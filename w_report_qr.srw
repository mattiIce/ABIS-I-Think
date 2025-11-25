$PBExportHeader$w_report_qr.srw
forward
global type w_report_qr from w_sheet
end type
type st_2 from statictext within w_report_qr
end type
type dw_enduser_part_num from datawindow within w_report_qr
end type
type cbx_no_flaws from checkbox within w_report_qr
end type
type st_1 from statictext within w_report_qr
end type
type dw_handling_codes from datawindow within w_report_qr
end type
type dw_flaw_reason from datawindow within w_report_qr
end type
type dw_material_num from datawindow within w_report_qr
end type
type dw_payoff_direction from datawindow within w_report_qr
end type
type st_9 from statictext within w_report_qr
end type
type st_8 from statictext within w_report_qr
end type
type st_5 from statictext within w_report_qr
end type
type cb_getsize from commandbutton within w_report_qr
end type
type st_6 from statictext within w_report_qr
end type
type dw_customer_lookup from datawindow within w_report_qr
end type
type cb_export from u_cb within w_report_qr
end type
type dw_rebanded_list from datawindow within w_report_qr
end type
type dw_rejcoil_list from datawindow within w_report_qr
end type
type st_rowcount from statictext within w_report_qr
end type
type cb_1 from commandbutton within w_report_qr
end type
type st_all_dates from statictext within w_report_qr
end type
type cb_retrieve from commandbutton within w_report_qr
end type
type em_from from editmask within w_report_qr
end type
type em_to from editmask within w_report_qr
end type
type st_from from statictext within w_report_qr
end type
type st_to from statictext within w_report_qr
end type
type dw_report from u_dw within w_report_qr
end type
type cb_close from u_cb within w_report_qr
end type
type cb_print from u_cb within w_report_qr
end type
end forward

global type w_report_qr from w_sheet
integer width = 5080
integer height = 2861
string title = "QR Report"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
st_2 st_2
dw_enduser_part_num dw_enduser_part_num
cbx_no_flaws cbx_no_flaws
st_1 st_1
dw_handling_codes dw_handling_codes
dw_flaw_reason dw_flaw_reason
dw_material_num dw_material_num
dw_payoff_direction dw_payoff_direction
st_9 st_9
st_8 st_8
st_5 st_5
cb_getsize cb_getsize
st_6 st_6
dw_customer_lookup dw_customer_lookup
cb_export cb_export
dw_rebanded_list dw_rebanded_list
dw_rejcoil_list dw_rejcoil_list
st_rowcount st_rowcount
cb_1 cb_1
st_all_dates st_all_dates
cb_retrieve cb_retrieve
em_from em_from
em_to em_to
st_from st_from
st_to st_to
dw_report dw_report
cb_close cb_close
cb_print cb_print
end type
global w_report_qr w_report_qr

type variables
String	is_add_2sql_prev_month

String	is_sql_orig
String	is_date_from_to

String	is_run_date_t, is_date_range_head_t, is_process_date_head_t, is_customer_head_t, is_handling_codes_head_t
String	is_coil_num_head_t, is_material_num_head_t, is_payoff_direction_head_t, is_flaw_reason_head_t
String	is_enduser_part_num_head_t
String	is_handling_code_arg_save, is_flaw_reason_arg_save
end variables

forward prototypes
public subroutine exporttoexcel (datawindow adw_dw, long al_rows)
public subroutine wf_add_2sql (long al_die_id, datetime adt_date_from, datetime adt_date_to)
public function long wf_rejected_coil_wt (long al_job, long al_coil_num)
public subroutine wf_set_display_values (long al_job, long al_row)
public function integer wf_calc_prev_month ()
end prototypes

event type string ue_whoami();Return "w_report_qr"
end event

public subroutine exporttoexcel (datawindow adw_dw, long al_rows);//Alex Gerlants. 05/02/2016. Begin
/*
Function:	exporttoexcel
Returns:		none
Arguments:	value		datawindow	adw_dw
				value		long			al_rows	

*/

// Export the data to Excel
OleObject 	lole_OLE, lole_Sheet
String 		ls_Columns[]
Long 			ll_report_rows, ll_Row, ll_Col, ll_Cols
String		ls_range 
String		ls_sum_processed, ls_sum_scrap_net
String		ls_sum_net_wt, ls_sum_tare_wt, ls_sum_theo_wt
Boolean		lb_rtn, lb_directoryexists

String 		ls_file, ls_today, ls_now, ls_folder, ls_run_date
Date 			ld_today
Time 			ld_now
Integer		li_answer

//Return //Disable this function for now ...

uo_save_as_excel	luo_save_as_excel

luo_save_as_excel = Create uo_save_as_excel

ll_report_rows = adw_dw.RowCount()

If ll_report_rows <= 0 Then Return

ls_run_date = is_run_date_t

lole_OLE = CREATE OleObject

SetPointer( HourGlass! )

lole_OLE.ConnectToNewObject( 'excel.application' )
lole_OLE.Workbooks.Add
lole_sheet = lole_OLE.Application.ActiveWorkbook.WorkSheets[1]

luo_save_as_excel.GetColumns( adw_DW, ls_Columns )

ll_Cols = UpperBound( ls_Columns )

FOR ll_col = 1 TO ll_cols
	lole_Sheet.Cells[ 1, ll_Col ] = ls_Columns[ ll_Col ]
NEXT

FOR ll_Row = 2 TO al_rows + 1
	FOR ll_Col = 1 TO ll_cols
		lole_Sheet.Cells[ ll_Row, ll_Col ] = &
		luo_save_as_excel.GetData( adw_DW, ll_Row - 1, ls_Columns[ ll_Col ] )
	NEXT
NEXT

lole_Sheet.Range( luo_save_as_excel.inttocolumn( 1 ) + "1:" + luo_save_as_excel.inttocolumn( ll_Cols ) + "1").Select
lole_OLE.Selection.Font.Bold = True

lole_Sheet.Range("A1:A1").Select
lole_Sheet.Columns( luo_save_as_excel.inttocolumn( 1 ) + ":" + luo_save_as_excel.inttocolumn( ll_cols ) ).EntireColumn.AutoFit


//Column Headings
lole_OLE.cells[1,1] = "Coil ABC Number"
lole_OLE.cells[1,2] = "Coil Customer Number"
lole_OLE.cells[1,3] = "Date/Time Received"
lole_OLE.cells[1,4] = "End User Part Number"
lole_OLE.cells[1,5] = "Material Number"
lole_OLE.cells[1,6] = "Net Weight"
lole_OLE.cells[1,7] = "Payoff Direction"
lole_OLE.cells[1,8] = "Flaw Reason"
lole_OLE.cells[1,9] = "Starting Position"
lole_OLE.cells[1,10] = "Ending Position"
lole_OLE.cells[1,11] = "Flaw Length"
lole_OLE.cells[1,12] = "Flaw Handling"
lole_OLE.cells[1,13] = "Coil Gauge"
lole_OLE.cells[1,14] = "Coil Width"

