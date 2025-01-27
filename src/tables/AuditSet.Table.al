table 50100 "Audit Set"
{
    DataClassification = CustomerContent;
    DrillDownPageId = "Audit Sets";
    LookupPageId = "Audit Sets";

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
        }
        field(2; Description; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(3; Title; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Title';
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
}