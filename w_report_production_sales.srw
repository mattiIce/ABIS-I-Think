$PBExportHeader$w_report_production_sales.srw
$PBExportComments$production sales report based on different customers
forward
global type w_report_production_sales from w_sheet
end type
type dw_report from u_dw within w_report_production_sales
end type
type cb_print from u_cb within w_report_production_sales
end type
type dw_customer from u_dw within w_report_production_sales
end type
type cb_close from u_cb within w_report_production_sales
end type
type cb_preview from u_cb within w_report_production_sales
end type
type ddlb_customer from dropdownlistbox within w_report_production_sales
end type
type em_from from editmask within w_report_production_sales
end type
type em_to from editmask within w_report_production_sales
end type
type cb_setzoom from u_cb within w_report_production_sales
end type
type gb_3 from u_gb within w_report_production_sales
end type
type gb_2 from u_gb within w_report_production_sales
end type
type gb_1 from u_gb within w_report_production_sales
end type
type rb_custall from u_rb within w_report_production_sales
end type
type rb_cust from u_rb within w_report_production_sales
end type
type rb_typeall from u_rb within w_report_production_sales
end type
type rb_type from u_rb within w_report_production_sales
end type
type rb_dateall from u_rb within w_report_production_sales
end type
type rb_date from u_rb within w_report_production_sales
end type
type st_1 from statictext within w_report_production_sales
end type
end forward

global type w_report_production_sales from w_sheet
string tag = "Production sales reports"
integer x = 4
integer y = 3
integer width = 2717
integer height = 1779
string title = "Production - Sales Report"
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
dw_report dw_report
cb_print cb_print
dw_customer dw_customer
cb_close cb_close
cb_preview cb_preview
ddlb_customer ddlb_customer
em_from em_from
em_to em_to
cb_setzoom cb_setzoom
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
rb_custall rb_custall
rb_cust rb_cust
rb_typeall rb_typeall
rb_type rb_type
rb_dateall rb_dateall
rb_date rb_date
st_1 st_1
end type
global w_report_production_sales w_report_production_sales

type variables
Long il_bwt
Long il_sheetwt
Long il_scrapwt
Long il_rejwt
Real ir_y
Int ii_type //0-regular 1 -abco detail 2 -abco summary
String is_cust

end variables

forward prototypes
public subroutine wf_settitle ()
public function integer wf_fill_row (long al_job, long al_row)
public subroutine wf_customer_report ()
public subroutine wf_abco_report ()
public subroutine wf_customer_total (long al_customer_id)
public subroutine wf_abco_report_detail ()
public subroutine wf_customer_detail (long al_customer_id)
end prototypes

event ue_whoami;RETURN "w_report_production_sales"
end event

public subroutine wf_settitle ();String ls_modstring,ls_s
Long ll_c

CHOOSE CASE ii_type
	CASE 2
		ls_s = ls_s + "Aluminum Blanking Overall Conversion Totals" 
	CASE 1
		ls_s = ls_s + "ABCO Companies Conversion Totals" 	
	CASE ELSE
		ll_c = dw_customer.GetRow()
		ls_s = dw_customer.GetItemString(ll_c, "customer_short_name")
		ls_s = Trim(ls_s)
		ls_s = ls_s + " Yields" 
END CHOOSE
ls_modstring = "title_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 

IF rb_dateall.Checked THEN
	ls_s = "All"
ELSE
	ls_s = em_from.Text + " - " + em_to.Text 
END IF
ls_modstring = "date_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 

end subroutine

public function integer wf_fill_row (long al_job, long al_row);SetPointer(HourGlass!)
String ls_shape, ls_enduser, ls_material, ls_spec, ls_temper, ls_cust, ls_yield
Long ll_order, ll_enduser, ll_bwt, ll_rejwt, ll_sheetwt, ll_scrapwt
Int li_item
String ls_alloy
Real lr_l, lr_s, lr_w, lr_yield, lr_gauge
DataStore lds_data
Long ll_row, ll_r

dw_report.SetItem(al_row, "ab_job_num", al_job)

CONNECT USING SQLCA;

SELECT order_abc_num, order_item_num INTO :ll_order, :li_item
FROM ab_job 
WHERE ab_job_num = :al_job
USING SQLCA;

