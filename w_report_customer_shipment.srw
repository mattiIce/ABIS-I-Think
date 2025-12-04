$PBExportHeader$w_report_customer_shipment.srw
forward
global type w_report_customer_shipment from w_sheet
end type
type dw_endusers_4customer from datawindow within w_report_customer_shipment
end type
type st_rowcount from statictext within w_report_customer_shipment
end type
type cb_1 from commandbutton within w_report_customer_shipment
end type
type cb_export from u_cb within w_report_customer_shipment
end type
type gb_1 from u_gb within w_report_customer_shipment
end type
type gb_2 from u_gb within w_report_customer_shipment
end type
type gb_3 from u_gb within w_report_customer_shipment
end type
type dw_customer from u_dw within w_report_customer_shipment
end type
type dw_allcust from u_dw within w_report_customer_shipment
end type
type dw_report from u_dw within w_report_customer_shipment
end type
type cb_print from u_cb within w_report_customer_shipment
end type
type cb_close from u_cb within w_report_customer_shipment
end type
type cb_preview from u_cb within w_report_customer_shipment
end type
type ddlb_customer from dropdownlistbox within w_report_customer_shipment
end type
type st_3 from statictext within w_report_customer_shipment
end type
type em_from from editmask within w_report_customer_shipment
end type
type em_to from editmask within w_report_customer_shipment
end type
type cb_setzoom from u_cb within w_report_customer_shipment
end type
type ddlb_enduser from dropdownlistbox within w_report_customer_shipment
end type
type rb_custall from u_rb within w_report_customer_shipment
end type
type rb_cust from u_rb within w_report_customer_shipment
end type
type rb_dateall from u_rb within w_report_customer_shipment
end type
type rb_date from u_rb within w_report_customer_shipment
end type
type rb_enduserall from u_rb within w_report_customer_shipment
end type
type rb_enduser from u_rb within w_report_customer_shipment
end type
type cb_sort from u_cb within w_report_customer_shipment
end type
type cb_email from u_cb within w_report_customer_shipment
end type
end forward

global type w_report_customer_shipment from w_sheet
string tag = "Shipment Report"
integer x = 424
integer y = 310
integer width = 3931
integer height = 1955
string title = "Shipment Report "
boolean maxbox = false
boolean resizable = false
long backcolor = 81324524
event type string ue_whoami ( )
dw_endusers_4customer dw_endusers_4customer
st_rowcount st_rowcount
cb_1 cb_1
cb_export cb_export
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
dw_customer dw_customer
dw_allcust dw_allcust
dw_report dw_report
cb_print cb_print
cb_close cb_close
cb_preview cb_preview
ddlb_customer ddlb_customer
st_3 st_3
em_from em_from
em_to em_to
cb_setzoom cb_setzoom
ddlb_enduser ddlb_enduser
rb_custall rb_custall
rb_cust rb_cust
rb_dateall rb_dateall
rb_date rb_date
rb_enduserall rb_enduserall
rb_enduser rb_enduser
cb_sort cb_sort
cb_email cb_email
end type
global w_report_customer_shipment w_report_customer_shipment

type prototypes

end prototypes

type variables
//Report header variables
String	is_date_from_to, is_customer, is_enduser //Alex Gerlants. 05/03/2016
end variables

forward prototypes
public subroutine wf_settitle ()
public subroutine wf_setfilter ()
public subroutine wf_shipment ()
public subroutine exporttoexcel (datawindow adw_dw, long al_rows)
public function any getdata (datawindow adw_dw, long al_row, string as_column)
public function string inttocolumn (integer ai_col)
public subroutine getcolumns (datawindow adw_dw, ref string as_columns[])
public subroutine wf_endusers_4customer (long al_customer_id)
public function long wf_get_enduser_id (string as_customer_short_name)
public function string wf_desadv_required (n_tr_abc01 at_tran, long al_packing_list)
public function string wf_shipment_type (n_tr_abc01 at_tran, long al_packing_list)
end prototypes

event ue_whoami;RETURN "w_report_customer_shipment"
end event

public subroutine wf_settitle ();String ls_modstring,ls_s
String	ls_date_from, ls_date_to
long ll_c


IF rb_custall.Checked THEN
	ls_s = "All customers "
ELSE
	ll_c = dw_customer.GetRow()
	ls_s = dw_customer.GetItemString(ll_c, "customer_short_name")
	ls_s = Trim(ls_s)
	ls_s = "Customer: " + ls_s
END IF

ls_modstring = "customer_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 

is_customer = ls_s //Alex Gerlants. 05/03/2016

//Alex Gerlants. 09/12/2016. Begin
IF rb_enduserall.Checked THEN
	ls_s = "All End Users"
ELSE
	ll_c = dw_allcust.GetRow()
	ls_s = dw_allcust.GetItemString(ll_c, "customer_short_name")
	ls_s = Trim(ls_s)
	ls_s = "End User: " + ls_s
END IF

ls_modstring = "enduser_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring)

is_enduser = ls_s
//Alex Gerlants. 09/12/2016. End


ls_s = "(" +em_from.Text + "-" + em_to.Text+")"
//ls_modstring = "date_t.Text = ~"" + ls_s + "~""
//dw_report.Modify(ls_modstring) 

//is_date_from_to = ls_s //Alex Gerlants. 05/03/2016

ls_date_from = em_from.Text
ls_date_to = em_to.Text

If ls_date_from = ls_date_to Then
	is_date_from_to = "Ship Date: " + ls_date_from
Else
	is_date_from_to = "Ship Date From: " + ls_date_from + " To: " + ls_date_to
End If




/*
String ls_modstring,ls_s
Long ll_c, ll_t

IF rb_dateall.Checked THEN
	ls_s = "All"
ELSE
	ls_s = em_from.Text + "-" + em_to.Text
END IF
ls_modstring = "date_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 

/*
IF rb_statusall.Checked THEN
	ls_s = "All"
ELSE
	ll_t = 0
	IF cbx_1.Checked THEN
		ls_s = cbx_1.Text
		ll_t++
	END IF
	IF cbx_2.Checked THEN 
		ls_s = cbx_2.Text
		ll_t++
	END IF
	IF cbx_3.Checked THEN 
		ls_s = cbx_3.Text
		ll_t++
	END IF
	IF cbx_4.Checked THEN
		ls_s = cbx_4.Text
		ll_t++
	END IF
	IF cbx_5.Checked THEN
		ls_s = cbx_5.Text
		ll_t++
	END IF
	IF cbx_6.Checked THEN
		ls_s = cbx_6.Text
		ll_t++
	END IF
	IF cbx_7.Checked THEN
		ls_s = cbx_7.Text
		ll_t++
	END IF
	IF cbx_8.Checked THEN
		ls_s = cbx_8.Text
		ll_t++
	END IF
	IF ll_t > 1 THEN ls_s = "Multiple"
END IF

*/
ls_modstring = "status_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 

