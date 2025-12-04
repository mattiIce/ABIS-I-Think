$PBExportHeader$w_report_customer_skid.srw
$PBExportComments$inventory skid report based on different customers
forward
global type w_report_customer_skid from w_sheet
end type
type dw_skid_status_desc from datawindow within w_report_customer_skid
end type
type cb_1 from commandbutton within w_report_customer_skid
end type
type cb_export from u_cb within w_report_customer_skid
end type
type dw_report from u_dw within w_report_customer_skid
end type
type cb_print from u_cb within w_report_customer_skid
end type
type cb_close from u_cb within w_report_customer_skid
end type
type cb_setzoom from u_cb within w_report_customer_skid
end type
type gb_6 from u_gb within w_report_customer_skid
end type
type gb_5 from u_gb within w_report_customer_skid
end type
type gb_4 from u_gb within w_report_customer_skid
end type
type gb_3 from u_gb within w_report_customer_skid
end type
type rb_custall from u_rb within w_report_customer_skid
end type
type rb_cust from u_rb within w_report_customer_skid
end type
type rb_enduserall from u_rb within w_report_customer_skid
end type
type rb_enduser from u_rb within w_report_customer_skid
end type
type ddlb_cust from u_ddlb within w_report_customer_skid
end type
type ddlb_enduser from u_ddlb within w_report_customer_skid
end type
type dw_allcust from u_dw within w_report_customer_skid
end type
type dw_customer from u_dw within w_report_customer_skid
end type
type cb_retrieve from u_cb within w_report_customer_skid
end type
type rb_statusall from u_rb within w_report_customer_skid
end type
type rb_status from u_rb within w_report_customer_skid
end type
type ddlb_status from u_ddlb within w_report_customer_skid
end type
type cb_sort from u_cb within w_report_customer_skid
end type
type cb_email from u_cb within w_report_customer_skid
end type
type rb_dateall from u_rb within w_report_customer_skid
end type
type rb_date from u_rb within w_report_customer_skid
end type
type em_from from u_em within w_report_customer_skid
end type
type em_to from u_em within w_report_customer_skid
end type
type st_1 from statictext within w_report_customer_skid
end type
end forward

global type w_report_customer_skid from w_sheet
string tag = "ABCO production reports"
integer x = 4
integer y = 3
integer width = 4754
integer height = 1834
string title = "Inventory Report - Skid"
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
dw_skid_status_desc dw_skid_status_desc
cb_1 cb_1
cb_export cb_export
dw_report dw_report
cb_print cb_print
cb_close cb_close
cb_setzoom cb_setzoom
gb_6 gb_6
gb_5 gb_5
gb_4 gb_4
gb_3 gb_3
rb_custall rb_custall
rb_cust rb_cust
rb_enduserall rb_enduserall
rb_enduser rb_enduser
ddlb_cust ddlb_cust
ddlb_enduser ddlb_enduser
dw_allcust dw_allcust
dw_customer dw_customer
cb_retrieve cb_retrieve
rb_statusall rb_statusall
rb_status rb_status
ddlb_status ddlb_status
cb_sort cb_sort
cb_email cb_email
rb_dateall rb_dateall
rb_date rb_date
em_from em_from
em_to em_to
st_1 st_1
end type
global w_report_customer_skid w_report_customer_skid

type variables
String is_status
String is_cust
String is_enduser
String is_desc

//Report header variables
String	is_report_title_xl, is_status_xl, is_created_date_xl, is_enduser_xl //Alex Gerlants. 05/03/2016
Boolean	ib_use_package_num //Alex Gerlants. 06/15/2018. Arconic_Package_Num
end variables

forward prototypes
public function string wf_search_terms ()
public subroutine wf_settitle ()
public subroutine getcolumns (datawindow adw_dw, ref string as_columns[])
public function any getdata (datawindow adw_dw, long al_row, string as_column)
public function string inttocolumn (integer ai_col)
public subroutine exporttoexcel (datawindow adw_dw, long al_rows)
protected function string wf_job_spec (long al_job)
public function string wf_get_skid_status_desc (integer ai_skid_status_code)
end prototypes

event ue_whoami;RETURN "w_report_customer_skid"
end event

public function string wf_search_terms ();String ls_terms, ls_sort, ls_s
Long ll_row, ll_i
Long ll_line, ll_cust, ll_enduser, ll_status

//Alex Gerlants. Skid_Inv_Report_Status_Argument. 05/08/2019. Begin
Integer	li_skid_status_code
String	ls_skid_status_code, ls_skid_status_desc
Long		ll_rows
//Alex Gerlants. Skid_Inv_Report_Status_Argument. 05/08/2019. End

ls_s = is_desc
IF rb_cust.Checked THEN
	ll_row = dw_customer.RowCount()
	FOR ll_i = 1 TO ll_row
		IF dw_customer.GetItemString(ll_i, "customer_short_name") = is_cust THEN
			ll_cust = dw_customer.GetItemNumber(ll_i, "customer_id")
		END IF
	NEXT
	ls_s = ls_s + " and (~~~"CUSTOMER_ORDER~~~".~~~"ORIG_CUSTOMER_ID~~~" = " + String(ll_cust) + " )"