//Insert Lines for Header & Miscellaneous Details (5 lines above columnar data)
lole_Sheet.Range("A1:N8").Select
lole_Sheet.Application.Selection.EntireRow.Insert 

//lole_OLE.cells[1,1] = "QR Report"
//lole_Sheet.Range("A1:A1").Select
//lole_OLE.Selection.Font.Bold = True
//lole_OLE.Selection.Font.Size = 24 //Change font size
//lole_OLE.Selection.Font.Underline = True

lole_OLE.cells[1,5] = ls_run_date
lole_Sheet.Range("E1:E1").Select
lole_OLE.Selection.Font.Bold = True




//----------------------------------------------------------------------------------------------------

lole_OLE.cells[2,1] = is_customer_head_t
lole_Sheet.Range("A2:A2").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[3,1] = is_date_range_head_t
lole_Sheet.Range("A3:A3").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[4,1] = is_enduser_part_num_head_t
lole_Sheet.Range("A4:A4").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[5,1] = is_material_num_head_t
lole_Sheet.Range("A5:A5").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[6,1] = is_payoff_direction_head_t
lole_Sheet.Range("A6:A6").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[7,1] = is_flaw_reason_head_t
lole_Sheet.Range("A7:A7").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[8,1] = is_handling_codes_head_t
lole_Sheet.Range("A8:A8").Select
lole_OLE.Selection.Font.Bold = True

//---

SetPointer(HourGlass!)
ld_today = Today()
ld_now = Now()
ls_today = String(ld_today,"yymmdd")
ls_now = String(ld_now,"hhmmss")

////Delete extra columns	
//lole_Sheet.Columns("O:T").Select
//lole_OLE.Selection.Delete

//Justify
//lole_OLE.Selection.HorizontalAlignment = -4108 //Center
//lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
//lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

lole_Sheet.Range("A4:E" + String(ll_report_rows + 9)).Select
lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify

lole_Sheet.Range("F4:F" + String(ll_report_rows + 9)).Select
lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

lole_Sheet.Range("G4:H" + String(ll_report_rows + 9)).Select
lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify

lole_Sheet.Range("I4:K" + String(ll_report_rows + 9)).Select
lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

lole_Sheet.Range("L4:L" + String(ll_report_rows + 9)).Select
lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify

//Change date format for a column
lole_Sheet.Range("C9:C" + String(ll_report_rows + 9)).Select
lole_OLE.Selection.NumberFormat = "mm/dd/yyyy"

//Change number format for a column
//lole_Sheet.Range("H9:I" + String(ll_report_rows + 9)).Select
//lole_OLE.Selection.NumberFormat = "###,###,###.###"

//lole_Sheet.Range("E9:E" + String(ll_report_rows + 9)).Select
//lole_OLE.Selection.NumberFormat = "###,###,###.00"

//Underline column headers
lole_Sheet.Range("A9:L9").Select
lole_OLE.Selection.Font.Underline = True

////Underline the 3 totals columns
//lole_OLE.Application.range ("E" + String(ll_report_rows + 9) + ":G" + String(ll_report_rows + 9)).borders(4).LineStyle = 1

//Increase column width
lole_Sheet.Range("A4:A4").Select
lole_OLE.Selection.ColumnWidth = 18.3

lole_Sheet.Range("B4:B4").Select
lole_OLE.Selection.ColumnWidth = 21.1

lole_Sheet.Range("C4:C4").Select
lole_OLE.Selection.ColumnWidth = 21.1

lole_Sheet.Range("D4:D4").Select
lole_OLE.Selection.ColumnWidth = 21.1

lole_Sheet.Range("E4:E4").Select
lole_OLE.Selection.ColumnWidth = 18.3

lole_Sheet.Range("F4:F4").Select
lole_OLE.Selection.ColumnWidth = 16.2

lole_Sheet.Range("G4:G4").Select
lole_OLE.Selection.ColumnWidth = 16.2

lole_Sheet.Range("H4:H4").Select
lole_OLE.Selection.ColumnWidth = 36.9

lole_Sheet.Range("J4:K4").Select
lole_OLE.Selection.ColumnWidth = 17.8

lole_Sheet.Range("L4:L4").Select
lole_OLE.Selection.ColumnWidth = 62.6

//---

lole_OLE.cells[1,1] = "QR Report"
lole_Sheet.Range("A1:A1").Select
lole_OLE.Selection.Font.Bold = True
lole_OLE.Selection.Font.Size = 24 //Change font size
lole_OLE.Selection.Font.Underline = True

//---