/*
IF rb_specsall.Checked THEN
	ls_s = "All"
ELSE
	ls_s = em_gauge.Text
END IF
ls_modstring = "gauge_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 

IF rb_specsall.Checked THEN
	ls_s = "All"
ELSE
	ls_s = em_width.Text
END IF
ls_modstring = "width_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 

*/
IF rb_enduserall.Checked THEN
	ls_s = "All"
ELSE
	ll_c = dw_allcust.GetRow()
	ls_s = dw_allcust.GetItemString(ll_c, "customer_short_name")
	ls_s = Trim(ls_s)
END IF
ls_modstring = "enduser_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 

IF rb_custall.Checked THEN
	ls_s = "ABCO Customers Shipment Report" 
ELSE
	ll_c = dw_customer.GetRow()
	ls_s = dw_customer.GetItemString(ll_c, "customer_short_name")
	ls_s = Trim(ls_s)
	ls_s = ls_s + " Shipment Report" 
END IF	
ls_modstring = "title_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 
*/
end subroutine

public subroutine wf_setfilter ();/*
String ls_s, ls_status
Int li_status

ls_s = ""
IF rb_specs.Checked THEN
	IF Real(em_gauge.text) > 0 THEN
		ls_s = "(coil_coil_gauge = " + em_gauge.text + ")"
		IF Real(em_width.Text) > 0 THEN
			ls_s = ls_s + " and " + "(coil_coil_width = " + em_width.text + ")"
		END IF
	ELSE
		ls_s = " "
		IF Real(em_width.Text) > 0 THEN
			ls_s = "(coil_coil_width = " + em_width.text + ")"
		END IF		
	END IF
END IF

IF rb_status.Checked THEN
	ls_status = ""
	IF cbx_1.Checked THEN li_status = 2
	IF Len(ls_status) < 3 THEN
		ls_status = "( " + "coil_coil_status = " + String(li_status)
	ELSE
		ls_status = ls_status + " OR " + "coil_coil_status = " + String(li_status)
	END IF
	IF cbx_2.Checked THEN li_status = 1
	IF Len(ls_status) < 3 THEN
		ls_status = "( " + "coil_coil_status = " + String(li_status)
	ELSE
		ls_status = ls_status + " OR " + "coil_coil_status = " + String(li_status)
	END IF
	IF cbx_3.Checked THEN li_status = 3
	IF Len(ls_status) < 3 THEN
		ls_status = "( " + "coil_coil_status = " + String(li_status)
	ELSE
		ls_status = ls_status + " OR " + "coil_coil_status = " + String(li_status)
	END IF
	IF cbx_4.Checked THEN li_status = 5
	IF Len(ls_status) < 3 THEN
		ls_status = "( " + "coil_coil_status = " + String(li_status)
	ELSE
		ls_status = ls_status + " OR " + "coil_coil_status = " + String(li_status)
	END IF
	IF cbx_5.Checked THEN li_status = 4
	IF Len(ls_status) < 3 THEN
		ls_status = "( " + "coil_coil_status = " + String(li_status)
	ELSE
		ls_status = ls_status + " OR " + "coil_coil_status = " + String(li_status)
	END IF
	IF cbx_6.Checked THEN li_status = 6
	IF Len(ls_status) < 3 THEN
		ls_status = "( " + "coil_coil_status = " + String(li_status)
	ELSE
		ls_status = ls_status + " OR " + "coil_coil_status = " + String(li_status)
	END IF
	IF cbx_7.Checked THEN li_status = 7
	IF Len(ls_status) < 3 THEN
		ls_status = "( " + "coil_coil_status = " + String(li_status)
	ELSE
		ls_status = ls_status + " OR " + "coil_coil_status = " + String(li_status)
	END IF
	IF cbx_8.Checked THEN li_status = 8
	IF Len(ls_status) < 3 THEN
		ls_status = "( " + "coil_coil_status = " + String(li_status)
	ELSE
		ls_status = ls_status + " OR " + "coil_coil_status = " + String(li_status)
	END IF
	
	IF Pos(ls_status, "(") > 0 THEN
		ls_status = ls_status + " )"
	END IF
	
	IF Len(ls_s) > 3 THEN
		ls_s = ls_s + " and " + ls_status
	ELSE
		ls_s = ls_status
	END IF
END IF

dw_report.inv_filter.of_SetFilter(ls_s)
dw_report.inv_filter.of_Filter()
*/
end subroutine

public subroutine wf_shipment ();Long ll_cust_row, ll_cust, ll_enduser, ll_rows
Date ld_s, ld_e
DateTime	ldt_from, ldt_to //Alex Gerlants. 08/17/2016

dw_report.reset()
IF rb_dateall.Checked THEN
	ld_s = Date("00/00/0000")
	ld_e = Date("12/31/9999")
ELSE
	ld_s = Date(em_from.Text)
	ld_e = Date(em_to.Text)
END IF

f_date_2datetime_from_to(ld_s, ld_e, ldt_from, ldt_to) //Alex Gerlants. 08/17/2016. Bug fix

//Alex Gerlants. 08/30/2016. Begin
//Putting everything in one place...more reliable...
If rb_custall.Checked And rb_enduserall.Checked Then //All customers and all end users

	dw_report.DataObject = "d_report_shipment_a"
	
	dw_report.SetTransObject(sqlca)
	ll_rows = dw_report.Retrieve(ldt_from, ldt_to)
	
ElseIf rb_custall.Checked And rb_enduser.Checked Then //All customers and one selected end user
	
	dw_report.DataObject = "d_report_shipment_c"
	
	ll_cust_row = dw_allcust.GetRow()
   ll_enduser = dw_allcust.GetItemNumber(ll_cust_row, "customer_id")
	
	dw_report.SetTransObject(sqlca)
	ll_rows = dw_report.Retrieve(ldt_from, ldt_to, ll_enduser)
	
ElseIf rb_cust.Checked And rb_enduserall.Checked Then //One selected customer and all end users
	
	dw_report.DataObject = "d_report_shipment"
	
	ll_cust_row = dw_customer.GetRow()
	ll_cust = dw_customer.GetItemNumber(ll_cust_row, "customer_id")
	
	dw_report.SetTransObject(sqlca)
	ll_rows = dw_report.Retrieve(ll_cust, ldt_from, ldt_to)
	
ElseIf rb_cust.Checked And rb_enduser.Checked Then //One selected customer and one selected end user
	
	dw_report.DataObject = "d_report_shipment_e"
	
	ll_cust_row = dw_customer.GetRow()
	ll_cust = dw_customer.GetItemNumber(ll_cust_row, "customer_id")
	
	ll_cust_row = dw_allcust.GetRow()
	ll_enduser = dw_allcust.GetItemNumber(ll_cust_row, "customer_id")
	
	dw_report.SetTransObject(sqlca)
	ll_rows = dw_report.Retrieve(ll_cust, ldt_from, ldt_to, ll_enduser)
	
