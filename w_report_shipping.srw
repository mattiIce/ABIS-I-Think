$PBExportHeader$w_report_shipping.srw
$PBExportComments$<popup> shipping report tool inherited from pfemain/w_popup
forward
global type w_report_shipping from w_popup
end type
type cb_sleep_test from commandbutton within w_report_shipping
end type
type dw_reprint_cert_label from datawindow within w_report_shipping
end type
type cbx_cert_label from checkbox within w_report_shipping
end type
type cb_reprint from commandbutton within w_report_shipping
end type
type dw_skids_4packing_list from datawindow within w_report_shipping
end type
type dw_package_num_4packing_list from datawindow within w_report_shipping
end type
type cb_close from u_cb within w_report_shipping
end type
type cb_setzoom from u_cb within w_report_shipping
end type
type cb_print from u_cb within w_report_shipping
end type
type cb_reset from u_cb within w_report_shipping
end type
type st_1 from statictext within w_report_shipping
end type
type ddlb_type from dropdownlistbox within w_report_shipping
end type
type dw_type from u_dw within w_report_shipping
end type
type dw_report from u_report_dw within w_report_shipping
end type
type cb_setup from u_cb within w_report_shipping
end type
type cb_custom from u_cb within w_report_shipping
end type
type dw_detail from u_dw within w_report_shipping
end type
end forward

global type w_report_shipping from w_popup
integer x = 55
integer y = 19
integer width = 3606
integer height = 2429
string title = "Print shipping report"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
cb_sleep_test cb_sleep_test
dw_reprint_cert_label dw_reprint_cert_label
cbx_cert_label cbx_cert_label
cb_reprint cb_reprint
dw_skids_4packing_list dw_skids_4packing_list
dw_package_num_4packing_list dw_package_num_4packing_list
cb_close cb_close
cb_setzoom cb_setzoom
cb_print cb_print
cb_reset cb_reset
st_1 st_1
ddlb_type ddlb_type
dw_type dw_type
dw_report dw_report
cb_setup cb_setup
cb_custom cb_custom
dw_detail dw_detail
end type
global w_report_shipping w_report_shipping

type variables
Long il_shipment
Int ii_type
Long il_customer
Long il_enduser
string is_typename

end variables

forward prototypes
public function string wf_get_objectname ()
public function integer wf_setreportobject ()
public subroutine wf_reprint_cert_label (long al_sheet_skid_num)
public function boolean wf_shipping_2gm ()
end prototypes

public function string wf_get_objectname ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Get_objectname
//
//	Access:    Public
//
//	Arguments:	None
//
//	Returns:  string
//	  The object name string.
//
//	Description:  
//	Returns report object name base on 
//			il_customer  --  customer_id
//			il_enduser	--	enduser_id
//			ii_type	--	report type
//	IF there is no object specified then return then default one.
//
//////////////////////////////////////////////////////////////////////////////

String ls_name
Int li_template_id

SetNULL(ls_name)
CONNECT USING SQLCA;
SELECT SH_REPORT_TEMPLATES.SH_REPORT_TEMPLATE_OBJECT INTO :ls_name  
FROM CUSTOMER_SH_REPORT_TEMPLATES, SH_REPORT_TEMPLATES  
WHERE ( SH_REPORT_TEMPLATES.SH_REPORT_TEMPLATE_ID = CUSTOMER_SH_REPORT_TEMPLATES.SH_REPORT_TEMPLATE_ID ) and  
		( ( CUSTOMER_SH_REPORT_TEMPLATES.CUSTOMER_ID = :il_customer ) AND  
		( CUSTOMER_SH_REPORT_TEMPLATES.SHIPTO_ID = :il_enduser ) AND  
		( SH_REPORT_TEMPLATES.SH_REPORT_TYPE_ID = :ii_type ) )    
USING SQLCA;

IF IsNULL(ls_name) OR Len(ls_name) < 2 THEN
	//CUSTOMER DEFAULT TEMPLATE
	SELECT SH_REPORT_TEMPLATES.SH_REPORT_TEMPLATE_OBJECT INTO :ls_name  
	FROM CUST_SH_DEFAULT_TEMPLATE, SH_REPORT_TEMPLATES  
	WHERE ( SH_REPORT_TEMPLATES.SH_REPORT_TEMPLATE_ID = CUST_SH_DEFAULT_TEMPLATE.SH_REPORT_TEMPLATE_ID ) and  
			( (CUST_SH_DEFAULT_TEMPLATE.CUSTOMER_ID = :il_customer ) AND  
			( CUST_SH_DEFAULT_TEMPLATE.SH_REPORT_TYPE_ID = :ii_type ) )    
	USING SQLCA;
