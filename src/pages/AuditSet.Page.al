page 50101 "Audit Set"
{
    PageType = Document;
    SourceTable = "Audit Set";
    ApplicationArea = All;
    UsageCategory = None;
    Caption = 'Audit Set';

    layout
    {
        area(content)
        {
            group(General)
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
            group(Audits)
            {
                Caption = 'Audits';

                part(AuditSetSubpage; "Audit Set Subpage")
                {
                    ApplicationArea = All;
                    SubPageLink = "Audit Set Code" = field(Code);
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Open Worksheet")
            {
                ApplicationArea = All;
                ToolTip = 'Open Worksheet';
                Image = Worksheet;

                trigger OnAction()
                var
                    AuditManagement: Codeunit "Audit Management";
                begin
                    AuditManagement.OpenWorksheetOnAuditSet(Rec);
                end;
            }
        }
        area(Promoted)
        {
            actionref("Open Worksheet Promoted"; "Open Worksheet") { }
        }
    }
}