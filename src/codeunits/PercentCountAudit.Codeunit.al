codeunit 50102 "Percent Count Audit" implements AuditType
{
    procedure ShouldInsertAudit(Audit: Record Audit): Boolean
    begin
        RecordRef.Open(Audit."Audit Table ID");
        MaxCount := RecordRef.Count;
        AuditManagement.SetAuditTableFilters(Audit, RecordRef);

        Percent := Round(((RecordRef.Count / MaxCount) * 100), 0.01);

        if (Percent < Audit.Threshold) then
            exit(false);

        exit(true);
    end;

    procedure RunAudit(Audit: Record Audit; var AuditResult: Record "Audit Result")
    begin
        AuditManagement.InitAuditResult(Audit, AuditResult);

        AuditResult.Result := CopyStr(StrSubstNo(Audit."Result Message", Percent), 1, MaxStrLen(AuditResult.Result));

        AuditResult.Insert(true);
    end;

    var
        AuditManagement: Codeunit "Audit Management";
        RecordRef: RecordRef;
        MaxCount: Integer;
        Percent: Decimal;
}