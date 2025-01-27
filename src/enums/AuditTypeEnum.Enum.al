enum 50100 "Audit Type Enum" implements AuditType
{
    Extensible = true;

    value(0; "Count Table")
    {
        Caption = 'Count Table';
        Implementation = AuditType = "Count Table Audit";
    }
    value(1; "Record Value")
    {
        Caption = 'Record Value';
        Implementation = AuditType = "Record Value Audit";
    }
    value(2; "Percent Count")
    {
        Caption = 'Percent Count';
        Implementation = AuditType = "Percent Count Audit";
    }
}
