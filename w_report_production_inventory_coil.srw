$PBExportHeader$w_report_production_inventory_coil.srw
$PBExportComments$production inventory report based on different customers on Coil only
forward
global type w_report_production_inventory_coil from w_sheet
end type
type dw_report from u_dw within w_report_production_inventory_coil
end type
type cb_print from u_cb within w_report_production_inventory_coil
end type
type cb_close from u_cb within w_report_production_inventory_coil
end type
type cb_setzoom from u_cb within w_report_production_inventory_coil
end type
type gb_5 from u_gb within w_report_production_inventory_coil
end type
type gb_4 from u_gb within w_report_production_inventory_coil
end type
type gb_3 from u_gb within w_report_production_inventory_coil
end type
type gb_2 from u_gb within w_report_production_inventory_coil
end type
type gb_1 from u_gb within w_report_production_inventory_coil
end type
type rb_lineall from u_rb within w_report_production_inventory_coil
end type
type rb_line from u_rb within w_report_production_inventory_coil
end type
type rb_dateall from u_rb within w_report_production_inventory_coil
end type
type rb_date from u_rb within w_report_production_inventory_coil
end type
type rb_custall from u_rb within w_report_production_inventory_coil
end type
type rb_cust from u_rb within w_report_production_inventory_coil
end type
type rb_enduserall from u_rb within w_report_production_inventory_coil
end type
type rb_enduser from u_rb within w_report_production_inventory_coil
end type
type ddlb_line from u_ddlb within w_report_production_inventory_coil
end type
type em_from from u_em within w_report_production_inventory_coil
end type
type em_to from u_em within w_report_production_inventory_coil
end type
type st_1 from statictext within w_report_production_inventory_coil
end type
type ddlb_cust from u_ddlb within w_report_production_inventory_coil
end type
type ddlb_enduser from u_ddlb within w_report_production_inventory_coil
end type
type dw_allcust from u_dw within w_report_production_inventory_coil
end type
type dw_customer from u_dw within w_report_production_inventory_coil
end type
type cb_retrieve from u_cb within w_report_production_inventory_coil
end type
type dw_line from u_dw within w_report_production_inventory_coil
end type
type rb_statusall from u_rb within w_report_production_inventory_coil
end type
type rb_status from u_rb within w_report_production_inventory_coil
end type
type ddlb_status from u_ddlb within w_report_production_inventory_coil
end type
type cb_email from u_cb within w_report_production_inventory_coil
end type
end forward

global type w_report_production_inventory_coil from w_sheet
string tag = "ABCO production reports"
integer x = 4
integer y = 3
integer height = 1837
string title = "Production Coils Report"
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
dw_report dw_report
cb_print cb_print
cb_close cb_close
cb_setzoom cb_setzoom
gb_5 gb_5
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
rb_lineall rb_lineall
rb_line rb_line
rb_dateall rb_dateall
rb_date rb_date
rb_custall rb_custall
rb_cust rb_cust
rb_enduserall rb_enduserall
rb_enduser rb_enduser
ddlb_line ddlb_line
em_from em_from
em_to em_to
st_1 st_1
ddlb_cust ddlb_cust
ddlb_enduser ddlb_enduser
dw_allcust dw_allcust
dw_customer dw_customer
cb_retrieve cb_retrieve
dw_line dw_line
rb_statusall rb_statusall
rb_status rb_status
ddlb_status ddlb_status
cb_email cb_email
end type
global w_report_production_inventory_coil w_report_production_inventory_coil

type variables
String is_line
String is_status
String is_cust
String is_enduser
String is_desc
end variables

forward prototypes
public function string wf_job_spec (long al_job)
public function string wf_search_terms ()
public subroutine wf_settitle ()
end prototypes

event ue_whoami;RETURN "w_report_production_inventory_coil"
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

public function string wf_search_terms ();String ls_terms, ls_sort, ls_s
Long ll_row, ll_i
Long ll_line, ll_cust, ll_enduser, ll_status

ls_s = is_desc
IF rb_line.Checked THEN
	ll_row = dw_line.RowCount()
	FOR ll_i = 1 TO ll_row
		IF dw_line.GetItemString(ll_i, "line_desc") = is_line THEN
			ll_line = dw_line.GetItemNumber(ll_i, "line_num")
		END IF
	NEXT
	ls_s = ls_s + " and ( ~~~"AB_JOB~~~".~~~"LINE_NUM~~~" = " + String(ll_line) + " )"