SELECT enduser_id INTO :ll_enduser
FROM customer_order
WHERE order_abc_num = :ll_order
USING SQLCA;
IF ll_enduser > 0 THEN
	SELECT customer_short_name INTO :ls_enduser
	FROM customer
	WHERE customer_id = :ll_enduser
	USING SQLCA;
	ls_cust = Upper(Trim(ls_enduser) )
ELSE
	ls_cust = ""
END IF
dw_report.SetItem(al_row, "enduser_customer", ls_cust)

SELECT sheet_type, gauge, alloy2, temper INTO :ls_shape, :lr_gauge, :ls_alloy, :ls_temper
FROM order_item
WHERE order_abc_num = :ll_order AND order_item_num = :li_item
USING SQLCA;

ls_material = ls_alloy + " - " + ls_temper
dw_report.SetItem(al_row, "material", ls_material)

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
dw_report.SetItem(al_row, "spec", ls_spec)

lds_data = CREATE DataStore

lds_data.DataObject = "d_report_sales_ab_job_coil"
lds_data.SetTransObject(SQLCA)
lds_data.Retrieve(al_job)
ll_bwt = 0
ll_row = lds_data.RowCount()
IF ll_row > 0 THEN
	FOR ll_r = 1 TO ll_row 
		ll_bwt = ll_bwt + lds_data.GetItemNumber(ll_r, "process_coil_process_quantity" )
	NEXT
END IF
dw_report.SetItem(al_row, "begin_wt", ll_bwt)
il_bwt = il_bwt + ll_bwt

lds_data.DataObject = "d_report_sales_sheet_wt"
lds_data.SetTransObject(SQLCA)
lds_data.Retrieve(al_job)
ll_sheetwt = 0
ll_row = lds_data.RowCount()
IF ll_row > 0 THEN
	FOR ll_r = 1 TO ll_row 
		ll_sheetwt = ll_sheetwt + lds_data.GetItemNumber(ll_r, "prod_item_net_wt" )
	NEXT
END IF
dw_report.SetItem(al_row, "ship_wt", ll_sheetwt)
il_sheetwt = il_sheetwt + ll_sheetwt

lds_data.DataObject = "d_report_sales_job_rejcoil"
lds_data.SetTransObject(SQLCA)
lds_data.Retrieve(al_job)
ll_rejwt = 0
ll_row = lds_data.RowCount()
IF ll_row > 0 THEN
	FOR ll_r = 1 TO ll_row 
		ll_rejwt = ll_rejwt + lds_data.GetItemNumber(ll_r, "coil_net_wt_balance" )
	NEXT
END IF
dw_report.SetItem(al_row, "rej_coil_wt", ll_rejwt)
il_rejwt = il_rejwt + ll_rejwt

ll_scrapwt = 0
lds_data.DataObject = "d_report_sales_scrap_item_wt"
lds_data.SetTransObject(SQLCA)
lds_data.Retrieve(al_job)
ll_row = lds_data.RowCount()
IF ll_row > 0 THEN
	FOR ll_r = 1 TO ll_row 
		ll_scrapwt = ll_scrapwt + lds_data.GetItemNumber(ll_r, "return_item_net_wt" )
	NEXT
END IF
dw_report.SetItem(al_row, "scrap_wt", ll_scrapwt)
il_scrapwt = il_scrapwt + ll_scrapwt

IF ll_bwt > 0 THEN
	lr_yield = Real(ll_sheetwt) / ll_bwt * 100
ELSE
	lr_yield = 0
END IF
ls_yield = String(lr_yield, "##.##")
dw_report.SetItem(al_row, "yield", ls_yield)
ir_y = ir_y + lr_yield

DESTROY lds_data

RETURN 1
end function

public subroutine wf_customer_report ();DataStore lds_job
Long ll_row, ll_c, ll_report_row, ll_cust_row
Long ll_cust
Date ld_s, ld_e
String ls_modstring

lds_job = CREATE DataStore
lds_job.DataObject = "d_report_customer_job_list"
lds_job.SetTransObject(SQLCA)

il_bwt = 0
il_sheetwt = 0
il_scrapwt = 0
il_rejwt = 0
ir_y = 0
ll_cust_row = dw_customer.GetRow()
ll_cust = dw_customer.GetItemNumber(ll_cust_row, "customer_id")
IF rb_dateall.Checked THEN
	ld_s = Date("00/00/0000")
	ld_e = Date("12/31/9999")
ELSE
	ld_s = Date(em_from.Text)
	ld_e = Date(em_to.Text)
