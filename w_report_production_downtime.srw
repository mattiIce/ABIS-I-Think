$PBExportHeader$w_report_production_downtime.srw
forward
global type w_report_production_downtime from w_sheet
end type
type cb_size from commandbutton within w_report_production_downtime
end type
type st_2 from statictext within w_report_production_downtime
end type
type dw_sheet_type_desc_lookup from datawindow within w_report_production_downtime
end type
type st_1 from statictext within w_report_production_downtime
end type
type dw_line from datawindow within w_report_production_downtime
end type
type st_6 from statictext within w_report_production_downtime
end type
type dw_customer_lookup from datawindow within w_report_production_downtime
end type
type cb_export from u_cb within w_report_production_downtime
end type
type dw_rebanded_list from datawindow within w_report_production_downtime
end type
type dw_rejcoil_list from datawindow within w_report_production_downtime
end type
type st_note from statictext within w_report_production_downtime
end type
type st_rowcount from statictext within w_report_production_downtime
end type
type cbx_all_dates from checkbox within w_report_production_downtime
end type
type cb_1 from commandbutton within w_report_production_downtime
end type
type st_all_dates from statictext within w_report_production_downtime
end type
type cb_retrieve from commandbutton within w_report_production_downtime
end type
type em_from from editmask within w_report_production_downtime
end type
type em_to from editmask within w_report_production_downtime
end type
type st_from from statictext within w_report_production_downtime
end type
type st_to from statictext within w_report_production_downtime
end type
type cbx_dateall from checkbox within w_report_production_downtime
end type
type dw_report from u_dw within w_report_production_downtime
end type
type cb_close from u_cb within w_report_production_downtime
end type
type cb_print from u_cb within w_report_production_downtime
end type
end forward

global type w_report_production_downtime from w_sheet
integer width = 4012
integer height = 1795
string title = "Production Downtime Report"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
cb_size cb_size
st_2 st_2
dw_sheet_type_desc_lookup dw_sheet_type_desc_lookup
st_1 st_1
dw_line dw_line
st_6 st_6
dw_customer_lookup dw_customer_lookup
cb_export cb_export
dw_rebanded_list dw_rebanded_list
dw_rejcoil_list dw_rejcoil_list
st_note st_note
st_rowcount st_rowcount
cbx_all_dates cbx_all_dates
cb_1 cb_1
st_all_dates st_all_dates
cb_retrieve cb_retrieve
em_from em_from
em_to em_to
st_from st_from
st_to st_to
cbx_dateall cbx_dateall
dw_report dw_report
cb_close cb_close
cb_print cb_print
end type
global w_report_production_downtime w_report_production_downtime

type variables
String	is_sql_orig
String	is_date_from_to

String	is_process_date_head_t
String	is_customer_name_head_t
String	is_enduser_part_num_head_t
String	is_material_end_use_head_t

String	is_line_head_t
String	is_date_range_head_t
String	is_alloy_head_t
String	is_temper_head_t
String	is_scrap_type_head_t
String	is_sheet_type_head_t
String	is_customer_head_t
String	is_run_date_t

String	is_test
//Long		il_sum_processed, il_scrap_net
end variables

forward prototypes
public subroutine exporttoexcel (datawindow adw_dw, long al_rows)
public subroutine wf_add_2sql (long al_die_id, datetime adt_date_from, datetime adt_date_to)
public function long wf_rejected_coil_wt (long al_job, long al_coil_num)
public subroutine wf_set_display_values (long al_job, long al_row)
end prototypes

event type string ue_whoami();Return "w_report_production_downtime"
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

//If ll_report_rows <= 0 Then Return

////Get totals
//If ll_report_rows > 0 Then
//	//ls_sum_processed = String(adw_dw.Object.sum_processed_t[1], "###,###,###")
//	//ls_sum_scrap_net = String(adw_dw.Object.sum_crap_net_t[1], "###,###,###")
//	
//	ls_sum_net_wt = String(adw_dw.Object.sum_net_wt_t[1], "###,###,###")
//	ls_sum_tare_wt = String(adw_dw.Object.sum_tare_wt_t[1], "###,###,###")
//	ls_sum_theo_wt = String(adw_dw.Object.sum_theo_wt_t[1], "###,###,###")
//	
//	ls_run_date = is_run_date_t
//Else
//	Return
//End If

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
lole_OLE.cells[1,1] = "Customer"
lole_OLE.cells[1,2] = "Enduser"
lole_OLE.cells[1,3] = "Shift Num"
lole_OLE.cells[1,4] = "Schedule Type"
lole_OLE.cells[1,5] = "Shift Start Date/Time"
lole_OLE.cells[1,6] = "Shift End Date/Time"
lole_OLE.cells[1,7] = "Line Desc"
lole_OLE.cells[1,8] = "Job Num"
lole_OLE.cells[1,9] = "Order Item Desc"
lole_OLE.cells[1,10] = "Sheet Type"
lole_OLE.cells[1,11] = "Downtine Starting Date/Time"
lole_OLE.cells[1,12] = "Downtine Ending Date/Time"
lole_OLE.cells[1,13] = "Cause Name"
lole_OLE.cells[1,14] = "Duration"
lole_OLE.cells[1,15] = "Note"