END IF

IF rb_date.Checked THEN
	ls_s = ls_s + " and (TO_DATE(TO_CHAR(~~~"AB_JOB~~~".~~~"TIME_DATE_STARTED~~~",~~~'DD-MON-YYYY~~~'),~~~'DD-MON-YYYY~~~'  ) >= " + " TO_DATE(~~~'" + em_from.Text + "~~~',~~~'mm/dd/yyyy~~~' )" + " )"  
	ls_s = ls_s + " and (TO_DATE(TO_CHAR(~~~"AB_JOB~~~".~~~"TIME_DATE_STARTED~~~",~~~'DD-MON-YYYY~~~'),~~~'DD-MON-YYYY~~~'  )  <= " + " TO_DATE(~~~'" + em_to.Text + "~~~',~~~'mm/dd/yyyy~~~' )" + " )"  //21-DEC-1998 format
END IF

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

IF rb_status.Checked THEN
	CHOOSE CASE UPPER(Trim(is_status))
		CASE "DONE"
			ll_status = 0
		CASE "INPROCESS"
			ll_status = 1
//		CASE "NEW"
//			ll_status = 2
		CASE "CANCELED"
			ll_status = 3
		CASE "ONHOLD"
			ll_status = 4
	END CHOOSE
	ls_s = ls_s + " and ( ~~~"AB_JOB~~~".~~~"JOB_STATUS~~~" = " + String(ll_status) + " )"
END IF

//ls_sort = " ORDER BY ~~~"LINE~~~".~~~"MAX_WIDTH~~~" ASC,   ~~~"AB_JOB~~~".~~~"TIME_DATE_STARTED~~~" ASC "

ls_terms = ls_terms + ls_s + ls_sort

RETURN ls_terms
end function

public subroutine wf_settitle ();String ls_modstring,ls_s
Long ll_c

IF rb_lineall.Checked THEN
	ls_s = "ALL"		
ELSE
	ls_s = is_line
END IF

ls_modstring = "line_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 

IF rb_statusall.Checked THEN
	ls_s = "ALL"		
ELSE
	ls_s = is_status
END IF

ls_modstring = "status_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 

IF rb_dateall.Checked THEN
	ls_s = "ALL"		
ELSE
	ls_s = em_from.Text + " - " + em_to.Text
END IF

ls_modstring = "date_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 

IF rb_enduserall.Checked THEN
	ls_s = "ALL"		
ELSE
	ls_s = is_enduser
END IF

ls_modstring = "enduser_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 

IF rb_custall.Checked THEN
	ls_s = "ABCO Customer Production Coil Report" 	
ELSE
	ls_s = Trim(is_cust) + " Production Coil Report"
END IF	

ls_modstring = "title_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 


end subroutine

on w_report_production_inventory_coil.create
int iCurrent
call super::create
this.dw_report=create dw_report
this.cb_print=create cb_print
this.cb_close=create cb_close
this.cb_setzoom=create cb_setzoom
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.rb_lineall=create rb_lineall
this.rb_line=create rb_line
this.rb_dateall=create rb_dateall
this.rb_date=create rb_date
this.rb_custall=create rb_custall
this.rb_cust=create rb_cust
this.rb_enduserall=create rb_enduserall
this.rb_enduser=create rb_enduser
this.ddlb_line=create ddlb_line
this.em_from=create em_from
this.em_to=create em_to
this.st_1=create st_1
this.ddlb_cust=create ddlb_cust
this.ddlb_enduser=create ddlb_enduser
this.dw_allcust=create dw_allcust
this.dw_customer=create dw_customer
this.cb_retrieve=create cb_retrieve
this.dw_line=create dw_line
this.rb_statusall=create rb_statusall
this.rb_status=create rb_status
this.ddlb_status=create ddlb_status
this.cb_email=create cb_email
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_report
this.Control[iCurrent+2]=this.cb_print
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.cb_setzoom
this.Control[iCurrent+5]=this.gb_5
this.Control[iCurrent+6]=this.gb_4
this.Control[iCurrent+7]=this.gb_3
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.rb_lineall
this.Control[iCurrent+11]=this.rb_line
this.Control[iCurrent+12]=this.rb_dateall
this.Control[iCurrent+13]=this.rb_date
this.Control[iCurrent+14]=this.rb_custall
this.Control[iCurrent+15]=this.rb_cust
this.Control[iCurrent+16]=this.rb_enduserall
this.Control[iCurrent+17]=this.rb_enduser
this.Control[iCurrent+18]=this.ddlb_line
this.Control[iCurrent+19]=this.em_from
this.Control[iCurrent+20]=this.em_to
this.Control[iCurrent+21]=this.st_1
this.Control[iCurrent+22]=this.ddlb_cust
this.Control[iCurrent+23]=this.ddlb_enduser
this.Control[iCurrent+24]=this.dw_allcust
this.Control[iCurrent+25]=this.dw_customer
this.Control[iCurrent+26]=this.cb_retrieve
this.Control[iCurrent+27]=this.dw_line
this.Control[iCurrent+28]=this.rb_statusall
this.Control[iCurrent+29]=this.rb_status
this.Control[iCurrent+30]=this.ddlb_status
this.Control[iCurrent+31]=this.cb_email
end on

