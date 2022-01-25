page 50100 "Item List Page"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Item Custom Tablez";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Unite Price"; Rec."Unite Price")
                {
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
                field("Substitutes Exist"; Rec."Substitutes Exist")
                {
                    ApplicationArea = All;
                }
                field("Assembly BOM"; Rec."Assembly BOM")
                {
                    ApplicationArea = All;
                }
                field("Item Expired"; Rec."Item Expired")
                {
                    ApplicationArea = All;
                }
            }

        }
    }

    actions
    {
        area(Processing)
        {
            action("Import Items")
            {
                Image = Import;
                ApplicationArea = All;
                Caption = 'Import all item data';
                trigger OnAction()
                begin
                    Items.ImportItems();
                end;
            }
            action("Sort With Substitutes Exist")
            {
                Image = SortAscending;
                ApplicationArea = All;
                Caption = 'Sort data with Substituties Exists';
                trigger OnAction()
                begin
                    //Items.SortWithSubstituteExist();
                    Rec.SetCurrentKey("Substitutes Exist");
                    Rec.SetAscending("Substitutes Exist", true);
                end;
            }
            action("Block Fifth Item")
            {
                Image = Error;
                ApplicationArea = All;
                Caption = 'Block every fifth Item';
                trigger OnAction()
                begin
                    Items.BlockFifthItem();
                end;
            }
            action("Assign Default Unit Price")
            {
                Image = Default;
                ApplicationArea = All;
                Caption = 'Assign default unit price to 10';
                trigger OnAction()
                begin
                    Items.AssignDefaultUnitPrice();
                end;
            }
            action("Count of Customer")
            {
                image = Calculate;
                ApplicationArea = All;
                Caption = 'Count of the customer who have discount setups';
                trigger OnAction()
                begin
                    Items.CountOfCustomer();
                end;
            }
            action("Items Expired")
            {
                Image = Warning;
                ApplicationArea = All;
                Caption = 'Items as expired which are bought before “01/23/22”';
                trigger OnAction()
                begin
                    Items.ShowItemsExpired();
                end;
            }
            action("Intsert(true)")
            {
                Image = Return;
                ApplicationArea = All;
                Caption = 'Insert(True) example';
                trigger OnAction()
                begin
                    Items.CallWithInsertTrue();
                end;
            }
        }
    }
    var
        Items: Codeunit Items;
}