End If
//Alex Gerlants. 08/30/2016. End

//Alex Gerlants. 08/30/2016. Comment out begin
//IF rb_enduser.Checked THEN 
//	ll_cust_row = dw_allcust.GetRow()
//   ll_enduser = dw_allcust.GetItemNumber(ll_cust_row, "customer_id")
//	IF rb_cust.Checked THEN
//   	dw_report.Retrieve(ll_cust, ld_s, ld_e, ll_enduser)
//	ELSE
//   	dw_report.Retrieve(ld_s, ld_e, ll_enduser)
//	END IF		
//ELSE
//	IF rb_cust.Checked THEN
//		dw_report.retrieve(ll_cust, ld_s, ld_e)
//	ELSE
//		dw_report.retrieve(ld_s, ld_e)
//	END IF
//END IF
//Alex Gerlants. 08/30/2016. Comment out end

end subroutine

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
String		ls_range, ls_total_net_weight, ls_total_gross_weight
Boolean		lb_rtn, lb_directoryexists

String 		ls_file, ls_today, ls_now, ls_folder
Date 			ld_today
Time 			ld_now
Integer		li_answer

ll_report_rows = al_rows
ll_report_rows = adw_dw.RowCount()

If ll_report_rows > 0 Then
	ls_total_net_weight = String(adw_dw.Object.compute_2[1])
	ls_total_gross_weight = String(adw_dw.Object.compute_3[1])
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
		lole_Sheet.Cells[ ll_Row, ll_Col ] = This.GetData( adw_DW, ll_Row - 1, ls_Columns[ ll_Col ] )
	NEXT
NEXT

lole_Sheet.Range( inttocolumn( 1 ) + "1:" + inttocolumn( ll_Cols ) + "1").Select
lole_OLE.Selection.Font.Bold = True

lole_Sheet.Range("A1:A1").Select
lole_Sheet.Columns( inttocolumn( 1 ) + ":" + inttocolumn( ll_cols ) ).EntireColumn.AutoFit


//Column Headings
lole_OLE.cells[1,1] = "Packing List"
lole_OLE.cells[1,2] = "BOL"
lole_OLE.cells[1,3] = "Destination"
lole_OLE.cells[1,4] = "Date Shipped"
lole_OLE.cells[1,5] = "Customer"
lole_OLE.cells[1,6] = "End User"
lole_OLE.cells[1,7] = "Net Weight"
lole_OLE.cells[1,8] = "Gross Weight"
lole_OLE.cells[1,9] = "EDI Req'd"
lole_OLE.cells[1,10] = "EDI Trig'd"
lole_OLE.cells[1,11] = "EDI Gen'd"
lole_OLE.cells[1,12] = "EDI Sent"
lole_OLE.cells[1,13] = "FA Recv'd"


//Insert Lines for Header & Miscellaneous Details (5 lines above columnar data)
lole_Sheet.Range("A1:H5").Select
lole_Sheet.Application.Selection.EntireRow.Insert 

lole_OLE.cells[1,4] = "Customer Shipment Report"
lole_Sheet.Range("D1:D1").Select
lole_OLE.Selection.Font.Bold = True
lole_OLE.Selection.Font.Size = 24 //Change font size
lole_OLE.Selection.Font.Underline = True

lole_OLE.cells[1,13] = String(Today(), "mm/dd/yyyy")
lole_Sheet.Range("M1:M1").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[2,4] = is_customer
lole_Sheet.Range("D2:D2").Select
lole_OLE.Selection.Font.Size = 16 //Change font size
lole_OLE.Selection.Font.Bold = True
lole_OLE.Selection.Font.Italic = True

lole_OLE.cells[3,4] = is_enduser
lole_Sheet.Range("D3:D3").Select
lole_OLE.Selection.Font.Size = 16 //Change font size
lole_OLE.Selection.Font.Bold = True
lole_OLE.Selection.Font.Italic = True

lole_OLE.cells[4,4] = is_date_from_to
lole_Sheet.Range("D4:D4").Select
lole_OLE.Selection.Font.Bold = True

//---

//Insert 2 lines for totals (below columnar data)
ls_range = "A" + String(ll_report_rows + 7) + ":" + "H" + String(ll_report_rows + 7)
lole_Sheet.Range(ls_range).Select
lole_Sheet.Application.Selection.EntireRow.Insert

lole_OLE.cells[ll_report_rows + 7,7] = "Total Net(LB)"
ls_range = "G" + String(ll_report_rows + 7) + ":" + "G" + String(ll_report_rows + 7)
lole_Sheet.Range(ls_range).Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[ll_report_rows + 8,7] = String(ls_total_net_weight)
ls_range = "G" + String(ll_report_rows + 8) + ":" + "G" + String(ll_report_rows + 8)
lole_Sheet.Range(ls_range).Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[ll_report_rows + 7,8] = "Total Gross(LB)"
ls_range = "H" + String(ll_report_rows + 7) + ":" + "H" + String(ll_report_rows + 7)
lole_Sheet.Range(ls_range).Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[ll_report_rows + 8,8] = String(ls_total_gross_weight)
ls_range = "H" + String(ll_report_rows + 8) + ":" + "H" + String(ll_report_rows + 8)
lole_Sheet.Range(ls_range).Select
lole_OLE.Selection.Font.Bold = True

SetPointer(HourGlass!)
ld_today = Today()
ld_now = Now()
ls_today = String(ld_today,"yymmdd")
ls_now = String(ld_now,"hhmmss")

//Delete extra columns	
lole_Sheet.columns("N:CC").Delete

//Justify
//lole_OLE.Selection.HorizontalAlignment = -4108 //Center
//lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
//lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

lole_Sheet.Range("A4:F" + String(ll_report_rows + 7)).Select
lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify

lole_Sheet.Range("G4:H" + String(ll_report_rows + 7)).Select
lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

lole_Sheet.Range("I4:M" + String(ll_report_rows + 7)).Select
lole_OLE.Selection.HorizontalAlignment = -4108 //Center

//Change date format for a column
lole_Sheet.Range("D4:D" + String(ll_report_rows + 7)).Select
lole_OLE.Selection.NumberFormat = "mm/dd/yyyy"

//Underline column headers
lole_Sheet.Range("A6:M6").Select
lole_OLE.Selection.Font.Underline = True

////Draw border around column headers
//lole_OLE.Application.range ("A4:J4").borders(4).LineStyle = 1

//Increase column width
lole_Sheet.Range("I4:J4").Select
lole_OLE.Selection.ColumnWidth = 12.33

