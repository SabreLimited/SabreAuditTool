page 50103 Audit
{
    PageType = Card;
    SourceTable = Audit;
    ApplicationArea = All;
    UsageCategory = None;
    Caption = 'Audit';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Title; Rec.Title)
                {
                    ToolTip = 'Title';
                }
                field("Audit Type"; Rec."Audit Type")
                {
                    ToolTip = 'Audit Type';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                }
                field("Result Message"; Rec."Result Message")
                {
                    ToolTip = 'Result Message (Use %1 as place holder for the result value)';
                }
                field(Enabled; Rec.Enabled)
                {
                    ToolTip = 'Enabled';
                }
                field(Warning; Rec.Warning)
                {
                    ToolTip = 'Specifies the value of the Warning field.';
                }
            }
            group(Parameters)
            {
                Caption = 'Parameters';

                field("Audit Table No."; Rec."Audit Table ID")
                {
                    ToolTip = 'Specifies the value of the Audit Table No. field.';
                }
                field("Audit Table Name"; Rec."Audit Table Name")
                {
                    ToolTip = 'Specifies the value of the Audit Table field.';
                }
                field("Filters"; Rec.Filters)
                {
                    ToolTip = 'Specifies the value of the Filter 1 field.';
                    DrillDown = true;
                }
                field("Field ID"; Rec."Field ID")
                {
                    ToolTip = 'Specifies the value of the Field ID field.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Field: Record Field;
                    begin
                        Field.SetRange(TableNo, Rec."Audit Table ID");
                        if Page.RunModal(Page::"Fields Lookup", Field) = Action::LookupOK then
                            Rec.Validate("Field ID", Field."No.");
                        CurrPage.Update(true);
                    end;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field("Field Name"; Rec."Field Name")
                {
                    ToolTip = 'Specifies the value of the Field Name field.';
                }
                field("Comparison Table ID"; Rec."Comparison Table ID")
                {
                    ToolTip = 'Specifies the value of the Comparison Table No. field.';
                }
                field("Comparison Table Name"; Rec."Comparison Table Name")
                {
                    ToolTip = 'Specifies the value of the Comparison Table field.';
                }
                field("Comparison Field ID"; Rec."Comparison Field ID")
                {
                    ToolTip = 'Specifies the value of the Comparison Field field.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Field: Record Field;
                    begin
                        Field.SetRange(TableNo, Rec."Comparison Table ID");
                        if Page.RunModal(Page::"Fields Lookup", Field) = Action::LookupOK then
                            Rec.Validate("Comparison Field ID", Field."No.");
                        CurrPage.Update(true);
                    end;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field(MultiRow; Rec.MultiRow)
                {
                    ToolTip = 'Specifies the value of the MultiRow field.';
                }
                field(Threshold; Rec.Threshold)
                {
                    ToolTip = 'Specifies the value of the Threshold field.';
                }

                field("Action By Name"; Rec."Action By Name")
                {
                    ToolTip = 'Specifies the value of the Action By Name field.';
                    DrillDown = false;

                    trigger OnAssistEdit()
                    var
                        User: Record User;
                        Users: Page Users;
                    begin
                        if User.Get(Rec."Action By Id") then
                            Users.SetRecord(User);

                        Users.LookupMode := true;
                        if Users.RunModal() = ACTION::LookupOK then begin
                            Users.GetRecord(User);
                            Rec.Validate("Action By Id", User."User Security ID");
                            CurrPage.Update(true);
                        end;
                    end;
                }
                field("Description Field"; Rec."Description Field")
                {
                    ToolTip = 'Specifies the value of the Description Field field.';
                }
                field("User 1"; Rec."User 1")
                {
                    ToolTip = 'Specifies the value of the User 1 field.';
                }
                field("User 2"; Rec."User 2")
                {
                    ToolTip = 'Specifies the value of the User 2 field.';
                }
                field("User 3"; Rec."User 3")
                {
                    ToolTip = 'Specifies the value of the User 3 field.';
                }
            }
        }
    }
}