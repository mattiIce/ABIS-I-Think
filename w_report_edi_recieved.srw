$PBExportHeader$w_report_edi_recieved.srw
forward
global type w_report_edi_recieved from w_sheet
end type
type cbx_detail from checkbox within w_report_edi_recieved
end type
type cb_1 from commandbutton within w_report_edi_recieved
end type
type dw_customer_duns from datawindow within w_report_edi_recieved
end type
type st_number_of_rows from statictext within w_report_edi_recieved
end type
type dw_customer_duns_number_string from datawindow within w_report_edi_recieved
end type
type st_all_dates from statictext within w_report_edi_recieved
end type
type cb_retrieve from commandbutton within w_report_edi_recieved
end type
type em_from from editmask within w_report_edi_recieved
end type
type em_to from editmask within w_report_edi_recieved
end type
type st_1 from statictext within w_report_edi_recieved
end type
type st_2 from statictext within w_report_edi_recieved
end type
type st_3 from statictext within w_report_edi_recieved
end type
type dw_report from u_dw within w_report_edi_recieved
end type
type cb_close from u_cb within w_report_edi_recieved
end type
type cb_print from u_cb within w_report_edi_recieved
end type
end forward

global type w_report_edi_recieved from w_sheet
integer width = 3536
integer height = 1955
string title = "ASN Received Report"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
cbx_detail cbx_detail
cb_1 cb_1
dw_customer_duns dw_customer_duns
st_number_of_rows st_number_of_rows
dw_customer_duns_number_string dw_customer_duns_number_string
st_all_dates st_all_dates
cb_retrieve cb_retrieve
em_from em_from
em_to em_to
st_1 st_1
st_2 st_2
st_3 st_3
dw_report dw_report
cb_close cb_close
cb_print cb_print
end type
global w_report_edi_recieved w_report_edi_recieved

type variables
String	is_customer, is_date_from_to
end variables

forward prototypes
public subroutine exporttoexcel (datawindow adw_dw, long al_rows)
public subroutine getcolumns (datawindow adw_dw, ref string as_columns[])
public function any getdata (datawindow adw_dw, long al_row, string as_column)
public function string inttocolumn (integer ai_col)
end prototypes

event type string ue_whoami();Return "w_report_edi_recieved"
end event

public subroutine exporttoexcel (datawindow adw_dw, long al_rows);//Alex Gerlants. 07/08/2016. Begin
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
Boolean		lb_rtn, lb_directoryexists

String 		ls_range, ls_file, ls_today, ls_now, ls_folder
Date 			ld_today
Time 			ld_now
Integer		li_answer

String		ls_customer, ls_date_from_to, ls_file_count, ls_file_count_grand
String		ls_rundate

ll_report_rows = dw_report.RowCount()
If ll_report_rows <= 0 Then Return //Nothing to do

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
If dw_report.DataObject = "d_report_edi_received_1" Then
	lole_OLE.cells[1,1]  = "Customer"
	lole_OLE.cells[1,2]  = "Transaction Date"
	lole_OLE.cells[1,3]  = "File Count"
Else //dw_report.DataObject = "d_report_edi_received_2"
	lole_OLE.cells[1,1]  = "Customer Name"
	lole_OLE.cells[1,2]  = "Transaction Date"
	lole_OLE.cells[1,3]  = "EDI File Name"
End If

//Insert Lines for Header & Miscellaneous Details (4 lines above columnar data)
lole_Sheet.Range("A1:G4").Select
lole_Sheet.Application.Selection.EntireRow.Insert 

//abc3_2.jpg
//If FileExists("C:\abis\ABC1.jpg") Then
If FileExists("C:\abis\abc3_2.jpg") Then
	lole_Sheet.Range("A1:A1").Select
	lole_Sheet.Pictures.Insert("C:\abis\abc3_2.jpg").Select
	
	lole_Sheet.Range("A1:A1").Select
	lole_OLE.Selection.RowHeight = 39.6 //Increase row height
End If

ls_rundate = dw_report.Object.compute_run_date[1]

lole_OLE.cells[1,1] = ls_rundate
lole_Sheet.Range("A1:A1").Select
lole_OLE.Selection.Font.Bold = False
lole_OLE.Selection.Font.Size = 8 //Change font size

