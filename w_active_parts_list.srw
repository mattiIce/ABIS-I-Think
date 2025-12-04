$PBExportHeader$w_active_parts_list.srw
forward
global type w_active_parts_list from w_sheet
end type
type cb_1 from commandbutton within w_active_parts_list
end type
type cb_export from u_cb within w_active_parts_list
end type
type st_rowcount from statictext within w_active_parts_list
end type
type cb_retrieve from commandbutton within w_active_parts_list
end type
type st_32 from statictext within w_active_parts_list
end type
type dw_edge_trim_reqd from datawindow within w_active_parts_list
end type
type st_14 from statictext within w_active_parts_list
end type
type st_12 from statictext within w_active_parts_list
end type
type st_11 from statictext within w_active_parts_list
end type
type st_10 from statictext within w_active_parts_list
end type
type st_9 from statictext within w_active_parts_list
end type
type st_8 from statictext within w_active_parts_list
end type
type st_6 from statictext within w_active_parts_list
end type
type st_4 from statictext within w_active_parts_list
end type
type st_3 from statictext within w_active_parts_list
end type
type st_2 from statictext within w_active_parts_list
end type
type st_1 from statictext within w_active_parts_list
end type
type st_note from statictext within w_active_parts_list
end type
type st_to from statictext within w_active_parts_list
end type
type st_from from statictext within w_active_parts_list
end type
type em_to from editmask within w_active_parts_list
end type
type em_from from editmask within w_active_parts_list
end type
type cbx_all_dates from checkbox within w_active_parts_list
end type
type dw_die_name from datawindow within w_active_parts_list
end type
type dw_line_lookup from datawindow within w_active_parts_list
end type
type dw_scrap_handing_type from datawindow within w_active_parts_list
end type
type dw_sheet_type from datawindow within w_active_parts_list
end type
type dw_material_end_use from datawindow within w_active_parts_list
end type
type dw_order_item_desc from datawindow within w_active_parts_list
end type
type dw_enduser from datawindow within w_active_parts_list
end type
type dw_enduser_part_num from datawindow within w_active_parts_list
end type
type dw_sector from datawindow within w_active_parts_list
end type
type dw_customer from datawindow within w_active_parts_list
end type
type cb_close from u_cb within w_active_parts_list
end type
type cb_print from u_cb within w_active_parts_list
end type
type dw_report from u_dw within w_active_parts_list
end type
type r_1 from rectangle within w_active_parts_list
end type
end forward

global type w_active_parts_list from w_sheet
integer width = 4392
integer height = 2784
string title = "Active Parts List"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
cb_1 cb_1
cb_export cb_export
st_rowcount st_rowcount
cb_retrieve cb_retrieve
st_32 st_32
dw_edge_trim_reqd dw_edge_trim_reqd
st_14 st_14
st_12 st_12
st_11 st_11
st_10 st_10
st_9 st_9
st_8 st_8
st_6 st_6
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
st_note st_note
st_to st_to
st_from st_from
em_to em_to
em_from em_from
cbx_all_dates cbx_all_dates
dw_die_name dw_die_name
dw_line_lookup dw_line_lookup
dw_scrap_handing_type dw_scrap_handing_type
dw_sheet_type dw_sheet_type
dw_material_end_use dw_material_end_use
dw_order_item_desc dw_order_item_desc
dw_enduser dw_enduser
dw_enduser_part_num dw_enduser_part_num
dw_sector dw_sector
dw_customer dw_customer
cb_close cb_close
cb_print cb_print
dw_report dw_report
r_1 r_1
end type
global w_active_parts_list w_active_parts_list

type variables
String	is_sql_orig
String	is_run_date_t, is_date_range_head_t
String	is_sector_head_t, is_customer_head_t, is_enduser_head_t, is_enduser_part_head_t
String	is_die_head_t, is_line_head_t, is_order_item_desc_head_t, is_material_end_use_head_t
String	is_sheet_type_head_t, is_scrap_handling_type_head_t, is_edge_trim_reqd_head_t
String	is_date_from, is_date_to

String	is_sql_enduser_part_orig, is_sql_customer_list_orig, is_sql_enduser_list_orig
String	is_sql_order_item_desc_orig, is_sql_material_end_use_orig, is_sql_die_name_orig
String	is_sql_sheet_type_orig, is_sql_scrap_handling_type_orig, is_sql_sector_orig
String	is_sql_line_orig, is_sql_edge_trim_reqd_orig

end variables

forward prototypes
public subroutine exporttoexcel (datawindow adw_dw, long al_rows)
public subroutine wf_reset_report ()
public function integer wf_retrieve_customer_list (boolean ab_restore_user_selection)
public function integer wf_retrieve_die_name (boolean ab_restore_user_selection)
public function integer wf_retrieve_enduser_list (boolean ab_restore_user_selection)
public function integer wf_retrieve_enduser_parts (boolean ab_restore_user_selection)
public function integer wf_retrieve_material_end_use (boolean ab_restore_user_selection)
public function integer wf_retrieve_order_item_desc (boolean ab_restore_user_selection)
public function integer wf_retrieve_sheet_type (boolean ab_restore_user_selection)
public function integer wf_retrieve_blanking_line (boolean ab_restore_user_selection)
public function integer wf_retrieve_scrap_handling_type (boolean ab_restore_user_selection)
public subroutine wf_restore_user_selection (ref datawindow adw_parent_dw, ref datawindowchild adw_child_dw, string as_parent_dw_column_name, string as_child_dw_column_name, string as_user_selection)
public function integer wf_retrieve_sector (boolean ab_restore_user_selection)
public function integer wf_retrieve_edge_trim_reqd (boolean ab_restore_user_selection)
end prototypes

event type string ue_whoami();Return "w_active_parts_list"
end event

public subroutine exporttoexcel (datawindow adw_dw, long al_rows);//Alex Gerlants. Active_Parts_List. Begin
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

//Get totals
If ll_report_rows > 0 Then
	ls_run_date = is_run_date_t
Else
	Return
End If

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
lole_OLE.cells[1,1] = "Enduser Part Num"
lole_OLE.cells[1,2] = "Sector"
lole_OLE.cells[1,3] = "Customer Name"
lole_OLE.cells[1,4] = "Customer Po"
lole_OLE.cells[1,5] = "Enduser Name"
lole_OLE.cells[1,6] = "Enduser Po"
lole_OLE.cells[1,7] = "Order Item Desc"
lole_OLE.cells[1,8] = "Order Item Created Date"
lole_OLE.cells[1,9] = "Material End Use"
lole_OLE.cells[1,10] = "Sheet Type"
lole_OLE.cells[1,11] = "Scrap Handing"
lole_OLE.cells[1,12] = "Coil Edge Trim Req?"
lole_OLE.cells[1,13] = "Unit Weight"
lole_OLE.cells[1,14] = "Prod Line"
lole_OLE.cells[1,15] = "AB Die#"
lole_OLE.cells[1,16] = "Surface"
lole_OLE.cells[1,17] = "Flatness"
lole_OLE.cells[1,18] = "Alloy"
lole_OLE.cells[1,19] = "Temper"
lole_OLE.cells[1,20] = "Gauge"
lole_OLE.cells[1,21] = "Gauge Tol (+)"
lole_OLE.cells[1,22] = "Gauge Tol (-)"
lole_OLE.cells[1,23] = "Long Length"
lole_OLE.cells[1,24] = "Long Length Tol (+)"
lole_OLE.cells[1,25] = "Long Length Tol (-)"
lole_OLE.cells[1,26] = "Short Length"
lole_OLE.cells[1,27] = "Short Length Tol (+)"
lole_OLE.cells[1,28] = "Short Length Tol (-)"
lole_OLE.cells[1,29] = "Width"
lole_OLE.cells[1,30] = "Width Tol (+)"
lole_OLE.cells[1,31] = "Width Tol (-)"
lole_OLE.cells[1,32] = "PCs/Skid"
lole_OLE.cells[1,33] = "Unit Price"

//Insert Lines for Header & Miscellaneous Details (5 lines above columnar data)
lole_Sheet.Range("A1:AF15").Select
lole_Sheet.Application.Selection.EntireRow.Insert 