//---

ls_folder = ProfileString(gs_ini_file, "EMAIL","email_out","c:\temp\")

If Right(ls_folder, 1) <> "\" Then ls_folder = ls_folder + "\"
ls_file = ls_folder + "Customer Shipment Report" + "_" + ls_today + ls_now + ".xls"

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

Choose Case Len(ls_col)
	Case 0
		ls_Col += String( Char( 64 + li_Min ) )
	Case 1
		ls_Col += String( Char( 65 + li_Min ) )
End Choose

RETURN ls_Col
//Alex Gerlants. 05/02/2016. End
end function

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

//Alex Gerlants. 05/02/2016. End
end subroutine

public subroutine wf_endusers_4customer (long al_customer_id);//Alex Gerlants. 08/30/2016. Begin
/*
Function:	wf_endusers_4customer
				Populate ddlb_enduser with customer_short_name for customer_id = shipment.shipment_enduser_id
Returns:		none
Arguments:	value	long	al_customer_id
								If al_customer_id = -1, retrieve all end users
*/

Long			ll_rows, ll_row
Integer		ls_rtn
String		ls_customer_short_name, ls_sql_orig, ls_sql_new, ls_where

ls_sql_orig = dw_endusers_4customer.GetSqlSelect()
ddlb_enduser.Reset()

If al_customer_id = -1 Then //All end users
	ll_rows = dw_endusers_4customer.Retrieve()
Else //One end user
	If ls_sql_orig <> "" Then //OK
		ls_where = "  where shipment.customer_id = " + String(al_customer_id)
		ls_sql_new = ls_sql_orig + ls_where
		
		ls_rtn = dw_endusers_4customer.SetSqlSelect(ls_sql_new)
		
		If ls_rtn = 1 Then
			ll_rows = dw_endusers_4customer.Retrieve()
			
			dw_endusers_4customer.SetSort("customer_short_name Asc")
			dw_endusers_4customer.Sort()
		End If
	End If
End If

//Populate end user ddlb
If ll_rows > 0 Then //OK
	For ll_row = 1 To ll_rows
		ls_customer_short_name = dw_endusers_4customer.Object.customer_short_name[ll_row]
		ddlb_enduser.AddItem(ls_customer_short_name)
	Next
End If

//Restore the original SQL
dw_endusers_4customer.SetSqlSelect(ls_sql_orig)
//Alex Gerlants. 08/30/2016. End
end subroutine

public function long wf_get_enduser_id (string as_customer_short_name);//Alex Gerlants. 08/30/2016. Begin
/*
Function:	wf_get_enduser_id
Returns:		long	enduser_id
Arguments:	value	string	as_customer_short_name
*/

Long		ll_enduser_id, ll_found_row
String	ls_find_string
String	ls_customer_short_name

ls_find_string = "customer_short_name = '" + as_customer_short_name + "'"
ll_found_row = dw_endusers_4customer.Find(ls_find_string, 1, dw_endusers_4customer.RowCount())

If ll_found_row > 0 Then
	ll_enduser_id = dw_endusers_4customer.Object.customer_id[ll_found_row]
End If

Return ll_enduser_id
//Alex Gerlants. 08/30/2016. End
end function

public function string wf_desadv_required (n_tr_abc01 at_tran, long al_packing_list);//Alex Gerlants. 09/06/2016. Begin
/*
Function:	wf_desadv_required
Returns:		string
Arguments:	value	n_tr_abc01	at_tran
				value	long			al_packing_list
*/

String	ls_desadv_req = "N", ls_desadv_req_destination, ls_desadv_req_customer

select 	upper(nvl(c1.desadv_req, 'N')),
			upper(nvl(c2.desadv_req, 'N'))
into		:ls_desadv_req_destination,
			:ls_desadv_req_customer
from 		shipment
     		join customer c1 on c1.customer_id = shipment.des_sh_cust_id
     		join customer c2 on c2.customer_id = shipment.customer_id
where 	shipment.packing_list = :al_packing_list
using		at_tran;

If at_tran.sqlcode = 0 Then //OK
	If ls_desadv_req_destination + ls_desadv_req_customer = "YY" Then
		ls_desadv_req = "Y"
	End If
End If

Return ls_desadv_req
//Alex Gerlants. 09/06/2016. End
end function

public function string wf_shipment_type (n_tr_abc01 at_tran, long al_packing_list);//Alex Gerlants. 09/06/2016. Begin
/*
Function:	wf_shipment_type
Returns:		string
Arguments:	value	n_tr_abc01	at_tran
				value	long			al_packing_list
				
ls_shipment_type =	1 - Sheet <== EDI Required
							2 - Coil  <== EDI Not Required
							3 - Scrap <== EDI Not Required
*/

String	ls_edi_req_destination, ls_edi_req_customer
String	ls_shipment_type
Integer	li_ascii_value

select 	upper(nvl(shipment_type, '1'))
into		:ls_shipment_type
from 		shipment
where 	shipment.packing_list = :al_packing_list
using		at_tran;

If at_tran.sqlcode = 0 Then //OK
	li_ascii_value = asc(ls_shipment_type)
	
	If li_ascii_value < 48 And li_ascii_value > 57 Then //Not a number 0 to 9
		ls_shipment_type = "1"
	End If
End If

Return ls_shipment_type
//Alex Gerlants. 09/06/2016. End
end function

on w_report_customer_shipment.create
int iCurrent
call super::create
this.dw_endusers_4customer=create dw_endusers_4customer
this.st_rowcount=create st_rowcount
this.cb_1=create cb_1
this.cb_export=create cb_export
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.dw_customer=create dw_customer
this.dw_allcust=create dw_allcust
this.dw_report=create dw_report
this.cb_print=create cb_print
this.cb_close=create cb_close
this.cb_preview=create cb_preview
this.ddlb_customer=create ddlb_customer
this.st_3=create st_3
this.em_from=create em_from
this.em_to=create em_to
this.cb_setzoom=create cb_setzoom
this.ddlb_enduser=create ddlb_enduser
this.rb_custall=create rb_custall
this.rb_cust=create rb_cust
this.rb_dateall=create rb_dateall
this.rb_date=create rb_date
this.rb_enduserall=create rb_enduserall
this.rb_enduser=create rb_enduser
this.cb_sort=create cb_sort
this.cb_email=create cb_email
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_endusers_4customer
this.Control[iCurrent+2]=this.st_rowcount
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_export
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.gb_2
this.Control[iCurrent+7]=this.gb_3
this.Control[iCurrent+8]=this.dw_customer
this.Control[iCurrent+9]=this.dw_allcust
this.Control[iCurrent+10]=this.dw_report
this.Control[iCurrent+11]=this.cb_print
this.Control[iCurrent+12]=this.cb_close
this.Control[iCurrent+13]=this.cb_preview
this.Control[iCurrent+14]=this.ddlb_customer
this.Control[iCurrent+15]=this.st_3
this.Control[iCurrent+16]=this.em_from
this.Control[iCurrent+17]=this.em_to
this.Control[iCurrent+18]=this.cb_setzoom
this.Control[iCurrent+19]=this.ddlb_enduser
this.Control[iCurrent+20]=this.rb_custall
this.Control[iCurrent+21]=this.rb_cust
this.Control[iCurrent+22]=this.rb_dateall
this.Control[iCurrent+23]=this.rb_date
this.Control[iCurrent+24]=this.rb_enduserall
this.Control[iCurrent+25]=this.rb_enduser
this.Control[iCurrent+26]=this.cb_sort
this.Control[iCurrent+27]=this.cb_email
end on

on w_report_customer_shipment.destroy
call super::destroy
destroy(this.dw_endusers_4customer)
destroy(this.st_rowcount)
destroy(this.cb_1)
destroy(this.cb_export)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.dw_customer)
destroy(this.dw_allcust)
destroy(this.dw_report)
destroy(this.cb_print)
destroy(this.cb_close)
destroy(this.cb_preview)
destroy(this.ddlb_customer)
destroy(this.st_3)
destroy(this.em_from)
destroy(this.em_to)
destroy(this.cb_setzoom)
destroy(this.ddlb_enduser)
destroy(this.rb_custall)
destroy(this.rb_cust)
destroy(this.rb_dateall)
destroy(this.rb_date)
destroy(this.rb_enduserall)
destroy(this.rb_enduser)
destroy(this.cb_sort)
destroy(this.cb_email)
end on