ls_folder = ProfileString(gs_ini_file, "EMAIL","email_out","c:\temp\")

If Right(ls_folder, 1) <> "\" Then ls_folder = ls_folder + "\"
ls_file = ls_folder + "QR Report" + "_" + ls_today + ls_now + ".xls"

//Check if ls_folder exists.
lb_directoryexists = DirectoryExists(ls_folder)

If Not lb_directoryexists Then //Folder ls_folder doesn't exist
	CreateDirectory(ls_folder) //Create ls_folder
End If

lole_sheet.SaveAs(ls_file, Excel8!)

//Open the worksheet for user to veiw
li_answer = MessageBox("Open Worksheet?", "Would you like to open worksheet " + ls_file + "?", Question!, YesNo!, 1)

If li_answer = 1 Then //Yes
	lole_OLE.Application.Visible = True
Else
	lole_OLE.Application.Visible = False
End If
	
lole_OLE.DisconnectObject()
DESTROY lole_OLE
//Alex Gerlants. 05/02/2016. End
end subroutine

public subroutine wf_add_2sql (long al_die_id, datetime adt_date_from, datetime adt_date_to);/*
Function:	wf_add_2sql
Returns:		none
Arguments:	value		long		al_die_id
				value		datetime	adt_date_from
				value		datetime	adt_date_to
				
where ab_job.time_date_finished between to_date( '08/20/2016 00:00:00', 'mm/dd/yyyy hh24:mi:ss' ) and to_date( '08/24/2016 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )

*/

String		ls_add_2sql_die, ls_die_id, ls_die_id_string
String		ls_sql, ls_sql_1, ls_sql_2, ls_sql_new
String		ls_date_from, ls_date_to
String		ls_sql_dates_from, ls_sql_dates_to, ls_add_2sql_dates_where
Long			ll_die_id, ll_rows, ll_row, ll_pos_group_by
Integer		li_rtn
DataStore	lds_die_by_name

li_rtn = dw_report.SetSqlSelect(is_sql_orig) //To start, restore the original SQL

ls_date_from = String(adt_date_from, "mm/dd/yyyy")
ls_date_to = String(adt_date_to, "mm/dd/yyyy")

ls_add_2sql_dates_where = " where order_item.theoretical_unit_wt > 0 and dbo.f_get_die_id(ab_job.ab_job_num) is not null " + &
							" and ab_job.job_status = 0 " + &
							" and ab_job.time_date_finished between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + &
							" and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )  "

//ls_add_2sql_dates_where = ls_add_2sql_dates_where + " and dbo.f_get_die_name_ab_job(ab_job.ab_job_num) is not null and dbo.f_get_die_name_ab_job(ab_job.ab_job_num) <> ' ' "

ls_sql = dw_report.GetSqlSelect()

If ls_sql <> "" Then
	ll_pos_group_by = Pos(ls_sql, "group by", 1)
	
	If ll_pos_group_by > 0 Then
		ls_sql_1 = Mid(ls_sql, 1, ll_pos_group_by - 1) + "  "
		ls_sql_2 = "  " + Mid(ls_sql, ll_pos_group_by, Len(ls_sql))
	End If
End If

If al_die_id <= 0 Then //All dies
	//Add date arguments only
	ls_sql_new = ls_sql_1 + ls_add_2sql_dates_where + ls_sql_2
Else //al_die_id > 0 <== One die selected
	ls_add_2sql_die = "  and dbo.f_get_die_id(ab_job.ab_job_num) = " + String(al_die_id)
	ls_sql_new = ls_sql_1 + ls_add_2sql_dates_where + ls_add_2sql_die + ls_sql_2
End If

li_rtn = dw_report.SetSqlSelect(ls_sql_new)

end subroutine

public function long wf_rejected_coil_wt (long al_job, long al_coil_num);/*
Function:	wf_rejected_coil_wt
Returns:		long
Arguments:	value	long	al_job
				value	long	al_col_num
*/

Long ll_wt1, ll_wt2, ll_wt, ll_shift_end_wt

CONNECT USING SQLCA;

SELECT process_quantity, process_end_wt INTO :ll_wt, :ll_shift_end_wt
FROM process_coil
WHERE (coil_abc_num = :al_coil_num) AND (ab_job_num = :al_job)
USING SQLCA;
IF IsNULL(ll_wt) THEN ll_wt = 0

IF IsNULL(ll_shift_end_wt) THEN
	SELECT net_wt_balance INTO :ll_wt1
	FROM coil
	WHERE coil_abc_num = :al_coil_num
	USING SQLCA;
	IF ISNULL(ll_wt1) THEN ll_wt1 = 0
ELSE
	ll_wt1 = ll_shift_end_wt
END IF

SELECT MAX(process_quantity) INTO :ll_wt2
FROM process_coil
WHERE (coil_abc_num = :al_coil_num) AND (process_quantity < :ll_wt)
USING SQLCA;
IF IsNULL(ll_wt2) THEN ll_wt2 = 0

RETURN MAX(ll_wt1, ll_wt2)
end function

public subroutine wf_set_display_values (long al_job, long al_row);///*
//Function:	wf_set_display_values
//Returns:		none
//Arguments:	value	long	al_jobString
//				value	long	al_row
//*/
//
//String	ls_modstring, ls_processed_wt, ls_scrap_net
//Long 		ll_l, ll_coilnet, ll_sheetnet, ll_scrapnet, ll_rejnet, ll_t, ll_l1, ll_l2
//Long		ll_rebandedwt, ll_unprocessed_num, ll_unprocessednet
//Long		ll_rows, ll_row, ll_coil_abc_num
//
//
//ll_rows = dw_rejcoil_list.Retrieve(al_job)
//ll_rows = dw_rebanded_list.Retrieve(al_job)
//
//SELECT NVL(COUNT(coil_abc_num),0) INTO :ll_l
//FROM process_coil
//WHERE ab_job_num = :al_job
//USING SQLCA;
//ls_modstring = "coil_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
////dw_report.Modify(ls_modstring) 
//
////Modified by Victor Huang in 04/05
//SELECT NVL(COUNT(coil_abc_num),0) INTO :ll_unprocessed_num
//FROM process_coil
//WHERE ab_job_num = :al_job AND process_coil_status = 2	//for those coil applied but never used in this ab_job
//USING SQLCA;
//
//ll_l = ll_unprocessed_num
//ls_modstring = "unproccoil_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
////dw_report.Modify(ls_modstring) 
//
//SELECT NVL(SUM(process_quantity),0) INTO :ll_unprocessednet
//FROM process_coil
//WHERE ab_job_num = :al_job AND process_coil_status = 2	//for those coil applied but never used in this ab_job
//USING SQLCA;
//
//ll_l = ll_unprocessednet
//ls_modstring = "unproccoil_net_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
////dw_report.Modify(ls_modstring) 
//
//ll_l1 = dw_rejcoil_list.RowCount()
//ll_l2 = dw_rebanded_list.RowCount()
//ll_l = ll_l1 + ll_l2
//ls_modstring = "rejcoil_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
////dw_report.Modify(ls_modstring) 
//ll_rejnet = 0
//
//IF ll_l1 > 0 THEN
//	FOR ll_t = 1 TO ll_l1
//		ll_rejnet = ll_rejnet + wf_rejected_coil_wt(al_job, dw_rejcoil_list.GetItemNumber(ll_t, "process_coil_coil_abc_num"))
//	NEXT
//	ls_modstring = "rejcoil_wt_t.Text = ~"" + String(ll_rejnet, "###,###,###") + "~""
//	dw_rejcoil_list.Modify(ls_modstring) 
//END IF
//ll_rebandedwt = 0
//IF ll_l2 > 0 THEN
//	FOR ll_t = 1 TO ll_l2
//		ll_rebandedwt = ll_rebandedwt + wf_rejected_coil_wt(al_job, dw_rebanded_list.GetItemNumber(ll_t, "process_coil_coil_abc_num"))
//	NEXT
//	ls_modstring = "rejcoil_wt_t.Text = ~"" + String(ll_rebandedwt, "###,###,###") + "~""
//	dw_rebanded_list.Modify(ls_modstring) 
//END IF
//ll_rejnet = ll_rejnet + ll_rebandedwt
//ls_modstring = "rejcoil_net_t.Text = ~"" + String(ll_rejnet, "###,###,###") + "~""
////dw_report.Modify(ls_modstring) 
//
//
//SELECT NVL(COUNT(sheet_skid_num),0) INTO :ll_l
//FROM sheet_skid
//WHERE ab_job_num = :al_job
//USING SQLCA;
//ls_modstring = "sheet_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
////dw_report.Modify(ls_modstring) 
//
//SELECT NVL(COUNT(return_scrap_item_num),0) INTO :ll_l
//FROM return_scrap_item
//WHERE ab_job_num = :al_job
//USING SQLCA;
//ls_modstring = "scrap_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
////dw_report.Modify(ls_modstring) 
//
//SELECT NVL(SUM(process_quantity),0) INTO :ll_l
//FROM process_coil
//WHERE ab_job_num = :al_job
//USING SQLCA;
//ls_modstring = "coil_net_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
////dw_report.Modify(ls_modstring) 
//ll_coilnet = ll_l
//
//If ll_coilnet <= 0 Then is_test = is_test + ", " + String(al_job)
//
//SELECT NVL(SUM(prod_item_net_wt),0) INTO :ll_l
//FROM production_sheet_item
//WHERE ab_job_num = :al_job
//USING SQLCA;
//ls_modstring = "sheet_net_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
////dw_report.Modify(ls_modstring) 
//ll_sheetnet = ll_l
//
//		SELECT NVL(SUM(return_item_net_wt),0) INTO :ll_l
//		FROM return_scrap_item
//		WHERE ab_job_num = :al_job
//		USING SQLCA;
//		ls_modstring = "scrap_net_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
//		//dw_report.Modify(ls_modstring) 
//		
//		ls_scrap_net = String(ll_l, "###,###,###")
//		dw_report.Object.scrap_net_t[al_row] = ls_scrap_net
//		
//		//il_scrap_net = il_scrap_net + ll_l //Accumulate scrap weight
//		
//		ll_scrapnet = ll_l
//
//SELECT NVL(SUM(prod_item_pieces),0) INTO :ll_l
//FROM production_sheet_item
//WHERE ab_job_num = :al_job
//USING SQLCA;
//ls_modstring = "sheet_pc_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
////dw_report.Modify(ls_modstring) 
//
//SELECT SUM(sheet_tare_wt) INTO :ll_l
//FROM sheet_skid
//WHERE ab_job_num = :al_job
//USING SQLCA;
//ll_l = ll_l + ll_sheetnet
//ls_modstring = "sheet_tare_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
////dw_report.Modify(ls_modstring) 
//
//SELECT NVL(SUM(scrap_tare_wt),0) INTO :ll_l
//FROM scrap_skid
//WHERE scrap_ab_job_num = :al_job
//USING SQLCA;
//ll_l = ll_l + ll_scrapnet
//ls_modstring = "scrap_tare_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
////dw_report.Modify(ls_modstring) 
//
//
//ll_l = ll_sheetnet + ll_scrapnet + ll_rejnet + ll_unprocessednet - ll_coilnet 
//ls_modstring = "off_t.Text = ~"" + String(ll_l, "###,###,##0") + "~""
////dw_report.Modify(ls_modstring) 
////ls_modstring = "off_per_t.Text = ~"( " + String((ll_l/ll_coilnet)*100, "#0.###") + "% )~""
////dw_report.Modify(ls_modstring) 
//
//		//BEGIN Modified by Victor Huang in 04/06
//		ls_modstring = "processed_t.Text = ~"" + String((ll_coilnet - ll_unprocessednet - ll_rejnet), "###,###,###") + "~""
//		dw_report.Modify(ls_modstring)
//		
//		ls_processed_wt = String((ll_coilnet - ll_unprocessednet - ll_rejnet), "###,###,###")
//		dw_report.Object.processed_t[al_row] = ls_processed_wt
//		
//		//il_sum_processed = il_sum_processed + ll_coilnet - ll_unprocessednet - ll_rejnet //Accumulate total processed weight
//		
//		//If al_job = 98504 Then
//		//	MessageBox("", "ab_job_num = " + String(al_job) + &
//		//						"~n~rll_coilnet = " + String(ll_coilnet) + &
//		//						"~n~rll_unprocessednet = " + String(ll_unprocessednet) + &
//		//						"~n~rll_rejnet = " + String(ll_rejnet) + &
//		//						"~n~ril_sum_processed = " + String(il_sum_processed))
//		//End If
//		
//		//END Modified by Victor Huang in 04/06
//
//dw_report.SetItemStatus(al_row, 0, Primary!, NotModified!)
end subroutine

public function integer wf_calc_prev_month ();//Alex Gerlants. QR_Report. Begin
/*
Function:	wf_calc_prev_month
Returns:		integer	 1 if OK
							-1 if DB error
Arguments:	value	string	as_email_addresses[]							
*/

Integer					li_rtn = 1
Integer					li_i
Boolean					lb_rtn, lb_leap_year_2select
Date						ld_date_from, ld_date_to
String					ls_today, ls_month, ls_day, ls_year, ls_month_2select, ls_year_2select
String					ls_day_from = "01", ls_day_to, ls_add_2sql
String					ls_days_leap[] = {"31","29","31","30","31","30","31","31","30","31","30","31"}
String					ls_days_not_leap[] = {"31","28","31","30","31","30","31","31","30","31","30","31"}
String					ls_key, ls_date_from, ls_date_to, ls_run_message
String					ls_file_name_2email[], ls_file, ls_body, ls_email_address
String					ls_sql, ls_sql_new
Time						lt_time_from, lt_time_to
Long						ll_rows, ll_row, ll_i
//w_inventory_reports	lw_inventory_reports
//DataStore				lds_qr_report
//
//ls_run_message = "QR report run started."
//li_rtn = wf_insert_auto_run_log(ls_run_message)
//
//If IsValid(lds_qr_report) Then Destroy lds_qr_report
//lds_qr_report = Create DataStore
//lds_qr_report.DataObject = "d_qr_report"
//lds_qr_report.SetTransObject(sqlca)

//This report has to run on the first of every month.
//The data are from the first day of the previous month to the last day of the previous month.

ls_today = String(Today(), "mm/dd/yyyy")

//ls_today = "03/01/2018" //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

ls_month = Left(ls_today, 2)
ls_day = Mid(ls_today, 4, 2)
ls_year = Right(ls_today, 4)

If Mod(Integer(ls_year), 4) = 0 Then
	lb_leap_year_2select = True
Else
	lb_leap_year_2select = False
End If

If ls_month = "01" Then
	ls_month_2select = "12" //December of previous year
	ls_year_2select = String(Integer(ls_year) - 1, "00") //Previous year
Else
	ls_month_2select = String(Integer(ls_month) - 1, "00") //Previous month of current year
	ls_year_2select = ls_year //Current year
End If

If lb_leap_year_2select Then
	ls_day_to = ls_days_leap[Integer(ls_month_2select)]
Else
	ls_day_to = ls_days_not_leap[Integer(ls_month_2select)]
End If

ls_date_from = ls_month_2select + "/" + ls_day_from + "/" + ls_year_2select
ls_date_to = ls_month_2select + "/" + ls_day_to + "/" + ls_year_2select

em_from.Text = ls_date_from
em_to.Text = ls_date_to

is_add_2sql_prev_month = " where coil.date_received between " + &
						"to_date('" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss')" + &
						" and to_date('" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss')" + &
						" order by coil.coil_abc_num, coil.coil_org_num, coil_quality_flaw_mapping.starting_position, coil_quality_flaw_mapping.ending_position"

Return li_rtn
end function

on w_report_qr.create
int iCurrent
call super::create
this.st_2=create st_2
this.dw_enduser_part_num=create dw_enduser_part_num
this.cbx_no_flaws=create cbx_no_flaws
this.st_1=create st_1
this.dw_handling_codes=create dw_handling_codes
this.dw_flaw_reason=create dw_flaw_reason
this.dw_material_num=create dw_material_num
this.dw_payoff_direction=create dw_payoff_direction
this.st_9=create st_9
this.st_8=create st_8
this.st_5=create st_5
this.cb_getsize=create cb_getsize
this.st_6=create st_6
this.dw_customer_lookup=create dw_customer_lookup
this.cb_export=create cb_export
this.dw_rebanded_list=create dw_rebanded_list
this.dw_rejcoil_list=create dw_rejcoil_list
this.st_rowcount=create st_rowcount
this.cb_1=create cb_1
this.st_all_dates=create st_all_dates
this.cb_retrieve=create cb_retrieve
this.em_from=create em_from
this.em_to=create em_to
this.st_from=create st_from
this.st_to=create st_to
this.dw_report=create dw_report
this.cb_close=create cb_close
this.cb_print=create cb_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.dw_enduser_part_num
this.Control[iCurrent+3]=this.cbx_no_flaws
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.dw_handling_codes
this.Control[iCurrent+6]=this.dw_flaw_reason
this.Control[iCurrent+7]=this.dw_material_num
this.Control[iCurrent+8]=this.dw_payoff_direction
this.Control[iCurrent+9]=this.st_9
this.Control[iCurrent+10]=this.st_8
this.Control[iCurrent+11]=this.st_5
this.Control[iCurrent+12]=this.cb_getsize
this.Control[iCurrent+13]=this.st_6
this.Control[iCurrent+14]=this.dw_customer_lookup
this.Control[iCurrent+15]=this.cb_export
this.Control[iCurrent+16]=this.dw_rebanded_list
this.Control[iCurrent+17]=this.dw_rejcoil_list
this.Control[iCurrent+18]=this.st_rowcount
this.Control[iCurrent+19]=this.cb_1
this.Control[iCurrent+20]=this.st_all_dates
this.Control[iCurrent+21]=this.cb_retrieve
this.Control[iCurrent+22]=this.em_from
this.Control[iCurrent+23]=this.em_to
this.Control[iCurrent+24]=this.st_from
this.Control[iCurrent+25]=this.st_to
this.Control[iCurrent+26]=this.dw_report
this.Control[iCurrent+27]=this.cb_close
this.Control[iCurrent+28]=this.cb_print
end on

on w_report_qr.destroy
call super::destroy
destroy(this.st_2)
destroy(this.dw_enduser_part_num)
destroy(this.cbx_no_flaws)
destroy(this.st_1)
destroy(this.dw_handling_codes)
destroy(this.dw_flaw_reason)
destroy(this.dw_material_num)
destroy(this.dw_payoff_direction)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_5)
destroy(this.cb_getsize)
destroy(this.st_6)
destroy(this.dw_customer_lookup)
destroy(this.cb_export)
destroy(this.dw_rebanded_list)
destroy(this.dw_rejcoil_list)
destroy(this.st_rowcount)
destroy(this.cb_1)
destroy(this.st_all_dates)
destroy(this.cb_retrieve)
destroy(this.em_from)
destroy(this.em_to)
destroy(this.st_from)
destroy(this.st_to)
destroy(this.dw_report)
destroy(this.cb_close)
destroy(this.cb_print)
end on