lole_OLE.cells[1,1] = "Active Parts List"
lole_Sheet.Range("A1:A1").Select
lole_OLE.Selection.Font.Bold = True
lole_OLE.Selection.Font.Size = 24 //Change font size
lole_OLE.Selection.Font.Underline = True

//lole_OLE.cells[1,4] = "Run Date: " + String(Today(), "mm/dd/yyyy") + " " + String(Now(), "hh:mm:ss")
lole_OLE.cells[1,3] = "Run Date/Time: " + ls_run_date
lole_Sheet.Range("D1:D1").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[3,1] = is_date_range_head_t
lole_Sheet.Range("A3:A3").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[4,1] = is_sector_head_t
lole_Sheet.Range("A4:A4").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[5,1] = is_customer_head_t
lole_Sheet.Range("A5:A5").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[6,1] = is_enduser_head_t
lole_Sheet.Range("A6:A6").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[7,1] = is_enduser_part_head_t
lole_Sheet.Range("A7:A7").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[8,1] = is_die_head_t
lole_Sheet.Range("A8:A8").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[9,1] = is_line_head_t
lole_Sheet.Range("A9:A9").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[10,1] = is_order_item_desc_head_t
lole_Sheet.Range("A10:A10").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[11,1] = is_material_end_use_head_t
lole_Sheet.Range("A11:A11").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[12,1] = is_sheet_type_head_t
lole_Sheet.Range("A12:A12").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[13,1] = is_scrap_handling_type_head_t
lole_Sheet.Range("A13:A13").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[14,1] = is_edge_trim_reqd_head_t
lole_Sheet.Range("A14:A14").Select
lole_OLE.Selection.Font.Bold = True

////Insert 2 lines for totals (below columnar data)
//lole_OLE.cells[ll_report_rows + 10,9] = "Totals:"
//ls_range = "I" + String(ll_report_rows + 10) + ":" + "I" + String(ll_report_rows + 10)
//lole_Sheet.Range(ls_range).Select
//lole_OLE.Selection.Font.Bold = True
//
//lole_OLE.cells[ll_report_rows + 10,10] = String(ls_sum_processed)
//ls_range = "J" + String(ll_report_rows + 10) + ":" + "J" + String(ll_report_rows + 10)
//lole_Sheet.Range(ls_range).Select
//lole_OLE.Selection.Font.Bold = True
//
//lole_OLE.cells[ll_report_rows + 10,11] = String(ls_sum_scrap_net)
//ls_range = "K" + String(ll_report_rows + 10) + ":" + "K" + String(ll_report_rows + 10)
//lole_Sheet.Range(ls_range).Select
//lole_OLE.Selection.Font.Bold = True

//---

SetPointer(HourGlass!)
ld_today = Today()
ld_now = Now()
ls_today = String(ld_today,"mmddyyyy")
ls_now = String(ld_now,"hhmmss")

////Delete extra columns	
//lole_Sheet.Columns("O:T").Select
//lole_OLE.Selection.Delete

//Justify
//lole_OLE.Selection.HorizontalAlignment = -4108 //Center
//lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
//lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

lole_Sheet.Range("L16:L" + String(ll_report_rows + 16)).Select
lole_OLE.Selection.HorizontalAlignment = -4108 //Center

lole_Sheet.Range("A16:K" + String(ll_report_rows + 16)).Select
lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify

lole_Sheet.Range("M16:M" + String(ll_report_rows + 16)).Select
lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

lole_Sheet.Range("N16:S" + String(ll_report_rows + 16)).Select
lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify

lole_Sheet.Range("T16:AG" + String(ll_report_rows + 16)).Select
lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

//Change date format for a column
lole_Sheet.Range("H16:H" + String(ll_report_rows + 16)).Select
lole_OLE.Selection.NumberFormat = "mm/dd/yyyy"

//Underline column headers
lole_Sheet.Range("A16:AG16").Select
lole_OLE.Selection.Font.Underline = True

////Draw border around column headers
//lole_OLE.Application.range ("J" + String(ll_report_rows + 9) + ":K" + String(ll_report_rows + 9)).borders(4).LineStyle = 1

//Increase column width
lole_Sheet.Range("A16:AF16").Select
lole_OLE.Selection.ColumnWidth = 30

lole_Sheet.Range("G4:G4").Select
lole_OLE.Selection.ColumnWidth = 47

lole_Sheet.Range("I4:I4").Select
lole_OLE.Selection.ColumnWidth = 47

lole_Sheet.Range("L4:L4").Select
lole_OLE.Selection.ColumnWidth = 18

lole_Sheet.Range("P4:Q4").Select
lole_OLE.Selection.ColumnWidth = 73

lole_Sheet.Range("R4:T4").Select
lole_OLE.Selection.ColumnWidth = 7

lole_Sheet.Range("U4:AG4").Select
lole_OLE.Selection.ColumnWidth = 18

//---

