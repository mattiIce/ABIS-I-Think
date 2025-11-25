$PBExportHeader$w_report_order_label.srw
$PBExportComments$<main> print order labels inherited from pfemain/w_sheet
forward
global type w_report_order_label from w_sheet
end type
type dw_report from u_dw within w_report_order_label
end type
type cb_setzoom from u_cb within w_report_order_label
end type
type cb_print from u_cb within w_report_order_label
end type
type cb_close from u_cb within w_report_order_label
end type
type rb_order from u_rb within w_report_order_label
end type
type rb_time from u_rb within w_report_order_label
end type
type cb_retrieve from u_cb within w_report_order_label
end type
type st_1 from statictext within w_report_order_label
end type
type st_11 from statictext within w_report_order_label
end type
type st_12 from statictext within w_report_order_label
end type
type st_21 from statictext within w_report_order_label
end type
type st_22 from statictext within w_report_order_label
end type
type em_1 from u_em within w_report_order_label
end type
type em_2 from u_em within w_report_order_label
end type
type sle_1 from editmask within w_report_order_label
end type
type sle_2 from editmask within w_report_order_label
end type
type em_printfrom from u_em within w_report_order_label
end type
type st_2 from statictext within w_report_order_label
end type
type st_3 from statictext within w_report_order_label
end type
end forward

global type w_report_order_label from w_sheet
integer x = 4
integer y = 19
integer width = 2600
integer height = 1747
string title = "Print Customer Order Labels"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
dw_report dw_report
cb_setzoom cb_setzoom
cb_print cb_print
cb_close cb_close
rb_order rb_order
rb_time rb_time
cb_retrieve cb_retrieve
st_1 st_1
st_11 st_11
st_12 st_12
st_21 st_21
st_22 st_22
em_1 em_1
em_2 em_2
sle_1 sle_1
sle_2 sle_2
em_printfrom em_printfrom
st_2 st_2
st_3 st_3
end type
global w_report_order_label w_report_order_label

type variables


end variables

forward prototypes
public subroutine wf_fill_order_array (long al_s, long al_e)
public subroutine wf_fill_time_array (date ad_s, date ad_e)
public function string wf_job_specs (long al_job)
end prototypes

event ue_whoami;RETURN "w_report_order_label"
end event

public subroutine wf_fill_order_array (long al_s, long al_e);SetPointer(HourGlass!)

DataStore lds_report
Long ll_i, ll_row, ll_rrow
Long ll_job
String	ls_cust_prod_line_id, ls_orig_customer_po //Alex Gerlants. 07/11/2016

dw_report.Reset()

lds_report = CREATE datastore  
lds_report.DataObject = "d_report_order_label1_order"
lds_report.SetTransObject (SQLCA)  
lds_report.Retrieve(al_s, al_e)

IF Long(em_printfrom.Text) > 0 THEN
	FOR ll_i = 1 TO Long(em_printfrom.Text)
		dw_report.InsertRow(0)
	NEXT
END IF

ll_row = lds_report.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO lds_report.RowCount()
		ll_rrow = dw_report.InsertRow(0)
		ll_job = lds_report.getItemNumber(ll_i, "ab_job_ab_job_num")

		ls_cust_prod_line_id = lds_report.Object.cust_prod_line_id[ll_i] //Alex Gerlants. 07/11/2016
		If IsNull(ls_cust_prod_line_id) Then ls_cust_prod_line_id = "" //Alex Gerlants. 07/11/2016
		dw_report.Object.cust_prod_line_id[ll_rrow] = ls_cust_prod_line_id //Alex Gerlants. 07/11/2016
		
		dw_report.SetItem(ll_rrow, "cust_name", lds_report.GetItemString(ll_i, "customer_customer_short_name"))
		dw_report.SetItem(ll_rrow, "job_num", string(ll_job))
		dw_report.SetItem(ll_rrow, "cust_po", lds_report.GetItemString(ll_i, "customer_order_orig_customer_po"))
		dw_report.SetItem(ll_rrow, "alloy", lds_report.GetItemString(ll_i, "order_item_alloy2") + "-" + lds_report.GetItemString(ll_i, "order_item_temper") )
		dw_report.SetItem(ll_rrow, "spec", wf_job_specs(ll_job))
	NEXT
END IF

dw_report.ResetUpdate()

DESTROY lds_report
end subroutine

public subroutine wf_fill_time_array (date ad_s, date ad_e);SetPointer(HourGlass!)

DataStore lds_report
Long ll_i, ll_row, ll_rrow
Long ll_job
String	ls_cust_prod_line_id //Alex Gerlants. 07/11/2016

