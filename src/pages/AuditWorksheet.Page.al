page 50104 "Audit Worksheet"
{
    Caption = 'Audit Worksheet';
    PageType = Worksheet;
    SourceTable = "Audit Result";
    ApplicationArea = All;
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Audit Set Code"; AuditSetCode)
                {
                    ApplicationArea = All;
                    Caption = 'Audit Set Code';
                    ToolTip = 'Specifies the current Audit Set.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        AuditSet: Record "Audit Set";
                    begin
                        if Page.RunModal(Page::"Audit Sets", AuditSet) = Action::LookupOK then begin
                            Text := AuditSet.Code;
                            ValidateAuditSetCode();
                            exit(true);
                        end;
                        exit(false);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateAuditSetCode();
                    end;
                }
                field("Audit Set Title"; AuditSetTitle)
                {
                    ApplicationArea = All;
                    Caption = 'Audit Set Title';
                    ToolTip = 'Specifies the title of the current Audit Set.';
                    Editable = false;
                }
            }

            repeater(Group)
            {
                ShowAsTree = true;
                IndentationColumn = Rec.Indendation;

                field("Audit Title"; Rec."Audit Title")
                {
                    ToolTip = 'Specifies the value of the Audit Title field.';
                    Editable = false;
                    DrillDown = false;
                }
                field(Result; Rec.Result)
                {
                    ToolTip = 'Specifies the value of the Result field.';
                    Editable = false;
                }
                field(Warning; Rec.Warning)
                {
                    ToolTip = 'Specifies the value of the Warning field.';
                    Editable = false;
                    DrillDown = false;
                }
                field("Audit Date Time"; Rec."Audit Date Time")
                {
                    ToolTip = 'Specifies the value of the Audit Date Time field.';
                    Editable = false;
                }
                field("Action by Name"; Rec."Action by Name")
                {
                    ToolTip = 'Specifies the value of the Action by Name field.';
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Run Audit Set")
            {
                ApplicationArea = All;
                ToolTip = 'Run Audit Set';
                Image = Action;

                trigger OnAction()
                var
                    AuditManagement: Codeunit "Audit Management";
                begin
                    AuditManagement.RunAuditSet(AuditSetCode);
                end;
            }
            action("Create User Task")
            {
                ApplicationArea = All;
                ToolTip = 'Create User Task';
                Image = CopyFromTask;

                trigger OnAction()
                var
                    UserTask: Record "User Task";
                begin
                    Rec.TestField("Action By Id");

                    UserTask.Init();
                    UserTask.Validate(Title, Rec.Warning);
                    UserTask.SetDescription(Rec.Result);
                    UserTask.Validate("Assigned To", Rec."Action By Id");
                    UserTask.Insert(true);

                    Message('User Task created.');
                end;
            }
        }
        area(Navigation)
        {
            action("Audit Sets")
            {
                ApplicationArea = All;
                ToolTip = 'Audit Sets';
                Image = Documents;
                RunObject = Page "Audit Sets";
                RunPageMode = View;
            }
        }
        area(Promoted)
        {
            actionref("Run Audit Set Promoted"; "Run Audit Set") { }
        }
    }

    trigger OnOpenPage()
    begin
        SetAuditSet();
    end;

    var
        AuditSetTitle: Text[80];
        AuditSetCode: Code[20];

    local procedure ValidateAuditSetCode()
    var
        AuditSet: Record "Audit Set";
    begin
        AuditSet.Get(AuditSetCode);
        AuditSetTitle := AuditSet.Title;
        Rec.SetRange("Audit Set Code", AuditSetCode);
        CurrPage.Update(false);
    end;

    local procedure SetAuditSet()
    var
        AuditSet: Record "Audit Set";
    begin
        if AuditSetCode <> '' then
            exit;
        if Page.RunModal(Page::"Audit Sets", AuditSet) = Action::LookupOK then begin
            AuditSetCode := AuditSet.Code;
            ValidateAuditSetCode();
        end;
    end;

    internal procedure RunOnAuditSet(AuditSet: Record "Audit Set")
    begin
        AuditSetCode := AuditSet.Code;
        ValidateAuditSetCode();
        this.Run();
    end;
}