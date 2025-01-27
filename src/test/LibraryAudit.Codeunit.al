codeunit 50105 "Library - Audit"
{
    Permissions = tabledata "Audit Set" = rmid,
                tabledata Audit = rmid,
                tabledata "Audit Filter" = rmid;

    procedure CreateAuditSet(AuditSetCode: Code[20]; Title: Text[80]; Description: Text[80]) AuditSet: Record "Audit Set"
    begin
        AuditSet.Init();
        if AuditSetCode = '' then
            AuditSet.Validate(Code, LibraryRandom.RandText(20))
        else
            AuditSet.Validate(Code, AuditSetCode);
        AuditSet.Validate(Title, Title);
        AuditSet.Validate(Description, Description);
        AuditSet.Insert(true);
    end;

    procedure CreateAudit(AuditSetCode: Code[20];
                            Title: Text[80];
                            AuditType: Enum "Audit Type Enum";
                            Description: Text[80];
                            ResultMessage: Text[255];
                            Warning: Text[255];
                            AuditTableId: Integer) Audit: Record Audit;
    begin
        Audit.Init();
        Audit.Validate("Audit Set Code", AuditSetCode);
        Audit.Validate(Title, Title);
        Audit.Validate("Audit Type", AuditType);
        Audit.Validate(Description, Description);
        Audit.Validate("Result Message", ResultMessage);
        Audit.Validate(Warning, Warning);
        Audit.Validate("Audit Table ID", AuditTableId);
        Audit.Validate(Enabled, true);
        Audit.Insert(true);
    end;

    procedure SetFilter(Audit: Record Audit;
                        FieldId: Integer;
                        FilterValue: Text[80]) AuditFilter: Record "Audit Filter"
    begin
        AuditFilter.Init();
        AuditFilter.Validate("Audit Set Code", Audit."Audit Set Code");
        AuditFilter.Validate("Audit Entry No.", Audit."Entry No.");
        AuditFilter.Validate("Table ID", Audit."Audit Table ID");
        AuditFilter.Validate("Field ID", FieldId);
        AuditFilter.Validate("Filter Value", FilterValue);
        if not AuditFilter.Insert(true) then
            AuditFilter.Modify(true);
    end;

    var
        LibraryRandom: Codeunit "Library - Random";
}