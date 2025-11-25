$PBExportHeader$w_report_customer_coils.srw
$PBExportComments$inventory coil report based on different customers
forward
global type w_report_customer_coils from w_sheet
end type
type cbx_scrap from checkbox within w_report_customer_coils
end type
type cbx_prerecap from checkbox within w_report_customer_coils
end type
type cbx_include_coils_inprocess from checkbox within w_report_customer_coils
end type
type cb_1 from commandbutton within w_report_customer_coils
end type
type cb_export from u_cb within w_report_customer_coils
end type
type dw_report from u_dw within w_report_customer_coils
end type
type cb_print from u_cb within w_report_customer_coils
end type
type dw_customer from u_dw within w_report_customer_coils
end type
type cb_close from u_cb within w_report_customer_coils
end type
type cb_preview from u_cb within w_report_customer_coils
end type
type ddlb_customer from dropdownlistbox within w_report_customer_coils
end type
type st_3 from statictext within w_report_customer_coils
end type
type em_from from editmask within w_report_customer_coils
end type
type em_to from editmask within w_report_customer_coils
end type
type cb_setzoom from u_cb within w_report_customer_coils
end type
type ddlb_enduser from dropdownlistbox within w_report_customer_coils
end type
type dw_allcust from u_dw within w_report_customer_coils
end type
type gb_5 from u_gb within w_report_customer_coils
end type
type gb_3 from u_gb within w_report_customer_coils
end type
type gb_2 from u_gb within w_report_customer_coils
end type
type gb_1 from u_gb within w_report_customer_coils
end type
type rb_custall from u_rb within w_report_customer_coils
end type
type rb_cust from u_rb within w_report_customer_coils
end type
type rb_dateall from u_rb within w_report_customer_coils
end type
type rb_date from u_rb within w_report_customer_coils
end type
type rb_enduserall from u_rb within w_report_customer_coils
end type
type rb_enduser from u_rb within w_report_customer_coils
end type
type rb_statusall from u_rb within w_report_customer_coils
end type
type rb_status from u_rb within w_report_customer_coils
end type
type rb_specsall from u_rb within w_report_customer_coils
end type
type rb_specs from u_rb within w_report_customer_coils
end type
type em_gauge from editmask within w_report_customer_coils
end type
type st_1 from statictext within w_report_customer_coils
end type
type em_width from editmask within w_report_customer_coils
end type
type cb_sort from u_cb within w_report_customer_coils
end type
type cbx_1 from checkbox within w_report_customer_coils
end type
type cbx_2 from checkbox within w_report_customer_coils
end type
type cbx_3 from checkbox within w_report_customer_coils
end type
type cbx_4 from checkbox within w_report_customer_coils
end type
type cbx_5 from checkbox within w_report_customer_coils
end type
type cbx_6 from checkbox within w_report_customer_coils
end type
type cbx_7 from checkbox within w_report_customer_coils
end type
type cbx_8 from checkbox within w_report_customer_coils
end type
type cb_email from u_cb within w_report_customer_coils
end type
type gb_4 from u_gb within w_report_customer_coils
end type
end forward

global type w_report_customer_coils from w_sheet
string tag = "Customer inventory reports"
integer x = 424
integer y = 314
integer width = 4769
integer height = 2333
string title = "Inventory Report - Coils"
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
cbx_scrap cbx_scrap
cbx_prerecap cbx_prerecap
cbx_include_coils_inprocess cbx_include_coils_inprocess
cb_1 cb_1
cb_export cb_export
dw_report dw_report
cb_print cb_print
dw_customer dw_customer
cb_close cb_close
cb_preview cb_preview
ddlb_customer ddlb_customer
st_3 st_3
em_from em_from
em_to em_to
cb_setzoom cb_setzoom
ddlb_enduser ddlb_enduser
dw_allcust dw_allcust
gb_5 gb_5
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
rb_custall rb_custall
rb_cust rb_cust
rb_dateall rb_dateall
rb_date rb_date
rb_enduserall rb_enduserall
rb_enduser rb_enduser
rb_statusall rb_statusall
rb_status rb_status
rb_specsall rb_specsall
rb_specs rb_specs
em_gauge em_gauge
st_1 st_1
em_width em_width
cb_sort cb_sort
cbx_1 cbx_1
cbx_2 cbx_2
cbx_3 cbx_3
cbx_4 cbx_4
cbx_5 cbx_5
cbx_6 cbx_6
cbx_7 cbx_7
cbx_8 cbx_8
cb_email cb_email
gb_4 gb_4
end type
global w_report_customer_coils w_report_customer_coils

type variables
//Report header variables
String	is_report_title, is_received_date, is_status, is_gauge, is_width, is_enduser //Alex Gerlants. 05/03/2016
end variables

forward prototypes
public subroutine wf_settitle ()
public subroutine wf_customer_coil_index_coil ()
public subroutine wf_abc_coil_index_coil ()
public subroutine wf_setfilter ()
public subroutine getcolumns (datawindow adw_dw, ref string as_columns[])
public function any getdata (datawindow adw_dw, long al_row, string as_column)
public function string inttocolumn (integer ai_col)
public subroutine exporttoexcel (datawindow adw_dw, long al_rows)
public subroutine wf_add_coils_inprocess (long al_cust, long al_enduser, datetime adt_s, datetime adt_e)
public function integer wf_recalculate_totals ()
public subroutine wf_set_coils_inprocess ()
end prototypes

event ue_whoami;RETURN "w_report_customer_coils"
end event

public subroutine wf_settitle ();String ls_modstring,ls_s
Long ll_c, ll_t

IF rb_dateall.Checked THEN
	ls_s = "All"
ELSE
	ls_s = em_from.Text + "-" + em_to.Text
END IF
ls_modstring = "date_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 

is_received_date = ls_s //Alex Gerlants. 05/03/2016

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
	
	//Alex Gerlants. 03/13/2019. Add_Coil_Status_To_Coil_Inv_Report. Begin
	If cbx_prerecap.Checked Then
		ls_s = cbx_prerecap.Text
		ll_t++
	End If
	
	If cbx_scrap.Checked Then
		ls_s = cbx_scrap.Text
		ll_t++
	End If
	//Alex Gerlants. 03/13/2019. Add_Coil_Status_To_Coil_Inv_Report. End
	
	IF ll_t > 1 THEN ls_s = "Multiple"
END IF
ls_modstring = "status_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 

is_status = ls_s //Alex Gerlants. 05/03/2016

IF rb_specsall.Checked THEN
	ls_s = "All"
ELSE
	ls_s = em_gauge.Text
END IF
ls_modstring = "gauge_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring)

is_gauge = ls_s //Alex Gerlants. 05/03/2016

IF rb_specsall.Checked THEN
	ls_s = "All"
ELSE
	ls_s = em_width.Text
END IF
ls_modstring = "width_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 

is_width = ls_s //Alex Gerlants. 05/03/2016

IF rb_enduserall.Checked THEN
	ls_s = "All"
ELSE
	ll_c = dw_allcust.GetRow()
	ls_s = dw_allcust.GetItemString(ll_c, "customer_short_name")
	ls_s = Trim(ls_s)
END IF
ls_modstring = "enduser_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring)

is_enduser = ls_s //Alex Gerlants. 05/03/2016

IF rb_custall.Checked THEN
	ls_s = "ABCO Customers Coil Inventory Report" 
ELSE
	ll_c = dw_customer.GetRow()
	ls_s = dw_customer.GetItemString(ll_c, "customer_short_name")
	ls_s = Trim(ls_s)
	ls_s = ls_s + " Coil Inventory Report" 
END IF	
ls_modstring = "title_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 

is_report_title = ls_s //Alex Gerlants. 05/03/2016

end subroutine

public subroutine wf_customer_coil_index_coil ();Long ll_cust_row, ll_cust, ll_enduser
Date ld_s, ld_e
DateTime ldt_s, ldt_e //Alex Gerlants. 02/23/2017

ll_cust_row = dw_customer.GetRow()
ll_cust = dw_customer.GetItemNumber(ll_cust_row, "customer_id")
ll_cust_row = dw_allcust.GetRow()
ll_enduser = dw_allcust.GetItemNumber(ll_cust_row, "customer_id")
IF rb_dateall.Checked THEN
	//ld_s = Date("00/00/0000")
	//ld_e = Date("12/31/9999")
	
	ldt_s = DateTime(Date("00/00/0000"), Time("00:00:00")) //Alex Gerlants. 02/23/2017
	ldt_e = DateTime(Date("12/31/9999"), Time("23:59:59")) //Alex Gerlants. 02/23/2017
ELSE
	//ld_s = Date(em_from.Text)
	//ld_e = Date(em_to.Text)
	
	ldt_s = DateTime(Date(em_from.Text), Time("00:00:00")) //Alex Gerlants. 02/23/2017
	ldt_e = DateTime(Date(em_to.Text), Time("23:59:59")) //Alex Gerlants. 02/23/2017
END IF

IF rb_enduser.Checked THEN 
	dw_report.Retrieve(ll_cust, ldt_s, ldt_e, ll_enduser) //Alex Gerlants. 02/23/2017. Changed from "ld_s, ld_e" to "ldt_s, ldt_e"
	//wf_add_coils_inprocess(ll_cust, ll_enduser, ldt_s, ldt_e) //Alex Gerlants. 05/17/2017
ELSE
	dw_report.retrieve(ll_cust, ldt_s, ldt_e) //Alex Gerlants. 02/23/2017. Changed from "ld_s, ld_e" to "ldt_s, ldt_e"
	
	ll_enduser = 0 //Alex Gerlants. 05/17/2017
	//wf_add_coils_inprocess(ll_cust, ll_enduser, ldt_s, ldt_e) //Alex Gerlants. 05/17/2017
