$PBExportHeader$w_report_edge_trim.srw
forward
global type w_report_edge_trim from w_sheet
end type
type st_note from statictext within w_report_edge_trim
end type
type st_rowcount from statictext within w_report_edge_trim
end type
type cbx_all_dates from checkbox within w_report_edge_trim
end type
type st_5 from statictext within w_report_edge_trim
end type
type dw_material_end_use from datawindow within w_report_edge_trim
end type
type st_4 from statictext within w_report_edge_trim
end type
type dw_enduser_part_edge_trim from datawindow within w_report_edge_trim
end type
type cb_1 from commandbutton within w_report_edge_trim
end type
type st_all_dates from statictext within w_report_edge_trim
end type
type cb_retrieve from commandbutton within w_report_edge_trim
end type
type em_from from editmask within w_report_edge_trim
end type
type em_to from editmask within w_report_edge_trim
end type
type dw_customer_edge_trim from datawindow within w_report_edge_trim
end type
type st_1 from statictext within w_report_edge_trim
end type
type st_from from statictext within w_report_edge_trim
end type
type st_to from statictext within w_report_edge_trim
end type
type cbx_dateall from checkbox within w_report_edge_trim
end type
type dw_report from u_dw within w_report_edge_trim
end type
type cb_close from u_cb within w_report_edge_trim
end type
type cb_print from u_cb within w_report_edge_trim
end type
end forward

global type w_report_edge_trim from w_sheet
integer width = 3536
integer height = 1955
string title = "Edge Trim Report"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
st_note st_note
st_rowcount st_rowcount
cbx_all_dates cbx_all_dates
st_5 st_5
dw_material_end_use dw_material_end_use
st_4 st_4
dw_enduser_part_edge_trim dw_enduser_part_edge_trim
cb_1 cb_1
st_all_dates st_all_dates
cb_retrieve cb_retrieve
em_from em_from
em_to em_to
dw_customer_edge_trim dw_customer_edge_trim
st_1 st_1
st_from st_from
st_to st_to
cbx_dateall cbx_dateall
dw_report dw_report
cb_close cb_close
cb_print cb_print
end type
global w_report_edge_trim w_report_edge_trim

type variables
String	is_sql_orig
String	is_date_from_to

String	is_process_date_head_t
String	is_customer_name_head_t
String	is_enduser_part_num_head_t
String	is_material_end_use_head_t
end variables

forward prototypes
public subroutine exporttoexcel (datawindow adw_dw, long al_rows)
public subroutine wf_add_2sql (long al_die_id, datetime adt_date_from, datetime adt_date_to)
end prototypes

event type string ue_whoami();Return "w_report_edge_trim"
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
String		ls_range, ls_total_coil_incoming_weight, ls_total_coil_processed_weight
String		ls_total_edge_trim_scrap_weight, ls_total_scrap_weight
Boolean		lb_rtn, lb_directoryexists

String 		ls_file, ls_today, ls_now, ls_folder
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
	ls_total_coil_incoming_weight = String(adw_dw.Object.compute_5[1])
	ls_total_coil_processed_weight = String(adw_dw.Object.compute_4[1])
	ls_total_edge_trim_scrap_weight = String(adw_dw.Object.compute_3[1])
	ls_total_scrap_weight = String(adw_dw.Object.compute_2[1])
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
lole_OLE.cells[1,1] = "Process Date"
lole_OLE.cells[1,2] = "Ab Job Num"
lole_OLE.cells[1,3] = "Coil Abc Num"
lole_OLE.cells[1,4] = "Coil Org Num"
lole_OLE.cells[1,5] = "Customer Name"
lole_OLE.cells[1,6] = "Enduser Name"
lole_OLE.cells[1,7] = "Enduser Part Num"
lole_OLE.cells[1,8] = "Material End Use"
lole_OLE.cells[1,9] = "Incoming Coil Width"
lole_OLE.cells[1,10] = "Incoming Coil Weight"
lole_OLE.cells[1,11] = "Trimmed Coil Width"
lole_OLE.cells[1,12] = "Coil Processed Weight"
lole_OLE.cells[1,13] = "Edge Trim Scrap Weight"
lole_OLE.cells[1,14] = "Scrap Total Weight"

//Insert Lines for Header & Miscellaneous Details (3 lines above columnar data)
lole_Sheet.Range("A1:N6").Select
lole_Sheet.Application.Selection.EntireRow.Insert 

lole_OLE.cells[1,1] = "Edge Trim Report"
lole_Sheet.Range("A1:A1").Select
lole_OLE.Selection.Font.Bold = True
lole_OLE.Selection.Font.Size = 24 //Change font size
lole_OLE.Selection.Font.Underline = True