dw_report.Reset()

lds_report = CREATE datastore  
lds_report.DataObject = "d_report_order_label1_time"
lds_report.SetTransObject (SQLCA)  
lds_report.Retrieve(ad_s, ad_e)

IF Long(em_printfrom.Text) > 0 THEN
	FOR ll_i = 1 TO Long(em_printfrom.Text)
		dw_report.InsertRow(0)
	NEXT
END IF

ll_row = lds_report.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO lds_report.RowCount()
		ll_rrow = dw_report.InsertRow(0)
		ll_job = lds_report.getItemNumber(ll_i, "ab_job_ab_job_num")
		
		ls_cust_prod_line_id = lds_report.Object.cust_prod_line_id[ll_i] //Alex Gerlants. 07/11/2016
		If IsNull(ls_cust_prod_line_id) Then ls_cust_prod_line_id = "" //Alex Gerlants. 07/11/2016
		dw_report.Object.cust_prod_line_id[ll_rrow] = ls_cust_prod_line_id //Alex Gerlants. 07/11/2016
		
		dw_report.SetItem(ll_rrow, "cust_name", lds_report.GetItemString(ll_i, "customer_customer_short_name"))
		dw_report.SetItem(ll_rrow, "job_num", string(ll_job))
		dw_report.SetItem(ll_rrow, "cust_po", lds_report.GetItemString(ll_i, "customer_order_orig_customer_po"))
		dw_report.SetItem(ll_rrow, "alloy", (lds_report.GetItemString(ll_i, "order_item_alloy2") + "-" + lds_report.GetItemString(ll_i, "order_item_temper")) )
		dw_report.SetItem(ll_rrow, "spec", wf_job_specs(ll_job))
	NEXT
END IF

dw_report.ResetUpdate()

DESTROY lds_report
end subroutine

public function string wf_job_specs (long al_job);String ls_spec
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
		ls_spec = ls_spec +  " X " + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
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
	CASE "LIFTGATE"
		SELECT li_length, li_width INTO :lr_l, :lr_w
		FROM liftgate_shape
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec +  " X " + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "REINFORCEMENT"
		SELECT re_length, re_width INTO :lr_l, :lr_w
		FROM reinforcement
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec +  " X " + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE ELSE
		ls_spec = ls_spec + " X " + "VAR"
END CHOOSE	

RETURN ls_spec



end function

on w_report_order_label.create
int iCurrent
call super::create
this.dw_report=create dw_report
this.cb_setzoom=create cb_setzoom
this.cb_print=create cb_print
this.cb_close=create cb_close
this.rb_order=create rb_order
this.rb_time=create rb_time
this.cb_retrieve=create cb_retrieve
this.st_1=create st_1
this.st_11=create st_11
this.st_12=create st_12
this.st_21=create st_21
this.st_22=create st_22
this.em_1=create em_1
this.em_2=create em_2
this.sle_1=create sle_1
this.sle_2=create sle_2
this.em_printfrom=create em_printfrom
this.st_2=create st_2
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_report
this.Control[iCurrent+2]=this.cb_setzoom
this.Control[iCurrent+3]=this.cb_print
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.rb_order
this.Control[iCurrent+6]=this.rb_time
this.Control[iCurrent+7]=this.cb_retrieve
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.st_11
this.Control[iCurrent+10]=this.st_12
this.Control[iCurrent+11]=this.st_21
this.Control[iCurrent+12]=this.st_22
this.Control[iCurrent+13]=this.em_1
this.Control[iCurrent+14]=this.em_2
this.Control[iCurrent+15]=this.sle_1
this.Control[iCurrent+16]=this.sle_2
this.Control[iCurrent+17]=this.em_printfrom
this.Control[iCurrent+18]=this.st_2
this.Control[iCurrent+19]=this.st_3
end on

on w_report_order_label.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.cb_setzoom)
destroy(this.cb_print)
destroy(this.cb_close)
destroy(this.rb_order)
destroy(this.rb_time)
destroy(this.cb_retrieve)
destroy(this.st_1)
destroy(this.st_11)
destroy(this.st_12)
destroy(this.st_21)
destroy(this.st_22)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.sle_1)
destroy(this.sle_2)
destroy(this.em_printfrom)
destroy(this.st_2)
destroy(this.st_3)
end on

event open;call super::open;dw_report.SetFocus()


end event

type dw_report from u_dw within w_report_order_label
integer x = 22
integer y = 157
integer width = 2531
integer height = 1382
integer taborder = 100
string dataobject = "d_report_prod_order_label"
boolean hscrollbar = true
end type