END IF

//DEFAULT TEMPLATE
IF IsNULL(ls_name) OR Len(ls_name) < 2 THEN
	SELECT SH_REPORT_TEMPLATES.SH_REPORT_TEMPLATE_OBJECT INTO :ls_name   
   FROM SH_REPORT_DEFAULT_TEMPLATE, SH_REPORT_TEMPLATES  
   WHERE ( SH_REPORT_TEMPLATES.SH_REPORT_TEMPLATE_ID = SH_REPORT_DEFAULT_TEMPLATE.SH_REPORT_TEMPLATE_ID ) and  
     	   ( SH_REPORT_DEFAULT_TEMPLATE.SH_REPORT_TYPE_ID = SH_REPORT_TEMPLATES.SH_REPORT_TYPE_ID ) and  
    	   ( ( SH_REPORT_DEFAULT_TEMPLATE.SH_REPORT_TYPE_ID = :ii_type ) )    
	USING SQLCA;
END IF

//Alex Gerlants. 11/13/2019. Arconic-TN GM Barcode Change. Begin
If ii_type = 4 Then //Barcode
	If wf_shipping_2gm() Then
		ls_name = "u_barcode_shipping_2gm"
	End If
End If
//Alex Gerlants. 11/13/2019. Arconic-TN GM Barcode Change. End

RETURN ls_name
end function

public function integer wf_setreportobject ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_setreportobject
//
//	Access:    Public
//
//	Arguments:	None
//
//	Returns:  Integer
//	  	1	-- success
//		other  -- false
//
//	Description:  setup print object based on the object name
//
//////////////////////////////////////////////////////////////////////////////

String ls_oname
s_dw_info lstr_dw
Integer	li_allow_setup //Alex Gerlants. 05/21/2018

//Alex Gerlants. Reprint_Barcode_Button. 05/07/2019. Begin
If ii_type = 4 Or ii_type = 1 Then //Barcode or Packaging ticket
	dw_skids_4packing_list.Visible = True
	cb_reprint.Visible = True
	cbx_cert_label.Visible = True //Alex Gerlants. 06/11/2019. Reprint cert label
Else
	dw_skids_4packing_list.Visible = False
	cb_reprint.Visible = False
	cbx_cert_label.Visible = False //Alex Gerlants. 06/11/2019. Reprint cert label
End If
//Alex Gerlants. Reprint_Barcode_Button. 05/07/2019. End

ls_oname = wf_get_objectname()
dw_report.of_setabcoreport(ls_oname)

li_allow_setup = dw_report.inv_abco_report.Dynamic of_allowsetup()

//IF dw_report.inv_abco_report.Dynamic of_allowsetup() = 1 THEN
IF li_allow_setup = 1 THEN
	cb_setup.Enabled = TRUE
ELSE
	cb_setup.Enabled = FALSE
END IF

dw_report.Reset()
dw_report.DataObject = dw_report.inv_abco_report.Dynamic of_getreportobject()
dw_report.setTransObject(SQLCA)
IF dw_report.inv_abco_report.Dynamic of_retrieve(il_shipment) < 0 THEN
	MessageBox("Info", "Failed to print report.")
	cb_print.Enabled = FALSE
	cb_reset.Enabled = FALSE
	cb_setzoom.Enabled = FALSE
ELSE
	cb_print.Enabled = TRUE
	cb_reset.Enabled = TRUE
	cb_setzoom.Enabled = TRUE
END IF

lstr_dw = dw_report.inv_abco_report.Dynamic Event ue_custom_display()
dw_report.Width = lstr_dw.width
dw_report.Height = lstr_dw.length
dw_report.VScrollBar = lstr_dw.v_bar
dw_report.HScrollBar = lstr_dw.h_bar
dw_report.BringToTop = lstr_dw.front

RETURN 1
end function

public subroutine wf_reprint_cert_label (long al_sheet_skid_num);String	ls_find_string
Long		ll_rows, ll_found_row, ll_orig_customer_id, ll_order_abc_num
Integer	li_rtn

