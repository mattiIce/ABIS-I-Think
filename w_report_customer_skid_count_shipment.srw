$PBExportHeader$w_report_customer_skid_count_shipment.srw
forward
global type w_report_customer_skid_count_shipment from w_sheet
end type
type st_customer_list from statictext within w_report_customer_skid_count_shipment
end type
type cb_clearselection from commandbutton within w_report_customer_skid_count_shipment
end type
type dw_customer_short_list_all from datawindow within w_report_customer_skid_count_shipment
end type
type st_2 from statictext within w_report_customer_skid_count_shipment
end type
type st_7 from statictext within w_report_customer_skid_count_shipment
end type
type st_6 from statictext within w_report_customer_skid_count_shipment
end type
type st_5 from statictext within w_report_customer_skid_count_shipment
end type
type st_4 from statictext within w_report_customer_skid_count_shipment
end type
type dw_enduser from datawindow within w_report_customer_skid_count_shipment
end type
type rb_cust from u_rb within w_report_customer_skid_count_shipment
end type
type rb_custall from u_rb within w_report_customer_skid_count_shipment
end type
type dw_enduser_part_num from datawindow within w_report_customer_skid_count_shipment
end type
type dw_name from datawindow within w_report_customer_skid_count_shipment
end type
type st_1 from statictext within w_report_customer_skid_count_shipment
end type
type dw_abis_ini from datawindow within w_report_customer_skid_count_shipment
end type
type sle_email_address from singlelineedit within w_report_customer_skid_count_shipment
end type
type cbx_detail from checkbox within w_report_customer_skid_count_shipment
end type
type dw_endusers_4customer from datawindow within w_report_customer_skid_count_shipment
end type
type st_rowcount from statictext within w_report_customer_skid_count_shipment
end type
type cb_open_in_excel from commandbutton within w_report_customer_skid_count_shipment
end type
type cb_export from u_cb within w_report_customer_skid_count_shipment
end type
type dw_customer from u_dw within w_report_customer_skid_count_shipment
end type
type dw_report from u_dw within w_report_customer_skid_count_shipment
end type
type cb_print from u_cb within w_report_customer_skid_count_shipment
end type
type cb_close from u_cb within w_report_customer_skid_count_shipment
end type
type cb_preview from u_cb within w_report_customer_skid_count_shipment
end type
type st_3 from statictext within w_report_customer_skid_count_shipment
end type
type em_from from editmask within w_report_customer_skid_count_shipment
end type
type em_to from editmask within w_report_customer_skid_count_shipment
end type
type cb_setzoom from u_cb within w_report_customer_skid_count_shipment
end type
type rb_dateall from u_rb within w_report_customer_skid_count_shipment
end type
type cb_sort from u_cb within w_report_customer_skid_count_shipment
end type
type cb_email from u_cb within w_report_customer_skid_count_shipment
end type
type r_1 from rectangle within w_report_customer_skid_count_shipment
end type
type dw_customer_short_list from datawindow within w_report_customer_skid_count_shipment
end type
end forward

global type w_report_customer_skid_count_shipment from w_sheet
string tag = "Shipment Report"
integer x = 424
integer y = 310
integer width = 5047
integer height = 2128
string title = "Skid Count Shipment Report "
boolean maxbox = false
boolean resizable = false
windowstate windowstate = maximized!
long backcolor = 81324524
event type string ue_whoami ( )
st_customer_list st_customer_list
cb_clearselection cb_clearselection
dw_customer_short_list_all dw_customer_short_list_all
st_2 st_2
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
dw_enduser dw_enduser
rb_cust rb_cust
rb_custall rb_custall
dw_enduser_part_num dw_enduser_part_num
dw_name dw_name
st_1 st_1
dw_abis_ini dw_abis_ini
sle_email_address sle_email_address
cbx_detail cbx_detail
dw_endusers_4customer dw_endusers_4customer
st_rowcount st_rowcount
cb_open_in_excel cb_open_in_excel
cb_export cb_export
dw_customer dw_customer
dw_report dw_report
cb_print cb_print
cb_close cb_close
cb_preview cb_preview
st_3 st_3
em_from em_from
em_to em_to
cb_setzoom cb_setzoom
rb_dateall rb_dateall
cb_sort cb_sort
cb_email cb_email
r_1 r_1
dw_customer_short_list dw_customer_short_list
end type
global w_report_customer_skid_count_shipment w_report_customer_skid_count_shipment

type prototypes

end prototypes

type variables
//Report header variables
String	is_date_from_to, is_customer, is_enduser //Alex Gerlants. 05/03/2016

Boolean	ib_debugviewer = False
n_smtp 	in_smtp

//Populated in Open event for this window
String	is_from_email //Sender email address
String	is_from_name //Sender name
String	is_server //SMTP server IP address
Integer	ii_port //SMTP port
String	is_send_email //Recipient email address
String	is_send_name //Recipient name
String	is_logfile //Log file where we record SMTP email messages if email fails
String	is_subject //Email subject line
String	is_email_folder //Windows folder where the files to attach to email are
String	is_file_name_2email[] //Alex Gerlants. Customer_Shipment_Rpt_All_Together. Changed to array 

//String	is_work_folder, is_archive_folder, is_combine_bat_file, is_taskkill_bat_file

String	is_customer_list, is_customer_name_list, is_sql_enduser_orig, is_sql_enduser_part_orig //Alex Gerlants. Customer_Shipment_Rpt_All_Together
String	is_sql_dw_report_orig //Alex Gerlants. Customer_Shipment_Rpt_All_Together
String	is_customer_head_t, is_shipto_head_t, is_enduser_part_head_t, is_date_range_head_t //Alex Gerlants. Customer_Shipment_Rpt_All_Together

Long		il_customer_id[]
String	is_customer_short_name[], is_taskkill_bat_file
//Boolean	ib_called_from_email_button //Alex Gerlants. Customer_Shipment_Rpt_All_Together
end variables

forward prototypes
public subroutine wf_settitle ()
public subroutine wf_setfilter ()
public subroutine wf_shipment ()
public subroutine exporttoexcel (datawindow adw_dw, long al_rows)
public function any getdata (datawindow adw_dw, long al_row, string as_column)
public function string inttocolumn (integer ai_col)
public subroutine getcolumns (datawindow adw_dw, ref string as_columns[])
public function long wf_get_enduser_id (string as_customer_short_name)
public function string wf_desadv_required (n_tr_abc01 at_tran, long al_packing_list)
public function string wf_shipment_type (n_tr_abc01 at_tran, long al_packing_list)
public function boolean wf_send_smtp_email (string as_body, string as_attached_file_name[])
public function integer wf_insert_update_abis_ini ()
public subroutine wf_get_customer_names (string as_customer_id_list, ref string as_customer_name_list)
public subroutine wf_retrieve_ldwc_4all_customers ()
public subroutine exporttoexcel_detail (datawindow adw_dw, long al_rows)
public function integer wf_export_2excel ()
public subroutine wf_open_in_excel ()
public function boolean wf_email (string as_file_name_2email[])
public function integer wf_customer_list (long al_customer_id, boolean ab_row_selected)
public subroutine wf_reset_report ()
public subroutine wf_delete_emailed_files (string as_file_name_2email[])
end prototypes

event type string ue_whoami();RETURN "w_report_customer_skid_count_shipment"
end event

public subroutine wf_settitle ();String ls_modstring,ls_s
String	ls_date_from, ls_date_to
String	ls_text
long ll_c


IF rb_custall.Checked THEN
	ls_s = "All customers "
ELSE
	ll_c = dw_customer.GetRow()
	ls_s = dw_customer.GetItemString(ll_c, "customer_short_name")
	
//	ls_text = ddlb_customer.Text(0)
	
	ls_s = Trim(ls_s)
	ls_s = "Customer: " + ls_s
END IF

ls_modstring = "customer_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 

is_customer = ls_s //Alex Gerlants. 05/03/2016

////Alex Gerlants. 09/12/2016. Begin
//IF rb_enduserall.Checked THEN
//	ls_s = "All End Users"
//ELSE
//	ll_c = dw_allcust.GetRow()
//	ls_s = dw_allcust.GetItemString(ll_c, "customer_short_name")
//	ls_s = Trim(ls_s)
//	ls_s = "End User: " + ls_s
//END IF
//
//ls_modstring = "enduser_t.Text = ~"" + ls_s + "~""
//dw_report.Modify(ls_modstring)
//
//is_enduser = ls_s
////Alex Gerlants. 09/12/2016. End


ls_s = "(" +em_from.Text + "-" + em_to.Text+")"
//ls_modstring = "date_t.Text = ~"" + ls_s + "~""
//dw_report.Modify(ls_modstring) 
//
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

public subroutine wf_shipment ();//Long ll_cust_row, ll_cust, ll_enduser, ll_rows
//Date ld_s, ld_e
//DateTime	ldt_from, ldt_to //Alex Gerlants. 08/17/2016
//
//dw_report.reset()
//IF rb_dateall.Checked THEN
//	ld_s = Date("00/00/0000")
//	ld_e = Date("12/31/9999")
//ELSE
//	ld_s = Date(em_from.Text)
//	ld_e = Date(em_to.Text)
//END IF
//
//f_date_2datetime_from_to(ld_s, ld_e, ldt_from, ldt_to) //Alex Gerlants. 08/17/2016. Bug fix
//
////Alex Gerlants. 08/30/2016. Begin
////Putting everything in one place...more reliable...
//If rb_custall.Checked And rb_enduserall.Checked Then //All customers and all end users
//
//	dw_report.DataObject = "d_report_skid_count_shipment_a"
//	
//	If cbx_detail.Checked Then dw_report.DataObject = dw_report.DataObject + "_detail" //Alex Gerlants. 05/23/2017
//	
//	dw_report.SetTransObject(sqlca)
//	ll_rows = dw_report.Retrieve(ldt_from, ldt_to)
//	
//ElseIf rb_custall.Checked And rb_enduser.Checked Then //All customers and one selected end user
//	
//	dw_report.DataObject = "d_report_skid_count_shipment_c"
//	
//	If cbx_detail.Checked Then dw_report.DataObject = dw_report.DataObject + "_detail" //Alex Gerlants. 05/23/2017
//	
//	ll_cust_row = dw_allcust.GetRow()
//   ll_enduser = dw_allcust.GetItemNumber(ll_cust_row, "customer_id")
//	
//	dw_report.SetTransObject(sqlca)
//	ll_rows = dw_report.Retrieve(ldt_from, ldt_to, ll_enduser)
//	
//ElseIf rb_cust.Checked And rb_enduserall.Checked Then //One selected customer and all end users
//	
//	dw_report.DataObject = "d_report_skid_count_shipment"
//	
//	If cbx_detail.Checked Then dw_report.DataObject = dw_report.DataObject + "_detail" //Alex Gerlants. 05/23/2017
//	
//	ll_cust_row = dw_customer.GetRow()
//	ll_cust = dw_customer.GetItemNumber(ll_cust_row, "customer_id")
//	
//	dw_report.SetTransObject(sqlca)
//	ll_rows = dw_report.Retrieve(ll_cust, ldt_from, ldt_to)
//	
//ElseIf rb_cust.Checked And rb_enduser.Checked Then //One selected customer and one selected end user
//	
//	dw_report.DataObject = "d_report_skid_count_shipment_e"
//	
//	If cbx_detail.Checked Then dw_report.DataObject = dw_report.DataObject + "_detail" //Alex Gerlants. 05/23/2017
//	
//	ll_cust_row = dw_customer.GetRow()
//	ll_cust = dw_customer.GetItemNumber(ll_cust_row, "customer_id")
//	
//	ll_cust_row = dw_allcust.GetRow()
//	ll_enduser = dw_allcust.GetItemNumber(ll_cust_row, "customer_id")
//	
//	dw_report.SetTransObject(sqlca)
//	ll_rows = dw_report.Retrieve(ll_cust, ldt_from, ldt_to, ll_enduser)
//	
//End If
////Alex Gerlants. 08/30/2016. End
//
////Alex Gerlants. 08/30/2016. Comment out begin
////IF rb_enduser.Checked THEN 
////	ll_cust_row = dw_allcust.GetRow()
////   ll_enduser = dw_allcust.GetItemNumber(ll_cust_row, "customer_id")
////	IF rb_cust.Checked THEN
////   	dw_report.Retrieve(ll_cust, ld_s, ld_e, ll_enduser)
////	ELSE
////   	dw_report.Retrieve(ld_s, ld_e, ll_enduser)
////	END IF		
////ELSE
////	IF rb_cust.Checked THEN
////		dw_report.retrieve(ll_cust, ld_s, ld_e)
////	ELSE
////		dw_report.retrieve(ld_s, ld_e)
////	END IF
////END IF
////Alex Gerlants. 08/30/2016. Comment out end
//
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
String		ls_range, ls_total_net_weight, ls_total_gross_weight, ls_total_skids
Boolean		lb_rtn, lb_directoryexists