END IF
lds_job.Retrieve(ll_cust, ld_s, ld_e)
ll_row = lds_job.RowCount()
IF ll_row > 0 THEN
	FOR ll_c = 1 TO ll_row
		ll_report_row = dw_report.InsertRow(0)
		wf_fill_row(lds_job.GetItemNumber(ll_c, "ab_job_ab_job_num"), ll_report_row)
	NEXT
	dw_report.ResetUpdate()
	ir_y = ir_y  /  ll_row
END IF
DESTROY lds_job

ls_modstring = "t_begin_t.Text = ~"" + String(il_bwt) + "~""
dw_report.Modify(ls_modstring) 
ls_modstring = "t_ship_t.Text = ~"" + String(il_sheetwt) + "~""
dw_report.Modify(ls_modstring) 
ls_modstring = "t_scrap_t.Text = ~"" + String(il_scrapwt) + "~""
dw_report.Modify(ls_modstring) 
ls_modstring = "t_rej_t.Text = ~"" + String(il_rejwt) + "~""
dw_report.Modify(ls_modstring) 
ls_modstring = "a_yield_t.Text = ~"" + String(ir_y, "##.##") + "~""
dw_report.Modify(ls_modstring) 


end subroutine

public subroutine wf_abco_report ();Long ll_cust, ll_row, ll_c, ll_wt
String ls_modstring

il_bwt = 0
il_sheetwt = 0
il_scrapwt = 0
il_rejwt = 0
ir_y = 0

ll_row = dw_customer.RowCount()
IF ll_row > 0 THEN
	FOR ll_c = 1 TO ll_row
		ll_cust = dw_customer.GetItemNumber(ll_c, "customer_id")
		wf_customer_total(ll_cust)
	NEXT
END IF

ll_row = dw_report.RowCount()
IF ll_row > 0 THEN
	FOR ll_c = 1 TO ll_row
		ll_wt = dw_report.GetItemNumber(ll_c, "begin_wt", Primary!, FALSE)
		IF il_bwt > 0 THEN dw_report.SetItem(ll_c, "total_percent", String(Real(ll_wt)/il_bwt*100, "##.##"))
	NEXT
	ir_y = ir_y / ll_row
END IF
		
ls_modstring = "t_begin_t.Text = ~"" + String(il_bwt) + "~""
dw_report.Modify(ls_modstring) 
ls_modstring = "t_ship_t.Text = ~"" + String(il_sheetwt) + "~""
dw_report.Modify(ls_modstring) 
ls_modstring = "t_scrap_t.Text = ~"" + String(il_scrapwt) + "~""
dw_report.Modify(ls_modstring) 
ls_modstring = "t_rej_t.Text = ~"" + String(il_rejwt) + "~""
dw_report.Modify(ls_modstring) 
ls_modstring = "a_yield_t.Text = ~"" + String(ir_y, "##.##") + "~""
dw_report.Modify(ls_modstring) 

dw_report.ResetUpdate()


end subroutine

public subroutine wf_customer_total (long al_customer_id);DataStore lds_job, lds_data
Long ll_bwt, ll_sheetwt, ll_scrapwt, ll_rejwt
Long ll_bwt_t, ll_sheetwt_t, ll_scrapwt_t, ll_rejwt_t
Real lr_yield
Long ll_datarow, ll_datar, ll_jobrow, ll_jobr, ll_report_row, ll_job
Date ld_s, ld_e
String ls_modstring, ls_cust, ls_yield

ll_bwt = 0
ll_sheetwt = 0
ll_scrapwt = 0
ll_rejwt = 0
lr_yield = 0

CONNECT USING SQLCA;
SELECT customer_short_name INTO :ls_cust
FROM customer
WHERE customer_id = :al_customer_id
USING SQLCA;
ls_cust = Upper(Trim(ls_cust))

lds_job = CREATE DataStore
lds_job.DataObject = "d_report_customer_job_list"
lds_job.SetTransObject(SQLCA)
IF rb_dateall.Checked THEN
	ld_s = Date("00/00/0000")
	ld_e = Date("12/31/9999")
ELSE
	ld_s = Date(em_from.Text)
	ld_e = Date(em_to.Text)