on w_report_production_inventory_coil.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.cb_print)
destroy(this.cb_close)
destroy(this.cb_setzoom)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.rb_lineall)
destroy(this.rb_line)
destroy(this.rb_dateall)
destroy(this.rb_date)
destroy(this.rb_custall)
destroy(this.rb_cust)
destroy(this.rb_enduserall)
destroy(this.rb_enduser)
destroy(this.ddlb_line)
destroy(this.em_from)
destroy(this.em_to)
destroy(this.st_1)
destroy(this.ddlb_cust)
destroy(this.ddlb_enduser)
destroy(this.dw_allcust)
destroy(this.dw_customer)
destroy(this.cb_retrieve)
destroy(this.dw_line)
destroy(this.rb_statusall)
destroy(this.rb_status)
destroy(this.ddlb_status)
destroy(this.cb_email)
end on

event open;call super::open;Long ll_row, ll_c
String ls_spec
Long ll_job, ll_bal_due

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
ll_row = dw_line.RowCount()
IF ll_row > 0 THEN 
	FOR ll_c = 1 TO ll_row
		ddlb_line.AddItem(dw_line.GetItemString(ll_c, "line_desc"))
	NEXT
END IF

wf_settitle()

is_desc = dw_report.Describe("DataWindow.Table.Select")







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

type dw_report from u_dw within w_report_production_inventory_coil
event ue_specs ( )
event ue_retrieve ( )
integer x = 11
integer y = 426
integer width = 2081
integer height = 1293
integer taborder = 10
string dataobject = "d_report_prd_abc_allcoil"
boolean hscrollbar = true
end type

event ue_specs;SetPointer(HourGlass!)

Long ll_row, ll_c
Long ll_job, ll_coil, ll_coil_wt, ll_net_bal, ll_ps_wt, ll_qc_wt, ll_pc_wt, ll_rej_coil_wt, ll_scrap_wt
Int li_coil_status

ll_row = this.RowCount()
IF ll_row > 0 THEN
	FOR ll_c = 1 TO ll_row
		ll_job = dw_report.GetItemNumber(ll_c, "ab_job_ab_job_num")
		ll_coil = dw_report.GetItemNumber( ll_c, "process_coil_coil_abc_num")
		ll_coil_wt = dw_report.GetItemNumber( ll_c, "coil_net_wt")
		IF IsNULL(ll_coil_wt) THEN ll_coil_wt = 0
		ll_net_bal = dw_report.GetItemNumber( ll_c, "coil_net_wt_balance")
		IF IsNULL(ll_net_bal) THEN ll_net_bal = 0
		li_coil_status = dw_report.GetItemNumber( ll_c, "coil_coil_status")
		ll_ps_wt = 0
		ll_qc_wt = 0
		ll_pc_wt = 0
		ll_rej_coil_wt = 0		
		SELECT SUM(prod_item_net_wt) INTO :ll_ps_wt
		FROM production_sheet_item
		WHERE ab_job_num = :ll_job AND coil_abc_num = :ll_coil  // total sheet
		USING SQLCA;
		IF IsNULL(ll_ps_wt) THEN ll_ps_wt = 0
		SELECT SUM(prod_item_net_wt) INTO :ll_qc_wt
		FROM production_sheet_item
		WHERE ab_job_num = :ll_job AND coil_abc_num = :ll_coil AND prod_item_status = 4  //on hold sheet
		USING SQLCA;
		IF IsNULL(ll_qc_wt) THEN ll_qc_wt = 0
		ll_ps_wt -= ll_qc_wt
		IF li_coil_status = 3 THEN  //reject coil
			ll_rej_coil_wt = ll_net_bal 
			ll_pc_wt = 0
		ELSE
			ll_pc_wt = ll_net_bal
			ll_rej_coil_wt = 0
		END IF
		ll_scrap_wt = ll_coil_wt - ll_net_bal - ll_ps_wt - ll_qc_wt
		IF ll_scrap_wt < 0 THEN ll_scrap_wt = 0
		
		dw_report.SetItem(ll_c, "cps_t", ll_ps_wt)
		dw_report.SetItem(ll_c, "coil_net_wt_balance", ll_pc_wt)
		dw_report.SetItem(ll_c, "cqc_t", ll_qc_wt)
		dw_report.SetItem(ll_c, "crejcoil_t", ll_rej_coil_wt)
		dw_report.SetItem(ll_c, "cscrap_t", ll_scrap_wt)
	NEXT
