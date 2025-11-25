$PBExportHeader$w_report_customer_skid_for_trans.srw
$PBExportComments$list all customer skid list for trans only
forward
global type w_report_customer_skid_for_trans from w_sheet
end type
type cb_export from u_cb within w_report_customer_skid_for_trans
end type
type dw_list from u_dw within w_report_customer_skid_for_trans
end type
type cb_close from u_cb within w_report_customer_skid_for_trans
end type
type gb_4 from u_gb within w_report_customer_skid_for_trans
end type
type gb_3 from u_gb within w_report_customer_skid_for_trans
end type
type rb_custall from u_rb within w_report_customer_skid_for_trans
end type
type rb_cust from u_rb within w_report_customer_skid_for_trans
end type
type rb_enduserall from u_rb within w_report_customer_skid_for_trans
end type
type rb_enduser from u_rb within w_report_customer_skid_for_trans
end type
type ddlb_cust from u_ddlb within w_report_customer_skid_for_trans
end type
type ddlb_enduser from u_ddlb within w_report_customer_skid_for_trans
end type
type dw_allcust from u_dw within w_report_customer_skid_for_trans
end type
type dw_customer from u_dw within w_report_customer_skid_for_trans
end type
type cb_retrieve from u_cb within w_report_customer_skid_for_trans
end type
type cb_select from u_cb within w_report_customer_skid_for_trans
end type
type cb_create from u_cb within w_report_customer_skid_for_trans
end type
type st_1 from statictext within w_report_customer_skid_for_trans
end type
type st_2 from statictext within w_report_customer_skid_for_trans
end type
type st_3 from statictext within w_report_customer_skid_for_trans
end type
type st_4 from statictext within w_report_customer_skid_for_trans
end type
type st_5 from statictext within w_report_customer_skid_for_trans
end type
type st_6 from statictext within w_report_customer_skid_for_trans
end type
type st_7 from statictext within w_report_customer_skid_for_trans
end type
type st_8 from statictext within w_report_customer_skid_for_trans
end type
type cbx_1 from checkbox within w_report_customer_skid_for_trans
end type
type cbx_2 from checkbox within w_report_customer_skid_for_trans
end type
type cbx_3 from checkbox within w_report_customer_skid_for_trans
end type
type cbx_4 from checkbox within w_report_customer_skid_for_trans
end type
type st_9 from statictext within w_report_customer_skid_for_trans
end type
type st_10 from statictext within w_report_customer_skid_for_trans
end type
type st_11 from statictext within w_report_customer_skid_for_trans
end type
type mle_s from multilineedit within w_report_customer_skid_for_trans
end type
type sle_1 from singlelineedit within w_report_customer_skid_for_trans
end type
type sle_2 from singlelineedit within w_report_customer_skid_for_trans
end type
type sle_3 from singlelineedit within w_report_customer_skid_for_trans
end type
type sle_6 from singlelineedit within w_report_customer_skid_for_trans
end type
type sle_7 from singlelineedit within w_report_customer_skid_for_trans
end type
type sle_8 from singlelineedit within w_report_customer_skid_for_trans
end type
type sle_4 from singlelineedit within w_report_customer_skid_for_trans
end type
type sle_5 from singlelineedit within w_report_customer_skid_for_trans
end type
type sle_9 from singlelineedit within w_report_customer_skid_for_trans
end type
type sle_10 from singlelineedit within w_report_customer_skid_for_trans
end type
type cb_undo from u_cb within w_report_customer_skid_for_trans
end type
end forward

global type w_report_customer_skid_for_trans from w_sheet
string tag = "ABCO production reports"
integer x = 4
integer y = 3
integer width = 2948
integer height = 1824
string title = "Inventory Report - Skid For Trans"
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
cb_export cb_export
dw_list dw_list
cb_close cb_close
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
cb_select cb_select
cb_create cb_create
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
st_6 st_6
st_7 st_7
st_8 st_8
cbx_1 cbx_1
cbx_2 cbx_2
cbx_3 cbx_3
cbx_4 cbx_4
st_9 st_9
st_10 st_10
st_11 st_11
mle_s mle_s
sle_1 sle_1
sle_2 sle_2
sle_3 sle_3
sle_6 sle_6
sle_7 sle_7
sle_8 sle_8
sle_4 sle_4
sle_5 sle_5
sle_9 sle_9
sle_10 sle_10
cb_undo cb_undo
end type
global w_report_customer_skid_for_trans w_report_customer_skid_for_trans