END IF
lds_job.Retrieve(al_customer_id, ld_s, ld_e)
ll_jobrow = lds_job.RowCount()
IF ll_jobrow > 0 THEN
	FOR ll_jobr = 1 TO ll_jobrow
		ll_job = lds_job.GetItemNumber(ll_jobr, "ab_job_ab_job_num")

		lds_data = CREATE DataStore

		lds_data.DataObject = "d_report_sales_ab_job_coil"
		lds_data.SetTransObject(SQLCA)
		lds_data.Retrieve(ll_job)
		ll_bwt_t = 0
		ll_datarow = lds_data.RowCount()
		IF ll_datarow > 0 THEN
			FOR ll_datar = 1 TO ll_datarow 
				ll_bwt_t = ll_bwt_t + lds_data.GetItemNumber(ll_datar, "process_coil_process_quantity" )
			NEXT
		END IF
		ll_bwt = ll_bwt + ll_bwt_t

		lds_data.DataObject = "d_report_sales_sheet_wt"
		lds_data.SetTransObject(SQLCA)
		lds_data.Retrieve(ll_job)
		ll_sheetwt_t = 0
		ll_datarow = lds_data.RowCount()
		IF ll_datarow > 0 THEN
			FOR ll_datar = 1 TO ll_datarow 
				ll_sheetwt_t = ll_sheetwt_t + lds_data.GetItemNumber(ll_datar, "prod_item_net_wt" )
			NEXT
		END IF
		ll_sheetwt = ll_sheetwt + ll_sheetwt_t

		lds_data.DataObject = "d_report_sales_job_rejcoil"
		lds_data.SetTransObject(SQLCA)
		lds_data.Retrieve(ll_job)
		ll_rejwt_t = 0
		ll_datarow = lds_data.RowCount()
		IF ll_datarow > 0 THEN
			FOR ll_datar = 1 TO ll_datarow 
				ll_rejwt_t = ll_rejwt_t + lds_data.GetItemNumber(ll_datar, "coil_net_wt_balance" )
			NEXT
		END IF
		ll_rejwt = ll_rejwt + ll_rejwt_t
		
		ll_scrapwt_t = 0
		lds_data.DataObject = "d_report_sales_scrap_item_wt"
		lds_data.SetTransObject(SQLCA)
		lds_data.Retrieve(ll_job)
		ll_datarow = lds_data.RowCount()
		IF ll_datarow > 0 THEN
			FOR ll_datar = 1 TO ll_datarow 
				ll_scrapwt_t = ll_scrapwt_t + lds_data.GetItemNumber(ll_datar, "return_item_net_wt" )
			NEXT
		END IF
		ll_scrapwt = ll_scrapwt + ll_scrapwt_t
	
		DESTROY lds_data
	NEXT
END IF

IF ll_bwt > 0 THEN
	ll_report_row = dw_report.InsertRow(0)

	dw_report.SetItem(ll_report_row, "enduser_customer", ls_cust)
	dw_report.SetItem(ll_report_row, "begin_wt", ll_bwt)
	dw_report.SetItem(ll_report_row, "ship_wt", ll_sheetwt)
	dw_report.SetItem(ll_report_row, "rej_coil_wt", ll_rejwt)
	dw_report.SetItem(ll_report_row, "scrap_wt", ll_scrapwt)

	IF ll_bwt > 0 THEN
		lr_yield = Real(ll_sheetwt) / ll_bwt * 100
	ELSE
		lr_yield = 0
	END IF
	ls_yield = String(lr_yield, "##.##")
	dw_report.SetItem(ll_report_row, "yield", ls_yield)

	dw_report.ResetUpdate()
END IF

DESTROY lds_job

il_bwt = il_bwt + ll_bwt
il_sheetwt = il_sheetwt + ll_sheetwt
il_scrapwt = il_scrapwt + ll_scrapwt
il_rejwt = il_rejwt + ll_rejwt
ir_y = ir_y + lr_yield

end subroutine

public subroutine wf_abco_report_detail ();Long ll_cust, ll_row, ll_c, ll_wt
String ls_modstring

il_bwt = 0
il_sheetwt = 0
il_scrapwt = 0
il_rejwt = 0
ir_y = 0

ll_row = dw_customer.RowCount()
IF ll_row > 0 THEN
	FOR ll_c = 1 TO ll_row
		ll_cust = dw_customer.GetItemNumber(ll_c, "customer_id")
		wf_customer_detail(ll_cust)
	NEXT