lole_OLE.cells[2,1] = "Run Date: " + String(Today(), "mm/dd/yyyy") + " " + String(Now(), "hh:mm:ss")
lole_Sheet.Range("A2:A2").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[3,1] = is_process_date_head_t
lole_Sheet.Range("A3:A3").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[4,1] = is_customer_name_head_t
lole_Sheet.Range("A4:A4").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[5,1] = is_enduser_part_num_head_t
lole_Sheet.Range("A5:A5").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[6,1] = is_material_end_use_head_t
lole_Sheet.Range("A6:A6").Select
lole_OLE.Selection.Font.Bold = True

//Insert 2 lines for totals (below columnar data)
lole_OLE.cells[ll_report_rows + 8,9] = "Totals:"
ls_range = "G" + String(ll_report_rows + 8) + ":" + "I" + String(ll_report_rows + 8)
lole_Sheet.Range(ls_range).Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[ll_report_rows + 8,10] = String(ls_total_coil_incoming_weight)
ls_range = "G" + String(ll_report_rows + 8) + ":" + "J" + String(ll_report_rows + 8)
lole_Sheet.Range(ls_range).Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[ll_report_rows + 8,12] = String(ls_total_coil_processed_weight)
ls_range = "H" + String(ll_report_rows + 8) + ":" + "L" + String(ll_report_rows + 8)
lole_Sheet.Range(ls_range).Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[ll_report_rows + 8,13] = String(ls_total_edge_trim_scrap_weight)
ls_range = "H" + String(ll_report_rows + 8) + ":" + "M" + String(ll_report_rows + 8)
lole_Sheet.Range(ls_range).Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[ll_report_rows + 8,14] = String(ls_total_scrap_weight)
ls_range = "H" + String(ll_report_rows + 8) + ":" + "N" + String(ll_report_rows + 8)
lole_Sheet.Range(ls_range).Select
lole_OLE.Selection.Font.Bold = True

//---

SetPointer(HourGlass!)
ld_today = Today()
ld_now = Now()
ls_today = String(ld_today,"yymmdd")
ls_now = String(ld_now,"hhmmss")

//Delete extra columns	
//lole_Sheet.columns("O:T").Delete

lole_Sheet.Columns("O:T").Select
lole_OLE.Selection.Delete

//Justify
//lole_OLE.Selection.HorizontalAlignment = -4108 //Center
//lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
//lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

lole_Sheet.Range("A4:A" + String(ll_report_rows + 7)).Select
lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify

lole_Sheet.Range("B4:B" + String(ll_report_rows + 7)).Select
lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

////Change date format for a column
//lole_Sheet.Range("D4:D" + String(ll_report_rows + 5)).Select
//lole_OLE.Selection.NumberFormat = "mm/dd/yyyy"

//Underline column headers
lole_Sheet.Range("A7:N7").Select
lole_OLE.Selection.Font.Underline = True

//Draw border around column headers
lole_OLE.Application.range ("A7:N7").borders(4).LineStyle = 1

//Increase column width
lole_Sheet.Range("A4:A4").Select
lole_OLE.Selection.ColumnWidth = 18

lole_Sheet.Range("E4:G4").Select
lole_OLE.Selection.ColumnWidth = 40

lole_Sheet.Range("H4:H4").Select
lole_OLE.Selection.ColumnWidth = 60

//---