ll_rows = dw_reprint_cert_label.Retrieve(il_shipment)

If ll_rows > 0 Then
	ls_find_string = "sheet_skid_num = " + String(al_sheet_skid_num)
	ll_found_row = dw_reprint_cert_label.Find(ls_find_string, 1, dw_reprint_cert_label.RowCount())
	
	If ll_found_row > 0 Then
		ll_orig_customer_id = dw_reprint_cert_label.Object.orig_customer_id[ll_found_row]
		ll_order_abc_num = dw_reprint_cert_label.Object.order_abc_num[ll_found_row]
		
		li_rtn = PrintSetup()
		
		If li_rtn = -1 Then //Error in PrintSetup() or user clicked on "Cancel"
			Return
		End If
		
		li_rtn = f_print_cert_label(ll_orig_customer_id, al_sheet_skid_num, ll_order_abc_num, sqlca)
	End If
End If
end subroutine

public function boolean wf_shipping_2gm ();//Alex Gerlants. 11/13/2019. Arconic-TN GM Barcode Change. Begin
/*
Function:	wf_shipping_2gm
Returns:		boolean	True  if shipping to a GM destination
							False	if shipping to a non-GM destination
Arguments:	none							
*/
Boolean		lb_shipping_2gm = False
Long			ll_count, ll_customer, ll_des_sh_cust_id
Integer		li_i

ll_customer = il_customer
ll_des_sh_cust_id = il_enduser

select	count(*)
into		:ll_count
from		dbo.gm_destination_customers
where		customer_id = :ll_customer
and		des_sh_cust_id = :ll_des_sh_cust_id
using		sqlca;

If sqlca.sqlcode = 0 Then //OK
	If ll_count > 0 Then
		lb_shipping_2gm = True
	End If
End If
 
Return lb_shipping_2gm
//Alex Gerlants. 11/13/2019. Arconic-TN GM Barcode Change. End
end function

on w_report_shipping.create
int iCurrent
call super::create
this.cb_sleep_test=create cb_sleep_test
this.dw_reprint_cert_label=create dw_reprint_cert_label
this.cbx_cert_label=create cbx_cert_label
this.cb_reprint=create cb_reprint
this.dw_skids_4packing_list=create dw_skids_4packing_list
this.dw_package_num_4packing_list=create dw_package_num_4packing_list
this.cb_close=create cb_close
this.cb_setzoom=create cb_setzoom
this.cb_print=create cb_print
this.cb_reset=create cb_reset
this.st_1=create st_1
this.ddlb_type=create ddlb_type
this.dw_type=create dw_type
this.dw_report=create dw_report
this.cb_setup=create cb_setup
this.cb_custom=create cb_custom
this.dw_detail=create dw_detail
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_sleep_test
this.Control[iCurrent+2]=this.dw_reprint_cert_label
this.Control[iCurrent+3]=this.cbx_cert_label
this.Control[iCurrent+4]=this.cb_reprint
this.Control[iCurrent+5]=this.dw_skids_4packing_list
this.Control[iCurrent+6]=this.dw_package_num_4packing_list
this.Control[iCurrent+7]=this.cb_close
this.Control[iCurrent+8]=this.cb_setzoom
this.Control[iCurrent+9]=this.cb_print
this.Control[iCurrent+10]=this.cb_reset
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.ddlb_type
this.Control[iCurrent+13]=this.dw_type
this.Control[iCurrent+14]=this.dw_report
this.Control[iCurrent+15]=this.cb_setup
this.Control[iCurrent+16]=this.cb_custom
this.Control[iCurrent+17]=this.dw_detail
end on

on w_report_shipping.destroy
call super::destroy
destroy(this.cb_sleep_test)
destroy(this.dw_reprint_cert_label)
destroy(this.cbx_cert_label)
destroy(this.cb_reprint)
destroy(this.dw_skids_4packing_list)
destroy(this.dw_package_num_4packing_list)
destroy(this.cb_close)
destroy(this.cb_setzoom)
destroy(this.cb_print)
destroy(this.cb_reset)
destroy(this.st_1)
destroy(this.ddlb_type)
destroy(this.dw_type)
destroy(this.dw_report)
destroy(this.cb_setup)
destroy(this.cb_custom)
destroy(this.dw_detail)
end on

event pfc_print;//Alex Gerlants. 05/21/2018. Begin
Integer	li_rtn

