codeunit 50103 "Audit Management"
{
    SingleInstance = true;

    procedure OpenWorksheetOnAuditSet(AuditSet: Record "Audit Set")
    var
        AuditWorksheet: Page "Audit Worksheet";
    begin
        AuditWorksheet.RunOnAuditSet(AuditSet);
    end;

    procedure RunAuditSet(AuditSetCode: Code[20])
    var
        AuditSet: Record "Audit Set";
        AuditResult: Record "Audit Result";
        Audit: Record Audit;
        AuditType: Interface AuditType;
    begin
        AuditSet.Get(AuditSetCode);
        ClearAuditSetResults(AuditSet);
        Audit.SetRange("Audit Set Code", AuditSet.Code);
        Audit.SetRange(Enabled, true);
        if Audit.FindSet() then
            repeat
                AuditType := Audit."Audit Type";
                if AuditType.ShouldInsertAudit(Audit) then begin
                    InsertAuditResultHeader(Audit, AuditResult);
                    AuditType.RunAudit(Audit, AuditResult);
                end;
            until Audit.Next() = 0;
    end;

    internal procedure InitAuditResult(var Audit: Record Audit; var AuditResult: Record "Audit Result")
    begin
        AuditResult.Init();
        AuditResult."Audit Set Code" := Audit."Audit Set Code";
        AuditResult."Audit Entry No." := Audit."Entry No.";
        AuditResult."Audit Result Entry No." := 0;
        AuditResult.Indendation := 1;
        AuditResult."Audit Title" := Audit.Title;
        AuditResult."Audit Date Time" := CurrentDateTime;
        AuditResult.Warning := Audit.Warning;
        AuditResult."Action By Id" := Audit."Action by Id";
    end;

    local procedure InsertAuditResultHeader(Audit: Record Audit; var AuditResult: Record "Audit Result")
    begin
        InitAuditResult(Audit, AuditResult);
        AuditResult.Indendation := 0;
        AuditResult.Insert(true);
    end;

    internal procedure SetAuditTableFilters(Audit: Record Audit; var RecordRef: RecordRef)
    var
        AuditFilter: Record "Audit Filter";
    begin
        AuditFilter.Reset();
        AuditFilter.SetRange("Audit Set Code", Audit."Audit Set Code");
        AuditFilter.SetRange("Audit Entry No.", Audit."Entry No.");
        AuditFilter.SetRange("Table ID", Audit."Audit Table ID");
        if AuditFilter.FindSet() then
            repeat
                AuditFilter.SetFilterOnRecordRef(RecordRef);
            until AuditFilter.Next() = 0;
    end;

    internal procedure SetEnableAudit(var Audit: Record Audit; Enable: Boolean)
    begin
        Audit.Enabled := Enable;
        Audit.Modify();
    end;

    local procedure ClearAuditSetResults(AuditSet: Record "Audit Set")
    var
        AuditResult: Record "Audit Result";
    begin
        AuditResult.SetRange("Audit Set Code", AuditSet.Code);
        if AuditResult.Count > 0 then
            if GuiAllowed then
                if not Confirm('Running the audit set will delete all existing results. Do you want to continue?') then
                    Error('');
        AuditResult.DeleteAll();
    end;
}