ls_folder = ProfileString(gs_ini_file, "EMAIL","email_out","c:\temp\")

If Right(ls_folder, 1) <> "\" Then ls_folder = ls_folder + "\"
ls_file = ls_folder + "Active Parts List_Formatted Order Created Date between " + is_date_from + " and " + is_date_to + ".xls"

//Check if ls_folder exists.
lb_directoryexists = DirectoryExists(ls_folder)

If Not lb_directoryexists Then //Folder ls_folder doesn't exist
	CreateDirectory(ls_folder) //Create ls_folder
End If

If FileExists(ls_file) Then FileDelete(ls_file)

lole_sheet.SaveAs(ls_file, Excel8!)

lole_OLE.application.Quit() //Close Excel application

//Open the worksheet for user to veiw?
li_answer = MessageBox("Open Worksheet?", "Would you like to open worksheet " + ls_file + "?", Question!, YesNo!, 1)

If li_answer = 1 Then //Yes
	lole_OLE.WorkBooks.Open(ls_file)
	lole_OLE.Application.Visible = True
Else
	lole_OLE.Application.Visible = False
End If

lole_OLE.DisconnectObject()
Destroy lole_OLE

lole_sheet.DisconnectObject()
Destroy lole_sheet

Garbagecollect() //This actually kills Excel Windows process
//Alex Gerlants. Active_Parts_List. End
end subroutine

public subroutine wf_reset_report ();/*
Function:	wf_reset_report
Returns:		none
Arguments:	none
*/
String	ls_modstring

dw_report.Reset()
st_rowcount.Text = ""

ls_modstring = "date_range_head_t.Text = ''"
dw_report.Modify(ls_modstring)

ls_modstring = "sector_head_t.Text = ''"
dw_report.Modify(ls_modstring)

ls_modstring = "customer_head_t.Text = ''"
dw_report.Modify(ls_modstring)

ls_modstring = "enduser_head_t.Text = ''"
dw_report.Modify(ls_modstring)

ls_modstring = "enduser_part_head_t.Text = ''"
dw_report.Modify(ls_modstring)

ls_modstring = "die_head_t.Text = ''"
dw_report.Modify(ls_modstring)

ls_modstring = "line_head_t.Text = ''"
dw_report.Modify(ls_modstring)

ls_modstring = "order_item_desc_head_t.Text = ''"
dw_report.Modify(ls_modstring)

ls_modstring = "material_end_use_head_t.Text = ''"
dw_report.Modify(ls_modstring)

ls_modstring = "sheet_type_head_t.Text = ''"
dw_report.Modify(ls_modstring)

ls_modstring = "scrap_handling_type_head_t.Text = ''"
dw_report.Modify(ls_modstring)

ls_modstring = "edge_trim_reqd_head_t.Text = ''"
dw_report.Modify(ls_modstring)
end subroutine

public function integer wf_retrieve_customer_list (boolean ab_restore_user_selection);/*
Function:	wf_retrieve_customer_list
Returns:		integer
Argumants:	value	boolean	ab_restore_user_selection <== Populate dw_customer with user selection. Select row in ldwc
*/

DataWindowChild	ldwc
Integer				li_rtn = 1
String				ls_date_from, ls_date_to
String				ls_user_selection

ls_user_selection = dw_customer.Object.customer_short_name[1]

ls_date_from = em_from.Text
ls_date_to = em_to.Text

li_rtn = dw_customer.GetChild("customer_short_name", ldwc)

//Retrieve End User Part list
If li_rtn = 1 And is_sql_customer_list_orig <> "" Then
	li_rtn = f_retrieve_child_dw(	dw_customer, &
											ldwc, &
											"customer_short_name", &
											"customer_short_name", &
											is_sql_customer_list_orig, &
											" and ( customer_order.created_date between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + " and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )" + " or " + "(order_item.item_created_dttm between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + " and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )" + " ))" + " order by customer.customer_short_name", &
											sqlca, &
											True, &
											True)
	
	If ab_restore_user_selection Then
		wf_restore_user_selection(	dw_customer, &
											ldwc, &
											"customer_short_name", &
											"customer_id", &
											ls_user_selection )
	End If
											
End If

Return li_rtn
end function

public function integer wf_retrieve_die_name (boolean ab_restore_user_selection);/*
Function:	wf_retrieve_die_name
Returns:		integer
Argumants:	value	boolean	ab_restore_user_selection <== Populate dw_customer with user selection. Select row in ldwc
*/

DataWindowChild	ldwc
Integer				li_rtn = 1
Long					ll_found_row, ll_rows, ll_pos
String				ls_date_from, ls_date_to, ls_find_string, ls_sort_string
String				ls_user_selection

ls_user_selection = dw_die_name.Object.die_name[dw_die_name.GetRow()]

ls_date_from = em_from.Text
ls_date_to = em_to.Text

li_rtn = dw_die_name.GetChild("die_name", ldwc)

//Retrieve End User Part list
If li_rtn = 1 And is_sql_die_name_orig <> "" Then
	li_rtn = f_retrieve_child_dw(	dw_die_name, &
											ldwc, &
											"die_name", &
											"die_name", &
											is_sql_die_name_orig, &
											" and ( customer_order.created_date between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + " and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )" + " or " + "(order_item.item_created_dttm between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + " and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )" + " ))", &
											sqlca, &
											True, &
											True)
											
	//Get rid of 1 row with value of "NULL VALUE". It is populated in dbo.f_get_die_name_4order_item()
	//ldwc.Print() //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY
	ll_rows = ldwc.RowCount()
	ls_find_string = "die_name = 'NULL VALUE'"
	ll_found_row = ldwc.Find(ls_find_string, 1, ll_rows)
	
	If ll_found_row > 0 Then
		ldwc.DeleteRow(ll_found_row)
		
		ls_sort_string = "Integer(Right(  die_name, Len(die_name) - Pos(die_name, ' ', 1)  )) Asc"
		li_rtn = ldwc.SetSort(ls_sort_string)
		li_rtn = ldwc.Sort()
	End If
	
	If ab_restore_user_selection Then
		wf_restore_user_selection(	dw_die_name, &
											ldwc, &
											"die_name", &
											"die_name", &
											ls_user_selection )
	End If
	
End If

Return li_rtn
end function

public function integer wf_retrieve_enduser_list (boolean ab_restore_user_selection);/*
Function:	wf_retrieve_enduser_list
Returns:		integer
Argumants:	value	boolean	ab_restore_user_selection <== Populate dw_customer with user selection. Select row in ldwc
*/

DataWindowChild	ldwc
Integer				li_rtn = 1
String				ls_date_from, ls_date_to
String				ls_user_selection

ls_user_selection = dw_customer.Object.customer_short_name[1]

ls_date_from = em_from.Text
ls_date_to = em_to.Text

li_rtn = dw_enduser.GetChild("customer_short_name", ldwc)

//Retrieve End User Part list
If li_rtn = 1 And is_sql_enduser_list_orig <> "" Then
	li_rtn = f_retrieve_child_dw(	dw_enduser, &
											ldwc, &
											"customer_short_name", &
											"customer_short_name", &
											is_sql_enduser_list_orig, &
											" and ( customer_order.created_date between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + " and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )" + " or " + "(order_item.item_created_dttm between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + " and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )" + " ))" + " order by customer.customer_short_name", &
											sqlca, &
											True, &
											True)
											
	If ab_restore_user_selection Then
		wf_restore_user_selection(	dw_enduser, &
											ldwc, &
											"customer_short_name", &
											"customer_id", &
											ls_user_selection )
	End If											
End If

Return li_rtn
end function

public function integer wf_retrieve_enduser_parts (boolean ab_restore_user_selection);/*
Function:	wf_retrieve_enduser_parts
Returns:		integer
Argumants:	value	boolean	ab_restore_user_selection <== Populate dw_customer with user selection. Select row in ldwc
*/

DataWindowChild	ldwc
Integer				li_rtn = 1
String				ls_date_from, ls_date_to, ls_user_selection

ls_user_selection = dw_enduser_part_num.Object.enduser_part_num[dw_enduser_part_num.GetRow()]

ls_date_from = em_from.Text
ls_date_to = em_to.Text

li_rtn = dw_enduser_part_num.GetChild("enduser_part_num", ldwc)

//Retrieve End User Part list
If li_rtn = 1 And is_sql_enduser_part_orig <> "" Then
	li_rtn = f_retrieve_child_dw(	dw_enduser_part_num, &
											ldwc, &
											"enduser_part_num", &
											"enduser_part_num", &
											is_sql_enduser_part_orig, &
											" and ( customer_order.created_date between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + " and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )" + " or " + "(order_item.item_created_dttm between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + " and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )" + " ))" + " order by enduser_part_num", &
											sqlca, &
											True, &
											True)
											
	If ab_restore_user_selection Then
		wf_restore_user_selection(	dw_enduser_part_num, &
											ldwc, &
											"enduser_part_num", &
											"enduser_part_num", &
											ls_user_selection )
	End If
End If

Return li_rtn
end function

public function integer wf_retrieve_material_end_use (boolean ab_restore_user_selection);/*
Function:	wf_retrieve_material_end_use
Returns:		integer
Argumants:	value	boolean	ab_restore_user_selection <== Populate dw_customer with user selection. Select row in ldwc
*/

DataWindowChild	ldwc
Integer				li_rtn = 1
String				ls_date_from, ls_date_to
String				ls_user_selection

ls_user_selection = dw_material_end_use.Object.material_end_use[dw_material_end_use.GetRow()]

ls_date_from = em_from.Text
ls_date_to = em_to.Text

li_rtn = dw_material_end_use.GetChild("material_end_use", ldwc)

//Retrieve End User Part list
If li_rtn = 1 And is_sql_material_end_use_orig <> "" Then
	li_rtn = f_retrieve_child_dw(	dw_material_end_use, &
											ldwc, &
											"material_end_use", &
											"material_end_use", &
											is_sql_material_end_use_orig, &
											" and ( customer_order.created_date between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + " and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )" + " or " + "(order_item.item_created_dttm between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + " and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )" + " ))" + " order by rtrim(ltrim(order_item.material_end_use))", &
											sqlca, &
											True, &
											True)
											
	If ab_restore_user_selection Then
		wf_restore_user_selection(	dw_material_end_use, &
											ldwc, &
											"material_end_use", &
											"material_end_use", &
											ls_user_selection )
	End If
End If

Return li_rtn
end function

public function integer wf_retrieve_order_item_desc (boolean ab_restore_user_selection);/*
Function:	wf_retrieve_order_item_desc
Returns:		integer
Argumants:	value	boolean	ab_restore_user_selection <== Populate dw_customer with user selection. Select row in ldwc
*/

DataWindowChild	ldwc
Integer				li_rtn = 1
String				ls_date_from, ls_date_to
String				ls_user_selection

ls_user_selection = dw_order_item_desc.Object.order_item_desc[dw_order_item_desc.GetRow()]

ls_date_from = em_from.Text
ls_date_to = em_to.Text

li_rtn = dw_order_item_desc.GetChild("order_item_desc", ldwc)

//Retrieve End User Part list
If li_rtn = 1 And is_sql_customer_list_orig <> "" Then
	li_rtn = f_retrieve_child_dw(	dw_order_item_desc, &
											ldwc, &
											"order_item_desc", &
											"order_item_desc", &
											is_sql_order_item_desc_orig, &
											" and ( customer_order.created_date between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + " and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )" + " or " + "(order_item.item_created_dttm between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + " and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )" + " ))" + " order by order_item.order_item_desc", &
											sqlca, &
											True, &
											True)
											
	If ab_restore_user_selection Then
		wf_restore_user_selection(	dw_order_item_desc, &
											ldwc, &
											"order_item_desc", &
											"order_item_desc", &
											ls_user_selection )
	End If
End If

Return li_rtn
end function

public function integer wf_retrieve_sheet_type (boolean ab_restore_user_selection);/*
Function:	wf_retrieve_sheet_type
Returns:		integer
Argumants:	value	boolean	ab_restore_user_selection <== Populate dw_customer with user selection. Select row in ldwc
*/

DataWindowChild	ldwc
Integer				li_rtn = 1
String				ls_date_from, ls_date_to
String				ls_user_selection

ls_user_selection = dw_sheet_type.Object.sheet_type[dw_sheet_type.GetRow()]

ls_date_from = em_from.Text
ls_date_to = em_to.Text

li_rtn = dw_sheet_type.GetChild("sheet_type", ldwc)

//Retrieve End User Part list
If li_rtn = 1 And is_sql_sheet_type_orig <> "" Then
	li_rtn = f_retrieve_child_dw(	dw_sheet_type, &
											ldwc, &
											"sheet_type", &
											"sheet_type", &
											is_sql_sheet_type_orig, &
											" and ( customer_order.created_date between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + " and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )" + " or " + "(order_item.item_created_dttm between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + " and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )" + " ))" + " order by ltrim(rtrim(order_item.sheet_type))", &
											sqlca, &
											True, &
											True)
											
	If ab_restore_user_selection Then
		wf_restore_user_selection(	dw_sheet_type, &
											ldwc, &
											"sheet_type", &
											"sheet_type", &
											ls_user_selection )
	End If
End If

Return li_rtn
end function

public function integer wf_retrieve_blanking_line (boolean ab_restore_user_selection);/*
Function:	wf_retrieve_blanking_line
Returns:		integer
Argumants:	value	boolean	ab_restore_user_selection <== Populate dw_customer with user selection. Select row in ldwc
*/
DataWindowChild	ldwc
Integer				li_rtn = 1
Long					ll_rows, ll_row_inserted, ll_found_row
String				ls_date_from, ls_date_to
String				ls_user_selection, ls_find_string

ls_user_selection = dw_line_lookup.Object.cust_order_line_note[dw_line_lookup.GetRow()]

ls_date_from = em_from.Text
ls_date_to = em_to.Text

li_rtn = dw_line_lookup.GetChild("cust_order_line_note", ldwc)

If li_rtn = 1 Then //OK
	li_rtn = f_retrieve_child_dw(	dw_line_lookup, &
											ldwc, &
											"cust_order_line_note", &
											"cust_order_line_note", &
											is_sql_line_orig, &
											" and ( customer_order.created_date between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + " and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )" + " or " + "(order_item.item_created_dttm between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + " and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )" + " ))" + " order by to_number(substr(ltrim(rtrim('BL ' || customer_order.cust_order_line_note)), instr(ltrim(rtrim('BL ' || customer_order.cust_order_line_note)),' ', 1, 1) + 1, length(ltrim(rtrim('BL ' || customer_order.cust_order_line_note))) - instr(ltrim(rtrim('BL ' || customer_order.cust_order_line_note)),' ', 1, 1)))", &
											sqlca, &
											False, &
											True)
											
	ls_find_string = "cust_order_line_note = 'BL 0'"
	ll_found_row = ldwc.Find(ls_find_string, 1, ldwc.RowCount())
	
	If ll_found_row > 0 Then
		ldwc.SetItem(ll_found_row,"cust_order_line_note", "None")
	End If
	
	If ab_restore_user_selection Then
		wf_restore_user_selection(	dw_line_lookup, &
											ldwc, &
											"cust_order_line_note", &
											"cust_order_line_note", &
											ls_user_selection )
	End If
	
	If ab_restore_user_selection Then
		wf_restore_user_selection(	dw_line_lookup, &
											ldwc, &
											"cust_order_line_note", &
											"cust_order_line_note", &
											ls_user_selection )
	End If
End If

Return li_rtn
end function

public function integer wf_retrieve_scrap_handling_type (boolean ab_restore_user_selection);/*
Function:	wf_retrieve_scrap_handling_type
Returns:		integer
Argumants:	value	boolean	ab_restore_user_selection <== Populate dw_customer with user selection. Select row in ldwc
*/

DataWindowChild	ldwc
Integer				li_rtn = 1
String				ls_date_from, ls_date_to
String				ls_user_selection

ls_user_selection = dw_scrap_handing_type.Object.scrap_handing_type[dw_scrap_handing_type.GetRow()]

ls_date_from = em_from.Text
ls_date_to = em_to.Text

li_rtn = dw_scrap_handing_type.GetChild("scrap_handing_type", ldwc)

//Retrieve End User Part list
If li_rtn = 1 And is_sql_scrap_handling_type_orig <> "" Then
	li_rtn = f_retrieve_child_dw(	dw_scrap_handing_type, &
											ldwc, &
											"scrap_handing_type", &
											"scrap_handing_type", &
											is_sql_scrap_handling_type_orig, &
											" and ( customer_order.created_date between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + " and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )" + " or " + "(order_item.item_created_dttm between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + " and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )" + " ))" + " order by nvl(ltrim(rtrim(customer_order.scrap_handing_type)), '')", &
											sqlca, &
											True, &
											True)
											
	If ab_restore_user_selection Then
		wf_restore_user_selection(	dw_scrap_handing_type, &
											ldwc, &
											"scrap_handing_type", &
											"scrap_handing_type", &
											ls_user_selection )
	End If
End If

Return li_rtn
end function

public subroutine wf_restore_user_selection (ref datawindow adw_parent_dw, ref datawindowchild adw_child_dw, string as_parent_dw_column_name, string as_child_dw_column_name, string as_user_selection);/*
Function:	wf_restore_user_selection
Returns:		none
Arguments:	reference	datawindow			adw_parent_dw
				reference	datawindowchild	adw_child_dw
				value			string				as_parent_dw_column_name
				value			string				as_child_dw_column_name
				value			string				as_user_selection
*/
String	ls_find_string
Long		ll_child_rows, ll_found_row

If as_user_selection <> "ALL" Then
	ll_child_rows = adw_child_dw.RowCount()

	If IsNumber(as_user_selection) Then
		ls_find_string = as_child_dw_column_name + " = " + as_user_selection
	Else
		ls_find_string = as_child_dw_column_name + " = '" + as_user_selection + "'"
	End If
	
	ll_found_row = adw_child_dw.Find(ls_find_string, 1, ll_child_rows)
	
	If ll_found_row > 0 Then
		adw_parent_dw.SetItem(1, as_parent_dw_column_name, as_user_selection)
		adw_child_dw.SelectRow(ll_found_row, True)
		adw_child_dw.ScrollToRow(ll_found_row)
	End If
End If
end subroutine

public function integer wf_retrieve_sector (boolean ab_restore_user_selection);/*
Function:	wf_retrieve_sector
Returns:		integer
Argumants:	value	boolean	ab_restore_user_selection <== Populate dw_customer with user selection. Select row in ldwc
*/

DataWindowChild	ldwc
Integer				li_rtn = 1
String				ls_date_from, ls_date_to, ls_user_selection
Any					la_user_selection

ls_user_selection = dw_sector.Object.sector_desc[1]
If IsNull(ls_user_selection) Then ls_user_selection = "ALL"

ls_date_from = em_from.Text
ls_date_to = em_to.Text

li_rtn = dw_sector.GetChild("sector_desc", ldwc)

//Retrieve End User Part list
If li_rtn = 1 And is_sql_sector_orig <> "" Then
	li_rtn = f_retrieve_child_dw(	dw_sector, &
											ldwc, &
											"sector_desc", &
											"sector_desc", &
											is_sql_sector_orig, &
											" and ( customer_order.created_date between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + " and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )" + " or " + "(order_item.item_created_dttm between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + " and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )" + " ))" + " order by sector.sector_desc", &
											sqlca, &
											True, &
											True)
	
	If ab_restore_user_selection Then
		wf_restore_user_selection(	dw_sector, &
											ldwc, &
											"sector_desc", &
											"sector_code", &
											ls_user_selection )
	End If
											
End If

Return li_rtn
end function

public function integer wf_retrieve_edge_trim_reqd (boolean ab_restore_user_selection);/*
Function:	wf_retrieve_edge_trim_reqd
Returns:		integer
Argumants:	value	boolean	ab_restore_user_selection <== Populate dw_customer with user selection. Select row in ldwc
*/

DataWindowChild	ldwc
Integer				li_rtn = 1
String				ls_date_from, ls_date_to
String				ls_user_selection

ls_user_selection = dw_edge_trim_reqd.Object.edge_trim_reqd[dw_edge_trim_reqd.GetRow()]

ls_date_from = em_from.Text
ls_date_to = em_to.Text

li_rtn = dw_edge_trim_reqd.GetChild("edge_trim_reqd", ldwc)

//Retrieve End User Part list
If li_rtn = 1 And is_sql_edge_trim_reqd_orig <> "" Then
	li_rtn = f_retrieve_child_dw(	dw_edge_trim_reqd, &
											ldwc, &
											"edge_trim_reqd", &
											"edge_trim_reqd", &
											is_sql_edge_trim_reqd_orig, &
											" and ( customer_order.created_date between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + " and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )" + " or " + "(order_item.item_created_dttm between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + " and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )" + " ))" + " order by nvl(order_item.trimming_required, 'N')", &
											sqlca, &
											True, &
											True)
											
	If ab_restore_user_selection Then
		wf_restore_user_selection(	dw_edge_trim_reqd, &
											ldwc, &
											"edge_trim_reqd", &
											"edge_trim_reqd", &
											ls_user_selection )
	End If
End If

Return li_rtn
end function

on w_active_parts_list.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_export=create cb_export
this.st_rowcount=create st_rowcount
this.cb_retrieve=create cb_retrieve
this.st_32=create st_32
this.dw_edge_trim_reqd=create dw_edge_trim_reqd
this.st_14=create st_14
this.st_12=create st_12
this.st_11=create st_11
this.st_10=create st_10
this.st_9=create st_9
this.st_8=create st_8
this.st_6=create st_6
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.st_note=create st_note
this.st_to=create st_to
this.st_from=create st_from
this.em_to=create em_to
this.em_from=create em_from
this.cbx_all_dates=create cbx_all_dates
this.dw_die_name=create dw_die_name
this.dw_line_lookup=create dw_line_lookup
this.dw_scrap_handing_type=create dw_scrap_handing_type
this.dw_sheet_type=create dw_sheet_type
this.dw_material_end_use=create dw_material_end_use
this.dw_order_item_desc=create dw_order_item_desc
this.dw_enduser=create dw_enduser
this.dw_enduser_part_num=create dw_enduser_part_num
this.dw_sector=create dw_sector
this.dw_customer=create dw_customer
this.cb_close=create cb_close
this.cb_print=create cb_print
this.dw_report=create dw_report
this.r_1=create r_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_export
this.Control[iCurrent+3]=this.st_rowcount
this.Control[iCurrent+4]=this.cb_retrieve
this.Control[iCurrent+5]=this.st_32
this.Control[iCurrent+6]=this.dw_edge_trim_reqd
this.Control[iCurrent+7]=this.st_14
this.Control[iCurrent+8]=this.st_12
this.Control[iCurrent+9]=this.st_11
this.Control[iCurrent+10]=this.st_10
this.Control[iCurrent+11]=this.st_9
this.Control[iCurrent+12]=this.st_8
this.Control[iCurrent+13]=this.st_6
this.Control[iCurrent+14]=this.st_4
this.Control[iCurrent+15]=this.st_3
this.Control[iCurrent+16]=this.st_2
this.Control[iCurrent+17]=this.st_1
this.Control[iCurrent+18]=this.st_note
this.Control[iCurrent+19]=this.st_to
this.Control[iCurrent+20]=this.st_from
this.Control[iCurrent+21]=this.em_to
this.Control[iCurrent+22]=this.em_from
this.Control[iCurrent+23]=this.cbx_all_dates
this.Control[iCurrent+24]=this.dw_die_name
this.Control[iCurrent+25]=this.dw_line_lookup
this.Control[iCurrent+26]=this.dw_scrap_handing_type
this.Control[iCurrent+27]=this.dw_sheet_type
this.Control[iCurrent+28]=this.dw_material_end_use
this.Control[iCurrent+29]=this.dw_order_item_desc
this.Control[iCurrent+30]=this.dw_enduser
this.Control[iCurrent+31]=this.dw_enduser_part_num
this.Control[iCurrent+32]=this.dw_sector
this.Control[iCurrent+33]=this.dw_customer
this.Control[iCurrent+34]=this.cb_close
this.Control[iCurrent+35]=this.cb_print
this.Control[iCurrent+36]=this.dw_report
this.Control[iCurrent+37]=this.r_1
end on

on w_active_parts_list.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_export)
destroy(this.st_rowcount)
destroy(this.cb_retrieve)
destroy(this.st_32)
destroy(this.dw_edge_trim_reqd)
destroy(this.st_14)
destroy(this.st_12)
destroy(this.st_11)
destroy(this.st_10)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_6)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_note)
destroy(this.st_to)
destroy(this.st_from)
destroy(this.em_to)
destroy(this.em_from)
destroy(this.cbx_all_dates)
destroy(this.dw_die_name)
destroy(this.dw_line_lookup)
destroy(this.dw_scrap_handing_type)
destroy(this.dw_sheet_type)
destroy(this.dw_material_end_use)
destroy(this.dw_order_item_desc)
destroy(this.dw_enduser)
destroy(this.dw_enduser_part_num)
destroy(this.dw_sector)
destroy(this.dw_customer)
destroy(this.cb_close)
destroy(this.cb_print)
destroy(this.dw_report)
destroy(this.r_1)
end on

