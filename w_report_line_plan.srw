$PBExportHeader$w_report_line_plan.srw
forward
global type w_report_line_plan from w_sheet
end type
type dw_report from u_dw within w_report_line_plan
end type
type cb_print from u_cb within w_report_line_plan
end type
type cb_close from u_cb within w_report_line_plan
end type
type cb_setzoom from u_cb within w_report_line_plan
end type
type gb_4 from u_gb within w_report_line_plan
end type
type gb_3 from u_gb within w_report_line_plan
end type
type gb_2 from u_gb within w_report_line_plan
end type
type gb_1 from u_gb within w_report_line_plan
end type
type rb_lineall from u_rb within w_report_line_plan
end type
type rb_line from u_rb within w_report_line_plan
end type
type rb_dateall from u_rb within w_report_line_plan
end type
type rb_date from u_rb within w_report_line_plan
end type
type rb_custall from u_rb within w_report_line_plan
end type
type rb_cust from u_rb within w_report_line_plan
end type
type rb_enduserall from u_rb within w_report_line_plan
end type
type rb_enduser from u_rb within w_report_line_plan
end type
type ddlb_line from u_ddlb within w_report_line_plan
end type
type em_from from u_em within w_report_line_plan
end type
type em_to from u_em within w_report_line_plan
end type
type st_1 from statictext within w_report_line_plan
end type
type ddlb_cust from u_ddlb within w_report_line_plan
end type
type ddlb_enduser from u_ddlb within w_report_line_plan
end type
type dw_allcust from u_dw within w_report_line_plan
end type
type dw_customer from u_dw within w_report_line_plan
end type
type cb_retrieve from u_cb within w_report_line_plan
end type
type dw_line from u_dw within w_report_line_plan
end type
end forward

global type w_report_line_plan from w_sheet
string tag = "ABCO production reports"
integer x = 4
integer y = 3
integer width = 3354
integer height = 2054
string title = "Production Report"
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
dw_report dw_report
cb_print cb_print
cb_close cb_close
cb_setzoom cb_setzoom
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
end type
global w_report_line_plan w_report_line_plan

type variables
String is_line
String is_cust
String is_enduser
Long il_line
Long il_cust
Long il_enduser
end variables

forward prototypes
public function string wf_job_spec (long al_job)
public function string wf_search_terms ()
public subroutine wf_settitle ()
end prototypes

event ue_whoami;RETURN "w_report_line_plan"
end event

public function string wf_job_spec (long al_job);String ls_spec
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

ls_terms = " SELECT ~~~"LINE~~~".~~~"MAX_WIDTH~~~", " + &
			" ~~~"LINE~~~".~~~"LINE_DESC~~~", " + &
			" ~~~"AB_JOB~~~".~~~"AB_JOB_NUM~~~",  " + &
			" ~~~"AB_JOB~~~".~~~"TIME_DATE_STARTED~~~", " + &
         " ~~~"AB_JOB~~~".~~~"TIME_DATE_FINISHED~~~", " + &
         " ~~~"AB_JOB~~~".~~~"DUE_DATE~~~", " + &
         " ~~~"CUSTOMER_ORDER~~~".~~~"ORIG_CUSTOMER_ID~~~",  " + &
         " ~~~"CUSTOMER_ORDER~~~".~~~"ORIG_CUSTOMER_PO~~~",   " + &
         " ~~~"CUSTOMER_ORDER~~~".~~~"ENDUSER_ID~~~",  " + &
         " ~~~"ORDER_ITEM~~~".~~~"ALLOY2~~~",    " + &
         " ~~~"ORDER_ITEM~~~".~~~"TEMPER~~~",  " + &
			" NULL ~~~"CSPEC_T~~~", " + &
			" 0 ~~~"CBAL_DUE~~~" " + &
   "  FROM ~~~"AB_JOB~~~",    " + &
        "  ~~~"CUSTOMER~~~",   " + &
        "  ~~~"CUSTOMER_ORDER~~~",  " + &
        "  ~~~"ORDER_ITEM~~~", " + &
        "  ~~~"LINE~~~"  " + &
   " WHERE ( ~~~"CUSTOMER_ORDER~~~".~~~"ENDUSER_ID~~~" = ~~~"CUSTOMER~~~".~~~"CUSTOMER_ID~~~" ) and   " + &
         " ( ~~~"ORDER_ITEM~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~" ) and  " + &
         " ( ~~~"ORDER_ITEM~~~".~~~"ORDER_ITEM_NUM~~~" = ~~~"AB_JOB~~~".~~~"ORDER_ITEM_NUM~~~" ) and   " + &
         " ( ~~~"ORDER_ITEM~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"AB_JOB~~~".~~~"ORDER_ABC_NUM~~~" ) and  " + &
         " ( ~~~"AB_JOB~~~".~~~"LINE_NUM~~~" = ~~~"LINE~~~".~~~"LINE_NUM~~~" ) and   " + &
         " ( ( ~~~"AB_JOB~~~".~~~"JOB_STATUS~~~" = 1 ) OR  " + &
         " ( ~~~"AB_JOB~~~".~~~"JOB_STATUS~~~" = 2 ) ) "  