END IF
end subroutine

public subroutine wf_abc_coil_index_coil ();Date ld_s, ld_e
DateTime ldt_s, ldt_e //Alex Gerlants. 02/23/2017
Long ll_cust_row, ll_enduser

ll_cust_row = dw_allcust.GetRow()
ll_enduser = dw_allcust.GetItemNumber(ll_cust_row, "customer_id")
IF rb_dateall.Checked THEN
	//ld_s = Date("00/00/0000")
	//ld_e = Date("12/31/9999")
	
	ldt_s = DateTime(Date("00/00/0000"), Time("00:00:00")) //Alex Gerlants. 02/23/2017
	ldt_e = DateTime(Date("12/31/9999"), Time("23:59:59")) //Alex Gerlants. 02/23/2017
ELSE
	//ld_s = Date(em_from.Text)
	//ld_e = Date(em_to.Text)
	
	ldt_s = DateTime(Date(em_from.Text), Time("00:00:00")) //Alex Gerlants. 02/23/2017
	ldt_e = DateTime(Date(em_to.Text), Time("23:59:59")) //Alex Gerlants. 02/23/2017
END IF
IF rb_enduser.Checked THEN 
	dw_report.Retrieve(ldt_s, ldt_e, ll_enduser) //Alex Gerlants. 02/23/2017. Changed from "ld_s, ld_e" to "ldt_s, ldt_e"
ELSE
	dw_report.retrieve(ldt_s, ldt_e) //Alex Gerlants. 02/23/2017. Changed from "ld_s, ld_e" to "ldt_s, ldt_e"
END IF
end subroutine

public subroutine wf_setfilter ();String ls_s, ls_status
Int li_status, li_rtn
String	ls_status_desc

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
	IF cbx_1.Checked THEN 
		li_status = 2
		
		IF Len(ls_status) < 3 THEN
			ls_status = "( " + "coil_coil_status = " + String(li_status)
		ELSE
			ls_status = ls_status + " OR " + "coil_coil_status = " + String(li_status)
		END IF
	End If //Alex Gerlants. 05/17/2017 
	
	IF cbx_2.Checked THEN
		li_status = 1
		IF Len(ls_status) < 3 THEN
			ls_status = "( " + "coil_coil_status = " + String(li_status)
		ELSE
			ls_status = ls_status + " OR " + "coil_coil_status = " + String(li_status)
		END IF
	End If //Alex Gerlants. 05/17/2017
	
	IF cbx_3.Checked THEN 
		li_status = 3
		
		IF Len(ls_status) < 3 THEN
			ls_status = "( " + "coil_coil_status = " + String(li_status)
		ELSE
			ls_status = ls_status + " OR " + "coil_coil_status = " + String(li_status)
		END IF
	End If //Alex Gerlants. 05/17/2017
	
	IF cbx_4.Checked THEN
		li_status = 5
		
		IF Len(ls_status) < 3 THEN
			ls_status = "( " + "coil_coil_status = " + String(li_status)
		ELSE
			ls_status = ls_status + " OR " + "coil_coil_status = " + String(li_status)
		END IF
	End If //Alex Gerlants. 05/17/2017
	
	IF cbx_5.Checked THEN
		li_status = 4
		
		IF Len(ls_status) < 3 THEN
			ls_status = "( " + "coil_coil_status = " + String(li_status)
		ELSE
			ls_status = ls_status + " OR " + "coil_coil_status = " + String(li_status)
		END IF
	End If //Alex Gerlants. 05/17/2017
	
	IF cbx_6.Checked THEN
		li_status = 6
		
		IF Len(ls_status) < 3 THEN
			ls_status = "( " + "coil_coil_status = " + String(li_status)
		ELSE
			ls_status = ls_status + " OR " + "coil_coil_status = " + String(li_status)
		END IF
	End If //Alex Gerlants. 05/17/2017
	
	IF cbx_7.Checked THEN
		li_status = 7
		
		IF Len(ls_status) < 3 THEN
			ls_status = "( " + "coil_coil_status = " + String(li_status)
		ELSE
			ls_status = ls_status + " OR " + "coil_coil_status = " + String(li_status)
		END IF
	End If //Alex Gerlants. 05/17/2017
	
	IF cbx_8.Checked THEN
		li_status = 8
		
		IF Len(ls_status) < 3 THEN
			ls_status = "( " + "coil_coil_status = " + String(li_status)
		ELSE
			ls_status = ls_status + " OR " + "coil_coil_status = " + String(li_status)
		END IF
	End If //Alex Gerlants. 05/17/2017
	
	IF Pos(ls_status, "(") > 0 THEN
		ls_status = ls_status + " )"
	END IF
	
	IF Len(ls_s) > 3 THEN
		ls_s = ls_s + " and " + ls_status
	ELSE
		ls_s = ls_status
	END IF
	
	//Alex Gerlants. 05/17/2017. Begin
	If cbx_prerecap.Checked Then
		If Len(ls_status_desc) < 3 Then
			ls_status_desc = "( " + "coil_status_desc = '" + "PreRecap" + "'"
		Else
			ls_status_desc = ls_status_desc + " OR " + "coil_status_desc = '" + "PreRecap" + "'"
		End If
	End If
	
	//Alex Gerlants. 03/13/2019. Add_Coil_Status_To_Coil_Inv_Report. Begin
	If cbx_scrap.Checked Then
		If Len(ls_status_desc) < 3 Then
			ls_status_desc = "( " + "coil_status_desc = '" + "Scrap" + "'"
		Else
			ls_status_desc = ls_status_desc + " OR " + "coil_status_desc = '" + "Scrap" + "'"
		End If
	End If
	//Alex Gerlants. 03/13/2019. Add_Coil_Status_To_Coil_Inv_Report. End
	
	If cbx_2.Checked Then //InProcess
		If Len(ls_status_desc) < 3 Then
			ls_status_desc = "( " + "coil_status_desc = '" + "InProcess" + "'"
		Else
			ls_status_desc = ls_status_desc + " OR " + "coil_status_desc = '" + "InProcess" + "'"
		End If
	End If
	
	If ls_status_desc <> "" Then
		ls_status_desc = ls_status_desc + ")"
	End If
	
	If ls_s <> "" Then
		If ls_status_desc <> "" Then
			ls_s = "(" + ls_s + ") or (" + ls_status_desc + ")"
		End If
	Else
		If ls_status_desc <> "" Then
			ls_s = ls_status_desc
		End If
	End If
	//Alex Gerlants. 05/17/2017. End
	
END IF

li_rtn = dw_report.inv_filter.of_SetFilter(ls_s)
li_rtn = dw_report.inv_filter.of_Filter()

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
String		ls_range, ls_total_coil_orig_net_wt, ls_total_coil_current_net_wt_balance, ls_total_coil_count
Boolean		lb_rtn, lb_directoryexists

String 		ls_file, ls_today, ls_now, ls_folder
Date 			ld_today
Time 			ld_now
Integer		li_answer

//Get report totals
ll_report_rows = dw_report.RowCount()
If ll_report_rows > 0 Then
	Choose Case dw_report.DataObject
		Case "d_report_inv_abc_coils"
			ls_total_coil_count = String(dw_report.Object.compute_3[1])
			ls_total_coil_orig_net_wt = String(dw_report.Object.compute_4[1])
			ls_total_coil_current_net_wt_balance = String(dw_report.Object.compute_2[1])
			
		Case "d_report_inv_abc_coils_e"
			ls_total_coil_count = String(dw_report.Object.compute_2[1])
			ls_total_coil_orig_net_wt = String(dw_report.Object.compute_3[1])
			ls_total_coil_current_net_wt_balance = String(dw_report.Object.compute_4[1])
			
		Case "d_report_inv_cust_coils"
			ls_total_coil_count = String(dw_report.Object.compute_2[1])
			ls_total_coil_orig_net_wt = String(dw_report.Object.compute_3[1])
			ls_total_coil_current_net_wt_balance = String(dw_report.Object.compute_4[1])
			
		Case "d_report_inv_cust_coils_e"
			ls_total_coil_count = String(dw_report.Object.compute_3[1])
			ls_total_coil_orig_net_wt = String(dw_report.Object.compute_4[1])
			ls_total_coil_current_net_wt_balance = String(dw_report.Object.compute_2[1])
			
	End Choose
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
Choose Case dw_report.DataObject
	Case "d_report_inv_abc_coils"
		lole_OLE.cells[1,1]  = "Coil ID"
		lole_OLE.cells[1,2]  = "Customer"
		lole_OLE.cells[1,3]  = "Coil Orig No."
		lole_OLE.cells[1,4]  = "Alt. Coil No."
		lole_OLE.cells[1,5]  = "Lot No."
		lole_OLE.cells[1,6]  = "Alloy"
		lole_OLE.cells[1,7]  = "Temp"
		lole_OLE.cells[1,8]  = "End User"
		lole_OLE.cells[1,9]  = "Reference"
		lole_OLE.cells[1,10] = "Begin wt.r"
		lole_OLE.cells[1,11] = "Orig NetWT"
		lole_OLE.cells[1,12] = "Received"
		lole_OLE.cells[1,13] = "Current WT"
		lole_OLE.cells[1,14] = "Gauge"
		lole_OLE.cells[1,15] = "Width"
		lole_OLE.cells[1,16] = "Status"
		lole_OLE.cells[1,17] = "Duration"
	Case "d_report_inv_abc_coils_e" 
		lole_OLE.cells[1,1]  = "Coil ID"
		lole_OLE.cells[1,2]  = "Customer"
		lole_OLE.cells[1,3]  = "Coil Orig No."
		lole_OLE.cells[1,4]  = "Alt. Coil No."
		lole_OLE.cells[1,5]  = "Lot No."
		lole_OLE.cells[1,6]  = "Alloy"
		lole_OLE.cells[1,7]  = "Temp"
		lole_OLE.cells[1,8]  = "End User"
		lole_OLE.cells[1,9]  = "Reference"
		lole_OLE.cells[1,10] = "Begin WT"
		lole_OLE.cells[1,11] = "Received"
		lole_OLE.cells[1,12] = "Current WT"
		lole_OLE.cells[1,13] = "Gauge"
		lole_OLE.cells[1,14] = "Width"
		lole_OLE.cells[1,15] = "Status"
		lole_OLE.cells[1,16] = "Duration"
	Case "d_report_inv_cust_coils"
		lole_OLE.cells[1,1]  = "Coil ID"
		lole_OLE.cells[1,2]  = "Coil Orig No."
		lole_OLE.cells[1,3]  = "Alt. Coil No."
		lole_OLE.cells[1,4]  = "Lot No."
		lole_OLE.cells[1,5]  = "Alloy"
		lole_OLE.cells[1,6]  = "Temp"
		lole_OLE.cells[1,7]  = "End User"
		lole_OLE.cells[1,8]  = "Reference"
		lole_OLE.cells[1,9] = "Begin Wt"
		lole_OLE.cells[1,10] = "Orig NetWT"
		lole_OLE.cells[1,11] = "Received"
		lole_OLE.cells[1,12] = "Cur.WT"
		lole_OLE.cells[1,13] = "Gauge"
		lole_OLE.cells[1,14] = "Width"
		lole_OLE.cells[1,15] = "Status"
		lole_OLE.cells[1,16] = "Duration"
		lole_OLE.cells[1,17] = "Cons.Coil #"
		lole_OLE.cells[1,18] = "Material#"
		lole_OLE.cells[1,19] = "CASH"
	Case "d_report_inv_cust_coils_e"
		lole_OLE.cells[1,1]  = "Coil ID"
		lole_OLE.cells[1,2]  = "Coil Orig No."
		lole_OLE.cells[1,3]  = "Alt. Coil No."
		lole_OLE.cells[1,4]  = "Lot No."
		lole_OLE.cells[1,5]  = "Alloy"
		lole_OLE.cells[1,6]  = "Temp"
		lole_OLE.cells[1,7]  = "Reference"
		lole_OLE.cells[1,8]  = "Orig NetWT"
		lole_OLE.cells[1,9]  = "Received"
		lole_OLE.cells[1,10] = "Current WT"
		lole_OLE.cells[1,11] = "Gauge"
		lole_OLE.cells[1,12] = "Width"
		lole_OLE.cells[1,13] = "Status"
		lole_OLE.cells[1,14] = "Duration"
		lole_OLE.cells[1,15] = "Concumed Coil ID"
		lole_OLE.cells[1,16] = "Material #"
		lole_OLE.cells[1,17] = "CASH"