END IF

IF rb_enduser.Checked THEN
	ll_row = dw_allcust.RowCount()
	FOR ll_i = 1 TO ll_row
		IF dw_allcust.GetItemString(ll_i, "customer_short_name") = is_enduser THEN
			ll_enduser = dw_allcust.GetItemNumber(ll_i, "customer_id")
		END IF
	NEXT
	ls_s = ls_s + " and ( ~~~"CUSTOMER_ORDER~~~".~~~"ENDUSER_ID~~~" = " + String(ll_enduser) + " )"
END IF

IF rb_date.Checked THEN
	ls_s = ls_s + " and (TO_DATE(TO_CHAR(~~~"SHEET_SKID~~~".~~~"SKID_DATE~~~",~~~'DD-MON-YYYY~~~'),~~~'DD-MON-YYYY~~~'  ) >= " + " TO_DATE(~~~'" + em_from.Text + "~~~',~~~'mm/dd/yyyy~~~' )" + " )"  
	ls_s = ls_s + " and (TO_DATE(TO_CHAR(~~~"SHEET_SKID~~~".~~~"SKID_DATE~~~",~~~'DD-MON-YYYY~~~'),~~~'DD-MON-YYYY~~~'  )  <= " + " TO_DATE(~~~'" + em_to.Text + "~~~',~~~'mm/dd/yyyy~~~' )" + " )"  //21-DEC-1998 format
END IF


//Alex Gerlants. Skid_Inv_Report_Status_Argument. 05/08/2019. Begin
dw_skid_status_desc.AcceptText()

ll_rows = dw_skid_status_desc.RowCount()

If dw_skid_status_desc.RowCount() > 0 Then
	ls_skid_status_code = dw_skid_status_desc.Object.skid_status_desc[1]
	
	If ls_skid_status_code <> "ALL" Then
		If IsNumber(ls_skid_status_code) Then
			li_skid_status_code = Integer(ls_skid_status_code)
			ls_s = ls_s + " and ( ~~~"SHEET_SKID~~~".~~~"SKID_SHEET_STATUS~~~" = " + String(li_skid_status_code) + " )"
		End If
	End If
End If



//IF rb_status.Checked THEN
//	CHOOSE CASE UPPER(Trim(is_status))
////		CASE "GONE"
////			ll_status = 0
//		CASE "INPROCESS"
//			ll_status = 1
//		CASE "READY"
//			ll_status = 2
//		CASE "CANCELED"
//			ll_status = 3
//		CASE "ONHOLD"
//			ll_status = 4
//		CASE "PRERECAP"
//			ll_status = 5
////		CASE "TAREONLY"
////			ll_status = 6
//		CASE "PARTIAL"
//			ll_status = 7
//		CASE "SAMPLE"
//			ll_status = 12
//		CASE "WH-READY"
//			ll_status = 8
//		CASE "WH-COMING"
//			ll_status = 9
//		CASE "WH-SORT"
//			ll_status = 10
//		CASE "WH-GONE"
//			ll_status = 11
//		CASE "PARTIAL-RD"
//			ll_status = 13
//		
//	END CHOOSE
//	ls_s = ls_s + " and ( ~~~"SHEET_SKID~~~".~~~"SKID_SHEET_STATUS~~~" = " + String(ll_status) + " )"
//END IF
//Alex Gerlants. Skid_Inv_Report_Status_Argument. 05/08/2019. End

ls_terms = ls_terms + ls_s + ls_sort

RETURN ls_terms
end function

public subroutine wf_settitle ();String ls_modstring,ls_s
Long ll_c

//Alex Gerlants. Skid_Inv_Report_Status_Argument. 05/08/2019. Begin
Integer	li_skid_status_code
String	ls_skid_status_code, ls_skid_status_desc
Long		ll_rows

dw_skid_status_desc.AcceptText()

ll_rows = dw_skid_status_desc.RowCount()

If dw_skid_status_desc.RowCount() > 0 Then
	ls_skid_status_code = dw_skid_status_desc.Object.skid_status_desc[1]
	If IsNull(ls_skid_status_code) Then ls_skid_status_code = "ALL"
	
	If ls_skid_status_code = "ALL" Then
		ls_s = "ALL"
	Else
		If IsNumber(ls_skid_status_code) Then
			li_skid_status_code = Integer(ls_skid_status_code)
			ls_skid_status_desc = wf_get_skid_status_desc(li_skid_status_code)
			ls_s = ls_skid_status_desc
		End If
	End If	
End If

//IF rb_statusall.Checked THEN
//	ls_s = "ALL"		
//ELSE
//	ls_s = is_status
//END IF
//Alex Gerlants. Skid_Inv_Report_Status_Argument. 05/08/2019. End

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