type variables
String is_cust
String is_enduser
String is_sql

end variables

forward prototypes
public function string wf_job_spec (long al_job)
public function string wf_search_terms ()
public function datastore wf_create_email ()
end prototypes

event ue_whoami;RETURN "w_report_customer_skid_for_trans"
end event

public function string wf_job_spec (long al_job);SetPointer(HourGlass!)

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

public function string wf_search_terms ();String ls_terms
Long ll_row, ll_i
Long ll_line, ll_cust, ll_enduser

ls_terms = is_sql
IF rb_cust.Checked THEN
	ll_row = dw_customer.RowCount()
	FOR ll_i = 1 TO ll_row
		IF dw_customer.GetItemString(ll_i, "customer_short_name") = is_cust THEN
			ll_cust = dw_customer.GetItemNumber(ll_i, "customer_id")
		END IF
	NEXT
	ls_terms = ls_terms + " and (~~~"CUSTOMER_ORDER~~~".~~~"ORIG_CUSTOMER_ID~~~" = " + String(ll_cust) + " )"
END IF

IF rb_enduser.Checked THEN
	ll_row = dw_allcust.RowCount()
	FOR ll_i = 1 TO ll_row
		IF dw_allcust.GetItemString(ll_i, "customer_short_name") = is_enduser THEN
			ll_enduser = dw_allcust.GetItemNumber(ll_i, "customer_id")
		END IF
	NEXT
	ls_terms = ls_terms +  " and ( ~~~"CUSTOMER_ORDER~~~".~~~"ENDUSER_ID~~~" = " + String(ll_enduser) + " )"
END IF

RETURN ls_terms
end function

public function datastore wf_create_email ();String ls_mail,ls_temp
Long ll_row, ll_i, ll_tpc
n_ds ids_datastore

ids_datastore = CREATE n_ds
ids_datastore.DataObject = "d_email_datastore"
ids_datastore.Reset()
ids_datastore.of_SetBase(TRUE)

//Generate Header Info.
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "email_line",&
              "ALUMINUM BLANKING Co.") 
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "email_line",&
              "PONTIAC, MI. 48340") 
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "email_line",&
              "FAX: (248) 588 - 9779") 
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "email_line",&
              "PHONE: (248) 588 - 4422 ") 
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "email_line",&
              " ") 
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "email_line",&
              "TO: " + sle_1.Text + "   " + "ATTN: " + sle_2.Text + " ") 
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "email_line",&
              " ") 
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "email_line",&
					"FROM: " + sle_3.Text + "   " +"DATE: " + sle_4.Text + "   " + "TIME: " + sle_5.Text + " ") 			  
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "email_line",&
              " ") 
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "email_line",&
					"MATERIAL READY TO SHIP FOR: " + sle_6.Text + " ")
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "email_line",&
					"                   ADDRESS: " + sle_7.Text + " " )
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "email_line",&
					"                CITY/STATE: " + sle_8.Text + " " )
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "email_line",&
              " ") 
ls_temp =  "         "
IF cbx_1.Checked THEN
	ls_temp = "___X___Original    "
ELSE
	ls_temp = "_______Original    "
END IF
IF cbx_2.Checked THEN
	ls_temp = ls_temp + "___X___Rev 1   "
ELSE
	ls_temp = ls_temp + "_______Rev 1   "
END IF
IF cbx_3.Checked THEN
	ls_temp = ls_temp + "___X___Rev 2   "
ELSE
	ls_temp = ls_temp + "_______Rev 2   "
END IF
IF cbx_4.Checked THEN
	ls_temp = ls_temp + "___X___Rev 3   "
ELSE
	ls_temp = ls_temp + "_______Rev 3   "