END IF
ll_row = dw_report.RowCount()
IF ll_row > 0 THEN ir_y = ir_y / ll_row

ls_modstring = "t_begin_t.Text = ~"" + String(il_bwt) + "~""
dw_report.Modify(ls_modstring) 
ls_modstring = "t_ship_t.Text = ~"" + String(il_sheetwt) + "~""
dw_report.Modify(ls_modstring) 
ls_modstring = "t_scrap_t.Text = ~"" + String(il_scrapwt) + "~""
dw_report.Modify(ls_modstring) 
ls_modstring = "t_rej_t.Text = ~"" + String(il_rejwt) + "~""
dw_report.Modify(ls_modstring) 
ls_modstring = "a_yield_t.Text = ~"" + String(ir_y, "##.##") + "~""
dw_report.Modify(ls_modstring) 

dw_report.ResetUpdate()


end subroutine

public subroutine wf_customer_detail (long al_customer_id);DataStore lds_job, lds_data
Long ll_bwt, ll_sheetwt, ll_scrapwt, ll_rejwt
Real lr_yield
Long ll_jobrow, ll_jobr, ll_datarow, ll_datar, ll_report_row, ll_job, ll_order
Date ld_s, ld_e
String ls_modstring, ls_cust, ls_yield, ls_spec, ls_material, ls_shape, ls_temper
Real lr_l, lr_w, lr_s, lr_gauge
Int li_item
String ls_alloy

CONNECT USING SQLCA;
SELECT customer_short_name INTO :ls_cust
FROM customer
WHERE customer_id = :al_customer_id
USING SQLCA;
ls_cust = Upper(Trim(ls_cust))

lds_job = CREATE DataStore
lds_job.DataObject = "d_report_customer_job_list"
lds_job.SetTransObject(SQLCA)
IF rb_dateall.Checked THEN
	ld_s = Date("00/00/0000")
	ld_e = Date("12/31/9999")
ELSE
	ld_s = Date(em_from.Text)
	ld_e = Date(em_to.Text)