//Insert Lines for Header & Miscellaneous Details (5 lines above columnar data)
lole_Sheet.Range("A1:N8").Select
lole_Sheet.Application.Selection.EntireRow.Insert 

lole_OLE.cells[1,1] = "Production Downtime Report"
lole_Sheet.Range("A1:A1").Select
lole_OLE.Selection.Font.Bold = True
lole_OLE.Selection.Font.Size = 24 //Change font size
lole_OLE.Selection.Font.Underline = True

//lole_OLE.cells[1,4] = "Run Date: " + String(Today(), "mm/dd/yyyy") + " " + String(Now(), "hh:mm:ss")
ls_run_date = is_run_date_t
lole_OLE.cells[1,5] = ls_run_date
lole_Sheet.Range("F1:F1").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[4,1] = is_date_range_head_t
lole_Sheet.Range("A4:A4").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[5,1] = is_customer_head_t
lole_Sheet.Range("A5:A5").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[6,1] = is_line_head_t
lole_Sheet.Range("A6:A6").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[7,1] = is_sheet_type_head_t
lole_Sheet.Range("A7:A7").Select
lole_OLE.Selection.Font.Bold = True

//lole_OLE.cells[4,1] = is_alloy_head_t
//lole_Sheet.Range("A4:A4").Select
//lole_OLE.Selection.Font.Bold = True
//
//lole_OLE.cells[5,1] = is_temper_head_t
//lole_Sheet.Range("A5:A5").Select
//lole_OLE.Selection.Font.Bold = True
//
//lole_OLE.cells[6,1] = is_scrap_type_head_t
//lole_Sheet.Range("A6:A6").Select
//lole_OLE.Selection.Font.Bold = True
//




////Insert 2 lines for totals (below columnar data)
//lole_OLE.cells[ll_report_rows + 10,4] = "Totals:"
//ls_range = "D" + String(ll_report_rows + 10) + ":" + "D" + String(ll_report_rows + 10)
//lole_Sheet.Range(ls_range).Select
//lole_OLE.Selection.Font.Bold = True
//
//lole_OLE.cells[ll_report_rows + 10,5] = String(ls_sum_net_wt)
//ls_range = "E" + String(ll_report_rows + 10) + ":" + "E" + String(ll_report_rows + 10)
//lole_Sheet.Range(ls_range).Select
//lole_OLE.Selection.Font.Bold = True

//lole_OLE.cells[ll_report_rows + 10,6] = String(ls_sum_tare_wt)
//ls_range = "F" + String(ll_report_rows + 10) + ":" + "F" + String(ll_report_rows + 10)
//lole_Sheet.Range(ls_range).Select
//lole_OLE.Selection.Font.Bold = True
//
//lole_OLE.cells[ll_report_rows + 10,7] = String(ls_sum_theo_wt)
//ls_range = "G" + String(ll_report_rows + 10) + ":" + "G" + String(ll_report_rows + 10)
//lole_Sheet.Range(ls_range).Select
//lole_OLE.Selection.Font.Bold = True

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

lole_Sheet.Range("A4:B" + String(ll_report_rows + 9)).Select
lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify

lole_Sheet.Range("C4:D" + String(ll_report_rows + 9)).Select
lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

lole_Sheet.Range("E4:G" + String(ll_report_rows + 9)).Select
lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify

lole_Sheet.Range("H4:H" + String(ll_report_rows + 9)).Select
lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

lole_Sheet.Range("K4:L" + String(ll_report_rows + 9)).Select
lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify

lole_Sheet.Range("N4:N" + String(ll_report_rows + 9)).Select
lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

lole_Sheet.Range("O4:O" + String(ll_report_rows + 9)).Select
lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify

//Change date format for a column
lole_Sheet.Range("E9:F" + String(ll_report_rows + 9)).Select
lole_OLE.Selection.NumberFormat = "mm/dd/yyyy hh:mm:ss"

lole_Sheet.Range("K9:L" + String(ll_report_rows + 9)).Select
lole_OLE.Selection.NumberFormat = "mm/dd/yyyy hh:mm:ss"

