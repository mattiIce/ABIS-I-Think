$PBExportHeader$w_report_customer_scrap_skid.srw
$PBExportComments$inventory scrap skid report based on different customers
forward
global type w_report_customer_scrap_skid from w_sheet
end type
type cb_select_all from commandbutton within w_report_customer_scrap_skid
end type
type dw_scrap_status_desc from datawindow within w_report_customer_scrap_skid
end type
type cbx_default from checkbox within w_report_customer_scrap_skid
end type
type cb_1 from commandbutton within w_report_customer_scrap_skid
end type
type cb_export from u_cb within w_report_customer_scrap_skid
end type
type dw_report from u_dw within w_report_customer_scrap_skid
end type
type cb_print from u_cb within w_report_customer_scrap_skid
end type
type cb_close from u_cb within w_report_customer_scrap_skid
end type
type cb_setzoom from u_cb within w_report_customer_scrap_skid
end type
type gb_5 from u_gb within w_report_customer_scrap_skid
end type
type gb_4 from u_gb within w_report_customer_scrap_skid
end type
type gb_3 from u_gb within w_report_customer_scrap_skid
end type
type rb_custall from u_rb within w_report_customer_scrap_skid
end type
type rb_cust from u_rb within w_report_customer_scrap_skid
end type
type rb_dateall from u_rb within w_report_customer_scrap_skid
end type
type rb_date from u_rb within w_report_customer_scrap_skid
end type
type ddlb_cust from u_ddlb within w_report_customer_scrap_skid
end type
type dw_customer from u_dw within w_report_customer_scrap_skid
end type
type cb_retrieve from u_cb within w_report_customer_scrap_skid
end type
type rb_statusall from u_rb within w_report_customer_scrap_skid
end type
type rb_status from u_rb within w_report_customer_scrap_skid
end type
type ddlb_status from u_ddlb within w_report_customer_scrap_skid
end type
type cb_sort from u_cb within w_report_customer_scrap_skid
end type
type cb_email from u_cb within w_report_customer_scrap_skid
end type
type em_from from u_em within w_report_customer_scrap_skid
end type
type em_to from u_em within w_report_customer_scrap_skid
end type
type st_1 from statictext within w_report_customer_scrap_skid
end type
end forward

global type w_report_customer_scrap_skid from w_sheet
string tag = "ABCO production reports"
integer x = 4
integer y = 3
integer width = 4484
integer height = 2176
string title = "Inventory Report - Scrap Skid"
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
cb_select_all cb_select_all
dw_scrap_status_desc dw_scrap_status_desc
cbx_default cbx_default
cb_1 cb_1
cb_export cb_export
dw_report dw_report
cb_print cb_print
cb_close cb_close
cb_setzoom cb_setzoom
gb_5 gb_5
gb_4 gb_4
gb_3 gb_3
rb_custall rb_custall
rb_cust rb_cust
rb_dateall rb_dateall
rb_date rb_date
ddlb_cust ddlb_cust
dw_customer dw_customer
cb_retrieve cb_retrieve
rb_statusall rb_statusall
rb_status rb_status
ddlb_status ddlb_status
cb_sort cb_sort
cb_email cb_email
em_from em_from
em_to em_to
st_1 st_1
end type
global w_report_customer_scrap_skid w_report_customer_scrap_skid

type variables
String is_status
String is_cust
String is_enduser
String is_desc

//Report header variables
String	is_report_title_xl, is_status_xl, is_created_date_xl, is_enduser_xl //Alex Gerlants. 05/03/2016

Integer	li_rows_scrap_status_desc //Alex Gerlants. 05/12/2017
String	is_sql_orig_all_cust, is_sql_orig_one_cust, is_status_list //Alex Gerlants. 05/12/2017
end variables

forward prototypes
public function string wf_search_terms ()
public subroutine wf_settitle ()
public subroutine getcolumns (datawindow adw_dw, ref string as_columns[])
public function any getdata (datawindow adw_dw, long al_row, string as_column)
public function string inttocolumn (integer ai_col)
public subroutine exporttoexcel (datawindow adw_dw, long al_rows)
public subroutine wf_retrieve_all_scrap ()
public function boolean wf_all_statuses_selected ()
public function boolean wf_all_statuses_unselected ()
end prototypes

event ue_whoami;RETURN "w_report_customer_scrap_skid"
end event

public function string wf_search_terms ();String ls_terms, ls_sort, ls_s
Long ll_row, ll_i
Long ll_line, ll_cust, ll_enduser, ll_status

ls_s = is_desc
IF rb_cust.Checked THEN
	ll_row = dw_customer.RowCount()
	FOR ll_i = 1 TO ll_row
		IF dw_customer.GetItemString(ll_i, "customer_short_name") = is_cust THEN
			ll_cust = dw_customer.GetItemNumber(ll_i, "customer_id")
		END IF
	NEXT
	ls_s = ls_s + " and (~~~"SCRAP_SKID~~~".~~~"CUSTOMER_ID~~~" = " + String(ll_cust) + " )"
END IF

IF rb_date.Checked THEN
	ls_s = ls_s + " and (TO_DATE(TO_CHAR(~~~"SCRAP_SKID~~~".~~~"SCRAP_DATE~~~",~~~'DD-MON-YYYY~~~'),~~~'DD-MON-YYYY~~~'  ) >= " + " TO_DATE(~~~'" + em_from.Text + "~~~',~~~'mm/dd/yyyy~~~' )" + " )"  
	ls_s = ls_s + " and (TO_DATE(TO_CHAR(~~~"SCRAP_SKID~~~".~~~"SCRAP_DATE~~~",~~~'DD-MON-YYYY~~~'),~~~'DD-MON-YYYY~~~'  )  <= " + " TO_DATE(~~~'" + em_to.Text + "~~~',~~~'mm/dd/yyyy~~~' )" + " )"  //21-DEC-1998 format
END IF


IF rb_status.Checked THEN
	CHOOSE CASE UPPER(Trim(is_status))
//		CASE "GONE"
//			ll_status = 0
		CASE "INPROCESS"
			ll_status = 1
		CASE "READY"
			ll_status = 2
		CASE "CANCELED"
			ll_status = 3
		CASE "ONHOLD"
			ll_status = 4
	END CHOOSE
	ls_s = ls_s + " and ( ~~~"SCRAP_SKID~~~".~~~"SKID_SCRAP_STATUS~~~" = " + String(ll_status) + " )"
END IF

ls_terms = ls_terms + ls_s + ls_sort

