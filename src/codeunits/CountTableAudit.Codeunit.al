codeunit 50100 "Count Table Audit" implements AuditType
{
    procedure ShouldInsertAudit(Audit: Record Audit): Boolean
    begin
        RecordRef.Open(Audit."Audit Table ID");
        AuditManagement.SetAuditTableFilters(Audit, RecordRef);

        if (RecordRef.Count = 0) or (RecordRef.Count < Audit.Threshold) then
            exit(false);

        exit(true);
    end;

    procedure RunAudit(Audit: Record Audit; var AuditResult: Record "Audit Result")
    begin
        AuditManagement.InitAuditResult(Audit, AuditResult);
        AuditResult.Result := CopyStr(StrSubstNo(Audit."Result Message", RecordRef.Count), 1, MaxStrLen(AuditResult.Result));

        AuditResult.Insert(true);
    end;

    var
        AuditManagement: Codeunit "Audit Management";
        RecordRef: RecordRef;
}