//Change number format for a column
lole_Sheet.Range("N9:N" + String(ll_report_rows + 9)).Select
lole_OLE.Selection.NumberFormat = "###,###,##0.000"

//Underline column headers
lole_Sheet.Range("A9:O9").Select
lole_OLE.Selection.Font.Underline = True

////Underline the 3 totals columns
//lole_OLE.Application.range ("E" + String(ll_report_rows + 9) + ":G" + String(ll_report_rows + 9)).borders(4).LineStyle = 1

//Increase column width
lole_Sheet.Range("A4:A4").Select
lole_OLE.Selection.ColumnWidth = 30

lole_Sheet.Range("B4:B4").Select
lole_OLE.Selection.ColumnWidth = 30

lole_Sheet.Range("E4:F4").Select
lole_OLE.Selection.ColumnWidth = 30

lole_Sheet.Range("K4:L4").Select
lole_OLE.Selection.ColumnWidth = 30

lole_Sheet.Range("O4:O4").Select
lole_OLE.Selection.ColumnWidth = 30

//---

ls_folder = ProfileString(gs_ini_file, "EMAIL","email_out","c:\temp\")

If Right(ls_folder, 1) <> "\" Then ls_folder = ls_folder + "\"
ls_file = ls_folder + "Production Downtime Report" + "_" + ls_today + ls_now + ".xls"

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

public subroutine wf_set_display_values (long al_job, long al_row);/*
Function:	wf_set_display_values
Returns:		none
Arguments:	value	long	al_jobString
				value	long	al_row
*/

String	ls_modstring, ls_processed_wt, ls_scrap_net
Long 		ll_l, ll_coilnet, ll_sheetnet, ll_scrapnet, ll_rejnet, ll_t, ll_l1, ll_l2
Long		ll_rebandedwt, ll_unprocessed_num, ll_unprocessednet
Long		ll_rows, ll_row, ll_coil_abc_num


ll_rows = dw_rejcoil_list.Retrieve(al_job)
ll_rows = dw_rebanded_list.Retrieve(al_job)

SELECT NVL(COUNT(coil_abc_num),0) INTO :ll_l
FROM process_coil
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "coil_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
//dw_report.Modify(ls_modstring) 

//Modified by Victor Huang in 04/05
SELECT NVL(COUNT(coil_abc_num),0) INTO :ll_unprocessed_num
FROM process_coil
WHERE ab_job_num = :al_job AND process_coil_status = 2	//for those coil applied but never used in this ab_job
USING SQLCA;

ll_l = ll_unprocessed_num
ls_modstring = "unproccoil_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
//dw_report.Modify(ls_modstring) 

SELECT NVL(SUM(process_quantity),0) INTO :ll_unprocessednet
FROM process_coil
WHERE ab_job_num = :al_job AND process_coil_status = 2	//for those coil applied but never used in this ab_job
USING SQLCA;

ll_l = ll_unprocessednet
ls_modstring = "unproccoil_net_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
//dw_report.Modify(ls_modstring) 

ll_l1 = dw_rejcoil_list.RowCount()
ll_l2 = dw_rebanded_list.RowCount()
ll_l = ll_l1 + ll_l2
ls_modstring = "rejcoil_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
//dw_report.Modify(ls_modstring) 
ll_rejnet = 0

IF ll_l1 > 0 THEN
	FOR ll_t = 1 TO ll_l1
		ll_rejnet = ll_rejnet + wf_rejected_coil_wt(al_job, dw_rejcoil_list.GetItemNumber(ll_t, "process_coil_coil_abc_num"))
	NEXT
	ls_modstring = "rejcoil_wt_t.Text = ~"" + String(ll_rejnet, "###,###,###") + "~""
	dw_rejcoil_list.Modify(ls_modstring) 
END IF
ll_rebandedwt = 0
IF ll_l2 > 0 THEN
	FOR ll_t = 1 TO ll_l2
		ll_rebandedwt = ll_rebandedwt + wf_rejected_coil_wt(al_job, dw_rebanded_list.GetItemNumber(ll_t, "process_coil_coil_abc_num"))
	NEXT
	ls_modstring = "rejcoil_wt_t.Text = ~"" + String(ll_rebandedwt, "###,###,###") + "~""
	dw_rebanded_list.Modify(ls_modstring) 
END IF
ll_rejnet = ll_rejnet + ll_rebandedwt
ls_modstring = "rejcoil_net_t.Text = ~"" + String(ll_rejnet, "###,###,###") + "~""
//dw_report.Modify(ls_modstring) 


SELECT NVL(COUNT(sheet_skid_num),0) INTO :ll_l
FROM sheet_skid
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "sheet_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
//dw_report.Modify(ls_modstring) 

SELECT NVL(COUNT(return_scrap_item_num),0) INTO :ll_l
FROM return_scrap_item
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "scrap_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
//dw_report.Modify(ls_modstring) 

SELECT NVL(SUM(process_quantity),0) INTO :ll_l
FROM process_coil
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "coil_net_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
//dw_report.Modify(ls_modstring) 
ll_coilnet = ll_l

If ll_coilnet <= 0 Then is_test = is_test + ", " + String(al_job)

SELECT NVL(SUM(prod_item_net_wt),0) INTO :ll_l
FROM production_sheet_item
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "sheet_net_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
//dw_report.Modify(ls_modstring) 
ll_sheetnet = ll_l

		SELECT NVL(SUM(return_item_net_wt),0) INTO :ll_l
		FROM return_scrap_item
		WHERE ab_job_num = :al_job
		USING SQLCA;
		ls_modstring = "scrap_net_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
		//dw_report.Modify(ls_modstring) 
		
		ls_scrap_net = String(ll_l, "###,###,###")
		dw_report.Object.scrap_net_t[al_row] = ls_scrap_net
		
		//il_scrap_net = il_scrap_net + ll_l //Accumulate scrap weight
		
		ll_scrapnet = ll_l

SELECT NVL(SUM(prod_item_pieces),0) INTO :ll_l
FROM production_sheet_item
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "sheet_pc_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
//dw_report.Modify(ls_modstring) 

SELECT SUM(sheet_tare_wt) INTO :ll_l
FROM sheet_skid
WHERE ab_job_num = :al_job
USING SQLCA;
ll_l = ll_l + ll_sheetnet
ls_modstring = "sheet_tare_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
//dw_report.Modify(ls_modstring) 

SELECT NVL(SUM(scrap_tare_wt),0) INTO :ll_l
FROM scrap_skid
WHERE scrap_ab_job_num = :al_job
USING SQLCA;
ll_l = ll_l + ll_scrapnet
ls_modstring = "scrap_tare_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
//dw_report.Modify(ls_modstring) 


ll_l = ll_sheetnet + ll_scrapnet + ll_rejnet + ll_unprocessednet - ll_coilnet 
ls_modstring = "off_t.Text = ~"" + String(ll_l, "###,###,##0") + "~""
//dw_report.Modify(ls_modstring) 
//ls_modstring = "off_per_t.Text = ~"( " + String((ll_l/ll_coilnet)*100, "#0.###") + "% )~""
//dw_report.Modify(ls_modstring) 

		//BEGIN Modified by Victor Huang in 04/06
		ls_modstring = "processed_t.Text = ~"" + String((ll_coilnet - ll_unprocessednet - ll_rejnet), "###,###,###") + "~""
		dw_report.Modify(ls_modstring)
		
		ls_processed_wt = String((ll_coilnet - ll_unprocessednet - ll_rejnet), "###,###,###")
		dw_report.Object.processed_t[al_row] = ls_processed_wt
		
		//il_sum_processed = il_sum_processed + ll_coilnet - ll_unprocessednet - ll_rejnet //Accumulate total processed weight
		
		//If al_job = 98504 Then
		//	MessageBox("", "ab_job_num = " + String(al_job) + &
		//						"~n~rll_coilnet = " + String(ll_coilnet) + &
		//						"~n~rll_unprocessednet = " + String(ll_unprocessednet) + &
		//						"~n~rll_rejnet = " + String(ll_rejnet) + &
		//						"~n~ril_sum_processed = " + String(il_sum_processed))
		//End If
		
		//END Modified by Victor Huang in 04/06

dw_report.SetItemStatus(al_row, 0, Primary!, NotModified!)
end subroutine

on w_report_production_downtime.create
int iCurrent
call super::create
this.cb_size=create cb_size
this.st_2=create st_2
this.dw_sheet_type_desc_lookup=create dw_sheet_type_desc_lookup
this.st_1=create st_1
this.dw_line=create dw_line
this.st_6=create st_6
this.dw_customer_lookup=create dw_customer_lookup
this.cb_export=create cb_export
this.dw_rebanded_list=create dw_rebanded_list
this.dw_rejcoil_list=create dw_rejcoil_list
this.st_note=create st_note
this.st_rowcount=create st_rowcount
this.cbx_all_dates=create cbx_all_dates
this.cb_1=create cb_1
this.st_all_dates=create st_all_dates
this.cb_retrieve=create cb_retrieve
this.em_from=create em_from
this.em_to=create em_to
this.st_from=create st_from
this.st_to=create st_to
this.cbx_dateall=create cbx_dateall
this.dw_report=create dw_report
this.cb_close=create cb_close
this.cb_print=create cb_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_size
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.dw_sheet_type_desc_lookup
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.dw_line
this.Control[iCurrent+6]=this.st_6
this.Control[iCurrent+7]=this.dw_customer_lookup
this.Control[iCurrent+8]=this.cb_export
this.Control[iCurrent+9]=this.dw_rebanded_list
this.Control[iCurrent+10]=this.dw_rejcoil_list
this.Control[iCurrent+11]=this.st_note
this.Control[iCurrent+12]=this.st_rowcount
this.Control[iCurrent+13]=this.cbx_all_dates
this.Control[iCurrent+14]=this.cb_1
this.Control[iCurrent+15]=this.st_all_dates
this.Control[iCurrent+16]=this.cb_retrieve
this.Control[iCurrent+17]=this.em_from
this.Control[iCurrent+18]=this.em_to
this.Control[iCurrent+19]=this.st_from
this.Control[iCurrent+20]=this.st_to
this.Control[iCurrent+21]=this.cbx_dateall
this.Control[iCurrent+22]=this.dw_report
this.Control[iCurrent+23]=this.cb_close
this.Control[iCurrent+24]=this.cb_print
end on

on w_report_production_downtime.destroy
call super::destroy
destroy(this.cb_size)
destroy(this.st_2)
destroy(this.dw_sheet_type_desc_lookup)
destroy(this.st_1)
destroy(this.dw_line)
destroy(this.st_6)
destroy(this.dw_customer_lookup)
destroy(this.cb_export)
destroy(this.dw_rebanded_list)
destroy(this.dw_rejcoil_list)
destroy(this.st_note)
destroy(this.st_rowcount)
destroy(this.cbx_all_dates)
destroy(this.cb_1)
destroy(this.st_all_dates)
destroy(this.cb_retrieve)
destroy(this.em_from)
destroy(this.em_to)
destroy(this.st_from)
destroy(this.st_to)
destroy(this.cbx_dateall)
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

st_note.Visible = False
cb_size.Visible = False

dw_report.SetTransObject(sqlca)
is_sql_orig = dw_report.GetSqlSelect() //Save the original SQL

ld_from_default = RelativeDate(Today(), -7) //7 days into the past
em_from.Text = String(ld_from_default)

//dw_line
li_rtn = dw_line.GetChild("line_num", ldwc)

If li_rtn = 1 Then //OK
	ldwc.SetTransObject(sqlca)
	ll_rows = ldwc.Retrieve()
	
	If ll_rows > 0 Then
		ll_row_inserted = ldwc.InsertRow(1)
		
		If ll_row_inserted > 0 Then
			ldwc.SetItem(ll_row_inserted, "line_desc", "ALL")
			dw_line.Object.line_num[1] = "ALL"
		End If
	End If
End If
//
////dw_alloy_lookup
//li_rtn = dw_alloy_lookup.GetChild("alloy2", ldwc)
//
//If li_rtn = 1 Then //OK
//	ldwc.SetTransObject(sqlca)
//	ll_rows = ldwc.Retrieve()
//	
//	If ll_rows > 0 Then
//		ll_row_inserted = ldwc.InsertRow(1)
//		
//		If ll_row_inserted > 0 Then
//			ldwc.SetItem(ll_row_inserted, "alloy2", "ALL")
//			dw_alloy_lookup.Object.alloy2[1] = "ALL"
//		End If
//	End If
//End If
//
////dw_temper_lookup
//li_rtn = dw_temper_lookup.GetChild("coil_temper", ldwc)
//
//If li_rtn = 1 Then //OK
//	ldwc.SetTransObject(sqlca)
//	ll_rows = ldwc.Retrieve()
//	
//	If ll_rows > 0 Then
//		ll_row_inserted = ldwc.InsertRow(1)
//		
//		If ll_row_inserted > 0 Then
//			ldwc.SetItem(ll_row_inserted, "coil_temper", "ALL")
//			dw_temper_lookup.Object.coil_temper[1] = "ALL"
//		End If
//	End If
//End If
//
////dw_scrap_type_lookup
//li_rtn = dw_scrap_type_lookup.GetChild("scrap_type", ldwc)
//
//If li_rtn = 1 Then //OK
//	ldwc.SetTransObject(sqlca)
//	ll_rows = ldwc.Retrieve()
//	
//	If ll_rows > 0 Then
//		ll_row_inserted = ldwc.InsertRow(1)
//		
//		If ll_row_inserted > 0 Then
//			ldwc.SetItem(ll_row_inserted, "scrap_type", "ALL")
//			dw_scrap_type_lookup.Object.scrap_type[1] = "ALL"
//		End If
//	End If
//End If

//dw_sheet_type_desc_lookup
li_rtn = dw_sheet_type_desc_lookup.GetChild("sheet_type", ldwc)

If li_rtn = 1 Then //OK
	ldwc.SetTransObject(sqlca)
	ll_rows = ldwc.Retrieve()
	
	If ll_rows > 0 Then
		ll_row_inserted = ldwc.InsertRow(1)
		
		If ll_row_inserted > 0 Then
			ldwc.SetItem(ll_row_inserted, "sheet_type", "ALL")
			dw_sheet_type_desc_lookup.Object.sheet_type[1] = "ALL"
		End If
	End If
End If

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
end event

event pfc_postopen;call super::pfc_postopen;This.Width = 5168
This.Height = 2400
This.X = 40

dw_report.Width = 5025
dw_report.Height = 1667

st_rowcount.Y = 2000

cb_retrieve.Y = 2100
cb_print.Y = 2100
cb_1.Y = 2100
cb_export.Y = 2100
cb_close.Y = 2100
cb_size.Y = 2100
end event

event pfc_preopen;call super::pfc_preopen;This.of_SetResize(True)

If IsValid(This.inv_resize) THEN
   This.inv_resize.of_SetOrigSize(4650, 2800)
	//This.inv_resize.of_Register(dw_report, "FixedToBottom")
	This.inv_resize.of_Register(st_rowcount, "FixedToBottom")

	This.inv_resize.of_Register(cb_print, "FixedToBottom")
	This.inv_resize.of_Register(cb_export, "FixedToBottom")
	This.inv_resize.of_Register(cb_1, "FixedToBottom")
	This.inv_resize.of_Register(cb_retrieve, "FixedToBottom")
	This.inv_resize.of_Register(cb_close, "FixedToBottom")
	This.inv_resize.of_Register(cb_size, "FixedToBottom")
End If
end event

type cb_size from commandbutton within w_report_production_downtime
integer x = 3536
integer y = 1613
integer width = 322
integer height = 90
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Size"
end type

event clicked;MessageBox("", "Window Width: " + String(Parent.Width) + &
	"~n~rWindow Height: " + String(Parent.Height) + &
	"~n~rWindow X= " + String(parent.X) + &
	"~n~rWindow Y= " + String(parent.Y) + &
	"~n~r~n~rdw_report Width: " + String(dw_report.Width) + &
	"~n~rdw_report Height: " + String(dw_report.Height) + &
	"~n~rdw_report X= " + String(dw_report.X) + &
	"~n~rdw_report Y= " + String(dw_report.Y))
end event

type st_2 from statictext within w_report_production_downtime
integer x = 2015
integer y = 115
integer width = 252
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
string text = "Sheet Type"
boolean focusrectangle = false
end type

type dw_sheet_type_desc_lookup from datawindow within w_report_production_downtime
integer x = 2019
integer y = 179
integer width = 417
integer height = 77
integer taborder = 20
string title = "none"
string dataobject = "d_sheet_type_desc_lookup"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.InsertRow(0)
end event

type st_1 from statictext within w_report_production_downtime
integer x = 1631
integer y = 115
integer width = 143
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
string text = "Line"
boolean focusrectangle = false
end type

type dw_line from datawindow within w_report_production_downtime
integer x = 1635
integer y = 179
integer width = 296
integer height = 77
integer taborder = 10
string title = "none"
string dataobject = "d_line_2"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.InsertRow(0)
end event

type st_6 from statictext within w_report_production_downtime
integer x = 761
integer y = 115
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

type dw_customer_lookup from datawindow within w_report_production_downtime
integer x = 764
integer y = 179
integer width = 775
integer height = 77
integer taborder = 30
string title = "none"
string dataobject = "d_customer_edge_trim"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_export from u_cb within w_report_production_downtime
integer x = 1382
integer y = 1610
integer width = 406
integer height = 93
integer taborder = 60
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

ls_file = "c:\temp\Production Downtime Report " + ls_date_from + "-" + ls_date_to + ".xls"

If dw_report.SaveAs(ls_file, Excel8!, True) = -1 Then
   MessageBox("Data SaveAs", "Error")
	Return -1
Else
	MessageBox("Success", "Data have been successfully exported to " + ls_file)
End If

Return 1
end event

type dw_rebanded_list from datawindow within w_report_production_downtime
boolean visible = false
integer x = 3562
integer y = 2163
integer width = 549
integer height = 320
integer taborder = 60
string title = "none"
string dataobject = "d_ab_job_reband_coil_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_rejcoil_list from datawindow within w_report_production_downtime
boolean visible = false
integer x = 2970
integer y = 2147
integer width = 549
integer height = 320
integer taborder = 50
string title = "none"
string dataobject = "d_ab_job_rej_coil_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_note from statictext within w_report_production_downtime
integer x = 761
integer y = 42
integer width = 523
integer height = 51
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 79741120
string text = "Can take a while..."
boolean focusrectangle = false
end type

type st_rowcount from statictext within w_report_production_downtime
integer x = 18
integer y = 1536
integer width = 3942
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

type cbx_all_dates from checkbox within w_report_production_downtime
integer x = 22
integer y = 38
integer width = 724
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "From the beginning of time"
end type

event clicked;If This.Checked = True Then
	st_from.Visible = False
	st_to.Visible = False
	em_from.Visible = False
	em_to.Visible = False
	st_note.Visible = True
Else
	st_from.Visible = True
	st_to.Visible = True
	em_from.Visible = True
	em_to.Visible = True
	st_note.Visible = False
End If
end event

type cb_1 from commandbutton within w_report_production_downtime
integer x = 947
integer y = 1610
integer width = 344
integer height = 93
integer taborder = 50
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

type st_all_dates from statictext within w_report_production_downtime
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

type cb_retrieve from commandbutton within w_report_production_downtime
integer x = 26
integer y = 1610
integer width = 351
integer height = 93
integer taborder = 30
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

event clicked;String				ls_line, ls_line_desc, ls_alloy, ls_temper, ls_scrap_type, ls_sheet_type_desc
String				ls_date_from, ls_date_to, ls_add_2sql_where, ls_sql_new, ls_customer_name
String				ls_find_string
Integer				li_rtn, li_line_num
Long					ll_rows, ll_found_row, ll_customer_id
DataWindowChild	ldwc

dw_report.AcceptText()

dw_line.AcceptText()
dw_sheet_type_desc_lookup.AcceptText()
dw_sheet_type_desc_lookup.AcceptText()
dw_customer_lookup.AcceptText()

li_rtn = dw_report.SetSqlSelect(is_sql_orig) //To start, restore the original SQL
ls_add_2sql_where = ""

If cbx_all_dates.Checked = True Then
	is_date_range_head_t = "Date Range: From the beginning of time"
Else
	ls_date_from = em_from.Text
	ls_date_to = em_to.Text
	
	If ls_date_from = ls_date_to Then
		is_date_range_head_t = "Shift Start: " + ls_date_from
	Else
		is_date_range_head_t = "Shift Start between " + ls_date_from + " and " + ls_date_to
	End If
	
	ls_add_2sql_where = ls_add_2sql_where + " and a.start_time between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + &
								" and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )  "
End If

ls_line = dw_line.Object.line_num[1]
If IsNull(ls_line) Then ls_line = "ALL"

If ls_line = "ALL" Then
	is_line_head_t = "All Lines"
Else
	ls_add_2sql_where = ls_add_2sql_where + " and a.line_num = " + ls_line
	
	//Get line description for report header
	li_rtn = dw_line.GetChild("line_num", ldwc)
	
	If li_rtn = 1 Then //OK
		ls_find_string = "line_num = " + ls_line
		ll_found_row = ldwc.Find(ls_find_string, 1, ldwc.RowCount())
		
		If ll_found_row > 0 Then
			ls_line_desc = ldwc.GetItemString(ll_found_row, "line_desc")
		End If
	Else
		ls_line_desc = ""
	End If
	
	is_line_head_t = "Line: " + ls_line_desc
End If

	

ls_sheet_type_desc = dw_sheet_type_desc_lookup.Object.sheet_type[1]

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
	ls_add_2sql_where = ls_add_2sql_where + " and h.orig_customer_id = " + String(ll_customer_id)
	is_customer_head_t = "Customer: " + ls_customer_name
End If



//If ls_alloy = "ALL" Then
//	is_alloy_head_t = "All Alloys"
//Else
//	ls_add_2sql_where = ls_add_2sql_where + " and order_item.alloy2 = '" + ls_alloy + "'"
//	is_alloy_head_t = "Alloy: " + ls_alloy
//End If
//
//If ls_temper = "ALL" Then
//	is_temper_head_t = "All Temper Codes"
//Else
//	ls_add_2sql_where = ls_add_2sql_where + " and order_item.temper = '" + ls_temper + "'"
//	is_temper_head_t = "Temper: " + ls_temper
//End If
//
//If ls_scrap_type = "ALL" Then
//	is_sheet_type_head_t = "All Scrap Handing Types"
//Else
//	ls_add_2sql_where = ls_add_2sql_where + " and customer_order.scrap_handing_type = '" + ls_scrap_type + "'"
//	is_scrap_type_head_t = "Scrap Handing Type: " + ls_scrap_type
//End If

If ls_sheet_type_desc = "ALL" Then
	is_sheet_type_head_t = "All Sheet Types"
Else
	ls_add_2sql_where = ls_add_2sql_where + " and ltrim(rtrim(lower(g.sheet_type))) = '" + Trim(Lower(ls_sheet_type_desc)) + "'"
	is_sheet_type_head_t = "Sheet Type: " + ls_sheet_type_desc
End If

//---

ls_sql_new = is_sql_orig + ls_add_2sql_where
ls_sql_new = ls_sql_new + " order by i.customer_short_name,  j.customer_short_name, a.SHIFT_NUM"

li_rtn = dw_report.SetSqlSelect(ls_sql_new)

ll_rows = dw_report.Retrieve()
end event

type em_from from editmask within w_report_production_downtime
integer x = 26
integer y = 179
integer width = 282
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

event constructor;This.Text = String(Today(), "mm/dd/yyyy")

end event

event modified;//Date	ld_date_from
//
//ld_date_from = Date(This.Text)
//
//If ld_date_from <= Date("01/01/2015") Then
//	This.Text = "01/01/2015"
//End If
end event

type em_to from editmask within w_report_production_downtime
integer x = 340
integer y = 179
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

event constructor;this.Text = String(Today(), "mm/dd/yyyy")

end event

type st_from from statictext within w_report_production_downtime
integer x = 26
integer y = 115
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

type st_to from statictext within w_report_production_downtime
integer x = 340
integer y = 115
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

type cbx_dateall from checkbox within w_report_production_downtime
boolean visible = false
integer x = 702
integer y = 128
integer width = 293
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "All Dates"
end type

event clicked;If This.Checked Then
	//This.Checked = False
	em_from.Enabled = False
	em_to.Enabled = False
	st_all_dates.Visible = True
Else
	//This.Checked = True
	em_from.Enabled = True
	em_to.Enabled = True
	st_all_dates.Visible = False
End If
end event

type dw_report from u_dw within w_report_production_downtime
integer y = 314
integer width = 3939
integer height = 1187
integer taborder = 10
string dataobject = "d_report_production_downtime"
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

is_run_date_t = "Run Date/Time: " + String(Today(), "mm/dd/yyyy hh:mm:ss")
ls_modstring = "run_date_t.Text = '" + is_run_date_t + "'"
ls_rtn = dw_report.Modify(ls_modstring)

//If This.RowCount() > 0 Then
//	is_run_date_t = This.Object.run_date_t[1]
//Else
//	is_run_date_t = "Run Date/Time: " + String(Today(), "mm/dd/yyyy hh:mm")
//End If

//Update retrieval arguments in report header
ls_modstring = "date_range_head_t.Text = '" + is_date_range_head_t + "'"
dw_report.Modify(ls_modstring)

ls_modstring = "line_head_t.Text = '" + is_line_head_t + "'"
dw_report.Modify(ls_modstring)

//ls_modstring = "alloy_head_t.Text = '" + is_alloy_head_t + "'"
//dw_report.Modify(ls_modstring)
//
//ls_modstring = "temper_head_t.Text = '" + is_temper_head_t + "'"
//dw_report.Modify(ls_modstring)
//
//ls_modstring = "scrap_type_head_t.Text = '" + is_scrap_type_head_t + "'"
//dw_report.Modify(ls_modstring)

ls_modstring = "sheet_type_head_t.Text = '" + is_sheet_type_head_t + "'"
dw_report.Modify(ls_modstring)

ls_modstring = "customer_short_name_head_t.Text = '" + is_customer_head_t + "'"
ls_rtn = dw_report.Modify(ls_modstring)

ls_modstring = "date_from_to_t.Text = '" + is_date_range_head_t + "'"
ls_rtn = dw_report.Modify(ls_modstring)

ll_rows = dw_report.RowCount()

If ll_rows = 1 Then
	st_rowcount.Text = "1 row retrieved"
Else
	st_rowcount.Text = String(rowcount) + " rows retrieved"
End If

////Update processed weight and scrap weight
//For ll_row = 1 To ll_rows
//	ll_ab_job_num = dw_report.Object.ab_job_ab_job_num[ll_row]
//	wf_set_display_values(ll_ab_job_num, ll_row)
//Next

SetPointer(oldpointer)
end event

type cb_close from u_cb within w_report_production_downtime
string tag = "Close without printing"
integer x = 2582
integer y = 1610
integer width = 351
integer height = 93
integer taborder = 40
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_print from u_cb within w_report_production_downtime
integer x = 486
integer y = 1610
integer width = 351
integer height = 93
integer taborder = 30
boolean bringtotop = true
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;dw_report.Event pfc_print()
end event