String 		ls_file, ls_today, ls_now, ls_folder, ls_now_filecopy, ls_file_filecopy
Date 			ld_today
Time 			ld_now
Integer		li_answer

ll_report_rows = al_rows
ll_report_rows = adw_dw.RowCount()

If ll_report_rows > 0 Then
	ls_total_net_weight = String(adw_dw.Object.compute_2[1])
	ls_total_gross_weight = String(adw_dw.Object.compute_3[1])
	ls_total_skids = String(adw_dw.Object.compute_6[1])
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
lole_OLE.cells[1,9] = "Number Of Skids"


//Insert Lines for Header & Miscellaneous Details (5 lines above columnar data)
lole_Sheet.Range("A1:H5").Select
lole_Sheet.Application.Selection.EntireRow.Insert 

lole_OLE.cells[1,3] = "Customer Skid Count Shipment Report"
lole_Sheet.Range("C1:C1").Select
lole_OLE.Selection.Font.Bold = True
lole_OLE.Selection.Font.Size = 24 //Change font size
lole_OLE.Selection.Font.Underline = True

lole_OLE.cells[1,9] = String(Today(), "mm/dd/yyyy")
lole_Sheet.Range("K1:K1").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[2,4] = is_customer_head_t
//lole_Sheet.Range("D2:D2").Select
//lole_OLE.Selection.Font.Size = 16 //Change font size
//lole_OLE.Selection.Font.Bold = True
//lole_OLE.Selection.Font.Italic = True

lole_OLE.cells[3,4] = is_shipto_head_t
//lole_Sheet.Range("D3:D3").Select
//lole_OLE.Selection.Font.Size = 16 //Change font size
//lole_OLE.Selection.Font.Bold = True
//lole_OLE.Selection.Font.Italic = True

lole_OLE.cells[4,4] = is_date_range_head_t
//lole_Sheet.Range("D3:D3").Select
//lole_OLE.Selection.Font.Size = 16 //Change font size
//lole_OLE.Selection.Font.Bold = True
//lole_OLE.Selection.Font.Italic = True

//lole_OLE.cells[4,4] = is_date_from_to
//lole_Sheet.Range("D4:D4").Select
//lole_OLE.Selection.Font.Bold = True

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

//---
lole_OLE.cells[ll_report_rows + 7,9] = "Total Skids"
ls_range = "I" + String(ll_report_rows + 7) + ":" + "I" + String(ll_report_rows + 7)
lole_Sheet.Range(ls_range).Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[ll_report_rows + 8,9] = String(ls_total_skids)
ls_range = "I" + String(ll_report_rows + 8) + ":" + "I" + String(ll_report_rows + 8)
lole_Sheet.Range(ls_range).Select
lole_OLE.Selection.Font.Bold = True
//---

SetPointer(HourGlass!)
ld_today = Today()
ld_now = Now()
ls_today = String(ld_today,"yymmdd")
ls_now = String(ld_now,"hhmmss")

//Delete extra columns	
lole_Sheet.columns("J:CC").Delete

//Justify
//lole_OLE.Selection.HorizontalAlignment = -4108 //Center
//lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
//lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

lole_Sheet.Range("A4:F" + String(ll_report_rows + 7)).Select
lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify

lole_Sheet.Range("G4:H" + String(ll_report_rows + 7)).Select
lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

lole_Sheet.Range("I4:M" + String(ll_report_rows + 7)).Select
lole_OLE.Selection.HorizontalAlignment = -4152 //Right

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
lole_OLE.Selection.ColumnWidth = 14.33

//---