END IF
this.ResetUpdate()

end event

event ue_retrieve;String ls_modify, ls_rc

IF rb_custall.checked and rb_enduserall.checked  and rb_dateall.Checked THEN
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

type cb_print from u_cb within w_report_production_inventory_coil
integer x = 2117
integer y = 1027
integer width = 307
integer height = 74
integer taborder = 180
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;Parent.Event pfc_print()
end event

type cb_close from u_cb within w_report_production_inventory_coil
string tag = "Exit"
integer x = 2117
integer y = 1578
integer width = 322
integer height = 74
integer taborder = 190
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_setzoom from u_cb within w_report_production_inventory_coil
integer x = 2117
integer y = 752
integer width = 307
integer height = 74
integer taborder = 170
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&SetZoom"
end type

event clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type gb_5 from u_gb within w_report_production_inventory_coil
integer x = 1763
integer y = 3
integer width = 662
integer height = 208
integer taborder = 50
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Job Status"
end type

type gb_4 from u_gb within w_report_production_inventory_coil
integer x = 1145
integer y = 214
integer width = 1280
integer height = 208
integer taborder = 140
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "End User"
end type

type gb_3 from u_gb within w_report_production_inventory_coil
integer x = 7
integer y = 214
integer width = 1119
integer height = 208
integer taborder = 150
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Customer"
end type

type gb_2 from u_gb within w_report_production_inventory_coil
integer x = 823
integer y = 3
integer width = 911
integer height = 208
integer taborder = 130
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Starting Date"
end type

type gb_1 from u_gb within w_report_production_inventory_coil
integer x = 4
integer width = 794
integer height = 208
integer taborder = 160
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Line"
end type

type rb_lineall from u_rb within w_report_production_inventory_coil
integer x = 22
integer y = 51
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "All"
boolean checked = true
end type

event clicked;IF this.Checked THEN
	ddlb_line.Enabled = FALSE
ELSE
	ddlb_line.Enabled = TRUE
END IF

dw_report.SetTransObject(SQLCA)
wf_settitle()

//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.
RETURN 1


end event

type rb_line from u_rb within w_report_production_inventory_coil
integer x = 26
integer y = 118
integer width = 216
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Line"
end type

event clicked;IF this.Checked THEN 
	ddlb_line.Enabled = TRUE
ELSE
	ddlb_line.Enabled = FALSE
END IF
dw_report.SetTransObject(SQLCA)
wf_settitle()

//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.
RETURN 1

end event

type rb_dateall from u_rb within w_report_production_inventory_coil
integer x = 834
integer y = 54
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

type rb_date from u_rb within w_report_production_inventory_coil
integer x = 837
integer y = 118
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "From "
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

type rb_custall from u_rb within w_report_production_inventory_coil
integer x = 26
integer y = 269
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "All"
boolean checked = true
end type

event clicked;IF this.Checked THEN
	ddlb_cust.Enabled = FALSE
	dw_report.DataObject = "d_report_prd_abc_allcoil" 
ELSE
	ddlb_cust.Enabled = TRUE
	dw_report.DataObject = "d_report_prd_cust_allcoil" 
END IF

dw_report.SetTransObject(SQLCA)
is_desc = dw_report.Describe("DataWindow.Table.Select")
wf_settitle()

//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.
RETURN 1