RETURN ls_terms
end function

public subroutine wf_settitle ();String ls_modstring,ls_s
Long ll_c

//Alex Gerlants. 05/12/2017. Begin
If dw_report.DataObject = "d_report_inv_scrap_skids_all_cust" Or dw_report.DataObject = "d_report_inv_scrap_skids_one_cust" Then
	If is_status_list = "" Or wf_all_statuses_selected() Then
		ls_s = "ALL"
	Else
		ls_s = is_status_list
	End If
Else
//Alex Gerlants. 05/12/2017. End
	IF rb_statusall.Checked THEN
		ls_s = "ALL"		
	ELSE
		ls_s = is_status
	END IF
End If //Alex Gerlants. 05/12/2017	

ls_modstring = "status_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 

is_status_xl = ls_s //Alex Gerlants. 05/03/2016

IF rb_dateall.Checked THEN
	ls_s = "ALL"		
ELSE
	ls_s = em_from.Text + " - " + em_to.Text
END IF

ls_modstring = "date_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 

is_created_date_xl = ls_s //Alex Gerlants. 05/03/2016

IF rb_custall.Checked THEN
	ls_s = "ABCO Customer Scrap Skid Inventory Report" 	
ELSE
	ls_s = Trim(is_cust) + " Scrap Skid Inventory Report"
END IF	

ls_modstring = "title_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 

is_report_title_xl = ls_s //Alex Gerlants. 05/03/2016


end subroutine

public subroutine getcolumns (datawindow adw_dw, ref string as_columns[]);//Alex Gerlants. 05/02/2016. Begin
/*
Function:	getcolumns
				Get a list of all the columns in the DW
				Note this function could be replaced with
				a function that allows the developer to specify
				the column names to be exported.
Returns:		none
Arguments:	value	datawindow	adw_dw
				reference	string	as_columns[]
*/

Long ll_I, ll_Cols
String	ls_column_name

ll_Cols = Long( adw_DW.Describe( 'datawindow.column.count' ) )
FOR ll_I = ll_cols TO 1 STEP -1
	ls_column_name = adw_DW.Describe( '#' + String( ll_I ) + '.Name' )
	as_columns[ ll_I ] = ls_column_name
NEXT

////Alex Gerlants. 05/02/2016. End
end subroutine

public function any getdata (datawindow adw_dw, long al_row, string as_column);//Alex Gerlants. 05/02/2016. Begin
/*
Function:	getdata
Returns:		any
Arguments:	value	datawindow	adw_dw
				value	long			al_row
				value	string		as_column
*/

Long ll_Col
Any la_A

IF al_Row > adw_DW.RowCount() THEN RETURN ""
ll_Col = Long( adw_DW.Describe( as_Column + ".ID" ) )
IF ll_Col > 0 THEN &
   la_A = adw_DW.object.data.primary.current[ al_Row, ll_Col ]

RETURN la_A
//Alex Gerlants. 05/02/2016. End
end function

public function string inttocolumn (integer ai_col);//Alex Gerlants. 05/02/2016. Begin
/*
Function:	inttocolumn
				Convert a column number into a spreadsheet column reference
Returns:		string
Arguments:	value	integer	ai_col
*/

String ls_Col
Integer li_Min, li_Max

IF ai_col <= 0 THEN RETURN ""

// calc the major/minor letters
li_Max = ai_col / 26
li_Min = ai_col - ( li_Max * 26 )

// Convert min and max to letters
IF li_Max > 0 THEN
	ls_Col = Char( 64 + li_Max )
END IF

ls_Col += String( Char( 64 + li_Min ) )

RETURN ls_Col
//Alex Gerlants. 05/02/2016. End
end function

public subroutine exporttoexcel (datawindow adw_dw, long al_rows);//Alex Gerlants. 05/02/2016. Begin
/*
Function:	exporttoexcel
Returns:		none
Arguments:	value		datawindow	adw_dw
				value		long			al_rows	

*/

//Export the data to Excel
OleObject 	lole_OLE, lole_Sheet
String 		ls_Columns[]
Long 			ll_report_rows, ll_Row, ll_Col, ll_Cols, ll_total_line1, ll_total_line2
String		ls_range, ls_total_skid, ls_total_Net_wt, ls_dataobject
Boolean		lb_rtn, lb_directoryexists

String 		ls_file, ls_today, ls_now, ls_folder
Date 			ld_today
Time 			ld_now
Integer		li_answer, li_count

ll_report_rows = dw_report.RowCount()
ls_dataobject = dw_report.DataObject

If ll_report_rows > 0 Then
	//Get report totals
	If ls_dataobject = "d_report_inv_abc_scrap_skids" Or ls_dataobject = "d_report_inv_scrap_skids_all_cust" Then
		ls_total_skid = String(dw_report.Object.compute_2[1])
		ls_total_Net_wt = String(dw_report.Object.compute_6[1])
	Else
		ls_total_skid = String(dw_report.Object.compute_2[1])
		ls_total_Net_wt = String(dw_report.Object.compute_3[1])
	End If
Else
	Return
End If

lole_OLE = CREATE OleObject

SetPointer( HourGlass! )

lole_OLE.ConnectToNewObject( 'excel.application' )
lole_OLE.Workbooks.Add
lole_sheet = lole_OLE.Application.ActiveWorkbook.WorkSheets[1]

this.GetColumns( adw_DW, ls_Columns )
ll_Cols = UpperBound( ls_Columns )
FOR ll_col = 1 TO ll_cols
	lole_Sheet.Cells[ 1, ll_Col ] = ls_Columns[ ll_Col ]
NEXT

FOR ll_Row = 2 TO al_rows + 1
	FOR ll_Col = 1 TO ll_cols
		lole_Sheet.Cells[ ll_Row, ll_Col ] = &
		this.GetData( adw_DW, ll_Row - 1, ls_Columns[ ll_Col ] )
	NEXT
NEXT

lole_Sheet.Range( inttocolumn( 1 ) + "1:" + inttocolumn( ll_Cols ) + "1").Select
lole_OLE.Selection.Font.Bold = True

lole_Sheet.Range("A1:A1").Select
lole_Sheet.Columns( inttocolumn( 1 ) + ":" + inttocolumn( ll_cols ) ).EntireColumn.AutoFit