END IF
lds_job.Retrieve(al_customer_id, ld_s, ld_e)
ll_jobrow = lds_job.RowCount()
IF ll_jobrow > 0 THEN
	FOR ll_jobr = 1 TO ll_jobrow
		ll_bwt = 0
		ll_sheetwt = 0
		ll_scrapwt = 0
		ll_rejwt = 0
		lr_yield = 0

		ll_report_row = dw_report.InsertRow(0)
		dw_report.SetItem(ll_report_row, "enduser_customer", ls_cust)
		
		ll_job = lds_job.GetItemNumber(ll_jobr, "ab_job_ab_job_num")
		dw_report.SetItem(ll_report_row, "ab_job_num", ll_job)
		
		CONNECT USING SQLCA;

		SELECT order_abc_num, order_item_num INTO :ll_order, :li_item
		FROM ab_job 
		WHERE ab_job_num = :ll_job
		USING SQLCA;

		SELECT sheet_type, gauge, alloy2, temper INTO :ls_shape, :lr_gauge, :ls_alloy, :ls_temper
		FROM order_item
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;

		ls_material = ls_alloy + " - " + ls_temper
		dw_report.SetItem(ll_report_row, "material", ls_material)

		ls_spec = String(lr_gauge, "#.#####")
		CHOOSE CASE Upper(Trim(ls_shape))
			CASE "RECTANGLE"
				SELECT rt_length, rt_width INTO :lr_l, :lr_w
				FROM rectangle
				WHERE order_abc_num = :ll_order AND order_item_num = :li_item
				USING SQLCA;
				ls_spec = ls_spec + " X " + String(lr_l, "#####.#####") + " X " + String(lr_w, "#####.#####")
			CASE "PARALLELOGRAM"
				SELECT p_length, p_width INTO :lr_l, :lr_w
				FROM parallelogram
				WHERE order_abc_num = :ll_order AND order_item_num = :li_item
				USING SQLCA;
				ls_spec = ls_spec + " X " + String(lr_l, "#####.#####") + " X " + String(lr_w, "#####.#####")
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
				ls_spec = ls_spec + " X " + String(lr_l, "#####.#####") + " X " + String(lr_w, "#####.#####")
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
				ls_spec = ls_spec + " X " + String(lr_l, "#####.#####") + " X " + String(lr_s, "#####.#####") + " X " + String(lr_w, "#####.#####")
			CASE "L.TRAPEZOID"
				SELECT ltr_long_length, ltr_short_length, ltr_width INTO :lr_l, :lr_s, :lr_w
				FROM left_trapezoid
				WHERE order_abc_num = :ll_order AND order_item_num = :li_item
				USING SQLCA;
				ls_spec = ls_spec + " X " + String(lr_l, "#####.#####") + " X " + String(lr_s, "#####.#####") + " X " + String(lr_w, "#####.#####")
			CASE "R.TRAPEZOID"
				SELECT rtr_long_length, rtr_short_length, rtr_width INTO :lr_l, :lr_s, :lr_w
				FROM right_trapezoid
				WHERE order_abc_num = :ll_order AND order_item_num = :li_item
				USING SQLCA;
				ls_spec = ls_spec + " X " + String(lr_l, "#####.#####") + " X " + String(lr_s, "#####.#####") + " X " + String(lr_w, "#####.#####")
			CASE ELSE
				ls_spec = ls_spec + " X " + "VAR"
		END CHOOSE	
		dw_report.SetItem(ll_report_row, "spec", ls_spec)

		lds_data = CREATE DataStore

		lds_data.DataObject = "d_report_sales_ab_job_coil"
		lds_data.SetTransObject(SQLCA)
		lds_data.Retrieve(ll_job)
		ll_datarow = lds_data.RowCount()
		IF ll_datarow > 0 THEN
			FOR ll_datar = 1 TO ll_datarow 
				ll_bwt = ll_bwt + lds_data.GetItemNumber(ll_datar, "process_coil_process_quantity" )
			NEXT
		END IF
		dw_report.SetItem(ll_report_row, "begin_wt", ll_bwt)

		lds_data.DataObject = "d_report_sales_sheet_wt"
		lds_data.SetTransObject(SQLCA)
		lds_data.Retrieve(ll_job)
		ll_datarow = lds_data.RowCount()
		IF ll_datarow > 0 THEN
			FOR ll_datar = 1 TO ll_datarow 
				ll_sheetwt = ll_sheetwt + lds_data.GetItemNumber(ll_datar, "prod_item_net_wt" )
			NEXT
		END IF
		dw_report.SetItem(ll_report_row, "ship_wt", ll_sheetwt)

		lds_data.DataObject = "d_report_sales_job_rejcoil"
		lds_data.SetTransObject(SQLCA)
		lds_data.Retrieve(ll_job)
		ll_datarow = lds_data.RowCount()
		IF ll_datarow > 0 THEN
			FOR ll_datar = 1 TO ll_datarow 
				ll_rejwt = ll_rejwt + lds_data.GetItemNumber(ll_datar, "coil_net_wt_balance" )
			NEXT
		END IF
		dw_report.SetItem(ll_report_row, "rej_coil_wt", ll_rejwt)
		
		lds_data.DataObject = "d_report_sales_scrap_item_wt"
		lds_data.SetTransObject(SQLCA)
		lds_data.Retrieve(ll_job)
		ll_datarow = lds_data.RowCount()
		IF ll_datarow > 0 THEN
			FOR ll_datar = 1 TO ll_datarow 
				ll_scrapwt = ll_scrapwt + lds_data.GetItemNumber(ll_datar, "return_item_net_wt" )
			NEXT
		END IF
		dw_report.SetItem(ll_report_row, "scrap_wt", ll_scrapwt)
	
		IF ll_bwt > 0 THEN
			lr_yield = Real(ll_sheetwt) / ll_bwt * 100
		ELSE
			lr_yield = 0
		END IF
		ls_yield = String(lr_yield, "##.##")
		dw_report.SetItem(ll_report_row, "yield", ls_yield)
		
		dw_report.ResetUpdate()
		
		il_bwt = il_bwt + ll_bwt
		il_sheetwt = il_sheetwt + ll_sheetwt
		il_scrapwt = il_scrapwt + ll_scrapwt
		il_rejwt = il_rejwt + ll_rejwt
		ir_y = ir_y + lr_yield

		DESTROY lds_data	

	NEXT
END IF

DESTROY lds_job


end subroutine

