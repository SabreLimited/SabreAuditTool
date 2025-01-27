permissionset 50100 AuditToolPermissions
{
    Assignable = true;
    Permissions = tabledata Audit=RIMD,
        tabledata "Audit Filter"=RIMD,
        tabledata "Audit Result"=RIMD,
        tabledata "Audit Set"=RIMD,
        table Audit=X,
        table "Audit Filter"=X,
        table "Audit Result"=X,
        table "Audit Set"=X,
        codeunit "Audit Management"=X,
        codeunit "Audit Test"=X,
        codeunit "Count Table Audit"=X,
        codeunit "Library - Audit"=X,
        codeunit "Percent Count Audit"=X,
        codeunit "Record Value Audit"=X,
        page Audit=X,
        page "Audit Filters"=X,
        page "Audit Set"=X,
        page "Audit Set Subpage"=X,
        page "Audit Sets"=X,
        page "Audit Worksheet"=X;
}