End Choose

//Insert Lines for Header & Miscellaneous Details (3 lines above columnar data)
lole_Sheet.Range("A1:Q3").Select
lole_Sheet.Application.Selection.EntireRow.Insert 

Choose Case dw_report.DataObject
	Case "d_report_inv_abc_coils"
		lole_OLE.cells[1,8] = is_report_title
		lole_Sheet.Range("H1:H1").Select
		lole_OLE.Selection.Font.Bold = True
		lole_OLE.Selection.Font.Size = 24 //Change font size
		lole_OLE.Selection.Font.Underline = True 
		
		lole_OLE.cells[1,17] = String(Today(), "mm/dd/yyyy")
		lole_Sheet.Range("Q1:Q1").Select
		lole_OLE.Selection.Font.Bold = True
		
	Case "d_report_inv_abc_coils_e"
		lole_OLE.cells[1,8] = is_report_title
		lole_Sheet.Range("H1:H1").Select
		lole_OLE.Selection.Font.Bold = True
		lole_OLE.Selection.Font.Size = 24 //Change font size
		lole_OLE.Selection.Font.Underline = True
		
		lole_OLE.cells[1,16] = String(Today(), "mm/dd/yyyy")
		lole_Sheet.Range("P1:P1").Select
		lole_OLE.Selection.Font.Bold = True
		
	Case "d_report_inv_cust_coils"
		lole_OLE.cells[1,9] = is_report_title
		lole_Sheet.Range("I1:I1").Select
		lole_OLE.Selection.Font.Bold = True
		lole_OLE.Selection.Font.Size = 24 //Change font size
		lole_OLE.Selection.Font.Underline = True
		
		lole_OLE.cells[1,19] = String(Today(), "mm/dd/yyyy")
		lole_Sheet.Range("S1:S1").Select
		lole_OLE.Selection.Font.Bold = True
		
	Case "d_report_inv_cust_coils_e"
		lole_OLE.cells[1,8] = is_report_title
		lole_Sheet.Range("H1:H1").Select
		lole_OLE.Selection.Font.Bold = True
		lole_OLE.Selection.Font.Size = 24 //Change font size
		lole_OLE.Selection.Font.Underline = True
		
		lole_OLE.cells[1,17] = String(Today(), "mm/dd/yyyy")
		lole_Sheet.Range("Q1:Q1").Select
		lole_OLE.Selection.Font.Bold = True
		
End Choose

Choose Case dw_report.DataObject
	Case "d_report_inv_abc_coils"
		lole_OLE.cells[2,3] = "Received Date: " + is_received_date
		lole_Sheet.Range("C2:C2").Select
		lole_OLE.Selection.Font.Bold = True
		
		lole_OLE.cells[2,8] = "Status: " + is_status
		lole_Sheet.Range("H2:H2").Select
		lole_OLE.Selection.Font.Bold = True
		
		lole_OLE.cells[2,10] = "Gauge: " + is_gauge
		lole_Sheet.Range("J2:J2").Select
		lole_OLE.Selection.Font.Bold = True
		
		lole_OLE.cells[2,13] = "Width: " + is_width
		lole_Sheet.Range("M2:M2").Select
		lole_OLE.Selection.Font.Bold = True
		
	Case "d_report_inv_abc_coils_e"
		lole_OLE.cells[2,3] = "End User: " + is_enduser
		lole_Sheet.Range("C2:C2").Select
		lole_OLE.Selection.Font.Bold = True
		
		lole_OLE.cells[2,7] = "Received Date: " + is_received_date
		lole_Sheet.Range("G2:G2").Select
		lole_OLE.Selection.Font.Bold = True
		
		lole_OLE.cells[2,10] = "Status: " + is_status
		lole_Sheet.Range("J2:J2").Select
		lole_OLE.Selection.Font.Bold = True
		
		lole_OLE.cells[2,12] = "Gauge: " + is_gauge
		lole_Sheet.Range("L2:L2").Select
		lole_OLE.Selection.Font.Bold = True
		
		lole_OLE.cells[2,14] = "Width: " + is_width
		lole_Sheet.Range("N2:N2").Select
		lole_OLE.Selection.Font.Bold = True
		
	Case "d_report_inv_cust_coils"
		lole_OLE.cells[2,3] = "Received Date: " + is_received_date
		lole_Sheet.Range("C2:C2").Select
		lole_OLE.Selection.Font.Bold = True
		
		lole_OLE.cells[2,8] = "Status: " + is_status
		lole_Sheet.Range("H2:H2").Select
		lole_OLE.Selection.Font.Bold = True
		
		lole_OLE.cells[2,10] = "Gauge: " + is_gauge
		lole_Sheet.Range("J2:J2").Select
		lole_OLE.Selection.Font.Bold = True
		
		lole_OLE.cells[2,13] = "Width: " + is_width
		lole_Sheet.Range("M2:M2").Select
		lole_OLE.Selection.Font.Bold = True
	
	Case "d_report_inv_cust_coils_e"
		lole_OLE.cells[2,3] = "End User: " + is_enduser
		lole_Sheet.Range("C2:C2").Select
		lole_OLE.Selection.Font.Bold = True
		
		lole_OLE.cells[2,7] = "Received Date: " + is_received_date
		lole_Sheet.Range("G2:G2").Select
		lole_OLE.Selection.Font.Bold = True
		
		lole_OLE.cells[2,10] = "Status: " + is_status
		lole_Sheet.Range("J2:J2").Select
		lole_OLE.Selection.Font.Bold = True
		
		lole_OLE.cells[2,12] = "Gauge: " + is_gauge
		lole_Sheet.Range("L2:L2").Select
		lole_OLE.Selection.Font.Bold = True
		
		lole_OLE.cells[2,14] = "Width: " + is_width
		lole_Sheet.Range("N2:N2").Select
		lole_OLE.Selection.Font.Bold = True
		
End Choose

//---

ll_total_line1 = ll_report_rows + 5
ll_total_line2 = ll_report_rows + 6

//Insert 2 lines for totals (below columnar data)
ls_range = "A" + String(ll_total_line1) + ":" + "S" + String(ll_total_line1)
lole_Sheet.Range(ls_range).Select
lole_Sheet.Application.Selection.EntireRow.Insert