//Column Headings
If ls_dataobject = "d_report_inv_abc_scrap_skids" Or ls_dataobject = "d_report_inv_scrap_skids_all_cust" Then
	lole_OLE.cells[1,1]  = "Skid #"
	lole_OLE.cells[1,2]  = "Customer"
	lole_OLE.cells[1,3]  = "Scrap Handling"
	lole_OLE.cells[1,4]  = "Scrap Type"
	lole_OLE.cells[1,5]  = "Scrap Ref"
	lole_OLE.cells[1,6]  = "Net WT"
	lole_OLE.cells[1,7]  = "Tare"
	lole_OLE.cells[1,8]  = "Status"
	lole_OLE.cells[1,9] = "Skid Job"
	lole_OLE.cells[1,10]  = "Alloy"
	lole_OLE.cells[1,11]  = "Temp"
	lole_OLE.cells[1,12] = "Skid Date"
	lole_OLE.cells[1,13] = "Duration"
	lole_OLE.cells[1,14] = "Item NetWT"
	lole_OLE.cells[1,15] = "Item Job"
	lole_OLE.cells[1,16] = "Item Date"
Else
	lole_OLE.cells[1,1]  = "Skid #"
	lole_OLE.cells[1,2]  = "Scrap Handling"
	lole_OLE.cells[1,3]  = "Scrap Type"
	lole_OLE.cells[1,4]  = "Scrap Ref"
	lole_OLE.cells[1,5]  = "Net WT"
	lole_OLE.cells[1,6]  = "Tare"
	lole_OLE.cells[1,7]  = "Status"
	lole_OLE.cells[1,8] = "Skid Job"
	lole_OLE.cells[1,9]  = "Alloy"
	lole_OLE.cells[1,10]  = "Temp"
	lole_OLE.cells[1,11] = "Skid Date"
	lole_OLE.cells[1,12] = "Duration"
	lole_OLE.cells[1,13] = "Item NetWT"
	lole_OLE.cells[1,14] = "Item Job"
	lole_OLE.cells[1,15] = "Item Date"
End If

//Insert Lines for Header & Miscellaneous Details (3 lines above columnar data)
lole_Sheet.Range("A1:Q3").Select
lole_Sheet.Application.Selection.EntireRow.Insert 

//Change font size for report title
lole_OLE.cells[1,6] = is_report_title_xl
lole_Sheet.Range("F1:F1").Select
lole_OLE.Selection.Font.Bold = True
lole_OLE.Selection.Font.Size = 24
lole_OLE.Selection.Font.Underline = True

//Underline column headers
If ls_dataobject = "d_report_inv_abc_scrap_skids" Or ls_dataobject = "d_report_inv_scrap_skids_all_cust" Then
	lole_Sheet.Range("A4:P4").Select
	lole_OLE.Selection.Font.Underline = True
Else
	lole_Sheet.Range("A4:O4").Select
	lole_OLE.Selection.Font.Underline = True
End If

//Change date format for current date
If ls_dataobject = "d_report_inv_abc_scrap_skids" Or ls_dataobject = "d_report_inv_scrap_skids_all_cust" Then
	lole_OLE.cells[1,16] = String(Today(), "mm/dd/yyyy")
	lole_Sheet.Range("P1:P1").Select
	lole_OLE.Selection.Font.Bold = True
Else
	lole_OLE.cells[1,15] = String(Today(), "mm/dd/yyyy")
	lole_Sheet.Range("O1:O1").Select
	lole_OLE.Selection.Font.Bold = True
End If

//Format date columns
If ls_dataobject = "d_report_inv_abc_scrap_skids" Or ls_dataobject = "d_report_inv_scrap_skids_all_cust" Then
	lole_Sheet.Range("L3:L" + String(ll_report_rows + 4)).Select
	lole_OLE.Selection.NumberFormat = "mm/dd/yyyy"
	
	lole_Sheet.Range("P3:P" + String(ll_report_rows + 4)).Select
	lole_OLE.Selection.NumberFormat = "mm/dd/yyyy"
Else
	lole_Sheet.Range("K3:K" + String(ll_report_rows + 4)).Select
	lole_OLE.Selection.NumberFormat = "mm/dd/yyyy"
	
	lole_Sheet.Range("O3:O" + String(ll_report_rows + 4)).Select
	lole_OLE.Selection.NumberFormat = "mm/dd/yyyy"
End If

//Bold report arguments row
lole_OLE.cells[2,6] = "Skid Created Date: " + is_created_date_xl
lole_Sheet.Range("F2:F2").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[2,9] = "Status: " + is_status_xl
lole_Sheet.Range("I2:I2").Select
lole_OLE.Selection.Font.Bold = True

//Make some columns italics
If ls_dataobject = "d_report_inv_abc_scrap_skids" Or ls_dataobject = "d_report_inv_scrap_skids_all_cust" Then
	lole_Sheet.Range("M2:P" + String(ll_report_rows + 5)).Select
	lole_OLE.Selection.Font.Italic = True
Else
	lole_Sheet.Range("L2:O" + String(ll_report_rows + 5)).Select
	lole_OLE.Selection.Font.Italic = True
End If



//---

ll_total_line1 = ll_report_rows + 5
ll_total_line2 = ll_report_rows + 6

//Insert 2 lines for totals (below columnar data)
ls_range = "A" + String(ll_total_line1) + ":" + "N" + String(ll_total_line1)
lole_Sheet.Range(ls_range).Select
lole_Sheet.Application.Selection.EntireRow.Insert

//Insert totals
//ls_total_skid, ls_total_Net_wt
If ls_dataobject = "d_report_inv_abc_scrap_skids" Or ls_dataobject = "d_report_inv_scrap_skids_all_cust" Then
	lole_OLE.cells[ll_total_line1,1] = "----------------"
	ls_range = "A" + String(ll_total_line1) + ":" + "A" + String(ll_total_line1)
	lole_Sheet.Range(ls_range).Select
	//lole_OLE.Selection.Font.Bold = True
	lole_OLE.Selection.Font.FontStyle = "Bold"
	
	lole_OLE.cells[ll_total_line2,1] = "Total Skids: " + ls_total_skid
	ls_range = "A" + String(ll_total_line2) + ":" + "A" + String(ll_total_line2)
	lole_Sheet.Range(ls_range).Select
	//lole_OLE.Selection.Font.Bold = True
	lole_OLE.Selection.Font.FontStyle = "Bold" //Another way to bold a cell
	
	lole_OLE.cells[ll_total_line1,14] = "--------------------"
	ls_range = "N" + String(ll_total_line1) + ":" + "N" + String(ll_total_line1)
	lole_Sheet.Range(ls_range).Select
	//lole_OLE.Selection.Font.Bold = True
	lole_OLE.Selection.Font.FontStyle = "Bold"
	
	lole_OLE.cells[ll_total_line2,14] = "Total Net Wt: " + ls_total_Net_wt
	ls_range = "N" + String(ll_total_line2) + ":" + "N" + String(ll_total_line2)
	lole_Sheet.Range(ls_range).Select
	//lole_OLE.Selection.Font.Bold = True
	lole_OLE.Selection.Font.FontStyle = "Bold" //Another way to bold a cell