END IF
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "email_line", ls_temp + " " )
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "email_line",&
              " ") 
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "email_line",&
					"DOI/CENTURY NUMBER	CUSTOMER PO.	#SKIDS	GROSS WEIGHT	DESCRIPTION" + " ")
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "email_line",&
					"--------------------------------------------------------------------------------------------------------------------------------------------" + " ")					
//skid info
ll_row = dw_list.RowCount()
IF ll_row > 0 THEN
	ll_tpc = 0
	FOR ll_i = 1 TO ll_row
		IF dw_list.GetItemString(ll_i, "ct_select",Primary!, FALSE) =  "X" THEN
			ls_temp = dw_list.GetItemString(ll_i, "customer_order_orig_customer_po")
			ls_temp = ls_temp + "   " + dw_list.GetItemString(ll_i, "customer_order_enduser_po")
			ls_temp = ls_temp + "   " + String(dw_list.GetItemNumber(ll_i, "ct_skids"), "###,###,###")
			ls_temp = ls_temp + "   " + String(dw_list.GetItemNumber(ll_i, "ct_grosswt"), "###,###,###")
			ls_temp = ls_temp + "   " + dw_list.GetItemString(ll_i, "ct_desc")
			ls_temp = ls_temp + "   PART NO: " + dw_list.GetItemString(ll_i, "order_item_enduser_part_num")
			ls_temp = ls_temp + "   " + String(dw_list.GetItemNumber(ll_i, "ct_pcs"), "###,###,###") + " PCs"
			ls_temp = ls_temp + "   (" + String(dw_list.GetItemNumber(ll_i, "ab_job_ab_job_num")) + ") "
			ll_tpc = ll_tpc + dw_list.GetItemNumber(ll_i, "ct_pcs") 
			ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "email_line", ls_temp + " " )
		END IF
	NEXT
	IF ll_tpc > 0 THEN
		ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "email_line", " ") 
		ls_temp = "          TOTAL: " + String(ll_tpc, "###,###,###") + " PCs"
		ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "email_line", ls_temp + " " )
	END IF
END IF

//end of skid info
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "email_line",&
					"--------------------------------------------------------------------------------------------------------------------------------------------" + " ")					
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "email_line",&
              " ") 
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "email_line",&
					"SHIP DATE: " + sle_9.Text + "       " + "TRUCKING COMPANY: " + sle_10.Text + " ")
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "email_line",&
              " ") 
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "email_line",&
					"SPECIAL INSTRUCTIONS:" + " ")
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "email_line",mle_s.Text + " ")
								
RETURN ids_datastore

end function

on w_report_customer_skid_for_trans.create
int iCurrent
call super::create
this.cb_export=create cb_export
this.dw_list=create dw_list
this.cb_close=create cb_close
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
this.cb_select=create cb_select
this.cb_create=create cb_create
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.st_8=create st_8
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
this.cbx_3=create cbx_3
this.cbx_4=create cbx_4
this.st_9=create st_9
this.st_10=create st_10
this.st_11=create st_11
this.mle_s=create mle_s
this.sle_1=create sle_1
this.sle_2=create sle_2
this.sle_3=create sle_3
this.sle_6=create sle_6
this.sle_7=create sle_7
this.sle_8=create sle_8
this.sle_4=create sle_4
this.sle_5=create sle_5
this.sle_9=create sle_9
this.sle_10=create sle_10
this.cb_undo=create cb_undo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_export
this.Control[iCurrent+2]=this.dw_list
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.gb_4
this.Control[iCurrent+5]=this.gb_3
this.Control[iCurrent+6]=this.rb_custall
this.Control[iCurrent+7]=this.rb_cust
this.Control[iCurrent+8]=this.rb_enduserall
this.Control[iCurrent+9]=this.rb_enduser
this.Control[iCurrent+10]=this.ddlb_cust
this.Control[iCurrent+11]=this.ddlb_enduser
this.Control[iCurrent+12]=this.dw_allcust
this.Control[iCurrent+13]=this.dw_customer
this.Control[iCurrent+14]=this.cb_retrieve
this.Control[iCurrent+15]=this.cb_select
this.Control[iCurrent+16]=this.cb_create
this.Control[iCurrent+17]=this.st_1
this.Control[iCurrent+18]=this.st_2
this.Control[iCurrent+19]=this.st_3
this.Control[iCurrent+20]=this.st_4
this.Control[iCurrent+21]=this.st_5
this.Control[iCurrent+22]=this.st_6
this.Control[iCurrent+23]=this.st_7
this.Control[iCurrent+24]=this.st_8
this.Control[iCurrent+25]=this.cbx_1
this.Control[iCurrent+26]=this.cbx_2
this.Control[iCurrent+27]=this.cbx_3
this.Control[iCurrent+28]=this.cbx_4
this.Control[iCurrent+29]=this.st_9
this.Control[iCurrent+30]=this.st_10
this.Control[iCurrent+31]=this.st_11
this.Control[iCurrent+32]=this.mle_s
this.Control[iCurrent+33]=this.sle_1
this.Control[iCurrent+34]=this.sle_2
this.Control[iCurrent+35]=this.sle_3
this.Control[iCurrent+36]=this.sle_6
this.Control[iCurrent+37]=this.sle_7
this.Control[iCurrent+38]=this.sle_8
this.Control[iCurrent+39]=this.sle_4
this.Control[iCurrent+40]=this.sle_5
this.Control[iCurrent+41]=this.sle_9
this.Control[iCurrent+42]=this.sle_10
this.Control[iCurrent+43]=this.cb_undo
end on