IF rb_enduserall.Checked THEN
	ls_s = "ALL"		
ELSE
	ls_s = is_enduser
END IF

ls_modstring = "enduser_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 

is_enduser_xl = ls_s //Alex Gerlants. 05/03/2016

IF rb_custall.Checked THEN
	ls_s = "ABCO Customer Skid Inventory Report" 	
ELSE
	ls_s = Trim(is_cust) + " Skid Inventory Report"
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

// Export the data to Excel
OleObject 	lole_OLE, lole_Sheet
String 		ls_Columns[]
Long 			ll_report_rows, ll_Row, ll_Col, ll_Cols, ll_total_line1, ll_total_line2
String		ls_range, ls_total_prod_item_net_wt
Boolean		lb_rtn, lb_directoryexists

String 		ls_file, ls_today, ls_now, ls_folder
Date 			ld_today
Time 			ld_now
Integer		li_answer, li_count

ll_report_rows = dw_report.RowCount()

If ll_report_rows > 0 Then
	//Get report totals
	ls_total_prod_item_net_wt = String(dw_report.Object.compute_2[1])
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
If dw_report.DataObject = "d_report_inv_abc_skids" Then
	lole_OLE.cells[1,1]  = "Skid #"
	lole_OLE.cells[1,2]  = "Job #"
	lole_OLE.cells[1,3]  = "Customer"
	lole_OLE.cells[1,4]  = "End User"
	lole_OLE.cells[1,5]  = "EndUser Part #"
	lole_OLE.cells[1,6]  = "Pieces"
	lole_OLE.cells[1,7]  = "Net Weight"
	lole_OLE.cells[1,8]  = "Status"
	lole_OLE.cells[1,9]  = "Coil Orig #"
	lole_OLE.cells[1,10]  = "Spec"
	lole_OLE.cells[1,11] = "Material"
	lole_OLE.cells[1,12] = "Lot #"
	lole_OLE.cells[1,13] = "Item PCs"
	lole_OLE.cells[1,14] = "Item NetWT"
	lole_OLE.cells[1,15] = "Duration"
ElseIf dw_report.DataObject = "d_report_inv_cust_skids" Then
	lole_OLE.cells[1,1]  = "Skid #"
	lole_OLE.cells[1,2]  = "End User"
	lole_OLE.cells[1,3]  = "Ab Job"
	lole_OLE.cells[1,4]  = "EndUser Part #"
	lole_OLE.cells[1,5]  = "Pieces"
	lole_OLE.cells[1,6]  = "Net Wt."
	lole_OLE.cells[1,7]  = "Status"
	lole_OLE.cells[1,8]  = "Coil Orig #"
	lole_OLE.cells[1,9]  = "Spec"
	lole_OLE.cells[1,10] = "Material"
	lole_OLE.cells[1,11] = "Lot #"
	lole_OLE.cells[1,12] = "Item PCs"
	lole_OLE.cells[1,13] = "NonConf."
	lole_OLE.cells[1,14] = "Item NetWT"
	lole_OLE.cells[1,15] = "Duration"
Else
	lole_OLE.cells[1,1]  = "Skid #"
	lole_OLE.cells[1,2]  = "End User"
	lole_OLE.cells[1,3]  = "Ab Job"
	lole_OLE.cells[1,4]  = "EndUser Part #"
	lole_OLE.cells[1,5]  = "Pieces"
	lole_OLE.cells[1,6]  = "Net Wt."
	lole_OLE.cells[1,7]  = "Status"
	lole_OLE.cells[1,8]  = "Coil Orig #"
	lole_OLE.cells[1,9]  = "Spec"
	lole_OLE.cells[1,10] = "Material"
	lole_OLE.cells[1,11] = "Lot #"
	lole_OLE.cells[1,12] = "Item PCs"
	lole_OLE.cells[1,13] = "NonConf."
	lole_OLE.cells[1,14] = "Item NetWT"
	lole_OLE.cells[1,15] = "Duration"
	lole_OLE.cells[1,16] = "Package No"
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

//Change date format for current date
lole_OLE.cells[1,14] = String(Today(), "mm/dd/yyyy")
lole_Sheet.Range("N1:N1").Select
lole_OLE.Selection.Font.Bold = True

//Bold report arguments row
lole_OLE.cells[2,3] = "End User: " + is_enduser_xl
lole_Sheet.Range("C2:C2").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[2,8] = "Status: " + is_status_xl
lole_Sheet.Range("H2:H2").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[2,10] = "Created Date: " + is_created_date_xl
lole_Sheet.Range("J2:J2").Select
lole_OLE.Selection.Font.Bold = True

//---

ll_total_line1 = ll_report_rows + 5
ll_total_line2 = ll_report_rows + 6

//Insert 2 lines for totals (below columnar data)
ls_range = "A" + String(ll_total_line1) + ":" + "N" + String(ll_total_line1)
lole_Sheet.Range(ls_range).Select
lole_Sheet.Application.Selection.EntireRow.Insert

