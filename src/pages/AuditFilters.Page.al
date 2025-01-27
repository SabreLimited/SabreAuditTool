page 50105 "Audit Filters"
{
    PageType = Worksheet;
    SourceTable = "Audit Filter";
    ApplicationArea = All;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Field ID"; Rec."Field ID")
                {
                    ToolTip = 'Specifies the value of the Field ID field.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Field: Record Field;
                    begin
                        Field.SetRange(TableNo, Rec."Table ID");
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
                field("Comparison Field ID"; Rec."Comparison Field ID")
                {
                    ToolTip = 'Specifies the value of the Comparison Field ID field.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Field: Record Field;
                    begin
                        Field.SetRange(TableNo, Rec."Table ID");
                        if Page.RunModal(Page::"Fields Lookup", Field) = Action::LookupOK then
                            Rec.Validate("Comparison Field ID", Field."No.");
                        CurrPage.Update(true);
                    end;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field("Comparison Field Name"; Rec."Comparison Field Name")
                {
                    ToolTip = 'Specifies the value of the Comparison Field Name field.';
                }
                field("Field Type"; Rec."Field Type")
                {
                    ToolTip = 'Specifies the value of the Field Type field.';
                }
                field("Filter Value"; Rec."Filter Value")
                {
                    ToolTip = 'Specifies the value of the Filter Value field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Show Option Values")
            {
                Caption = 'Show Option Values';
                ToolTip = 'Show Option Values';
                Image = ShowChart;

                trigger OnAction()
                var
                    RecordRef: RecordRef;
                    FieldRef: FieldRef;
                begin
                    RecordRef.Open(Rec."Table ID");
                    FieldRef := RecordRef.Field(Rec."Field ID");
                    Message(FieldRef.OptionMembers());
                end;
            }
        }
        area(Promoted)
        {
            actionref("Show Option Values Promoted"; "Show Option Values") { }
        }
    }
}