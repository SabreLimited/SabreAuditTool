codeunit 50104 "Audit Test"
{
    Description = 'Audit';
    Subtype = Test;
    TestPermissions = Disabled;

    [Test]
    procedure T01_OpenPurchaseOrders90Days()
    var
        AuditSet: Record "Audit Set";
        Audit: Record Audit;
        PurchaseHeader: Record "Purchase Header";
        AuditResult: Record "Audit Result";
        AuditManagement: Codeunit "Audit Management";
    begin
        Initialize();

        // [GIVEN] Audit Set
        AuditSet := LibraryAudit.CreateAuditSet('', '', '');

        // [GIVEN] Audit - Open Purchase Orders older then 90 days
        Audit := LibraryAudit.CreateAudit(AuditSet.Code, 'Open Purchase Orders', Enum::"Audit Type Enum"::"Count Table", '', '%1 Purchase Orders are older than 90 days', 'Archive Orders', Database::"Purchase Header");

        // [GIVEN] Set Audit Filters
        LibraryAudit.SetFilter(Audit, PurchaseHeader.FieldNo("Buy-from Vendor No."), Vendor."No.");
        LibraryAudit.SetFilter(Audit, PurchaseHeader.FieldNo("Document Type"), '1');
        LibraryAudit.SetFilter(Audit, PurchaseHeader.FieldNo("Document Date"), '<T-90D');
        LibraryAudit.SetFilter(Audit, PurchaseHeader.FieldNo(Status), '0');

        // [WHEN] Run Audit Worksheet
        AuditManagement.RunAuditSet(AuditSet.Code);

        // [THEN] Line with correct message is inserted
        AuditResult.SetRange("Audit Set Code", AuditSet.Code);
        AuditResult.SetRange("Audit Entry No.", Audit."Entry No.");
        AuditResult.SetRange(Indendation, 1);
        AuditResult.FindFirst();
        Assert.AreEqual('1 Purchase Orders are older than 90 days', AuditResult.Result, 'Correct message is not displayed.');
    end;

    [Test]
    procedure T02_PurchaseOrders90DaysPastDelivery()
    var
        AuditSet: Record "Audit Set";
        Audit: Record Audit;
        PurchaseHeader: Record "Purchase Header";
        AuditResult: Record "Audit Result";
        AuditManagement: Codeunit "Audit Management";
    begin
        Initialize();

        // [GIVEN] Audit Set
        AuditSet := LibraryAudit.CreateAuditSet('', '', '');

        // [GIVEN] Audit - Purchase Orders 90 days past Expected Delivery Date
        Audit := LibraryAudit.CreateAudit(AuditSet.Code, 'Purchase Orders past Delivery', Enum::"Audit Type Enum"::"Count Table", '', '%1 Purchase Orders are more then 90 days late compared to their expected delivery date.', '', Database::"Purchase Header");

        // [GIVEN] Set Audit Filters
        LibraryAudit.SetFilter(Audit, PurchaseHeader.FieldNo("Buy-from Vendor No."), Vendor."No.");
        LibraryAudit.SetFilter(Audit, PurchaseHeader.FieldNo("Document Type"), '1');
        LibraryAudit.SetFilter(Audit, PurchaseHeader.FieldNo("Expected Receipt Date"), '<T-90D');

        // [WHEN] Run Audit Worksheet
        AuditManagement.RunAuditSet(AuditSet.Code);

        // [THEN] Line with correct message is inserted
        AuditResult.SetRange("Audit Set Code", AuditSet.Code);
        AuditResult.SetRange("Audit Entry No.", Audit."Entry No.");
        AuditResult.SetRange(Indendation, 1);
        AuditResult.FindFirst();
        Assert.AreEqual('1 Purchase Orders are more then 90 days late compared to their expected delivery', AuditResult.Result, 'Correct message is not displayed.');
    end;

    [Test]
    procedure T03_CustomerBlankPostingGroup()
    var
        AuditSet: Record "Audit Set";
        Audit: Record Audit;
        AuditResult: Record "Audit Result";
        AuditManagement: Codeunit "Audit Management";
    begin
        Initialize();

        // [GIVEN] Audit Set
        AuditSet := LibraryAudit.CreateAuditSet('', '', '');

        // [GIVEN] Audit - Customer Blank Posting Group
        Audit := LibraryAudit.CreateAudit(AuditSet.Code, 'Customer Blank Posting Group', Enum::"Audit Type Enum"::"Record Value", '', 'Customer %1 has blank posting group', '', Database::"Customer");
        Audit.Validate("Field ID", Customer.FieldNo("No."));
        Audit.Modify(true);

        // [GIVEN] Set Audit Filters
        LibraryAudit.SetFilter(Audit, Customer.FieldNo("No."), Customer."No.");
        LibraryAudit.SetFilter(Audit, Customer.FieldNo("Customer Posting Group"), '''''');

        // [WHEN] Run Audit Worksheet
        AuditManagement.RunAuditSet(AuditSet.Code);

        // [THEN] Line with correct message is inserted
        AuditResult.SetRange("Audit Set Code", AuditSet.Code);
        AuditResult.SetRange("Audit Entry No.", Audit."Entry No.");
        AuditResult.SetRange(Indendation, 1);
        AuditResult.FindFirst();
        Assert.AreEqual('Customer GL00000002 has blank posting group', AuditResult.Result, 'Correct message is not displayed.');
    end;

    [Test]
    procedure T04_ItemLedgerEntriesAdjPercent()
    var
        AuditSet: Record "Audit Set";
        Audit: Record Audit;
        ItemLedgerEntry: Record "Item Ledger Entry";
        AuditResult: Record "Audit Result";
        Item: Record Item;
        AuditManagement: Codeunit "Audit Management";
    begin
        Initialize();

        // [GIVEN] Item Ledger Entry
        LibraryInventory.CreateItem(Item);


        // [GIVEN] Audit Set
        AuditSet := LibraryAudit.CreateAuditSet('', '', '');

        // [GIVEN] Audit - Percent of Item Ledger Entries that are Adjustments
        Audit := LibraryAudit.CreateAudit(AuditSet.Code, 'Item Ledger Entries Adj. Percent', Enum::"Audit Type Enum"::"Percent Count", '', '%1% of Item Ledger Entries are adjustments', '', Database::"Item Ledger Entry");

        // [GIVEN] Set Audit Filters
        LibraryAudit.SetFilter(Audit, ItemLedgerEntry.FieldNo("Item No."), Item."No.");
        LibraryAudit.SetFilter(Audit, ItemLedgerEntry.FieldNo("Entry Type"), '=2|3');


        // [WHEN] Run Audit Worksheet
        AuditManagement.RunAuditSet(AuditSet.Code);

        // [THEN] Line with correct message is inserted
        AuditResult.SetRange("Audit Set Code", AuditSet.Code);
        AuditResult.SetRange("Audit Entry No.", Audit."Entry No.");
        AuditResult.SetRange(Indendation, 1);
        AuditResult.FindFirst();
        Assert.AreEqual('0% of Item Ledger Entries are adjustments', AuditResult.Result, 'Correct message is not displayed.');
    end;

    trigger OnRun();
    begin
        IsInitialized := false;
    end;

    local procedure Initialize();
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        LibraryTestInitialize.OnTestInitialize(Codeunit::"Audit Test");
        ClearLastError();
        LibraryVariableStorage.Clear();
        LibrarySetupStorage.Restore();
        if IsInitialized then
            exit;

        LibraryTestInitialize.OnBeforeTestSuiteInitialize(Codeunit::"Audit Test");

        LibraryRandom.Init();

        LibraryPurchase.CreateVendor(Vendor);
        LibraryPurchase.CreatePurchaseOrderForVendorNo(PurchaseHeader, Vendor."No.");

        LibrarySales.CreateCustomer(Customer);
        Customer.Validate("Customer Posting Group", '');
        Customer.Modify(true);

        IsInitialized := true;
        Commit();

        LibraryTestInitialize.OnAfterTestSuiteInitialize(Codeunit::"Audit Test");
    end;

    var
        Vendor: Record Vendor;
        Customer: Record Customer;
        Assert: Codeunit "Library Assert";
        LibraryAudit: Codeunit "Library - Audit";
        LibraryPurchase: Codeunit "Library - Purchase";
        LibrarySales: Codeunit "Library - Sales";
        LibraryInventory: Codeunit "Library - Inventory";
        LibraryRandom: Codeunit "Library - Random";
        LibrarySetupStorage: Codeunit "Library - Setup Storage";
        LibraryTestInitialize: Codeunit "Library - Test Initialize";
        LibraryVariableStorage: Codeunit "Library - Variable Storage";
        IsInitialized: Boolean;
}