Else
	lole_OLE.cells[ll_total_line1,1] = "----------------"
	ls_range = "A" + String(ll_total_line1) + ":" + "A" + String(ll_total_line1)
	lole_Sheet.Range(ls_range).Select
	//lole_OLE.Selection.Font.Bold = True
	lole_OLE.Selection.Font.FontStyle = "Bold"
	
	lole_OLE.cells[ll_total_line2,1] = "Total Skids: " + ls_total_skid
	ls_range = "A" + String(ll_total_line2) + ":" + "A" + String(ll_total_line2)
	lole_Sheet.Range(ls_range).Select
	//lole_OLE.Selection.Font.Bold = True
	lole_OLE.Selection.Font.FontStyle = "Bold" //Another way to bold a cell
	
	lole_OLE.cells[ll_total_line1,13] = "--------------------"
	ls_range = "M" + String(ll_total_line1) + ":" + "M" + String(ll_total_line1)
	lole_Sheet.Range(ls_range).Select
	//lole_OLE.Selection.Font.Bold = True
	lole_OLE.Selection.Font.FontStyle = "Bold"
	
	lole_OLE.cells[ll_total_line2,13] = "Total Net Wt: " + ls_total_Net_wt
	ls_range = "M" + String(ll_total_line2) + ":" + "M" + String(ll_total_line2)
	lole_Sheet.Range(ls_range).Select
	//lole_OLE.Selection.Font.Bold = True
	lole_OLE.Selection.Font.FontStyle = "Bold" //Another way to bold a cell
End If

//Delete extra columns	
If ls_dataobject = "d_report_inv_abc_scrap_skids" Or ls_dataobject = "d_report_inv_scrap_skids_all_cust" Then
	lole_Sheet.columns("Q:T").Delete
	//lole_Sheet.columns("O:T").Delete
Else
	lole_Sheet.columns("P:T").Delete
End If

//Justify
//lole_OLE.Selection.HorizontalAlignment = -4108 //Center
//lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
//lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

If ls_dataobject = "d_report_inv_abc_scrap_skids" Or ls_dataobject = "d_report_inv_scrap_skids_all_cust" Then
	lole_Sheet.Range("A3:D" + String(ll_report_rows + 6)).Select
	lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
	
	lole_Sheet.Range("E3:F" + String(ll_report_rows + 6)).Select
	lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify
	
	lole_Sheet.Range("G3:K" + String(ll_report_rows + 6)).Select
	lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
	
	lole_Sheet.Range("L3:N" + String(ll_report_rows + 6)).Select
	lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify
	
	lole_Sheet.Range("O3:O" + String(ll_report_rows + 6)).Select
	lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
	
	lole_Sheet.Range("P3:P" + String(ll_report_rows + 6)).Select
	lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
	
Else //Selecting for one customer
	lole_Sheet.Range("A3:C" + String(ll_report_rows + 6)).Select
	lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
	
	lole_Sheet.Range("D3:E" + String(ll_report_rows + 6)).Select
	lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify
	
	lole_Sheet.Range("F3:J" + String(ll_report_rows + 6)).Select
	lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
	
	lole_Sheet.Range("K3:L" + String(ll_report_rows + 6)).Select
	lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify
	
	lole_Sheet.Range("M3:M" + String(ll_report_rows + 6)).Select
	lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify
	
	lole_Sheet.Range("N3:N" + String(ll_report_rows + 6)).Select
	lole_OLE.Selection.HorizontalAlignment = -4131 //Right justify
	
	lole_Sheet.Range("O3:O" + String(ll_report_rows + 6)).Select
	lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
End If

//---

//Save the changes
SetPointer(HourGlass!)
ld_today = Today()
ld_now = Now()
ls_today = String(ld_today,"yymmdd")
ls_now = String(ld_now,"hhmmss")