event open;call super::open;dw_customer.Visible = FALSE
dw_customer.SetTransObject(SQLCA)
dw_customer.Retrieve()
dw_customer.SelectRow(1,TRUE)

dw_allcust.Visible = FALSE
dw_allcust.SetTransObject(SQLCA)
dw_allcust.Retrieve()

Long ll_row, ll_i
ll_row = dw_allcust.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		ddlb_enduser.AddItem(dw_allcust.GetItemString(ll_i, "customer_short_name"))
	NEXT
END IF
ll_row = dw_customer.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		ddlb_customer.AddItem(dw_customer.GetItemString(ll_i, "customer_short_name"))
	NEXT
END IF

ddlb_customer.Enabled = TRUE
em_from.Enabled = TRUE
em_to.Enabled = TRUE


wf_settitle()
cb_preview.SetFocus()

//dw_report.Event ue_retrieve()


end event

event pfc_print;RETURN dw_report.Event pfc_print()
end event

event close;call super::close;f_display_app()
end event

event pfc_saveas;Long ll_cust
String ls_cust, ls_title, ls_from, ls_to
//Save quote File
ll_cust = dw_customer.GetRow()
ls_cust = dw_customer.GetItemString(ll_cust, "customer_short_name")
ls_cust = Trim(ls_cust)

ls_from = string(Date(em_from.Text),"mmddyyyy")
ls_to = string(Date(em_to.Text),"mmddyyyy")

ls_title = ProfileString(gs_ini_file, "REPORT","file_path","c:\temp")+'\' +"Shipment_" + ls_cust + '_' + ls_from + '_' + ls_to +".PSR"

IF dw_report.SaveAs(ls_title, PSReport!, FALSE) =-1 THEN
  	MessageBox("Report SaveAs", "Error") 
	RETURN
END IF

MessageBox("Success", "File has been saved as " + ls_title + " Successfully!" )


end event

type dw_endusers_4customer from datawindow within w_report_customer_shipment
boolean visible = false
integer x = 3306
integer width = 293
integer height = 154
integer taborder = 50
string title = "none"
string dataobject = "d_endusers_4customer"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_rowcount from statictext within w_report_customer_shipment
integer y = 1664
integer width = 2984
integer height = 77
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_report_customer_shipment
integer x = 2838
integer y = 1782
integer width = 344
integer height = 77
integer taborder = 160
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

type cb_export from u_cb within w_report_customer_shipment
integer x = 2311
integer y = 1782
integer width = 406
integer height = 77
integer taborder = 150
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
ls_now = String(ld_now,"hhmmss")

ls_file = ProfileString(gs_ini_file, "EMAIL","email_out","c:\temp")+'\Customer Shipment Report_' + ls_today + ls_now + ".xls"

If dw_report.SaveAs(ls_file, Excel8!, True) = -1 Then
   MessageBox("Data SaveAs", "Error")
	Return -1
Else
	MessageBox("Success", "Data have been successfully exported to " + ls_file)
End If

Return 1
end event

type gb_1 from u_gb within w_report_customer_shipment
integer x = 15
integer width = 1115
integer height = 205
integer taborder = 60
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Customer"
end type

type gb_2 from u_gb within w_report_customer_shipment
integer x = 2293
integer width = 922
integer height = 205
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = " Date"
end type

type gb_3 from u_gb within w_report_customer_shipment
integer x = 1130
integer width = 1156
integer height = 205
integer taborder = 50
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "End User"
end type

type dw_customer from u_dw within w_report_customer_shipment
boolean visible = false
integer x = 2399
integer y = 1693
integer width = 132
integer height = 38
integer taborder = 0
string dataobject = "d_customer_short_display"
boolean vscrollbar = false
end type

event clicked;SelectRow(0, FALSE)

// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

// Notify the RowSelect service that the row has been clicked.
IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF
SelectRow(row, TRUE)

// Sort services.
IF IsValid (inv_Sort) THEN 
	// Notify the Sort service, since it may have have a request
	// to sort on colum header.
	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
END IF 













end event

event constructor;of_SetBase(TRUE)
of_SetRowManager(TRUE)
of_SetRowSelect(TRUE)
inv_RowSelect.of_SetStyle ( 0 )

end event

event rbuttondown;//disbaled
Return 0
end event

event rbuttonup;//disbaled
Return 0
end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.event pfc_rowchanged()

end event

type dw_allcust from u_dw within w_report_customer_shipment
boolean visible = false
integer x = 2341
integer y = 1731
integer width = 157
integer height = 70
integer taborder = 70
string dataobject = "d_customer_short_list"
boolean vscrollbar = false
end type

event clicked;SelectRow(0, FALSE)

// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

// Notify the RowSelect service that the row has been clicked.
IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF
SelectRow(row, TRUE)

// Sort services.
IF IsValid (inv_Sort) THEN 
	// Notify the Sort service, since it may have have a request
	// to sort on colum header.
	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
END IF 













end event

event constructor;of_SetBase(TRUE)
of_SetRowManager(TRUE)
of_SetRowSelect(TRUE)
inv_RowSelect.of_SetStyle ( 0 )

end event

event rbuttondown;//disbaled
Return 0
end event

