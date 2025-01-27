codeunit 50101 "Record Value Audit" implements AuditType
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

        if RecordRef.FindSet() then
            repeat
                AuditManagement.InitAuditResult(Audit, AuditResult);
                FieldRef := RecordRef.Field(Audit."Field ID");
                AuditResult.Result := CopyStr(StrSubstNo(Audit."Result Message", FieldRef.Value()), 1, MaxStrLen(AuditResult.Result));
                AuditResult.Insert(true);
            until RecordRef.Next() = 0;
    end;

    var
        AuditManagement: Codeunit "Audit Management";
        RecordRef: RecordRef;
        FieldRef: FieldRef;
}