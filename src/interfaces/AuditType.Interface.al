interface AuditType
{
    procedure RunAudit(Audit: Record Audit; var AuditResult: Record "Audit Result");

    procedure ShouldInsertAudit(Audit: Record Audit): Boolean;
}