on w_report_customer_skid_for_trans.destroy
call super::destroy
destroy(this.cb_export)
destroy(this.dw_list)
destroy(this.cb_close)
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
destroy(this.cb_select)
destroy(this.cb_create)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.cbx_1)
destroy(this.cbx_2)
destroy(this.cbx_3)
destroy(this.cbx_4)
destroy(this.st_9)
destroy(this.st_10)
destroy(this.st_11)
destroy(this.mle_s)
destroy(this.sle_1)
destroy(this.sle_2)
destroy(this.sle_3)
destroy(this.sle_6)
destroy(this.sle_7)
destroy(this.sle_8)
destroy(this.sle_4)
destroy(this.sle_5)
destroy(this.sle_9)
destroy(this.sle_10)
destroy(this.cb_undo)
end on

event open;call super::open;Long ll_row, ll_c

dw_list.SetTransObject(SQLCA)
is_sql = dw_list.Describe("DataWindow.Table.Select")
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









end event

event pfc_print;RETURN dw_list.Event pfc_print()
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

type cb_export from u_cb within w_report_customer_skid_for_trans
integer x = 1569
integer y = 1632
integer width = 406
integer height = 77
integer taborder = 80
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

ls_file = ProfileString(gs_ini_file, "EMAIL","email_out","c:\temp")+'\Customer Skid for Trans Report_' + ls_today + ls_now + ".xls"
If dw_list.SaveAs(ls_file, Excel8!, True) = -1 Then //Alex Gerlants. 04/20/2016
   MessageBox("Data SaveAs", "Error")
	Return -1
Else
	MessageBox("Success", "Data have been successfully exported to " + ls_file)
End If

Return 1
end event

type dw_list from u_dw within w_report_customer_skid_for_trans
event ue_specs ( )
event ue_retrieve ( )
integer x = 22
integer y = 669
integer width = 2611
integer height = 605
integer taborder = 10
string dataobject = "d_report_inv_cust_skids_for_trans"
boolean hscrollbar = true
end type

event ue_specs;Long ll_row, ll_c
Long ll_job, ll_skids, ll_grosswt, ll_pcs

ll_row = this.RowCount()
IF ll_row > 0 THEN
	FOR ll_c = 1 TO ll_row
		ll_job = this.GetItemNumber(ll_c, "ab_job_ab_job_num")
		this.SetItem(ll_c, "ct_desc", wf_job_spec(ll_job))
		ll_skids = 0
		ll_grosswt = 0
		ll_pcs = 0
		CONNECT USING SQLCA;
		SELECT COUNT(sheet_skid_num), SUM(sheet_net_wt)+ SUM(sheet_tare_wt), SUM(skid_pieces) INTO :ll_skids, :ll_grosswt, :ll_pcs
		FROM sheet_skid
		WHERE ab_job_num = :ll_job and skid_sheet_status = 2
		USING SQLCA;
		this.SetItem(ll_c, "ct_skids", ll_skids)
		this.SetItem(ll_c, "ct_grosswt", ll_grosswt)
		this.SetItem(ll_c, "ct_pcs", ll_pcs)
	NEXT