event rowfocuschanged;call super::rowfocuschanged;this.event pfc_rowchanged()

end event

event rbuttonup;//disbaled
Return 0
end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

Return 

end event

type dw_report from u_dw within w_report_customer_shipment
event ue_retrieve ( )
event ue_clean_duplicates ( )
integer y = 205
integer width = 3745
integer height = 1434
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_report_shipment"
boolean hscrollbar = true
end type

event ue_retrieve;dw_report.Reset()

wf_shipment()
wf_settitle()
wf_setfilter()
//this.Event ue_clean_duplicates()







end event

event ue_clean_duplicates;/*

Long ll_row, ll_i

ll_row = this.RowCount()
IF ll_row < 2 THEN RETURN
FOR ll_i = ll_row TO 2 STEP -1
	IF this.GetItemString(ll_i, "coil_coil_org_num") = this.GetItemString((ll_i - 1), "coil_coil_org_num") THEN
		IF (this.GetItemString(ll_i, "coil_coil_mid_num") = this.GetItemString((ll_i - 1), "coil_coil_mid_num")) OR ISNULL(this.GetItemString(ll_i, "coil_coil_mid_num")) THEN
			IF this.GetItemString(ll_i, "coil_lot_num") = this.GetItemString((ll_i - 1), "coil_lot_num") THEN
				IF this.GetItemNumber(ll_i, "customer_order_enduser_id") = this.GetItemNumber((ll_i - 1), "customer_order_enduser_id") THEN
					this.DeleteRow(ll_i)
				END IF
			END IF
		END IF
	END IF
NEXT

*/
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

event retrieveend;call super::retrieveend;String	ls_fileexists, ls_directory, ls_file_name_856, ls_file_name_desadv, ls_file_name
String	ls_edi_generated_856, ls_edi_generated_desadv, ls_edi_generated
String	ls_edi_856_req, ls_desadv_req, ls_edi_req
String	ls_fa_received_file_name
String	ls_fa_received_time
String	ls_shipment_edi856_date, ls_shipment_desadv_date
//String	ls_shipment_type
Long		ll_rows, ll_row, ll_edi_file_id_856, ll_edi_file_id_desadv, ll_packing_list
Integer	li_rtn, li_fileexists_856, li_fileexists_desadv
DateTime	ldt_shipment_edi856_date, ldt_shipment_desadv_date

ll_rows = rowcount

If ll_rows = 1 Then
	st_rowcount.Text = " 1 row retrieved"
Else
	st_rowcount.Text = " " + String(This.Rowcount()) + " rows retrieved"
End If

For ll_row = 1 To ll_rows
	ls_edi_generated = "N"
	ll_packing_list = This.Object.packing_list[ll_row]