ls_folder = ProfileString(gs_ini_file, "EMAIL","email_out","c:\temp\")
If Right(ls_folder, 1) <> "\" Then ls_folder = ls_folder + "\"

ls_file = ls_folder + is_report_title_xl + "_" + ls_today + ls_now + ".xls"

//Check if ls_folder exists.
lb_directoryexists = DirectoryExists(ls_folder)

If Not lb_directoryexists Then //Folder ls_folder doesn't exist
	CreateDirectory(ls_folder) //Create ls_folder
End If

lole_sheet.SaveAs(ls_file, Excel8!)

//Open the worksheet for user to veiw and save
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

public subroutine wf_retrieve_all_scrap ();//Alex Gerlants. 05/12/2017. Begin
/*
Function:	wf_retrieve_all_scrap
Returns:		none
Arguments:	none
*/

String	ls_sql, ls_sql_new, ls_add_2sql_where, ls_status_list, ls_scrap_status_desc_temp
String	ls_s, ls_date_from, ls_date_to
Integer	li_scrap_status_temp, li_rtn
Long		ll_row, ll_i, ll_cust, ll_rows
Boolean	lb_other_arguments_selected = False

If dw_report.DataObject = "d_report_inv_scrap_skids_all_cust" Or dw_report.DataObject = "d_report_inv_scrap_skids_one_cust" Then //Just in case...

	If dw_report.DataObject = "d_report_inv_scrap_skids_all_cust" Then
		li_rtn = dw_report.SetSqlSelect(is_sql_orig_all_cust)
	Else
		li_rtn = dw_report.SetSqlSelect(is_sql_orig_one_cust)
	End If		
		
	ls_add_2sql_where = ""
	ls_status_list = ""
	
	If wf_all_statuses_unselected() Then dw_scrap_status_desc.SelectRow(0, True) //Select all statuses
	
	If rb_date.Checked Then
		lb_other_arguments_selected = True
		
		ls_date_from = em_from.Text
		ls_date_to = em_to.Text
		
		ls_add_2sql_where = ls_add_2sql_where + " and scrap_skid.scrap_date between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + &
									" and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )  "
	End If
	
	If rb_cust.Checked Then
		lb_other_arguments_selected = True
		
		ll_row = dw_customer.RowCount()
		For ll_i = 1 To ll_row
			If dw_customer.GetItemString(ll_i, "customer_short_name") = is_cust Then
				ll_cust = dw_customer.GetItemNumber(ll_i, "customer_id")
			End If
		Next
	
		ls_add_2sql_where = ls_add_2sql_where + " and scrap_skid.customer_id = " + String(ll_cust)
	End If
	
	ll_row = dw_scrap_status_desc.RowCount()
	
	For ll_i = 1 To ll_row
		If dw_scrap_status_desc.IsSelected(ll_i) Then
			ls_scrap_status_desc_temp = dw_scrap_status_desc.Object.scrap_status_desc[ll_i]
			is_status_list = is_status_list + ls_scrap_status_desc_temp + ", "
			
			li_scrap_status_temp = dw_scrap_status_desc.Object.scrap_status[ll_i]
			ls_status_list = ls_status_list + String(li_scrap_status_temp) + ","
		End If
	Next
	
	If ls_status_list <> "" Then
		//Remove the last comma
		is_status_list = Left(is_status_list, Len(is_status_list) - 2)
		
		ls_status_list = Left(ls_status_list, Len(ls_status_list) - 1)
		ls_add_2sql_where = ls_add_2sql_where + " and scrap_skid.skid_scrap_status in (" + ls_status_list + ")"
	End If
	
	If dw_report.DataObject = "d_report_inv_scrap_skids_all_cust" Then
		ls_sql_new = is_sql_orig_all_cust + ls_add_2sql_where
	Else
		ls_sql_new = is_sql_orig_one_cust + ls_add_2sql_where
	End if
		
	li_rtn = dw_report.SetSqlSelect(ls_sql_new)
	
	If Not lb_other_arguments_selected And wf_all_statuses_selected() Then
		MessageBox("Cannot Retrieve", "You are trying to retrieve all scrap skids in all statuses " + &
		"for all customers for all dates." + &
		"~n~rPlease unselect status 'Gone'; or select a customer, and/or a date range.", StopSign!)
	Else
		dw_report.SetTransObject(sqlca)
		ll_rows = dw_report.Retrieve()
		dw_report.Event ue_specs()
	End If
End if
//Alex Gerlants. 05/12/2017. End
end subroutine

public function boolean wf_all_statuses_selected ();//Alex Gerlants. 05/12/2017. Begin
/*
Function:	wf_all_statuses_selected
Returns:		boolean
Arguments:	none
*/
Boolean	lb_rtn = False
Integer	li_rows, li_row, li_selected_count = 0

li_rows = dw_scrap_status_desc.RowCount()

For li_row = 1 To li_rows
	If dw_scrap_status_desc.IsSelected(li_row) Then
		li_selected_count++
	End If
Next

If li_selected_count = li_rows Then lb_rtn = True

Return lb_rtn
//Alex Gerlants. 05/12/2017. End
end function

public function boolean wf_all_statuses_unselected ();//Alex Gerlants. 05/12/2017. Begin
/*
Function:	wf_all_statuses_unselected
Returns:		boolean
Arguments:	none
*/
Boolean	lb_rtn = False
Integer	li_rows, li_row, li_unselected_count = 0

li_rows = dw_scrap_status_desc.RowCount()

For li_row = 1 To li_rows
	If Not dw_scrap_status_desc.IsSelected(li_row) Then
		li_unselected_count++
	End If
Next

If li_unselected_count = li_rows Then lb_rtn = True

Return lb_rtn
//Alex Gerlants. 05/12/2017. End
end function

on w_report_customer_scrap_skid.create
int iCurrent
call super::create
this.cb_select_all=create cb_select_all
this.dw_scrap_status_desc=create dw_scrap_status_desc
this.cbx_default=create cbx_default
this.cb_1=create cb_1
this.cb_export=create cb_export
this.dw_report=create dw_report
this.cb_print=create cb_print
this.cb_close=create cb_close
this.cb_setzoom=create cb_setzoom
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_3=create gb_3
this.rb_custall=create rb_custall
this.rb_cust=create rb_cust
this.rb_dateall=create rb_dateall
this.rb_date=create rb_date
this.ddlb_cust=create ddlb_cust
this.dw_customer=create dw_customer
this.cb_retrieve=create cb_retrieve
this.rb_statusall=create rb_statusall
this.rb_status=create rb_status
this.ddlb_status=create ddlb_status
this.cb_sort=create cb_sort
this.cb_email=create cb_email
this.em_from=create em_from
this.em_to=create em_to
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_select_all
this.Control[iCurrent+2]=this.dw_scrap_status_desc
this.Control[iCurrent+3]=this.cbx_default
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_export
this.Control[iCurrent+6]=this.dw_report
this.Control[iCurrent+7]=this.cb_print
this.Control[iCurrent+8]=this.cb_close
this.Control[iCurrent+9]=this.cb_setzoom
this.Control[iCurrent+10]=this.gb_5
this.Control[iCurrent+11]=this.gb_4
this.Control[iCurrent+12]=this.gb_3
this.Control[iCurrent+13]=this.rb_custall
this.Control[iCurrent+14]=this.rb_cust
this.Control[iCurrent+15]=this.rb_dateall
this.Control[iCurrent+16]=this.rb_date
this.Control[iCurrent+17]=this.ddlb_cust
this.Control[iCurrent+18]=this.dw_customer
this.Control[iCurrent+19]=this.cb_retrieve
this.Control[iCurrent+20]=this.rb_statusall
this.Control[iCurrent+21]=this.rb_status
this.Control[iCurrent+22]=this.ddlb_status
this.Control[iCurrent+23]=this.cb_sort
this.Control[iCurrent+24]=this.cb_email
this.Control[iCurrent+25]=this.em_from
this.Control[iCurrent+26]=this.em_to
this.Control[iCurrent+27]=this.st_1
end on

on w_report_customer_scrap_skid.destroy
call super::destroy
destroy(this.cb_select_all)
destroy(this.dw_scrap_status_desc)
destroy(this.cbx_default)
destroy(this.cb_1)
destroy(this.cb_export)
destroy(this.dw_report)
destroy(this.cb_print)
destroy(this.cb_close)
destroy(this.cb_setzoom)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.rb_custall)
destroy(this.rb_cust)
destroy(this.rb_dateall)
destroy(this.rb_date)
destroy(this.ddlb_cust)
destroy(this.dw_customer)
destroy(this.cb_retrieve)
destroy(this.rb_statusall)
destroy(this.rb_status)
destroy(this.ddlb_status)
destroy(this.cb_sort)
destroy(this.cb_email)
destroy(this.em_from)
destroy(this.em_to)
destroy(this.st_1)
end on