on w_report_production_sales.create
int iCurrent
call super::create
this.dw_report=create dw_report
this.cb_print=create cb_print
this.dw_customer=create dw_customer
this.cb_close=create cb_close
this.cb_preview=create cb_preview
this.ddlb_customer=create ddlb_customer
this.em_from=create em_from
this.em_to=create em_to
this.cb_setzoom=create cb_setzoom
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.rb_custall=create rb_custall
this.rb_cust=create rb_cust
this.rb_typeall=create rb_typeall
this.rb_type=create rb_type
this.rb_dateall=create rb_dateall
this.rb_date=create rb_date
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_report
this.Control[iCurrent+2]=this.cb_print
this.Control[iCurrent+3]=this.dw_customer
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.cb_preview
this.Control[iCurrent+6]=this.ddlb_customer
this.Control[iCurrent+7]=this.em_from
this.Control[iCurrent+8]=this.em_to
this.Control[iCurrent+9]=this.cb_setzoom
this.Control[iCurrent+10]=this.gb_3
this.Control[iCurrent+11]=this.gb_2
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.rb_custall
this.Control[iCurrent+14]=this.rb_cust
this.Control[iCurrent+15]=this.rb_typeall
this.Control[iCurrent+16]=this.rb_type
this.Control[iCurrent+17]=this.rb_dateall
this.Control[iCurrent+18]=this.rb_date
this.Control[iCurrent+19]=this.st_1
end on

on w_report_production_sales.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.cb_print)
destroy(this.dw_customer)
destroy(this.cb_close)
destroy(this.cb_preview)
destroy(this.ddlb_customer)
destroy(this.em_from)
destroy(this.em_to)
destroy(this.cb_setzoom)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.rb_custall)
destroy(this.rb_cust)
destroy(this.rb_typeall)
destroy(this.rb_type)
destroy(this.rb_dateall)
destroy(this.rb_date)
destroy(this.st_1)
end on

event open;call super::open;dw_customer.Visible = FALSE
dw_customer.SetTransObject(SQLCA)
dw_customer.Retrieve()
dw_customer.SelectRow(1,TRUE)

Long ll_row, ll_i
ll_row = dw_customer.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		ddlb_customer.AddItem(dw_customer.GetItemString(ll_i, "customer_short_name"))
	NEXT
END IF
ii_type = 2
wf_settitle()
cb_preview.SetFocus()


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

ls_title = ProfileString(gs_ini_file, "REPORT","file_path","c:\temp")+'\' +"Sales_" + ls_cust + '_' + ls_from + '_' + ls_to +".PSR"

IF dw_report.SaveAs(ls_title, PSReport!, FALSE) =-1 THEN
  	MessageBox("Quotation DataStore SaveAs", "Error") 
	RETURN
END IF

MessageBox("Success", "File has been saved as " + ls_title + " Successfully!" )


end event

type dw_report from u_dw within w_report_production_sales
event ue_retrieve ( )
integer x = 29
integer y = 224
integer width = 2629
integer height = 1334
integer taborder = 60
string dataobject = "d_report_production_sales_allcust"
boolean hscrollbar = true
end type

event ue_retrieve;dw_report.Reset()

IF rb_custall.checked and rb_dateall.checked THEN
	IF MessageBox("Question", "It will take a long time to generate this report, continue?", Question!, YesNo!, 2) = 2 THEN
		RETURN
	END IF
END IF

CHOOSE CASE ii_type
	CASE 2
		wf_abco_report()
	CASE 1
		wf_abco_report_detail()
	CASE ELSE
		wf_customer_report()
END CHOOSE

end event

event rbuttondown;//disable
Return 0
end event

event rbuttonup;//disable
Return 0
end event

event constructor;of_SetBase(TRUE)
This.of_SetPrintPreview(TRUE)




end event

type cb_print from u_cb within w_report_production_sales
integer x = 1445
integer y = 1584
integer width = 307
integer height = 74
integer taborder = 90
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;Parent.Event pfc_print()
end event

type dw_customer from u_dw within w_report_production_sales
boolean visible = false
integer x = 2469
integer y = 1603
integer width = 132
integer height = 48
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

event constructor;SetRowFocusIndicator(Hand!)
of_SetBase(TRUE)
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

type cb_close from u_cb within w_report_production_sales
string tag = "Exit"
integer x = 1982
integer y = 1584
integer width = 322
integer height = 74
integer taborder = 100
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_preview from u_cb within w_report_production_sales
event clicked pbm_bnclicked
integer x = 369
integer y = 1584
integer width = 307
integer height = 74
integer taborder = 70
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Retrieve"
end type

event clicked;dw_report.Event ue_retrieve()
RETURN 1
end event