//Insert totals
If dw_report.DataObject = "d_report_inv_abc_skids" Then
	lole_OLE.cells[ll_total_line1,7] = "----------------"
	ls_range = "G" + String(ll_total_line1) + ":" + "G" + String(ll_total_line1)
	lole_Sheet.Range(ls_range).Select
	//lole_OLE.Selection.Font.Bold = True
	lole_OLE.Selection.Font.FontStyle = "Bold"
	
	lole_OLE.cells[ll_total_line2,7] = "Total: " + ls_total_prod_item_net_wt
	ls_range = "G" + String(ll_total_line2) + ":" + "G" + String(ll_total_line2)
	lole_Sheet.Range(ls_range).Select
	//lole_OLE.Selection.Font.Bold = True
	lole_OLE.Selection.Font.FontStyle = "Bold" //Another way to bold a cell
	
	//lole_OLE.cells[ll_total_line2,6] = ls_total_prod_item_net_wt
	//ls_range = "F" + String(ll_total_line2) + ":" + "F" + String(ll_total_line2)
	//lole_Sheet.Range(ls_range).Select
	//lole_OLE.Selection.Font.Bold = True
	//lole_OLE.Selection.Font.FontStyle = "Bold" //Another way to bold a cell
Else
	lole_OLE.cells[ll_total_line1,5] = "----------------"
	ls_range = "E" + String(ll_total_line1) + ":" + "E" + String(ll_total_line1)
	lole_Sheet.Range(ls_range).Select
	//lole_OLE.Selection.Font.Bold = True
	lole_OLE.Selection.Font.FontStyle = "Bold"
	
	lole_OLE.cells[ll_total_line2,5] = "Total: " + ls_total_prod_item_net_wt
	ls_range = "E" + String(ll_total_line2) + ":" + "E" + String(ll_total_line2)
	lole_Sheet.Range(ls_range).Select
	//lole_OLE.Selection.Font.Bold = True
	lole_OLE.Selection.Font.FontStyle = "Bold" //Another way to bold a cell
	
	//lole_OLE.cells[ll_total_line2,6] = ls_total_prod_item_net_wt
	//ls_range = "D" + String(ll_total_line2) + ":" + "D" + String(ll_total_line2)
	//lole_Sheet.Range(ls_range).Select
	//lole_OLE.Selection.Font.Bold = True
	//lole_OLE.Selection.Font.FontStyle = "Bold" //Another way to bold a cell
End If

//Delete extra columns	
//If dw_report.DataObject = "d_report_inv_abc_skids" Then
//	lole_Sheet.columns("O:T").Delete
//	lole_Sheet.columns("O:T").Delete
//Else

If dw_report.DataObject = "d_report_inv_cust_skids_pn" Then
	lole_Sheet.columns("Q:X").Delete
Else
	lole_Sheet.columns("P:W").Delete
End If

//Justify
//lole_OLE.Selection.HorizontalAlignment = -4108 //Center
//lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
//lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

If dw_report.DataObject = "d_report_inv_abc_skids" Then
	lole_Sheet.Range("A3:E" + String(ll_report_rows + 6)).Select
	lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
	
	lole_Sheet.Range("F3:G" + String(ll_report_rows + 6)).Select
	lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify
	
	lole_Sheet.Range("H3:L" + String(ll_report_rows + 6)).Select
	lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
	
	lole_Sheet.Range("M3:O" + String(ll_report_rows + 6)).Select
	lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify
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
	lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
	
	lole_Sheet.Range("N3:N" + String(ll_report_rows + 6)).Select
	lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify
End If

//Underline column headers
lole_Sheet.Range("A4:O4").Select
lole_OLE.Selection.Font.Underline = True

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

protected function string wf_job_spec (long al_job);SetPointer(HourGlass!)

String ls_spec
Long ll_order
Int li_item
String ls_shape
Real lr_l, lr_s, lr_w, lr_gauge

CONNECT USING SQLCA;

SELECT order_abc_num, order_item_num INTO :ll_order, :li_item
FROM ab_job 
WHERE ab_job_num = :al_job
USING SQLCA;

SELECT sheet_type, gauge INTO :ls_shape, :lr_gauge
FROM order_item
WHERE order_abc_num = :ll_order AND order_item_num = :li_item
USING SQLCA;