Choose Case dw_report.DataObject
	Case "d_report_inv_abc_coils"
		lole_OLE.cells[ll_total_line2,8] = "Total:"
		ls_range = "H" + String(ll_total_line2) + ":" + "H" + String(ll_total_line2)
		lole_Sheet.Range(ls_range).Select
		//lole_OLE.Selection.Font.Bold = True
		lole_OLE.Selection.Font.FontStyle = "Bold" //Another way to bold a cell
		
		lole_OLE.cells[ll_total_line2,9] = ls_total_coil_count
		ls_range = "I" + String(ll_total_line2) + ":" + "I" + String(ll_total_line2)
		lole_Sheet.Range(ls_range).Select
		//lole_OLE.Selection.Font.Bold = True
		lole_OLE.Selection.Font.FontStyle = "Bold" //Another way to bold a cell
		
		lole_OLE.cells[ll_total_line1,11] = "-------------"
		ls_range = "K" + String(ll_total_line1) + ":" + "K" + String(ll_total_line1)
		lole_Sheet.Range(ls_range).Select
		//lole_OLE.Selection.Font.Bold = True
		lole_OLE.Selection.Font.FontStyle = "Bold"
		
		lole_OLE.cells[ll_total_line2,11] = ls_total_coil_orig_net_wt
		ls_range = "K" + String(ll_total_line2) + ":" + "K" + String(ll_total_line2)
		lole_Sheet.Range(ls_range).Select
		lole_OLE.Selection.Font.Bold = True
		
		lole_OLE.cells[ll_total_line1,13] = "-------------"
		ls_range = "M" + String(ll_total_line1) + ":" + "M" + String(ll_total_line1)
		lole_Sheet.Range(ls_range).Select
		lole_OLE.Selection.Font.Bold = True
		
		lole_OLE.cells[ll_total_line2,13] = ls_total_coil_current_net_wt_balance
		ls_range = "M" + String(ll_total_line2) + ":" + "M" + String(ll_total_line2)
		lole_Sheet.Range(ls_range).Select
		lole_OLE.Selection.Font.Bold = True
		
	Case "d_report_inv_abc_coils_e"
		lole_OLE.cells[ll_total_line2,7] = "Total:"
		ls_range = "G" + String(ll_total_line2) + ":" + "G" + String(ll_total_line2)
		lole_Sheet.Range(ls_range).Select
		//lole_OLE.Selection.Font.Bold = True
		lole_OLE.Selection.Font.FontStyle = "Bold" //Another way to bold a cell
		
		lole_OLE.cells[ll_total_line2,9] = ls_total_coil_count
		ls_range = "I" + String(ll_total_line2) + ":" + "I" + String(ll_total_line2)
		lole_Sheet.Range(ls_range).Select
		//lole_OLE.Selection.Font.Bold = True
		lole_OLE.Selection.Font.FontStyle = "Bold" //Another way to bold a cell
		
		lole_OLE.cells[ll_total_line1,10] = "-------------"
		ls_range = "J" + String(ll_total_line1) + ":" + "I" + String(ll_total_line1)
		lole_Sheet.Range(ls_range).Select
		//lole_OLE.Selection.Font.Bold = True
		lole_OLE.Selection.Font.FontStyle = "Bold"
		//lole_OLE.Selection.HorizontalAlignment = "xlRight"
		
		lole_OLE.cells[ll_total_line2,10] = ls_total_coil_orig_net_wt
		ls_range = "J" + String(ll_total_line2) + ":" + "J" + String(ll_total_line2)
		lole_Sheet.Range(ls_range).Select
		lole_OLE.Selection.Font.Bold = True
		
		lole_OLE.cells[ll_total_line1,12] = "-------------"
		ls_range = "L" + String(ll_total_line1) + ":" + "L" + String(ll_total_line1)
		lole_Sheet.Range(ls_range).Select
		lole_OLE.Selection.Font.Bold = True
		
		lole_OLE.cells[ll_total_line2,12] = ls_total_coil_current_net_wt_balance
		ls_range = "L" + String(ll_total_line2) + ":" + "L" + String(ll_total_line2)
		lole_Sheet.Range(ls_range).Select
		lole_OLE.Selection.Font.Bold = True
		
	Case "d_report_inv_cust_coils"
		lole_OLE.cells[ll_total_line2,7] = "Total:"
		ls_range = "G" + String(ll_total_line2) + ":" + "G" + String(ll_total_line2)
		lole_Sheet.Range(ls_range).Select
		//lole_OLE.Selection.Font.Bold = True
		lole_OLE.Selection.Font.FontStyle = "Bold" //Another way to bold a cell
		
		lole_OLE.cells[ll_total_line2,8] = ls_total_coil_count
		ls_range = "H" + String(ll_total_line2) + ":" + "H" + String(ll_total_line2)
		lole_Sheet.Range(ls_range).Select
		//lole_OLE.Selection.Font.Bold = True
		lole_OLE.Selection.Font.FontStyle = "Bold" //Another way to bold a cell
		
		lole_OLE.cells[ll_total_line1,10] = "-------------"
		ls_range = "J" + String(ll_total_line1) + ":" + "J" + String(ll_total_line1)
		lole_Sheet.Range(ls_range).Select
		//lole_OLE.Selection.Font.Bold = True
		lole_OLE.Selection.Font.FontStyle = "Bold"
		
		lole_OLE.cells[ll_total_line2,10] = ls_total_coil_orig_net_wt
		ls_range = "J" + String(ll_total_line2) + ":" + "J" + String(ll_total_line2)
		lole_Sheet.Range(ls_range).Select
		lole_OLE.Selection.Font.Bold = True
		
		lole_OLE.cells[ll_total_line1,12] = "-------------"
		ls_range = "L" + String(ll_total_line1) + ":" + "L" + String(ll_total_line1)
		lole_Sheet.Range(ls_range).Select
		lole_OLE.Selection.Font.Bold = True
		
		lole_OLE.cells[ll_total_line2,12] = ls_total_coil_current_net_wt_balance
		ls_range = "L" + String(ll_total_line2) + ":" + "L" + String(ll_total_line2)
		lole_Sheet.Range(ls_range).Select
		lole_OLE.Selection.Font.Bold = True
	
	Case "d_report_inv_cust_coils_e"
		lole_OLE.cells[ll_total_line2,6] = "Total:"
		ls_range = "F" + String(ll_total_line2) + ":" + "H" + String(ll_total_line2)
		lole_Sheet.Range(ls_range).Select
		//lole_OLE.Selection.Font.Bold = True
		lole_OLE.Selection.Font.FontStyle = "Bold" //Another way to bold a cell
		
		lole_OLE.cells[ll_total_line2,7] = ls_total_coil_count
		ls_range = "G" + String(ll_total_line2) + ":" + "G" + String(ll_total_line2)
		lole_Sheet.Range(ls_range).Select
		//lole_OLE.Selection.Font.Bold = True
		lole_OLE.Selection.Font.FontStyle = "Bold" //Another way to bold a cell
		
		lole_OLE.cells[ll_total_line1,8] = "-------------"
		ls_range = "H" + String(ll_total_line1) + ":" + "H" + String(ll_total_line1)
		lole_Sheet.Range(ls_range).Select
		//lole_OLE.Selection.Font.Bold = True
		lole_OLE.Selection.Font.FontStyle = "Bold"
		
		lole_OLE.cells[ll_total_line2,8] = ls_total_coil_orig_net_wt
		ls_range = "H" + String(ll_total_line2) + ":" + "H" + String(ll_total_line2)
		lole_Sheet.Range(ls_range).Select
		lole_OLE.Selection.Font.Bold = True
		
		lole_OLE.cells[ll_total_line1,10] = "-------------"
		ls_range = "J" + String(ll_total_line1) + ":" + "J" + String(ll_total_line1)
		lole_Sheet.Range(ls_range).Select
		lole_OLE.Selection.Font.Bold = True
		
		lole_OLE.cells[ll_total_line2,10] = ls_total_coil_current_net_wt_balance
		ls_range = "J" + String(ll_total_line2) + ":" + "J" + String(ll_total_line2)
		lole_Sheet.Range(ls_range).Select
		lole_OLE.Selection.Font.Bold = True
		
End Choose

//--------

//Delete extra columns	
Choose Case dw_report.DataObject
	Case "d_report_inv_abc_coils"
		lole_Sheet.columns("R:BB").Delete
		
	Case "d_report_inv_abc_coils_e"
		lole_Sheet.columns("Q:BB").Delete
		
	Case "d_report_inv_cust_coils"
		lole_Sheet.columns("T:BB").Delete
		
	Case "d_report_inv_cust_coils_e"
		lole_Sheet.columns("R:BB").Delete
		
End Choose

//Justify
//lole_OLE.Selection.HorizontalAlignment = -4108 //Center
//lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
//lole_OLE.Selection.HorizontalAlignment = -4152 //Right justif
Choose Case dw_report.DataObject
	Case "d_report_inv_abc_coils"
		lole_Sheet.Range("A3:I" + String(ll_report_rows + 6)).Select
		lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
		//
		lole_Sheet.Range("I" + String(ll_total_line2) + ":" + "I" + String(ll_total_line2)).Select //One cell
		lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify one cell
		
		lole_Sheet.Range("J3:K" + String(ll_report_rows + 6)).Select
		lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify
		
		lole_Sheet.Range("L3:L" + String(ll_report_rows + 6)).Select
		lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
		
		lole_Sheet.Range("M3:O" + String(ll_report_rows + 6)).Select
		lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify
		
		lole_Sheet.Range("P3:P" + String(ll_report_rows + 6)).Select
		lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
		
		lole_Sheet.Range("Q3:Q" + String(ll_report_rows + 6)).Select
		lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

	Case "d_report_inv_abc_coils_e"
		lole_Sheet.Range("A3:I" + String(ll_report_rows + 6)).Select
		lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
		
		lole_Sheet.Range("J3:J" + String(ll_report_rows + 6)).Select
		lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify
		
		lole_Sheet.Range("K3:K" + String(ll_report_rows + 6)).Select
		lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
		
		lole_Sheet.Range("L3:N" + String(ll_report_rows + 6)).Select
		lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify
		
		lole_Sheet.Range("O3:O" + String(ll_report_rows + 6)).Select
		lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
		
		lole_Sheet.Range("P3:P" + String(ll_report_rows + 6)).Select
		lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify
		
	Case "d_report_inv_cust_coils"
		lole_Sheet.Range("A3:H" + String(ll_report_rows + 6)).Select
		lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
		
		lole_Sheet.Range("I3:J" + String(ll_report_rows + 6)).Select
		lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify
		
		lole_Sheet.Range("K3:K" + String(ll_report_rows + 6)).Select
		lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
		
		lole_Sheet.Range("L3:N" + String(ll_report_rows + 6)).Select
		lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify
		
		lole_Sheet.Range("O3:O" + String(ll_report_rows + 6)).Select
		lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
		
		lole_Sheet.Range("P3:P" + String(ll_report_rows + 6)).Select
		lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify
		
		lole_Sheet.Range("Q3:S" + String(ll_report_rows + 6)).Select
		lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
	
	Case "d_report_inv_cust_coils_e"
		lole_Sheet.Range("A3:G" + String(ll_report_rows + 6)).Select
		lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
		
		lole_Sheet.Range("H3:H" + String(ll_report_rows + 6)).Select
		lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify
		
		lole_Sheet.Range("I3:I" + String(ll_report_rows + 6)).Select
		lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
		
		lole_Sheet.Range("J3:I" + String(ll_report_rows + 6)).Select
		lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify
		
		lole_Sheet.Range("M3:M" + String(ll_report_rows + 6)).Select
		lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
		
		lole_Sheet.Range("N3:N" + String(ll_report_rows + 6)).Select
		lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify
		
		lole_Sheet.Range("O3:Q" + String(ll_report_rows + 6)).Select
		lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
		