END IF
this.ResetUpdate()

end event

event ue_retrieve;String ls_modify, ls_rc

IF rb_custall.checked and rb_enduserall.checked THEN
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
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

SetTransObject(SQLCA)

end event

type cb_close from u_cb within w_report_customer_skid_for_trans
string tag = "Exit"
integer x = 2081
integer y = 1632
integer width = 322
integer height = 74
integer taborder = 210
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type gb_4 from u_gb within w_report_customer_skid_for_trans
integer x = 1441
integer y = 6
integer width = 1452
integer height = 208
integer taborder = 0
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "End User"
end type

type gb_3 from u_gb within w_report_customer_skid_for_trans
integer x = 22
integer y = 6
integer width = 1401
integer height = 208
integer taborder = 0
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Customer"
end type

type rb_custall from u_rb within w_report_customer_skid_for_trans
integer x = 59
integer y = 51
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "All"
boolean checked = true
end type

event clicked;IF this.Checked THEN 
	ddlb_cust.Enabled = FALSE
ELSE
	ddlb_cust.Enabled = TRUE
END IF

//dw_list.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.
RETURN 1
end event

type rb_cust from u_rb within w_report_customer_skid_for_trans
integer x = 59
integer y = 118
integer width = 241
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Show"
end type

event clicked;IF this.Checked THEN 
	ddlb_cust.Enabled = TRUE
ELSE
	ddlb_cust.Enabled = FALSE
END IF

RETURN 1

end event

type rb_enduserall from u_rb within w_report_customer_skid_for_trans
integer x = 1488
integer y = 51
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

//dw_list.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.
RETURN 1

end event

type rb_enduser from u_rb within w_report_customer_skid_for_trans
integer x = 1488
integer y = 118
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

RETURN 1

end event

type ddlb_cust from u_ddlb within w_report_customer_skid_for_trans
integer x = 260
integer y = 118
integer width = 1130
integer height = 992
integer taborder = 20
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
dw_list.SetTransObject(SQLCA)

//dw_list.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.

RETURN 1


end event

type ddlb_enduser from u_ddlb within w_report_customer_skid_for_trans
integer x = 1697
integer y = 118
integer width = 1145
integer height = 1059
integer taborder = 30
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
dw_list.SetTransObject(SQLCA)

//dw_list.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.

RETURN 1


end event

type dw_allcust from u_dw within w_report_customer_skid_for_trans
boolean visible = false
integer x = 2450
integer y = 1635
integer width = 91
integer height = 51
integer taborder = 70
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

type dw_customer from u_dw within w_report_customer_skid_for_trans
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

type cb_retrieve from u_cb within w_report_customer_skid_for_trans
integer x = 655
integer y = 1632
integer width = 307
integer height = 74
integer taborder = 190
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Retrieve"
end type

event clicked;dw_list.Event ue_retrieve()
Return 1
end event

type cb_select from u_cb within w_report_customer_skid_for_trans
integer x = 2644
integer y = 717
integer width = 263
integer height = 74
integer taborder = 140
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Select"
end type

event clicked;Long ll_row
ll_row = dw_list.GetRow()
IF ll_row > 0 THEN
	dw_list.SetItem(ll_row, "ct_select", "X")
END IF
dw_list.ResetUpdate()
end event

type cb_create from u_cb within w_report_customer_skid_for_trans
string tag = "Create E-mail"
integer x = 1097
integer y = 1632
integer width = 351
integer height = 74
integer taborder = 200
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Create &Email"
end type

event clicked;OpenWithParm(w_email_customer_trans, wf_create_email())
RETURN 1
end event

type st_1 from statictext within w_report_customer_skid_for_trans
integer x = 22
integer y = 221
integer width = 106
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
string text = "TO:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_report_customer_skid_for_trans
integer x = 1781
integer y = 221
integer width = 143
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
string text = "ATTN:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_report_customer_skid_for_trans
integer x = 22
integer y = 294
integer width = 165
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
string text = "FROM:"
boolean focusrectangle = false
end type