event open;call super::open;Integer				li_rtn_customer, li_rtn
Long					ll_rows, ll_row_inserted
DataWindowChild	ldwc, ldwc_customer, ldwc_enduser, ldwc_sector
Date					ld_from_default
String				ls_date_from, ls_date_t, ls_sql_sector_orig

st_note.Visible = False
cbx_all_dates.Visible = False

dw_report.SetTransObject(sqlca)
is_sql_orig = dw_report.GetSqlSelect() //Save the original SQL

ld_from_default = RelativeDate(Today(), -30) //30 days into the past
em_from.Text = String(ld_from_default)

//dw_sector
dw_sector.InsertRow(0)

li_rtn = dw_sector.GetChild("sector_desc", ldwc)

If li_rtn = 1 Then //OK
	is_sql_sector_orig = ldwc.GetSqlSelect()
	//is_sql_sector_orig = ls_sql_sector_orig
	
	If is_sql_sector_orig <> "" Then
		wf_retrieve_sector(False)
	End If
End If

//dw_customer
dw_customer.InsertRow(0)

li_rtn = dw_customer.GetChild("customer_short_name", ldwc)

If li_rtn = 1 Then //OK
	is_sql_customer_list_orig = ldwc.GetSqlSelect()

	If is_sql_customer_list_orig <> "" Then
		wf_retrieve_customer_list(False)
	End if