End Choose

//Underline column headers
lole_Sheet.Range("A4:S4").Select
lole_OLE.Selection.Font.Underline = True

//Change date format for a column
Choose Case dw_report.DataObject
	Case "d_report_inv_abc_coils"
		lole_Sheet.Range("L5:L" + String(ll_report_rows + 6)).Select
		lole_OLE.Selection.NumberFormat = "mm/dd/yyyy"
	Case "d_report_inv_abc_coils_e"
		lole_Sheet.Range("K5:K" + String(ll_report_rows + 6)).Select
		lole_OLE.Selection.NumberFormat = "mm/dd/yyyy"
		
	Case "d_report_inv_cust_coils"
		lole_Sheet.Range("K5:K" + String(ll_report_rows + 6)).Select
		lole_OLE.Selection.NumberFormat = "mm/dd/yyyy"
		
	Case "d_report_inv_cust_coils_e"
		lole_Sheet.Range("I5:I" + String(ll_report_rows + 6)).Select
		lole_OLE.Selection.NumberFormat = "mm/dd/yyyy"
		
		lole_Sheet.Range("Q5:Q" + String(ll_report_rows + 6)).Select
		lole_OLE.Selection.NumberFormat = "mm/dd/yyyy"
		
End Choose

//Save the changes
SetPointer(HourGlass!)
ld_today = Today()
ld_now = Now()
ls_today = String(ld_today,"yymmdd")
ls_now = String(ld_now,"hhmmss")