//	ls_shipment_type = wf_shipment_type(sqlca, ll_packing_list)
//	
//			/*
//				ls_shipment_type:
//				-----------------
//				1 - Sheet <== EDI Required
//				2 - Coil  <== EDI Not Required
//				3 - Scrap <== EDI Not Required
//			*/
			
	//ls_edi_856_req = wf_edi_required(sqlca, ll_packing_list)
	//ls_desadv_req = wf_desadv_required(sqlca, ll_packing_list)
	
	ls_edi_856_req = This.Object.edi_856_req[ll_row]
	If IsNull(ls_edi_856_req) Then ls_edi_856_req = "N"
	ls_desadv_req = This.Object.desadv_req[ll_row]
	If IsNull(ls_desadv_req) Then ls_desadv_req = "N"
	
	ls_edi_req = This.Object.edi_req[ll_row]
	
	//If ls_shipment_type = "1" And (Upper(ls_edi_856_req) = "Y" Or Upper(ls_desadv_req) = "Y") Then
	If Upper(ls_edi_req) = "Y" Then //This packing_list requires EDI
		//Shipping sheets (first tab on shipment screen) or warehouse rework (fourth tab),
		//and customer requires EDI
		//This.Object.edi_req[ll_row] = "Y"

		If Upper(ls_edi_856_req) = "Y" Then
			ll_edi_file_id_856 = This.Object.edi_file_id_856[ll_row]

			If ll_edi_file_id_856 > 0 Then //856 file generated
				ls_edi_generated_856 = "Y"
			End If
		End If
		
		If Upper(ls_desadv_req) = "Y" Then
			ll_edi_file_id_desadv = This.Object.edi_file_id_desadv[ll_row]
			
			If ll_edi_file_id_desadv > 0 Then //desadv file generated
				ls_edi_generated_desadv = "Y"
			End If
		End If
		
		If Upper(ls_edi_856_req) = "Y" Or Upper(ls_desadv_req) = "Y" Then
			If Upper(ls_edi_856_req) = "Y" And Upper(ls_desadv_req) = "Y" Then
				If Upper(ls_edi_generated_856) = "Y" And Upper(ls_edi_generated_desadv) = "Y" Then
					ls_edi_generated = "Y"
				Else
					ls_edi_generated = "N"
				End If
			ElseIf Upper(ls_edi_856_req) = "Y" Then
				If Upper(ls_edi_generated_856) = "Y" Then
					ls_edi_generated = "Y"
				Else
					ls_edi_generated = "N"
				End If
			Else //ls_desadv_req = "Y"
				If Upper(ls_edi_generated_desadv) = "Y" Then
					ls_edi_generated = "Y"
				Else
					ls_edi_generated = "N"
				End If
			End If
		End If
		
		This.Object.edi_generated[ll_row] = ls_edi_generated
	Else
		This.Object.edi_req[ll_row] = "N"
		This.Object.edi_generated[ll_row] = "N"
	End If
	
	//Get edi file names and dates for 856, desadv, and FA
	If ll_edi_file_id_856 > 0 Then
		ll_edi_file_id_856 = This.Object.edi_file_id_856[ll_row]

		select	edi_file_name, transaction_time, fa_received_file_name, fa_received_time
		into		:ls_file_name_856, :ldt_shipment_edi856_date, :ls_fa_received_file_name, :ls_fa_received_time
		from		outbound_edi_transaction
		where		edi_file_id = :ll_edi_file_id_856
		using		sqlca;
		
		If Not IsNull(ldt_shipment_edi856_date) Then
			ls_shipment_edi856_date = String(ldt_shipment_edi856_date, "mm/dd/yyyy hh:mm:ss AM/PM")
		Else
			ls_shipment_edi856_date = ""
		End If
		
		If Not IsNull(ls_fa_received_time) Then
			If IsNumber(ls_fa_received_time) Then
				If Integer(Mid(ls_fa_received_time, 7, 2)) >= 12 Then
					ls_fa_received_time = 	Mid(ls_fa_received_time, 3, 2) + "/" + &
													Mid(ls_fa_received_time, 5, 2) + "/" + "20" + &
													Mid(ls_fa_received_time, 1, 2) + " " + &
													String(Integer(Mid(ls_fa_received_time, 7, 2)) - 12)  + ":" + &
													Mid(ls_fa_received_time, 9, 2) + ":00 PM"
				Else
					ls_fa_received_time = 	Mid(ls_fa_received_time, 3, 2) + "/" + &
													Mid(ls_fa_received_time, 5, 2) + "/" + "20" + &
													Mid(ls_fa_received_time, 1, 2) + " " + &
													Mid(ls_fa_received_time, 7, 2) + ":" + &
													Mid(ls_fa_received_time, 9, 2) + ":00 AM"
				End If
			Else
				ls_fa_received_time = ""
			End If
		Else
			ls_fa_received_time = ""
		End If
	Else
		ls_file_name_856 = ""
		ls_shipment_edi856_date = ""
	End If
	
	If ll_edi_file_id_desadv > 0 Then
		ll_edi_file_id_desadv = This.Object.edi_file_id_desadv[ll_row]
		
		select	edi_file_name, transaction_time
		into		:ls_file_name_desadv, :ldt_shipment_desadv_date
		from		outbound_edi_transaction
		where		edi_file_id = :ll_edi_file_id_desadv
		using		sqlca;
		
		If Not IsNull(ldt_shipment_desadv_date) Then
			ls_shipment_desadv_date = String(ldt_shipment_desadv_date, "mm/dd/yyyy hh:mm:ss AM/PM")
		Else
			ls_shipment_desadv_date = ""
		End If
	Else
		ls_file_name_desadv = ""
		ls_shipment_desadv_date = ""
	End If
	
	//Populate dw_report
	This.Object.edi_file_name_856[ll_row] = ls_file_name_856
	This.Object.shipment_edi856_date[ll_row] = ls_shipment_edi856_date
	This.Object.edi_file_name_desadv[ll_row] = ls_file_name_desadv
	This.Object.shipment_desadv_date[ll_row] = ls_shipment_desadv_date
	This.Object.fa_received_file_name[ll_row] = ls_fa_received_file_name
	This.Object.fa_received_time[ll_row] = ls_fa_received_time
	
	//Populate edi_sent
	//If file generated in Unix, and it is not there (in Unix) when this report is running,
	//it means that this file has been FTP'ed out.
	//This is not a reliable indication because the FTP script has no error checking (according to Patrick).
	//Thus even if there is a problem with FTP, the FTP script still moves that file out to another directory.
	//Here however, this is the only one way to figure out if a file has been FTP'ed.
	
	//ls_directory = "/templar/templar/incoming/senddata" //Hard coded as in all EDI functions
	
	select	directory_path
	into		:ls_directory
	from		all_directories
	where		directory_name = 'EDI_DIR'
	using		sqlca;
	
	//Oracle function f_unix_file_exists() is defined as Local External Function on n_tr_abc01 in silverdome.pbl
	
	If Upper(ls_edi_856_req) = "Y" Then
		ls_file_name = ls_file_name_856
		
		If ls_file_name_856 <> "" Then
			li_fileexists_856 = sqlca.f_unix_file_exists(ls_directory, ls_file_name)
		Else
			li_fileexists_856 = 1 //This is when 856 never existed in the first place
		End If
	End If
	
	If Upper(ls_desadv_req) = "Y" Then
		ls_file_name = ls_file_name_desadv
		
		If ls_file_name_desadv <> "" Then
			li_fileexists_desadv = sqlca.f_unix_file_exists(ls_directory, ls_file_name)
		Else
			li_fileexists_desadv = 1 //This is when desadv never existed in the first place
		End If
	End If
	
	If Upper(ls_edi_856_req) = "Y" Or Upper(ls_desadv_req) = "Y" Then
		If Upper(ls_edi_856_req) = "Y" And Upper(ls_desadv_req) = "Y" Then
			If li_fileexists_856 = 0 And li_fileexists_desadv = 0 Then //Both files not in Unix...FTP'ed out
				This.Object.edi_sent[ll_row] = "Y"
			Else //One or both files not FTP'ed
				This.Object.edi_sent[ll_row] = "N"
			End If
		ElseIf Upper(ls_edi_856_req) = "Y" Then
			If li_fileexists_856 = 0 Then
				This.Object.edi_sent[ll_row] = "Y"
			Else
				This.Object.edi_sent[ll_row] = "N"
			End If
		Else //ls_desadv_req = "Y"
			If li_fileexists_desadv = 0 Then
				This.Object.edi_sent[ll_row] = "Y"
			Else
				This.Object.edi_sent[ll_row] = "N"
			End If
		End If
	Else
		This.Object.edi_sent[ll_row] = "N"
	End If
	
	//Populate fa_received
	//Only 856 receive confirmation FA. GM does not send confirmations for our DesAdv files.
	ls_fa_received_file_name = This.Object.fa_received_file_name[ll_row]
	
	If Upper(ls_fa_received_file_name) <> "" Then
		This.Object.fa_received[ll_row] = "Y"
	Else
		This.Object.fa_received[ll_row] = "N"
	End If
	
	This.SetItemStatus(ll_row, 0, Primary!, NotModified!) //Otherwise, it is going to ask to save changes.
Next


//ls_file_name = "QWEQ"

//li_fileexists = sqlca.f_unix_file_exists(ls_directory, ls_file_name)
end event

event doubleclicked;call super::doubleclicked;Integer	li_return
Long		ll_packing_list

If row > 0 Then
	ll_packing_list = This.Object.packing_list[row]
	This.SelectRow(row, True)
	
	li_return = OpenSheetWithParm(w_report_shipment_4packing_list, ll_packing_list, &
				 gnv_app.of_getframe(), 0, Original!)	
				 
	If li_return = 1 Then //OK
		//
	Else //Error opening sheet
		MessageBox("Error", "Error opening sheet w_report_shipment_4packing_list")
	End If
End If
end event

event clicked;call super::clicked;If row > 0 Then
	If This.IsSelected(row) Then
		This.SelectRow(row, False)
	Else
		This.SelectRow(0, False) //Unselect all rows
		This.SelectRow(row, True)
	End If
End If	
end event

type cb_print from u_cb within w_report_customer_shipment
integer x = 1872
integer y = 1782
integer width = 307
integer height = 74
integer taborder = 140
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;Parent.Event pfc_print()
end event

type cb_close from u_cb within w_report_customer_shipment
string tag = "Exit"
integer x = 3306
integer y = 1782
integer width = 322
integer height = 74
integer taborder = 150
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_preview from u_cb within w_report_customer_shipment
event clicked pbm_bnclicked
integer x = 88
integer y = 1782
integer width = 307
integer height = 70
integer taborder = 120
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Retrieve"
boolean default = true
end type

