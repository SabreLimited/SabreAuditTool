table 50102 "Audit Result"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Audit Set Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Audit Set Code';
        }
        field(2; "Audit Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Audit Entry No.';
        }
        field(3; "Audit Result Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
            Caption = 'Audit Result Entry No.';
        }
        field(4; "Audit Set Title"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Audit Set Title';
        }
        field(5; "Audit Title"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Audit Title';
        }
        field(6; "Result"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Result';
        }
        field(7; "Warning"; Text[255])
        {
            DataClassification = CustomerContent;
            Caption = 'Warning';
        }
        field(8; "Audit Date Time"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Audit Date Time';
        }
        field(9; Indendation; Integer)
        {
            DataClassification = SystemMetadata;
            Caption = 'Indendation';
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
            Caption = 'User Assigned To';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(PK; "Audit Set Code", "Audit Entry No.", "Audit Result Entry No.")
        {
            Clustered = true;
        }
    }
}