ls_folder = ProfileString(gs_ini_file, "EMAIL","email_out","c:\temp\")
If Right(ls_folder, 1) <> "\" Then ls_folder = ls_folder + "\"

ls_file = ls_folder + is_report_title + "_" + ls_today + ls_now + ".xls"

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

public subroutine wf_add_coils_inprocess (long al_cust, long al_enduser, datetime adt_s, datetime adt_e);//Alex Gerlants. 05/17/2017. Begin
/*
Function:	wf_add_coils_inprocess 
Returns:		none
Arguments:	value	long		al_cust
				value	long		al_enduser
				value	datetime	adt_s
				value	datetime	adt_e
*/

Integer		li_rtn = 1
Long			ll_row, ll_rows, ll_rows_add, ll_rows_orig, ll_ab_job_num, ll_inserted_row
Long			ll_coil_coil_abc_num, ll_coil_coil_abc_num_prev
Long			ll_coil_net_wt, ll_coil_net_wt_balance, ll_coil_net_wt_accum, ll_coil_net_wt_balance_accum
Long			ll_counter, ll_counter_inprocess
Long			ll_count_line_current_status
Long			ll_coil_abc_num_inprogress, ll_found_row
String		ls_rtn, ls_sql, ls_dataobject_dw_report, ls_dataobject_add
String		ls_coil_status_desc, ls_inprocess, ls_prerecap, ls_filter_string
DataStore	lds_report_inv_cust_coils_add, lds_coil_add

If cbx_include_coils_inprocess.Checked = False Then Return
ll_rows_orig = dw_report.RowCount()

ls_dataobject_dw_report = dw_report.DataObject
ls_dataobject_add = ls_dataobject_dw_report + "_add"

lds_report_inv_cust_coils_add = Create DataStore
lds_report_inv_cust_coils_add.DataObject = ls_dataobject_add
lds_report_inv_cust_coils_add.setTransObject(sqlca)

//ls_sql = lds_report_inv_cust_coils_add.GetSqlSelect() //For debugging only

If al_cust > 0 and al_enduser > 0 Then
	ll_rows_add = lds_report_inv_cust_coils_add.Retrieve(al_cust, adt_s, adt_e, al_enduser)
ElseIf al_cust = 0 And al_enduser = 0 Then
	ll_rows_add = lds_report_inv_cust_coils_add.Retrieve(adt_s, adt_e)
ElseIf al_cust > 0 and al_enduser = 0 Then
	ll_rows_add = lds_report_inv_cust_coils_add.Retrieve(al_cust, adt_s, adt_e)
Else //al_cust = 0 and al_enduser > 0
	ll_rows_add = lds_report_inv_cust_coils_add.Retrieve(adt_s, adt_e, al_enduser)
End If

//dw_report.Print() //For debugging only
//lds_report_inv_cust_coils_add.Print() //For debugging only

If ll_rows_add > 0 Then
	//Add rows to the end of the report
	li_rtn = lds_report_inv_cust_coils_add.RowsCopy(1, lds_report_inv_cust_coils_add.RowCount(), Primary!, dw_report, dw_report.RowCount() + 1, Primary!)
Else
	li_rtn = 1
End If

If li_rtn = 1 Then //OK in RowsCopy()
	wf_recalculate_totals()
End if
//Alex Gerlants. 05/17/2017. End
end subroutine

public function integer wf_recalculate_totals ();//Alex Gerlants. 05/16/2017. Begin
/*
Function:	wf_recalculate_totals
Returns:		integer
Arguments:	none
*/

Integer		li_rtn = 1
Long			ll_row, ll_rows, ll_rows_add, ll_rows_orig, ll_ab_job_num, ll_inserted_row
Long			ll_coil_coil_abc_num, ll_coil_coil_abc_num_prev
Long			ll_coil_net_wt, ll_coil_net_wt_balance, ll_coil_net_wt_accum, ll_coil_net_wt_balance_accum
Long			ll_counter, ll_counter_inprocess
Long			ll_count_line_current_status
Long			ll_coil_abc_num_inprogress, ll_found_row
String		ls_rtn, ls_sql, ls_dataobject_dw_report, ls_dataobject_add
String		ls_coil_status_desc, ls_inprocess, ls_prerecap, ls_filter_string
DataStore	lds_report_inv_cust_coils_add, lds_coil_add

ll_coil_coil_abc_num_prev = 0

dw_report.SetSort("coil_coil_abc_num Asc")
dw_report.Sort()

//dw_report.Print() //For debugging only
//lds_report_inv_cust_coils_add.Print() //For debugging only

ll_rows = dw_report.RowCount()

For ll_row = 1 To ll_rows
	ll_coil_coil_abc_num = dw_report.Object.coil_coil_abc_num[ll_row]
	ls_coil_status_desc = dw_report.Object.coil_status_desc[ll_row]
	
	If ll_coil_coil_abc_num <> ll_coil_coil_abc_num_prev Then
		ll_counter++
	End If
	ll_coil_coil_abc_num_prev = ll_coil_coil_abc_num
	
	ll_coil_net_wt = dw_report.Object.coil_net_wt[ll_row]
	ll_coil_net_wt_accum = ll_coil_net_wt_accum + ll_coil_net_wt
	
	ll_coil_net_wt_balance = dw_report.Object.coil_net_wt_balance[ll_row]
	ll_coil_net_wt_balance_accum = ll_coil_net_wt_balance_accum + ll_coil_net_wt_balance
	
	If ls_coil_status_desc <> "PreRecap" Then
		select  	count(*)
		into    	:ll_counter_inprocess
		from    	line_current_status
		where   	coil_abc_num = :ll_coil_coil_abc_num
		using		sqlca;
		
		If sqlca.sqlcode = 0 Then //OK
			If ll_counter_inprocess > 0 Then //This coil is currently in process
				dw_report.Object.coil_status_desc[ll_row] = "InProcess"
			End If
		End If
	End If
	
	dw_report.SetItemStatus(ll_row, 0, Primary!, NotModified!)
Next


Choose Case ls_dataobject_dw_report
	Case "d_report_inv_abc_coils"
		ls_rtn = dw_report.Modify("compute_3.Expression = '" + String(ll_counter) + "'")
		ls_rtn = dw_report.Modify("compute_4.Expression = '" + String(ll_coil_net_wt_accum) + "'")
		ls_rtn = dw_report.Modify("compute_2.Expression = '" + String(ll_coil_net_wt_balance_accum) + "'")
	Case "d_report_inv_abc_coils_e"
		ls_rtn = dw_report.Modify("compute_2.Expression = '" + String(ll_counter) + "'")
		ls_rtn = dw_report.Modify("compute_3.Expression = '" + String(ll_coil_net_wt_accum) + "'")
		ls_rtn = dw_report.Modify("compute_4.Expression = '" + String(ll_coil_net_wt_balance_accum) + "'")
	Case "d_report_inv_cust_coils"
		ls_rtn = dw_report.Modify("compute_2.Expression = '" + String(ll_counter) + "'")
		ls_rtn = dw_report.Modify("compute_3.Expression = '" + String(ll_coil_net_wt_accum) + "'")
		ls_rtn = dw_report.Modify("compute_4.Expression = '" + String(ll_coil_net_wt_balance_accum) + "'")
	Case "d_report_inv_cust_coils_e"
		ls_rtn = dw_report.Modify("compute_3.Expression = '" + String(ll_counter) + "'")
		ls_rtn = dw_report.Modify("compute_4.Expression = '" + String(ll_coil_net_wt_accum) + "'")
		ls_rtn = dw_report.Modify("compute_2.Expression = '" + String(ll_coil_net_wt_balance_accum) + "'")
End Choose


Return li_rtn
//Alex Gerlants. 05/16/2017. End
end function

public subroutine wf_set_coils_inprocess ();//Alex Gerlants. 05/17/2017. Begin
/*
Function:	wf_set_coils_inprocess
Returns:		none
Arguments:	none
*/

Long	ll_rows, ll_row, ll_coil_coil_abc_num, ll_counter_inprocess

ll_rows = dw_report.RowCount()

//dw_report.Print()

For ll_row = 1 To ll_rows
	ll_coil_coil_abc_num = dw_report.Object.coil_coil_abc_num[ll_row]
	
	select  	count(*)
	into    	:ll_counter_inprocess
	from    	line_current_status
	where   	coil_abc_num = :ll_coil_coil_abc_num
	using		sqlca;
	
	If sqlca.sqlcode = 0 Then //OK
		If ll_counter_inprocess > 0 Then //This coil is currently in process
			dw_report.Object.coil_status_desc[ll_row] = "InProcess"
		End If
	End If

	dw_report.SetItemStatus(ll_row, 0, Primary!, NotModified!)
Next
end subroutine

on w_report_customer_coils.create
int iCurrent
call super::create
this.cbx_scrap=create cbx_scrap
this.cbx_prerecap=create cbx_prerecap
this.cbx_include_coils_inprocess=create cbx_include_coils_inprocess
this.cb_1=create cb_1
this.cb_export=create cb_export
this.dw_report=create dw_report
this.cb_print=create cb_print
this.dw_customer=create dw_customer
this.cb_close=create cb_close
this.cb_preview=create cb_preview
this.ddlb_customer=create ddlb_customer
this.st_3=create st_3
this.em_from=create em_from
this.em_to=create em_to
this.cb_setzoom=create cb_setzoom
this.ddlb_enduser=create ddlb_enduser
this.dw_allcust=create dw_allcust
this.gb_5=create gb_5
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.rb_custall=create rb_custall
this.rb_cust=create rb_cust
this.rb_dateall=create rb_dateall
this.rb_date=create rb_date
this.rb_enduserall=create rb_enduserall
this.rb_enduser=create rb_enduser
this.rb_statusall=create rb_statusall
this.rb_status=create rb_status
this.rb_specsall=create rb_specsall
this.rb_specs=create rb_specs
this.em_gauge=create em_gauge
this.st_1=create st_1
this.em_width=create em_width
this.cb_sort=create cb_sort
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
this.cbx_3=create cbx_3
this.cbx_4=create cbx_4
this.cbx_5=create cbx_5
this.cbx_6=create cbx_6
this.cbx_7=create cbx_7
this.cbx_8=create cbx_8
this.cb_email=create cb_email
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_scrap
this.Control[iCurrent+2]=this.cbx_prerecap
this.Control[iCurrent+3]=this.cbx_include_coils_inprocess
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_export
this.Control[iCurrent+6]=this.dw_report
this.Control[iCurrent+7]=this.cb_print
this.Control[iCurrent+8]=this.dw_customer
this.Control[iCurrent+9]=this.cb_close
this.Control[iCurrent+10]=this.cb_preview
this.Control[iCurrent+11]=this.ddlb_customer
this.Control[iCurrent+12]=this.st_3
this.Control[iCurrent+13]=this.em_from
this.Control[iCurrent+14]=this.em_to
this.Control[iCurrent+15]=this.cb_setzoom
this.Control[iCurrent+16]=this.ddlb_enduser
this.Control[iCurrent+17]=this.dw_allcust
this.Control[iCurrent+18]=this.gb_5
this.Control[iCurrent+19]=this.gb_3
this.Control[iCurrent+20]=this.gb_2
this.Control[iCurrent+21]=this.gb_1
this.Control[iCurrent+22]=this.rb_custall
this.Control[iCurrent+23]=this.rb_cust
this.Control[iCurrent+24]=this.rb_dateall
this.Control[iCurrent+25]=this.rb_date
this.Control[iCurrent+26]=this.rb_enduserall
this.Control[iCurrent+27]=this.rb_enduser
this.Control[iCurrent+28]=this.rb_statusall
this.Control[iCurrent+29]=this.rb_status
this.Control[iCurrent+30]=this.rb_specsall
this.Control[iCurrent+31]=this.rb_specs
this.Control[iCurrent+32]=this.em_gauge
this.Control[iCurrent+33]=this.st_1
this.Control[iCurrent+34]=this.em_width
this.Control[iCurrent+35]=this.cb_sort
this.Control[iCurrent+36]=this.cbx_1
this.Control[iCurrent+37]=this.cbx_2
this.Control[iCurrent+38]=this.cbx_3
this.Control[iCurrent+39]=this.cbx_4
this.Control[iCurrent+40]=this.cbx_5
this.Control[iCurrent+41]=this.cbx_6
this.Control[iCurrent+42]=this.cbx_7
this.Control[iCurrent+43]=this.cbx_8
this.Control[iCurrent+44]=this.cb_email
this.Control[iCurrent+45]=this.gb_4
end on

on w_report_customer_coils.destroy
call super::destroy
destroy(this.cbx_scrap)
destroy(this.cbx_prerecap)
destroy(this.cbx_include_coils_inprocess)
destroy(this.cb_1)
destroy(this.cb_export)
destroy(this.dw_report)
destroy(this.cb_print)
destroy(this.dw_customer)
destroy(this.cb_close)
destroy(this.cb_preview)
destroy(this.ddlb_customer)
destroy(this.st_3)
destroy(this.em_from)
destroy(this.em_to)
destroy(this.cb_setzoom)
destroy(this.ddlb_enduser)
destroy(this.dw_allcust)
destroy(this.gb_5)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.rb_custall)
destroy(this.rb_cust)
destroy(this.rb_dateall)
destroy(this.rb_date)
destroy(this.rb_enduserall)
destroy(this.rb_enduser)
destroy(this.rb_statusall)
destroy(this.rb_status)
destroy(this.rb_specsall)
destroy(this.rb_specs)
destroy(this.em_gauge)
destroy(this.st_1)
destroy(this.em_width)
destroy(this.cb_sort)
destroy(this.cbx_1)
destroy(this.cbx_2)
destroy(this.cbx_3)
destroy(this.cbx_4)
destroy(this.cbx_5)
destroy(this.cbx_6)
destroy(this.cbx_7)
destroy(this.cbx_8)
destroy(this.cb_email)
destroy(this.gb_4)
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

ls_title = ProfileString(gs_ini_file, "REPORT","file_path","c:\temp")+'\' +"Inv_" + ls_cust + '_' + ls_from + '_' + ls_to +".PSR"

IF dw_report.SaveAs(ls_title, PSReport!, FALSE) =-1 THEN
  	MessageBox("Quotation DataStore SaveAs", "Error") 
	RETURN
END IF

MessageBox("Success", "File has been saved as " + ls_title + " Successfully!" )


end event

type cbx_scrap from checkbox within w_report_customer_coils
integer x = 1646
integer y = 246
integer width = 216
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Scrap"
end type

type cbx_prerecap from checkbox within w_report_customer_coils
integer x = 1159
integer y = 246
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
boolean enabled = false
string text = "PreRecap"
end type

type cbx_include_coils_inprocess from checkbox within w_report_customer_coils
integer x = 4122
integer y = 38
integer width = 585
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Include PreRecap Coils"
boolean checked = true
end type

event clicked;String	ls_rtn

//I am changing DataObjects to the same because otherwise, the 3 computed totals stay the same
//as the totals from the previous retrieve.
Choose Case dw_report.DataObject
Case "d_report_inv_abc_coils"
	dw_report.DataObject = "d_report_inv_abc_coils"
Case "d_report_inv_abc_coils_e"
	dw_report.DataObject = "d_report_inv_abc_coils_e"
Case "d_report_inv_cust_coils"
	dw_report.DataObject = "d_report_inv_cust_coils"
Case "d_report_inv_cust_coils_e"
	dw_report.DataObject = "d_report_inv_cust_coils_e"
End Choose

dw_report.SetTransObject(sqlca)
end event

type cb_1 from commandbutton within w_report_customer_coils
integer x = 1913
integer y = 2131
integer width = 380
integer height = 77
integer taborder = 80
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

type cb_export from u_cb within w_report_customer_coils
integer x = 1477
integer y = 2131
integer width = 406
integer height = 77
integer taborder = 180
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

ls_file = ProfileString(gs_ini_file, "EMAIL","email_out","c:\temp")+'\Customer Coil Inventory Report_' + ls_today + ls_now + ".xls"
//if dw_report.SaveAs(ls_file,HTMLTable!, TRUE) =-1 then //Alex Gerlants. 04/20/2016. Commented out
If dw_report.SaveAs(ls_file, Excel8!, True) = -1 Then //Alex Gerlants. 04/20/2016
   MessageBox("Data SaveAs", "Error")
	Return -1
Else
	MessageBox("Success", "Data have been successfully exported to " + ls_file)
End If

Return 1
end event

