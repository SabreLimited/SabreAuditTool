page 50102 "Audit Set Subpage"
{
    PageType = ListPart;
    SourceTable = Audit;
    ApplicationArea = All;
    CardPageId = "Audit";
    InsertAllowed = false;
    ModifyAllowed = true;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    Caption = 'Title';
                    ToolTip = 'Title';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                    ToolTip = 'Description';
                    Editable = false;
                }
                field("Audit Type"; Rec."Audit Type")
                {
                    ApplicationArea = All;
                    Caption = 'Audit Type';
                    ToolTip = 'Audit Type';
                    Editable = false;
                }
                field(Enabled; Rec.Enabled)
                {
                    ApplicationArea = All;
                    Caption = 'Enabled';
                    ToolTip = 'Enabled';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Enable")
            {
                ApplicationArea = All;
                ToolTip = 'Enable';
                Image = Action;

                trigger OnAction()
                var
                    Audit: Record Audit;
                    AuditManagement: Codeunit "Audit Management";
                begin
                    CurrPage.SetSelectionFilter(Audit);
                    if Audit.FindSet() then
                        repeat
                            AuditManagement.SetEnableAudit(Rec, true);
                        until Audit.Next() = 0;
                end;
            }
            action("Disable")
            {
                ApplicationArea = All;
                ToolTip = 'Disable';
                Image = Action;

                trigger OnAction()
                var
                    Audit: Record Audit;
                    AuditManagement: Codeunit "Audit Management";
                begin
                    CurrPage.SetSelectionFilter(Audit);
                    if Audit.FindSet() then
                        repeat
                            AuditManagement.SetEnableAudit(Rec, false);
                        until Audit.Next() = 0;
                end;
            }
        }
    }
}