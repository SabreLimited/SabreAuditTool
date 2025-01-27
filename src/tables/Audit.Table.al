table 50101 "Audit"
{
    DataClassification = CustomerContent;
    DrillDownPageId = Audit;
    LookupPageId = Audit;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
            Editable = false;
            Caption = 'Entry No.';
        }
        field(2; "Audit Set Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Audit Set".Code;
            Editable = false;
            Caption = 'Audit Set Code';
        }
        field(3; Description; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(4; "Audit Type"; Enum "Audit Type Enum")
        {
            DataClassification = CustomerContent;
            Caption = 'Audit Type';
        }
        field(5; Enabled; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Enabled';
        }
        field(6; MultiRow; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'MultiRow';
        }
        field(7; Title; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Title';
        }
        field(8; Warning; Text[255])
        {
            DataClassification = CustomerContent;
            Caption = 'Warning';
        }
        field(9; "Audit Table Name"; Text[80])
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup(allObjWithCaption."Object Name" where("Object ID" = field("Audit Table ID")));
            Caption = 'Audit Table Name';
        }
        field(10; "Audit Table ID"; Integer)
        {
            DataClassification = CustomerContent;
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Table));
            Caption = 'Audit Table ID';
        }
        field(11; "Field ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Field ID';
            // TableRelation = Field."No." where(TableNo = field("Audit Table ID"));
        }
        field(23; "Field Name"; Text[80])
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup(Field.FieldName where("No." = field("Field ID"), TableNo = field("Audit Table ID")));
            Caption = 'Field Name';
        }
        field(12; "Description Field"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Description Field';
        }
        field(13; "Comparison Table Name"; Text[80])
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup(allObjWithCaption."Object Name" where("Object ID" = field("Comparison Table ID")));
            Caption = 'Comparison Table Name';
        }
        field(14; "Comparison Table ID"; Integer)
        {
            DataClassification = CustomerContent;
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Table));
            Caption = 'Comparison Table ID';
        }
        field(15; "Comparison Field ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Comparison Field ID';
        }
        field(16; Filters; Boolean)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = exist("Audit Filter" where("Audit Set Code" = field("Audit Set Code"), "Audit Entry No." = field("Entry No."), "Table ID" = field("Audit Table ID")));
            Caption = 'Filters';
        }
        field(17; "User 1"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'User 1';
        }
        field(18; "User 2"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'User 2';
        }
        field(19; "User 3"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'User 3';
        }
        field(20; Threshold; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Threshold';
        }
        field(21; "Action By Id"; Guid)
        {
            TableRelation = User."User Security ID" where("License Type" = const("Full User"));
            DataClassification = EndUserPseudonymousIdentifiers;
            Caption = 'Action By Id';
        }
        field(22; "Action by Name"; Code[50])
        {
            CalcFormula = lookup(User."User Name" where("User Security ID" = field("Action By Id")));
            Caption = 'Action by Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(24; "Result Message"; Text[255])
        {
            DataClassification = CustomerContent;
            Caption = 'Result Message';
        }
    }

    keys
    {
        key(PK; "Audit Set Code", "Entry No.")
        {
            Clustered = true;
        }
    }
}