type dw_report from u_dw within w_report_customer_coils
event ue_retrieve ( )
event ue_clean_duplicates ( )
integer x = 15
integer y = 416
integer width = 4718
integer height = 1638
integer taborder = 120
string dataobject = "d_report_inv_abc_coils"
boolean hscrollbar = true
end type

event ue_retrieve();//Alex Gerlants. 10/03/2017. Begin
DataStore	lds_unmatched_coils
Long			ll_rows

lds_unmatched_coils = Create DataStore
lds_unmatched_coils.DataObject = "d_unmatched_coils"
lds_unmatched_coils.SetTransObject(sqlca)
//Alex Gerlants. 10/03/2017. End

dw_report.Reset()

dw_report.SetFilter("") //Alex Gerlants. 05/17/2017
dw_report.Filter() //Alex Gerlants. 05/17/2017

Int li_count;
Long ll_cust_row;
Long ll_cust;

IF rb_custall.Checked THEN //All Customer

	//Alex Gerlants. 10/03/2017. Begin
	ll_rows = lds_unmatched_coils.Retrieve(0, 999999)
	
	If ll_rows > 0 Then
		OpenWithParm(w_unmatched_coils, lds_unmatched_coils)
		Return
	End If
	//Alex Gerlants. 10/03/2017. End

	li_count = 0;
	
	SELECT count(*) into :li_count
	FROM PROCESS_COIL p, COIL c, customer cu
	WHERE c.CUSTOMER_ID = cu.CUSTOMER_ID
	and c.COIL_ABC_NUM  = p.COIL_ABC_NUM
	AND c.COIL_STATUS <> 0
	AND p.PROCESS_COIL_STATUS = 0
	using SQLCA;
	
	if li_count > 0 then
		MessageBox("Warning Message", "Status unmatched coil(s) found, please contact system dept before generating report.", StopSign!, OK!) 
		return
	end if
	wf_abc_coil_index_coil()
ELSE // Customer
	ll_cust_row = dw_customer.GetRow()
	ll_cust = dw_customer.GetItemNumber(ll_cust_row, "customer_id")
	
	//Alex Gerlants. 10/03/2017. Begin
	ll_rows = lds_unmatched_coils.Retrieve(ll_cust, ll_cust)
	
	If ll_rows > 0 Then
		OpenWithParm(w_unmatched_coils, lds_unmatched_coils)
		Return
	End If
	//Alex Gerlants. 10/03/2017. End
	
	li_count = 0;
	
	SELECT count(*) into :li_count
	FROM PROCESS_COIL p, COIL c, customer cu
	WHERE c.CUSTOMER_ID = cu.CUSTOMER_ID
	and c.COIL_ABC_NUM  = p.COIL_ABC_NUM
	AND c.COIL_STATUS <> 0
	AND p.PROCESS_COIL_STATUS = 0
	AND cu.CUSTOMER_ID = :ll_cust
	using SQLCA;
	
	if li_count > 0 then
		MessageBox("Warning Message", "Status unmatched coil(s) found, please contact system dept before generating report.", StopSign!, OK!) 
		return
	end if
	
	
	wf_customer_coil_index_coil()
END IF
wf_settitle()

wf_setfilter()
this.Event ue_clean_duplicates()

dw_report.SetSort("coil_coil_abc_num Asc") //Alex Gerlants. 05/17/2017
dw_report.Sort() //Alex Gerlants. 05/17/2017







end event

event ue_clean_duplicates();Long ll_row, ll_i

ll_row = this.RowCount()
IF ll_row < 2 THEN RETURN
FOR ll_i = ll_row TO 2 STEP -1
	IF this.GetItemString(ll_i, "coil_coil_org_num") = this.GetItemString((ll_i - 1), "coil_coil_org_num") THEN
		IF (this.GetItemString(ll_i, "coil_coil_mid_num") = this.GetItemString((ll_i - 1), "coil_coil_mid_num")) OR ISNULL(this.GetItemString(ll_i, "coil_coil_mid_num")) THEN
			IF this.GetItemString(ll_i, "coil_lot_num") = this.GetItemString((ll_i - 1), "coil_lot_num") THEN
				If Right(This.DataObject, 2) <> "_e" Then
					//IF this.GetItemNumber(ll_i, "customer_order_enduser_id") = this.GetItemNumber((ll_i - 1), "customer_order_enduser_id") THEN //Alex Gerlants. 05/03/2016. Comment out
					IF this.GetItemString(ll_i, "enduser_name") = this.GetItemString((ll_i - 1), "enduser_name") THEN //Alex Gerlants. 05/03/2016
							this.DeleteRow(ll_i)
					END IF
				Else
					this.DeleteRow(ll_i)
				End If
			END IF
		END IF
	END IF
NEXT
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

event retrieveend;call super::retrieveend;//Alex Gerlants. 09/18/2017. Begin
/*
Remove rows with duplicate coil_org_num
*/

//Alex Gerlants. 01/23/2018. Begin
/*
Remove rows with duplicate combination of coil_org_num and coil_abc_num
*/

Long		ll_rows, ll_row
Integer	li_rtn
String	ls_coil_coil_org_num_prev, ls_coil_coil_org_num
String	ls_coil_coil_abc_num_prev, ls_coil_coil_abc_num
String	ls_key, ls_key_prev

ll_rows = rowcount
If ll_rows <= 0 Then Return 0

li_rtn = dw_report.SetSort("coil_coil_org_num Asc, coil_coil_abc_num Asc")
li_rtn = dw_report.Sort()

//ls_coil_coil_org_num_prev = ""
ls_key_prev = ""

For ll_row = ll_rows To 1 Step -1
	ls_coil_coil_org_num = dw_report.Object.coil_coil_org_num[ll_row]
	ls_coil_coil_abc_num = String(dw_report.Object.coil_coil_abc_num[ll_row])
	
	ls_key = ls_coil_coil_org_num + ls_coil_coil_abc_num
	
	//If ls_coil_coil_org_num = ls_coil_coil_org_num_prev Then
	If ls_key = ls_key_prev Then
		dw_report.DeleteRow(ll_row)
	End If
	
	//ls_coil_coil_org_num_prev = ls_coil_coil_org_num
	ls_key_prev = ls_key
Next
//Alex Gerlants. 09/18/2017. End
end event

type cb_print from u_cb within w_report_customer_coils
integer x = 2330
integer y = 2131
integer width = 307
integer height = 77
integer taborder = 190
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;Parent.Event pfc_print()
end event

type dw_customer from u_dw within w_report_customer_coils
boolean visible = false
integer x = 2399
integer y = 1693
integer width = 132
integer height = 42
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

type cb_close from u_cb within w_report_customer_coils
string tag = "Exit"
integer x = 2714
integer y = 2131
integer width = 322
integer height = 77
integer taborder = 200
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_preview from u_cb within w_report_customer_coils
event clicked pbm_bnclicked
integer y = 2131
integer width = 307
integer height = 77
integer taborder = 140
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Retrieve"
end type

event clicked;dw_report.Event ue_retrieve()

end event

type ddlb_customer from dropdownlistbox within w_report_customer_coils
integer x = 252
integer y = 109
integer width = 845
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

ls_text = Text(index)

IF rb_enduser.Checked THEN 
	dw_report.DataObject = "d_report_inv_cust_coils_e"
ELSE
	dw_report.DataObject = "d_report_inv_cust_coils"
END IF							
ll_row = dw_customer.RowCount()
FOR ll_i = 1 TO ll_row
	IF dw_customer.GetItemString(ll_i, "customer_short_name") = ls_text THEN
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

type st_3 from statictext within w_report_customer_coils
integer x = 2728
integer y = 115
integer width = 95
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

type em_from from editmask within w_report_customer_coils
integer x = 2432
integer y = 109
integer width = 282
integer height = 77
integer taborder = 100
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

type em_to from editmask within w_report_customer_coils
integer x = 2783
integer y = 109
integer width = 271
integer height = 77
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
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
end type

event constructor;this.Text = String(Today(), "mm/dd/yyyy")

end event

event losefocus;wf_settitle()

RETURN 1
end event

type cb_setzoom from u_cb within w_report_customer_coils
integer x = 768
integer y = 2131
integer width = 307
integer height = 77
integer taborder = 160
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&SetZoom"
end type

event clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type ddlb_enduser from dropdownlistbox within w_report_customer_coils
integer x = 1368
integer y = 109
integer width = 801
integer height = 1197
integer taborder = 130
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

type dw_allcust from u_dw within w_report_customer_coils
boolean visible = false
integer x = 2406
integer y = 1661
integer width = 121
integer height = 35
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

type gb_5 from u_gb within w_report_customer_coils
integer x = 7
integer y = 205
integer width = 911
integer height = 205
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Specs"
end type

type gb_3 from u_gb within w_report_customer_coils
integer x = 1134
integer width = 1050
integer height = 205
integer taborder = 50
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "End User"
end type

type gb_2 from u_gb within w_report_customer_coils
integer x = 2198
integer width = 1068
integer height = 205
integer taborder = 30
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Received Date"
end type

type gb_1 from u_gb within w_report_customer_coils
integer x = 7
integer width = 1115
integer height = 205
integer taborder = 60
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Customer"
end type

type rb_custall from u_rb within w_report_customer_coils
integer x = 26
integer y = 48
integer width = 208
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "All"
boolean checked = true
end type

event clicked;IF this.Checked THEN
	ddlb_customer.Enabled = FALSE
	IF rb_enduser.Checked THEN 
		dw_report.DataObject = "d_report_inv_abc_coils_e" 
	ELSE
		dw_report.DataObject = "d_report_inv_abc_coils" 
	END IF											
ELSE
	ddlb_customer.Enabled = TRUE
END IF

dw_report.SetTransObject(SQLCA)
wf_settitle()

//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.
RETURN 1
end event