If dw_report.DataObject = "d_report_edi_received_1" Then
	lole_OLE.cells[2,1] = "ASN Received Report"
Else //dw_report.DataObject = "d_report_edi_received_2"
	lole_OLE.cells[2,1] = "ASN Received Detail Report"
End If

lole_Sheet.Range("A2:A2").Select
lole_OLE.Selection.Font.Bold = True
lole_OLE.Selection.Font.Size = 24 //Change font size
lole_OLE.Selection.Font.Underline = True

lole_OLE.cells[3,1] = is_customer //Populated in Clicked event for cb_retrieve
lole_Sheet.Range("A3:A3").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[4,1] = is_date_from_to
lole_Sheet.Range("A4:A4").Select
lole_OLE.Selection.Font.Bold = True

lole_Sheet.Range("C5:C" + String(ll_report_rows + 6)).Select

If dw_report.DataObject = "d_report_edi_received_1" Then
	lole_OLE.Selection.ColumnWidth = 12.33 //Increase column width
Else //dw_report.DataObject = "d_report_edi_received_2"
	lole_OLE.Selection.ColumnWidth = 40 //Increase column width
End If

//---

//Delete extra columns	
//Choose Case dw_report.DataObject
//	Case "d_report_inv_abc_coils"
//		lole_Sheet.columns("R:T").Delete
//		
//	Case "d_report_inv_abc_coils_e"
//		lole_Sheet.columns("Q:V").Delete
//		
//	Case "d_report_inv_cust_coils"
//		lole_Sheet.columns("T:U").Delete
//		
//	Case "d_report_inv_cust_coils_e"
//		lole_Sheet.columns("R:S").Delete
//		
//End Choose

//Justify
//lole_OLE.Selection.HorizontalAlignment = -4108 //Center
//lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
//lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

lole_Sheet.Range("A4:A" + String(ll_report_rows + 6)).Select
lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify

lole_Sheet.Range("B4:B" + String(ll_report_rows + 6)).Select
lole_OLE.Selection.HorizontalAlignment = -4108 //Center

lole_Sheet.Range("C4:C" + String(ll_report_rows + 6)).Select

If dw_report.DataObject = "d_report_edi_received_1" Then
	lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify
Else //dw_report.DataObject = "d_report_edi_received_2"
	lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
End If
		
//Underline column headers
lole_Sheet.Range("A5:C5").Select
lole_OLE.Selection.Font.Underline = True

//Change date format for a column
lole_Sheet.Range("B6:B" + String(ll_report_rows + 7)).Select
lole_OLE.Selection.NumberFormat = "mm/dd/yyyy"

//Save the changes
SetPointer(HourGlass!)
ld_today = Today()
ld_now = Now()
ls_today = String(ld_today,"mmddyyyy")
ls_now = String(ld_now,"hhmmss")