ls_folder = ProfileString(gs_ini_file, "EMAIL","email_out","c:\temp\")

If Right(ls_folder, 1) <> "\" Then ls_folder = ls_folder + "\"
ls_file = ls_folder + "Edge Trim Report" + "_" + ls_today + ls_now + ".xls"

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

on w_report_edge_trim.create
int iCurrent
call super::create
this.st_note=create st_note
this.st_rowcount=create st_rowcount
this.cbx_all_dates=create cbx_all_dates
this.st_5=create st_5
this.dw_material_end_use=create dw_material_end_use
this.st_4=create st_4
this.dw_enduser_part_edge_trim=create dw_enduser_part_edge_trim
this.cb_1=create cb_1
this.st_all_dates=create st_all_dates
this.cb_retrieve=create cb_retrieve
this.em_from=create em_from
this.em_to=create em_to
this.dw_customer_edge_trim=create dw_customer_edge_trim
this.st_1=create st_1
this.st_from=create st_from
this.st_to=create st_to
this.cbx_dateall=create cbx_dateall
this.dw_report=create dw_report
this.cb_close=create cb_close
this.cb_print=create cb_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_note
this.Control[iCurrent+2]=this.st_rowcount
this.Control[iCurrent+3]=this.cbx_all_dates
this.Control[iCurrent+4]=this.st_5
this.Control[iCurrent+5]=this.dw_material_end_use
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.dw_enduser_part_edge_trim
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.st_all_dates
this.Control[iCurrent+10]=this.cb_retrieve
this.Control[iCurrent+11]=this.em_from
this.Control[iCurrent+12]=this.em_to
this.Control[iCurrent+13]=this.dw_customer_edge_trim
this.Control[iCurrent+14]=this.st_1
this.Control[iCurrent+15]=this.st_from
this.Control[iCurrent+16]=this.st_to
this.Control[iCurrent+17]=this.cbx_dateall
this.Control[iCurrent+18]=this.dw_report
this.Control[iCurrent+19]=this.cb_close
this.Control[iCurrent+20]=this.cb_print
end on

on w_report_edge_trim.destroy
call super::destroy
destroy(this.st_note)
destroy(this.st_rowcount)
destroy(this.cbx_all_dates)
destroy(this.st_5)
destroy(this.dw_material_end_use)
destroy(this.st_4)
destroy(this.dw_enduser_part_edge_trim)
destroy(this.cb_1)
destroy(this.st_all_dates)
destroy(this.cb_retrieve)
destroy(this.em_from)
destroy(this.em_to)
destroy(this.dw_customer_edge_trim)
destroy(this.st_1)
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

dw_report.SetTransObject(sqlca)
is_sql_orig = dw_report.GetSqlSelect() //Save the original SQL

ld_from_default = RelativeDate(Today(), -7) //7 days into the past
em_from.Text = String(ld_from_default)

//dw_general_customer
li_rtn = dw_customer_edge_trim.GetChild("customer_name", ldwc)

If li_rtn = 1 Then //OK
	ldwc.SetTransObject(sqlca)
	ll_rows = ldwc.Retrieve()
	
	If ll_rows > 0 Then
		ll_row_inserted = ldwc.InsertRow(1)
		
		If ll_row_inserted > 0 Then
			ldwc.SetItem(ll_row_inserted, "customer_short_name", "ALL")
			dw_customer_edge_trim.Object.customer_name[1] = "ALL"
		End If
	End If
End If

//dw_enduser_part_edge_trim
li_rtn = dw_enduser_part_edge_trim.GetChild("enduser_part_num", ldwc)

If li_rtn = 1 Then //OK
	ldwc.SetTransObject(sqlca)
	ll_rows = ldwc.Retrieve()
	
	If ll_rows > 0 Then
		ll_row_inserted = ldwc.InsertRow(1)
		
		If ll_row_inserted > 0 Then
			ldwc.SetItem(ll_row_inserted, "enduser_part_num", "ALL")
			dw_enduser_part_edge_trim.Object.enduser_part_num[1] = "ALL"
		End If
	End If
End If

//dw_material_end_use
li_rtn = dw_material_end_use.GetChild("material_end_use", ldwc)

If li_rtn = 1 Then //OK
	ldwc.SetTransObject(sqlca)
	ll_rows = ldwc.Retrieve()
	
	If ll_rows > 0 Then
		ll_row_inserted = ldwc.InsertRow(1)
		
		If ll_row_inserted > 0 Then
			ldwc.SetItem(ll_row_inserted, "material_end_use", "ALL")
			dw_material_end_use.Object.material_end_use[1] = "ALL"
		End If
	End If
End If
end event

type st_note from statictext within w_report_edge_trim
boolean visible = false
integer x = 2699
integer y = 13
integer width = 830
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Might take some time..."
boolean focusrectangle = false
end type

type st_rowcount from statictext within w_report_edge_trim
integer y = 1821
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

type cbx_all_dates from checkbox within w_report_edge_trim
integer x = 2359
integer y = 6
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

type st_5 from statictext within w_report_edge_trim
integer x = 1441
integer y = 67
integer width = 377
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
string text = "Material End Use"
boolean focusrectangle = false
end type

type dw_material_end_use from datawindow within w_report_edge_trim
integer x = 1437
integer y = 122
integer width = 739
integer height = 86
integer taborder = 40
string title = "none"
string dataobject = "d_material_end_use"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_report_edge_trim
integer x = 812
integer y = 64
integer width = 358
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
string text = "EndUser Part"
boolean focusrectangle = false
end type

type dw_enduser_part_edge_trim from datawindow within w_report_edge_trim
integer x = 812
integer y = 122
integer width = 581
integer height = 86
integer taborder = 30
string title = "none"
string dataobject = "d_enduser_part_edge_trim"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_report_edge_trim
integer x = 2984
integer y = 512
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

type st_all_dates from statictext within w_report_edge_trim
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

type cb_retrieve from commandbutton within w_report_edge_trim
integer x = 2984
integer y = 256
integer width = 351
integer height = 90
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

event clicked;String	ls_customer_name, ls_enduser_part_num, ls_material_end_use
String	ls_date_from, ls_date_to, ls_add_2sql_where, ls_sql_new
String	ls_find_string
Integer	li_rtn
Long		ll_rows, ll_found_row
DataWindowChild	ldwc

dw_report.AcceptText()
li_rtn = dw_report.SetSqlSelect(is_sql_orig) //To start, restore the original SQL
ls_add_2sql_where = ""

If cbx_all_dates.Checked = True Then
	is_process_date_head_t = "All Dates"
Else
	ls_date_from = em_from.Text
	ls_date_to = em_to.Text
	
	//ls_date_from = em_from.Text 
	//ls_date_to = em_to.Text
	
	//is_process_date_head_t = "Date From: " + ls_date_from + "  Date To: " + ls_date_to
	
	If ls_date_from = ls_date_to Then
		is_process_date_head_t = "Date: " + ls_date_from
	Else
		is_process_date_head_t = "Date between " + ls_date_from + " and " + ls_date_to
	End If
	
	ls_add_2sql_where = ls_add_2sql_where + " and process_coil.process_date between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + &
								" and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )  "
End If

ls_customer_name = dw_customer_edge_trim.Object.customer_name[1]
ls_enduser_part_num = dw_enduser_part_edge_trim.Object.enduser_part_num[1]
ls_material_end_use = dw_material_end_use.Object.material_end_use[1]

If ls_customer_name = "ALL" Then
	is_customer_name_head_t = "All Customers"
	is_customer_name_head_t = "All Customers"
Else
	ls_add_2sql_where = ls_add_2sql_where + " and c1.customer_id = '" + ls_customer_name + "'"
	
	li_rtn = dw_customer_edge_trim.GetChild("customer_name", ldwc)
	
	If li_rtn = 1 Then //OK
		ls_find_string = "customer_id = " + ls_customer_name
		ll_found_row = ldwc.Find(ls_find_string, 1, ldwc.RowCount())
		
		If ll_found_row > 0 Then
			ls_customer_name = ldwc.GetItemString(ll_found_row, "customer_short_name")
		End If
	End If
	
	is_customer_name_head_t = "Customer: " + ls_customer_name
End If

If ls_enduser_part_num = "ALL" Then
	is_enduser_part_num_head_t = "All End User Part Numbers"
Else
	ls_add_2sql_where = ls_add_2sql_where + " and order_item.enduser_part_num = '" + ls_enduser_part_num + "'"
	is_enduser_part_num_head_t = "End User Part Numbers: " + ls_enduser_part_num
End If

If ls_material_end_use = "ALL" Then
	is_material_end_use_head_t = "All Material End Use"
Else
	ls_add_2sql_where = ls_add_2sql_where + " and order_item.material_end_use = '" + ls_material_end_use + "'"
	is_material_end_use_head_t = "Material End Use: " + ls_material_end_use
End If

ls_sql_new = is_sql_orig + ls_add_2sql_where

ls_sql_new = ls_sql_new + " order by process_coil.process_date, ab_job.ab_job_num, coil.coil_abc_num"

li_rtn = dw_report.SetSqlSelect(ls_sql_new)

ll_rows = dw_report.Retrieve()


















//String				ls_die_name, ls_sql, ls_modstring, ls_date_from, ls_date_to
//String				ls_find_string
//DateTime				ldt_date_from, ldt_date_to	
//Long					ll_rows, ll_die_id, ll_found_row
//Boolean				lb_all_dates
//Integer				li_rtn, li_inserted_row
//DataWindowChild	ldwc
//
//dw_report.Reset()
//dw_die_list_active.AcceptText()
//
//ls_date_from = em_from.Text
//ls_date_to = em_to.Text
//
//ldt_date_from = DateTime(Date(ls_date_from), Time("00:00:00"))
//ldt_date_to = DateTime(Date(ls_date_to), Time("23:59:59"))
//
//If ls_date_from = ls_date_to Then
//	ls_modstring = "date_from_to_t.Text = 'Date: " + ls_date_from + "'"
//	is_date_from_to = "Date: " + ls_date_from
//Else
//	ls_modstring = "date_from_to_t.Text = 'Date between " + ls_date_from + " and " + ls_date_to + "'"
//	is_date_from_to = "Date between " + ls_date_from + " and " + ls_date_to
//End If
//
//dw_report.Modify(ls_modstring)
//
//ls_die_name = dw_die_list_active.Object.die_name[1]
//
////dw_die_list_active.Print()
//
//If Upper(ls_die_name) = "ALL" Then
//	ls_modstring = "die_name_t.Text = 'All Dies'"
//Else
//	ls_modstring = "die_name_t.Text = 'Die: " + ls_die_name + "'"
//End If
//
//dw_report.Modify(ls_modstring)
//
////If ll_die_id = 0, the report will select for all dies
//If Upper(ls_die_name) = "ALL" Then
//	ll_die_id = 0
//Else
//	//ll_die_id = dw_die_list_active.Object.die_id[1]
//	//If IsNull(ll_die_id) Then ll_die_id = 0
//	
//	li_rtn = dw_die_list_active.GetChild("die_name", ldwc)
//	
//	If li_rtn = 1 Then //OK
//		ls_find_string = "die_name = '" + ls_die_name + "'"
//		ll_found_row = ldwc.Find(ls_find_string, 1, ldwc.RowCount())
//		
//		If ll_found_row > 0 Then
//			ll_die_id = ldwc.GetItemNumber(ll_found_row, "die_id")
//		Else
//			ll_die_id = 0
//		End If
//	Else
//		ll_die_id = 0
//	End If
//End If
//
//wf_add_2sql(ll_die_id, ldt_date_from, ldt_date_to)
//
////ls_sql = dw_report.GetSqlSelect() //For debugging only
//
//ll_rows = dw_report.Retrieve() //No arguments here. Arguments are set up in wf_add_2sql()
//
////If ll_rows <= 0 Then
////	li_inserted_row = dw_report.InsertRow(0)
////	
////	If li_inserted_row > 0 Then
////		dw_report.Object.die_name[li_inserted_row] = "All Dies"
////		dw_report.Object.num_of_strokes[li_inserted_row] = 0
////	End If
////End If
//
//

end event

type em_from from editmask within w_report_edge_trim
integer x = 2224
integer y = 128
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

type em_to from editmask within w_report_edge_trim
integer x = 2575
integer y = 128
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

type dw_customer_edge_trim from datawindow within w_report_edge_trim
integer y = 122
integer width = 779
integer height = 86
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_customer_edge_trim"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.InsertRow(0)
end event

type st_1 from statictext within w_report_edge_trim
integer y = 77
integer width = 230
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

type st_from from statictext within w_report_edge_trim
integer x = 2224
integer y = 77
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

type st_to from statictext within w_report_edge_trim
integer x = 2575
integer y = 77
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

type cbx_dateall from checkbox within w_report_edge_trim
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

type dw_report from u_dw within w_report_edge_trim
integer y = 256
integer width = 2896
integer height = 1552
integer taborder = 10
string dataobject = "d_report_edge_trim"
boolean hscrollbar = true
end type

event clicked;call super::clicked;String 	ls_old_sort, ls_column, ls_name
Char 		lc_sort

If row > 0 Then
	This.SelectRow(0, False)
	
	If This.IsSelected(row) Then
		This.SelectRow(row, False)
	Else
		This.SelectRow(row, True)
	End If
End If

ls_name = dwo.Name

If ls_name = "die_id_t" Then ls_name = "die_name_t" 	//Column die_id is not on the screen.
																		//Column die_name is.

/* Check whether the user clicks on the column header */
If Right(ls_name, 2) = '_t' Then
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

event retrieveend;call super::retrieveend;String	ls_modstring

st_rowcount.Text = String(rowcount) + " rows retrieved"

/*
String	is_process_date_head_t
String	is_customer_name_head_t
String	is_enduser_part_num_head_t
String	is_material_end_use_head_t
*/

ls_modstring = "process_date_head_t.Text = '" + is_process_date_head_t + "'"
dw_report.Modify(ls_modstring)

ls_modstring = "customer_name_head_t.Text = '" + is_customer_name_head_t + "'"
dw_report.Modify(ls_modstring)

ls_modstring = "enduser_part_num_head_t.Text = '" + is_enduser_part_num_head_t + "'"
dw_report.Modify(ls_modstring)

ls_modstring = "material_end_use_head_t.Text = '" + is_material_end_use_head_t + "'"
dw_report.Modify(ls_modstring)
end event

type cb_close from u_cb within w_report_edge_trim
string tag = "Close without printing"
integer x = 2984
integer y = 640
integer width = 351
integer height = 93
integer taborder = 40
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_print from u_cb within w_report_edge_trim
integer x = 2984
integer y = 384
integer width = 351
integer height = 93
integer taborder = 30
boolean bringtotop = true
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;dw_report.Event pfc_print()
end event