end event

type rb_cust from u_rb within w_report_production_inventory_coil
integer x = 26
integer y = 336
integer width = 241
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Show"
end type

event clicked;IF this.Checked THEN
	ddlb_cust.Enabled = TRUE
	dw_report.DataObject = "d_report_prd_cust_allcoil" 
ELSE
	ddlb_cust.Enabled = FALSE
	dw_report.DataObject = "d_report_prd_abc_allcoil" 
END IF

dw_report.SetTransObject(SQLCA)
is_desc = dw_report.Describe("DataWindow.Table.Select")
wf_settitle()

//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.
RETURN 1

end event

type rb_enduserall from u_rb within w_report_production_inventory_coil
integer x = 1163
integer y = 269
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

type rb_enduser from u_rb within w_report_production_inventory_coil
integer x = 1163
integer y = 336
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
//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.
RETURN 1
end event

type ddlb_line from u_ddlb within w_report_production_inventory_coil
integer x = 194
integer y = 115
integer width = 552
integer height = 672
integer taborder = 120
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 1090519039
boolean enabled = false
end type

event selectionchanged;Long ll_row, ll_i

is_line = Text(index)
wf_settitle()

RETURN 1


end event

type em_from from u_em within w_report_production_inventory_coil
integer x = 1039
integer y = 112
integer width = 289
integer height = 77
integer taborder = 110
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
double increment = 0
string minmax = ""
end type

type em_to from u_em within w_report_production_inventory_coil
integer x = 1426
integer y = 112
integer width = 282
integer height = 77
integer taborder = 100
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
double increment = 0
string minmax = ""
end type

type st_1 from statictext within w_report_production_inventory_coil
integer x = 1342
integer y = 118
integer width = 69
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
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_cust from u_ddlb within w_report_production_inventory_coil
integer x = 227
integer y = 333
integer width = 881
integer height = 992
integer taborder = 90
boolean bringtotop = true
boolean enabled = false
end type

event selectionchanged;Long ll_row, ll_i
String ls_text

ls_text = Text(index)
is_cust = ls_text
wf_settitle()
ll_row = dw_customer.RowCount()
FOR ll_i = 1 TO ll_row
	IF dw_customer.GetItemString(ll_i, "customer_short_name") = ls_text THEN
		dw_customer.Event RowFocusChanged(ll_i)
		dw_customer.SelectRow(0, False)
		dw_customer.SelectRow(ll_i, True)
	END IF
NEXT
RETURN 1


end event

type ddlb_enduser from u_ddlb within w_report_production_inventory_coil
integer x = 1371
integer y = 333
integer width = 1017
integer height = 1059
integer taborder = 80
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

type dw_allcust from u_dw within w_report_production_inventory_coil
boolean visible = false
integer x = 2121
integer y = 1373
integer height = 42
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

type dw_customer from u_dw within w_report_production_inventory_coil
boolean visible = false
integer x = 2121
integer y = 1424
integer height = 38
integer taborder = 60
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

type cb_retrieve from u_cb within w_report_production_inventory_coil
integer x = 2117
integer y = 477
integer width = 307
integer height = 74
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Retrieve"
end type

event clicked;dw_report.Event ue_retrieve()
Return 1
end event

type dw_line from u_dw within w_report_production_inventory_coil
boolean visible = false
integer x = 2121
integer y = 1475
integer height = 35
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_line_number"
end type

event constructor;of_SetBase(TRUE)
of_SetRowManager(TRUE)
of_SetRowSelect(TRUE)
inv_RowSelect.of_SetStyle ( 0 )
SetTransObject(SQLCA)
Retrieve()

end event

type rb_statusall from u_rb within w_report_production_inventory_coil
integer x = 1792
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

type rb_status from u_rb within w_report_production_inventory_coil
integer x = 1792
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
//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.
RETURN 1
end event

type ddlb_status from u_ddlb within w_report_production_inventory_coil
integer x = 1997
integer y = 115
integer width = 399
integer height = 528
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 1090519039
boolean enabled = false
string item[] = {"Done","InProcess","Canceled","OnHold"}
end type

event selectionchanged;is_status = Text(index)

wf_settitle()

//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.

RETURN 1

end event

type cb_email from u_cb within w_report_production_inventory_coil
integer x = 2117
integer y = 1302
integer width = 307
integer height = 74
integer taborder = 11
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