ls_spec = String(lr_gauge, "#.#####")
CHOOSE CASE Upper(Trim(ls_shape))
	CASE "RECTANGLE"
		SELECT rt_length, rt_width INTO :lr_l, :lr_w
		FROM rectangle
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + " X " + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "PARALLELOGRAM"
		SELECT p_length, p_width INTO :lr_l, :lr_w
		FROM parallelogram
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + " X " + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "FENDER"
		SELECT fe_side INTO :lr_l
		FROM fender
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + " X " + String(lr_l, "#####.#####") 
	CASE "CHEVRON"
		SELECT ch_length, ch_width INTO :lr_l, :lr_w
		FROM chevron
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + " X " + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "CIRCLE"
		SELECT c_diameter INTO :lr_l
		FROM circle
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + " X " + String(lr_l, "#####.#####") 
	CASE "TRAPEZOID"
		SELECT tr_long_length, tr_short_length, tr_width INTO :lr_l, :lr_s, :lr_w
		FROM trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + " X " + String(lr_w, "#####.#####") + " X " + String(lr_s, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "L.TRAPEZOID"
		SELECT ltr_long_length, ltr_short_length, ltr_width INTO :lr_l, :lr_s, :lr_w
		FROM left_trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + " X " + String(lr_w, "#####.#####") + " X " + String(lr_s, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "R.TRAPEZOID"
		SELECT rtr_long_length, rtr_short_length, rtr_width INTO :lr_l, :lr_s, :lr_w
		FROM right_trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + " X " + String(lr_w, "#####.#####") + " X " + String(lr_s, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "OTHER"
		SELECT x_1, x_2 INTO :lr_w, :lr_l
		FROM x1_shape
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + " X " + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE ELSE
		ls_spec = ls_spec + " X " + "VAR"
END CHOOSE	

RETURN ls_spec
end function

public function string wf_get_skid_status_desc (integer ai_skid_status_code);//Alex Gerlants. Skid_Inv_Report_Status_Argument. 05/08/2019. Begin
/*
Function:	wf_get_skid_status_desc
Returns:		string	<== skid_status.skid_status_desc
Arguments:	value	string	as_skid_status_desc
*/
Integer				li_rtn
Long					ll_found_row, ll_rows
String				ls_find_string, ls_skid_status_desc
DataWindowChild	ldwc

li_rtn = dw_skid_status_desc.GetChild("skid_status_desc", ldwc)

If li_rtn = 1 Then //OK
	ls_find_string = "skid_status_code = " + String(ai_skid_status_code)
	ll_found_row = ldwc.Find(ls_find_string, 1, ldwc.RowCount())
	
	If ll_found_row > 0 Then
		ls_skid_status_desc = ldwc.GetItemString(ll_found_row, "skid_status_desc")
	End If
Else
	ls_skid_status_desc = ""
End If

Return ls_skid_status_desc
//Alex Gerlants. Skid_Inv_Report_Status_Argument. 05/08/2019. End
end function

on w_report_customer_skid.create
int iCurrent
call super::create
this.dw_skid_status_desc=create dw_skid_status_desc
this.cb_1=create cb_1
this.cb_export=create cb_export
this.dw_report=create dw_report
this.cb_print=create cb_print
this.cb_close=create cb_close
this.cb_setzoom=create cb_setzoom
this.gb_6=create gb_6
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_3=create gb_3
this.rb_custall=create rb_custall
this.rb_cust=create rb_cust
this.rb_enduserall=create rb_enduserall
this.rb_enduser=create rb_enduser
this.ddlb_cust=create ddlb_cust
this.ddlb_enduser=create ddlb_enduser
this.dw_allcust=create dw_allcust
this.dw_customer=create dw_customer
this.cb_retrieve=create cb_retrieve
this.rb_statusall=create rb_statusall
this.rb_status=create rb_status
this.ddlb_status=create ddlb_status
this.cb_sort=create cb_sort
this.cb_email=create cb_email
this.rb_dateall=create rb_dateall
this.rb_date=create rb_date
this.em_from=create em_from
this.em_to=create em_to
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_skid_status_desc
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_export
this.Control[iCurrent+4]=this.dw_report
this.Control[iCurrent+5]=this.cb_print
this.Control[iCurrent+6]=this.cb_close
this.Control[iCurrent+7]=this.cb_setzoom
this.Control[iCurrent+8]=this.gb_6
this.Control[iCurrent+9]=this.gb_5
this.Control[iCurrent+10]=this.gb_4
this.Control[iCurrent+11]=this.gb_3
this.Control[iCurrent+12]=this.rb_custall
this.Control[iCurrent+13]=this.rb_cust
this.Control[iCurrent+14]=this.rb_enduserall
this.Control[iCurrent+15]=this.rb_enduser
this.Control[iCurrent+16]=this.ddlb_cust
this.Control[iCurrent+17]=this.ddlb_enduser
this.Control[iCurrent+18]=this.dw_allcust
this.Control[iCurrent+19]=this.dw_customer
this.Control[iCurrent+20]=this.cb_retrieve
this.Control[iCurrent+21]=this.rb_statusall
this.Control[iCurrent+22]=this.rb_status
this.Control[iCurrent+23]=this.ddlb_status
this.Control[iCurrent+24]=this.cb_sort
this.Control[iCurrent+25]=this.cb_email
this.Control[iCurrent+26]=this.rb_dateall
this.Control[iCurrent+27]=this.rb_date
this.Control[iCurrent+28]=this.em_from
this.Control[iCurrent+29]=this.em_to
this.Control[iCurrent+30]=this.st_1
end on

on w_report_customer_skid.destroy
call super::destroy
destroy(this.dw_skid_status_desc)
destroy(this.cb_1)
destroy(this.cb_export)
destroy(this.dw_report)
destroy(this.cb_print)
destroy(this.cb_close)
destroy(this.cb_setzoom)
destroy(this.gb_6)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.rb_custall)
destroy(this.rb_cust)
destroy(this.rb_enduserall)
destroy(this.rb_enduser)
destroy(this.ddlb_cust)
destroy(this.ddlb_enduser)
destroy(this.dw_allcust)
destroy(this.dw_customer)
destroy(this.cb_retrieve)
destroy(this.rb_statusall)
destroy(this.rb_status)
destroy(this.ddlb_status)
destroy(this.cb_sort)
destroy(this.cb_email)
destroy(this.rb_dateall)
destroy(this.rb_date)
destroy(this.em_from)
destroy(this.em_to)
destroy(this.st_1)
end on

event open;call super::open;Long ll_row, ll_c

Integer				li_rtn //Alex Gerlants. Skid_Inv_Report_Status_Argument. 05/08/2019
Long					ll_rows, ll_row_inserted //Alex Gerlants. Skid_Inv_Report_Status_Argument. 05/08/2019
DataWindowChild	ldwc //Alex Gerlants. Skid_Inv_Report_Status_Argument. 05/08/2019
String				ls_skid_status_desc //Alex Gerlants. Skid_Inv_Report_Status_Argument. 05/08/2019

dw_report.SetTransObject(SQLCA)
//dw_report.Retrieve()
//dw_report.Event ue_specs()

ll_row = dw_allcust.RowCount()
IF ll_row > 0 THEN 
	FOR ll_c = 1 TO ll_row
		ddlb_enduser.AddItem(dw_allcust.GetItemString(ll_c, "customer_short_name"))
	NEXT
END IF
ll_row = dw_customer.RowCount()
IF ll_row > 0 THEN 
	FOR ll_c = 1 TO ll_row
		ddlb_cust.AddItem(dw_customer.GetItemString(ll_c, "customer_short_name"))
	NEXT
END IF

//Alex Gerlants. Skid_Inv_Report_Status_Argument. 05/08/2019. Begin
dw_skid_status_desc.InsertRow(0)

li_rtn = dw_skid_status_desc.GetChild("skid_status_desc", ldwc)

If li_rtn = 1 Then //OK
	ldwc.SetTransObject(sqlca)
	ll_rows = ldwc.Retrieve()
	
	If ll_rows > 0 Then
		ll_row_inserted = ldwc.InsertRow(1)
		
		If ll_row_inserted > 0 Then
			//ldwc.SetItem(ll_row_inserted, "skid_status_code", -99)
			ldwc.SetItem(ll_row_inserted, "skid_status_desc", "ALL")
		End If
		
		dw_skid_status_desc.Object.skid_status_desc[1] = "ALL"
	End If
End If
//Alex Gerlants. Skid_Inv_Report_Status_Argument. 05/08/2019. End


wf_settitle()
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

type dw_skid_status_desc from datawindow within w_report_customer_skid
integer x = 1953
integer y = 115
integer width = 413
integer height = 83
integer taborder = 11
string title = "none"
string dataobject = "d_skid_status_desc"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_report_customer_skid
integer x = 2077
integer y = 1629
integer width = 380
integer height = 77
integer taborder = 30
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

type cb_export from u_cb within w_report_customer_skid
integer x = 1584
integer y = 1629
integer width = 406
integer height = 77
integer taborder = 140
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

ls_file = ProfileString(gs_ini_file, "EMAIL","email_out","c:\temp")+'\Customer Skid Inventory Report_' + ls_today + ls_now + ".xls"
If dw_report.SaveAs(ls_file, Excel8!, True) = -1 Then //Alex Gerlants. 04/20/2016
   MessageBox("Data SaveAs", "Error")
	Return -1
Else
	messageBox("Success", "Data have been successfully exported to " + ls_file)
End If

Return 1
end event

type dw_report from u_dw within w_report_customer_skid
event ue_specs ( )
event ue_retrieve ( )
integer y = 227
integer width = 4714
integer height = 1389
integer taborder = 10
string dataobject = "d_report_inv_abc_skids"
boolean hscrollbar = true
end type

event ue_specs;Long ll_row, ll_c
Long ll_job, ll_bal_due
String ls_spec

ll_row = this.RowCount()
IF ll_row > 0 THEN
	FOR ll_c = 1 TO ll_row
		ll_job = this.GetItemNumber(ll_c, "ab_job_ab_job_num")
		ls_spec = wf_job_spec(ll_job)
		this.SetItem(ll_c, "cspec_t", ls_spec)
	NEXT
END IF
this.ResetUpdate()

end event

event ue_retrieve();String ls_modify, ls_rc

IF rb_custall.Checked THEN
	this.DataObject = "d_report_inv_abc_skids" 
ELSE
	//Alex Gerlants. 06/15/2018. Arconic_Package_Num. Begin
	//this.DataObject = "d_report_inv_cust_skids"
	
	If ib_use_package_num Then
		dw_report.DataObject = "d_report_inv_cust_skids_pn"
	Else
		dw_report.DataObject = "d_report_inv_cust_skids"
	End If
	//Alex Gerlants. 06/15/2018. Arconic_Package_Num. End
END IF

this.SetTransObject(SQLCA)
is_desc = this.Describe("DataWindow.Table.Select")

wf_settitle()
IF rb_custall.checked and rb_enduserall.checked and rb_statusall.checked THEN
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

event sqlpreview;call super::sqlpreview;String	ls_sql

ls_sql = sqlsyntax
end event

type cb_print from u_cb within w_report_customer_skid
integer x = 2538
integer y = 1629
integer width = 307
integer height = 74
integer taborder = 130
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;Parent.Event pfc_print()
end event

type cb_close from u_cb within w_report_customer_skid
string tag = "Exit"
integer x = 2937
integer y = 1629
integer width = 322
integer height = 74
integer taborder = 140
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_setzoom from u_cb within w_report_customer_skid
integer x = 834
integer y = 1629
integer width = 307
integer height = 74
integer taborder = 110
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&SetZoom"
end type

event clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type gb_6 from u_gb within w_report_customer_skid
integer x = 2604
integer y = 3
integer width = 852
integer height = 208
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 80269524
string text = "Created Date"
end type

type gb_5 from u_gb within w_report_customer_skid
integer x = 1927
integer y = 3
integer width = 662
integer height = 208
integer taborder = 0
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Status"
end type

type gb_4 from u_gb within w_report_customer_skid
integer x = 936
integer y = 6
integer width = 984
integer height = 208
integer taborder = 0
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "End User"
end type

type gb_3 from u_gb within w_report_customer_skid
integer x = 7
integer y = 6
integer width = 918
integer height = 208
integer taborder = 0
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Customer"
end type

type rb_custall from u_rb within w_report_customer_skid
integer x = 22
integer y = 61
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "All"
boolean checked = true
end type

event clicked;IF this.Checked THEN
	ddlb_cust.Enabled = FALSE
	dw_report.DataObject = "d_report_inv_abc_skids" 
ELSE
	ddlb_cust.Enabled = TRUE
	dw_report.DataObject = "d_report_inv_cust_skids"
END IF

dw_report.SetTransObject(SQLCA)
is_desc = dw_report.Describe("DataWindow.Table.Select")
wf_settitle()

//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.
RETURN 1
end event

type rb_cust from u_rb within w_report_customer_skid
integer x = 22
integer y = 128
integer width = 241
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Show"
end type

event clicked;IF this.Checked THEN 
	ddlb_cust.Enabled = TRUE
	dw_report.DataObject = "d_report_inv_cust_skids"
ELSE
	ddlb_cust.Enabled = FALSE
	dw_report.DataObject = "d_report_inv_abc_skids" 
END IF
dw_report.SetTransObject(SQLCA)
is_desc = dw_report.Describe("DataWindow.Table.Select")

wf_settitle()

RETURN 1

end event

type rb_enduserall from u_rb within w_report_customer_skid
integer x = 955
integer y = 61
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "All"
boolean checked = true
end type

event clicked;IF this.Checked THEN 
	ddlb_enduser.Enabled = FALSE
ELSE
	ddlb_enduser.Enabled = TRUE
END IF
wf_settitle()
//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.
RETURN 1

end event

type rb_enduser from u_rb within w_report_customer_skid
integer x = 955
integer y = 128
integer width = 216
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Show"
end type

event clicked;IF this.Checked THEN 
	ddlb_enduser.Enabled = TRUE
ELSE
	ddlb_enduser.Enabled = FALSE
END IF
wf_settitle()
end event

type ddlb_cust from u_ddlb within w_report_customer_skid
integer x = 223
integer y = 118
integer width = 688
integer height = 992
integer taborder = 30
boolean bringtotop = true
boolean enabled = false
end type

event selectionchanged;Long ll_row, ll_i
Long	ll_customer_id //Alex Gerlants. 06/15/2018. Arconic_Package_Num

is_cust = Text(index)
ll_row = dw_customer.RowCount()
FOR ll_i = 1 TO ll_row
	IF dw_customer.GetItemString(ll_i, "customer_short_name") = is_cust THEN
		dw_customer.Event RowFocusChanged(ll_i)
		dw_customer.SelectRow(0, False)
		dw_customer.SelectRow(ll_i, True)
		
		//Alex Gerlants. 06/15/2018. Arconic_Package_Num. Begin
		ll_customer_id = dw_customer.Object.customer_id[ll_i]
		f_get_use_package_num_2customer(ll_customer_id, sqlca, ib_use_package_num) //ib_use_package_num is by reference in f_get_use_package_num_2customer()
		
		If ib_use_package_num Then
			dw_report.DataObject = "d_report_inv_cust_skids_pn"
		Else
			dw_report.DataObject = "d_report_inv_cust_skids"
		End If
		//Alex Gerlants. 06/15/2018. Arconic_Package_Num. End
	END IF
NEXT
dw_report.SetTransObject(SQLCA)
wf_settitle()

//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.

RETURN 1


end event

type ddlb_enduser from u_ddlb within w_report_customer_skid
integer x = 1163
integer y = 118
integer width = 742
integer height = 1059
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 1090519039
boolean enabled = false
end type

event selectionchanged;Long ll_row, ll_i
String ls_text

ls_text = Text(index)
is_enduser = ls_text
ll_row = dw_allcust.RowCount()
FOR ll_i = 1 TO ll_row
	IF dw_allcust.GetItemString(ll_i, "customer_short_name") = ls_text THEN
		dw_allcust.Event RowFocusChanged(ll_i)
		dw_allcust.SelectRow(0, False)
		dw_allcust.SelectRow(ll_i, True)
	END IF
NEXT
dw_report.SetTransObject(SQLCA)
wf_settitle()

//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.

RETURN 1


end event

type dw_allcust from u_dw within w_report_customer_skid
boolean visible = false
integer x = 2450
integer y = 1635
integer width = 91
integer height = 51
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_customer_short_list"
end type

event constructor;of_SetBase(TRUE)
of_SetRowManager(TRUE)
of_SetRowSelect(TRUE)
inv_RowSelect.of_SetStyle ( 0 )
SetTransObject(SQLCA)
Retrieve()


end event

type dw_customer from u_dw within w_report_customer_skid
boolean visible = false
integer x = 2545
integer y = 1638
integer width = 102
integer height = 42
integer taborder = 20
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

type cb_retrieve from u_cb within w_report_customer_skid
integer x = 37
integer y = 1629
integer width = 307
integer height = 74
integer taborder = 90
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Retrieve"
boolean default = true
end type

event clicked;dw_report.Event ue_retrieve()
Return 1
end event

type rb_statusall from u_rb within w_report_customer_skid
boolean visible = false
integer x = 3544
integer y = 96
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

type rb_status from u_rb within w_report_customer_skid
boolean visible = false
integer x = 3544
integer y = 186
integer width = 201
integer height = 42
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

type ddlb_status from u_ddlb within w_report_customer_skid
boolean visible = false
integer x = 3752
integer y = 131
integer width = 399
integer height = 525
integer taborder = 60
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 1090519039
boolean enabled = false
string item[] = {"Ready","InProcess","Canceled","OnHold","PreReCap","Partial","Wh-ready","Wh-coming","Wh-sort","Wh-gone","Sample","Partial-Rd"}
end type

event selectionchanged;is_status = Text(index)

wf_settitle()

//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.

RETURN 1

end event

type cb_sort from u_cb within w_report_customer_skid
integer x = 435
integer y = 1629
integer width = 307
integer height = 74
integer taborder = 100
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

type cb_email from u_cb within w_report_customer_skid
integer x = 1232
integer y = 1629
integer width = 307
integer height = 74
integer taborder = 120
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

type rb_dateall from u_rb within w_report_customer_skid
integer x = 2626
integer y = 54
integer width = 197
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 80269524
string text = "All"
boolean checked = true
end type

event clicked;IF this.Checked THEN
	em_from.Enabled = FALSE
	em_to.Enabled = FALSE
ELSE
	em_from.Enabled = TRUE
	em_to.Enabled = TRUE
END IF
wf_settitle()
//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.
RETURN 1
end event

type rb_date from u_rb within w_report_customer_skid
integer x = 2626
integer y = 125
integer width = 190
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 80269524
string text = "From"
end type

event clicked;IF this.Checked THEN
	em_from.Enabled = TRUE
	em_to.Enabled = TRUE
ELSE
	em_from.Enabled = FALSE
	em_to.Enabled = FALSE
END IF
wf_settitle()
//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.
RETURN 1
end event

type em_from from u_em within w_report_customer_skid
integer x = 2812
integer y = 125
integer width = 278
integer height = 64
integer taborder = 70
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
double increment = 0
string minmax = ""
end type

event constructor;this.Text = String(Today(), "mm/dd/yyyy")
end event

type em_to from u_em within w_report_customer_skid
integer x = 3160
integer y = 125
integer width = 278
integer height = 64
integer taborder = 80
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
double increment = 0
string minmax = ""
end type

event constructor;this.Text = String(Today(), "mm/dd/yyyy")
end event

type st_1 from statictext within w_report_customer_skid
integer x = 3090
integer y = 125
integer width = 66
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
boolean enabled = false
string text = "To"
alignment alignment = center!
boolean focusrectangle = false
end type