type rb_cust from u_rb within w_report_customer_coils
integer x = 26
integer y = 112
integer width = 201
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Select"
end type

event clicked;IF this.Checked THEN
	ddlb_customer.Enabled = TRUE
	
	//Alex Gerlants. 05/16/2017. Bug fix. Begin
	If rb_enduser.Checked = True Then
		dw_report.DataObject = "d_report_inv_cust_coils_e"
	Else
		dw_report.DataObject = "d_report_inv_cust_coils"
	End if
	//Alex Gerlants. 05/16/2017. Bug fix. End
ELSE
	ddlb_customer.Enabled = FALSE
	
	//Alex Gerlants. 05/16/2017. Bug fix. Begin
	If rb_enduser.Checked = True Then
		dw_report.DataObject = "d_report_inv_abc_coils_e"
	Else
		dw_report.DataObject = "d_report_inv_abc_coils"
	End if
	//Alex Gerlants. 05/16/2017. Bug fix. End
END IF

dw_report.SetTransObject(sqlca) //Alex Gerlants. 05/16/2017. Bug fix)

wf_settitle()	
end event

type rb_dateall from u_rb within w_report_customer_coils
integer x = 2238
integer y = 48
integer width = 179
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
	em_to.Enabled = TRUE
END IF
wf_settitle()

//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.
RETURN 1
end event

type rb_date from u_rb within w_report_customer_coils
integer x = 2238
integer y = 112
integer width = 194
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
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
end event

type rb_enduserall from u_rb within w_report_customer_coils
integer x = 1156
integer y = 48
integer width = 176
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "All"
boolean checked = true
end type

event clicked;IF this.Checked THEN
	ddlb_enduser.Enabled = FALSE
	IF rb_custall.Checked THEN 
		dw_report.DataObject = "d_report_inv_abc_coils"
	ELSE
		dw_report.DataObject = "d_report_inv_cust_coils"
	END IF								
ELSE
	ddlb_enduser.Enabled = TRUE
END IF
dw_report.SetTransObject(SQLCA)
wf_settitle()
//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.
RETURN 1
end event

type rb_enduser from u_rb within w_report_customer_coils
integer x = 1156
integer y = 112
integer width = 208
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Select"
end type

event clicked;dw_report.Reset()
IF this.Checked THEN 
	ddlb_enduser.Enabled = TRUE
	dw_report.DataObject = dw_report.DataObject + "_e"
ELSE
	ddlb_enduser.Enabled = FALSE
	dw_report.DataObject = Left(dw_report.DataObject, (Len(dw_report.DataObject) - 2))
END IF
dw_report.Reset()
dw_report.SetTransObject(SQLCA)
wf_settitle()

end event

type rb_statusall from u_rb within w_report_customer_coils
integer x = 951
integer y = 256
integer width = 176
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "All"
boolean checked = true
end type

event clicked;IF this.Checked THEN
	cbx_1.Enabled = FALSE
	cbx_2.Enabled = FALSE
	cbx_3.Enabled = FALSE
	cbx_4.Enabled = FALSE
	cbx_5.Enabled = FALSE
	cbx_6.Enabled = FALSE
	cbx_7.Enabled = FALSE
	cbx_8.Enabled = FALSE
	cbx_prerecap.Enabled = False //Alex Gerlants. 05/16/2017
	cbx_scrap.Enabled = False //Alex Gerlants. 03/13/2019. Add_Coil_Status_To_Coil_Inv_Report
ELSE
	cbx_1.Enabled = TRUE
	cbx_2.Enabled = TRUE
	cbx_3.Enabled = TRUE
	cbx_4.Enabled = TRUE
	cbx_5.Enabled = TRUE
	cbx_6.Enabled = TRUE
	cbx_7.Enabled = TRUE
	cbx_8.Enabled = TRUE
	cbx_prerecap.Enabled = True //Alex Gerlants. 05/16/2017
	cbx_scrap.Enabled = True //Alex Gerlants. 03/13/2019. Add_Coil_Status_To_Coil_Inv_Report
END IF
wf_settitle()
//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.
RETURN 1

end event

type rb_status from u_rb within w_report_customer_coils
integer x = 951
integer y = 323
integer width = 205
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Select"
end type

event clicked;IF this.Checked THEN
	cbx_1.Enabled = TRUE
	cbx_2.Enabled = TRUE
	cbx_3.Enabled = TRUE
	cbx_4.Enabled = TRUE
	cbx_5.Enabled = TRUE
	cbx_6.Enabled = TRUE
	cbx_7.Enabled = TRUE
	cbx_8.Enabled = TRUE
	cbx_1.Checked = TRUE	
	cbx_prerecap.Enabled = True //Alex Gerlants. 05/16/2017
	cbx_scrap.Enabled = True //Alex Gerlants. 03/13/2019. Add_Coil_Status_To_Coil_Inv_Report
ELSE
	cbx_1.Enabled = FALSE
	cbx_2.Enabled = FALSE
	cbx_3.Enabled = FALSE
	cbx_4.Enabled = FALSE
	cbx_5.Enabled = FALSE
	cbx_6.Enabled = FALSE
	cbx_7.Enabled = FALSE
	cbx_8.Enabled = FALSE
	cbx_prerecap.Enabled = False //Alex Gerlants. 05/16/2017
	cbx_scrap.Enabled = False //Alex Gerlants. 03/13/2019. Add_Coil_Status_To_Coil_Inv_Report
END IF
wf_settitle()	
//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.
RETURN 1

end event

type rb_specsall from u_rb within w_report_customer_coils
integer x = 26
integer y = 256
integer width = 282
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "All"
boolean checked = true
end type

event clicked;IF this.Checked THEN
	em_gauge.Enabled = FALSE
	em_width.Enabled = FALSE
ELSE
	em_gauge.Enabled = TRUE
	em_width.Enabled = TRUE
END IF
wf_settitle()

//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.
RETURN 1
end event

type rb_specs from u_rb within w_report_customer_coils
integer x = 26
integer y = 323
integer width = 208
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Gauge"
end type

event clicked;IF this.Checked THEN
	em_gauge.Enabled = TRUE
	em_width.Enabled = TRUE
ELSE
	em_gauge.Enabled = FALSE
	em_width.Enabled = FALSE
END IF
wf_settitle()

end event

type em_gauge from editmask within w_report_customer_coils
integer x = 238
integer y = 323
integer width = 263
integer height = 67
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
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##.#####"
end type

type st_1 from statictext within w_report_customer_coils
integer x = 508
integer y = 330
integer width = 132
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
string text = "Width"
boolean focusrectangle = false
end type

type em_width from editmask within w_report_customer_coils
integer x = 636
integer y = 323
integer width = 263
integer height = 67
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
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#####.###"
end type

type cb_sort from u_cb within w_report_customer_coils
integer x = 384
integer y = 2131
integer width = 307
integer height = 77
integer taborder = 150
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

type cbx_1 from checkbox within w_report_customer_coils
integer x = 1159
integer y = 317
integer width = 161
integer height = 77
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
string text = "New"
end type

event clicked;wf_settitle()
//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.
RETURN 1

end event

type cbx_2 from checkbox within w_report_customer_coils
integer x = 1349
integer y = 317
integer width = 278
integer height = 77
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
string text = "InProcess"
end type

event clicked;wf_settitle()
//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.
RETURN 1

end event

type cbx_3 from checkbox within w_report_customer_coils
integer x = 1646
integer y = 317
integer width = 278
integer height = 77
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
string text = "Rejected"
end type

event clicked;wf_settitle()
//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.
RETURN 1

end event

type cbx_4 from checkbox within w_report_customer_coils
integer x = 1927
integer y = 317
integer width = 278
integer height = 77
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
string text = "InTransit"
end type

event clicked;wf_settitle()
//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.
RETURN 1

end event

type cbx_5 from checkbox within w_report_customer_coils
integer x = 2198
integer y = 317
integer width = 278
integer height = 77
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
string text = "OnHold"
end type

event clicked;wf_settitle()
//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.
RETURN 1

end event

type cbx_6 from checkbox within w_report_customer_coils
integer x = 2447
integer y = 317
integer width = 230
integer height = 77
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
string text = "Return"
end type

event clicked;wf_settitle()
//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.
RETURN 1

end event

type cbx_7 from checkbox within w_report_customer_coils
integer x = 2673
integer y = 317
integer width = 278
integer height = 77
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
string text = "Rebanded"
end type

event clicked;wf_settitle()
//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.
RETURN 1

end event

type cbx_8 from checkbox within w_report_customer_coils
integer x = 2973
integer y = 317
integer width = 205
integer height = 77
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
string text = "Retry"
end type

event clicked;wf_settitle()
//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.
RETURN 1

end event

type cb_email from u_cb within w_report_customer_coils
integer x = 1123
integer y = 2131
integer width = 307
integer height = 77
integer taborder = 170
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
//if dw_report.SaveAs(ls_file,Excel8!, TRUE) =-1 then
if dw_report.SaveAs(ls_file,HTMLtable!, false) =-1 then
   MessageBox("Email SaveAs", "Error")
	return -1
end if

f_send_email(0,ls_file)

//ls_file = ProfileString(gs_ini_file, "EMAIL","email_out","c:\temp")+'\m_' + ls_today + ls_now + ".xls"
//if dw_report.SaveAs(ls_file,Excel8!, TRUE) =-1 then
////if dw_report.SaveAs(ls_file,HTMLtable!, false) =-1 then
//   MessageBox("Email SaveAs", "Error")
//	return -1
//else
//	messageBox("Email SaveAs", "Success")
//end if
//
RETURN 1
end event

type gb_4 from u_gb within w_report_customer_coils
integer x = 933
integer y = 205
integer width = 2330
integer height = 205
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Status"
end type