ls_folder = ProfileString(gs_ini_file, "EMAIL","email_out","c:\temp\")

If Right(ls_folder, 1) <> "\" Then ls_folder = ls_folder + "\"
ls_file = ls_folder + "Customer Shipment Report" + "_" + ls_today + "_" + ls_now + ".xls"

//Check if ls_folder exists.
lb_directoryexists = DirectoryExists(ls_folder)

If Not lb_directoryexists Then //Folder ls_folder doesn't exist
	CreateDirectory(ls_folder) //Create ls_folder
End If

lole_sheet.SaveAs(ls_file, Excel8!)

lole_OLE.DisconnectObject()
If IsValid(lole_OLE) Then Destroy lole_OLE
//Alex Gerlants. 05/02/2016. End

//Alex Gerlants. 02/19/2019. Fix. Commented out the code below

////Alex Gerlants. Customer_Shipment_Rpt_All_Together. Begin
//Run("C:\abis\killexcel.bat", Minimized!) //It will kill the running excel.exe tasks. They are locking ls_file, and it cannot be attached to email.
//is_file_name_2email[UpperBound(is_file_name_2email[]) + 1] = ls_file
////Alex Gerlants. Customer_Shipment_Rpt_All_Together. End

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

public function boolean wf_send_smtp_email (string as_body, string as_attached_file_name[]);//Alex Gerlants. 09/24/2017. Begin
/*
Function:	wf_send_smtp_email
Returns:		boolean
Arguments:	value	string	as_body						<== Email body text
				value	string	as_attached_file_name[]	<== Files to attach to email.
*/

UInt 		lui_port
Boolean	lb_Return
Integer	li_i, li_number_of_files
String	ls_filename, ls_send_email
Pointer 	oldpointer

oldpointer = SetPointer(HourGlass!)

lui_port = Long(ii_port)

// *** Set email properties *********************
in_smtp.of_ResetAll()
in_smtp.of_SetPort(lui_port)
in_smtp.of_SetServer(is_server)
in_smtp.of_SetLogFile(True, is_logfile)
in_smtp.of_SetDebugViewer(ib_debugviewer)
in_smtp.of_SetSubject(is_subject)
in_smtp.of_SetBody(as_body, False)
in_smtp.of_SetFrom(is_from_email, is_from_name)

ls_send_email = sle_email_address.Text
in_smtp.of_AddAddress(ls_send_email, is_send_name)

//// *** set Userid/Password if required **********
//If of_getreg("Auth", "N") = "Y" Then
//	ls_uid = of_getreg("Userid", "")
//	ls_pwd = of_getreg("Password", "")
//	in_smtp.of_SetLogin(ls_uid, ls_pwd)
//End If

// *** Add any attachments **********************
li_number_of_files = UpperBound(as_attached_file_name[])

For li_i = 1 To li_number_of_files
	ls_filename = as_attached_file_name[li_i]
	in_smtp.of_AddAttachment(ls_filename)
Next

// *** send the message *************************
lb_Return = in_smtp.of_SendMail()

SetPointer(oldpointer)

If lb_Return Then
	MessageBox("SendMail", "Mail successfully sent!")
Else
	MessageBox("SendMail Error", in_smtp.of_GetLastError())
End If

Return lb_Return
//Alex Gerlants. 09/24/2017. End
end function

public function integer wf_insert_update_abis_ini ();//Alex Gerlants. 05/24/2017. Begin
/*
Function:	wf_insert_update_abis_ini
Returns:		integer
Arguments:	none
*/

Integer	li_rtn = 1
Long		ll_inserted_row
String	ls_null

SetNull(ls_null)

ll_inserted_row = dw_abis_ini.InsertRow(0)

If ll_inserted_row > 0 Then
	//is_server = "192.168.3.67"
	dw_abis_ini.Object.process[ll_inserted_row] = 'customer_shipment_skid_report'
	dw_abis_ini.Object.section[ll_inserted_row] = 'smtp_email'
	
	dw_abis_ini.Object.key[ll_inserted_row] = "server"
	dw_abis_ini.Object.value[ll_inserted_row] = is_server
	dw_abis_ini.Object.description[ll_inserted_row] = "SMTP server IP address"
End If

ll_inserted_row = dw_abis_ini.InsertRow(0)

If ll_inserted_row > 0 Then
	//ii_port = 25
	dw_abis_ini.Object.process[ll_inserted_row] = 'customer_shipment_skid_report'
	dw_abis_ini.Object.section[ll_inserted_row] = 'smtp_email'
	
	dw_abis_ini.Object.key[ll_inserted_row] = "port"
	dw_abis_ini.Object.value[ll_inserted_row] = String(ii_port)
	dw_abis_ini.Object.description[ll_inserted_row] = "SMTP port"
End If

//ll_inserted_row = dw_abis_ini.InsertRow(0)
//
//If ll_inserted_row > 0 Then
//	//ls_send_email = "rsedam@albl.com"
//	//sle_email_address.Text = ls_send_email
//	dw_abis_ini.Object.process[ll_inserted_row] = 'customer_shipment_skid_report'
//	dw_abis_ini.Object.section[ll_inserted_row] = 'smtp_email'
//	
//	dw_abis_ini.Object.key[ll_inserted_row] = "useremail"
//	dw_abis_ini.Object.value[ll_inserted_row] = is_send_email
//	dw_abis_ini.Object.description[ll_inserted_row] = "User Email address to send to"
//End If

ll_inserted_row = dw_abis_ini.InsertRow(0)

If ll_inserted_row > 0 Then
	//is_send_name = "User"
	dw_abis_ini.Object.process[ll_inserted_row] = 'customer_shipment_skid_report'
	dw_abis_ini.Object.section[ll_inserted_row] = 'smtp_email'
	
	dw_abis_ini.Object.key[ll_inserted_row] = "send_name"
	dw_abis_ini.Object.value[ll_inserted_row] = is_send_name
	dw_abis_ini.Object.description[ll_inserted_row] = "Name of SMTP email recipient"
End If

ll_inserted_row = dw_abis_ini.InsertRow(0)

If ll_inserted_row > 0 Then
	//is_logfile = "P:\Email_Errors_LogFiles\SMTP_Email_LogFile.txt"
	dw_abis_ini.Object.process[ll_inserted_row] = 'customer_shipment_skid_report'
	dw_abis_ini.Object.section[ll_inserted_row] = 'smtp_email'
	
	dw_abis_ini.Object.key[ll_inserted_row] = "logfile"
	dw_abis_ini.Object.value[ll_inserted_row] = is_logfile
	dw_abis_ini.Object.description[ll_inserted_row] = "Log file where we record SMTP email messages if email fails"
End If

ll_inserted_row = dw_abis_ini.InsertRow(0)

If ll_inserted_row > 0 Then
	//is_subject = "Inventory Reports"
	dw_abis_ini.Object.process[ll_inserted_row] = 'customer_shipment_skid_report'
	dw_abis_ini.Object.section[ll_inserted_row] = 'smtp_email'
	
	dw_abis_ini.Object.key[ll_inserted_row] = "subject"
	dw_abis_ini.Object.value[ll_inserted_row] = "Customer Shipment Skid Report"
	dw_abis_ini.Object.description[ll_inserted_row] = "SMTP email subject line"
End If

ll_inserted_row = dw_abis_ini.InsertRow(0)

If ll_inserted_row > 0 Then
	//is_email_folder = "C:\temp\email\"
	dw_abis_ini.Object.process[ll_inserted_row] = 'customer_shipment_skid_report'
	dw_abis_ini.Object.section[ll_inserted_row] = 'smtp_email'
	
	dw_abis_ini.Object.key[ll_inserted_row] = "email_folder"
	dw_abis_ini.Object.value[ll_inserted_row] = is_email_folder
	dw_abis_ini.Object.description[ll_inserted_row] = "Windows folder where the files to attach to email are"
End If

li_rtn = dw_abis_ini.Update()

If li_rtn = 1 Then //OK
	commit using sqlca;
Else //DB error
	rollback using sqlca;
End If

Return li_rtn
//Alex Gerlants. 05/24/2017. End
end function

public subroutine wf_get_customer_names (string as_customer_id_list, ref string as_customer_name_list);//Alex Gerlants. Customer_Shipment_Rpt_All_Together. Begin
/*
Function:	wf_get_customer_names
Returns:		none
Arguments:	value			string	as_customer_id_list
				reference	string	as_customer_name_list
*/

Long		ll_pos_comma_prev, ll_pos_comma, ll_start, ll_found_row
String	ls_find_string, ls_customer_id_temp, ls_customer_short_name

If as_customer_id_list = "" Then
	as_customer_name_list = ""
	Return
End If

as_customer_name_list = ""
ll_start = 1

ll_pos_comma = Pos(as_customer_id_list, ",", ll_start)

If ll_pos_comma > 0 Then
	Do While ll_pos_comma > 0
		If ll_start > 1 Then //Not the first iteration
			ls_customer_id_temp = Mid(as_customer_id_list, ll_pos_comma_prev + 1, ll_pos_comma - ll_pos_comma_prev - 1)
		Else //First iteration
			ls_customer_id_temp = Left(as_customer_id_list, ll_pos_comma - 1)
		End If
		
		If IsNumber(ls_customer_id_temp) Then
			ls_find_string = "customer_id = " + ls_customer_id_temp
			ll_found_row = dw_customer_short_list.Find(ls_find_string, 1, dw_customer_short_list.RowCount())
			
			If ll_found_row > 0 Then
				ls_customer_short_name = Trim(dw_customer_short_list.Object.customer_short_name[ll_found_row])
				as_customer_name_list = as_customer_name_list + ls_customer_short_name + ", "
			End If
		End If
		
		ll_pos_comma_prev = ll_pos_comma
		ll_start = ll_pos_comma + 1
		ll_pos_comma = Pos(as_customer_id_list, ",", ll_start)
	Loop
	
	//Take care of the last customer_id in as_customer_id_list. At this point, ll_pos_comma = 0
	ls_customer_id_temp = Right(as_customer_id_list, Len(as_customer_id_list) - ll_pos_comma_prev)
	
	If IsNumber(ls_customer_id_temp) Then
		ls_find_string = "customer_id = " + ls_customer_id_temp
		ll_found_row = dw_customer_short_list.Find(ls_find_string, 1, dw_customer_short_list.RowCount())
		
		If ll_found_row > 0 Then
			ls_customer_short_name = Trim(dw_customer_short_list.Object.customer_short_name[ll_found_row])
			as_customer_name_list = as_customer_name_list + ls_customer_short_name
		End If
	End If
	
Else //as_customer_id_list has only one customer_id
	ls_customer_id_temp = as_customer_id_list
	
	If IsNumber(ls_customer_id_temp) Then
		ls_find_string = "customer_id = " + ls_customer_id_temp
		ll_found_row = dw_customer_short_list.Find(ls_find_string, 1, dw_customer_short_list.RowCount())
		
		If ll_found_row > 0 Then
			ls_customer_short_name = Trim(dw_customer_short_list.Object.customer_short_name[ll_found_row])
			as_customer_name_list = ls_customer_short_name
		End If	
	End If
End If
//Alex Gerlants. Customer_Shipment_Rpt_All_Together. End
end subroutine

public subroutine wf_retrieve_ldwc_4all_customers ();//****************************************************************************************************************************//
//******************************************** This function is not used *****************************************************//
//****************************************************************************************************************************//


//Alex Gerlants. Customer_Shipment_Rpt_All_Together. Begin
/*
Function:	wf_retrieve_ldwc_4all_customers
Returns:		none
Arguments:	none
*/
Long					ll_rows, ll_row_inserted
Integer				li_rtn
String				ls_sql_new
DataWindowChild	ldwc


//Retrieve Ship-To list
li_rtn = dw_enduser.GetChild("customer_short_name", ldwc)

If li_rtn = 1 Then //OK
	ls_sql_new = is_sql_enduser_orig + " order by ltrim(rtrim(customer.customer_short_name))"
	li_rtn = ldwc.SetSqlSelect(ls_sql_new)
	
	If li_rtn = 1 Then //OK
		ldwc.SetTransObject(sqlca)
		ll_rows = ldwc.Retrieve()
		
		If ll_rows > 0 Then
			ll_row_inserted = ldwc.InsertRow(1)
			
			If ll_row_inserted > 0 Then
				ldwc.SetItem(ll_row_inserted, "customer_short_name", "ALL")
				dw_enduser.Object.customer_short_name[1] = "ALL"
			End If
		End If
	End If
End If

//Retrieve End User Part list
li_rtn = dw_enduser_part_num.GetChild("enduser_part_num", ldwc)

If li_rtn = 1 Then //OK
	ls_sql_new = is_sql_enduser_part_orig + " order by ltrim(rtrim(enduser_part_num))"
	li_rtn = ldwc.SetSqlSelect(ls_sql_new)
	
	If li_rtn = 1 Then //OK
		ldwc.SetTransObject(sqlca)
		ll_rows = ldwc.Retrieve()
		
		If ll_rows > 0 Then
			ll_row_inserted = ldwc.InsertRow(1)
			
			If ll_row_inserted > 0 Then
				ldwc.SetItem(ll_row_inserted, "enduser_part_num", "ALL")
				dw_enduser_part_num.Object.enduser_part_num[1] = "ALL"
			End If
		End If
	End If
End If

//Alex Gerlants. Customer_Shipment_Rpt_All_Together. End
end subroutine

public subroutine exporttoexcel_detail (datawindow adw_dw, long al_rows);//Alex Gerlants. 05/02/2016. Begin
/*
Function:	exporttoexcel_detail
Returns:		none
Arguments:	value		datawindow	adw_dw
				value		long			al_rows	

*/

// Export the data to Excel
OleObject 	lole_OLE, lole_Sheet
String 		ls_Columns[]
Long 			ll_report_rows, ll_Row, ll_Col, ll_Cols
String		ls_range
String		ls_total_gross_weight, ls_total_skids
String		ls_total_pieces, ls_total_net_wt, ls_total_tare_wt, ls_total_theo_wt
Boolean		lb_rtn, lb_directoryexists

String 		ls_file, ls_today, ls_now, ls_folder, ls_file_filecopy, ls_now_filecopy
Date 			ld_today
Time 			ld_now
Integer		li_answer
Long			ll_i

ll_report_rows = al_rows
ll_report_rows = adw_dw.RowCount()

If ll_report_rows > 0 Then
	ls_total_pieces = String(adw_dw.Object.compute_7[1])
	ls_total_net_wt = String(adw_dw.Object.compute_3[1])
	ls_total_tare_wt = String(adw_dw.Object.compute_5[1])
	ls_total_theo_wt = String(adw_dw.Object.compute_6[1])
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
lole_OLE.cells[1,2] = "Bill Of Lading"
lole_OLE.cells[1,3] = "Enduser Part Num"
lole_OLE.cells[1,4] = "Sheet Skid Num"
lole_OLE.cells[1,5] = "Skid Pieces"
lole_OLE.cells[1,6] = "Sheet Net Wt"
lole_OLE.cells[1,7] = "Sheet Tare Wt"
lole_OLE.cells[1,8] = "Sheet Theo Wt"
lole_OLE.cells[1,9] = "Destination Name"
lole_OLE.cells[1,10] = "Shipment Date"
lole_OLE.cells[1,11] = "Customer Name"
lole_OLE.cells[1,12] = "Enduser Name"


//Insert Lines for Header & Miscellaneous Details (5 lines above columnar data)
lole_Sheet.Range("A1:H5").Select
lole_Sheet.Application.Selection.EntireRow.Insert 

lole_OLE.cells[1,3] = "Customer Skid Count Shipment Report Detail"
lole_Sheet.Range("C1:C1").Select
lole_OLE.Selection.Font.Bold = True
lole_OLE.Selection.Font.Size = 24 //Change font size
lole_OLE.Selection.Font.Underline = True

lole_OLE.cells[1,12] = String(Today(), "mm/dd/yyyy")
lole_Sheet.Range("L1:L1").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[2,4] = is_customer_head_t
//lole_Sheet.Range("D2:D2").Select
//lole_OLE.Selection.Font.Size = 16 //Change font size
//lole_OLE.Selection.Font.Bold = True
//lole_OLE.Selection.Font.Italic = True

lole_OLE.cells[3,4] = is_shipto_head_t
//lole_Sheet.Range("D3:D3").Select
//lole_OLE.Selection.Font.Size = 16 //Change font size
//lole_OLE.Selection.Font.Bold = True
//lole_OLE.Selection.Font.Italic = True

lole_OLE.cells[4,4] = is_enduser_part_head_t
//lole_Sheet.Range("D3:D3").Select
//lole_OLE.Selection.Font.Size = 16 //Change font size
//lole_OLE.Selection.Font.Bold = True
//lole_OLE.Selection.Font.Italic = True

lole_OLE.cells[5,4] = is_date_range_head_t
//lole_Sheet.Range("D3:D3").Select
//lole_OLE.Selection.Font.Size = 16 //Change font size
//lole_OLE.Selection.Font.Bold = True
//lole_OLE.Selection.Font.Italic = True

//lole_OLE.cells[4,4] = is_date_from_to
//lole_Sheet.Range("D4:D4").Select
//lole_OLE.Selection.Font.Bold = True

//---

//Insert 2 lines for totals (below columnar data)
ls_range = "A" + String(ll_report_rows + 7) + ":" + "H" + String(ll_report_rows + 7)
lole_Sheet.Range(ls_range).Select
lole_Sheet.Application.Selection.EntireRow.Insert

lole_OLE.cells[ll_report_rows + 7,5] = "Total Pieces"
ls_range = "E" + String(ll_report_rows + 7) + ":" + "E" + String(ll_report_rows + 7)
lole_Sheet.Range(ls_range).Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[ll_report_rows + 8,5] = String(ls_total_pieces)
ls_range = "E" + String(ll_report_rows + 8) + ":" + "E" + String(ll_report_rows + 8)
lole_Sheet.Range(ls_range).Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[ll_report_rows + 7,6] = "Total Net Wt"
ls_range = "F" + String(ll_report_rows + 7) + ":" + "F" + String(ll_report_rows + 7)
lole_Sheet.Range(ls_range).Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[ll_report_rows + 8,6] = String(ls_total_net_wt)
ls_range = "F" + String(ll_report_rows + 8) + ":" + "F" + String(ll_report_rows + 8)
lole_Sheet.Range(ls_range).Select
lole_OLE.Selection.Font.Bold = True

//---
lole_OLE.cells[ll_report_rows + 7,7] = "Total Tare Wt"
ls_range = "G" + String(ll_report_rows + 7) + ":" + "G" + String(ll_report_rows + 7)
lole_Sheet.Range(ls_range).Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[ll_report_rows + 8,7] = String(ls_total_tare_wt)
ls_range = "G" + String(ll_report_rows + 8) + ":" + "G" + String(ll_report_rows + 8)
lole_Sheet.Range(ls_range).Select
lole_OLE.Selection.Font.Bold = True

//---
lole_OLE.cells[ll_report_rows + 7,8] = "Total Theo Wt"
ls_range = "H" + String(ll_report_rows + 7) + ":" + "H" + String(ll_report_rows + 7)
lole_Sheet.Range(ls_range).Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[ll_report_rows + 8,8] = String(ls_total_theo_wt)
ls_range = "H" + String(ll_report_rows + 8) + ":" + "H" + String(ll_report_rows + 8)
lole_Sheet.Range(ls_range).Select
lole_OLE.Selection.Font.Bold = True
//---

SetPointer(HourGlass!)
ld_today = Today()
ld_now = Now()
ls_today = String(ld_today,"mmddyyyy")
ls_now = String(ld_now,"hhmmss")

////Delete extra columns	
//lole_Sheet.columns("J:CC").Delete

//Justify
//lole_OLE.Selection.HorizontalAlignment = -4108 //Center
//lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
//lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

lole_Sheet.Range("A4:D" + String(ll_report_rows + 7)).Select
lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify

lole_Sheet.Range("E4:H" + String(ll_report_rows + 7)).Select
lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

lole_Sheet.Range("I4:L" + String(ll_report_rows + 7)).Select
lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify

////Change date format for a column
//lole_Sheet.Range("D4:D" + String(ll_report_rows + 7)).Select
//lole_OLE.Selection.NumberFormat = "mm/dd/yyyy"

//Underline column headers
lole_Sheet.Range("A6:M6").Select
lole_OLE.Selection.Font.Underline = True

////Draw border around column headers
//lole_OLE.Application.range ("A4:J4").borders(4).LineStyle = 1

//Increase column width
lole_Sheet.Range("H4:L4").Select
lole_OLE.Selection.ColumnWidth = 20.33

//---

ls_folder = ProfileString(gs_ini_file, "EMAIL","email_out","c:\temp\")

If Right(ls_folder, 1) <> "\" Then ls_folder = ls_folder + "\"
ls_file = ls_folder + "Customer Shipment Report Detail" + "_" + ls_today + "_" + ls_now + ".xls"

//Check if ls_folder exists.
lb_directoryexists = DirectoryExists(ls_folder)

If Not lb_directoryexists Then //Folder ls_folder doesn't exist
	CreateDirectory(ls_folder) //Create ls_folder
End If

lole_sheet.SaveAs(ls_file, Excel8!)

//Alex Gerlants. 02/19/2019. Fix begin
//Open the worksheet for user to veiw and save
li_answer = MessageBox("Open Worksheet?", "Would you like to open worksheet " + ls_file + "?", Question!, YesNo!, 1)

If li_answer = 1 Then //Yes
	lole_OLE.Application.Visible = True
Else
	lole_OLE.Application.Visible = False
End If
//Alex Gerlants. 02/19/2019. Fix End

lole_OLE.DisconnectObject()
DESTROY lole_OLE
//Alex Gerlants. 05/02/2016. End

//Alex Gerlants. 02/19/2019. Fix. Commented out the code below

////Alex Gerlants. Customer_Shipment_Rpt_All_Together. Begin
//Run("C:\abis\killexcel.bat", Minimized!) //It will kill the running excel.exe tasks. They are locking ls_file, and it cannot be attached to email.
//is_file_name_2email[UpperBound(is_file_name_2email[]) + 1] = ls_file
////Alex Gerlants. Customer_Shipment_Rpt_All_Together. End


end subroutine

public function integer wf_export_2excel ();//Alex Gerlants. Customer_Shipment_Rpt_All_Together. Begin
/*
Function:	wf_export_2excel
Returns:		integer
Arguments:	none
*/

SetPointer(HourGlass!)
String 	ls_file, ls_today, ls_now, ls_address_2email
String	ls_customer_short_name, ls_empty[]
Integer	li_answer
Date 		ld_today
Time 		ld_now
Long		ll_row

String	ls_notetext, ls_attached_file_name[]
Boolean	lb_rtn

If dw_report.RowCount() <= 0 Then
	MessageBox("Nothing to export", "Please retrieve report first", StopSign!)
	Return -1
End If

If UpperBound(is_customer_short_name[]) = 1 Then
	ls_customer_short_name = is_customer_short_name[1]
Else
	ls_customer_short_name = "Multiple Customers"
End If

ld_today = Today()
ld_now = Now()
ls_today = String(ld_today,"mmddyyyy")
ls_now = String(ld_now,"hhmmss")

If cbx_detail.Checked Then
	ls_file = ProfileString(gs_ini_file, "EMAIL","email_out","c:\temp") + '\Customer Shipment Report_Detail_' + ls_customer_short_name + "_" + ls_today + "_" + ls_now + ".xls"
Else
	ls_file = ProfileString(gs_ini_file, "EMAIL","email_out","c:\temp") + '\Customer Shipment Report_' + ls_customer_short_name + "_" + ls_today + "_" + ls_now + ".xls"
End If

If dw_report.SaveAs(ls_file, Excel5!, True) = -1 Then
   MessageBox("Data SaveAs", "Error")
	Return -1
Else
	is_file_name_2email[UpperBound(is_file_name_2email[]) + 1] = ls_file
End If

Return 1
//Alex Gerlants. Customer_Shipment_Rpt_All_Together. End
end function

public subroutine wf_open_in_excel ();//Alex Gerlants. Customer_Shipment_Rpt_All_Together. Begin
/*
Function:	wf_open_in_excel
Returns:		none
Arguments:	wf_open_in_excel
*/

If dw_report.DataObject = "d_report_skid_count_shipment_all" Then
	ExportToExcel( dw_report, dw_report.RowCount() )
ElseIf dw_report.DataObject = "d_report_skid_count_shipment_all_detail" Then
	ExportToExcel_detail( dw_report, dw_report.RowCount() )
End If
//Alex Gerlants. Customer_Shipment_Rpt_All_Together. End
end subroutine

public function boolean wf_email (string as_file_name_2email[]);//Alex Gerlants. Customer_Shipment_Rpt_All_Together. Begin
/*
Function:	wf_email
Returns:		boolean
Argumnts:	value	string	as_file_name_2email[]
*/

Boolean	lb_rtn
Long		ll_row
String	ls_customer_short_name,ls_attached_file_name[], ls_notetext, ls_empty[]

If UpperBound(is_customer_short_name[]) = 1 Then
	ls_customer_short_name = is_customer_short_name[1]
Else
	ls_customer_short_name = "Multiple Customers"
End If

If cbx_detail.Checked Then
	ls_notetext = "Please find attached Customer Shipment Skid Report Detail for " + ls_customer_short_name
	is_subject = f_get_ini_value("customer_shipment_skid_report","smtp_email","subject","customer_shipment_skid_report") + " Detail for " + ls_customer_short_name
Else
	ls_notetext = "Please find attached Customer Shipment Skid Report for " + ls_customer_short_name
	is_subject = f_get_ini_value("customer_shipment_skid_report","smtp_email","subject","customer_shipment_skid_report") + " for " + ls_customer_short_name
End If

ls_attached_file_name[] = as_file_name_2email[]
lb_rtn = wf_send_smtp_email(ls_notetext, ls_attached_file_name[])

wf_delete_emailed_files(ls_attached_file_name[])
is_file_name_2email[] = ls_empty[]

Return lb_rtn
//Alex Gerlants. Customer_Shipment_Rpt_All_Together. End
end function

public function integer wf_customer_list (long al_customer_id, boolean ab_row_selected);//Alex Gerlants. Customer_Shipment_Rpt_All_Together. Begin
/*
Function:	wf_customer_list
Returns:		integer
Arguments:	value			string	as_indicator <== "add" or "delete"
				reference	string	as_customer_list
				value			long		al_customer_id
*/
Integer	li_rtn = 1
Long		ll_rows, ll_row

String	ls_find_string
String	ls_customer_short_name, ls_empty[]
Long		ll_found_row
Long		ll_pos_customer_id, ll_pos_comma, ll_selected_row, ll_start, ll_customer_id, ll_empty[]

//Initialize instant variables
il_customer_id[] = ll_empty[]
is_customer_short_name[] = ls_empty[]
is_customer_list = "" //This is list of customer_id's
is_customer_name_list = "" //This is list of customer_short_name's
st_customer_list.Text = "" //This is customer name list below dw_report

//ll_customer_id = dw_customer_short_list.Object.customer_id[al_row]
ls_find_string = "customer_id = " + String(al_customer_id)
ll_found_row = dw_customer_short_list_all.Find(ls_find_string, 1, dw_customer_short_list_all.RowCount())

If ll_found_row > 0 Then
	If ab_row_selected Then
		dw_customer_short_list_all.SelectRow(ll_found_row, True)
	Else
		dw_customer_short_list_all.SelectRow(ll_found_row, False)
	End If
End If

ll_rows = dw_customer_short_list_all.RowCount()

ll_start = 0
ll_selected_row = dw_customer_short_list_all.GetSelectedRow(ll_start) //Start from the first row

Do While ll_selected_row > 0
	ll_customer_id = dw_customer_short_list_all.Object.customer_id[ll_selected_row]
	il_customer_id[UpperBound(il_customer_id[]) + 1] = ll_customer_id
	is_customer_list = is_customer_list + String(ll_customer_id) + ", "
	
	ls_customer_short_name = Trim(dw_customer_short_list_all.Object.customer_short_name[ll_selected_row])
	is_customer_short_name[UpperBound(is_customer_short_name[]) + 1] = ls_customer_short_name
	is_customer_name_list = is_customer_name_list + ls_customer_short_name + ", "
	
	ll_start = ll_selected_row
	ll_selected_row = dw_customer_short_list_all.GetSelectedRow(ll_start)
Loop

//Remove the last comma
is_customer_list = Left(is_customer_list, Len(is_customer_list) - 2)
is_customer_name_list = Left(is_customer_name_list, Len(is_customer_name_list) - 2)

st_customer_list.Text = is_customer_name_list

Return li_rtn
//Alex Gerlants. Customer_Shipment_Rpt_All_Together. End
end function

public subroutine wf_reset_report ();//Alex Gerlants. Customer_Shipment_Rpt_All_Together. Begin
/*
Function:	wf_reset_report
Returns:		none
Arguments:	none
*/
String	ls_modstring

dw_report.Reset()
st_rowcount.Text = ""
st_customer_list.Text = ""

is_customer_head_t = ""
is_shipto_head_t = ""
is_enduser_part_head_t = ""
is_date_range_head_t = ""


//Update retrieval arguments in report header
ls_modstring = "date_range_head_t.Text = '" + is_date_range_head_t + "'"
dw_report.Modify(ls_modstring)

ls_modstring = "customer_head_t.Text = '" + is_customer_head_t + "'"
dw_report.Modify(ls_modstring)

ls_modstring = "shipto_head_t.Text = '" + is_shipto_head_t + "'"
dw_report.Modify(ls_modstring)

ls_modstring = "enduser_part_head_t.Text = '" + is_enduser_part_head_t + "'"
dw_report.Modify(ls_modstring)
//Alex Gerlants. Customer_Shipment_Rpt_All_Together. End
end subroutine

public subroutine wf_delete_emailed_files (string as_file_name_2email[]);//Alex Gerlants. Customer_Shipment_Rpt_All_Together. Begin
/*
Function:	wf_delete_emailed_files
Returns:		none
Arguments:	value	string	as_file_name_2email[]
*/

Integer	li_i
String	ls_file

For li_i = 1 To UpperBound(as_file_name_2email[])
	ls_file = as_file_name_2email[li_i]
	
	FileDelete(ls_file)
Next
//Alex Gerlants. Customer_Shipment_Rpt_All_Together. End
end subroutine

on w_report_customer_skid_count_shipment.create
int iCurrent
call super::create
this.st_customer_list=create st_customer_list
this.cb_clearselection=create cb_clearselection
this.dw_customer_short_list_all=create dw_customer_short_list_all
this.st_2=create st_2
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.dw_enduser=create dw_enduser
this.rb_cust=create rb_cust
this.rb_custall=create rb_custall
this.dw_enduser_part_num=create dw_enduser_part_num
this.dw_name=create dw_name
this.st_1=create st_1
this.dw_abis_ini=create dw_abis_ini
this.sle_email_address=create sle_email_address
this.cbx_detail=create cbx_detail
this.dw_endusers_4customer=create dw_endusers_4customer
this.st_rowcount=create st_rowcount
this.cb_open_in_excel=create cb_open_in_excel
this.cb_export=create cb_export
this.dw_customer=create dw_customer
this.dw_report=create dw_report
this.cb_print=create cb_print
this.cb_close=create cb_close
this.cb_preview=create cb_preview
this.st_3=create st_3
this.em_from=create em_from
this.em_to=create em_to
this.cb_setzoom=create cb_setzoom
this.rb_dateall=create rb_dateall
this.cb_sort=create cb_sort
this.cb_email=create cb_email
this.r_1=create r_1
this.dw_customer_short_list=create dw_customer_short_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_customer_list
this.Control[iCurrent+2]=this.cb_clearselection
this.Control[iCurrent+3]=this.dw_customer_short_list_all
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_7
this.Control[iCurrent+6]=this.st_6
this.Control[iCurrent+7]=this.st_5
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.dw_enduser
this.Control[iCurrent+10]=this.rb_cust
this.Control[iCurrent+11]=this.rb_custall
this.Control[iCurrent+12]=this.dw_enduser_part_num
this.Control[iCurrent+13]=this.dw_name
this.Control[iCurrent+14]=this.st_1
this.Control[iCurrent+15]=this.dw_abis_ini
this.Control[iCurrent+16]=this.sle_email_address
this.Control[iCurrent+17]=this.cbx_detail
this.Control[iCurrent+18]=this.dw_endusers_4customer
this.Control[iCurrent+19]=this.st_rowcount
this.Control[iCurrent+20]=this.cb_open_in_excel
this.Control[iCurrent+21]=this.cb_export
this.Control[iCurrent+22]=this.dw_customer
this.Control[iCurrent+23]=this.dw_report
this.Control[iCurrent+24]=this.cb_print
this.Control[iCurrent+25]=this.cb_close
this.Control[iCurrent+26]=this.cb_preview
this.Control[iCurrent+27]=this.st_3
this.Control[iCurrent+28]=this.em_from
this.Control[iCurrent+29]=this.em_to
this.Control[iCurrent+30]=this.cb_setzoom
this.Control[iCurrent+31]=this.rb_dateall
this.Control[iCurrent+32]=this.cb_sort
this.Control[iCurrent+33]=this.cb_email
this.Control[iCurrent+34]=this.r_1
this.Control[iCurrent+35]=this.dw_customer_short_list
end on

on w_report_customer_skid_count_shipment.destroy
call super::destroy
destroy(this.st_customer_list)
destroy(this.cb_clearselection)
destroy(this.dw_customer_short_list_all)
destroy(this.st_2)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.dw_enduser)
destroy(this.rb_cust)
destroy(this.rb_custall)
destroy(this.dw_enduser_part_num)
destroy(this.dw_name)
destroy(this.st_1)
destroy(this.dw_abis_ini)
destroy(this.sle_email_address)
destroy(this.cbx_detail)
destroy(this.dw_endusers_4customer)
destroy(this.st_rowcount)
destroy(this.cb_open_in_excel)
destroy(this.cb_export)
destroy(this.dw_customer)
destroy(this.dw_report)
destroy(this.cb_print)
destroy(this.cb_close)
destroy(this.cb_preview)
destroy(this.st_3)
destroy(this.em_from)
destroy(this.em_to)
destroy(this.cb_setzoom)
destroy(this.rb_dateall)
destroy(this.cb_sort)
destroy(this.cb_email)
destroy(this.r_1)
destroy(this.dw_customer_short_list)
end on

event open;call super::open;DataWindowChild	ldwc //Alex Gerlants. Customer_Shipment_Rpt_All_Together
Long					ll_row_inserted //Alex Gerlants. Customer_Shipment_Rpt_All_Together

dw_customer.Visible = FALSE
dw_customer.SetTransObject(SQLCA)
dw_customer.Retrieve()
dw_customer.SelectRow(1,TRUE)

//ddlb_customer.Enabled = TRUE
em_from.Enabled = TRUE
em_to.Enabled = TRUE


wf_settitle()
cb_preview.SetFocus()

rb_custall.Checked = True
rb_cust.Checked = False

//cb_open_in_excel.Enabled = False
cb_print.Enabled = False

//dw_report.Event ue_retrieve()

//---------------------------------------------------------------------------------------------
//This is a copy from ws_populate_abis_ini_variables for w_customer_shipment_skid_report in silverdome3.pbl
//---------------------------------------------------------------------------------------------

String	ls_port
Long		ll_rows
Integer	li_rtn

is_from_email = gnv_app.of_GetUserId() + "@albl.com" //Email address "from"
is_from_name = gnv_app.of_GetUserId() //Name "from"

dw_abis_ini.SetTransObject(sqlca)
ll_rows = dw_abis_ini.Retrieve("customer_shipment_skid_report")

Choose Case ll_rows
	Case Is > 0 //abis_ini has rows for customer_shipment_skid_report
		is_server = f_get_ini_value("customer_shipment_skid_report","smtp_email","server","192.168.3.67")
		
		ls_port = f_get_ini_value("customer_shipment_skid_report","smtp_email","port","25")
		
		If IsNumber(ls_port) Then
			ii_port = Integer(ls_port)
		Else
			ii_port = 25
		End If
		
		is_send_email = f_get_ini_value("customer_shipment_skid_report","smtp_email","UserEmail","")
		sle_email_address.Text = is_send_email
		
		is_send_name = f_get_ini_value("customer_shipment_skid_report","smtp_email","send_name","User")
		is_logfile = f_get_ini_value("customer_shipment_skid_report","smtp_email","logfile","c:\temp\SMTP_Email_LogFile.txt")
		is_subject = f_get_ini_value("customer_shipment_skid_report","smtp_email","subject","Inventory Reports")
		
		is_email_folder = f_get_ini_value("customer_shipment_skid_report","smtp_email","email_folder","C:\temp\email\")
		
		If Right(is_email_folder, 1) <> "\" Then
			is_email_folder = is_email_folder + "\"
		End If
	Case 0 //abis_ini has no rows for customer_shipment_skid_report
		//Assign defaults to instance variables, and update to DB
		is_server = "192.168.3.67"

		ls_port = "25"
		
		If IsNumber(ls_port) Then
			ii_port = Integer(ls_port)
		Else
			ii_port = 25
		End If
		
		is_send_name = "User"
		is_logfile = "c:\temp\SMTP_Email_LogFile.txt"
		is_subject = "Customer Shipment Skid Report"
		
		is_email_folder = "C:\temp\"
		
		If Right(is_email_folder, 1) <> "\" Then
			is_email_folder = is_email_folder + "\"
		End If
		
		li_rtn = wf_insert_update_abis_ini() //Insert these defaults into dw_abis_ini, and update to DB
	Case Is < 0 //DB error
		//Assign defaults to instance variables
		is_server = "192.168.3.67"

		ls_port = "25"
		
		If IsNumber(ls_port) Then
			ii_port = Integer(ls_port)
		Else
			ii_port = 25
		End If
		
		is_send_name = "User"
		is_logfile = "c:\temp\SMTP_Email_LogFile.txt"
		is_subject = "Customer Shipment Skid Report"
		
		is_email_folder = "C:\temp\"
		
		If Right(is_email_folder, 1) <> "\" Then
			is_email_folder = is_email_folder + "\"
		End If
End Choose

//Alex Gerlants. Customer_Shipment_Rpt_All_Together. Begin
dw_customer_short_list.SetTransObject(sqlca)
ll_rows = dw_customer_short_list.Retrieve()

dw_customer_short_list.RowsCopy(1, dw_customer_short_list.RowCount(), Primary!, dw_customer_short_list_all, 1, Primary!)
ll_rows = dw_customer_short_list_all.RowCount()

dw_name.InsertRow(0)
SetFocus(dw_name)
dw_name.Visible = True
dw_customer_short_list.Visible = True
rb_cust.Checked = True
rb_custall.Checked = False


//Ship-To Destination list
dw_enduser.InsertRow(0)

li_rtn = dw_enduser.GetChild("customer_short_name", ldwc) 

If li_rtn = 1 Then //OK
	is_sql_enduser_orig = ldwc.GetSqlSelect()

	//Retrieve Ship-To list
	li_rtn = f_retrieve_child_dw(	dw_enduser, &
											ldwc, &
											"customer_short_name", &
											"customer_short_name", &
											is_sql_enduser_orig, &
											" order by ltrim(rtrim(customer.customer_short_name))", &
											sqlca, &
											False, &
											True)
End If


//End user part list
dw_enduser_part_num.InsertRow(0)

li_rtn = dw_enduser_part_num.GetChild("enduser_part_num", ldwc)

If li_rtn = 1 Then //OK
	is_sql_enduser_part_orig = ldwc.GetSqlSelect()

	//Retrieve End User Part list
	li_rtn = f_retrieve_child_dw(	dw_enduser_part_num, ldwc, &
											"enduser_part_num", &
											"enduser_part_num", &
											is_sql_enduser_part_orig, &
											" order by ltrim(rtrim(enduser_part_num))", &
											sqlca, &
											False, &
											True)
End If

dw_report.dataobject = "d_report_skid_count_shipment_all_detail"
cbx_detail.Checked = True
is_sql_dw_report_orig = dw_report.GetSqlSelect()
sle_email_address.Text = Lower(gnv_app.of_GetUserId()) + gs_albl_email_address
dw_customer_short_list_all.Visible = False
//Alex Gerlants. Customer_Shipment_Rpt_All_Together. End


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

type st_customer_list from statictext within w_report_customer_skid_count_shipment
integer x = 870
integer y = 1795
integer width = 3873
integer height = 51
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

type cb_clearselection from commandbutton within w_report_customer_skid_count_shipment
integer x = 380
integer y = 109
integer width = 366
integer height = 90
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Clear Selection"
end type

event clicked;DataWindowChild	ldwc
Integer				li_rtn
Long					ll_empty[]
String				ls_empty[]

dw_name.Object.name[1] = ""

////This will retrieve nothing
//li_rtn = f_retrieve_child_dw_2(	dw_enduser, &
//										ldwc, &
//										"customer_short_name", &
//										"customer_short_name", &
//										is_sql_enduser_orig, &
//										" and shipment.customer_id = -99999",&
//										sqlca)
//										
//dw_enduser.Object.customer_short_name[1] = "ALL"
//
//
////This will retrieve nothing
//li_rtn = f_retrieve_child_dw_2(	dw_enduser_part_num, ldwc, &
//										"enduser_part_num", &
//										"enduser_part_num", &
//										is_sql_enduser_part_orig, &
//										" and shipment.customer_id = -99999", &
//										sqlca)
//
//dw_enduser_part_num.Object.enduser_part_num[1] = "ALL"

//Remove filter
dw_customer_short_list.SetFilter("")
dw_customer_short_list.Filter()

rb_custall.Checked = False
rb_cust.Checked = True

st_customer_list.Text = ""
il_customer_id[] = ll_empty[]
is_customer_short_name[] = ls_empty[]
is_customer_list = ""
is_customer_name_list = ""

//Unselect all rows
dw_customer_short_list.SelectRow(0, False)
dw_customer_short_list_all.SelectRow(0, False)

wf_reset_report()
dw_name.Enabled = True
dw_name.SetFocus()
end event

type dw_customer_short_list_all from datawindow within w_report_customer_skid_count_shipment
integer x = 775
integer y = 19
integer width = 91
integer height = 1414
integer taborder = 130
string title = "none"
string dataobject = "d_customer_short_list_rpt"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;//String 	ls_old_sort, ls_column, ls_name
////String	ls_name_temp, ls_coltype
//Char 		lc_sort
//Long		ll_Col, ll_calendar_x
//Boolean	lb_dttm_column_clicked
//
//Long					ll_customer_id, ll_rows, ll_row_inserted //Alex Gerlants. Customer_Shipment_Rpt_All_Together
//Integer				li_rtn, li_rtn_enduser, li_rtn_enduser_part //Alex Gerlants. Customer_Shipment_Rpt_All_Together
//DataWindowChild	ldwc, ldwc_enduser, ldwc_enduser_part //Alex Gerlants. Customer_Shipment_Rpt_All_Together
//String				ls_sql, ls_sql_new //Alex Gerlants. Customer_Shipment_Rpt_All_Together
//
//ls_name = dwo.Name
//
///* Check whether the user clicks on the column header */
//If Right(ls_name, 2) = '_t' Then
//	ls_column = Left(dwo.Name, Len(String(dwo.Name)) - 2)
//
//	/* Get old sort, If any. */
//	ls_old_sort = This.Describe("Datawindow.Table.sort")
//
//	//Check whether previously sorted column and currently clicked column are same or not. 
//	//If both are same, check for the sort order of previously sorted column (A - Asc, D - Des) and change it. 
//	//If both are not same, simply sort it by Ascending order.
//	If ls_column = Left(ls_old_sort, Len(ls_old_sort) - 2) Then 
//		lc_sort = Right(ls_old_sort, 1)
//
//		If lc_sort = 'A' Then
//			lc_sort = 'D'
//		Else
//			lc_sort = 'A'
//		End If
//		  
//		This.SetSort(ls_column + " " + lc_sort)
//	Else
//		This.SetSort(ls_column + " A")
//	End If
//
//	This.Sort()
//End If
//
////---
////Alex Gerlants. Customer_Shipment_Rpt_All_Together. Begin
//
//If row <= 0 Then Return
//
////---
//
////ll_customer_id = This.Object.customer_id[row]
//
//If This.IsSelected(row) Then
//	This.SelectRow(row, False)
//	//wf_customer_list("delete", is_customer_list, ll_customer_id)
//Else
//	This.SelectRow(row, True)
//	//wf_customer_list("add", is_customer_list, ll_customer_id)
//End If
//
//wf_customer_list()
//
////---
//
////Retrieve Ship-To list
//If is_sql_enduser_orig <> "" And is_customer_list <> "" Then
//	li_rtn = f_retrieve_child_dw_2(	dw_enduser, &
//											ldwc, &
//											"customer_short_name", &
//											"customer_short_name", &
//											is_sql_enduser_orig, &
//											" and shipment.customer_id in (" + is_customer_list + ") order by ltrim(rtrim(customer.customer_short_name))",&
//											sqlca)
//	
//	
//Else
//	//ldwc.Reset()
//	//This will retrieve nothing
//	li_rtn = f_retrieve_child_dw_2(	dw_enduser, &
//											ldwc, &
//											"customer_short_name", &
//											"customer_short_name", &
//											is_sql_enduser_orig, &
//											" and shipment.customer_id = -99999",&
//											sqlca)
//											
//	dw_enduser.Object.customer_short_name[1] = "ALL"
//End If
//
////li_rtn = dw_enduser.GetChild("customer_short_name", ldwc)
////
////If li_rtn = 1 Then //OK
////	If is_sql_enduser_orig <> "" And is_customer_list <> "" Then
////		ls_sql_new = is_sql_enduser_orig + " and shipment.customer_id in (" + is_customer_list + ") order by ltrim(rtrim(customer.customer_short_name))"
////		li_rtn = ldwc.SetSqlSelect(ls_sql_new)
////		
////		If li_rtn = 1 Then //OK
////			ldwc.SetTransObject(sqlca)
////			ll_rows = ldwc.Retrieve()
////			
////			If ll_rows > 0 Then
////				ll_row_inserted = ldwc.InsertRow(1)
////				
////				If ll_row_inserted > 0 Then
////					ldwc.SetItem(ll_row_inserted, "customer_short_name", "ALL")
////					dw_enduser.Object.customer_short_name[1] = "ALL"
////				End If
////			End If
////		End If
////	Else
////		ldwc.Reset()
////		dw_enduser.Object.customer_short_name[1] = "ALL"
////	End If
////End If
//
//If is_sql_enduser_part_orig <> "" And is_customer_list <> "" Then
//	//Retrieve End User Part list
//	li_rtn = f_retrieve_child_dw_2(	dw_enduser_part_num, ldwc, &
//											"enduser_part_num", &
//											"enduser_part_num", &
//											is_sql_enduser_part_orig, &
//											" and shipment.customer_id in (" + is_customer_list + ") order by ltrim(rtrim(enduser_part_num))", &
//											sqlca)
//Else
//	//ldwc.Reset()
//	//This will retrieve nothing
//	li_rtn = f_retrieve_child_dw_2(	dw_enduser_part_num, ldwc, &
//											"enduser_part_num", &
//											"enduser_part_num", &
//											is_sql_enduser_part_orig, &
//											" and shipment.customer_id = -99999", &
//											sqlca)
//	
//	dw_enduser_part_num.Object.enduser_part_num[1] = "ALL"
//End If											
//										
////li_rtn = dw_enduser_part_num.GetChild("enduser_part_num", ldwc)
////
////If li_rtn = 1 Then //OK
////	If is_sql_enduser_part_orig <> "" And is_customer_list <> "" Then
////		ls_sql_new = is_sql_enduser_part_orig + " and shipment.customer_id in (" + is_customer_list + ") order by ltrim(rtrim(enduser_part_num))"
////		li_rtn = ldwc.SetSqlSelect(ls_sql_new)
////		
////		If li_rtn = 1 Then //OK
////			ldwc.SetTransObject(sqlca)
////			ll_rows = ldwc.Retrieve()
////			
////			If ll_rows > 0 Then
////				ll_row_inserted = ldwc.InsertRow(1)
////				
////				If ll_row_inserted > 0 Then
////					ldwc.SetItem(ll_row_inserted, "enduser_part_num", "ALL")
////					dw_enduser_part_num.Object.enduser_part_num[1] = "ALL"
////				End If
////			End If
////		End If
////	Else
////		ldwc.Reset()
////		dw_enduser_part_num.Object.enduser_part_num[1] = "ALL"
////	End If
////End If
//
////Alex Gerlants. Customer_Shipment_Rpt_All_Together. End
//	
//
//
end event

type st_2 from statictext within w_report_customer_skid_count_shipment
integer x = 2966
integer y = 150
integer width = 121
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
string text = "From"
boolean focusrectangle = false
end type

type st_7 from statictext within w_report_customer_skid_count_shipment
integer x = 2962
integer y = 58
integer width = 325
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Shipment Date"
boolean focusrectangle = false
end type

type st_6 from statictext within w_report_customer_skid_count_shipment
integer x = 102
integer y = 58
integer width = 322
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

type st_5 from statictext within w_report_customer_skid_count_shipment
integer x = 874
integer y = 58
integer width = 424
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Ship-To Destination"
boolean focusrectangle = false
end type

type st_4 from statictext within w_report_customer_skid_count_shipment
integer x = 1902
integer y = 58
integer width = 322
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

type dw_enduser from datawindow within w_report_customer_skid_count_shipment
integer x = 870
integer y = 131
integer width = 655
integer height = 90
integer taborder = 170
string title = "none"
string dataobject = "d_destination_4shipment_customer"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;//dw_report.Reset()
end event

type rb_cust from u_rb within w_report_customer_skid_count_shipment
integer x = 102
integer y = 176
integer width = 208
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Select"
end type

event clicked;DataWindowChild	ldwc
Integer				li_rtn

////Retrieve End User list
//li_rtn = dw_enduser.GetChild("customer_short_name", ldwc)
//
//If li_rtn = 1 Then //OK
//	li_rtn = ldwc.SetSqlSelect(is_sql_enduser_orig)
//
//	If li_rtn = 1 Then //OK
//		ldwc.Reset()
//	End If
//End If
//
////Retrieve End User Part list
//li_rtn = dw_enduser_part_num.GetChild("enduser_part_num", ldwc)
//
//If li_rtn = 1 Then //OK
//	li_rtn = ldwc.SetSqlSelect(is_sql_enduser_part_orig)
//	
//	If li_rtn = 1 Then //OK
//		ldwc.Reset()
//	End If
//End If

dw_customer_short_list.SelectRow(0, False)
This.Checked = True
rb_custall.Checked = False
dw_name.Enabled = True
dw_name.SetFocus()
end event

type rb_custall from u_rb within w_report_customer_skid_count_shipment
integer x = 102
integer y = 112
integer width = 172
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "All"
boolean checked = true
end type

event clicked;cb_clearselection.Event Clicked()

dw_customer_short_list.SelectRow(0, True) //Select all customers
This.Checked = True
rb_cust.Checked = False

//DataWindowChild	ldwc
//Integer				li_rtn
//Long					ll_rows, ll_row_inserted
//String				ls_sql_new
//
//
//
////Retrieve Ship-To list
//li_rtn = f_retrieve_child_dw_2(	dw_enduser, &
//										ldwc, &
//										"customer_short_name", &
//										"customer_short_name", &
//										is_sql_enduser_orig, &
//										" order by ltrim(rtrim(customer.customer_short_name))",&
//										sqlca)
//
////Retrieve End User Part list
//li_rtn = f_retrieve_child_dw_2(	dw_enduser_part_num, ldwc, &
//										"enduser_part_num", &
//										"enduser_part_num", &
//										is_sql_enduser_part_orig, &
//										" order by ltrim(rtrim(enduser_part_num))", &
//										sqlca)


end event

type dw_enduser_part_num from datawindow within w_report_customer_skid_count_shipment
integer x = 1905
integer y = 138
integer width = 655
integer height = 90
integer taborder = 120
string title = "none"
string dataobject = "d_enduser_part_4shipment_customer"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;//dw_report.Reset()
end event

type dw_name from datawindow within w_report_customer_skid_count_shipment
integer x = 88
integer y = 250
integer width = 680
integer height = 90
integer taborder = 110
string title = "none"
string dataobject = "d_name"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event editchanged;String	ls_data, ls_filter_string, ls_rtn
Integer	li_rtn
Long		ll_rows, ll_filteredcount

ls_data = Lower(data)

If Len(ls_data) > 0 Then
	ls_filter_string = "Lower(customer_short_name) like '" + ls_data + "%'"
Else
	ls_filter_string = ""
End If


li_rtn = dw_customer_short_list.SetFilter(ls_filter_string)
li_rtn = dw_customer_short_list.Filter()

ll_rows = dw_customer_short_list.RowCount()
ll_filteredcount = dw_customer_short_list.FilteredCount()


end event

event clicked;Long		ll_rows, ll_row, ll_selected_rows

ll_rows = dw_customer_short_list.RowCount()

For ll_row = 1 To ll_rows
	If dw_customer_short_list.IsSelected(ll_row) Then ll_selected_rows++
Next

If ll_selected_rows = ll_rows Then //All rows selected
	cb_clearselection.Event Clicked()
End If

rb_custall.Checked = False
rb_cust.Checked = True
end event

type st_1 from statictext within w_report_customer_skid_count_shipment
integer x = 4133
integer y = 93
integer width = 388
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Email To Address"
boolean focusrectangle = false
end type

type dw_abis_ini from datawindow within w_report_customer_skid_count_shipment
boolean visible = false
integer x = 2973
integer y = 1229
integer width = 1317
integer height = 512
integer taborder = 110
string title = "none"
string dataobject = "d_abis_ini"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type sle_email_address from singlelineedit within w_report_customer_skid_count_shipment
integer x = 4129
integer y = 144
integer width = 867
integer height = 77
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cbx_detail from checkbox within w_report_customer_skid_count_shipment
integer x = 4129
integer y = 19
integer width = 395
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Detail Report"
boolean checked = true
end type

event clicked;
If This.Checked Then
	dw_report.DataObject = dw_report.DataObject + "_detail"
	//cb_open_in_excel.Enabled = False
	cb_print.Enabled = False
Else
	dw_report.DataObject = Left(dw_report.DataObject, Len(dw_report.DataObject) - 7)
	//cb_open_in_excel.Enabled = True
	cb_print.Enabled = True
End If

is_sql_dw_report_orig = dw_report.GetSqlSelect()
dw_report.SetTransObject(sqlca)


end event

type dw_endusers_4customer from datawindow within w_report_customer_skid_count_shipment
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

type st_rowcount from statictext within w_report_customer_skid_count_shipment
integer x = 870
integer y = 1872
integer width = 1818
integer height = 51
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

type cb_open_in_excel from commandbutton within w_report_customer_skid_count_shipment
integer x = 2838
integer y = 1971
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

event clicked;Boolean	lb_rtn
Integer	li_answer = 2
String	ls_attached_file_name[], ls_file_name_2display

If dw_report.DataObject = "d_report_skid_count_shipment_all" Then
	Parent.ExportToExcel( dw_report, dw_report.RowCount() )
ElseIf dw_report.DataObject = "d_report_skid_count_shipment_all_detail" Then
	Parent.ExportToExcel_detail( dw_report, dw_report.RowCount() )
End If

//Alex Gerlants. 02/19/2019. Fix. Commented out the code below.
//li_answer = MessageBox("Success", "Report has been successfully exported to " + is_file_name_2email[1] + &
//			"~n~rWould you like to email this file?", Question!, YesNo!, 1 )
//			
//If li_answer = 1 Then //Yes
//	ls_attached_file_name[1] = is_file_name_2email[][1]
//	lb_rtn = wf_email(ls_attached_file_name[])
//End If
end event

type cb_export from u_cb within w_report_customer_skid_count_shipment
integer x = 2311
integer y = 1971
integer width = 406
integer height = 77
integer taborder = 150
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Export to Excel"
end type

event clicked;call super::clicked;SetPointer(HourGlass!)
String 	ls_file, ls_today, ls_now, ls_address_2email
String	ls_customer_short_name, ls_empty[]
Integer	li_answer
Date 		ld_today
Time 		ld_now
Long		ll_row

String	ls_notetext, ls_attached_file_name[]
Boolean	lb_rtn

If dw_report.RowCount() <= 0 Then
	MessageBox("Nothing to export", "Please retrieve report first", StopSign!)
	Return
End If

If UpperBound(is_customer_short_name[]) = 1 Then
	ls_customer_short_name = is_customer_short_name[1]
Else
	ls_customer_short_name = "Multiple Customers"
End If

ld_today = Today()
ld_now = Now()
ls_today = String(ld_today,"mmddyyyy")
ls_now = String(ld_now,"hhmmss")

If cbx_detail.Checked Then
	ls_file = ProfileString(gs_ini_file, "EMAIL","email_out","c:\temp") + '\Customer Shipment Report_Detail_' + ls_customer_short_name + "_" + ls_today + "_" + ls_now + ".xls"
Else
	ls_file = ProfileString(gs_ini_file, "EMAIL","email_out","c:\temp") + '\Customer Shipment Report_' + ls_customer_short_name + "_" + ls_today + "_" + ls_now + ".xls"
End If

If dw_report.SaveAs(ls_file, Excel5!, True) = -1 Then
   MessageBox("Data SaveAs", "Error")
	Return -1
Else
	is_file_name_2email[UpperBound(is_file_name_2email[]) + 1] = ls_file
	
	Sleep(5)
	
	li_answer = MessageBox("Success", "Report has been successfully exported to " + ls_file + &
		"~n~rWould you like to email this file?", Question!, YesNo!, 1 )
		
	If li_answer = 1 Then
		ls_address_2email = sle_email_address.Text
		If IsNull(ls_address_2email) Then ls_address_2email = ""
		
		If ls_address_2email <> "" Then
			ls_attached_file_name[1] = ls_file
			lb_rtn = wf_email(ls_attached_file_name[])
		Else
			MessageBox("Email address missing", "Please enter email address, and click on Email button.")
		End If
	End If
End If

Return 1
end event

type dw_customer from u_dw within w_report_customer_skid_count_shipment
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

type dw_report from u_dw within w_report_customer_skid_count_shipment
event ue_retrieve ( )
event ue_clean_duplicates ( )
integer x = 870
integer y = 246
integer width = 4136
integer height = 1533
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_report_skid_count_shipment_all"
boolean hscrollbar = true
end type

event ue_retrieve();//dw_report.Reset()
//
//wf_shipment()
//wf_settitle()
//wf_setfilter()
////this.Event ue_clean_duplicates()







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

event retrieveend;call super::retrieveend;//Alex Gerlants. Customer_Shipment_Rpt_All_Together. Begin
String	ls_modstring

//Update retrieval arguments in report header
ls_modstring = "date_range_head_t.Text = '" + is_date_range_head_t + "'"
dw_report.Modify(ls_modstring)

ls_modstring = "customer_head_t.Text = '" + is_customer_head_t + "'"
dw_report.Modify(ls_modstring)

ls_modstring = "shipto_head_t.Text = '" + is_shipto_head_t + "'"
dw_report.Modify(ls_modstring)

ls_modstring = "enduser_part_head_t.Text = '" + is_enduser_part_head_t + "'"
dw_report.Modify(ls_modstring)
//Alex Gerlants. Customer_Shipment_Rpt_All_Together. End





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

type cb_print from u_cb within w_report_customer_skid_count_shipment
integer x = 1419
integer y = 1971
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

type cb_close from u_cb within w_report_customer_skid_count_shipment
string tag = "Exit"
integer x = 3306
integer y = 1971
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

type cb_preview from u_cb within w_report_customer_skid_count_shipment
event clicked pbm_bnclicked
integer x = 66
integer y = 1971
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
//dw_report.Event ue_retrieve() //Alex Gerlants. Customer_Shipment_Rpt_All_Together. Comment out

//Alex Gerlants. Customer_Shipment_Rpt_All_Together. Begin
String				ls_date_from, ls_date_to, ls_enduser, ls_enduser_part
String				ls_add_2sql, ls_sql_new
String				ls_find_string, ls_shipto_destination, ls_shipto_destination_id, ls_empty[]
Long					ll_found_row, ll_des_sh_cust_id, ll_customer_id, ll_rows, ll_row_inserted
Integer				li_rtn
DataWindowChild	ldwc

is_file_name_2email[] = ls_empty[]

ls_date_from = em_from.Text
ls_date_to = em_to.Text
//wf_get_customer_names(is_customer_list, is_customer_name_list)
ls_enduser = String(dw_enduser.Object.customer_short_name[1])
ls_enduser_part = dw_enduser_part_num.Object.enduser_part_num[1]

ls_add_2sql = "  where shipment.shipment_actualed_date_time between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + &
								" and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )  "

If ls_date_from = ls_date_to Then
	is_date_range_head_t = "Shipment Date: " + ls_date_from
Else
	is_date_range_head_t = "Shipment Date Between " + ls_date_from + " and " + ls_date_to
End If

If is_customer_list <> "" Then
	ls_add_2sql = ls_add_2sql + " and shipment.customer_id in (" + is_customer_list + ")"
	is_customer_head_t = "Customer(s): " + is_customer_name_list
Else
	li_rtn = MessageBox("Run Report for all customers?", "No customers selected.~n~rRun Report for all customers?  Can take a while.", &
																					Question!, YesNo!, 2) 
	
	If li_rtn = 1 Then //Yes
		is_customer_head_t = "All Customers"
	Else
		Return
	End If
End If

If Upper(ls_enduser) <> "ALL" Then
	//ls_add_2sql = ls_add_2sql + " and shipment.des_sh_cust_id = " + ls_enduser
	
	li_rtn = dw_enduser.GetChild("customer_short_name", ldwc)
	
	If li_rtn = 1 Then //OK
		ls_find_string = "customer_short_name = '" + ls_enduser + "'"
		ll_found_row = ldwc.Find(ls_find_string, 1, ldwc.RowCount())
		
		If ll_found_row > 0 Then
			//ls_shipto_destination = ldwc.GetItemString(ll_found_row, "customer_short_name")
			is_shipto_head_t = "Ship-To Destination: " + ls_enduser
			
			ls_shipto_destination_id = String(ldwc.GetItemNumber(ll_found_row, "customer_id"))
			ls_add_2sql = ls_add_2sql + " and shipment.des_sh_cust_id = " + ls_shipto_destination_id
		End If
	End If
Else
	is_shipto_head_t = "All Ship-To Destinations"
End If

If dw_report.dataobject = "d_report_skid_count_shipment_all_detail" Then
	If Upper(ls_enduser_part) <> "ALL" Then
		ls_add_2sql = ls_add_2sql + " and order_item.enduser_part_num = '" + ls_enduser_part + "'"
		is_enduser_part_head_t = "End User Part: " + ls_enduser_part
	Else
	is_enduser_part_head_t = "All End User Parts"
	End If
End If

ls_sql_new = is_sql_dw_report_orig + ls_add_2sql

li_rtn = dw_report.SetSqlSelect(ls_sql_new)

If li_rtn = 1 Then //OK
	dw_report.SetTransObject(sqlca)
	ll_rows = dw_report.Retrieve()
	
	If ll_rows = 1 Then
		st_rowcount.Text = " 1 row retrieved"
	Else
		st_rowcount.Text = " " + String(ll_rows) + " rows retrieved"
	End If
End If
//Alex Gerlants. Customer_Shipment_Rpt_All_Together. End
end event

type st_3 from statictext within w_report_customer_skid_count_shipment
integer x = 3412
integer y = 150
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

type em_from from editmask within w_report_customer_skid_count_shipment
integer x = 3112
integer y = 144
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

event losefocus;//wf_SetTitle()
//RETURN 1
end event

type em_to from editmask within w_report_customer_skid_count_shipment
integer x = 3482
integer y = 144
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

event losefocus;//wf_settitle()
//
//RETURN 1
end event

type cb_setzoom from u_cb within w_report_customer_skid_count_shipment
integer x = 962
integer y = 1971
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

type rb_dateall from u_rb within w_report_customer_skid_count_shipment
boolean visible = false
integer x = 1620
integer y = 48
integer width = 176
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "All"
end type

event clicked;//IF this.Checked THEN
//	em_from.Enabled = FALSE
//	em_to.Enabled = FALSE
//ELSE
//	em_from.Enabled = TRUE
//	em_to.Enabled = TRUE
//END IF
//wf_settitle()
//
//dw_report.Event ue_retrieve()
//RETURN 1
end event

type cb_sort from u_cb within w_report_customer_skid_count_shipment
integer x = 512
integer y = 1971
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

type cb_email from u_cb within w_report_customer_skid_count_shipment
integer x = 1858
integer y = 1971
integer width = 307
integer height = 74
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Email"
end type

event clicked;String	ls_attached_file_name[], ls_notetext
String	ls_customer_short_name, ls_empty[]
Boolean	lb_rtn
Long		ll_row
pointer 	lp_oldpointer

If dw_report.RowCount() <= 0 Then
	MessageBox("Nothing to Email", "Please retrieve report first", StopSign!)
	Return
End If

lp_oldpointer = SetPointer(HourGlass!)
is_send_email = sle_email_address.Text

//Alex Gerlants. Customer_Shipment_Rpt_All_Together. Begin
wf_open_in_excel() //Alex Gerlants. Customer_Shipment_Rpt_All_Together
wf_export_2excel() //Alex Gerlants. Customer_Shipment_Rpt_All_Together

//Files to email are in is_file_name_2email[]

Sleep(5)

If UpperBound(is_customer_short_name[]) = 1 Then
	ls_customer_short_name = is_customer_short_name[1]
Else
	ls_customer_short_name = "Multiple Customers"
End If

If cbx_detail.Checked Then
	ls_notetext = "Please find attached Customer Shipment Skid Report Detail for " + ls_customer_short_name
	is_subject = f_get_ini_value("customer_shipment_skid_report","smtp_email","subject","customer_shipment_skid_report") + " Detail for " + ls_customer_short_name
Else
	ls_notetext = "Please find attached Customer Shipment Skid Report for " + ls_customer_short_name
	is_subject = f_get_ini_value("customer_shipment_skid_report","smtp_email","subject","customer_shipment_skid_report") + " for " + ls_customer_short_name
End If

ls_attached_file_name[] = is_file_name_2email[]
lb_rtn = wf_send_smtp_email(ls_notetext, ls_attached_file_name[])

wf_delete_emailed_files(ls_attached_file_name[])
is_file_name_2email[] = ls_empty[]

SetPointer(lp_oldpointer)

Return 1
end event

type r_1 from rectangle within w_report_customer_skid_count_shipment
long linecolor = 16777215
integer linethickness = 3
long fillcolor = 65535
integer x = 51
integer y = 1952
integer width = 336
integer height = 112
end type

type dw_customer_short_list from datawindow within w_report_customer_skid_count_shipment
integer x = 88
integer y = 358
integer width = 680
integer height = 1418
integer taborder = 120
string title = "none"
string dataobject = "d_customer_short_list_rpt"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;String 	ls_old_sort, ls_column, ls_name
//String	ls_name_temp, ls_coltype
Char 		lc_sort
Long		ll_Col, ll_calendar_x
Boolean	lb_dttm_column_clicked

Long					ll_customer_id, ll_rows, ll_row_inserted //Alex Gerlants. Customer_Shipment_Rpt_All_Together
Integer				li_rtn, li_rtn_enduser, li_rtn_enduser_part //Alex Gerlants. Customer_Shipment_Rpt_All_Together
DataWindowChild	ldwc, ldwc_enduser, ldwc_enduser_part //Alex Gerlants. Customer_Shipment_Rpt_All_Together
String				ls_sql, ls_sql_new, ls_customer_short_name //Alex Gerlants. Customer_Shipment_Rpt_All_Together

wf_reset_report()
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

//---
//Alex Gerlants. Customer_Shipment_Rpt_All_Together. Begin
If row <= 0 Then Return

//---

ll_customer_id = This.Object.customer_id[row]
ls_customer_short_name = This.Object.customer_short_name[row]

If This.IsSelected(row) Then
	This.SelectRow(row, False)
	wf_customer_list(ll_customer_id, False)
Else
	This.SelectRow(row, True)
	wf_customer_list(ll_customer_id, True)
End If

//dw_report.Reset()

////Retrieve Ship-To list
//If is_sql_enduser_orig <> "" And is_customer_list <> "" Then
//	li_rtn = f_retrieve_child_dw_2(	dw_enduser, &
//											ldwc, &
//											"customer_short_name", &
//											"customer_short_name", &
//											is_sql_enduser_orig, &
//											" and shipment.customer_id in (" + is_customer_list + ") order by ltrim(rtrim(customer.customer_short_name))",&
//											sqlca)
//	
//	
//Else
//	//This will retrieve nothing
//	li_rtn = f_retrieve_child_dw_2(	dw_enduser, &
//											ldwc, &
//											"customer_short_name", &
//											"customer_short_name", &
//											is_sql_enduser_orig, &
//											" and shipment.customer_id = -99999",&
//											sqlca)
//											
//	dw_enduser.Object.customer_short_name[1] = "ALL"
//End If
//
//If is_sql_enduser_part_orig <> "" And is_customer_list <> "" Then
//	//Retrieve End User Part list
//	li_rtn = f_retrieve_child_dw_2(	dw_enduser_part_num, ldwc, &
//											"enduser_part_num", &
//											"enduser_part_num", &
//											is_sql_enduser_part_orig, &
//											" and shipment.customer_id in (" + is_customer_list + ") order by ltrim(rtrim(enduser_part_num))", &
//											sqlca)
//Else
//	//This will retrieve nothing
//	li_rtn = f_retrieve_child_dw_2(	dw_enduser_part_num, ldwc, &
//											"enduser_part_num", &
//											"enduser_part_num", &
//											is_sql_enduser_part_orig, &
//											" and shipment.customer_id = -99999", &
//											sqlca)
//	
//	dw_enduser_part_num.Object.enduser_part_num[1] = "ALL"
//End If
//Alex Gerlants. Customer_Shipment_Rpt_All_Together. End
	


end event

