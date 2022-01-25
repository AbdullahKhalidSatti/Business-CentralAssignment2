codeunit 50100 Items
{
    procedure ImportItems()
    var
        ItemCustomTablez: Record "Item Custom Tablez";
        Item: Record Item;
    begin
        If Item.FindSet() then
            repeat
                ItemCustomTablez.Init();
                ItemCustomTablez."No." := Item."No.";
                ItemCustomTablez."Unite Price" := Item."Unit Price";
                ItemCustomTablez.Blocked := Item.Blocked;
                ItemCustomTablez.CalcFields("Assembly BOM", "Substitutes Exist");
                ItemCustomTablez."Substitutes Exist" := Item."Substitutes Exist";
                ItemCustomTablez."Assembly BOM" := Item."Assembly BOM";
                ItemCustomTablez.Insert();
            until Item.Next() = 0;
    end;

    procedure SortWithSubstituteExist()
    var

        ItemCustomTablez: Record "Item Custom Tablez";
    begin

        // Don't need this codeunite to Sort data, we can do this action on page also
        // ItemCustomTablez.SetRange("Unite Price");
        // ItemCustomTablez.SetCurrentKey("Unite Price");
        // ItemCustomTablez.SetAscending("Unite Price", true);
        // ItemCustomTablez.Ascending := true;
    end;

    procedure BlockFifthItem()
    var
        ItemCustomTablez: Record "Item Custom Tablez";
        Counter: Integer;
    begin
        Counter := 1;
        ItemCustomTablez.SetRange(Blocked);
        if ItemCustomTablez.FindSet() then
            repeat
                if Counter MOD 5 = 0 then
                    ItemCustomTablez.Blocked := True;
                Counter += 1;
                ItemCustomTablez.Modify();
            until ItemCustomTablez.Next() = 0;
    end;

    procedure AssignDefaultUnitPrice()
    var
        ItemCustomTablez: Record "Item Custom Tablez";
    begin
        ItemCustomTablez.SetFilter("Unite Price", '0.00');
        ItemCustomTablez.ModifyAll("Unite Price", 10);
    end;

    procedure CountOfCustomer()
    var
        Customer: Record Customer;
        Counter: Integer;
    begin
        Counter := 1;
        if Customer.FindSet() then
            repeat
                if Customer."Customer Disc. Group" <> '' then
                    Counter += 1;
            until Customer.Next() = 0;
        Message('Total customers using discount are %1', Counter);

    end;

    procedure ShowItemsExpired()
    var
        ItemCustomTablez: Record "Item Custom Tablez";
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        /* ItemLedgerEntry.SetFilter("Entry Type", '=Purchase');
        ItemLedgerEntry.SetFilter("Posting Date", '< 01/23/22');
        if ItemLedgerEntry.FindSet() then
            repeat
                if ItemCustomTablez.FindSet() then
                    repeat
                        if ItemLedgerEntry."Item No." = ItemCustomTablez."No." then
                            ItemCustomTablez."Item Expired" := true;
                        ItemCustomTablez.Modify();
                    until ItemCustomTablez.Next() = 0;
            until ItemLedgerEntry.Next() = 0; */
        //ItemLedgerEntry.SetFilter("Entry Type", '=Purchase');
        ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
        ItemLedgerEntry.SetFilter("Posting Date", '< 01/23/22');
        if ItemLedgerEntry.FindSet() then begin
            repeat
                if ItemCustomTablez.Get(ItemLedgerEntry."Item No.") then begin
                    ItemCustomTablez."Item Expired" := true;
                    ItemCustomTablez.Modify();
                end;
            until ItemLedgerEntry.Next() = 0;
        end;
    end;

    procedure CallWithInsertTrue()
    var
        ItemCustomTablez: Record "Item Custom Tablez";
    begin
        ItemCustomTablez.Insert(true);
    end;
}