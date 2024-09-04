report 60102 "Purchase Invoice-TAT Report"
{

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = ALL;
    DefaultLayout = RDLC;
    RDLCLayout = 'Purch Inv Report.rdl';

    // DefaultLayout = Excel;                             //PROPERTIES FOR EXCEL REPORT  
    // UsageCategory = ReportsAndAnalysis;
    // ApplicationArea = Basic, Suite;
    // // ExcelLayoutMultipleDataSheets = true;
    // ExcelLayout = 'Posted Purchase.xlsx';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {

            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";

            column(Type_Of_Invoice; '') { }
            column(Invoice_Number; "No.") { }
            column(Invoice_Raise_Date; "Posting Date") { }
            column(sales_Approved_Date; salesAppDate) { }
            column(Acc_Approved_Date; ACCAppDate) { }
            column(Final_Approved_Date; FinalAppDate) { }
            column(Sales_Approved_by; salesAppBy) { }
            column(Acc_Approved_by; ACCAppBy) { }
            column(Final_Approved_by; FinalAppBy) { }
            column(sennderid1; sennderid1)
            {

            }
            column(sennderid2; sennderid2)
            {

            }
            column(sennderid3; sennderid3)
            {

            }
            column(status1; status1)
            {

            }
            column(status2; status2)
            {

            }
            column(status3; status3)
            {

            }


            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                appEntry: record "Approval Entry";
                purchInv: Record "Purchase Header";

            begin
                Clear(appEntry);
                Clear(salesAppDate);
                Clear(salesAppBy);
                Clear(ACCAppDate);
                Clear(ACCAppBy);
                Clear(FinalAppDate);
                Clear(FinalAppBy);
                Clear(sennderid1);
                Clear(sennderid2);
                Clear(sennderid3);
                Clear(status1);
                Clear(status2);
                Clear(status3);

                appEntry.Reset();
                appEntry.SetRange("Document Type", appEntry."Document Type"::Invoice);
                appEntry.SetRange(appEntry."Document No.", "Purchase Header"."No.");
                // appEntry.SetRange(Status, appEntry.Status::Approved);
                // appEntry.SetRange(Status, appEntry.Status::Open);
                if appEntry.FindSet() then
                    repeat

                    begin
                        // if appEntry.SetRange(Status,'Open');
                        if appEntry."Sequence No." = 1
                        then begin

                            if appEntry.Status = appEntry.Status::Approved then begin
                                salesAppDate := appEntry."Last Date-Time Modified"
                            end;
                            salesAppBy := appEntry."Last Modified By User ID";
                            sennderid1 := appEntry."Approver ID";
                            if appEntry.Status = appEntry.Status::Approved then
                                status1 := 'Approved'
                            else
                                if appEntry.Status = appEntry.Status::Canceled then
                                    status1 := 'Canceled'
                                else
                                    if appEntry.Status = appEntry.Status::Created then
                                        status1 := 'Created'
                                    else
                                        if appEntry.Status = appEntry.Status::Open then
                                            status1 := 'Open'
                                        else
                                            if appEntry.Status = appEntry.Status::" " then
                                                status1 := '';

                        end;

                        if appEntry."Sequence No." = 2 then begin

                            if appEntry.Status = appEntry.Status::Approved then begin
                                ACCAppDate := appEntry."Last Date-Time Modified";
                            end;

                            // ACCAppDate := appEntry."Last Date-Time Modified";
                            ACCAppBy := appEntry."Approver ID";
                            sennderid2 := appEntry."Sender ID";
                            if appEntry.Status = appEntry.Status::Approved then
                                status2 := 'Approved'
                            else
                                if appEntry.Status = appEntry.Status::Canceled then
                                    status2 := 'Canceled'
                                else
                                    if appEntry.Status = appEntry.Status::Created then
                                        status2 := 'Created'
                                    else
                                        if appEntry.Status = appEntry.Status::Open then
                                            status2 := 'Open'
                                        else
                                            if appEntry.Status = appEntry.Status::" " then
                                                status2 := '';


                        end;

                        if appEntry."Sequence No." = 3 then begin

                            if appEntry.Status = appEntry.Status::Approved then begin
                                FinalAppDate := appEntry."Last Date-Time Modified";

                            end;


                            FinalAppBy := appEntry."Approver ID";
                            sennderid3 := appEntry."Sender ID";
                            if appEntry.Status = appEntry.Status::Approved then
                                status3 := 'Approved'
                            else
                                if appEntry.Status = appEntry.Status::Canceled then
                                    status3 := 'Canceled'
                                else
                                    if appEntry.Status = appEntry.Status::Created then
                                        status3 := 'Created'
                                    else
                                        if appEntry.Status = appEntry.Status::Open then
                                            status3 := 'Open'
                                        else
                                            if appEntry.Status = appEntry.Status::" " then
                                                status3 := '';
                        end;




                    end;
                    until appEntry.Next() = 0;

            end;

        }

    }
    var
        salesAppDate: DateTime;
        salesAppBy: code[50];
        sennderid1: Code[20];
        status1: Text[20];
        status2: Text[20];
        status3: Text[20];
        sennderid2: Code[20];
        sennderid3: Code[20];



        ACCAppDate: DateTime;
        ACCAppBy: code[50];

        FinalAppDate: DateTime;
        FinalAppBy: code[50];




}