event open;call super::open;Integer				li_rtn
Long					ll_rows, ll_row_inserted
DataWindowChild	ldwc
Date					ld_from_default

dw_rejcoil_list.SetTransObject(sqlca)
dw_rebanded_list.SetTransObject(sqlca)


dw_report.SetTransObject(sqlca)
is_sql_orig = dw_report.GetSqlSelect() //Save the original SQL
cb_getsize.Visible = False

//ld_from_default = RelativeDate(Today(), -7) //7 days into the past
//em_from.Text = String(ld_from_default)

wf_calc_prev_month()

//dw_customer
li_rtn = dw_customer_lookup.GetChild("customer_name", ldwc)

If li_rtn = 1 Then //OK
	ldwc.SetTransObject(sqlca)
	ll_rows = ldwc.Retrieve()
	
	If ll_rows > 0 Then
		ll_row_inserted = ldwc.InsertRow(1)
		
		If ll_row_inserted > 0 Then
			//Update drop-down
			ldwc.SetItem(ll_row_inserted, "customer_short_name", "ALL")
			ldwc.SetItem(ll_row_inserted, "customer_id", 0)
			
			//Update dw_customer_lookup
			dw_customer_lookup.Object.customer_name[1] = "ALL"
			dw_customer_lookup.Object.customer_id[1] = 0
		End If
	End If