End If

//dw_enduser
dw_enduser.InsertRow(0)

li_rtn = dw_enduser.GetChild("customer_short_name", ldwc)

If li_rtn = 1 Then //OK
	is_sql_enduser_list_orig = ldwc.GetSqlSelect()

	If is_sql_enduser_list_orig <> "" Then
		wf_retrieve_enduser_list(False)
	End if
End If

//dw_enduser_part_num
ll_row_inserted = dw_enduser_part_num.InsertRow(0)

li_rtn = dw_enduser_part_num.GetChild("enduser_part_num", ldwc)

If li_rtn = 1 Then //OK

	is_sql_enduser_part_orig = ldwc.GetSqlSelect()
	
	If is_sql_enduser_part_orig <> "" Then
		wf_retrieve_enduser_parts(False)
	End If
End If

//dw_die_name
dw_die_name.InsertRow(0)

li_rtn = dw_die_name.GetChild("die_name", ldwc)

If li_rtn = 1 Then //OK
	is_sql_die_name_orig = ldwc.GetSqlSelect()
	wf_retrieve_die_name(False)
End If

//dw_line_lookup. This is Blanking Line
dw_line_lookup.InsertRow(0)

li_rtn = dw_line_lookup.GetChild("cust_order_line_note", ldwc)

If li_rtn = 1 Then //OK
	is_sql_line_orig = ldwc.GetSqlSelect()
	wf_retrieve_blanking_line(False)
