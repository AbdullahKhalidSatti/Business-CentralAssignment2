table 50103 "Item Custom Tablez"
{
    Caption = 'Item List';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Unite Price"; Decimal)
        {
            Caption = 'Unite Price';
            DataClassification = ToBeClassified;
        }
        field(3; "Blocked"; Boolean)
        {
            Caption = 'Blocked';
        }
        field(4; "Substitutes Exist"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Item Substitution" where("Substitute No." = field("No.")));
            Caption = 'Substitutes Exist';
            Editable = false;
        }
        field(5; "Assembly BOM"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("BOM Component" WHERE("Parent Item No." = FIELD("No.")));
            Caption = 'Assembly BOM';
            Editable = false;
        }
        field(7; "Item Expired"; Boolean)
        {
            Caption= 'Item Expired';
        }
    }
    
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        
    }
    trigger OnInsert()
    begin
        Message('trigger called with insert(true)');
    end;
    
}