End If

//dw_payoff_direction
li_rtn = dw_payoff_direction.GetChild("payoff_direction", ldwc)

If li_rtn = 1 Then //OK
	ldwc.SetTransObject(sqlca)
	ll_rows = ldwc.Retrieve()
	
	If ll_rows > 0 Then
		ll_row_inserted = ldwc.InsertRow(1)
		
		If ll_row_inserted > 0 Then
			//Update drop-down
			ldwc.SetItem(ll_row_inserted, "payoff_direction_desc", "ALL")
			ldwc.SetItem(ll_row_inserted, "payoff_direction", "0")
			
			//Update dw_payoff_direction
			dw_payoff_direction.Object.payoff_direction[1] = "ALL"
		End If
	End If
End If

//dw_enduser_part_num
li_rtn = dw_enduser_part_num.GetChild("enduser_part_num", ldwc)

If li_rtn = 1 Then //OK
	ldwc.SetTransObject(sqlca)
	ll_rows = ldwc.Retrieve()
	
	If ll_rows > 0 Then
		ll_row_inserted = ldwc.InsertRow(1)
		
		If ll_row_inserted > 0 Then
			//Update drop-down
			ldwc.SetItem(ll_row_inserted, "enduser_part_num", "ALL")
			
			//Update dw_enduser_part_num
			dw_enduser_part_num.Object.enduser_part_num[1] = "ALL"
		End If
	End If
End If

//dw_material_num
li_rtn = dw_material_num.GetChild("material_num", ldwc)

If li_rtn = 1 Then //OK
	ldwc.SetTransObject(sqlca)
	ll_rows = ldwc.Retrieve()
	
	If ll_rows > 0 Then
		ll_row_inserted = ldwc.InsertRow(1)
		
		If ll_row_inserted > 0 Then
			//Update drop-down
			ldwc.SetItem(ll_row_inserted, "material_num", "ALL")
			
			//Update dw_material_num
			dw_material_num.Object.material_num[1] = "ALL"
		End If
	End If
End If