//Alex Gerlants. 06/15/2018. Arconic_Package_Num. Begin
Integer	li_answer
String	ls_skid_num_without_package_num, ls_customer_short_name
Long		ll_rows
Boolean	lb_use_package_num

f_get_use_package_num_4shipment(il_shipment, sqlca, lb_use_package_num)

If lb_use_package_num Then
	
	dw_package_num_4packing_list.SetTransObject(sqlca)
	ll_rows = dw_package_num_4packing_list.Retrieve(il_shipment)
	
	li_rtn = f_package_num_4packing_list(dw_package_num_4packing_list, il_shipment, ls_skid_num_without_package_num)

	If li_rtn = 1 Then
		If ls_skid_num_without_package_num <> "" Then
			select	customer_short_name
			into		:ls_customer_short_name
			from		customer
			where		customer_id = :il_customer
			using		sqlca;
			
			li_answer = MessageBox("One or more customer package numbers missing", &
								"Customer " + ls_customer_short_name + " requires its package number printed on shipping documents.~n~r"  + &
								"The following skids do not have required Customer Package Numbers:~n~r" + &
								ls_skid_num_without_package_num + &
								"~n~r~n~rWould you like to continue?", Question!, YesNo!, 2)
												
			If li_answer = 2 Then //No
				Return 1
			End If
		End If
	Else
		//
	End If
End If
//Alex Gerlants. 06/15/2018. Arconic_Package_Num. End

li_rtn = PrintSetup()

If li_rtn = -1 Then //User clicked on "Cancel"
	Return 1
End If
//Alex Gerlants. 05/21/2018. End

//PrintSetup() //Alex Gerlants. 05/21/2018. Comment out

dw_report.inv_abco_report.Dynamic of_printshippingreport(il_shipment)
MessageBox("Info", "Done!")
RETURN 1
end event

event pfc_open;il_shipment = Message.DoubleParm

Long ll_row, ll_i
ll_row = dw_type.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		ddlb_type.AddItem(dw_type.GetItemString(ll_i, "sh_report_type_name"))
	NEXT
END IF

CONNECT USING SQLCA;
SELECT customer_id, des_sh_cust_id INTO :il_customer, :il_enduser
FROM shipment
WHERE packing_list = :il_shipment
USING SQLCA;

ddlb_type.SelectItem(1)

end event

event pfc_saveas;dw_report.inv_abco_report.Dynamic of_savereport()


end event

event open;call super::open;il_shipment = Message.DoubleParm
Integer				li_rtn //Alex Gerlants. Reprint_Barcode_Button. 05/07/2019
Long					ll_rows, ll_sheet_skid_num //Alex Gerlants. Reprint_Barcode_Button. 05/07/2019
DataWindowChild	ldwc //Alex Gerlants. Reprint_Barcode_Button. 05/07/2019

Long ll_row, ll_i
dw_type.SetTransObject(SQLCA)
dw_type.Retrieve()
dw_type.SelectRow(1,TRUE)
ll_row = dw_type.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		ddlb_type.AddItem(dw_type.GetItemString(ll_i, "sh_report_type_name"))
	NEXT
END IF

CONNECT USING SQLCA;
SELECT customer_id, des_sh_cust_id INTO :il_customer, :il_enduser
FROM shipment
WHERE packing_list = :il_shipment
USING SQLCA;

ddlb_type.SelectItem(1)
ddlb_type.Event SelectionChanged(1)

dw_detail.Retrieve(il_shipment)

//Alex Gerlants. Reprint_Barcode_Button. 05/07/2019. Begin
dw_skids_4packing_list.InsertRow(0)

li_rtn = dw_skids_4packing_list.GetChild("sheet_skid_num", ldwc)

If li_rtn = 1 Then //OK
	ldwc.SetTransObject(sqlca)
	ll_rows = ldwc.Retrieve(il_shipment)
	
	If ll_rows > 0 Then
		ll_sheet_skid_num = ldwc.GetItemNumber(1, "sheet_skid_num")
		dw_skids_4packing_list.Object.sheet_skid_num[1] = ll_sheet_skid_num
	End If
End If

dw_skids_4packing_list.Visible = False
cb_reprint.Visible = False
cbx_cert_label.Visible = False //Alex Gerlants. 06/11/2019. Reprint cert label
dw_reprint_cert_label.Visible = False //Alex Gerlants. 06/11/2019. Reprint cert label
//Alex Gerlants. Reprint_Barcode_Button. 05/07/2019. End