event open;call super::open;Long 	ll_row, ll_c
DataStore	lds_report_inv_scrap_skids_all_cust, lds_report_inv_scrap_skids_one_cust //Alex Gerlants. 05/12/2017

//Alex Gerlants. 05/13/2016.
//Added the line below to fix a problem when user gets DB error "Invalid SQL Statement" trying
//to click on Retrieve button right after this window opens.
is_desc = dw_report.Describe("DataWindow.Table.Select")

dw_report.SetTransObject(SQLCA)
//dw_report.Retrieve()
//dw_report.Event ue_specs()

ll_row = dw_customer.RowCount()
IF ll_row > 0 THEN 
	FOR ll_c = 1 TO ll_row
		ddlb_cust.AddItem(dw_customer.GetItemString(ll_c, "customer_short_name"))
	NEXT
END IF

wf_settitle()

//Alex Gerlants. 05/12/2017. Begin
dw_scrap_status_desc.SetTransObject(sqlca)
li_rows_scrap_status_desc = dw_scrap_status_desc.Retrieve()

For ll_row = 1 To li_rows_scrap_status_desc
	dw_scrap_status_desc.SetItemStatus(ll_row, 0, Primary!, NotModified!) //So it will not ask to save data
Next

lds_report_inv_scrap_skids_all_cust = Create DataStore
lds_report_inv_scrap_skids_all_cust.DataObject = "d_report_inv_scrap_skids_all_cust"
is_sql_orig_all_cust = lds_report_inv_scrap_skids_all_cust.GetSqlSelect()

lds_report_inv_scrap_skids_one_cust = Create DataStore
lds_report_inv_scrap_skids_one_cust.DataObject = "d__report_inv_scrap_skids_one_cust"
is_sql_orig_one_cust = lds_report_inv_scrap_skids_one_cust.GetSqlSelect()
//Alex Gerlants. 05/12/2017. End
end event

event pfc_print;RETURN dw_report.Event pfc_print()
end event

event close;call super::close;f_display_app()
end event

event pfc_saveas;/*
Long ll_cust
String ls_cust, ls_title, ls_from, ls_to
//Save quote File
ll_cust = dw_customer.GetRow()
ls_cust = dw_customer.GetItemString(ll_cust, "customer_short_name")
ls_cust = Trim(ls_cust)

ls_from = string(Date(em_from.Text),"mmddyyyy")
ls_to = string(Date(em_to.Text),"mmddyyyy")

ls_title = ProfileString(gs_ini_file, "REPORT","file_path","c:\temp")+'\' +"Inv_" + ls_cust + '_' + ls_from + '_' + ls_to +".PSR"

IF dw_report.SaveAs(ls_title, PSReport!, FALSE) =-1 THEN
  	MessageBox("Quotation DataStore SaveAs", "Error") 
	RETURN
END IF

MessageBox("Success", "File has been saved as " + ls_title + " Successfully!" )
*/

end event

type cb_select_all from commandbutton within w_report_customer_scrap_skid
boolean visible = false
integer x = 2245
integer y = 474
integer width = 318
integer height = 90
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Select All"
end type

event clicked;Integer	li_row

//li_rows = dw_scrap_status_desc.RowCount()

If This.Text = "Select All" Then
	This.Text = "UnSelect All"
	
	For li_row = 1 To li_rows_scrap_status_desc
		dw_scrap_status_desc.SelectRow(li_row, True)
	Next
Else
	 This.Text = "Select All"
	 
	 For li_row = 1 To li_rows_scrap_status_desc
		dw_scrap_status_desc.SelectRow(li_row, False)
	Next
End If
end event

type dw_scrap_status_desc from datawindow within w_report_customer_scrap_skid
boolean visible = false
integer x = 2231
integer y = 22
integer width = 351
integer height = 432
integer taborder = 20
string dataobject = "d_scrap_status_desc"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;If This.IsSelected(row) Then
	This.SelectRow(row, False)
Else
	This.SelectRow(row, True)
End If
end event

type cbx_default from checkbox within w_report_customer_scrap_skid
integer x = 2673
integer y = 29
integer width = 322
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Default"
boolean checked = true
end type

event clicked;If This.Checked = True Then
	This.Checked = True
	//This.Text = "Default"
	
	gb_5.Visible = True
	rb_statusall.Visible = True
	rb_status.Visible = True
	ddlb_status.Visible = True
	
	dw_scrap_status_desc.Visible = False
	cb_select_all.Visible = False
	
	//dw_report.DataObject = is_report_dataobject_save //This excludes scrap statuses: 0 - Gone and 6 - PalletOnly
	
	If rb_custall.Checked Then
		dw_report.DataObject = "d_report_inv_abc_scrap_skids" 
	Else
		dw_report.DataObject = "d_report_inv_cust_scrap_skids" 
	End If
	
	dw_report.SetTransObject(SQLCA)
	is_desc = dw_report.Describe("DataWindow.Table.Select")
	wf_settitle()
	
Else
	This.Checked = False
	//This.Text = "All Scrap"
	
	gb_5.Visible = False
	rb_statusall.Visible = False
	rb_status.Visible = False
	ddlb_status.Visible = False
	
	dw_scrap_status_desc.Visible = True
	cb_select_all.Visible = True
	
	//is_report_dataobject_save = dw_report.DataObject //Save dataobject first
	dw_report.DataObject = "d_report_inv_scrap_skids_all_cust" //This selects all scrap statuses
	dw_scrap_status_desc.SelectRow(0, True) //Select all statuses
	cb_select_all.Text = "UnSelect All"
	
	wf_settitle()
End If
end event

type cb_1 from commandbutton within w_report_customer_scrap_skid
integer x = 1814
integer y = 2010
integer width = 380
integer height = 77
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Open in Excel"
end type

event clicked;Parent.ExportToExcel( dw_report, dw_report.RowCount() )
end event

type cb_export from u_cb within w_report_customer_scrap_skid
integer x = 1375
integer y = 2010
integer width = 406
integer height = 77
integer taborder = 60
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Export to Excel"
end type

event clicked;call super::clicked;SetPointer(HourGlass!)
String ls_file, ls_today, ls_now
Date ld_today
Time ld_now