End If

//dw_order_item_desc
dw_order_item_desc.InsertRow(0)

li_rtn = dw_order_item_desc.GetChild("order_item_desc", ldwc)

If li_rtn = 1 Then //OK
	is_sql_order_item_desc_orig = ldwc.GetSqlSelect()

	wf_retrieve_order_item_desc(False)
End If

//dw_material_end_use
dw_material_end_use.InsertRow(0)

li_rtn = dw_material_end_use.GetChild("material_end_use", ldwc)

If li_rtn = 1 Then //OK
	is_sql_material_end_use_orig = ldwc.GetSqlSelect()
	wf_retrieve_material_end_use(False)
End If

//dw_sheet_type
dw_sheet_type.InsertRow(0)

li_rtn = dw_sheet_type.GetChild("sheet_type", ldwc)

If li_rtn = 1 Then //OK
	is_sql_sheet_type_orig = ldwc.GetSqlSelect()
	wf_retrieve_sheet_type(False)
End If

//dw_scrap_handing_type
dw_scrap_handing_type.InsertRow(0)

li_rtn = dw_scrap_handing_type.GetChild("scrap_handing_type", ldwc)

If li_rtn = 1 Then //OK
	is_sql_scrap_handling_type_orig = ldwc.GetSqlSelect()
	wf_retrieve_scrap_handling_type(False)
End If

//dw_edge_trim_reqd
dw_edge_trim_reqd.InsertRow(0)

li_rtn = dw_edge_trim_reqd.GetChild("edge_trim_reqd", ldwc)

If li_rtn = 1 Then //OK
	is_sql_edge_trim_reqd_orig = ldwc.GetSqlSelect()
	wf_retrieve_edge_trim_reqd(False)
End If
end event

type cb_1 from commandbutton within w_active_parts_list
integer x = 1072
integer y = 2598
integer width = 344
integer height = 93
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Open in Excel"
end type

event clicked;Integer 		li_result
OLEObject	myoleobject

myoleobject = Create OLEObject

li_result = myoleobject.ConnectToObject("", "excel.application")
	 
Choose Case li_result
	Case 0 //Excel is open	
		MessageBox("Excel process is running", "If you have Excel spreadsheet open, please save it now.~n~rIt will be forcibly closed.")
		
		Do While li_result = 0
			Run("C:\abis\killexcel.bat", Minimized!) //Kill some hanging Excel tasks
			li_result = myoleobject.ConnectToObject("", "excel.application")
		Loop
		
		Sleep(1)
	Case -5 //Excel process is NOT running
		//
End Choose

If IsValid(myoleobject) Then Destroy myoleobject

Parent.ExportToExcel( dw_report, dw_report.RowCount() )

end event

type cb_export from u_cb within w_active_parts_list
integer x = 534
integer y = 2598
integer width = 406
integer height = 93
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Export to Excel"
end type

event clicked;call super::clicked;String	ls_date_from, ls_date_to, ls_file

ls_date_from = em_from.Text
ls_date_from = f_format_date_mmddyyyy(ls_date_from, False) //Remove "/"
//ls_date_from = Replace(ls_date_from, 3, 1, "")
//ls_date_from = Replace(ls_date_from, 5, 1, "")

ls_date_to = em_to.Text
ls_date_to = f_format_date_mmddyyyy(ls_date_to, False) //Remove "/"
//ls_date_to = Replace(ls_date_to, 3, 1, "")
//ls_date_to = Replace(ls_date_to, 5, 1, "")

ls_file = "c:\temp\Active Parts List Order Created Date between " + is_date_from + " and " + is_date_to + ".xls"

If FileExists(ls_file) Then FileDelete(ls_file)

If dw_report.SaveAs(ls_file, Excel8!, True) = -1 Then
   MessageBox("Data SaveAs", "Error")
	Return -1
Else
	MessageBox("Success", "Data have been successfully exported to " + ls_file)
End If

Return 1
end event

type st_rowcount from statictext within w_active_parts_list
integer x = 40
integer y = 2512
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

type cb_retrieve from commandbutton within w_active_parts_list
integer x = 29
integer y = 2598
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

event clicked;String				ls_sector, ls_customer_id, ls_enduser_id, ls_enduser_part_num, ls_die_name, ls_order_item_desc
String				ls_material_end_use, ls_sheet_type, ls_scrap_handing_type, ls_edge_trim_reqd

String				ls_date_from, ls_date_to, ls_add_2sql_where, ls_sql_new, ls_customer_name, ls_enduser_name
String				ls_line, ls_line_display
String				ls_find_string, ls_sector_desc, ls_enduser_short_name
Integer				li_rtn
Long					ll_rows, ll_found_row, ll_customer_id, ll_enduser_id, ll_pos_space
DataWindowChild	ldwc

//dw_report.AcceptText()

dw_sector.AcceptText()
dw_customer.AcceptText()
dw_enduser.AcceptText()
dw_enduser_part_num.AcceptText()
dw_die_name.AcceptText()
dw_line_lookup.AcceptText()
dw_order_item_desc.AcceptText()
dw_material_end_use.AcceptText()
dw_sheet_type.AcceptText()
dw_scrap_handing_type.AcceptText()
dw_edge_trim_reqd.AcceptText()

li_rtn = dw_report.SetSqlSelect(is_sql_orig) //To start, restore the original SQL
ls_add_2sql_where = ""

If cbx_all_dates.Checked = True Then
	is_date_range_head_t = "All Order/Item Created Dates"