event clicked;st_rowcount.Text = ""
dw_report.Event ue_retrieve()

end event

type ddlb_customer from dropdownlistbox within w_report_customer_shipment
integer x = 263
integer y = 112
integer width = 827
integer height = 1203
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
boolean sorted = false
boolean vscrollbar = true
integer limit = 20
integer accelerator = 50
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;String ls_text, ls_modstring
Long ll_row, ll_i

dw_report.reset()
ls_text = Text(index)

/*
IF rb_enduser.Checked THEN 
	dw_report.DataObject = "d_report_shipment_e"
ELSE
	dw_report.DataObject = "d_report_shipment"
END IF
*/

ll_row = dw_customer.RowCount()
FOR ll_i = 1 TO ll_row
	IF dw_customer.GetItemString(ll_i, "customer_short_name") = ls_text THEN
		dw_customer.Event RowFocusChanged(ll_i)
		dw_customer.SelectRow(0, False)
		dw_customer.SelectRow(ll_i, True)
	END IF
NEXT

//dw_report.SetTransObject(SQLCA)
wf_settitle()

//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.

RETURN 1


end event

type st_3 from statictext within w_report_customer_shipment
integer x = 2823
integer y = 115
integer width = 91
integer height = 61
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

type em_from from editmask within w_report_customer_shipment
integer x = 2523
integer y = 109
integer width = 285
integer height = 74
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
end type

event constructor;this.Text = String(Today(), "mm/dd/yyyy")

end event

event losefocus;wf_SetTitle()
RETURN 1
end event

type em_to from editmask within w_report_customer_shipment
integer x = 2893
integer y = 109
integer width = 285
integer height = 74
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
end type

event constructor;this.Text = String(Today(), "mm/dd/yyyy")

end event

event losefocus;wf_settitle()

RETURN 1
end event

type cb_setzoom from u_cb within w_report_customer_shipment
integer x = 984
integer y = 1782
integer width = 307
integer height = 74
integer taborder = 130
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&SetZoom"
end type

event clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type ddlb_enduser from dropdownlistbox within w_report_customer_shipment
integer x = 1401
integer y = 106
integer width = 827
integer height = 1194
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
boolean sorted = false
boolean vscrollbar = true
integer limit = 20
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;String ls_text
Long ll_i, ll_row

ls_text = Text(index)
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

type rb_custall from u_rb within w_report_customer_shipment
integer x = 37
integer y = 48
integer width = 212
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "All"
end type

event clicked;
IF MessageBox("Question", "All customers option may contains too many records and it may take a long time to generate this report, continue?", Question!, YesNo!, 2) = 2 THEN
	this.Checked = FALSE
	rb_cust.Checked = TRUE
	rb_cust.Event Clicked()
	RETURN 0
END IF

dw_report.Reset()

IF this.Checked THEN
	ddlb_customer.Enabled = FALSE
	IF rb_enduser.Checked THEN 
		dw_report.DataObject = "d_report_shipment_c" 
	ELSE
		dw_report.DataObject = "d_report_shipment_a" 
	END IF											
ELSE
	ddlb_customer.Enabled = TRUE
END IF

dw_report.SetTransObject(SQLCA)
wf_settitle()

//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.

RETURN 1
end event

type rb_cust from u_rb within w_report_customer_shipment
integer x = 37
integer y = 112
integer width = 230
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Select"
boolean checked = true
end type

event clicked;dw_report.Reset()
IF this.Checked THEN
	ddlb_customer.Enabled = TRUE
	IF rb_enduser.Checked THEN 
		dw_report.DataObject = "d_report_shipment_e" 
	ELSE
		dw_report.DataObject = "d_report_shipment" 
	END IF											
ELSE
	ddlb_customer.Enabled = FALSE
END IF

dw_report.SetTransObject(SQLCA)
wf_settitle()

RETURN 1

end event

type rb_dateall from u_rb within w_report_customer_shipment
boolean visible = false
integer x = 2326
integer y = 48
integer width = 176
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "All"
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

type rb_date from u_rb within w_report_customer_shipment
integer x = 2326
integer y = 112
integer width = 190
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "From"
boolean checked = true
end type

event clicked;IF this.Checked THEN
	em_from.Enabled = TRUE
	em_to.Enabled = TRUE
ELSE
	em_from.Enabled = FALSE
	em_to.Enabled = FALSE
END IF
wf_settitle()	
end event

type rb_enduserall from u_rb within w_report_customer_shipment
integer x = 1159
integer y = 48
integer width = 172
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "All"
boolean checked = true
end type

event clicked;dw_report.Reset()
IF this.Checked THEN
	ddlb_enduser.Enabled = FALSE
	IF rb_custall.Checked THEN 
		dw_report.DataObject = "d_report_shipment_a"
	ELSE
		dw_report.DataObject = "d_report_shipment_e"
	END IF								
ELSE
	ddlb_enduser.Enabled = TRUE
END IF
dw_report.SetTransObject(SQLCA)
wf_settitle()
//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.
RETURN 1

end event

type rb_enduser from u_rb within w_report_customer_shipment
integer x = 1159
integer y = 112
integer width = 208
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Select"
end type

event clicked;//ddlb_enduser.Enabled = TRUE
/*
//dw_report.Reset()
IF this.Checked THEN 
	ddlb_enduser.Enabled = TRUE
	dw_report.DataObject = "d_report_shipment_e"
ELSE
	ddlb_enduser.Enabled = FALSE
	dw_report.DataObject = "d_report_shipment"
	//dw_report.DataObject = Left(dw_report.DataObject, (Len(dw_report.DataObject) - 2))
END IF
dw_report.Reset()
dw_report.SetTransObject(SQLCA)
wf_settitle()

*/
dw_report.Reset()
IF this.Checked THEN
	ddlb_enduser.Enabled = TRUE
	IF rb_custall.Checked THEN 
		dw_report.DataObject = "d_report_shipment_c"
	ELSE
		dw_report.DataObject = "d_report_shipment_e"
	END IF								
ELSE
	ddlb_enduser.Enabled = FALSE
END IF
dw_report.SetTransObject(SQLCA)
wf_settitle()
//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.
RETURN 1

end event

type cb_sort from u_cb within w_report_customer_shipment
integer x = 534
integer y = 1782
integer width = 307
integer height = 74
integer taborder = 30
boolean bringtotop = true
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

type cb_email from u_cb within w_report_customer_shipment
integer x = 1426
integer y = 1782
integer width = 307
integer height = 74
integer taborder = 20
boolean bringtotop = true
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
//if dw_report.SaveAs(ls_file,Excel5!, false) =-1 then
if dw_report.SaveAs(ls_file,HTMLtable!, false) =-1 then
   MessageBox("Email SaveAs", "Error")
	return -1
end if

f_send_email(0,ls_file)

RETURN 1
end event