ld_today = Today()
ld_now = Now()
ls_today = String(ld_today,"yymmdd")
ls_now = String(ld_now,"hhmm")

ls_file = ProfileString(gs_ini_file, "EMAIL","email_out","c:\temp")+'\Customer Scrap Skid Inventory Report_' + ls_today + ls_now + ".xls"
If dw_report.SaveAs(ls_file, Excel8!, True) = -1 Then //Alex Gerlants. 04/20/2016
   MessageBox("Data SaveAs", "Error")
	Return -1
Else
	MessageBox("Success!", "Data have been successfully exported to " + ls_file)
End If

Return 1
end event

type dw_report from u_dw within w_report_customer_scrap_skid
event ue_specs ( )
event ue_retrieve ( )
integer y = 586
integer width = 4407
integer height = 1408
integer taborder = 10
string dataobject = "d_report_inv_abc_scrap_skids"
boolean hscrollbar = true
end type

event ue_specs;Long ll_row, ll_c
Long ll_days, ll_skid, ll_pskid, ll_nskid
Date ld_skiddate

ll_row = this.RowCount()
IF ll_row <= 0 THEN RETURN
ll_skid = this.GetItemNumber(1, "scrap_skid_scrap_skid_num")	
ld_skiddate = Date(this.GetItemDateTime(1, "scrap_skid_scrap_date"))
ll_days = DaysAfter(ld_skiddate, Today())
this.SetItem(1, "duration", ll_days)
ll_pskid = ll_skid
IF ll_row > 1 THEN
	FOR ll_c = 2 TO ll_row
		ll_skid = this.GetItemNumber(ll_c, "scrap_skid_scrap_skid_num")
		IF ll_skid = ll_pskid THEN
			SetNULL(ll_days)
			this.SetItem(ll_c, "duration", ll_days)
		ELSE
			ll_pskid = ll_skid
			ld_skiddate = Date(this.GetItemDateTime(ll_c, "scrap_skid_scrap_date"))
			ll_days = DaysAfter(ld_skiddate, Today())
			this.SetItem(ll_c, "duration", ll_days)
		END IF
	NEXT
END IF
this.ResetUpdate()

end event

event ue_retrieve();String ls_modify, ls_rc

wf_settitle()
IF rb_custall.checked and rb_dateall.checked and rb_statusall.checked THEN
	IF MessageBox("Question", "It will take a long time to generate this report, continue?", Question!, YesNo!, 2) = 2 THEN
		RETURN
	END IF
END IF

ls_modify ="DataWindow.Table.Select = '" + wf_search_terms() + " '"
ls_rc = This.Modify(ls_modify)
IF ls_rc = "" THEN
	This.SetTransObject(SQLCA)
	This.Retrieve()
	This.Event ue_specs()
ELSE
	MessageBox("Error","Failure to modify datawindow!", StopSign!)
END IF

end event

event rbuttondown;//disable
Return 0
end event

event rbuttonup;//disable
Return 0
end event

event constructor;of_SetBase(TRUE)
of_SetPrintPreview(TRUE)
of_SetFilter(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)

SetTransObject(SQLCA)

end event

event dberror;call super::dberror;//Alex Gerlants. 05/13/2016. Begin
String	ls_sqlerrtext, ls_sqlsyntax
Long		ll_sqldbcode

ll_sqldbcode = sqldbcode
ls_sqlerrtext = sqlerrtext
ls_sqlsyntax = sqlsyntax
//Alex Gerlants. 05/13/2016. End
end event

event sqlpreview;call super::sqlpreview;//Alex Gerlants. 05/13/2016. Begin
String	ls_sqlsyntax

ls_sqlsyntax = sqlsyntax
//Alex Gerlants. 05/13/2016. End
end event

event retrieveend;call super::retrieveend;
String	ls_sql

ls_sql = This.GetSqlSelect()

wf_settitle() //Alex Gerlants. 05/12/2017
end event

type cb_print from u_cb within w_report_customer_scrap_skid
integer x = 2260
integer y = 2010
integer width = 307
integer height = 74
integer taborder = 110
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;Parent.Event pfc_print()
end event

type cb_close from u_cb within w_report_customer_scrap_skid
string tag = "Exit"
integer x = 2604
integer y = 2010
integer width = 322
integer height = 74
integer taborder = 120
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_setzoom from u_cb within w_report_customer_scrap_skid
integer x = 695
integer y = 2010
integer width = 307
integer height = 74
integer taborder = 90
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&SetZoom"
end type

event clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type gb_5 from u_gb within w_report_customer_scrap_skid
integer x = 1997
integer y = 3
integer width = 662
integer height = 208
integer taborder = 0
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Status"
end type

type gb_4 from u_gb within w_report_customer_scrap_skid
integer x = 987
integer y = 6
integer width = 998
integer height = 208
integer taborder = 0
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Created Date"
end type

type gb_3 from u_gb within w_report_customer_scrap_skid
integer x = 7
integer y = 6
integer width = 969
integer height = 208
integer taborder = 0
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Customer"
end type

type rb_custall from u_rb within w_report_customer_scrap_skid
integer x = 22
integer y = 61
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "All"
boolean checked = true
end type

event clicked;If cbx_default.Checked Then //Alex Gerlants. 05/12/2017
	IF this.Checked THEN
		ddlb_cust.Enabled = FALSE
		dw_report.DataObject = "d_report_inv_abc_scrap_skids" 
	ELSE
		ddlb_cust.Enabled = TRUE
		dw_report.DataObject = "d_report_inv_cust_scrap_skids" 
	END IF
	
	dw_report.SetTransObject(SQLCA)
	is_desc = dw_report.Describe("DataWindow.Table.Select")
//Alex Gerlants. 05/12/2017. Begin
Else
	dw_report.DataObject = "d_report_inv_scrap_skids_all_cust"
	
	If This.Checked Then
		ddlb_cust.Enabled = False
	Else
		ddlb_cust.Enabled = True
	End If	
End If
//Alex Gerlants. 05/12/2017. End

wf_settitle()

//dw_report.Event ue_retrieve()  //Alex Gerlants. 05/25/2017. Per Laura Anderson's request.
RETURN 1
end event

type rb_cust from u_rb within w_report_customer_scrap_skid
integer x = 22
integer y = 128
integer width = 241
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Show"
end type