ls_folder = ProfileString(gs_ini_file, "EMAIL","email_out","c:\temp\")
If Right(ls_folder, 1) <> "\" Then ls_folder = ls_folder + "\"

If dw_report.DataObject = "d_report_edi_received_1" Then
	ls_file = ls_folder + "ASN Received Report" + "_" + ls_today + ls_now + ".xls"
Else //dw_report.DataObject = "d_report_edi_received_2"
	ls_file = ls_folder + "ASN Received Detail Report" + "_" + ls_today + ls_now + ".xls"
End If

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
//Alex Gerlants. 07/08/2016. End
end subroutine

public subroutine getcolumns (datawindow adw_dw, ref string as_columns[]);/*
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
end subroutine

public function any getdata (datawindow adw_dw, long al_row, string as_column);/*
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
end function

public function string inttocolumn (integer ai_col);/*
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
end function

on w_report_edi_recieved.create
int iCurrent
call super::create
this.cbx_detail=create cbx_detail
this.cb_1=create cb_1
this.dw_customer_duns=create dw_customer_duns
this.st_number_of_rows=create st_number_of_rows
this.dw_customer_duns_number_string=create dw_customer_duns_number_string
this.st_all_dates=create st_all_dates
this.cb_retrieve=create cb_retrieve
this.em_from=create em_from
this.em_to=create em_to
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.dw_report=create dw_report
this.cb_close=create cb_close
this.cb_print=create cb_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_detail
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_customer_duns
this.Control[iCurrent+4]=this.st_number_of_rows
this.Control[iCurrent+5]=this.dw_customer_duns_number_string
this.Control[iCurrent+6]=this.st_all_dates
this.Control[iCurrent+7]=this.cb_retrieve
this.Control[iCurrent+8]=this.em_from
this.Control[iCurrent+9]=this.em_to
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.st_3
this.Control[iCurrent+13]=this.dw_report
this.Control[iCurrent+14]=this.cb_close
this.Control[iCurrent+15]=this.cb_print
end on

on w_report_edi_recieved.destroy
call super::destroy
destroy(this.cbx_detail)
destroy(this.cb_1)
destroy(this.dw_customer_duns)
destroy(this.st_number_of_rows)
destroy(this.dw_customer_duns_number_string)
destroy(this.st_all_dates)
destroy(this.cb_retrieve)
destroy(this.em_from)
destroy(this.em_to)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.dw_report)
destroy(this.cb_close)
destroy(this.cb_print)
end on

event open;call super::open;Integer				li_rtn
Long					ll_rows, ll_row_inserted
DataWindowChild	ldwc
Date					ld_from_default

dw_report.SetTransObject(sqlca)

li_rtn = dw_customer_duns.GetChild("customer_name", ldwc)

If li_rtn = 1 Then //OK
	ldwc.SetTransObject(sqlca)
	ll_rows = ldwc.Retrieve()
	
	ll_row_inserted = ldwc.InsertRow(1)
	
	If ll_row_inserted > 0 Then
		ldwc.SetItem(ll_row_inserted, "customer_name", "ALL")
		dw_customer_duns.Object.customer_name[1] = "ALL"
	End If
End If	

ld_from_default = RelativeDate(Today(), -7)
em_from.Text = String(ld_from_default)
end event

type cbx_detail from checkbox within w_report_edi_recieved
integer x = 2487
integer y = 128
integer width = 380
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Detail Report"
end type

event clicked;If This.Checked Then //EDI Received Detail Report
	dw_report.DataObject = "d_report_edi_received_2"
Else //EDI Received Report
	dw_report.DataObject = "d_report_edi_received_1"
End If

dw_report.SetTransObject(sqlca)
end event

type cb_1 from commandbutton within w_report_edi_recieved
integer x = 2984
integer y = 589
integer width = 351
integer height = 93
integer taborder = 100
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Open in Excel"
end type

event clicked;Parent.ExportToExcel( dw_report, dw_report.RowCount() )
end event

type dw_customer_duns from datawindow within w_report_edi_recieved
integer x = 29
integer y = 115
integer width = 494
integer height = 77
integer taborder = 20
string title = "none"
string dataobject = "d_customer_duns"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.InsertRow(0)
end event

type st_number_of_rows from statictext within w_report_edi_recieved
integer x = 29
integer y = 1741
integer width = 2399
integer height = 51
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

type dw_customer_duns_number_string from datawindow within w_report_edi_recieved
boolean visible = false
integer x = 2487
integer width = 936
integer height = 230
integer taborder = 10
string title = "none"
string dataobject = "d_customer_duns_number_string"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_all_dates from statictext within w_report_edi_recieved
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

type cb_retrieve from commandbutton within w_report_edi_recieved
integer x = 2984
integer y = 256
integer width = 351
integer height = 90
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Retrieve"
boolean default = true
end type

event clicked;String	ls_duns_4retrieve[], ls_customer_name, ls_cust
String	ls_date_from, ls_date_to
String	ls_duns, ls_find_string
Long		ll_rows, ll_row, ll_number_of_customers, ll_i, ll_rows_total, ll_found_row

Integer				li_rtn
DataWindowChild	ldwc

li_rtn = dw_customer_duns.GetChild("customer_name", ldwc)
If li_rtn <> 1 Then Return //Cannot get to customer drop-down. Return

dw_report.Reset()

ls_date_from = em_from.Text
ls_date_to = em_to.Text

ls_date_from = Right(ls_date_from, 2) + "-" + Left(ls_date_from, 2) + "-" + Mid(ls_date_from, 4, 2)
ls_date_to = Right(ls_date_to, 2) + "-" + Left(ls_date_to, 2) + "-" + Mid(ls_date_to, 4, 2)

ls_customer_name = dw_customer_duns.Object.customer_name[1]

If IsNull(ls_customer_name) Then Return

If ls_customer_name = "ALL" Then
	ll_number_of_customers = ldwc.RowCount()
	
	For ll_i =1 To ll_number_of_customers
		ls_cust = ldwc.GetItemString(ll_i, "customer_name")
		
		If ls_cust <> "ALL" Then
			ls_duns = ldwc.GetItemString(ll_i, "customer_duns_number_string")
			ls_duns_4retrieve[UpperBound(ls_duns_4retrieve[]) + 1] = ls_duns
		End If
	Next
Else //One customer selected
	ls_find_string = "customer_name = '" + ls_customer_name + "'"
	
	ll_found_row = ldwc.Find(ls_find_string, 1, ldwc.RowCount())
	
	If ll_found_row > 0 Then
		ls_duns = ldwc.GetItemString(ll_found_row, "customer_duns_number_string")
		ls_duns_4retrieve[UpperBound(ls_duns_4retrieve[]) + 1] = ls_duns
	End If
End If

If UpperBound(ls_duns_4retrieve[]) = 1 Then
		dw_report.Object.t_customer.Text = "Customer: " + ls_customer_name
Else //More than 1 customer
	dw_report.Object.t_customer.Text = "All Customers"
End If

is_customer = dw_report.Object.t_customer.Text

If ls_date_from = ls_date_to Then
	dw_report.Object.t_date_from_to.Text = "Date: " + em_from.Text
Else
	dw_report.Object.t_date_from_to.Text = "Date from: " + em_from.Text + "  to: " + em_to.Text
End If

is_date_from_to = dw_report.Object.t_date_from_to.Text

For ll_i = 1 To UpperBound(ls_duns_4retrieve[])
	//Newly retrieved rows are added to the previuosly retrieved rows because
	//RetrieveStart event for dw_report returns 2
	ls_duns = ls_duns_4retrieve[ll_i]
	ll_rows = dw_report.Retrieve(ls_duns, ls_date_from, ls_date_to)
	ll_rows_total = dw_report.RowCount()
Next
end event

type em_from from editmask within w_report_edi_recieved
integer x = 1083
integer y = 115
integer width = 282
integer height = 77
integer taborder = 30
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

type em_to from editmask within w_report_edi_recieved
integer x = 1404
integer y = 115
integer width = 322
integer height = 77
integer taborder = 40
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

type st_1 from statictext within w_report_edi_recieved
integer x = 29
integer y = 51
integer width = 223
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

type st_2 from statictext within w_report_edi_recieved
integer x = 1083
integer y = 51
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

type st_3 from statictext within w_report_edi_recieved
integer x = 1404
integer y = 51
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

type dw_report from u_dw within w_report_edi_recieved
integer x = 29
integer y = 256
integer width = 2838
integer height = 1408
integer taborder = 100
string dataobject = "d_report_edi_received_1"
end type

event retrievestart;call super::retrievestart;Return 2 //Add the new rows to the existing rows. Do not delete rows from the previous retrieve
end event

event clicked;call super::clicked;String 	ls_old_sort, ls_column, ls_name
Char 		lc_sort

If dw_report.DataObject <> "d_report_edi_received_2" Then Return

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

event retrieveend;call super::retrieveend;st_number_of_rows.Text = String(This.RowCount(), "###,###,##0") + " rows retrieved"
end event

type cb_close from u_cb within w_report_edi_recieved
string tag = "Close without printing"
integer x = 2984
integer y = 768
integer width = 351
integer height = 93
integer taborder = 90
integer weight = 700
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_print from u_cb within w_report_edi_recieved
integer x = 2984
integer y = 410
integer width = 351
integer height = 93
integer taborder = 80
boolean bringtotop = true
integer weight = 700
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;dw_report.Event pfc_print()
end event