end event

type cb_sleep_test from commandbutton within w_report_shipping
integer x = 1737
integer y = 13
integer width = 322
integer height = 61
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Sleep Test"
end type

event clicked;
String	ls_time_before, ls_time_after, ls_delay_ms
Long		ll_delay_ms

//ll_delay_ms = Long(sle_ms.Text)
ls_delay_ms = f_get_ini_value("ship_print_delay_ms", "variables", "delay_print", "200")
ll_delay_ms = Long(ls_delay_ms)

ls_time_before = String(Now(), "hh:mm:ss:fffff")

sleep_ms(ll_delay_ms)

ls_time_after = String(Now(), "hh:mm:ss:fffff")

MessageBox("Test", 	"ll_delay_ms = " + String(ll_delay_ms) + &
							"~n~rls_time_before: " + ls_time_before + &
							"~n~rls_time_after   : " + ls_time_after)
							


Long		ll_i, ll_coil_id, ll_job_id, ll_begin_wt2, ll_dw_2_object_wt, ll_end_wt2
String	ls_line_desc
DateTime	ldt_curr_date_time

For ll_i = 1 to 5
	Beep(1)
	sleep_ms(1000) //1 second (1000 milliseconds) delay
Next

ll_coil_id = 12345678
ll_job_id = 87654321
ls_line_desc = 'BL84'
ll_begin_wt2 = 123456
ll_dw_2_object_wt = 123456
ll_end_wt2 = 0
ldt_curr_date_time = DateTime(Today(), Now())

//For ll_i = 1 to 5
//	
//	insert into dbo.last_job_coil_wt_0ed_out
//			(coil_abc_num, ab_job_num, seq_num, curr_date_time,     line_desc,     begin_wt,      dw_2_object_wt,     end_wt)
//	values 
//			(:ll_coil_id, :ll_job_id,  :ll_i,  :ldt_curr_date_time, :ls_line_desc, :ll_begin_wt2, :ll_dw_2_object_wt, :ll_end_wt2)
//	using  sqlca;
//Next
//
//if sqlca.sqlcode = 0 Then
//	commit using sqlca;
//End If
end event

type dw_reprint_cert_label from datawindow within w_report_shipping
integer x = 3215
integer y = 2253
integer width = 77
integer height = 74
integer taborder = 110
string title = "none"
string dataobject = "d_reprint_cert_label"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cbx_cert_label from checkbox within w_report_shipping
integer x = 2889
integer y = 2256
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
string text = "Cert Label"
end type

type cb_reprint from commandbutton within w_report_shipping
integer x = 2586
integer y = 2246
integer width = 249
integer height = 74
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Reprint"
end type

event clicked;Long	ll_sheet_skid_num

ll_sheet_skid_num = dw_skids_4packing_list.Object.sheet_skid_num[1]

sleep(0.2)

If cbx_cert_label.Checked Then
	dw_reprint_cert_label.SetTransObject(sqlca)
	wf_reprint_cert_label(ll_sheet_skid_num)
Else
	dw_report.inv_abco_report.Dynamic of_printshippingreport_4skid(il_shipment, ll_sheet_skid_num)
End If

MessageBox("Info", "Done!")
Return 1
end event

type dw_skids_4packing_list from datawindow within w_report_shipping
integer x = 2209
integer y = 2243
integer width = 362
integer height = 83
integer taborder = 100
string title = "none"
string dataobject = "d_skids_4packing_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_package_num_4packing_list from datawindow within w_report_shipping
integer x = 3646
integer y = 147
integer width = 212
integer height = 320
integer taborder = 40
string title = "none"
string dataobject = "d_package_num_4packing_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;MessageBox("dberror event fordw _package_num_4packing_list", "sqldbcode = " + String(sqldbcode) + "~n~r" + &
				"sqlerrtext = " + sqlerrtext)

Return 1
end event

type cb_close from u_cb within w_report_shipping
integer x = 3321
integer y = 2246
integer width = 249
integer height = 74
integer taborder = 90
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;Close(Parent)
end event

type cb_setzoom from u_cb within w_report_shipping
integer x = 421
integer y = 2246
integer width = 249
integer height = 74
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "&SetZoom"
end type

event clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type cb_print from u_cb within w_report_shipping
integer x = 830
integer y = 2246
integer width = 249
integer height = 74
integer taborder = 60
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "&Print..."
end type

event clicked;Parent.Event pfc_print()


end event

type cb_reset from u_cb within w_report_shipping
integer x = 26
integer y = 2246
integer width = 249
integer height = 74
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "&Reset"
end type

event clicked;String ls_text, ls_modstring
Long ll_row, ll_i

IF IsNULL(ii_type) OR ii_type < 1 THEN RETURN 0

CONNECT USING SQLCA;
SELECT sh_report_type_id INTO :ii_type
FROM sh_report_type
WHERE sh_report_type_name = :is_typename
USING SQLCA;

RETURN wf_setreportobject()


end event

type st_1 from statictext within w_report_shipping
integer x = 29
integer y = 6
integer width = 461
integer height = 77
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Select report type:"
boolean focusrectangle = false
end type

type ddlb_type from dropdownlistbox within w_report_shipping
integer x = 479
integer y = 3
integer width = 823
integer height = 675
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;Boolean	lb_use_package_num //Alex Gerlants. 06/15/2018. Arconic_Package_Num
Long		ll_rows //Alex Gerlants. 06/15/2018. Arconic_Package_Num

Boolean	lb_cash_date_on_bol //Alex Gerlants. 08/21/2018. Add Cash Date 2BOL

SetPointer(HourGlass!)

String ls_text, ls_modstring
Long ll_row, ll_i

ls_text = Text(index)
is_typename = ls_text
IF Len(is_typename) < 2 THEN Return 0

CONNECT USING SQLCA;
SELECT sh_report_type_id INTO :ii_type
FROM sh_report_type
WHERE sh_report_type_name = :ls_text
USING SQLCA;

//Alex Gerlants. 06/15/2018. Arconic_Package_Num. Begin
f_get_use_package_num_4shipment(il_shipment, sqlca, lb_use_package_num)

If lb_use_package_num Then
	dw_detail.DataObject = "d_report_combi_sheet_pn"
	dw_detail.SetTransObject(sqlca)
End If
//Alex Gerlants. 06/15/2018. Arconic_Package_Num. End

//Alex Gerlants. 08/21/2018. Add Cash Date 2BOL. Begin
f_get_cash_date_on_bol_4shipmen(il_shipment, sqlca, lb_cash_date_on_bol)

If lb_cash_date_on_bol Then
	dw_detail.DataObject = "d_report_combi_sheet_cd"
	dw_detail.SetTransObject(sqlca)
End If
//Alex Gerlants. 08/21/2018. Add Cash Date 2BOL. End

RETURN wf_setreportobject()
end event

type dw_type from u_dw within w_report_shipping
boolean visible = false
integer x = 1401
integer y = 26
integer width = 128
integer height = 45
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_shipping_report_type"
end type

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

type dw_report from u_report_dw within w_report_shipping
integer x = 22
integer y = 83
integer width = 3547
integer height = 1859
integer taborder = 20
boolean bringtotop = true
boolean hscrollbar = true
boolean vscrollbar = false
boolean livescroll = false
end type

event losefocus;this.AcceptText()
This.ResetUpdate()
end event

event rbuttondown;//Override
RETURN 0
end event

event rbuttonup;//Override
RETURN 0
end event

type cb_setup from u_cb within w_report_shipping
integer x = 1265
integer y = 2246
integer width = 249
integer height = 74
integer taborder = 70
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "Set&up"
end type

event clicked;IF IsValid (dw_report.inv_abco_report) THEN
	dw_report.inv_abco_report.Dynamic of_setupreport()
END IF

end event

type cb_custom from u_cb within w_report_shipping
integer x = 1675
integer y = 2246
integer width = 428
integer height = 74
integer taborder = 80
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "U.S./CAN C&ustom"
end type

event clicked;OpenWithParm(w_report_customs, il_shipment)
end event

type dw_detail from u_dw within w_report_shipping
integer x = 22
integer y = 1949
integer width = 3547
integer height = 288
integer taborder = 11
string dataobject = "d_report_combi_sheet"
end type

event rbuttondown;//Override
RETURN 0
end event

event rbuttonup;call super::rbuttonup;//Override
RETURN 0
end event

event constructor;of_SetRowManager(TRUE)
of_SetSort(TRUE)
of_SetPrintPreview(FALSE)
SetTransObject(SQLCA)

end event