type st_4 from statictext within w_report_customer_skid_for_trans
integer x = 991
integer y = 301
integer width = 165
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
string text = "DATE:"
boolean focusrectangle = false
end type

type st_5 from statictext within w_report_customer_skid_for_trans
integer x = 1774
integer y = 291
integer width = 165
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
string text = "TIME:"
boolean focusrectangle = false
end type

type st_6 from statictext within w_report_customer_skid_for_trans
integer x = 22
integer y = 365
integer width = 753
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
string text = "MATERIAL READY TO SHIP FOR:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_7 from statictext within w_report_customer_skid_for_trans
integer x = 22
integer y = 432
integer width = 753
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
string text = "ADDRESS:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_8 from statictext within w_report_customer_skid_for_trans
integer x = 22
integer y = 502
integer width = 753
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
string text = "CITY/STATE:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cbx_1 from checkbox within w_report_customer_skid_for_trans
integer x = 278
integer y = 586
integer width = 252
integer height = 77
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Original"
end type

type cbx_2 from checkbox within w_report_customer_skid_for_trans
integer x = 823
integer y = 586
integer width = 252
integer height = 77
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Rev 1"
end type

type cbx_3 from checkbox within w_report_customer_skid_for_trans
integer x = 1401
integer y = 586
integer width = 252
integer height = 77
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Rev 2"
end type

type cbx_4 from checkbox within w_report_customer_skid_for_trans
integer x = 1927
integer y = 586
integer width = 252
integer height = 77
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Rev 3"
end type

type st_9 from statictext within w_report_customer_skid_for_trans
integer x = 33
integer y = 1280
integer width = 274
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
string text = "SHIP DATE:"
boolean focusrectangle = false
end type

type st_10 from statictext within w_report_customer_skid_for_trans
integer x = 1046
integer y = 1283
integer width = 519
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
string text = "TRUCKING COMPANY:"
boolean focusrectangle = false
end type

type st_11 from statictext within w_report_customer_skid_for_trans
integer x = 29
integer y = 1350
integer width = 581
integer height = 58
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
string text = "SPECIAL INSTRUCTIONS:"
boolean focusrectangle = false
end type

type mle_s from multilineedit within w_report_customer_skid_for_trans
integer x = 29
integer y = 1414
integer width = 2864
integer height = 205
integer taborder = 180
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_report_customer_skid_for_trans
integer x = 128
integer y = 221
integer width = 1609
integer height = 67
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_2 from singlelineedit within w_report_customer_skid_for_trans
integer x = 1931
integer y = 221
integer width = 962
integer height = 67
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_3 from singlelineedit within w_report_customer_skid_for_trans
integer x = 179
integer y = 291
integer width = 790
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
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_6 from singlelineedit within w_report_customer_skid_for_trans
integer x = 790
integer y = 362
integer width = 2103
integer height = 67
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_7 from singlelineedit within w_report_customer_skid_for_trans
integer x = 790
integer y = 432
integer width = 2103
integer height = 67
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_8 from singlelineedit within w_report_customer_skid_for_trans
integer x = 790
integer y = 502
integer width = 2103
integer height = 67
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_4 from singlelineedit within w_report_customer_skid_for_trans
integer x = 1148
integer y = 291
integer width = 592
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
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_5 from singlelineedit within w_report_customer_skid_for_trans
integer x = 1927
integer y = 291
integer width = 965
integer height = 67
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_9 from singlelineedit within w_report_customer_skid_for_trans
integer x = 311
integer y = 1277
integer width = 720
integer height = 67
integer taborder = 160
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_10 from singlelineedit within w_report_customer_skid_for_trans
integer x = 1562
integer y = 1277
integer width = 1331
integer height = 67
integer taborder = 170
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_undo from u_cb within w_report_customer_skid_for_trans
integer x = 2644
integer y = 1014
integer width = 263
integer height = 74
integer taborder = 150
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Unselect"
end type

event clicked;Long ll_row
ll_row = dw_list.GetRow()
IF ll_row > 0 THEN
	dw_list.SetItem(ll_row, "ct_select", " ")
END IF
dw_list.ResetUpdate()
end event