ls_s = " "
IF rb_line.Checked THEN
	ls_s = ls_s + " and ( ~~~"AB_JOB~~~".~~~"LINE_NUM~~~" = " + String(il_line) + " )"
END IF

IF rb_date.Checked THEN
	ls_s = ls_s + " and (TO_DATE(TO_CHAR(~~~"AB_JOB~~~".~~~"TIME_DATE_STARTED~~~",~~~'DD-MON-YYYY~~~'),~~~'DD-MON-YYYY~~~'  ) >= " + " TO_DATE(~~~'" + em_from.Text + "~~~',~~~'mm/dd/yyyy~~~' )" + " )"  
	ls_s = ls_s + " and (TO_DATE(TO_CHAR(~~~"AB_JOB~~~".~~~"TIME_DATE_STARTED~~~",~~~'DD-MON-YYYY~~~'),~~~'DD-MON-YYYY~~~'  )  <= " + " TO_DATE(~~~'" + em_to.Text + "~~~',~~~'mm/dd/yyyy~~~' )" + " )"  //21-DEC-1998 format
END IF

IF rb_cust.Checked THEN
	ls_s = ls_s + " and (~~~"CUSTOMER_ORDER~~~".~~~"ORIG_CUSTOMER_ID~~~" = " + String(il_cust) + " )"
END IF

IF rb_enduser.Checked THEN
	ls_s = ls_s + " and ( ~~~"CUSTOMER_ORDER~~~".~~~"ENDUSER_ID~~~" = " + String(il_enduser) + " )"
END IF

//ls_sort = " ORDER BY ~~~"LINE~~~".~~~"MAX_WIDTH~~~" ASC,   ~~~"AB_JOB~~~".~~~"TIME_DATE_STARTED~~~" ASC "

ls_terms = ls_terms + ls_s + ls_sort

RETURN ls_terms
end function

public subroutine wf_settitle ();String ls_modstring,ls_s

IF rb_lineall.Checked THEN
	ls_s = "ALL"		
ELSE
	ls_s = is_line
END IF

ls_modstring = "line_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 

IF rb_dateall.Checked THEN
	ls_s = "ALL"		
ELSE
	ls_s = em_from.Text + " - " + em_to.Text
END IF

ls_modstring = "date_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 

IF rb_custall.Checked THEN
	ls_s = "ALL"		
ELSE
	ls_s = is_cust
END IF

ls_modstring = "cust_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 

IF rb_enduserall.Checked THEN
	ls_s = "ALL"		
ELSE
	ls_s = is_enduser
END IF

ls_modstring = "enduser_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 


end subroutine

on w_report_line_plan.create
int iCurrent
call super::create
this.dw_report=create dw_report
this.cb_print=create cb_print
this.cb_close=create cb_close
this.cb_setzoom=create cb_setzoom
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
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_report
this.Control[iCurrent+2]=this.cb_print
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.cb_setzoom
this.Control[iCurrent+5]=this.gb_4
this.Control[iCurrent+6]=this.gb_3
this.Control[iCurrent+7]=this.gb_2
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.rb_lineall
this.Control[iCurrent+10]=this.rb_line
this.Control[iCurrent+11]=this.rb_dateall
this.Control[iCurrent+12]=this.rb_date
this.Control[iCurrent+13]=this.rb_custall
this.Control[iCurrent+14]=this.rb_cust
this.Control[iCurrent+15]=this.rb_enduserall
this.Control[iCurrent+16]=this.rb_enduser
this.Control[iCurrent+17]=this.ddlb_line
this.Control[iCurrent+18]=this.em_from
this.Control[iCurrent+19]=this.em_to
this.Control[iCurrent+20]=this.st_1
this.Control[iCurrent+21]=this.ddlb_cust
this.Control[iCurrent+22]=this.ddlb_enduser
this.Control[iCurrent+23]=this.dw_allcust
this.Control[iCurrent+24]=this.dw_customer
this.Control[iCurrent+25]=this.cb_retrieve
this.Control[iCurrent+26]=this.dw_line
end on