Else
	ls_date_from = em_from.Text
	ls_date_to = em_to.Text
	
	If ls_date_from = ls_date_to Then
		is_date_range_head_t = "Order Created Date: " + ls_date_from
	Else
		is_date_range_head_t = "Order Created Date between " + ls_date_from + " and " + ls_date_to
	End If
	
	is_date_from = f_format_date_mmddyyyy(ls_date_from, False) //Remove "/"
	is_date_to = f_format_date_mmddyyyy(ls_date_to, False) //Remove "/"

	ls_add_2sql_where = ls_add_2sql_where + "~n and ( customer_order.created_date between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + " and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )" + " or " + "(order_item.item_created_dttm between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + " and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )" + " ))"
End If

//---

ls_sector = dw_sector.Object.sector_desc[1]
If IsNull(ls_sector) Then ls_sector = "ALL"

//dw_customer.Print() //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

ls_customer_id = dw_customer.Object.customer_short_name[dw_customer.GetRow()]
If IsNull(ls_customer_id) Then ls_customer_id = "ALL"
ls_enduser_id = Trim(dw_enduser.Object.customer_short_name[dw_enduser.GetRow()])
If IsNull(ls_enduser_id) Then ls_enduser_id = "ALL"
ls_enduser_part_num = dw_enduser_part_num.Object.enduser_part_num[dw_enduser_part_num.GetRow()]
If IsNull(ls_enduser_part_num) Then ls_enduser_part_num = "ALL"
ls_die_name = dw_die_name.Object.die_name[dw_die_name.GetRow()]
If IsNull(ls_die_name) Then ls_die_name = "ALL"

ls_line = dw_line_lookup.Object.cust_order_line_note[1] //Example: ls_line = "BL 84"
ls_line_display = ls_line

If Upper(ls_line) <> "ALL" Then
	ll_pos_space = Pos(ls_line, " ", 1)
	
	If ll_pos_space > 0 Then
		ls_line = Right(ls_line, Len(ls_line) - ll_pos_space) //Get numeric part on the right
		
		If Not IsNumber(ls_line) Then
			ls_line = "ALL" //It will not be included in SQL
		End If
	Else
		If ls_line = "None" Then
			ls_line = "'0'"
		Else
			ls_line = "ALL" //It will not be included in SQL
		End If
	End If
End If

ls_order_item_desc = dw_order_item_desc.Object.order_item_desc[dw_order_item_desc.GetRow()]
If IsNull(ls_order_item_desc) Then ls_order_item_desc = "ALL"
ls_material_end_use = dw_material_end_use.Object.material_end_use[dw_material_end_use.GetRow()]
If IsNull(ls_material_end_use) Then ls_material_end_use = "ALL"
ls_sheet_type = dw_sheet_type.Object.sheet_type[dw_sheet_type.GetRow()]
If IsNull(ls_sheet_type) Then ls_sheet_type = "ALL"
ls_scrap_handing_type = dw_scrap_handing_type.Object.scrap_handing_type[dw_scrap_handing_type.GetRow()]
If IsNull(ls_scrap_handing_type) Then ls_scrap_handing_type = "ALL"
ls_edge_trim_reqd = dw_edge_trim_reqd.Object.edge_trim_reqd[dw_edge_trim_reqd.GetRow()]
If IsNull(ls_edge_trim_reqd) Then ls_edge_trim_reqd = "ALL"

If Upper(ls_sector) = "ALL" Then
	is_sector_head_t = "All Sectors"
Else
	li_rtn = dw_sector.GetChild("sector_desc", ldwc)
	
	If li_rtn = 1 Then //OK
		//ls_sector_desc = dw_sector.Object.sector_desc[1]
		
		ls_find_string = "sector_code = " + ls_sector
		
		ll_found_row = ldwc.Find(ls_find_string, 1, ldwc.RowCount())
		
		If ll_found_row > 0 Then
			ls_sector_desc = ldwc.GetItemString(ll_found_row, "sector_desc")
			
			ls_add_2sql_where = ls_add_2sql_where + "~n and order_item.sector = " + ls_sector
			is_sector_head_t = "Sector: " + ls_sector_desc
		End If

	End if
	
			
End if

//Customer
If Upper(ls_customer_id) = "ALL" Or ls_customer_id = "0" Then
	is_customer_head_t = "All Customers"
Else
	If IsNumber(ls_customer_id) Then
		ll_customer_id = Long(ls_customer_id)
		ls_add_2sql_where = ls_add_2sql_where + "~n and customer_order.orig_customer_id = " + ls_customer_id
	End if
	
	li_rtn = dw_customer.GetChild("customer_short_name", ldwc)
	
	If li_rtn = 1 Then //OK
		ls_find_string = "customer_id = " + String(ll_customer_id)
		ll_found_row = ldwc.Find(ls_find_string, 1, ldwc.RowCount())
		
		If ll_found_row > 0 Then
			ls_customer_name = Trim(ldwc.GetItemString(ll_found_row, "customer_short_name"))
			is_customer_head_t = "Customer: " + ls_customer_id + "-" + ls_customer_name
		End If
	End If
End if

//End User
If Upper(ls_enduser_id) = "ALL" Or ls_enduser_short_name = "0" Then
	is_enduser_head_t = "All End Users"
Else
	If IsNumber(ls_enduser_id) Then
		ll_enduser_id = Long(ls_enduser_id)
		ls_add_2sql_where = ls_add_2sql_where + "~n and customer_order.enduser_id = " + ls_enduser_id
	End if
	
	li_rtn = dw_enduser.GetChild("customer_short_name", ldwc)
	
	If li_rtn = 1 Then //OK
		ls_find_string = "enduser_id = " + ls_enduser_id
		ll_found_row = ldwc.Find(ls_find_string, 1, ldwc.RowCount())
		
		If ll_found_row > 0 Then
			ls_enduser_name = Trim(ldwc.GetItemString(ll_found_row, "customer_short_name"))
			is_enduser_head_t = "Enduser: " + ls_enduser_id + "-" + ls_enduser_name
		End If
	End If
End if

//End User Part Number
If Upper(ls_enduser_part_num) = "ALL" Then
	is_enduser_part_head_t = "All End User Parts"
Else
	ls_add_2sql_where = ls_add_2sql_where + "~n and order_item.enduser_part_num = '" + Trim(ls_enduser_part_num) + "'"
	is_enduser_part_head_t = "End User Part: " + ls_enduser_part_num
End If

//Die
If Upper(ls_die_name) = "ALL" Then
	is_die_head_t = "All Dies"
Else
	ls_add_2sql_where = ls_add_2sql_where + "~n and (dbo.f_get_die_name_4order_item(order_item.order_abc_num, order_item.order_item_num)) = '" + ls_die_name + "'"
	is_die_head_t = "Die: " + ls_die_name
End If

//Blanking Line
If Upper(ls_line) = "ALL" Then
	is_line_head_t = "All Blanking Lines"
Else
	ls_add_2sql_where = ls_add_2sql_where + "~n and customer_order.cust_order_line_note = " + ls_line
	is_line_head_t = "Blanking Line: " + ls_line_display
End If

//Order Item Description
If Upper(ls_order_item_desc) = "ALL" Then
	is_order_item_desc_head_t = "All Order Items"
Else
	ls_add_2sql_where = ls_add_2sql_where + "~n and order_item.order_item_desc = '" + Trim(ls_order_item_desc) + "'"
	is_order_item_desc_head_t = "Order Item: " + ls_order_item_desc
End If

//Material End Use
If Upper(ls_material_end_use) = "ALL" Then
	is_material_end_use_head_t = "All Material End Uses"
Else
	ls_add_2sql_where = ls_add_2sql_where + "~n and order_item.material_end_use = '" + Trim(ls_material_end_use) + "'"
	is_material_end_use_head_t = "Material End Use: " + ls_material_end_use
End If

//Sheet Type
If Upper(ls_sheet_type) = "ALL" Then
	is_sheet_type_head_t = "All Sheet Types"
Else
	ls_add_2sql_where = ls_add_2sql_where + "~n and order_item.sheet_type = '" + Trim(ls_sheet_type) + "'"
	is_sheet_type_head_t = "Sheet Type: " + ls_sheet_type
End If

//Scrap Handling Type
If Upper(ls_scrap_handing_type) = "ALL" Then
	is_scrap_handling_type_head_t = "Scrap Handling Types"
Else
	ls_add_2sql_where = ls_add_2sql_where + "~n and customer_order.scrap_handing_type = '" + Trim(ls_scrap_handing_type) + "'"
	is_scrap_handling_type_head_t = "Scrap Handling Type: " + ls_scrap_handing_type
End If

//Edge Trimming Required
If Upper(ls_edge_trim_reqd) = "ALL" Then
	is_edge_trim_reqd_head_t = "Edge Trimming Required: Yes and No"
Else
	ls_add_2sql_where = ls_add_2sql_where + "~n and nvl(order_item.trimming_required, 'N') = '" + Trim(ls_edge_trim_reqd) + "'"
	is_edge_trim_reqd_head_t = "Edge Trimming Required: " + ls_edge_trim_reqd
End If


//---

ls_sql_new = is_sql_orig + ls_add_2sql_where

li_rtn = dw_report.SetSqlSelect(ls_sql_new)

ll_rows = dw_report.Retrieve()

If ll_rows = 1 Then
	st_rowcount.Text = "1 row retrieved"
Else
	st_rowcount.Text = String(ll_rows) + " rows retrieved"
End If
end event

type st_32 from statictext within w_active_parts_list
integer x = 33
integer y = 611
integer width = 128
integer height = 51
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

type dw_edge_trim_reqd from datawindow within w_active_parts_list
integer x = 1774
integer y = 506
integer width = 256
integer height = 90
integer taborder = 20
string title = "none"
string dataobject = "d_edge_trim_reqd"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;wf_reset_report()
end event

type st_14 from statictext within w_active_parts_list
integer x = 33
integer y = 522
integer width = 95
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Die"
boolean focusrectangle = false
end type

type st_12 from statictext within w_active_parts_list
integer x = 1408
integer y = 522
integer width = 351
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Edge Trim Req?"
boolean focusrectangle = false
end type

type st_11 from statictext within w_active_parts_list
integer x = 1408
integer y = 432
integer width = 358
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Scrap Handling"
boolean focusrectangle = false
end type

type st_10 from statictext within w_active_parts_list
integer x = 1408
integer y = 346
integer width = 358
integer height = 51
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

type st_9 from statictext within w_active_parts_list
integer x = 1408
integer y = 250
integer width = 358
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Mat.End Use"
boolean focusrectangle = false
end type

type st_8 from statictext within w_active_parts_list
integer x = 1408
integer y = 154
integer width = 358
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Order Item Desc"
boolean focusrectangle = false
end type

type st_6 from statictext within w_active_parts_list
integer x = 33
integer y = 339
integer width = 234
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "End User"
boolean focusrectangle = false
end type

type st_4 from statictext within w_active_parts_list
integer x = 33
integer y = 250
integer width = 230
integer height = 51
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

type st_3 from statictext within w_active_parts_list
integer x = 33
integer y = 157
integer width = 183
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Sector"
boolean focusrectangle = false
end type

type st_2 from statictext within w_active_parts_list
integer x = 33
integer y = 429
integer width = 344
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "End User Part"
boolean focusrectangle = false
end type

type st_1 from statictext within w_active_parts_list
integer x = 33
integer y = 48
integer width = 600
integer height = 51
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 33554432
long backcolor = 79741120
string text = "Retrieval Arguments"
boolean focusrectangle = false
end type

type st_note from statictext within w_active_parts_list
integer x = 3412
integer y = 45
integer width = 523
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Can take a while..."
boolean focusrectangle = false
end type

type st_to from statictext within w_active_parts_list
integer x = 3416
integer y = 86
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

type st_from from statictext within w_active_parts_list
integer x = 3101
integer y = 86
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

type em_to from editmask within w_active_parts_list
integer x = 3416
integer y = 134
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

event constructor;This.Text = String(Today(), "mm/dd/yyyy")

end event

event modified;wf_reset_report()

wf_retrieve_sector(True)
wf_retrieve_customer_list(True)
wf_retrieve_enduser_list(True)
wf_retrieve_enduser_parts(True)
wf_retrieve_die_name(True)
wf_retrieve_blanking_line(True)
wf_retrieve_order_item_desc(True)
wf_retrieve_material_end_use(True)
wf_retrieve_sheet_type(True)
wf_retrieve_scrap_handling_type(True)
wf_retrieve_edge_trim_reqd(True)
end event

type em_from from editmask within w_active_parts_list
integer x = 3101
integer y = 134
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

event constructor;This.Text = String(Today(), "mm/dd/yyyy")

end event

event modified;wf_reset_report()

wf_retrieve_sector(True)
wf_retrieve_customer_list(True)
wf_retrieve_enduser_list(True)
wf_retrieve_enduser_parts(True)
wf_retrieve_die_name(True)
wf_retrieve_blanking_line(True)
wf_retrieve_order_item_desc(True)
wf_retrieve_material_end_use(True)
wf_retrieve_sheet_type(True)
wf_retrieve_scrap_handling_type(True)
wf_retrieve_edge_trim_reqd(True)
end event

type cbx_all_dates from checkbox within w_active_parts_list
integer x = 3101
integer y = 13
integer width = 322
integer height = 64
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

type dw_die_name from datawindow within w_active_parts_list
integer x = 391
integer y = 506
integer width = 563
integer height = 90
integer taborder = 10
string title = "none"
string dataobject = "d_die_name"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;wf_reset_report()
end event

type dw_line_lookup from datawindow within w_active_parts_list
integer x = 391
integer y = 598
integer width = 322
integer height = 90
integer taborder = 10
string title = "none"
string dataobject = "d_line_4active_parts"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;wf_reset_report()
end event

type dw_scrap_handing_type from datawindow within w_active_parts_list
integer x = 1774
integer y = 416
integer width = 486
integer height = 90
integer taborder = 10
string dataobject = "d_scrap_handing_type"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;wf_reset_report()
end event

type dw_sheet_type from datawindow within w_active_parts_list
integer x = 1774
integer y = 323
integer width = 439
integer height = 90
integer taborder = 10
string title = "none"
string dataobject = "d_sheet_type_4active_parts"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;wf_reset_report()
end event

type dw_material_end_use from datawindow within w_active_parts_list
integer x = 1774
integer y = 230
integer width = 973
integer height = 90
integer taborder = 10
string title = "none"
string dataobject = "d_material_end_use_2"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;wf_reset_report()
end event

type dw_order_item_desc from datawindow within w_active_parts_list
integer x = 1774
integer y = 134
integer width = 633
integer height = 90
integer taborder = 10
string title = "none"
string dataobject = "d_order_item_desc"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;wf_reset_report()
end event

type dw_enduser from datawindow within w_active_parts_list
integer x = 391
integer y = 323
integer width = 647
integer height = 90
integer taborder = 10
string title = "none"
string dataobject = "d_endusers_4active_parts"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;wf_reset_report()
end event

type dw_enduser_part_num from datawindow within w_active_parts_list
integer x = 391
integer y = 416
integer width = 651
integer height = 90
integer taborder = 20
string title = "none"
string dataobject = "d_enduser_part_num"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;wf_reset_report()
end event

type dw_sector from datawindow within w_active_parts_list
integer x = 391
integer y = 141
integer width = 410
integer height = 90
integer taborder = 10
string title = "none"
string dataobject = "d_sector_4active_parts"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;wf_reset_report()
end event

type dw_customer from datawindow within w_active_parts_list
integer x = 391
integer y = 230
integer width = 647
integer height = 90
integer taborder = 10
string title = "none"
string dataobject = "d_customers_4active_parts"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;wf_reset_report()
end event

type cb_close from u_cb within w_active_parts_list
string tag = "Close without printing"
integer x = 2107
integer y = 2598
integer width = 351
integer height = 93
integer taborder = 20
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_print from u_cb within w_active_parts_list
integer x = 1565
integer y = 2598
integer width = 351
integer height = 93
integer taborder = 20
boolean bringtotop = true
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;Integer	li_answer
Long		ll_rows

ll_rows = dw_report.RowCount()

If ll_rows > 0 Then
	li_answer = MessageBox("Really?", "The report has too many columns. ~n~rDo you really want to print it?", Question!, YesNo!, 2)
	
	If li_answer = 1 Then
		dw_report.Event pfc_print()
	End If
End if
end event

type dw_report from u_dw within w_active_parts_list
integer x = 40
integer y = 704
integer width = 4297
integer height = 1808
integer taborder = 10
string dataobject = "d_active_parts_list"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event retrieveend;call super::retrieveend;Long		ll_rows, ll_row, ll_ab_job_num
String	ls_modstring
Pointer 	oldpointer

oldpointer = SetPointer(HourGlass!)

//Update retrieval arguments in report header
ls_modstring = "date_range_head_t.Text = '" + is_date_range_head_t + "'"
dw_report.Modify(ls_modstring)

ls_modstring = "sector_head_t.Text = '" + is_sector_head_t + "'"
dw_report.Modify(ls_modstring)

ls_modstring = "customer_head_t.Text = '" + is_customer_head_t + "'"
dw_report.Modify(ls_modstring)

ls_modstring = "enduser_head_t.Text = '" + is_enduser_head_t + "'"
dw_report.Modify(ls_modstring)

ls_modstring = "enduser_part_head_t.Text = '" + is_enduser_part_head_t + "'"
dw_report.Modify(ls_modstring)

ls_modstring = "die_head_t.Text = '" + is_die_head_t + "'"
dw_report.Modify(ls_modstring)

ls_modstring = "line_head_t.Text = '" + is_line_head_t + "'"
dw_report.Modify(ls_modstring)

ls_modstring = "order_item_desc_head_t.Text = '" + is_order_item_desc_head_t + "'"
dw_report.Modify(ls_modstring)

//is_material_end_use_head_t = "is_material_end_use_head_t"

ls_modstring = "material_end_use_head_t.Text = '" + is_material_end_use_head_t + "'"
dw_report.Modify(ls_modstring)

ls_modstring = "sheet_type_head_t.Text = '" + is_sheet_type_head_t + "'"
dw_report.Modify(ls_modstring)

ls_modstring = "scrap_handling_type_head_t.Text = '" + is_scrap_handling_type_head_t + "'"
dw_report.Modify(ls_modstring)

ls_modstring = "edge_trim_reqd_head_t.Text = '" + is_edge_trim_reqd_head_t + "'"
dw_report.Modify(ls_modstring)

is_run_date_t = String(DateTime(Today(), Now()), "mm/dd/yyyy hh:mm:ss")

SetPointer(oldpointer)
end event

event clicked;call super::clicked;String 	ls_old_sort, ls_column, ls_name
Char 		lc_sort

ls_name = dwo.Name

/* Check whether the user clicks on the column header */
If Right(ls_name, 2) = '_t' Then
	ls_column = Left(dwo.Name, Len(String(dwo.Name)) - 2)

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

type r_1 from rectangle within w_active_parts_list
long linecolor = 65535
integer linethickness = 3
long fillcolor = 65535
integer x = 18
integer y = 2586
integer width = 373
integer height = 122
end type