event constructor;This.of_SetPrintPreview(TRUE)
end event

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve()
end event

type cb_setzoom from u_cb within w_report_order_label
integer x = 834
integer y = 1552
integer width = 351
integer height = 74
integer taborder = 70
string facename = "Arial"
string text = "&SetZoom"
end type

event clicked;call super::clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type cb_print from u_cb within w_report_order_label
integer x = 1371
integer y = 1552
integer width = 351
integer height = 74
integer taborder = 80
boolean bringtotop = true
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;dw_report.Event pfc_print()
end event

type cb_close from u_cb within w_report_order_label
string tag = "Close without printing"
integer x = 1909
integer y = 1552
integer width = 351
integer height = 74
integer taborder = 90
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type rb_order from u_rb within w_report_order_label
integer x = 219
integer y = 6
integer width = 486
string facename = "Arial"
long backcolor = 79741120
string text = "Prod Order Number"
end type

type rb_time from u_rb within w_report_order_label
integer x = 219
integer y = 83
boolean bringtotop = true
string facename = "Arial"
long backcolor = 79741120
string text = "Date"
end type

type cb_retrieve from u_cb within w_report_order_label
string tag = "retrieve"
integer x = 296
integer y = 1552
integer width = 351
integer height = 74
integer taborder = 60
string facename = "Arial"
string text = "&Retrieve"
boolean default = true
end type

event clicked;Int li_flag

IF Long(em_printfrom.Text) > 14 THEN
	MessageBox("Error","Invalid printing from value.", StopSign!)
	Return -1
END IF

li_flag = 0
IF rb_order.Checked THEN li_flag = 1
IF rb_time.Checked THEN li_flag = 2

CHOOSE CASE li_flag
	CASE 0
		MessageBox("Error","Please indicate how you plan to retrieve data, job number or time?", StopSign!)
		Return -1
	CASE 1 //order
		Long ll_s, ll_e
		IF Len(sle_1.Text) < 1 THEN 
			ll_s = 0
		ELSE
			ll_s = Long(sle_1.Text)
		END IF
		IF Len(sle_2.Text) < 1 THEN 
			ll_e = 0
		ELSE
			ll_e = Long(sle_2.Text)
		END IF
		IF ll_e = 0 THEN ll_e = ll_s
		IF ll_s = 0 THEN ll_s = ll_e
		IF ll_s > ll_e THEN
			MessageBox("Error","Invalid Data!", StopSign!)
			Return -1
		END IF
		wf_fill_order_array(ll_s, ll_e)
	CASE 2 //time
		IF Date(em_1.Text) > Date(em_2.Text) THEN
			MessageBox("Error","Invalid Data!", StopSign!)
			Return -1
		END IF
		wf_fill_time_array(Date(em_1.Text), Date(em_2.Text))
END CHOOSE


end event

type st_1 from statictext within w_report_order_label
integer x = 26
integer y = 10
integer width = 183
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Select:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_11 from statictext within w_report_order_label
integer x = 706
integer y = 10
integer width = 143
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "From"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_12 from statictext within w_report_order_label
integer x = 1152
integer y = 10
integer width = 99
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "To"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_21 from statictext within w_report_order_label
integer x = 695
integer y = 86
integer width = 154
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "From"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_22 from statictext within w_report_order_label
integer x = 1152
integer y = 86
integer width = 99
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "To"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_1 from u_em within w_report_order_label
integer x = 867
integer y = 80
integer width = 278
integer height = 70
integer taborder = 30
fontcharset fontcharset = ansi!
string facename = "Arial"
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
double increment = 0
string minmax = ""
end type

type em_2 from u_em within w_report_order_label
integer x = 1276
integer y = 80
integer width = 278
integer height = 70
integer taborder = 40
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

type sle_1 from editmask within w_report_order_label
integer x = 867
integer y = 3
integer width = 278
integer height = 70
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "########"
end type

type sle_2 from editmask within w_report_order_label
integer x = 1276
integer y = 3
integer width = 278
integer height = 70
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "########"
end type

type em_printfrom from u_em within w_report_order_label
integer x = 1719
integer y = 48
integer width = 165
integer height = 67
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "0"
alignment alignment = center!
string mask = "##"
double increment = 0
string minmax = ""
end type

type st_2 from statictext within w_report_order_label
integer x = 1605
integer y = 51
integer width = 102
integer height = 54
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Skip"
boolean focusrectangle = false
end type

type st_3 from statictext within w_report_order_label
integer x = 1898
integer y = 48
integer width = 644
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "label(s) from top when printing"
boolean focusrectangle = false
end type