//dw_flaw_reason
li_rtn = dw_flaw_reason.GetChild("flaw_reason", ldwc)

If li_rtn = 1 Then //OK
	ldwc.SetTransObject(sqlca)
	ll_rows = ldwc.Retrieve()
	
	If ll_rows > 0 Then
		ll_row_inserted = ldwc.InsertRow(1)
		
		If ll_row_inserted > 0 Then
			//Update drop-down
			ldwc.SetItem(ll_row_inserted, "flaw_reason", "ALL")
			
			//Update dw_flaw_reason
			dw_flaw_reason.Object.flaw_reason[1] = "ALL"
		End If
	End If
End If

//dw_handling_codes
li_rtn = dw_handling_codes.GetChild("handling_code", ldwc)

If li_rtn = 1 Then //OK
	ldwc.SetTransObject(sqlca)
	ll_rows = ldwc.Retrieve()
	
	If ll_rows > 0 Then
		////Update dw_handling_codes
		//dw_handling_codes.Object.handling_code[1] = "ALL"
		
		ll_row_inserted = ldwc.InsertRow(1)
		
		If ll_row_inserted > 0 Then
			//Update drop-down
			ldwc.SetItem(ll_row_inserted, "handling_code_name", "ALL")
			
			//Update dw_handling_codes
			dw_handling_codes.Object.handling_code[1] = "ALL"
		End If
	End If
End If

cb_retrieve.Event Clicked()
dw_report.SetFocus()



end event

event pfc_postopen;call super::pfc_postopen;This.Width = 5230
This.Height = 2451

dw_report.Width = 5109
dw_report.Height = 1875
end event

event pfc_preopen;call super::pfc_preopen;This.Width = 4650
This.Height = 2800


This.of_SetResize(True)

If IsValid(This.inv_resize) THEN
   This.inv_resize.of_SetOrigSize(4650, 2800)

	This.inv_resize.of_Register(st_rowcount, "FixedToBottom")

	This.inv_resize.of_Register(cb_print, "FixedToBottom")
	This.inv_resize.of_Register(cb_export, "FixedToBottom")
	This.inv_resize.of_Register(cb_1, "FixedToBottom")
	This.inv_resize.of_Register(cb_retrieve, "FixedToBottom")
	This.inv_resize.of_Register(cb_close, "FixedToBottom")
	This.inv_resize.of_Register(cb_getsize, "FixedToBottom")
End If
end event

type st_2 from statictext within w_report_qr
integer x = 1485
integer y = 6
integer width = 351
integer height = 51
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "End User Part #"
boolean focusrectangle = false
end type

type dw_enduser_part_num from datawindow within w_report_qr
integer x = 1477
integer y = 70
integer width = 501
integer height = 80
integer taborder = 80
string title = "none"
string dataobject = "d_enduser_part_num_qr"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cbx_no_flaws from checkbox within w_report_qr
integer x = 4765
integer y = 74
integer width = 300
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "No Flaws"
end type

event clicked;//dw_report.Reset()

If This.Checked Then
	is_handling_code_arg_save = dw_handling_codes.Object.handling_code[1]
	is_flaw_reason_arg_save = dw_flaw_reason.Object.flaw_reason[1]
	
	dw_handling_codes.Object.handling_code[1] = "NONE"
	dw_flaw_reason.Object.flaw_reason[1] = "NONE"
Else //This.Checked = False
	dw_handling_codes.Object.handling_code[1] = is_handling_code_arg_save
	dw_flaw_reason.Object.flaw_reason[1] = is_flaw_reason_arg_save
End If
end event

type st_1 from statictext within w_report_qr
integer x = 3416
integer y = 6
integer width = 344
integer height = 51
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Flaw Handling"
boolean focusrectangle = false
end type

type dw_handling_codes from datawindow within w_report_qr
integer x = 3412
integer y = 70
integer width = 1349
integer height = 80
integer taborder = 70
string title = "none"
string dataobject = "d_handling_codes"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_flaw_reason from datawindow within w_report_qr
integer x = 2666
integer y = 70
integer width = 728
integer height = 80
integer taborder = 60
string title = "none"
string dataobject = "d_flaw_reason_qr"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_material_num from datawindow within w_report_qr
integer x = 1997
integer y = 70
integer width = 358
integer height = 80
integer taborder = 40
string title = "none"
string dataobject = "d_material_num_qr"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_payoff_direction from datawindow within w_report_qr
integer x = 2373
integer y = 70
integer width = 271
integer height = 74
integer taborder = 50
string dataobject = "d_payoff_direction_qr"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_9 from statictext within w_report_qr
integer x = 2666
integer y = 6
integer width = 285
integer height = 51
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Flaw Reason"
boolean focusrectangle = false
end type

type st_8 from statictext within w_report_qr
integer x = 2370
integer y = 6
integer width = 238
integer height = 51
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Payoff Dir"
boolean focusrectangle = false
end type

type st_5 from statictext within w_report_qr
integer x = 1997
integer y = 6
integer width = 245
integer height = 51
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Material #"
boolean focusrectangle = false
end type

type cb_getsize from commandbutton within w_report_qr
integer x = 3873
integer y = 2666
integer width = 322
integer height = 90
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "GetSize"
end type

event clicked;MessageBox("", "Window Width: " + String(Parent.Width) + &
					"~n~rWindow Height: " + String(Parent.Height) + &
					"~n~rWindow X: " + String(Parent.X) + &
					"~n~rWindow Y: " + String(Parent.Y) + &
					"~n~r~n~rdw_report.Width: " + String(dw_report.Width) + &
					"~n~rdw_report.Height: " + String(dw_report.Height) + &
					"~n~rdw_report X: " + String(dw_report.X) + &
					"~n~rdw_report Y: " + String(dw_report.Y))
end event

type st_6 from statictext within w_report_qr
integer x = 713
integer y = 6
integer width = 234
integer height = 51
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Customer"
boolean focusrectangle = false
end type

type dw_customer_lookup from datawindow within w_report_qr
integer x = 699
integer y = 70
integer width = 775
integer height = 77
integer taborder = 30
string title = "none"
string dataobject = "d_customer_qr"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_export from u_cb within w_report_qr
integer x = 1375
integer y = 2666
integer width = 406
integer height = 93
integer taborder = 110
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Export to Excel"
end type

event clicked;call super::clicked;String	ls_date_from, ls_date_to, ls_file

ls_date_from = em_from.Text
ls_date_from = Replace(ls_date_from, 3, 1, "")
ls_date_from = Replace(ls_date_from, 5, 1, "")

ls_date_to = em_to.Text
ls_date_to = Replace(ls_date_to, 3, 1, "")
ls_date_to = Replace(ls_date_to, 5, 1, "")

ls_file = "c:\temp\QR Report " + ls_date_from + "-" + ls_date_to + ".xls"