type ddlb_customer from dropdownlistbox within w_report_production_sales
integer x = 300
integer y = 115
integer width = 812
integer height = 973
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
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

dw_report.Reset()
wf_settitle()
//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.

RETURN 1

end event

type em_from from editmask within w_report_production_sales
integer x = 1938
integer y = 118
integer width = 300
integer height = 74
integer taborder = 40
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
end event

type em_to from editmask within w_report_production_sales
integer x = 2326
integer y = 118
integer width = 300
integer height = 74
integer taborder = 50
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
end event

type cb_setzoom from u_cb within w_report_production_sales
integer x = 907
integer y = 1584
integer width = 307
integer height = 74
integer taborder = 80
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&SetZoom"
end type

event clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type gb_3 from u_gb within w_report_production_sales
integer x = 1701
integer width = 958
integer height = 211
integer taborder = 11
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Starting Date"
end type

type gb_2 from u_gb within w_report_production_sales
integer x = 1189
integer width = 472
integer height = 211
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Type"
end type

type gb_1 from u_gb within w_report_production_sales
integer x = 29
integer width = 1112
integer height = 211
integer taborder = 30
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Customer"
end type

type rb_custall from u_rb within w_report_production_sales
integer x = 62
integer y = 58
integer width = 201
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "All"
boolean checked = true
end type

event clicked;IF this.Checked THEN
	ddlb_customer.Enabled = FALSE
	IF rb_typeall.Checked THEN
		ii_type = 2
		dw_report.DataObject = "d_report_production_sales_allcust"
	ELSE
		ii_type = 1
		dw_report.DataObject = "d_report_production_sales_general"
	END IF
	rb_typeall.Enabled = TRUE
	rb_type.Enabled = TRUE
ELSE
	ddlb_customer.Enabled = FALSE
	ii_type = 0
	dw_report.DataObject = "d_report_production_sales_general"
	rb_typeall.Enabled = FALSE
	rb_type.Enabled = FALSE
END IF

dw_report.SetTransObject(SQLCA)
wf_settitle()

//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.
RETURN 1
end event

type rb_cust from u_rb within w_report_production_sales
integer x = 62
integer y = 118
integer width = 216
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Select"
end type

event clicked;IF this.Checked THEN
	ddlb_customer.Enabled = TRUE
	ii_type = 0
	dw_report.DataObject = "d_report_production_sales_general"
	rb_typeall.Enabled = FALSE
	rb_type.Enabled = FALSE
ELSE
	ddlb_customer.Enabled = FALSE
	IF rb_typeall.Checked THEN
		ii_type = 2
		dw_report.DataObject = "d_report_production_sales_allcust"
	ELSE
		ii_type = 1
		dw_report.DataObject = "d_report_production_sales_general"
	END IF											
	rb_typeall.Enabled = TRUE
	rb_type.Enabled = TRUE
END IF

dw_report.SetTransObject(SQLCA)
wf_settitle()

//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.
RETURN 1
end event

type rb_typeall from u_rb within w_report_production_sales
integer x = 1229
integer y = 58
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "General"
boolean checked = true
end type

event clicked;IF this.Checked THEN
	IF rb_custall.Checked THEN
		ii_type = 2
		dw_report.DataObject = "d_report_production_sales_allcust"

		dw_report.SetTransObject(SQLCA)
		wf_settitle()

		//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.

	END IF											
END IF

RETURN 1
end event

type rb_type from u_rb within w_report_production_sales
integer x = 1229
integer y = 122
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Detail"
end type

event clicked;IF this.Checked THEN
	IF rb_custall.Checked THEN
		ii_type = 1
		dw_report.DataObject = "d_report_production_sales_general"

		dw_report.SetTransObject(SQLCA)
		wf_settitle()

		//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.

	END IF											
END IF

RETURN 1
end event

type rb_dateall from u_rb within w_report_production_sales
integer x = 1744
integer y = 58
integer width = 190
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

type rb_date from u_rb within w_report_production_sales
integer x = 1744
integer y = 122
integer width = 197
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
//dw_report.Event ue_retrieve()  //Alex Gerlants. 07/25/2017. Per Laura Anderson's request.
RETURN 1
end event

type st_1 from statictext within w_report_production_sales
integer x = 2253
integer y = 122
integer width = 73
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
string text = "To"
boolean focusrectangle = false
end type