event clicked;If cbx_default.Checked Then //Alex Gerlants. 05/12/2017
	IF this.Checked THEN 
		ddlb_cust.Enabled = TRUE
		dw_report.DataObject = "d_report_inv_cust_scrap_skids" 
	ELSE
		ddlb_cust.Enabled = FALSE
		dw_report.DataObject = "d_report_inv_abc_scrap_skids" 
	END IF
	dw_report.SetTransObject(SQLCA)
	is_desc = dw_report.Describe("DataWindow.Table.Select")
//Alex Gerlants. 05/12/2017. Begin
Else
	dw_report.DataObject = "d_report_inv_scrap_skids_all_cust"
	
	If This.Checked Then
		ddlb_cust.Enabled = True
	Else
		ddlb_cust.Enabled = False
	End If	
End If
//Alex Gerlants. 05/12/2017. End

wf_settitle()

RETURN 1

end event

type rb_dateall from u_rb within w_report_customer_scrap_skid
integer x = 1013
integer y = 61
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "All"
boolean checked = true
end type

event clicked;IF this.Checked THEN 
	em_from.Enabled = FALSE
	em_to.Enabled = FALSE
ELSE
	em_from.Enabled = TRUE
	em_from.Enabled = TRUE
END IF
wf_settitle()
//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.
RETURN 1

end event

type rb_date from u_rb within w_report_customer_scrap_skid
integer x = 1013
integer y = 125
integer width = 212
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "From"
end type

event clicked;IF this.Checked THEN 
	em_from.Enabled = TRUE
	em_from.Enabled = TRUE
ELSE
	em_from.Enabled = FALSE
	em_to.Enabled = FALSE
END IF
wf_settitle()
end event

type ddlb_cust from u_ddlb within w_report_customer_scrap_skid
integer x = 223
integer y = 125
integer width = 735
integer height = 992
integer taborder = 60
boolean bringtotop = true
boolean enabled = false
end type

event selectionchanged;Long ll_row, ll_i

is_cust = Text(index)
ll_row = dw_customer.RowCount()
FOR ll_i = 1 TO ll_row
	IF dw_customer.GetItemString(ll_i, "customer_short_name") = is_cust THEN
		dw_customer.Event RowFocusChanged(ll_i)
		dw_customer.SelectRow(0, False)
		dw_customer.SelectRow(ll_i, True)
	END IF
NEXT
dw_report.SetTransObject(SQLCA)
wf_settitle()

//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.

RETURN 1


end event

type dw_customer from u_dw within w_report_customer_scrap_skid
boolean visible = false
integer x = 2545
integer y = 1638
integer width = 102
integer height = 42
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_customer_short_display"
end type

event constructor;of_SetBase(TRUE)
of_SetRowManager(TRUE)
of_SetRowSelect(TRUE)
inv_RowSelect.of_SetStyle ( 0 )
SetTransObject(SQLCA)
Retrieve()

end event

type cb_retrieve from u_cb within w_report_customer_scrap_skid
integer x = 7
integer y = 2010
integer width = 307
integer height = 74
integer taborder = 70
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Retrieve"
boolean default = true
end type

event clicked;//Alex Gerlants. 05/12/2017. Begin
If cbx_default.Checked = False Then
	is_status_list = ""
	wf_retrieve_all_scrap()
Else
//Alex Gerlants. 05/12/2017. End
	dw_report.Event ue_retrieve()
End If //Alex Gerlants. 05/12/2017

Return 1
end event

type rb_statusall from u_rb within w_report_customer_scrap_skid
integer x = 2026
integer y = 54
integer width = 205
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "All"
boolean checked = true
end type

event clicked;IF this.Checked THEN
	ddlb_status.Enabled = FALSE
ELSE
	ddlb_status.Enabled = TRUE
END IF
wf_settitle()
//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.
RETURN 1

end event

type rb_status from u_rb within w_report_customer_scrap_skid
integer x = 2026
integer y = 118
integer width = 216
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Show"
end type

event clicked;IF this.Checked THEN
	ddlb_status.Enabled = TRUE
ELSE
	ddlb_status.Enabled = FALSE
	ddlb_status.selectItem("Done",1)
	is_status = "Done"
END IF
wf_settitle()	
end event

type ddlb_status from u_ddlb within w_report_customer_scrap_skid
integer x = 2231
integer y = 115
integer width = 399
integer height = 528
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 1090519039
boolean enabled = false
string item[] = {"Ready","InProcess","Canceled","OnHold"}
end type

event selectionchanged;is_status = Text(index)

wf_settitle()

//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.

RETURN 1

end event

type cb_sort from u_cb within w_report_customer_scrap_skid
integer x = 351
integer y = 2010
integer width = 307
integer height = 74
integer taborder = 80
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Sort"
end type

event clicked;SetPointer(HourGlass!)

String ls_null

SetNULL(ls_null)
dw_report.inv_sort.of_SetSort(ls_null)
dw_report.inv_sort.of_Sort()
end event

type cb_email from u_cb within w_report_customer_scrap_skid
integer x = 1039
integer y = 2010
integer width = 307
integer height = 74
integer taborder = 100
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Email"
end type

event clicked;SetPointer(HourGlass!)
String ls_file, ls_today, ls_now
Date ld_today
Time ld_now

ld_today = Today()
ld_now = Now()
ls_today = string(ld_today,"yymmdd")
ls_now = string(ld_now,"hhmm")

ls_file = ProfileString(gs_ini_file, "EMAIL","email_out","c:\temp")+'\m_' + ls_today + ls_now + ".html"
if dw_report.SaveAs(ls_file,HTMLtable!, false) =-1 then
   MessageBox("Email SaveAs", "Error")
	return -1
end if

f_send_email(0,ls_file)

RETURN 1
end event

type em_from from u_em within w_report_customer_scrap_skid
integer x = 1229
integer y = 125
integer width = 300
integer height = 67
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
double increment = 0
string minmax = ""
end type

event modified;call super::modified;rb_date.Checked = True
end event

event getfocus;call super::getfocus;rb_date.Checked = True
end event

type em_to from u_em within w_report_customer_scrap_skid
integer x = 1649
integer y = 125
integer width = 311
integer height = 67
integer taborder = 20
boolean bringtotop = true
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
double increment = 0
string minmax = ""
end type

event modified;call super::modified;rb_date.Checked = True
end event

event getfocus;call super::getfocus;rb_date.Checked = True
end event

type st_1 from statictext within w_report_customer_scrap_skid
integer x = 1554
integer y = 125
integer width = 88
integer height = 67
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "To"
boolean focusrectangle = false
end type