If dw_report.SaveAs(ls_file, Excel8!, True) = -1 Then
   MessageBox("Data SaveAs", "Error")
	Return -1
Else
	MessageBox("Success", "Data have been successfully exported to " + ls_file)
End If

Return 1
end event

type dw_rebanded_list from datawindow within w_report_qr
boolean visible = false
integer x = 3562
integer y = 2163
integer width = 549
integer height = 320
integer taborder = 120
string title = "none"
string dataobject = "d_ab_job_reband_coil_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_rejcoil_list from datawindow within w_report_qr
boolean visible = false
integer x = 2970
integer y = 2147
integer width = 549
integer height = 320
integer taborder = 70
string title = "none"
string dataobject = "d_ab_job_rej_coil_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_rowcount from statictext within w_report_qr
integer x = 22
integer y = 2582
integer width = 2900
integer height = 61
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_report_qr
integer x = 940
integer y = 2666
integer width = 344
integer height = 93
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Open in Excel"
end type

event clicked;Parent.ExportToExcel( dw_report, dw_report.RowCount() )
end event

type st_all_dates from statictext within w_report_qr
boolean visible = false
integer x = 702
integer y = 205
integer width = 410
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Starting 1/1/2015"
boolean focusrectangle = false
end type

type cb_retrieve from commandbutton within w_report_qr
integer x = 18
integer y = 2666
integer width = 351
integer height = 93
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Retrieve"
boolean default = true
end type

event clicked;String				ls_line, ls_alloy, ls_temper, ls_scrap_type, ls_sheet_type_desc, ls_coil_org_num_2, ls_coil_abc_num_2
String				ls_date_from, ls_date_to, ls_add_2sql_where, ls_sql_new, ls_customer_name, ls_flaw_reason, ls_flaw_reason_desc
String				ls_find_string, ls_coil_abc_num, ls_coil_org_num, ls_material_num, ls_payoff_direction, ls_payoff_direction_desc
String				ls_handling_code, ls_handling_code_name, ls_enduser_part_num
Integer				li_rtn
Long					ll_rows, ll_found_row, ll_customer_id, ll_coil_abc_num
DataWindowChild	ldwc

dw_report.AcceptText()
dw_customer_lookup.AcceptText()
dw_material_num.AcceptText()
dw_payoff_direction.AcceptText()
dw_flaw_reason.AcceptText()
dw_handling_codes.AcceptText()

ls_date_from = em_from.Text
ls_date_to = em_to.Text

If ls_date_from = "00/00/0000" Or ls_date_to = "00/00/0000" Then Return

li_rtn = dw_report.SetSqlSelect(is_sql_orig) //To start, restore the original SQL
ls_add_2sql_where = ""

ls_customer_name = dw_customer_lookup.Object.customer_name[1]

If IsNumber(ls_customer_name) Then
	ll_customer_id = Long(ls_customer_name)
End if

li_rtn = dw_customer_lookup.GetChild("customer_name", ldwc)

If li_rtn = 1 Then //OK
	ls_find_string = "customer_id = " + String(ll_customer_id)
	ll_found_row = ldwc.Find(ls_find_string, 1, ldwc.RowCount())
	
	If ll_found_row > 0 Then
		ls_customer_name = Trim(ldwc.GetItemString(ll_found_row, "customer_short_name"))
	End If
End If

If ls_customer_name = "ALL" Then
	is_customer_head_t = "All Customers"
Else
	ls_add_2sql_where = ls_add_2sql_where + "~n~rwhere coil.customer_id = " + String(ll_customer_id)
	is_customer_head_t = "Customer: " + ls_customer_name
End If

//---

ls_date_from = em_from.Text
ls_date_to = em_to.Text

If ls_date_from = ls_date_to Then
	is_date_range_head_t = "Coil Date Received: " + ls_date_from
Else
	is_date_range_head_t = "Coil Date Received between " + ls_date_from + " and " + ls_date_to
End If

If ls_add_2sql_where = "" Then
	ls_add_2sql_where = ls_add_2sql_where + "~n~rwhere coil.date_received between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + &
							" and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )  "
Else
	ls_add_2sql_where = ls_add_2sql_where + "~n~rand coil.date_received between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + &
							" and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )  "
End if
							
//---

ls_enduser_part_num = dw_enduser_part_num.Object.enduser_part_num[1]
If IsNull(ls_enduser_part_num) Then ls_enduser_part_num = ""

Choose Case ls_enduser_part_num
	Case "ALL"
		is_enduser_part_num_head_t = "All End User Parts"
	Case ""
		ls_add_2sql_where = ls_add_2sql_where + "~n~rand order_item.enduser_part_num is null"
		is_enduser_part_num_head_t = "Coils Have Not Been Processed"
	Case Else
		ls_enduser_part_num = dw_enduser_part_num.Object.enduser_part_num[1]
		ls_add_2sql_where = ls_add_2sql_where + "~n~rand order_item.enduser_part_num = '" + ls_enduser_part_num + "'"
		is_enduser_part_num_head_t = "End User Part: " + ls_enduser_part_num
End Choose

//---

ls_material_num = dw_material_num.Object.material_num[1]
If IsNull(ls_material_num) Then ls_material_num = "ALL"

If ls_material_num = "ALL" Then
	is_material_num_head_t = "All Material Numbers"
Else
	ls_material_num = dw_material_num.Object.material_num[1]
	ls_add_2sql_where = ls_add_2sql_where + "~n~rand coil.material_num = '" + ls_material_num + "'"
	is_material_num_head_t = "Material Number: " + ls_material_num
End If

//---

ls_payoff_direction = dw_payoff_direction.Object.payoff_direction[1]
If IsNull(ls_payoff_direction) Then ls_payoff_direction = "ALL"

If ls_payoff_direction = "ALL" Or ls_payoff_direction = "0" Then
	is_payoff_direction_head_t = "All Payoff Directions"
Else
	ls_add_2sql_where = ls_add_2sql_where + "~n~rand coil_quality.payoff_direction = '" + ls_payoff_direction + "'"

	li_rtn = dw_payoff_direction.GetChild("payoff_direction", ldwc)

	If li_rtn = 1 Then //OK
		ls_find_string = "payoff_direction = '" + ls_payoff_direction + "'"
		ll_found_row = ldwc.Find(ls_find_string, 1, ldwc.RowCount())
		
		If ll_found_row > 0 Then
			ls_payoff_direction_desc = Trim(ldwc.GetItemString(ll_found_row, "payoff_direction_desc"))
		End If
	End If

	is_payoff_direction_head_t = "Payoff Direction: " + ls_payoff_direction_desc
End If

//---