on w_report_line_plan.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.cb_print)
destroy(this.cb_close)
destroy(this.cb_setzoom)
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
end on

event open;call super::open;Long ll_row, ll_c
String ls_spec
Long ll_job, ll_bal_due

dw_report.SetTransObject(SQLCA)
dw_report.Retrieve()
dw_report.Event ue_specs()

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

type dw_report from u_dw within w_report_line_plan
event ue_specs ( )
integer x = 7
integer y = 230
integer width = 2940
integer height = 1696
integer taborder = 10
string dataobject = "d_report_line_plan"
boolean hscrollbar = true
end type

event ue_specs;Long ll_row, ll_c
Long ll_job, ll_bal_due
String ls_spec

ll_row = this.RowCount()
IF ll_row > 0 THEN
	FOR ll_c = 1 TO ll_row
		ll_job = this.GetItemNumber(ll_c, "ab_job_num")
		ls_spec = wf_job_spec(ll_job)
		this.SetItem(ll_c, "cspec_t", ls_spec)
		CONNECT USING SQLCA;
		SELECT SUM(process_quantity) INTO :ll_bal_due
		FROM process_coil
		WHERE ab_job_num = :ll_job
		USING SQLCA;
		IF IsNULL(ll_bal_due) THEN ll_bal_due = 0
		this.SetItem(ll_c, "cbal_due", ll_bal_due)
	NEXT
END IF
this.ResetUpdate()

end event

event rbuttondown;//disable
Return 0
end event

event rbuttonup;//disable
Return 0
end event

event constructor;of_SetBase(TRUE)
of_SetPrintPreview(TRUE)
SetTransObject(SQLCA)





end event

type cb_print from u_cb within w_report_line_plan
integer x = 2977
integer y = 822
integer width = 307
integer height = 74
integer taborder = 150
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;Parent.Event pfc_print()
end event

type cb_close from u_cb within w_report_line_plan
string tag = "Exit"
integer x = 2977
integer y = 1098
integer width = 322
integer height = 74
integer taborder = 160
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_setzoom from u_cb within w_report_line_plan
integer x = 2977
integer y = 547
integer width = 307
integer height = 74
integer taborder = 140
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&SetZoom"
end type

event clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type gb_4 from u_gb within w_report_line_plan
integer x = 2454
integer width = 863
integer height = 214
integer taborder = 110
string text = "End User"
end type

type gb_3 from u_gb within w_report_line_plan
integer x = 1459
integer width = 976
integer height = 214
integer taborder = 120
string text = "Customer"
end type

type gb_2 from u_gb within w_report_line_plan
integer x = 545
integer width = 896
integer height = 214
integer taborder = 100
string text = "Starting Date"
end type

type gb_1 from u_gb within w_report_line_plan
integer x = 4
integer width = 519
integer height = 214
integer taborder = 130
string text = "Line"
end type

type rb_lineall from u_rb within w_report_line_plan
integer x = 29
integer y = 58
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "All"
boolean checked = true
end type

event clicked;IF this.Checked THEN 
	ddlb_line.Enabled = FALSE
	il_line = 0
ELSE
	ddlb_line.Enabled = TRUE
END IF
wf_settitle()


end event

type rb_line from u_rb within w_report_line_plan
integer x = 33
integer y = 131
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
wf_settitle()
end event

type rb_dateall from u_rb within w_report_line_plan
integer x = 567
integer y = 58
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

end event

type rb_date from u_rb within w_report_line_plan
integer x = 571
integer y = 131
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
end event

type rb_custall from u_rb within w_report_line_plan
integer x = 1488
integer y = 58
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "All"
boolean checked = true
end type

