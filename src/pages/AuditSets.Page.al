page 50100 "Audit Sets"
{
    PageType = List;
    SourceTable = "Audit Set";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Audit Sets';
    CardPageId = "Audit Set";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Audit Set Code"; Rec.Code)
                {
                    ApplicationArea = All;
                    Caption = 'Audit Set Code';
                    ToolTip = 'Audit Set Code';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                    ToolTip = 'Description';
                }
                field("Set Title"; Rec.Title)
                {
                    ApplicationArea = All;
                    Caption = 'Set Title';
                    ToolTip = 'Set Title';
                }
            }
        }
    }
}