If Not cbx_no_flaws.Checked Then
	ls_flaw_reason = dw_flaw_reason.Object.flaw_reason[1]
	If IsNull(ls_flaw_reason) Then ls_flaw_reason = "ALL"
	
	If ls_flaw_reason = "ALL" Then
		is_flaw_reason_head_t = "All Flaw Reasons"
	Else
		ls_add_2sql_where = ls_add_2sql_where + "~n~rand coil_quality_flaw_mapping.flaw_code = '" + ls_flaw_reason + "'"
		
		li_rtn = dw_flaw_reason.GetChild("flaw_reason", ldwc)
	
		If li_rtn = 1 Then //OK
			ls_find_string = "flaw_code = " + ls_flaw_reason
			ll_found_row = ldwc.Find(ls_find_string, 1, ldwc.RowCount())
			
			If ll_found_row > 0 Then
				ls_flaw_reason_desc = Trim(ldwc.GetItemString(ll_found_row, "flaw_reason"))
			End If
		End If
		
		is_flaw_reason_head_t = "Flaw Reason: " + ls_flaw_reason_desc
	End If
	
	//---
	
	ls_handling_code = dw_handling_codes.Object.handling_code[1]
	If IsNull(ls_handling_code) Then ls_handling_code = "ALL"
	
	If ls_handling_code = "ALL" Then
		is_handling_codes_head_t = "All Handling Codes"
	Else
		ls_add_2sql_where = ls_add_2sql_where + "~n~rand handling_codes.handling_code = '" + ls_handling_code + "'"
		
		li_rtn = dw_handling_codes.GetChild("handling_code", ldwc)
	
		If li_rtn = 1 Then //OK
			ls_find_string = "handling_code = '" + ls_handling_code + "'"
			ll_found_row = ldwc.Find(ls_find_string, 1, ldwc.RowCount())
			
			If ll_found_row > 0 Then
				ls_handling_code_name = Trim(ldwc.GetItemString(ll_found_row, "handling_code_name"))
			End If
		End If
		
		is_handling_codes_head_t = "Handling Code: " + ls_handling_code_name
	End If
Else //cbx_no_flaws.Checked = True
	ls_add_2sql_where = ls_add_2sql_where + "~n~rand handling_codes.handling_code_name is null"
End If

//---

ls_sql_new = is_sql_orig + ls_add_2sql_where
ls_sql_new = ls_sql_new + "~n~rorder by coil.coil_abc_num, coil.date_received"

li_rtn = dw_report.SetSqlSelect(ls_sql_new)

ll_rows = dw_report.Retrieve()
dw_report.SetFocus()
end event

type em_from from editmask within w_report_qr
integer x = 69
integer y = 70
integer width = 282
integer height = 77
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
end type

event getfocus;String	ls_null

SetNull(ls_null)

This.Text = ls_null
end event

type em_to from editmask within w_report_qr
integer x = 362
integer y = 70
integer width = 322
integer height = 77
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
end type

event getfocus;String	ls_null

SetNull(ls_null)

This.Text = ls_null
end event

type st_from from statictext within w_report_qr
integer x = 69
integer y = 6
integer width = 234
integer height = 51
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Date From"
boolean focusrectangle = false
end type

type st_to from statictext within w_report_qr
integer x = 362
integer y = 6
integer width = 234
integer height = 51
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Date To"
boolean focusrectangle = false
end type

type dw_report from u_dw within w_report_qr
integer x = 33
integer y = 176
integer width = 5014
integer height = 1693
integer taborder = 0
string dataobject = "d_report_qr"
boolean hscrollbar = true
end type

event clicked;call super::clicked;String 	ls_old_sort, ls_column, ls_name
Char 		lc_sort

If row > 0 Then
	If This.IsSelected(row) Then
		This.SelectRow(row, False)
	Else
		This.SelectRow(0, False)
		This.SelectRow(row, True)
	End If
End If

ls_name = dwo.Name

If ls_name = "die_id_t" Then ls_name = "die_name_t" 	//Column die_id is not on the screen.
																		//Column die_name is.

/* Check whether the user clicks on the column header */
If Right(ls_name, 2) = '_t' Then
	This.SelectRow(0, False) //Unselect all rows
	
	ls_column = Left(ls_name, Len(String(ls_name)) - 2)

	/* Get old sort, If any. */
	ls_old_sort = This.Describe("Datawindow.Table.sort")

	//Check whether previously sorted column and currently clicked column are same or not. 
	//If both are same, check for the sort order of previously sorted column (A - Asc, D - Des) and change it. 
	//If both are not same, simply sort it by Ascending order.
	If ls_column = Left(ls_old_sort, Len(ls_old_sort) - 2) Then 
		lc_sort = Right(ls_old_sort, 1)

		If lc_sort = 'A' Then
			lc_sort = 'D'
		Else
			lc_sort = 'A'
		End If
		  
		This.SetSort(ls_column + " " + lc_sort)
	Else
		This.SetSort(ls_column + " A")
	End If

	This.Sort()
End If
end event

event sqlpreview;call super::sqlpreview;String	ls_sqlsyntax

ls_sqlsyntax = sqlsyntax
end event

event retrieveend;call super::retrieveend;Long		ll_rows, ll_row, ll_ab_job_num
String	ls_modstring, ls_rtn
Pointer 	oldpointer

oldpointer = SetPointer(HourGlass!)

ls_modstring = "customer_short_name_head_t.Text = '" + is_customer_head_t + "'"
ls_rtn = This.Modify(ls_modstring)

ls_modstring = "date_from_to_head_t.Text = '" + is_date_range_head_t + "'"
ls_rtn = This.Modify(ls_modstring)

ls_modstring = "enduser_part_num_head_t.Text = '" + is_enduser_part_num_head_t + "'"
ls_rtn = This.Modify(ls_modstring)

ls_modstring = "material_num_head_t.Text = '" + is_material_num_head_t + "'"
ls_rtn = This.Modify(ls_modstring)

ls_modstring = "payoff_direction_head_t.Text = '" + is_payoff_direction_head_t + "'"
ls_rtn = This.Modify(ls_modstring)

ls_modstring = "flaw_reason_head_t.Text = '" + is_flaw_reason_head_t + "'"
ls_rtn = This.Modify(ls_modstring)

ls_modstring = "handling_code_t.Text = '" + is_handling_codes_head_t + "'"
ls_rtn = This.Modify(ls_modstring)

ll_rows = This.RowCount()

If ll_rows = 1 Then
	st_rowcount.Text = "1 row retrieved"
Else
	st_rowcount.Text = String(rowcount) + " rows retrieved"
End If

If ll_rows > 0 Then
	is_run_date_t = This.Object.rundate_t[1]
End If

SetPointer(oldpointer)
end event

type cb_close from u_cb within w_report_qr
string tag = "Close without printing"
integer x = 2575
integer y = 2666
integer width = 351
integer height = 93
integer taborder = 130
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_print from u_cb within w_report_qr
integer x = 479
integer y = 2666
integer width = 351
integer height = 93
integer taborder = 90
boolean bringtotop = true
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;dw_report.Event pfc_print()
end event