event clicked;IF this.Checked THEN 
	ddlb_cust.Enabled = FALSE
	il_cust = 0
ELSE
	ddlb_cust.Enabled = TRUE
END IF
wf_settitle()
end event

type rb_cust from u_rb within w_report_line_plan
integer x = 1488
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
ELSE
	ddlb_cust.Enabled = FALSE
END IF
wf_settitle()
end event

type rb_enduserall from u_rb within w_report_line_plan
integer x = 2472
integer y = 58
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "All"
boolean checked = true
end type

event clicked;IF this.Checked THEN 
	ddlb_enduser.Enabled = FALSE
	il_enduser = 0
ELSE
	ddlb_enduser.Enabled = TRUE
END IF
wf_settitle()
end event

type rb_enduser from u_rb within w_report_line_plan
integer x = 2472
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

type ddlb_line from u_ddlb within w_report_line_plan
integer x = 205
integer y = 125
integer width = 300
integer height = 672
integer taborder = 90
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 1090519039
boolean enabled = false
end type

event selectionchanged;Long ll_row, ll_i

is_line = Text(index)
wf_settitle()
ll_row = dw_line.RowCount()
FOR ll_i = 1 TO ll_row
	IF dw_line.GetItemString(ll_i, "line_desc") = is_line THEN
		il_line = dw_line.GetItemNumber(ll_i, "line_num")
	END IF
NEXT

RETURN 1


end event

type em_from from u_em within w_report_line_plan
integer x = 753
integer y = 125
integer width = 289
integer height = 77
integer taborder = 80
boolean bringtotop = true
boolean enabled = false
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
double increment = 0
string minmax = ""
end type

type em_to from u_em within w_report_line_plan
integer x = 1137
integer y = 125
integer width = 282
integer height = 77
integer taborder = 70
boolean bringtotop = true
boolean enabled = false
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
double increment = 0
string minmax = ""
end type

type st_1 from statictext within w_report_line_plan
integer x = 1042
integer y = 131
integer width = 91
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

type ddlb_cust from u_ddlb within w_report_line_plan
integer x = 1697
integer y = 128
integer width = 724
integer height = 992
integer taborder = 60
boolean bringtotop = true
boolean enabled = false
end type

event selectionchanged;Long ll_row, ll_i

is_cust = Text(index)
wf_settitle()
ll_row = dw_customer.RowCount()
FOR ll_i = 1 TO ll_row
	IF dw_customer.GetItemString(ll_i, "customer_short_name") = is_cust THEN
		il_cust = dw_customer.GetItemNumber(ll_i, "customer_id")
	END IF
NEXT

RETURN 1


end event

type ddlb_enduser from u_ddlb within w_report_line_plan
integer x = 2662
integer y = 128
integer width = 640
integer height = 1059
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 1090519039
boolean enabled = false
end type

event selectionchanged;Long ll_row, ll_i

is_enduser = Text(index)
wf_settitle()
ll_row = dw_allcust.RowCount()
FOR ll_i = 1 TO ll_row
	IF dw_allcust.GetItemString(ll_i, "customer_short_name") = is_enduser THEN
		il_enduser = dw_allcust.GetItemNumber(ll_i, "customer_id")
	END IF
NEXT

RETURN 1


end event

type dw_allcust from u_dw within w_report_line_plan
boolean visible = false
integer x = 2962
integer y = 1395
integer height = 112
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

type dw_customer from u_dw within w_report_line_plan
boolean visible = false
integer x = 2962
integer y = 1523
integer height = 112
integer taborder = 30
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

type cb_retrieve from u_cb within w_report_line_plan
integer x = 2977
integer y = 272
integer width = 307
integer height = 74
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Retrieve"
end type

event clicked;String ls_modify, ls_rc

wf_settitle()

ls_modify ="DataWindow.Table.Select = '" + wf_search_terms() + " '"
ls_rc = dw_report.Modify(ls_modify)
IF ls_rc = "" THEN
	dw_report.Retrieve()
	dw_report.Event ue_specs()
ELSE
	MessageBox("Error","Failure to modify datawindow!", StopSign!)
END IF

RETURN 1
end event

type dw_line from u_dw within w_report_line_plan
boolean visible = false
integer x = 2962
integer y = 1648
integer height = 112
integer taborder = 11
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

