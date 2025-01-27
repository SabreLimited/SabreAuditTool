table 50103 "Audit Filter"
{
    DrillDownPageId = "Audit Filters";

    fields
    {
        field(1; "Audit Set Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Audit Set Code';
        }
        field(2; "Audit Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Audit Entry No.';
        }
        field(4; "Table ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Table ID';
            // TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Table));
        }
        field(5; "Field ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Field ID';
            // TableRelation = Field."No." where(TableNo = field("Table ID"));
        }
        field(6; "Filter Value"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Filter Value';

            trigger OnValidate()
            begin
                TestFilterValue();
            end;
        }
        field(7; "Field Name"; Text[80])
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup(Field.FieldName where("No." = field("Field ID"), TableNo = field("Table ID")));
            Caption = 'Field Name';
        }
        field(8; "Field Type"; Text[30])
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup(Field."Type Name" where("No." = field("Field ID"), TableNo = field("Table ID")));
            Caption = 'Field Type';
        }
        field(9; "Comparison Field ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Comparison Field ID';
            // TableRelation = Field."No." where(TableNo = field("Table ID"));
        }
        field(10; "Comparison Field Name"; Text[80])
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup(Field.FieldName where("No." = field("Comparison Field ID"), TableNo = field("Table ID")));
            Caption = 'Comparison Field Name';
        }
    }

    keys
    {
        key(PK; "Audit Set Code", "Audit Entry No.", "Table ID", "Field ID")
        {
            Clustered = true;
        }
    }

    internal procedure TestFilterValue()
    var
        RecordRef: RecordRef;
    begin
        RecordRef.Open(Rec."Table ID");
        SetFilterOnRecordRef(RecordRef);
    end;

    internal procedure SetFilterOnRecordRef(var RecordRef: RecordRef)
    var
        FieldRef: FieldRef;
        ComparisonFieldRef: FieldRef;
    begin
        FieldRef := RecordRef.Field(Rec."Field ID");
        if Rec."Comparison Field ID" <> 0 then begin
            ComparisonFieldRef := RecordRef.Field(Rec."Comparison Field ID");
            FieldRef.SetFilter(StrSubstNo(Rec."Filter Value", ComparisonFieldRef.Value));
        end else
            FieldRef.SetFilter(Rec."Filter Value");
    end;
}