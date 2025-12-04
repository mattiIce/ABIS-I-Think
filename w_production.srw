$PBExportHeader$w_production.srw
$PBExportComments$<main>Production info inherited from pfemain\w_sheet
forward
global type w_production from w_sheet
end type
type dw_shift_coil_delete_4job from u_dw within w_production
end type
type cb_prod_new from u_cb within w_production
end type
type cb_prod_print from u_cb within w_production
end type
type tab_production from tab within w_production
end type
type tabpage_item from userobject within tab_production
end type
type dw_prod_item from u_dw within tabpage_item
end type
type tabpage_item from userobject within tab_production
dw_prod_item dw_prod_item
end type
type tabpage_shape from userobject within tab_production
end type
type dw_spec_item from u_dw within tabpage_shape
end type
type tabpage_shape from userobject within tab_production
dw_spec_item dw_spec_item
end type
type tabpage_pack from userobject within tab_production
end type
type dw_package_term from u_dw within tabpage_pack
end type
type tabpage_pack from userobject within tab_production
dw_package_term dw_package_term
end type
type tab_production from tab within w_production
tabpage_item tabpage_item
tabpage_shape tabpage_shape
tabpage_pack tabpage_pack
end type
type cb_prod_save from u_cb within w_production
end type
type cb_orderopen from u_cb within w_production
end type
type cb_close from u_cb within w_production
end type
type cb_sum from u_cb within w_production
end type
type gb_3 from groupbox within w_production
end type
type mle_desc from u_mle within w_production
end type
type cb_newsketch from u_cb within w_production
end type
type cb_clearsketch from u_cb within w_production
end type
type dw_prod_order from u_dw within w_production
end type
type tab_mat from tab within w_production
end type
type tabpage_coil from userobject within tab_mat
end type
type dw_prod_coil from u_dw within tabpage_coil
end type
type st_1 from statictext within tabpage_coil
end type
type st_coil# from statictext within tabpage_coil
end type
type st_2 from statictext within tabpage_coil
end type
type st_total_wt from statictext within tabpage_coil
end type
type cb_addcoil from commandbutton within tabpage_coil
end type
type cb_coil_remove from commandbutton within tabpage_coil
end type
type cb_finished from commandbutton within tabpage_coil
end type
type cb_detail_coil from commandbutton within tabpage_coil
end type
type cb_resetwt from commandbutton within tabpage_coil
end type
type tabpage_coil from userobject within tab_mat
dw_prod_coil dw_prod_coil
st_1 st_1
st_coil# st_coil#
st_2 st_2
st_total_wt st_total_wt
cb_addcoil cb_addcoil
cb_coil_remove cb_coil_remove
cb_finished cb_finished
cb_detail_coil cb_detail_coil
cb_resetwt cb_resetwt
end type
type tabpage_wh from userobject within tab_mat
end type
type dw_job_wh_item from u_dw within tabpage_wh
end type
type tabpage_wh from userobject within tab_mat
dw_job_wh_item dw_job_wh_item
end type
type tabpage_partial from userobject within tab_mat
end type
type dw_partial from u_dw within tabpage_partial
end type
type cb_addpartial from u_cb within tabpage_partial
end type
type cb_delpartial from u_cb within tabpage_partial
end type
type tabpage_partial from userobject within tab_mat
dw_partial dw_partial
cb_addpartial cb_addpartial
cb_delpartial cb_delpartial
end type
type tab_mat from tab within w_production
tabpage_coil tabpage_coil
tabpage_wh tabpage_wh
tabpage_partial tabpage_partial
end type
type cb_viewsketch from u_cb within w_production
end type
type cb_wizard from u_cb within w_production
end type
type p_1 from u_p within w_production
end type
end forward

global type w_production from w_sheet
string tag = "Production info"
integer x = 4
integer y = 3
integer width = 3628
integer height = 2298
string title = "Production "
string menuname = "m_prod_main"
boolean maxbox = false
boolean resizable = false
long backcolor = 82042848
event ue_open_porder ( long el_ab_job_id )
event ue_new_order ( )
event type integer ue_add_coil ( long al_coil_num )
event ue_canceled ( integer ai_id )
event ue_open ( )
event type string ue_whoami ( )
event type integer ue_add_wh_item ( long al_item,  string as_packing_ticket )
event ue_read_only ( )
event type integer ue_coil_finish_wt ( datawindow ads_data )
event type integer ue_add_partial ( long al_skid_num )
event type long ue_job_wizard ( )
dw_shift_coil_delete_4job dw_shift_coil_delete_4job
cb_prod_new cb_prod_new
cb_prod_print cb_prod_print
tab_production tab_production
cb_prod_save cb_prod_save
cb_orderopen cb_orderopen
cb_close cb_close
cb_sum cb_sum
gb_3 gb_3
mle_desc mle_desc
cb_newsketch cb_newsketch
cb_clearsketch cb_clearsketch
dw_prod_order dw_prod_order
tab_mat tab_mat
cb_viewsketch cb_viewsketch
cb_wizard cb_wizard
p_1 p_1
end type
global w_production w_production

type variables
long il_current_ab_job_id
Long il_old_job_id
Long il_order
Int ii_item
Boolean ib_new_order
Long il_pic_id
Boolean ib_coilchanged, ib_isrectangle

Boolean		ib_ok_2delete_child_coil_records //Alex Gerlants. 09/13/2016
Long			il_coil_abc_num_2delete //Alex Gerlants. 09/13/2016
String		is_job_status_desc_db, is_job_status_desc_new, is_customer //Alex Gerlants. 09/16/2016
String		is_trimming_required //Alex Gerlants. 10/172016
Decimal{2}	id_edge_trim_yield_percentage //Alex Gerlants. 10/17/2016



end variables

forward prototypes
public function integer wf_retrieve_item_tab ()
public subroutine wf_tabpage_coil_wt ()
public function integer wf_updatespending ()
public function integer wf_save_order ()
public function integer wf_set_sketch_file ()
public function integer wf_ok_to_modify ()
public subroutine wf_get_sketch ()
public function integer wf_check_values ()
public function long wf_number_of_skids ()
public function integer wf_save_order_orig ()
public subroutine wf_set_updatable ()
public subroutine wf_set_non_updatable ()
public function integer wf_number_of_skid_by_coil ()
public function integer wf_delete_child_coils (long al_coil_abc_num)
public function string wf_get_job_status_desc (integer ai_job_status)
public function string wf_get_customer_name ()
public subroutine wf_calc_edge_trim_yield_percentage (datawindow adw, ref decimal ad_edge_trim_yield_percentage)
public function integer wf_count_shape_rows (long al_order_abc_num, integer ai_order_item_num, string as_shape, ref integer ai_die_row_count)
public function integer wf_update_shape_row (long al_order_abc_num, integer ai_order_item_num, string as_table_2update, string as_die_id1, string as_die_id2)
public function integer wf_update_shape_die (datawindow adw, long aab_job_num)
public subroutine wf_compare_coil_width (datawindow adw_spec_item, long al_row, long al_coil, real ar_coil_width, ref string as_msg_out)
public function string wf_get_die_column_name (string as_dataobject)
public function long wf_get_die_id (datawindow adw, ref boolean ab_ab_job_has_die_id)
public subroutine wf_update_shape_dw (ref datawindow adw, long al_die_id)
public function string wf_get_die_id_order_item ()
public function integer wf_check_863_4coil (string as_coil_org_num, ref boolean ab_863_exists)
public function integer wf_check_863_4skids ()
end prototypes

event ue_open_porder;dw_prod_order.inv_linkage.of_Reset()
wf_tabpage_coil_wt()
tab_production.tabpage_item.dw_prod_item.Reset()
tab_production.tabpage_shape.dw_spec_item.Reset()
tab_production.tabpage_pack.dw_package_term.Reset()
tab_mat.tabpage_wh.dw_job_wh_item.Reset()

il_current_ab_job_id = el_ab_job_id

DataWindowChild ldddw_cni
IF dw_prod_order.GetChild("line_num", ldddw_cni) = -1 THEN Return
dw_prod_order.Event pfc_PopulateDDDW("line_num", ldddw_cni)

dw_prod_order.inv_linkage.of_Reset()
IF dw_prod_order.inv_linkage.of_retrieve() = -1 THEN
	sqlca.of_Rollback()
	MessageBox("Error", "w_production::open function" )
ELSE
	SQLCA.of_Commit()
	dw_prod_order.SetFocus()
	dw_prod_order.Visible = TRUE
	wf_retrieve_item_tab()
End IF

wf_tabpage_coil_wt()
wf_get_sketch()


end event

event ue_new_order;dw_prod_order.inv_linkage.of_Reset()
wf_tabpage_coil_wt()
tab_production.tabpage_item.dw_prod_item.Reset()
tab_production.tabpage_shape.dw_spec_item.Reset()
tab_production.tabpage_pack.dw_package_term.Reset()
tab_mat.tabpage_wh.dw_job_wh_item.Reset()

wf_set_non_updatable()
dw_prod_order.Event pfc_addrow()
wf_set_updatable()
ib_new_order = TRUE
wf_retrieve_item_tab()
dw_prod_order.AcceptText()
end event

event type integer ue_add_coil(long al_coil_num);Long ll_row, ll_rowcount
String ls_coil#, ls_coilmid#, ls_lot#, ls_temp, ls_alloy, ls_item_alloy
Long ll_wt, ll_wtbal, ll_coil
Int li_status
Real lr_gauge, lr_width, lr_igauge, lr_igaugep, lr_igaugem, lr_partwidth
String	ls_msg //Alex Gerlants. 05/18/2016

ll_rowcount = tab_mat.tabpage_coil.dw_prod_coil.RowCount()
IF ll_rowcount > 0 THEN
	FOR ll_row = 1 TO ll_rowcount
		ll_coil = tab_mat.tabpage_coil.dw_prod_coil.GetItemNumber(ll_row, "process_coil_coil_abc_num", Primary!, FALSE)
		IF ll_coil = al_coil_num THEN
			MessageBox("Error","Coil had already been asigned to this job", StopSign!)
			Return 0
		END IF
	NEXT
END IF
ll_row = tab_production.tabpage_item.dw_prod_item.GetRow()
IF ll_row > 0 THEN
	lr_igauge = tab_production.tabpage_item.dw_prod_item.GetItemNumber(ll_row, "gauge")
	lr_igaugep = tab_production.tabpage_item.dw_prod_item.GetItemNumber(ll_row, "gauge_p")
	IF IsNULL(lr_igaugep) THEN lr_igaugep = 0
	lr_igaugem = tab_production.tabpage_item.dw_prod_item.GetItemNumber(ll_row, "gauge_m")
	IF IsNULL(lr_igaugem) THEN lr_igaugem = 0
	ls_item_alloy = tab_production.tabpage_item.dw_prod_item.GetItemString(ll_row, "alloy2")
END IF
IF ib_isrectangle THEN
	ll_row = tab_production.tabpage_shape.dw_spec_item.GetRow()
	IF ll_row > 0 THEN
		lr_partwidth = tab_production.tabpage_shape.dw_spec_item.GetItemNumber(ll_row, "rt_width")
		IF IsNULL(lr_partwidth) THEN lr_partwidth = 0		
	END IF
END IF

SetPointer(HourGlass!)
ll_row = tab_mat.tabpage_coil.dw_prod_coil.Event pfc_addrow()
IF ll_row > 0 THEN
	CONNECT USING SQLCA;
	SELECT coil_org_num, lot_num, coil_mid_num, net_wt, net_wt_balance, coil_status, coil_gauge, coil_width, coil_alloy2
	INTO :ls_coil#, :ls_lot#, :ls_coilmid#, :ll_wt, :ll_wtbal, :li_status, :lr_gauge, :lr_width, :ls_alloy
	FROM coil
	WHERE coil_abc_num = :al_coil_num
	USING SQLCA;
	
	tab_mat.tabpage_coil.dw_prod_coil.SetItem(ll_row,"process_coil_coil_abc_num", al_coil_num )	
	tab_mat.tabpage_coil.dw_prod_coil.SetItem(ll_row,"process_coil_ab_job_num",  il_current_ab_job_id )	
	tab_mat.tabpage_coil.dw_prod_coil.SetItem(ll_row,"process_coil_process_quantity",  ll_wtbal )	
	tab_mat.tabpage_coil.dw_prod_coil.SetItem(ll_row,"coil_coil_org_num", ls_coil#)	
	tab_mat.tabpage_coil.dw_prod_coil.SetItem(ll_row,"coil_coil_mid_num",  ls_coilmid# )	
	tab_mat.tabpage_coil.dw_prod_coil.SetItem(ll_row,"coil_net_wt", ll_wt )	
	tab_mat.tabpage_coil.dw_prod_coil.SetItem(ll_row,"coil_net_wt_balance",  ll_wtbal )	
	tab_mat.tabpage_coil.dw_prod_coil.SetItem(ll_row,"coil_coil_gauge",  lr_gauge)	
	tab_mat.tabpage_coil.dw_prod_coil.SetItem(ll_row,"coil_coil_width",  lr_width )	
	tab_mat.tabpage_coil.dw_prod_coil.SetItem(ll_row,"coil_coil_status",  li_status )	
	tab_mat.tabpage_coil.dw_prod_coil.SetItem(ll_row,"process_coil_process_coil_status",  li_status )	
	tab_mat.tabpage_coil.dw_prod_coil.SetItem(ll_row,"coil_lot_num",  ls_lot# )
	
	IF (lr_gauge > 0.1) AND (ll_wtbal / lr_width <= 100.0) THEN
		MessageBox("Warning", "Coil " + String(ll_coil) + " is heavy gauge and small OD coil!")
		ls_temp = dw_prod_order.GetItemString(dw_prod_order.GetRow(), "job_notes",Primary!, FALSE)
		IF IsNULL(ls_temp) THEN
			ls_temp = "Heavy gauge, small OD coil#" + String(al_coil_num) + " must contact foreman before threading."
		ELSE
			ls_temp = "Heavy gauge, small OD coil#" + String(al_coil_num) + " must contact foreman before threading." + ls_temp
		END IF	
		dw_prod_order.SetItem(dw_prod_order.GetRow(), "job_notes", ls_temp)
	END IF
			
	IF (lr_gauge > (lr_igauge + lr_igaugep)) OR (lr_gauge < (lr_igauge - lr_igaugem)) THEN
		//MessageBox("Warning", "Coil " + String(ll_coil) + "'s gauge is questionable for this item!") //Alex Gerlants. 05/18/2016. Comment out
		MessageBox("Warning", "Coil " + String(al_coil_num) + "'s gauge is questionable for this item!") //Alex Gerlants. 05/18/2016 
	END IF

	IF Trim(Upper(ls_alloy)) <> Trim(Upper(ls_item_alloy)) THEN
		IF (Integer(ls_alloy) <> Integer(ls_item_alloy)) OR ( (Integer(ls_alloy)= 0) AND (Integer(ls_item_alloy) = 0)) THEN
			//MessageBox("Warning", "Coil " + String(ll_coil) + "'s alloy is questionable for this item!") //Alex Gerlants. 05/18/2016. Comment out
			MessageBox("Warning", "Coil " + String(al_coil_num) + "'s alloy is questionable for this item!") //Alex Gerlants. 05/18/2016
		END IF
	END IF

	//Alex Gerlants. 05/18/2016. Commented out the 5 lines below. All warnings are created in wf_compare_coil_width()
	//IF ib_isrectangle THEN
	//	IF lr_partwidth <> lr_width THEN
	//		MessageBox("Warning", "Coil " + String(ll_coil) + "'s width is questionable for this item!")
	//	END IF
	//END IF
	
	//Alex Gerlants. 05/18/2016. Begin
	ls_msg = ""
	ll_row = tab_production.tabpage_shape.dw_spec_item.GetRow()
	wf_compare_coil_width(tab_production.tabpage_shape.dw_spec_item, ll_row, al_coil_num, lr_width, ls_msg)

	If ls_msg <> "" Then
		MessageBox("Warning", ls_msg)
	End If
	//Alex Gerlants. 05/18/2016. End

END IF

wf_tabpage_coil_wt()

ib_coilchanged = TRUE

Return 1
end event

event ue_canceled;call super::ue_canceled;IF  il_current_ab_job_id = 0 THEN Close(this)
end event

event ue_open;Int li_rc
IF wf_updatespending() > 0 THEN
	li_rc = MessageBox("Question","Save current production order first?",Question!, YesNo!, 2)
	IF li_rc = 1 THEN wf_save_order()
END IF

Close(this)

SetPointer(HourGlass!)
Message.StringParm = "w_ab_job_list" 
gnv_app.of_getFrame().Event pfc_open()

//open(w_ab_job_browser)

end event

event ue_whoami;RETURN "w_ab_job_list"
end event

event ue_add_wh_item;Long ll_row, ll_order, ll_from, ll_to, ll_bill, ll_net, ll_tare, ll_job
Int li_status
DateTime ld_rc, ld_856, ld_870
String ls_note, ls_locat

ll_row = tab_mat.tabpage_wh.dw_job_wh_item.InsertRow(0)
IF ll_row > 0 THEN
	tab_mat.tabpage_wh.dw_job_wh_item.SetItem(ll_row, "wh_item_num", al_item)
	tab_mat.tabpage_wh.dw_job_wh_item.SetItem(ll_row, "wh_packing_ticket", as_packing_ticket)
   CONNECT USING SQLCA;
	SELECT ASSO_ORDER_ABC_NUM,WH_PRODUCT_FROM,WH_PRODUCT_TO,WH_BILL_TO,WH_NET_WT,WH_TARE_WT,WH_DATE_RECEIVED,WH_STATUS,WH_LOCATION,WH_EDI856_DATE,WH_EDI870_DATE,WH_NOTES,ASSO_AB_JOB_NUM
	INTO :ll_order, :ll_from, :ll_to, :ll_bill, :ll_net, :ll_tare, :ld_rc, :li_status, :ls_locat, :ld_856, :ld_870, :ls_note, :ll_job
	FROM wh_item
	WHERE (wh_item_num = :al_item) AND (wh_packing_ticket = :as_packing_ticket)
	USING SQLCA;
	tab_mat.tabpage_wh.dw_job_wh_item.SetItem(ll_row,"ASSO_ORDER_ABC_NUM", ll_order)
	tab_mat.tabpage_wh.dw_job_wh_item.SetItem(ll_row,"WH_PRODUCT_FROM", ll_from)
	tab_mat.tabpage_wh.dw_job_wh_item.SetItem(ll_row,"WH_PRODUCT_TO", ll_to)
	tab_mat.tabpage_wh.dw_job_wh_item.SetItem(ll_row,"WH_BILL_TO", ll_bill)   
	tab_mat.tabpage_wh.dw_job_wh_item.SetItem(ll_row,"WH_NET_WT", ll_net)
	tab_mat.tabpage_wh.dw_job_wh_item.SetItem(ll_row,"WH_TARE_WT", ll_tare)
	tab_mat.tabpage_wh.dw_job_wh_item.SetItem(ll_row,"WH_DATE_RECEIVED", ld_rc)
	tab_mat.tabpage_wh.dw_job_wh_item.SetItem(ll_row,"WH_STATUS", li_status)   
	tab_mat.tabpage_wh.dw_job_wh_item.SetItem(ll_row,"WH_LOCATION", ls_locat)  
	tab_mat.tabpage_wh.dw_job_wh_item.SetItem(ll_row,"WH_EDI856_DATE", ld_856)
	tab_mat.tabpage_wh.dw_job_wh_item.SetItem(ll_row,"WH_EDI870_DATE", ld_870)   
	tab_mat.tabpage_wh.dw_job_wh_item.SetItem(ll_row,"WH_NOTES",ls_note)   
	tab_mat.tabpage_wh.dw_job_wh_item.SetItem(ll_row,"ASSO_AB_JOB_NUM", ll_job)
	RETURN 1
END IF

RETURN 0
end event

event ue_read_only;cb_prod_new.Enabled = FALSE
cb_prod_save.Enabled = FALSE
tab_mat.tabpage_coil.cb_addcoil.Enabled = FALSE
tab_mat.tabpage_coil.cb_resetwt.Enabled = FALSE
tab_mat.tabpage_coil.cb_coil_remove.Enabled = FALSE
tab_mat.tabpage_coil.cb_finished.Enabled = FALSE
cb_newsketch.Enabled = FALSE
cb_clearsketch.Enabled = FALSE
tab_mat.tabpage_partial.cb_addpartial.Enabled = FALSE
tab_mat.tabpage_partial.cb_delpartial.Enabled = FALSE

mle_desc.Enabled = FALSE

dw_prod_order.Enabled = FALSE
tab_mat.tabpage_coil.dw_prod_coil.Object.DataWindow.ReadOnly = "YES"
tab_mat.tabpage_wh.dw_job_wh_item.Object.DataWindow.ReadOnly = "YES"
tab_mat.tabpage_partial.dw_partial.Object.DataWindow.ReadOnly = "YES"

m_prod_main.m_file.m_save.Disable()

end event

event type integer ue_coil_finish_wt(datawindow ads_data);Long ll_datarow, ll_coilrow, ll_i, ll_j
Long ll_coil, ll_cwt, ll_status, ll_jobcoilstatus
DateTime ld_date

ll_datarow = ads_data.RowCount()
ll_coilrow = tab_mat.tabpage_coil.dw_prod_coil.RowCount()
IF ll_datarow < 1 THEN RETURN 0
IF ll_coilrow < 1 THEN RETURN 0
FOR ll_i = 1 TO ll_datarow
	ll_coil = ads_data.GetItemNumber(ll_i, "abc_num", Primary!, FALSE)
	ll_cwt = ads_data.getItemNumber(ll_i, "lb_cut", Primary!, FALSE)
	ld_date = ads_data.GetItemDateTime(ll_i, "processed_date", Primary!, FALSE)
	ll_jobcoilstatus = ads_data.GetItemNumber(ll_i, "job_coil_status", Primary!, FALSE)
	ll_status = ads_data.GetItemNumber(ll_i, "status", Primary!, FALSE)
	FOR ll_j = 1 TO ll_coilrow
		IF tab_mat.tabpage_coil.dw_prod_coil.GetItemNumber(ll_j,"process_coil_coil_abc_num",Primary!, FALSE) = ll_coil THEN	
			tab_mat.tabpage_coil.dw_prod_coil.SetItem(ll_j,"process_coil_process_date", ld_date) 
			tab_mat.tabpage_coil.dw_prod_coil.SetItem(ll_j,"coil_net_wt_balance", ll_cwt)
			tab_mat.tabpage_coil.dw_prod_coil.SetItem(ll_j,"coil_coil_status", ll_status)
			IF ll_cwt > 1 THEN
				tab_mat.tabpage_coil.dw_prod_coil.SetItem(ll_j,"process_coil_process_coil_status", ll_jobcoilstatus ) 
				tab_mat.tabpage_coil.dw_prod_coil.SetItem(ll_j,"process_coil_process_end_wt",ll_cwt)
			ELSE
				tab_mat.tabpage_coil.dw_prod_coil.SetItem(ll_j,"process_coil_process_coil_status", 0 ) //else done
				tab_mat.tabpage_coil.dw_prod_coil.SetItem(ll_j,"process_coil_process_end_wt",0)
			END IF
		END IF
	NEXT
NEXT

RETURN 1
end event

event ue_add_partial;Long ll_row, ll_rowcount
Long ll_skid, ll_net, ll_tare, ll_job, ll_pc
DateTime ld_d
string ls_l

ll_rowcount = tab_mat.tabpage_partial.dw_partial.RowCount()
IF ll_rowcount > 0 THEN
	FOR ll_row = 1 TO ll_rowcount
		ll_skid = tab_mat.tabpage_partial.dw_partial.GetItemNumber(ll_row, "sheet_skid_num", Primary!, FALSE)
		IF ll_skid = al_skid_num THEN
			MessageBox("Error","This partial skid had already been asigned to this job", StopSign!)
			Return -1
		END IF
	NEXT
END IF

SetPointer(HourGlass!)
ll_row = tab_mat.tabpage_partial.dw_partial.Event pfc_addrow()
IF ll_row > 0 THEN
	CONNECT USING SQLCA;
	SELECT ab_job_num, sheet_net_wt, sheet_tare_wt,  skid_pieces, skid_date, skid_location
	INTO :ll_job, :ll_net, :ll_tare, :ll_pc, :ld_d, :ls_l
	FROM sheet_skid
	WHERE sheet_skid_num = :al_skid_num
	USING SQLCA;
	
	tab_mat.tabpage_partial.dw_partial.SetItem(ll_row,"sheet_skid_num", al_skid_num )	
	tab_mat.tabpage_partial.dw_partial.SetItem(ll_row,"ab_job_num",  il_current_ab_job_id )	
	tab_mat.tabpage_partial.dw_partial.SetItem(ll_row,"partial_skid_ab_job_num",  ll_job )	
	tab_mat.tabpage_partial.dw_partial.SetItem(ll_row,"partial_sheet_net_wt",  ll_net )	
	tab_mat.tabpage_partial.dw_partial.SetItem(ll_row,"sheet_skid_sheet_tare_wt", ll_tare)	
	tab_mat.tabpage_partial.dw_partial.SetItem(ll_row,"partial_skid_pieces",  ll_pc )	
	tab_mat.tabpage_partial.dw_partial.SetItem(ll_row,"partial_skid_date",  ld_d )	
	tab_mat.tabpage_partial.dw_partial.SetItem(ll_row,"process_partial_skid_partial_skid_locati", ls_l )	
ELSE
	RETURN -2
END IF

Return 1
end event

event type long ue_job_wizard();s_wizard_question lstr_q
Long ll_qty, ll_sheetwt, ll_pcskid, ll_skid
Real lr_yield

Long ll_temp, ll_coil_wt
Int li_row, li_i, li_sheettype, li_item
Long ll_prodrow, ll_order, ll_max_skid_wt, ll_syspcskid
Real lr_pcwt

Long			ll_order_abc_num, ll_order_item_num, ll_ab_job_num //Alex Gerlants. 10/17/2016
String		ls_modstring, ls_rtn //Alex Gerlants. 10/17/2016
Decimal{3}	ld_edge_trim_scrap_percentage //Alex Gerlants. 09/16/2016
//Decimal{2}	ld_edge_trim_yield_percentage //Alex Gerlants. 10/17/2016
Boolean		lb_cancel //Alex Gerlants. 09/16/2016
nvuo_parm	lnvuo_parm //Alex Gerlants. 10/17/2016

ll_prodrow = dw_prod_order.GetRow()
IF ll_prodrow < 1 THEN RETURN 0

ll_qty = 0
li_row = tab_mat.tabpage_coil.dw_prod_coil.RowCount()
IF li_row > 0 THEN
	FOR li_i = 1 TO li_row
		ll_coil_wt = 0
		ll_coil_wt = tab_mat.tabpage_coil.dw_prod_coil.GetItemNumber(li_i,"process_coil_process_quantity", Primary!, FALSE )	
		IF NOT(IsNULL(ll_coil_wt)) THEN ll_qty = ll_qty + ll_coil_wt
	NEXT
END IF

lr_yield = dw_prod_order.GetItemNumber(ll_prodrow, "material_yield", Primary!, FALSE)
IF IsNULL(lr_yield) OR lr_yield <= 0  THEN 
	MessageBox("Warning", "Invalid yield value.")
	RETURN -1
END IF

ll_sheetwt = Long(ll_qty * lr_yield)

ll_order = dw_prod_order.GetItemNumber(ll_prodrow, "order_abc_num", Primary!, FALSE)
li_item = dw_prod_order.GetItemNumber(ll_prodrow, "order_item_num", Primary!, FALSE)
CONNECT USING SQLCA;
SELECT CUSTOMER_ORDER.SHEET_HANDLING_TYPE INTO :li_sheettype
FROM CUSTOMER_ORDER 
WHERE CUSTOMER_ORDER.ORDER_ABC_NUM = :ll_order
USING SQLCA;
SELECT max_skid_wt, theoretical_unit_wt, pieces_skid INTO :ll_max_skid_wt, :lr_pcwt, :ll_syspcskid
FROM order_item
WHERE order_abc_num = :ll_order AND order_item_num = :li_item
USING SQLCA;
IF IsNULL(ll_max_skid_wt) OR ll_max_skid_wt <= 0  THEN 
	MessageBox("Warning", "Invalid max skid weight value.")
	RETURN -1
END IF
IF IsNULL(lr_pcwt) OR lr_pcwt <= 0  THEN 
	MessageBox("Warning", "Invalid theo. piece weight value.")
	RETURN -1
END IF

CHOOSE CASE li_sheettype
	CASE 1
		ll_skid = wf_number_of_skid_by_coil()
		lstr_q.combine_lot = FALSE
	CASE ELSE
		ll_skid = Ceiling( ll_sheetwt / ll_max_skid_wt)
		lstr_q.combine_lot = TRUE
END CHOOSE

lstr_q.qty = ll_qty
lstr_q.sheet = ll_sheetwt
lstr_q.yield = lr_yield
lstr_q.theo_pcwt = lr_pcwt
lstr_q.pcskid = ll_syspcskid
lstr_q.max_skid_wt = ll_max_skid_wt
lstr_q.skid = ll_skid

//Alex Gerlants. 10/17/2016. Begin
//I needed to add variables to s_wizard_question; but I could not find s_wizard_question anywhere.
//Thus I used nvuo_parm to pass all 8 existing parameters plus ll_order_abc_num to w_job_wizard.
ll_order_abc_num = dw_prod_order.Object.order_abc_num[dw_prod_order.GetRow()]
ll_order_item_num = dw_prod_order.Object.order_item_num[dw_prod_order.GetRow()]
ll_ab_job_num = dw_prod_order.Object.ab_job_num[dw_prod_order.GetRow()]

lnvuo_parm.uf_set_b("combine_lot", lstr_q.combine_lot)
lnvuo_parm.uf_set_l("qty", ll_qty)
lnvuo_parm.uf_set_l("sheet", ll_sheetwt)
lnvuo_parm.uf_set_r("yield", lr_yield)
lnvuo_parm.uf_set_r("theo_pcwt", lr_pcwt)
lnvuo_parm.uf_set_l("pcskid", ll_syspcskid)
lnvuo_parm.uf_set_l("max_skid_wt", ll_max_skid_wt)
lnvuo_parm.uf_set_l("skid", ll_skid)
lnvuo_parm.uf_set_l("order_abc_num", ll_order_abc_num)
lnvuo_parm.uf_set_l("order_item_num", ll_order_item_num)
lnvuo_parm.uf_set_l("ab_job_num", ll_ab_job_num)
lnvuo_parm.uf_set_dc("edge_trim_yield_percentage", id_edge_trim_yield_percentage)
lnvuo_parm.uf_set_s("trimming_required", is_trimming_required)

OpenwithParm(w_job_wizard_2, lnvuo_parm)
lnvuo_parm = Message.PowerObjectParm

ll_qty = lnvuo_parm.uf_get_l("qty")
ll_sheetwt = lnvuo_parm.uf_get_l("sheet")
lr_yield = lnvuo_parm.uf_get_r("yield")
ll_syspcskid = lnvuo_parm.uf_get_l("pcskid")
ll_skid = lnvuo_parm.uf_get_l("skid")
lb_cancel = lnvuo_parm.uf_get_b("Cancel")

If Not lb_cancel Then
	//Disable column material_yield on dw_prod_order
	ls_modstring = "material_yield.Protect='1'"
	ls_rtn = dw_prod_order.Modify(ls_modstring)
	
	ls_modstring = "material_yield.Background.Color='12632256'"
	ls_rtn = dw_prod_order.Modify(ls_modstring)
Else
//	//Enable column material_yield on dw_prod_order
//	ls_modstring = "material_yield.Protect='0'"
//	ls_rtn = dw_prod_order.Modify(ls_modstring)
//	
//	ls_modstring = "material_yield.Background.Color='553648127'"
//	ls_rtn = dw_prod_order.Modify(ls_modstring)
End If

lstr_q.qty = ll_qty
lstr_q.sheet = ll_sheetwt
lstr_q.yield = lr_yield
lstr_q.pcskid = ll_syspcskid
lstr_q.skid = ll_skid
lstr_q.Cancel = lb_cancel
//ls_trimming_required = lnvuo_parm.uf_get_s("trimming_required")

//If is_trimming_required = "Y" Then
//	ld_edge_trim_scrap_percentage = lnvuo_parm.uf_get_dc("edge_trim_scrap_percentage")
//	dw_prod_order.Object.edge_trim_scrap_percentage[dw_prod_order.GetRow()] = ld_edge_trim_scrap_percentage
//End If
//Alex Gerlants. 10/17/2016. End

//OpenwithParm(w_job_wizard, lstr_q) //Alex Gerlants. 10/17/2016. Comment out
//lstr_q = Message.PowerObjectParm //Alex Gerlants. 10/17/2016. Comment out

IF NOT(lstr_q.Cancel) THEN
	dw_prod_order.SetItem(ll_prodrow, "ab_job_job_process_quantity", lstr_q.qty)
	dw_prod_order.SetItem(ll_prodrow, "ab_job_job_sheet_wt", lstr_q.sheet)
	dw_prod_order.SetItem(ll_prodrow, "ab_job_job_skid", lstr_q.skid)
	dw_prod_order.SetItem(ll_prodrow, "material_yield", lstr_q.yield)
	IF (li_sheettype <> 1) OR IsNULL(li_sheettype) THEN
		ll_pcskid =  lstr_q.pcskid
	ELSE
		SetNULL(ll_pcskid)
	END IF
	dw_prod_order.SetItem(ll_prodrow, "ab_job_job_pieces_skid", ll_pcskid)
	ib_coilchanged = FALSE
END IF

RETURN 1

end event

public function integer wf_retrieve_item_tab ();Integer li_row
li_row = dw_prod_order.GetRow()
ii_item = 0
il_order = 0
tab_production.tabpage_item.dw_prod_item.Reset()
tab_production.tabpage_shape.dw_spec_item.Reset()
tab_production.tabpage_pack.dw_package_term.Reset()

IF li_row > 0 THEN
	ii_item = dw_prod_order.GetItemNumber(li_row, "order_item_num", Primary!, FALSE )
	il_order = dw_prod_order.GetItemNumber( li_row, "order_abc_num", Primary!, FALSE )
	IF (ii_item <= 0) OR (il_order <= 0) THEN
		//MessageBox("Warning", "No customer order OR order item specified!" )
		Return -1
	END IF
	tab_production.tabpage_item.dw_prod_item.Event pfc_Retrieve()
	tab_production.tabpage_shape.dw_spec_item.Event pfc_Retrieve()
	tab_production.tabpage_pack.dw_package_term.Event pfc_Retrieve()
	Return 1
END IF

Return 0
end function

public subroutine wf_tabpage_coil_wt ();Long ll_total_wt, ll_coil_wt
Int li_row, li_int

ll_total_wt = 0
li_row = 0
li_row = tab_mat.tabpage_coil.dw_prod_coil.RowCount()
IF li_row > 0 THEN
	tab_mat.tabpage_coil.st_coil#.Text = String(li_row)
	FOR li_int = 1 TO li_row
		ll_coil_wt = 0
		ll_coil_wt = tab_mat.tabpage_coil.dw_prod_coil.GetItemNumber(li_int,"process_coil_process_quantity", Primary!, FALSE )	
		ll_total_wt = ll_total_wt + ll_coil_wt
		tab_mat.tabpage_coil.st_total_wt.Text = String(ll_total_wt, "###,###,###") + "  lbs"
	NEXT
ELSE
	tab_mat.tabpage_coil.st_coil#.Text = "0"
	tab_mat.tabpage_coil.st_total_wt.Text = "0 lb"
END IF

end subroutine

public function integer wf_updatespending ();Int li_return, li_dw_spec_item_modified_count

dw_prod_order.AcceptText()
tab_mat.tabpage_coil.dw_prod_coil.AcceptText()

tab_production.tabpage_shape.dw_spec_item.AcceptText() //Alex Gerlants. 03/27/2017
li_dw_spec_item_modified_count = tab_production.tabpage_shape.dw_spec_item.ModifiedCount() //Alex Gerlants. 03/27/2017

li_return = dw_prod_order.inv_linkage.of_GetUpdatesPending()

IF li_return = -1 THEN
	//accceptText error
	MessageBox("Edit Errors", "Check for valid data" )
	Return -1
ELSEIF li_return = 1 Or li_dw_spec_item_modified_count > 0 THEN //Alex Gerlants. 03/27/2017. Added " Or li_dw_spec_item_modified_count > 0".
	//Change
	Return 1
END IF
	
RETURN 0
end function

public function integer wf_save_order ();SetPointer(HourGlass!)
int li_return
Long skid_pieces, max_skid_wt, est_skid_wt
Integer	li_rtn //Alex Gerlants. 03/27/2017

//Date: 03/09/04
//Author: victor huang
//Problem: Est. wt excesss Max skid wt
tab_production.tabpage_item.dw_prod_item.AcceptText()
skid_pieces = dw_prod_order.GetItemNumber(1,"ab_job_job_pieces_skid")
max_skid_wt = tab_production.tabpage_item.dw_prod_item.GetItemNumber(1, "max_skid_wt")
est_skid_wt = tab_production.tabpage_item.dw_prod_item.GetItemNumber(1, "theoretical_unit_wt") * skid_pieces

if (est_skid_wt > max_skid_wt) then
	MessageBox("Warning", "ESTIMATED SKID WT. EXCEEDS MAX SKID WT. MUST RE-EDIT!!!")
	return -1
end if

dw_prod_order.AcceptText()
tab_mat.tabpage_coil.dw_prod_coil.AcceptText()
li_return = dw_prod_order.inv_linkage.of_update(TRUE,FALSE)
	IF li_return <> 1 THEN
		ROLLBACK USING SQLCA;
		IF SQLCA.SQLCODE <> 0 THEN
			MessageBox("Rollback Error", SQLCA.SQLErrText)
		ELSE
			MessageBox("Update Failed", "Rollback Succeeded")
		END IF
		Return -1
	END IF

//Alex Gerlants. 03/27/2017. Begin
//Update ab_job.die_id
li_rtn = wf_update_shape_die(tab_production.tabpage_shape.dw_spec_item, il_current_ab_job_id)

If li_rtn <> 1 Then //Error in wf_update_shape_die()
	ROLLBACK USING SQLCA;
	
	IF SQLCA.SQLCODE <> 0 THEN
		MessageBox("Rollback Error", SQLCA.SQLErrText)
	ELSE
		MessageBox("Update Failed", "Rollback Succeeded")
	END IF
	Return -1
End If
//Alex Gerlants. 03/27/2017. End	
	
COMMIT using SQLCA;
	IF SQLCA.SQLCODE <> 0 THEN
		MessageBox("Commit Error", SQLCA.SQLErrText)
		Return -6
	END IF
dw_prod_order.inv_linkage.of_ResetUpdate()

Return 1
end function

public function integer wf_set_sketch_file ();//copy current sketch to current directory sketch.jpg file
// and will be used in the production order report
Int li_filenum
Long ll_flen
Long ll_new_pos
Int li_loops, li_i
Blob lb_pic

SetPointer(HourGlass!)

SELECTBLOB sketch_view 
INTO :lb_pic
FROM sketch_jpg
WHERE sketch_id = :il_pic_id
USING SQLCA;
IF SQLCA.SQLCode = -1 THEN
	MessageBox("SQL ERROR", SQLCA.SQLErrText, StopSign!)
	Return -1
END IF

ll_flen = Len(lb_pic)
IF ll_flen > 32765 THEN
	IF Mod(ll_flen, 32765) = 0 THEN
		li_loops = ll_flen / 32765
	ELSE
		li_loops = (ll_flen / 32765) + 1
	END IF
ELSE
	li_loops = 1
END IF

ll_new_pos = 1
li_filenum = FileOpen(gs_Sketch_file, StreamMode!, Write!, LockReadWrite!, Replace!)
FileWrite(li_filenum, BlobMid(lb_pic, 0, 32765))
FileClose(li_FileNum)

FOR li_i = 1 TO li_loops
	li_filenum = FileOpen(gs_Sketch_file, StreamMode!, Write!, LockreadWrite!,Append!)
	FileWrite(li_filenum, BlobMid(lb_pic, li_i*32765, 32765) )
	FileClose(li_FileNum)
NEXT

Return 1


end function

public function integer wf_ok_to_modify ();Long ll_row, ll_order_id
Int li_status

ll_row = dw_prod_order.GetRow()
IF ll_row > 0 THEN 
	ll_order_id = dw_prod_order.GetItemNumber(ll_row, "order_abc_num", Primary!, FALSE)
	li_status = dw_prod_order.GetItemNumber(ll_row, "job_status", Primary!, FALSE)
ELSE
	MessageBox("Warning", "NO ABC Order specified in the production order")
	Return -1
END IF
IF li_status = 0 THEN 
	MessageBox("Warning", "This job is done, nothing can be modified now.")
	Return -2
END IF

RETURN 1

end function

public subroutine wf_get_sketch ();int li_rc
Blob lb_pic

SELECT sketch_id, sketch_job_note
INTO :il_pic_id,:mle_desc.Text 
FROM ab_job
WHERE ab_job_num = :il_current_ab_job_id
USING SQLCA;
IF SQLCA.SQLCode = -1 THEN
	MessageBox("SQL ERROR", SQLCA.SQLErrText, StopSign!)
	Return
END IF
IF IsNUll(il_pic_id) OR il_pic_id < 1 THEN 
	SetNULL(lb_pic)
	p_1.SetPicture(lb_pic)
	Return
END IF

SetPointer(HourGlass!)

SELECTBLOB sketch_view 
INTO :lb_pic
FROM sketch_jpg
WHERE sketch_id = :il_pic_id
USING SQLCA;
IF SQLCA.SQLCode = -1 THEN
	MessageBox("SQL ERROR", SQLCA.SQLErrText, StopSign!)
	Return
END IF
p_1.SetPicture(lb_pic)

end subroutine

public function integer wf_check_values ();Long ll_line, ll_row, ll_i, ll_coil
Real lr_m_width, lr_i_thick, lr_m_thick, lr_m_wt
Real lr_c_gauge, lr_c_width, lr_c_netwt, lr_c_netbal
Int li_rc
String ls_msg
String ls_notes

dw_prod_order.AcceptText()
ll_row = dw_prod_order.GetRow()
ll_line = dw_prod_order.getItemNumber(ll_row, "line_num", Primary!, FALSE)
IF IsNULL(ll_line) OR ll_line < 1 THEN RETURN 1

CONNECT USING SQLCA;
SELECT max_width, min_thickness, max_thickness,max_weight
INTO :lr_m_width, :lr_i_thick, :lr_m_thick, :lr_m_wt
FROM line
WHERE line_num = :ll_line
USING SQLCA;

tab_mat.tabpage_coil.dw_prod_coil.AcceptText()
ll_row = tab_mat.tabpage_coil.dw_prod_coil.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		ll_coil = tab_mat.tabpage_coil.dw_prod_coil.GetItemNumber(ll_i,"process_coil_coil_abc_num")
		lr_c_gauge = tab_mat.tabpage_coil.dw_prod_coil.GetItemNumber(ll_i,"coil_coil_gauge")
		IF IsNULL(lr_c_gauge) THEN lr_c_gauge = 0
		lr_c_width = tab_mat.tabpage_coil.dw_prod_coil.GetItemNumber(ll_i,"coil_coil_width")
		IF IsNULL(lr_c_width) THEN lr_c_width = 0
		lr_c_netbal = tab_mat.tabpage_coil.dw_prod_coil.GetItemNumber(ll_i,"coil_net_wt_balance")
		IF IsNULL(lr_c_netbal) THEN lr_c_netbal = 0
		lr_c_netwt = tab_mat.tabpage_coil.dw_prod_coil.GetItemNumber(ll_i,"coil_net_wt")
		IF IsNULL(lr_c_netwt) THEN lr_c_netwt = 0
		IF lr_c_netbal > 0 THEN lr_c_netwt = MIN(lr_c_netwt, lr_c_netbal)
		
		IF (lr_c_gauge >= 0.1) AND ((lr_c_netbal / lr_c_width) <= 100.0) THEN
			ls_msg = "Coil " + String(ll_coil) + " is heavy gauge and small OD coil!, Continue?"
			li_rc = MessageBox("Warning", ls_msg , Question!, YesNo!, 2)
			IF li_rc = 2 THEN RETURN -1
			
		END IF
		IF lr_c_netwt > lr_m_wt THEN
			ls_msg = "Coil " + String(ll_coil) + " overweight, please change this coil or this production line!, Continue?"
			li_rc = MessageBox("Warning", ls_msg , Question!, YesNo!, 2)
			IF li_rc = 2 THEN RETURN -1
		END IF
		IF lr_c_width > lr_m_width THEN
			ls_msg = "Coil " + String(ll_coil) + " overwidth, please change this coil or this production line!, Continue?"
			li_rc = MessageBox("Warning", ls_msg , Question!, YesNo!, 2)
			IF li_rc = 2 THEN RETURN -1
		END IF
		IF lr_c_gauge > lr_m_thick THEN
			ls_msg = "Coil " + String(ll_coil) + " overthickness, please change this coil or this production line!, Continue?"
			li_rc = MessageBox("Warning", ls_msg , Question!, YesNo!, 2)
			IF li_rc = 2 THEN RETURN -1
		END IF
		IF lr_c_gauge < lr_i_thick THEN
			ls_msg = "Coil " + String(ll_coil) + " too thin, please change this coil or this production line!, Continue?"
			li_rc = MessageBox("Warning", ls_msg , Question!, YesNo!, 2)
			IF li_rc = 2 THEN RETURN -1
		END IF
	NEXT
END IF
 
RETURN 1
end function

public function long wf_number_of_skids ();Long ll_row, ll_i, ll_j, ll_skid, ll_lotwt, ll_l
String ls_loted[], ls_lot
Boolean lb_existed
Real lr_yield
Long ll_max, ll_order
Int li_item

ll_row = dw_prod_order.GetRow()
IF ll_row <= 0 THEN RETURN 0
lr_yield = dw_prod_order.GetItemNumber(ll_row, "material_yield", Primary!, FALSE)

ll_order = dw_prod_order.GetItemNumber(ll_row, "order_abc_num", Primary!, FALSE)
li_item = dw_prod_order.GetItemNumber(ll_row, "order_item_num", Primary!, FALSE)
CONNECT USING SQLCA;
SELECT max_skid_wt INTO :ll_max
FROM order_item
WHERE order_abc_num = :ll_order AND order_item_num = :li_item
USING SQLCA;

ll_skid = 0
ll_row = tab_mat.tabpage_coil.dw_prod_coil.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		lb_existed = FALSE
		ls_lot = tab_mat.tabpage_coil.dw_prod_coil.GetItemString(ll_i,"coil_lot_num", Primary!, FALSE )
		FOR ll_l = 1 TO UpperBound(ls_loted)
			IF ls_loted[ll_l] = ls_lot THEN lb_existed = TRUE
		NEXT
		IF NOT(lb_existed) THEN ls_loted[UpperBound(ls_loted) + 1] = ls_lot
	NEXT
	FOR ll_l = 1 To UpperBound(ls_loted)
		ll_lotwt = 0
		FOR ll_i = 1 TO ll_row
			IF tab_mat.tabpage_coil.dw_prod_coil.GetItemString(ll_i,"coil_lot_num", Primary!, FALSE ) = ls_loted[ll_l] THEN
				ll_lotwt = ll_lotwt + tab_mat.tabpage_coil.dw_prod_coil.GetItemNumber(ll_i,"process_coil_process_quantity", Primary!, FALSE )
			END IF
		NEXT
		IF (ll_max > 0) AND (lr_yield > 0) THEN
			ll_skid = ll_skid + Ceiling( ll_lotwt * lr_yield / ll_max )
		END IF
	NEXT
END IF

RETURN ll_skid

end function

public function integer wf_save_order_orig ();SetPointer(HourGlass!)
int li_return
Integer	li_rtn //Alex Gerlants. 03/27/2017. Begin

dw_prod_order.AcceptText()
tab_mat.tabpage_coil.dw_prod_coil.AcceptText()
li_return = dw_prod_order.inv_linkage.of_update(TRUE,FALSE)
	IF li_return <> 1 THEN
		ROLLBACK USING SQLCA;
		IF SQLCA.SQLCODE <> 0 THEN
			MessageBox("Rollback Error", SQLCA.SQLErrText)
		ELSE
			MessageBox("Update Failed", "Rollback Succeeded")
		END IF
		Return -1
	END IF
	
//Alex Gerlants. 03/27/2017. Begin
//Update ab_job.die_id
li_rtn = wf_update_shape_die(tab_production.tabpage_shape.dw_spec_item, il_current_ab_job_id)

If li_rtn <> 1 Then //Error in wf_update_shape_die()
	ROLLBACK USING SQLCA;
	
	IF SQLCA.SQLCODE <> 0 THEN
		MessageBox("Rollback Error", SQLCA.SQLErrText)
	ELSE
		MessageBox("Update Failed", "Rollback Succeeded")
	END IF
	Return -1
End If
//Alex Gerlants. 03/27/2017. End	
	
COMMIT using SQLCA;
	IF SQLCA.SQLCODE <> 0 THEN
		MessageBox("Commit Error", SQLCA.SQLErrText)
		Return -6
	END IF
dw_prod_order.inv_linkage.of_ResetUpdate()

Return 1
end function

public subroutine wf_set_updatable ();dw_prod_order.SetTabOrder("material_yield", 10)
dw_prod_order.SetTabOrder("number_of_men_used", 20)
dw_prod_order.SetTabOrder("line_num", 30)
dw_prod_order.SetTabOrder("job_status", 40)
dw_prod_order.SetTabOrder("due_date", 50)
dw_prod_order.SetTabOrder("time_date_started", 60)
dw_prod_order.SetTabOrder("time_date_finished", 70)
dw_prod_order.SetTabOrder("time_date_finished", 80)
dw_prod_order.SetTabOrder("job_notes", 90)
dw_prod_order.SetTabOrder("ab_job_job_reference_codes", 100)
dw_prod_order.SetTabOrder("ab_job_nonconforming", 120)


end subroutine

public subroutine wf_set_non_updatable ();dw_prod_order.SetTabOrder("number_of_men_used", 0)
dw_prod_order.SetTabOrder("material_yield", 0)
dw_prod_order.SetTabOrder("line_num", 0)
dw_prod_order.SetTabOrder("job_status", 0)
dw_prod_order.SetTabOrder("due_date", 0)
dw_prod_order.SetTabOrder("time_date_started", 0)
dw_prod_order.SetTabOrder("time_date_finished", 0)
dw_prod_order.SetTabOrder("time_date_finished", 0)
dw_prod_order.SetTabOrder("job_notes", 0)
dw_prod_order.SetTabOrder("ab_job_job_reference_codes", 0)
dw_prod_order.SetTabOrder("ab_job_nonconforming", 0)

end subroutine

public function integer wf_number_of_skid_by_coil ();Long ll_row, ll_i, ll_j, ll_skid, ll_coilwt, ll_l
//String ls_loted[], ls_lot
//Boolean lb_existed
Real lr_yield
Long ll_max, ll_order
Int li_item

ll_row = dw_prod_order.GetRow()
IF ll_row <= 0 THEN RETURN 0
lr_yield = dw_prod_order.GetItemNumber(ll_row, "material_yield", Primary!, FALSE)

ll_order = dw_prod_order.GetItemNumber(ll_row, "order_abc_num", Primary!, FALSE)
li_item = dw_prod_order.GetItemNumber(ll_row, "order_item_num", Primary!, FALSE)
CONNECT USING SQLCA;
SELECT max_skid_wt INTO :ll_max
FROM order_item
WHERE order_abc_num = :ll_order AND order_item_num = :li_item
USING SQLCA;

ll_skid = 0
ll_row = tab_mat.tabpage_coil.dw_prod_coil.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		ll_coilwt = tab_mat.tabpage_coil.dw_prod_coil.GetItemNumber(ll_i,"process_coil_process_quantity", Primary!, FALSE )
		IF (ll_max > 0) AND (lr_yield > 0) THEN
			ll_skid = ll_skid + Ceiling( ll_coilwt * lr_yield / ll_max )
		END IF
	NEXT
END IF

RETURN ll_skid

end function

public function integer wf_delete_child_coils (long al_coil_abc_num);//Alex Gerlants. 09/13/2016. Begin
/*
Function:	wf_delete_child_coils
Returns:		integer
Arguments:	value		long	al_coil_abc_num
*/

Integer		li_rtn = 1
Long			ll_rows, ll_row, ll_coil_abc_num
String		ls_system_log_msg
//transaction tran_2delete

ll_rows = dw_shift_coil_delete_4job.RowCount() 	/*	It was retrieved in Open event for w_production as a part 
																	of linkage:	dw_prod_order
																					dw_shift_coil_delete_4job <== This datawindow
																					dw_prod_coil
																					dw_job_wh_item
																					dw_partial
																*/
If ll_rows > 0 Then
	ls_system_log_msg = 	"Job " + String(il_current_ab_job_id) + &
								" Customer " + is_customer + &
								" by " + gnv_app.of_GetUserId() + ". " + &
								String(Today(), "mm-dd-yyyy @HH:MM.") + &
								" Deleted child coil records from table shift_coil for coil " + String(al_coil_abc_num)

	f_add_system_log_tran(ls_system_log_msg, sqlca)
	
	For ll_row = ll_rows To 1 Step -1
		ll_coil_abc_num = dw_shift_coil_delete_4job.Object.coil_abc_num[ll_row]
		
		If ll_coil_abc_num = al_coil_abc_num Then
			dw_shift_coil_delete_4job.DeleteRow(ll_row)
		End If
	Next
End If

Return li_rtn

//---

//tran_2delete = create transaction
//tran_2delete.DBMS = ProfileString(gs_ini_file,"Database","DBMS","")
//tran_2delete.Servername = ProfileString(gs_ini_file,"Database","ServerName","")
//tran_2delete.LogID = gs_LogID
//tran_2delete.LogPass = gs_LogPass
//
//connect using tran_2delete;
//
//If tran_2delete.SQLCode < 0 Then 
//	MessageBox("DB Error", "Failed to connect to database to delete child coil records for job " + &
//								String(al_ab_job_num) + " and coil " + String(al_coil_abc_num) + &
//								"~n~rError:~n~r" + tran_2delete.sqlerrtext, Exclamation!)
//	
//   li_rtn = -1
//End If
//
//If li_rtn = 1 Then
//	delete from shift_coil
//	where		ab_job_num = :al_ab_job_num
//	and		coil_abc_num = :al_coil_abc_num
//	using		tran_2delete;
//	
//	If tran_2delete.sqlcode = 0 Then //OK
//		commit using tran_2delete;
//	Else //DB error
//		rollback using tran_2delete;
//		li_rtn = -1
//		
//		MessageBox("DB Error", "Database error while trying to delete child coil records for job " + &
//								String(al_ab_job_num) + " and coil " + String(al_coil_abc_num) + &
//								"~n~rError:~n~r" + tran_2delete.sqlerrtext)
//	End If
//	
//	disconnect using tran_2delete;
//	destroy tran_2delete;
//End If

//Return li_rtn
//Alex Gerlants. 09/13/2016. End
end function

public function string wf_get_job_status_desc (integer ai_job_status);//Alex Gerlants. 09/16/2016. Begin
/*
Function:	wf_get_job_status_desc
Returns:		string	<== job status description
Arguments:	value	integer	ai_job_status
*/
String	ls_job_status_desc

Choose Case ai_job_status
	Case 0
		ls_job_status_desc = "Done"
	Case 1
		ls_job_status_desc = "InProcess"
	Case 2
		ls_job_status_desc = "New"
	Case 3
		ls_job_status_desc = "Canceled"
	Case 4
		ls_job_status_desc = "OnHold"
	Case Else
		ls_job_status_desc = ""
End Choose

Return ls_job_status_desc
//Alex Gerlants. 09/16/2016. End
end function

public function string wf_get_customer_name ();//Alex Gerlants. 09/16/2016. Begin
/*
Function:	wf_get_customer_name
Returns:		string <== Customer name
Arguments:	none
*/
String				ls_customer
String				ls_system_log_msg, ls_find_string
Integer				li_rtn
Long					ll_customer_id, ll_found_row
DataWindowChild	ldwc 

ll_customer_id = dw_prod_order.Object.customer_order_orig_customer_id[1]

li_rtn = dw_prod_order.GetChild("customer_order_orig_customer_id", ldwc)
		
If li_rtn = 1 Then //OK
	ls_find_string = "customer_id = " + String(ll_customer_id)
	ll_found_row = ldwc.Find(ls_find_string, 1, ldwc.RowCount())
	
	If ll_found_row > 0 Then
		ls_customer = Trim(ldwc.GetItemString(ll_found_row, "customer_short_name"))
	Else
		ls_customer = ""
	End If
End If

Return ls_customer
//Alex Gerlants. 09/16/2016. End
end function

public subroutine wf_calc_edge_trim_yield_percentage (datawindow adw, ref decimal ad_edge_trim_yield_percentage);/*
Function:	wf_calc_edge_trim_yield_percentage
Returns:		none
Arguments:	value			datawindow	adw
				reference	decimal		ad_est_et_scrap_percentage
*/

Long			ll_row
Decimal{2}	ld_incoming_coil_width, ld_trimmed_coil_width

ll_row = adw.GetRow()

ld_incoming_coil_width = adw.Object.incoming_coil_width[ll_row]
ld_trimmed_coil_width = adw.Object.trimmed_coil_width[ll_row]

ad_edge_trim_yield_percentage = 1 - (ld_trimmed_coil_width / ld_incoming_coil_width)
end subroutine

public function integer wf_count_shape_rows (long al_order_abc_num, integer ai_order_item_num, string as_shape, ref integer ai_die_row_count);//Alex Gerlants. 03/27/2017. Begin
/*
Function:	wf_count_shape_rows
Returns:		integer	 1 if OK
							-1 id DB error
Arguments:	value			long		al_order_abc_num							
				value			integer	ai_order_item_num
				value			string	as_shape
				reference	integer	ai_die_row_count
*/

Integer	li_rtn = 1

Choose Case as_shape
	Case "rectangle"
		select	count(*)
		into		:ai_die_row_count
		from		rectangle
		where		order_abc_num = :al_order_abc_num
		and		order_item_num = :ai_order_item_num
		using		sqlca;

	Case "parallelogram"
		select	count(*)
		into		:ai_die_row_count
		from		parallelogram
		where		order_abc_num = :al_order_abc_num
		and		order_item_num = :ai_order_item_num
		using		sqlca;

	Case "fender"
		select	count(*)
		into		:ai_die_row_count
		from		fender
		where		order_abc_num = :al_order_abc_num
		and		order_item_num = :ai_order_item_num
		using		sqlca;

	Case "chevron"
		select	count(*)
		into		:ai_die_row_count
		from		chevron
		where		order_abc_num = :al_order_abc_num
		and		order_item_num = :ai_order_item_num
		using		sqlca;
		
	Case "circle"
		select	count(*)
		into		:ai_die_row_count
		from		circle
		where		order_abc_num = :al_order_abc_num
		and		order_item_num = :ai_order_item_num
		using		sqlca;
		
	Case "trapezoid"
		select	count(*)
		into		:ai_die_row_count
		from		trapezoid
		where		order_abc_num = :al_order_abc_num
		and		order_item_num = :ai_order_item_num
		using		sqlca;
		
	Case "ltrapezoid"
		select	count(*)
		into		:ai_die_row_count
		from		left_trapezoid
		where		order_abc_num = :al_order_abc_num
		and		order_item_num = :ai_order_item_num
		using		sqlca;
		
	Case "rtrapezoid"
		select	count(*)
		into		:ai_die_row_count
		from		right_trapezoid
		where		order_abc_num = :al_order_abc_num
		and		order_item_num = :ai_order_item_num
		using		sqlca;
		
	Case "reinforcement"
		select	count(*)
		into		:ai_die_row_count
		from		reinforcement
		where		order_abc_num = :al_order_abc_num
		and		order_item_num = :ai_order_item_num
		using		sqlca;
		
	Case "liftgate_shape"
		select	count(*)
		into		:ai_die_row_count
		from		liftgate_shape
		where		order_abc_num = :al_order_abc_num
		and		order_item_num = :ai_order_item_num
		using		sqlca;
		
	Case Else //"x1shape"
		select	count(*)
		into		:ai_die_row_count
		from		x1_shape
		where		order_abc_num = :al_order_abc_num
		and		order_item_num = :ai_order_item_num
		using		sqlca;
		
End Choose

If sqlca.sqlcode <> 0 Then //DB error
	li_rtn = -1
End If

Return li_rtn
//Alex Gerlants. 03/27/2017. End
end function

public function integer wf_update_shape_row (long al_order_abc_num, integer ai_order_item_num, string as_table_2update, string as_die_id1, string as_die_id2);//Alex Gerlants. 03/27/2017. Begin
/*
Function:	wf_update_shape_row
Returns:		integer	 1 if OK
							-1 id DB error
Arguments:	value			long		al_order_abc_num							
				value			integer	ai_order_item_num
				value			string	as_table_2update
				value			string	as_die_id1
				value			string	as_die_id2
*/

Integer	li_rtn = 1

Choose Case as_table_2update
	Case "rectangle"
		update	rectangle
		set		rt_die1 = :as_die_id1
		where		order_abc_num = :al_order_abc_num
		and		order_item_num = :ai_order_item_num
		using		sqlca;

	Case "parallelogram"
		update	parallelogram
		set		p_die1 = :as_die_id1
		where		order_abc_num = :al_order_abc_num
		and		order_item_num = :ai_order_item_num
		using		sqlca;

	Case "fender"
		If as_die_id1 <> "" Then
			update	fender
			set		fe_die1 = :as_die_id1
			where		order_abc_num = :al_order_abc_num
			and		order_item_num = :ai_order_item_num
			using		sqlca;
		Else
			update	fender
			set		fe_die2 = :as_die_id2
			where		order_abc_num = :al_order_abc_num
			and		order_item_num = :ai_order_item_num
			using		sqlca;
		End If

	Case "chevron"
		update	chevron
		set		ch_die = :as_die_id1
		where		order_abc_num = :al_order_abc_num
		and		order_item_num = :ai_order_item_num
		using		sqlca;
		
	Case "circle"
		update	circle
		set		c_die1 = :as_die_id1
		where		order_abc_num = :al_order_abc_num
		and		order_item_num = :ai_order_item_num
		using		sqlca;
		
	Case "trapezoid"
		update	trapezoid
		set		tr_die1 = :as_die_id1
		where		order_abc_num = :al_order_abc_num
		and		order_item_num = :ai_order_item_num
		using		sqlca;
		
	Case "ltrapezoid"
		update	left_trapezoid
		set		ltr_die1 = :as_die_id1
		where		order_abc_num = :al_order_abc_num
		and		order_item_num = :ai_order_item_num
		using		sqlca;
		
	Case "rtrapezoid"
		update	right_trapezoid
		set		rtr_die1 = :as_die_id1
		where		order_abc_num = :al_order_abc_num
		and		order_item_num = :ai_order_item_num
		using		sqlca;
		
	Case "reinforcement"
		update	reinforcement
		set		re_die1 = :as_die_id1
		where		order_abc_num = :al_order_abc_num
		and		order_item_num = :ai_order_item_num
		using		sqlca;
		
	Case "liftgate_shape"
		update	liftgate_shape
		set		li_die1 = :as_die_id1
		where		order_abc_num = :al_order_abc_num
		and		order_item_num = :ai_order_item_num
		using		sqlca;
		
	Case Else //"x1shape"
		update	x1_shape
		set		x_die = :as_die_id1
		where		order_abc_num = :al_order_abc_num
		and		order_item_num = :ai_order_item_num
		using		sqlca;
		
End Choose

If sqlca.sqlcode <> 0 Then //DB error
	li_rtn = -1
	
	MessageBox("Database Error", &
								"Database error in wf_update_shape_rows for w_production" + &
								"while trying to update table " + as_table_2update + " for Order ABC Number " + &
								String(al_order_abc_num) + " and Item Number " + String(ai_order_item_num) + &
								"with Die Id " + as_die_id1 + &
								"~n~rSaving aborted." + &
								"~n~rDatabase Error:~n~r" + sqlca.sqlerrtext)
End If

Return li_rtn
//Alex Gerlants. 03/27/2017. End
end function

public function integer wf_update_shape_die (datawindow adw, long aab_job_num);//Alex Gerlants. 03/27/2017. Begin
/*
Function:	wf_update_shape_die
Returns:		integer <==	 1 if OK
								-1 i DB error
Arguments:	value	datawindow	adw <== This is tab_production.tabpage_shape.dw_spec_item
				value	long			aab_job_num
*/

Integer	li_rtn = 1, li_die_row_count
Long		ll_row, ll_pos, ll_die_id
String	ls_dataobject, ls_die_id, ls_die_id1, ls_die_id2, ls_sql, ls_ab_job_die_id
Boolean	lb_ab_job_has_die_id

adw.AcceptText()

//ll_row = adw.GetRow()
//ls_die_id = adw.Object.ab_job_die_id[ll_row]

ll_die_id = wf_get_die_id(tab_production.tabpage_shape.dw_spec_item, lb_ab_job_has_die_id)

update	ab_job
set		die_id = :ll_die_id
where		ab_job_num = :aab_job_num
using		sqlca;

If sqlca.sqlcode = 0 Then //OK
	adw.ResetUpdate()
Else //DB error
	li_rtn = -1
	
	MessageBox("Database Error", &
									"Database error in wf_update_shape_die for w_production " + & 
									"while updating table ab_job for Job " + String(aab_job_num) + &
									" with Die Id " + ls_die_id + &
									"~n~rSaving aborted." + &
									"~n~rDatabase Error:~n~r" + sqlca.sqlerrtext)
End If

Return li_rtn
//Alex Gerlants. 03/27/2017. End
end function

public subroutine wf_compare_coil_width (datawindow adw_spec_item, long al_row, long al_coil, real ar_coil_width, ref string as_msg_out);//Alex Gerlants. 05/18/2016. Begin
/*
Function:	wf_compare_coil_width
				Compare incoming coil width with item width or side for fender, or diameter for circle; 
				and issue a warning if coil width is not equal to item width
Returns:		None
Arguments:	value			datawindow	adw_spec_item
				value			long			al_row			<== Row in adw_spec_item where item is
				value			long			al_coil			<== Coil number
				value			real			ar_coil_width	<== Coil width
				reference	string		as_msg_out		<== Warning message to display in the calling routine ue_add_coil for w_production
*/

Real		lr_item_dimension, lr_item_dimension_plus, lr_item_dimension_minus
Real		lr_item_dimension_maximum, lr_item_dimension_minimum
String	ls_dataobject, ls_item_name, ls_dimension_literal

ls_dimension_literal = "width"
ls_dataobject = Lower(adw_spec_item.DataObject)

Choose Case ls_dataobject
	Case "d_rectangle_display", "d_rectangle_display_job"
		ls_item_name = "Rectangle"
		lr_item_dimension = adw_spec_item.GetItemNumber(al_row, "rt_width")
		lr_item_dimension_plus = adw_spec_item.GetItemNumber(al_row, "rt_width_plus")
		lr_item_dimension_minus = adw_spec_item.GetItemNumber(al_row, "rt_width_minus")
	Case "d_parallelogram_display", "d_parallelogram_display_job"
		ls_item_name = "Parallelogram"
		lr_item_dimension = adw_spec_item.GetItemNumber(al_row, "p_width")
		lr_item_dimension_plus = adw_spec_item.GetItemNumber(al_row, "p_width_plus")
		lr_item_dimension_minus = adw_spec_item.GetItemNumber(al_row, "p_width_minus")
	Case "d_fender_display", "d_fender_display_job"
		ls_item_name = "Fender"
		ls_dimension_literal = "side"
		lr_item_dimension = adw_spec_item.GetItemNumber(al_row, "fe_side")
		lr_item_dimension_plus = adw_spec_item.GetItemNumber(al_row, "fe_side_plus")
		lr_item_dimension_minus = adw_spec_item.GetItemNumber(al_row, "fe_side_minus")
	Case "d_chevron_display", "d_chevron_display_job"
		ls_item_name = "Chevron"
		lr_item_dimension = adw_spec_item.GetItemNumber(al_row, "ch_width")
		lr_item_dimension_plus = adw_spec_item.GetItemNumber(al_row, "ch_width_plus")
		lr_item_dimension_minus = adw_spec_item.GetItemNumber(al_row, "ch_width_minus")
	Case "d_circle_display", "d_circle_display_job"
		ls_item_name = "Circle"
		ls_dimension_literal = "diameter"
		lr_item_dimension = adw_spec_item.GetItemNumber(al_row, "c_diameter")
		lr_item_dimension_plus = adw_spec_item.GetItemNumber(al_row, "c_diameter_plus")
		lr_item_dimension_minus = adw_spec_item.GetItemNumber(al_row, "c_diameter_minus")
	Case "d_trapezoid_display", "d_trapezoid_display_job"
		ls_item_name = "Trapezoid"
		lr_item_dimension = adw_spec_item.GetItemNumber(al_row, "tr_width")
		lr_item_dimension_plus = adw_spec_item.GetItemNumber(al_row, "tr_width_plus")
		lr_item_dimension_minus = adw_spec_item.GetItemNumber(al_row, "tr_width_minus")
	Case "d_ltrapezoid_display", "d_ltrapezoid_display_job"
		ls_item_name = "Left trapezoid"
		lr_item_dimension = adw_spec_item.GetItemNumber(al_row, "ltr_width")
		lr_item_dimension_plus = adw_spec_item.GetItemNumber(al_row, "ltr_width_plus")
		lr_item_dimension_minus = adw_spec_item.GetItemNumber(al_row, "ltr_width_minus")
	Case "d_rtrapezoid_display", "d_rtrapezoid_display_job"
		ls_item_name = "Right trapezoid"
		lr_item_dimension = adw_spec_item.GetItemNumber(al_row, "rtr_width")
		lr_item_dimension_plus = adw_spec_item.GetItemNumber(al_row, "rtr_width_plus")
		lr_item_dimension_minus = adw_spec_item.GetItemNumber(al_row, "rtr_width_minus")
	Case "d_reinforcement_display", "d_reinforcement_display_job"
		ls_item_name = "Reinforcement"
		lr_item_dimension = adw_spec_item.GetItemNumber(al_row, "re_width")
		lr_item_dimension_plus = adw_spec_item.GetItemNumber(al_row, "re_width_plus")
		lr_item_dimension_minus = adw_spec_item.GetItemNumber(al_row, "re_width_minus")
	Case "d_liftgate_shape_display", "d_liftgate_shape_display_job"
		ls_item_name = "Liftgate"
		lr_item_dimension = adw_spec_item.GetItemNumber(al_row, "li_width")
		lr_item_dimension_plus = adw_spec_item.GetItemNumber(al_row, "li_width_plus")
		lr_item_dimension_minus = adw_spec_item.GetItemNumber(al_row, "li_width_minus")
	Case Else //"d_x1shape_display"
		ls_item_name = "X1shape"
		lr_item_dimension = adw_spec_item.GetItemNumber(al_row, "x_1")
		lr_item_dimension_plus = adw_spec_item.GetItemNumber(al_row, "x_3")
		lr_item_dimension_minus = adw_spec_item.GetItemNumber(al_row, "x_4")
End Choose

If IsNull(lr_item_dimension) Then lr_item_dimension = 0
If IsNull(lr_item_dimension_plus) Then lr_item_dimension_plus = 0
If IsNull(lr_item_dimension_minus) Then lr_item_dimension_minus = 0

lr_item_dimension_maximum = lr_item_dimension + lr_item_dimension_plus
lr_item_dimension_minimum = lr_item_dimension - lr_item_dimension_minus

as_msg_out = ""

If  (ar_coil_width > lr_item_dimension_maximum ) Or (ar_coil_width < lr_item_dimension_minimum) Then
	as_msg_out =	"Coil " + String(al_coil) + " width: " + String(ar_coil_width) + &
						"~n~r~n~r" + ls_item_name + " nominal " + ls_dimension_literal + ":    " + String(lr_item_dimension) + &
						"~n~r" + ls_item_name + " maximum " + ls_dimension_literal + ": "    + String(lr_item_dimension_maximum) + &
						"~n~r" + ls_item_name + " minimum " + ls_dimension_literal + ":  "   + String(lr_item_dimension_minimum) + &
						"~n~r~n~rThis coil's width is questionable for this item!"
End If
//Alex Gerlants. 05/18/2016. End
end subroutine

public function string wf_get_die_column_name (string as_dataobject);//Alex Gerlants. 03/27/2017. Begin
/*
Function:	wf_get_die_column_name
Returns:		string <== Die column name
Arguments:	value	string	as_dataobject <== This is dataobject on tab_production.tabpage_shape.dw_spec_item
*/

String	ls_column_name, ls_modstring, ls_rtn
Integer	li_status

If Right(as_dataobject, 4) = "_job" Then //Dataobject for an existing job
	ls_column_name = "ab_job_die_id"
Else //Dataobject for a new job
	Choose Case as_dataobject
		Case "d_rectangle_display"	
			ls_column_name = "rt_die1"
		Case "d_parallelogram_display"
			ls_column_name = "p_die1"
		Case "d_fender_display"
			ls_column_name = "fe_die1"
		Case "d_chevron_display"
			ls_column_name = "ch_die"
		Case "d_circle_display"
			ls_column_name = "c_die1"
		Case "d_trapezoid_display"
			ls_column_name = "tr_die1"
		Case "d_ltrapezoid_display"
			ls_column_name = "ltr_die1"
		Case "d_rtrapezoid_display"
			ls_column_name = "rtr_die1"
		Case "d_reinforcement_display"
			ls_column_name = "re_die1"
		Case "d_liftgate_shape_display"
			ls_column_name = "li_die1"
		Case Else //"d_x1shape_display"
			ls_column_name = "x_die"
	End Choose
End If

Return ls_column_name
//Alex Gerlants. 03/27/2017. End
end function

public function long wf_get_die_id (datawindow adw, ref boolean ab_ab_job_has_die_id);//Alex Gerlants. 03/27/2017. Begin
/*
Function:	wf_get_die_id
Returns:		string <== Die id
Arguments:	value			datawindow	adw <== This is tab_production.tabpage_shape.dw_spec_item
				reference	boolean		ab_ab_job_has_die_id
*/

String	ls_die_id, ls_dataobject, ls_modstring, ls_rtn
Integer	li_status
Long		ll_row, ll_die_id

ab_ab_job_has_die_id = False

ll_row = adw.GetRow()

If ll_row > 0 Then
	ls_dataobject = adw.DataObject
	
	If Right(ls_dataobject, 4) = "_job" Then //Dataobject for an existing job
		ls_die_id = String(adw.Object.ab_job_die_id[ll_row])
		
		If Not IsNull(ls_die_id) Then //Table ab_job already has die_id
			ab_ab_job_has_die_id = True
		Else //Table ab_job doesn't have die_id
			//Get die_id from a shape table linked to order_item.sheet_type
			ls_die_id = wf_get_die_id_order_item()
		End If
	Else //Dataobject for a new job
		Choose Case ls_dataobject
			Case "d_rectangle_display"
				ls_die_id = adw.Object.rt_die1[ll_row]
			Case "d_parallelogram_display"
				ls_die_id = adw.Object.p_die1[ll_row]
			Case "d_fender_display"
				ls_die_id = adw.Object.fe_die1[ll_row]
			Case "d_chevron_display"
				ls_die_id = adw.Object.ch_die[ll_row]
			Case "d_circle_display"
				ls_die_id = adw.Object.c_die1[ll_row]
			Case "d_trapezoid_display"
				ls_die_id = adw.Object.tr_die1[ll_row]
			Case "d_ltrapezoid_display"
				ls_die_id = adw.Object.ltr_die1[ll_row]
			Case "d_rtrapezoid_display"
				ls_die_id = adw.Object.rtr_die1[ll_row]
			Case "d_reinforcement_display"
				ls_die_id = adw.Object.re_die1[ll_row]
			Case "d_liftgate_shape_display"
				ls_die_id = adw.Object.li_die1[ll_row]
			Case Else //"d_x1shape_display"
				ls_die_id = adw.Object.x_die[ll_row]
		End Choose
		
		If IsNull(ls_die_id) Then ls_die_id = ""
		
		If ls_die_id = "" Then
			ls_die_id = wf_get_die_id_order_item()
		End If
	End If
End If

If IsNumber(ls_die_id) Then
	ll_die_id = Long(ls_die_id)
Else
	SetNull(ll_die_id)
End If

Return ll_die_id
//Alex Gerlants. 03/27/2017. End
end function

public subroutine wf_update_shape_dw (ref datawindow adw, long al_die_id);//Alex Gerlants. 03/27/2017. Begin
/*
Function:	wf_update_shape_dw
Returns:		string <== Die id
Arguments:	reference	datawindow	adw <== This is tab_production.tabpage_shape.dw_spec_item
				value			long			al_die_id
*/

String	ls_die_id, ls_dataobject
Long		ll_row

//ab_ab_job_has_die_id = False

ll_row = adw.GetRow()

If ll_row > 0 Then
	ls_dataobject = adw.DataObject
	
	If Right(ls_dataobject, 4) = "_job" Then //Dataobject for an existing job
		adw.Object.ab_job_die_id[ll_row] = al_die_id
	Else //Dataobject for a new job
		ls_die_id = String(al_die_id)
		
		Choose Case ls_dataobject
			Case "d_rectangle_display"
				adw.Object.rt_die1[ll_row] = ls_die_id
			Case "d_parallelogram_display"
				adw.Object.p_die1[ll_row] = ls_die_id
			Case "d_fender_display"
				adw.Object.fe_die1[ll_row] = ls_die_id
			Case "d_chevron_display"
				adw.Object.ch_die[ll_row] = ls_die_id
			Case "d_circle_display"
				adw.Object.c_die1[ll_row] = ls_die_id
			Case "d_trapezoid_display"
				adw.Object.tr_die1[ll_row] = ls_die_id
			Case "d_ltrapezoid_display"
				adw.Object.ltr_die1[ll_row] = ls_die_id
			Case "d_rtrapezoid_display"
				adw.Object.rtr_die1[ll_row] = ls_die_id
			Case "d_reinforcement_display"
				adw.Object.re_die1[ll_row] = ls_die_id
			Case "d_liftgate_shape_display"
				adw.Object.li_die1[ll_row] = ls_die_id
			Case Else //"d_x1shape_display"
				adw.Object.x_die[ll_row] = ls_die_id
		End Choose
	End If
	
	adw.SetItemStatus(ll_row, 0, Primary!, NotModified!) //So it will not ask to save if no changes made.
End If
//Alex Gerlants. 03/27/2017. End
end subroutine

public function string wf_get_die_id_order_item ();//Alex Gerlants. 03/27/2017. Begin
/*
Function:	wf_get_die_id_order_item
Returns:		string <== Die id from a shape table linked order_item.sheet_type
Arguments:	none
*/

String	ls_die_id, ls_dataobject, ls_modstring, ls_rtn
Integer	li_status
Long		ll_row, ll_die_id
Long		ll_order_abc_num
Integer	li_order_item_num

ll_row = dw_prod_order.GetRow()

If ll_row > 0 Then
	ll_order_abc_num = dw_prod_order.Object.order_abc_num[ll_row]
	li_order_item_num = dw_prod_order.Object.order_item_num[ll_row]

	select   case lower(ltrim(rtrim(order_item.sheet_type)))
					  when 'rectangle'      then nvl(rectangle.rt_die1, '')
					  when 'parallelogram'  then nvl(parallelogram.p_die1, '')
					  when 'fender'         then nvl(fender.fe_die1, '')
					  when 'chevron'        then nvl(chevron.ch_die , '')
					  when 'circle'         then nvl(circle.c_die1, '')
					  when 'trapezoid'      then nvl(trapezoid.tr_die1, '')
					  when 'ltrapezoid'     then nvl(left_trapezoid.ltr_die1, '')
					  when 'rtrapezoid'     then nvl(right_trapezoid.rtr_die1, '')
					  when 'reinforcement'  then nvl(reinforcement.re_die1, '')
					  when 'liftgate_shape' then nvl(liftgate_shape.li_die1, '')
					  when 'x1shape'        then nvl(x1_shape.x_die, '')
					  else                       ''     
				end
	into		:ls_die_id			
	from     order_item
				
				left outer join chevron on order_item.order_item_num = chevron.order_item_num and order_item.order_abc_num = chevron.order_abc_num
				left outer join liftgate_shape on order_item.order_item_num = liftgate_shape.order_item_num and order_item.order_abc_num = liftgate_shape.order_abc_num
				left outer join circle on order_item.order_item_num = circle.order_item_num and order_item.order_abc_num = circle.order_abc_num
				left outer join left_trapezoid on order_item.order_item_num = left_trapezoid.order_item_num and order_item.order_abc_num = left_trapezoid.order_abc_num
				left outer join parallelogram on order_item.order_item_num = parallelogram.order_item_num and order_item.order_abc_num = parallelogram.order_abc_num 
				left outer join rectangle on order_item.order_item_num = rectangle.order_item_num and order_item.order_abc_num = rectangle.order_abc_num
				left outer join reinforcement on order_item.order_item_num = reinforcement.order_item_num and order_item.order_abc_num = reinforcement.order_abc_num
				left outer join right_trapezoid on order_item.order_item_num = right_trapezoid.order_item_num and order_item.order_abc_num = right_trapezoid.order_abc_num
				left outer join fender on order_item.order_item_num = fender.order_item_num and order_item.order_abc_num = fender.order_abc_num
				left outer join trapezoid on order_item.order_item_num = trapezoid.order_item_num and order_item.order_abc_num = trapezoid.order_abc_num
				left outer join x1_shape on order_item.order_abc_num = x1_shape.order_abc_num
	where    order_item.order_abc_num = :ll_order_abc_num
	and		order_item.order_item_num = :li_order_item_num
	using		sqlca;
	
	If sqlca.sqlcode <> 0 Then //DB error
		SetNull(ls_die_id)
	End If
Else
	SetNull(ls_die_id)
End If

Return ls_die_id
//Alex Gerlants. 03/27/2017. End
end function

public function integer wf_check_863_4coil (string as_coil_org_num, ref boolean ab_863_exists);//Alex Gerlants. 02/25/2019. Print Cert Label. Begin
/*
Function:	wf_check_863_4coil
Returns:		integer	 1 if ok
							-1 if DB error
Arguments:	value			string	as_coil_org_num
				reference	boolean	ab_863_exists
*/
Integer	li_rtn = 1, li_counter

select	count(*)
into		:li_counter
from		dbo.data_in_863
where 	coil_num = :as_coil_org_num
using		sqlca;

If sqlca.sqlcode = 0 Then //OK
	If li_counter > 0 Then
		ab_863_exists = True
	Else
		ab_863_exists = False
	End If
Else //DB error
	li_rtn = -1
	MessageBox("Database error", 	"Database error occurred in wf_check_863_4coil for w_production~n~r~n~r" + &
											"Error~n~r" + sqlca.sqlerrtext)
End If

Return li_rtn
//Alex Gerlants. 02/25/2019. Print Cert Label. End
end function

public function integer wf_check_863_4skids ();////***************************************************************************************************************************
////*****************************************  This function is not used  *****************************************************
////***************************************************************************************************************************
//
////Alex Gerlants. 02/25/2019. Print Cert Label. Begin
///*
//Function:	wf_check_863_4skids
//Returns:		integer	 1 if ok
//							-1 if DB error
//Arguments:	none
//*/
Integer	li_rtn = 1, li_skid_sheet_status
//Long		ll_rows, ll_row, ll_sheet_skid_num, ll_coil_abc_num_prev, ll_coil_abc_num
//String	ls_coil_org_num, ls_error_string_email, ls_error_string_popup
//Boolean	lb_863_exists_4coil, lb_skid_ok
//
//ll_rows = dw_skids_coils_4job.RowCount()
//ll_coil_abc_num_prev = 0
//lb_skid_ok = True
//ls_error_string_email = "Sheet Skid Num~tCoil ABC Num~tCoil Org Num~n~r"
//
////dw_skids_coils_4job is sorted by coil_abc_num A
//
//For ll_row = 1 To ll_rows
//	ls_coil_org_num = dw_skids_coils_4job.Object.coil_org_num[ll_row]
//	ll_sheet_skid_num = dw_skids_coils_4job.Object.sheet_skid_num[ll_row]
//	li_skid_sheet_status = dw_skids_coils_4job.Object.skid_sheet_status[ll_row]
//	ll_coil_abc_num = dw_skids_coils_4job.Object.coil_abc_num[ll_row]
//	
//	If ll_coil_abc_num <> ll_coil_abc_num_prev Then
//		li_rtn = wf_check_863_4coil(ls_coil_org_num, lb_863_exists_4coil) //lb_863_exists_4coil comes back from wf_check_863_4coil()
//		
//		If Not lb_863_exists_4coil Then
//			ls_error_string_popup = ls_error_string_popup + String(ll_coil_abc_num) + ", "
//		End If
//	End If
//	
//	If Not lb_863_exists_4coil Then
//		If li_skid_sheet_status = 2 Then //2-Ready
//		
//			//If ll_coil_abc_num <> ll_coil_abc_num_prev Then
//			//	ls_error_string_popup = ls_error_string_popup + String(ll_coil_abc_num) + ", "
//			//End If
//			
//			If li_skid_sheet_status = 2 Then //Ready
//				lb_skid_ok = False
//			
//				//Update skid to status 16-Hold For Cert
//				update	sheet_skid
//				set		skid_sheet_status = 16
//				where		sheet_skid_num = :ll_sheet_skid_num
//				using		sqlca;
//				
//				If sqlca.sqlcode < 0 Then //DB error
//					li_rtn = -1
//					
//					MessageBox("Database error", 	" while trying to update skid_sheet_status to 'Hold For Cert' " + &
//												"in table sheet_skid for skid " + String(ll_sheet_skid_num) + "~n~r~n~r" + &
//												"Error~n~r" + sqlca.sqlerrtext)
//				End If
//			End If
//
//			ls_error_string_email = ls_error_string_email + String(ll_sheet_skid_num) + "~t~t" + String(ll_coil_abc_num) + "~t~t" + ls_coil_org_num + "~n~r"		
//		End If
//	End If
//	
//	ll_coil_abc_num_prev = ll_coil_abc_num
//Next
//
//If Len(ls_error_string_email) > 32 Then
//	ls_error_string_email =	"The skids for job " + String(il_current_ab_job_id) + &
//			                  " from the following coils don't have 863 EDI transmission:~n~r~n~r" + ls_error_string_email
//									
//	//Send email here. **************************************************************************************
//	MessageBox("Test email message", ls_error_string_email)
//End If
//
//If ls_error_string_popup <> "" Then
//	//Remove the last comma
//	ls_error_string_popup = Left(ls_error_string_popup, Len(ls_error_string_popup) - 2)
//	ls_error_string_popup = "The following coils for job " + String(il_current_ab_job_id) + &
//									" don't have 863 EDI transmission:~n~r" + ls_error_string_popup
//									
//	MessageBox("Coils without 863 transmission", ls_error_string_popup)
//End If
//
Return li_rtn
////Alex Gerlants. 02/25/2019. Print Cert Label. End
end function

on w_production.create
int iCurrent
call super::create
if this.MenuName = "m_prod_main" then this.MenuID = create m_prod_main
this.dw_shift_coil_delete_4job=create dw_shift_coil_delete_4job
this.cb_prod_new=create cb_prod_new
this.cb_prod_print=create cb_prod_print
this.tab_production=create tab_production
this.cb_prod_save=create cb_prod_save
this.cb_orderopen=create cb_orderopen
this.cb_close=create cb_close
this.cb_sum=create cb_sum
this.gb_3=create gb_3
this.mle_desc=create mle_desc
this.cb_newsketch=create cb_newsketch
this.cb_clearsketch=create cb_clearsketch
this.dw_prod_order=create dw_prod_order
this.tab_mat=create tab_mat
this.cb_viewsketch=create cb_viewsketch
this.cb_wizard=create cb_wizard
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_shift_coil_delete_4job
this.Control[iCurrent+2]=this.cb_prod_new
this.Control[iCurrent+3]=this.cb_prod_print
this.Control[iCurrent+4]=this.tab_production
this.Control[iCurrent+5]=this.cb_prod_save
this.Control[iCurrent+6]=this.cb_orderopen
this.Control[iCurrent+7]=this.cb_close
this.Control[iCurrent+8]=this.cb_sum
this.Control[iCurrent+9]=this.gb_3
this.Control[iCurrent+10]=this.mle_desc
this.Control[iCurrent+11]=this.cb_newsketch
this.Control[iCurrent+12]=this.cb_clearsketch
this.Control[iCurrent+13]=this.dw_prod_order
this.Control[iCurrent+14]=this.tab_mat
this.Control[iCurrent+15]=this.cb_viewsketch
this.Control[iCurrent+16]=this.cb_wizard
this.Control[iCurrent+17]=this.p_1
end on

on w_production.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_shift_coil_delete_4job)
destroy(this.cb_prod_new)
destroy(this.cb_prod_print)
destroy(this.tab_production)
destroy(this.cb_prod_save)
destroy(this.cb_orderopen)
destroy(this.cb_close)
destroy(this.cb_sum)
destroy(this.gb_3)
destroy(this.mle_desc)
destroy(this.cb_newsketch)
destroy(this.cb_clearsketch)
destroy(this.dw_prod_order)
destroy(this.tab_mat)
destroy(this.cb_viewsketch)
destroy(this.cb_wizard)
destroy(this.p_1)
end on

event open;call super::open;Boolean	lb_this_window_open //Alex Gerlants. 05/16/2016
Long		ll_rows //Alex Gerlants. 02/25/2019. Print Cert Label

//initial
il_order = 0
ii_item = 0
il_current_ab_job_id = 0
ib_coilchanged = FALSE

// Setup order window
DataWindowChild ldddw_cni
IF dw_prod_order.GetChild("line_num", ldddw_cni) = -1 THEN Return -1
dw_prod_order.Event pfc_PopulateDDDW("line_num", ldddw_cni)

// Turn on the linkage service.
dw_prod_order.of_SetLinkage ( TRUE ) 

//Alex Gerlants. 09/13/2016, Begin
//Add dw_shift_coil_delete_4job to linkage
//dw_shift_coil_delete_4job inherited from u_dw in pfemain.pbl
dw_shift_coil_delete_4job.of_SetLinkage ( TRUE )
dw_shift_coil_delete_4job.inv_linkage.of_SetMaster(dw_prod_order)
IF NOT dw_shift_coil_delete_4job.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked dw_shift_coil_delete in win w_prodution!" )
ELSE
	dw_shift_coil_delete_4job.inv_linkage.of_Register( "ab_job_num", "ab_job_num"  ) 
	dw_shift_coil_delete_4job.inv_linkage.of_SetStyle( 2 ) 
END IF
//Alex Gerlants. 09/13/2016, End

//Setup coil window
tab_mat.tabpage_coil.dw_prod_coil.of_SetLinkage ( TRUE )
tab_mat.tabpage_coil.dw_prod_coil.inv_linkage.of_SetMaster(dw_prod_order)
IF NOT tab_mat.tabpage_coil.dw_prod_coil.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked order & coil in win w_prod!" )
ELSE
	tab_mat.tabpage_coil.dw_prod_coil.inv_linkage.of_Register( "ab_job_num", "process_coil_ab_job_num" ) 
	tab_mat.tabpage_coil.dw_prod_coil.inv_linkage.of_SetStyle( 2 ) 
	tab_mat.tabpage_coil.dw_prod_coil.SetRowFocusIndicator(FocusRect!) 
END IF

//wh items
tab_mat.tabpage_wh.dw_job_wh_item.of_SetLinkage ( TRUE )
tab_mat.tabpage_wh.dw_job_wh_item.inv_linkage.of_SetMaster(dw_prod_order)
IF NOT tab_mat.tabpage_wh.dw_job_wh_item.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked warehouse items in win w_prodution!" )
ELSE
	tab_mat.tabpage_wh.dw_job_wh_item.inv_linkage.of_Register( "ab_job_num", "ab_job_num"  ) 
	tab_mat.tabpage_wh.dw_job_wh_item.inv_linkage.of_SetStyle( 2 ) 
END IF

//partial
tab_mat.tabpage_partial.dw_partial.of_SetLinkage ( TRUE )
tab_mat.tabpage_partial.dw_partial.inv_linkage.of_SetMaster(dw_prod_order)
IF NOT tab_mat.tabpage_partial.dw_partial.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked partial skids in win w_prodution!" )
ELSE
	tab_mat.tabpage_partial.dw_partial.inv_linkage.of_Register( "ab_job_num", "ab_job_num"  ) 
	tab_mat.tabpage_partial.dw_partial.inv_linkage.of_SetStyle( 2 ) 
END IF

//retrieve
dw_prod_order.inv_Linkage.of_SetTransObject(sqlca) 
ib_new_order = FALSE

//list
//open(w_ab_job_browser)

IF gl_message > 0 THEN
	
	//Alex Gerlants. 05/16/2016. Begin
	This.Title = This.Title + ": " + String(gl_message)
	
	//Check if this window is already open.
	lb_this_window_open = f_window_open(This.Title)
	
	If lb_this_window_open Then //Window open
		Close(This) //Close this window
		Return
	End If		
	//Alex Gerlants. 05/16/2016. End
	
	this.Event ue_open_porder(gl_message)
ELSE
	il_old_job_id = 0
	this.Event ue_new_order()
END IF
wf_set_updatable()
SetNULL(gl_message)

//dw_skid_coils_863.SetTransObject(sqlca) //Alex Gerlants. 02/25/2019. Print Cert Label
//dw_skids_coils_4job.SetTransObject(sqlca) //Alex Gerlants. 02/25/2019. Print Cert Label
//ll_rows = dw_skids_coils_4job.Retrieve(il_current_ab_job_id) //Alex Gerlants. 02/25/2019. Print Cert Label
//wf_check_863_4skids()
//f_check_863_4skids(il_current_ab_job_id, sqlca) //Alex Gerlants. 02/25/2019. Print Cert Label


end event

event pfc_save;SetPointer(HourGlass!)
int li_return, li_coil_status, li_rc, ls_job_status, skid_pieces
Long ll_row, ll_i, ll_item, ll_null, ll_coil, ll_wt_bal, max_skid_wt, est_skid_wt
String ls_pt
String ls_msg
String ls_coil_status
datetime ls_finished_time

Boolean 	lb_valid //Alex Gerlants. 05/26/2016
String	ls_title //Alex Gerlants. 05/26/2016
Window 	lw_sheet //Alex Gerlants. 05/26/2016

String	ls_system_log_msg //Alex Gerlants. 09/16/2016
Integer	li_rtn //Alex Gerlants. 03/27/2017

IF ib_coilchanged THEN
	ls_msg = "Do you want to use wizard to create other values instead of those showing on the screen?"
	li_return = MessageBox("Question", ls_msg , Question!, YesNo!, 2)
	IF li_return = 1 THEN this.Event ue_job_wizard()
END IF

ll_row = dw_prod_order.GetRow()
dw_prod_order.SetItem(ll_row, "ab_job_sketch_job_note", mle_desc.Text)

dw_prod_order.AcceptText()
tab_mat.tabpage_coil.dw_prod_coil.AcceptText()
tab_mat.tabpage_partial.dw_partial.AcceptText()
li_return = dw_prod_order.inv_linkage.of_GetUpdatesPending()
IF li_return = -1 THEN
	//accceptText error
	MessageBox("Edit Errors", " Failed to save production order due to valid data" )
	Return -1
ELSEIF li_return = 0 THEN
	//No Change in the linkage
END IF
ib_new_order = FALSE



//dw_order_list.AcceptText()
//li_po = dw_order_list.GetItemString(1,"orig_customer_po") //Primary!, false)
//li_so = dw_order_list.GetItemString(1,"sales_order") //Primary!, false)

tab_production.tabpage_item.dw_prod_item.AcceptText()
skid_pieces = dw_prod_order.GetItemNumber(1,"ab_job_job_pieces_skid")
max_skid_wt = tab_production.tabpage_item.dw_prod_item.GetItemNumber(1, "max_skid_wt")
est_skid_wt = tab_production.tabpage_item.dw_prod_item.GetItemNumber(1, "theoretical_unit_wt") * skid_pieces

if (est_skid_wt > max_skid_wt) then
	MessageBox("Warning", "ESTIMATED SKID WT. EXCEEDS MAX SKID WT. MUST RE-EDIT!!!")
	return -1
end if

ls_job_status = dw_prod_order.GetItemNumber(1,"job_status")
ls_finished_time = dw_prod_order.GetItemDateTime(1, "time_date_finished")
if (isNull(ls_finished_time) and ls_job_status = 0 ) then
	MessageBox("Info", "You must enter job actual finished date and time!")
	return -1
end if

/*
if (isNull(li_po) or li_po = "") then
	MessageBox("Info", "You must enter Customer_PO!")
	return -1
end if

if ((isNull(li_po) or li_po = "") and (isNull(li_so) or li_so = "")) then
	MessageBox("Info", "You must enter either Customer_PO or Sales_Order!")
	return -1
end if

*/









IF wf_check_values() < 0 THEN
	MessageBox("Info", "Failed to save production order.")
	RETURN -2
END IF

IF li_return <> 0 THEN 
	//Alex Gerlants. 09/14/2016. Begin
	//ib_ok_2delete_child_coil_records and il_coil_abc_num_2delete are set in Clicked event for 
	//tab_mat.tabpage_coil.cb_coil_remove
	If ib_ok_2delete_child_coil_records Then
		wf_delete_child_coils(il_coil_abc_num_2delete)
	End If
	//Alex Gerlants. 09/14/2016. End
	
	
	//Alex Gerlants. 09/16/2016. Begin
	//Record job status change in system_log table
	If is_job_status_desc_new <> "" And is_job_status_desc_db <> is_job_status_desc_new Then //Job status changed
		ls_system_log_msg = 	"Job " + String(il_current_ab_job_id) + &
									" Customer " + is_customer + &
									" by " + gnv_app.of_GetUserId() + ". " + &
									String(Today(), "mm-dd-yyyy @HH:MM.") + &
									" Changed job status from '" + is_job_status_desc_db + &
									"' to '" + is_job_status_desc_new + "'."
	
		f_add_system_log_tran(ls_system_log_msg, sqlca)
	End If
	//Alex Gerlants. 09/16/2016. End
	
	//Alex Gerlants. 10/17/2016. Update ab_job.edge_trim_scrap_percentage
	dw_prod_order.Object.edge_trim_scrap_percentage[dw_prod_order.getrow()] = id_edge_trim_yield_percentage
	
	//update pending on the link
	li_return = dw_prod_order.inv_linkage.of_update(TRUE,FALSE) //- by Tony 11/12/2009
	IF li_return <> 1 THEN
		ROLLBACK USING SQLCA;
		IF SQLCA.SQLCODE <> 0 THEN
			MessageBox("Rollback Error", SQLCA.SQLErrText)
		ELSE
			MessageBox("Update Failed", "Rollback Succeeded # 1")
		END IF
		MessageBox("Info", "Failed to save production order.")
		RETURN -3
	END IF
END IF

//save coil info
ll_row = tab_mat.tabpage_coil.dw_prod_coil.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		ll_coil = tab_mat.tabpage_coil.dw_prod_coil.GetItemNumber(ll_i, "process_coil_coil_abc_num", Primary!, FALSE)
		ll_wt_bal = tab_mat.tabpage_coil.dw_prod_coil.GetItemNumber(ll_i, "coil_net_wt_balance", Primary!, FALSE)		
		li_coil_status =tab_mat.tabpage_coil.dw_prod_coil.GetItemNumber(ll_i, "coil_coil_status", Primary!, FALSE)
		
//		CHOOSE CASE li_coil_status
//			CASE 0
//			ls_coil_status = 'DONE'
//			CASE 2
//			ls_coil_status = 'NEW'
//			CASE 3
//			ls_coil_status = 'REJECTED'
//			CASE 7
//			ls_coil_status = 'REBANDED'
//			CASE 10
//			ls_coil_status = 'GONE'
//		END CHOOSE
		
		IF ll_wt_bal < 1 THEN li_coil_status = 0
		CONNECT USING SQLCA;
		UPDATE coil
		SET coil_status = :li_coil_status, net_wt_balance = :ll_wt_bal
		WHERE coil_abc_num = :ll_coil
		USING SQLCA;
		IF SQLCA.SQLNRows <= 0 THEN
			ROLLBACK USING SQLCA;
			MessageBox("Info", "Failed to save production order.")
			RETURN -6
		ELSE
			//Alex Gerlants. 02/25/2019. Print Cert Label. Begin
			li_rtn = f_check_863_4skids(il_current_ab_job_id, sqlca)
			
			If li_rtn = -1 Then //DB error in f_check_863_4skids(). Error message is in f_check_863_4skids()
				rollback using sqlca;
				Return -6
			End If
			//Alex Gerlants. 02/25/2019. Print Cert Label. End
			
			COMMIT using SQLCA;
			IF SQLCA.SQLCODE <> 0 THEN
				MessageBox("Commit Error", SQLCA.SQLErrText)
				MessageBox("Info", "Failed to save production order.")
				Return -9
//			ELSE
//				MessageBox("Info: Coil#" + String(ll_coil),  " Wt bal:" + String(ll_wt_bal) + ", " + "Status:" + ls_coil_status + ",  has been saved successfully.")
			//Alex Gerlants. 09/16/2016. Begin
			Else //Commit successful
				//Reset variables
				If is_job_status_desc_new <> "" Then
					is_job_status_desc_db = is_job_status_desc_new
					is_job_status_desc_new = ""
				End If
				//Alex Gerlants. 09/16/2016. End
			END IF
		END IF
		
		li_rc = 0
		SELECT Count(coil_abc_num) INTO :li_rc
		FROM reject_coil
		WHERE coil_abc_num = :ll_coil
		USING SQLCA;

		IF li_coil_status = 3 THEN
			IF li_rc = 0 THEN
				INSERT INTO reject_coil(coil_abc_num, reject_coil_status, ab_job_num)
				VALUES (:ll_coil, 3, :il_current_ab_job_id)
				USING SQLCA;
			END IF
		ELSE
			IF li_rc > 0 THEN
				DELETE FROM reject_coil
				WHERE coil_abc_num = :ll_coil
				USING SQLCA;
			END IF			
		END IF
	NEXT
END IF

//Alex Gerlants. 03/27/2017. Begin
//Update ab_job.die_id
li_rtn = wf_update_shape_die(tab_production.tabpage_shape.dw_spec_item, il_current_ab_job_id)

If li_rtn = 1 Then //OK in wf_update_shape_die()
//Alex Gerlants. 03/27/2017. End
	COMMIT using SQLCA;
	
	IF SQLCA.SQLCODE <> 0 THEN
		MessageBox("Commit Error", SQLCA.SQLErrText)
		MessageBox("Info", "Failed to save production order.")
		Return -9
	END IF
//Alex Gerlants. 03/27/2017. Begin
Else //Database error in wf_update_shape_die()
	ROLLBACK USING SQLCA;
	MessageBox("Info", "Failed to save production order.")
	RETURN -6
End If
//Alex Gerlants. 03/27/2017. End	

dw_prod_order.inv_linkage.of_ResetUpdate()

this.Event ue_open_porder(il_current_ab_job_id)

MessageBox("Info", "Production order has been saved successfully.")
ib_coilchanged = FALSE

//Alex Gerlants. 05/26/2016. Begin
//After successful update on this window, re-retrieve dw_job_list on w_ab_job_list.
//Thus changes on this window will be reflected on w_ab_job_list.

lw_sheet = gnv_app.of_getFrame().GetFirstSheet()
lb_valid = IsValid(lw_sheet)

If lb_valid Then
	ls_title = lw_sheet.Title //Get the first sheet title
	
	Do
		lw_sheet = gnv_app.of_getFrame().GetNextSheet(lw_sheet)
		lb_valid = IsValid (lw_sheet)
		
		If lb_valid Then
			ls_title = lw_sheet.Title //Get the next sheet title
			If Upper(ls_title) = "ABCO PRODUCTION ORDER MANAGEMENT" Then
				lw_sheet.Function Dynamic wf_retrieve() //Re-retrieve job list
			End If
		End If
	Loop While lb_valid
End If
//Alex Gerlants. 05/26/2016. End

//check if any status unmatched coils for this job
SELECT count(*) into :li_rc
	FROM PROCESS_COIL p, COIL c, customer cu
	WHERE c.CUSTOMER_ID = cu.CUSTOMER_ID
	and c.COIL_ABC_NUM  = p.COIL_ABC_NUM
	AND c.COIL_STATUS <> 0
	AND p.PROCESS_COIL_STATUS = 0
	AND p.AB_JOB_NUM = :il_current_ab_job_id
	using SQLCA;
	
	if li_rc > 0 then
		MessageBox("Warning Message", "Status unmatched coil(s) found, please contact system dept.", StopSign!, OK!) 
		//Log user's archiving trasaction
		String ls_message
		ls_message = "Unmatched status coil(s) found in AB_JOB #" + String(il_current_ab_job_id) + " when being zero-out, processeded by " + gnv_app.of_GetUserId() + " @" + String(Today(), "mm-dd-yyyy HH:MM.")
		f_add_system_log(ls_message)
		return -1
	else
		MessageBox("Info", "Coil(s) has been updated successfully.", Information!, OK!)
			
	end if

Return 1

end event

event pfc_print;Long	ll_row //Alex Gerlants. 10/17/2016

ll_row = dw_prod_order.GetRow() //Alex Gerlants. 10/17/2016

SetPointer(HourGlass!)
Int li_rc
IF wf_updatespending() > 0 THEN
	li_rc = MessageBox("Question","Save current production order first?",Question!, OKCancel!, 1)
	IF li_rc = 1 THEN
		
		If ll_row > 0 Then //Alex Gerlants. 10/17/2016
			dw_prod_order.Object.edge_trim_scrap_percentage[ll_row] = id_edge_trim_yield_percentage //Alex Gerlants. 10/17/2016
		End If //Alex Gerlants. 10/17/2016
		
		//Date: 03/09/04
		//Author: victor huang
		//Problem: Est. wt excesss Max skid wt
		if wf_save_order() < 0 then
			return -1
		end if		
	ELSE
		Return -1
	END IF
	
//Alex Gerlants. 10/17/2016. Begin
Else //There are no updates pending
	//Update edge_trim_scrap_percentage, and save it without asking user
	If ll_row > 0 Then
		dw_prod_order.Object.edge_trim_scrap_percentage[ll_row] = id_edge_trim_yield_percentage
	End If
	
	if wf_save_order() < 0 then
		return -1
	end if
	//Alex Gerlants. 10/17/2016. End	
	
END IF
IF ib_new_order THEN
		MessageBox("Error","Failed to print an new & unsaved production order!", StopSign!)
		Return -2
END IF

IF wf_set_sketch_file() < 0 THEN Return 0
openwithparm(w_report_prod_order,il_current_ab_job_id)
Return 1
end event

event close;call super::close;f_display_app()
end event

event activate;call super::activate;IF f_security_door("Production Control") = 1 THEN RETURN 1
This.Event ue_read_only()
end event

event pfc_saveas;Int li_rc
Long ll_order

IF wf_updatespending() > 0 THEN
	li_rc = MessageBox("Question"," You must save current production order information before you can duplicate it. Continue?",Question!, YesNo!, 2)
	IF li_rc = 1 THEN 
		IF wf_save_order() < 0 THEN RETURN
	ELSE
		RETURN 
	END IF
END IF

il_old_job_id = il_current_ab_job_id
this.Event ue_new_order()

end event

event pfc_postopen;call super::pfc_postopen;//Alex Gerlants. 09/16/2016. Begin
Integer	li_status
Long		ll_rows, ll_row
String	ls_modstring, ls_rtn //Alex Gerlants. 10/17/2016
Long		ll_die_id, ll_spec_row //Alex Gerlants. 03/27/2017
Boolean	lb_ab_job_has_die_id //Alex Gerlants. 03/27/2017

ll_rows = dw_prod_order.RowCount()

If ll_rows > 0 Then

	//Alex Gerlants. 03/27/2017. Begin
	ll_die_id = wf_get_die_id(tab_production.tabpage_shape.dw_spec_item, lb_ab_job_has_die_id)
	ll_spec_row = tab_production.tabpage_shape.dw_spec_item.GetRow()
	
	If Not lb_ab_job_has_die_id Then
		If ll_spec_row > 0 Then
			wf_update_shape_dw(tab_production.tabpage_shape.dw_spec_item, ll_die_id)
		End If
	End If
	//Alex Gerlants. 03/27/2017. End
	
	ll_row = dw_prod_order.GetRow()
	
	//Get job status on the database
	li_status = dw_prod_order.GetItemNumber(ll_row,"job_status")
	is_job_status_desc_db = wf_get_job_status_desc(li_status)

	is_customer = wf_get_customer_name()
	
	//Alex Gerlants. 10/17/2016. Begin
	is_trimming_required = Upper(Trim(dw_prod_order.Object.trimming_required[ll_row]))
	If IsNull(is_trimming_required) Then is_trimming_required = "N"
	
	If is_trimming_required = "Y" Then
		wf_calc_edge_trim_yield_percentage(dw_prod_order, id_edge_trim_yield_percentage)
		
		ls_modstring = "edge_trim_scrap_percentage_t.Text = '" + String(id_edge_trim_yield_percentage) + "'"
		ls_rtn = dw_prod_order.Modify(ls_modstring)
		
		//dw_prod_order.Object.edge_trim_scrap_percentage[ll_row] = id_edge_trim_yield_percentage
	End If
	//Alex Gerlants. 10/17/2016. End
End If
//Alex Gerlants. 09/16/2016. End
end event

type dw_shift_coil_delete_4job from u_dw within w_production
boolean visible = false
integer x = 3569
integer y = 896
integer width = 355
integer height = 230
integer taborder = 30
string dataobject = "d_shift_coil_delete_4job"
end type

event dberror;call super::dberror;//
//
//
end event

type cb_prod_new from u_cb within w_production
string tag = "new production order"
integer x = 640
integer y = 2077
integer width = 391
integer height = 77
integer taborder = 80
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Duplicate"
end type

event clicked;String ls_msg

ls_msg = "Save production order #" + String(il_current_ab_job_id) + " as a new production order?"
IF MessageBox("Question",ls_msg, Question!, OKCancel!) <> 1 THEN Return 0

Parent.Event pfc_saveas()
end event

type cb_prod_print from u_cb within w_production
string tag = "Print current production order"
integer x = 2586
integer y = 2077
integer width = 391
integer height = 77
integer taborder = 120
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print..."
end type

event clicked;call super::clicked;Parent.Event pfc_print()
end event

type tab_production from tab within w_production
event create ( )
event destroy ( )
integer x = 22
integer y = 1165
integer width = 3529
integer height = 880
integer taborder = 150
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean boldselectedtext = true
boolean pictureonright = true
tabposition tabposition = tabsonleft!
alignment alignment = center!
integer selectedtab = 1
tabpage_item tabpage_item
tabpage_shape tabpage_shape
tabpage_pack tabpage_pack
end type

on tab_production.create
this.tabpage_item=create tabpage_item
this.tabpage_shape=create tabpage_shape
this.tabpage_pack=create tabpage_pack
this.Control[]={this.tabpage_item,&
this.tabpage_shape,&
this.tabpage_pack}
end on

on tab_production.destroy
destroy(this.tabpage_item)
destroy(this.tabpage_shape)
destroy(this.tabpage_pack)
end on

type tabpage_item from userobject within tab_production
event create ( )
event destroy ( )
integer x = 102
integer y = 13
integer width = 3412
integer height = 854
long backcolor = 79741120
string text = "Specs"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Properties!"
long picturemaskcolor = 79741120
dw_prod_item dw_prod_item
end type

on tabpage_item.create
this.dw_prod_item=create dw_prod_item
this.Control[]={this.dw_prod_item}
end on

on tabpage_item.destroy
destroy(this.dw_prod_item)
end on

type dw_prod_item from u_dw within tabpage_item
integer x = 128
integer width = 3152
integer height = 838
integer taborder = 2
string dataobject = "d_order_item_detail_2"
boolean livescroll = false
end type

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve(ii_item, il_order )
end event

event constructor;call super::constructor;SetTransObject(SQLCA)
end event

event rbuttondown;//disabled
Return 0
end event

event rbuttonup;//disabled
Return 0
end event

type tabpage_shape from userobject within tab_production
integer x = 102
integer y = 13
integer width = 3412
integer height = 854
long backcolor = 12632256
string text = "Shape"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "UserObject!"
long picturemaskcolor = 79741120
dw_spec_item dw_spec_item
end type

on tabpage_shape.create
this.dw_spec_item=create dw_spec_item
this.Control[]={this.dw_spec_item}
end on

on tabpage_shape.destroy
destroy(this.dw_spec_item)
end on

type dw_spec_item from u_dw within tabpage_shape
integer x = 435
integer y = 29
integer width = 2600
integer height = 621
integer taborder = 2
string dataobject = "d_rectangle_display"
boolean vscrollbar = false
boolean livescroll = false
end type

event pfc_retrieve;call super::pfc_retrieve;Int li_row
String ls_shape
li_row = tab_production.tabpage_item.dw_prod_item.GetRow()
IF li_row <= 0 THEN Return -1
ls_shape = tab_production.tabpage_item.dw_prod_item.GetItemString(li_row, "sheet_type", Primary!,TRUE ) 

ib_isrectangle = FALSE

//Alex Gerlants. 03/27/2017. Begin
//gl_message = 0 when we are creating a new job.
//Thus, we have to retrieve die that is set up for the order
//Alex Gerlants. 03/27/2017. End

CHOOSE CASE Upper(Trim(ls_shape))
	CASE "RECTANGLE"
		If gl_message = 0 Then //New job
			this.DataObject = "d_rectangle_display"
		Else //Existing job
			this.DataObject = "d_rectangle_display_job"
		End If
		
		ib_isrectangle = TRUE
	CASE "PARALLELOGRAM"
		If gl_message = 0 Then //New job
			this.DataObject = "d_parallelogram_display"
		Else //Existing job
			this.DataObject = "d_parallelogram_display_job"
		End If
	CASE "FENDER"
		If gl_message = 0 Then //New job
			this.DataObject = "d_fender_display"
		Else //Existing job
			this.DataObject = "d_fender_display_job"
		End If
	CASE "CHEVRON"
		If gl_message = 0 Then //New job
			this.DataObject = "d_chevron_display"
		Else //Existing job
			this.DataObject = "d_chevron_display_job"
		End If
	CASE "CIRCLE"
		If gl_message = 0 Then //New job
			this.DataObject = "d_circle_display"
		Else //Existing job
			this.DataObject = "d_circle_display_job"
		End If
	CASE "TRAPEZOID"
		If gl_message = 0 Then //New job
			this.DataObject = "d_trapezoid_display"
		Else //Existing job
			this.DataObject = "d_trapezoid_display_job"
		End If
	CASE "L.TRAPEZOID"
		If gl_message = 0 Then //New job
			this.DataObject = "d_ltrapezoid_display"
		Else //Existing job
			this.DataObject = "d_ltrapezoid_display_job"
		End If
	CASE "R.TRAPEZOID"
		If gl_message = 0 Then //New job
			this.DataObject = "d_rtrapezoid_display"
		Else //Existing job
			this.DataObject = "d_rtrapezoid_display_job"
		End If
	CASE "REINFORCEMENT"
		If gl_message = 0 Then //New job
			this.DataObject = "d_reinforcement_display"
		Else //Existing job
			this.DataObject = "d_reinforcement_display_job"
		End If
	CASE "LIFTGATE"
		If gl_message = 0 Then //New job
			this.DataObject = "d_liftgate_shape_display"
		Else //Existing job
			this.DataObject = "d_liftgate_shape_display_job"
		End If
	CASE ELSE
		If gl_message = 0 Then //New job
			this.DataObject = "d_x1shape_display"
		Else //Existing job
			this.DataObject = "d_x1shape_display_job"
		End If
END CHOOSE

SetTransObject(SQLCA)

//Alex Gerlants. 03/27/2017. Begin
//Added ", il_current_ab_job_id" to the ELSE part of the IF below
//because all datawindows that end with "_job" listed above have additional retrieval argument ab_job.ab_job_num.
//They now retrieve die_id from table ab_job instead of a shape table (like rectangle, fender, etc).
If gl_message = 0 Then //New job
	Return this.Retrieve(ii_item, il_order )
Else //Existing job
	Return this.Retrieve(ii_item, il_order, il_current_ab_job_id )
End If
																				
end event

event rbuttondown;//disabled
Return 0
end event

event rbuttonup;//disabled
Return 0
end event

event constructor;call super::constructor;SetTransObject(SQLCA)
end event

event pfc_populatedddw;call super::pfc_populatedddw;IF adwc_obj.SetTransObject(SQLCA) = -1 THEN  
	Return -1  
ELSE   
	Return adwc_obj.Retrieve()  
END IF
end event

event pfc_retrievedddw;call super::pfc_retrievedddw;DataWindowChild dddw_cni

IF this.GetChild(as_column, dddw_cni) = -1 THEN
	Return -1
ELSE
	dddw_cni.SetTransObject(SQLCA)
	
	Return dddw_cni.Retrieve() 
END IF
end event

event retrieveend;call super::retrieveend;//Alex Gerlants. 03/27/2017. Begin
//Disable/Enable column ab_job_ab_job_num depending on job_status
//Enable if job_status = 1 - In Progress or 2 - New
//Otherwise, disable.

String	ls_dataobject, ls_column_name, ls_modstring, ls_rtn
Integer	li_status

ls_dataobject = This.DataObject
ls_column_name = wf_get_die_column_name(ls_dataobject)

li_status = dw_prod_order.GetItemNumber(dw_prod_order.GetRow(),"job_status")

If li_status = 1 Or li_status = 2 Then //1 = In Progress. 2 = New
	ls_modstring = ls_column_name + ".Background.Color='1073741824'" //White
	ls_rtn = This.Modify(ls_modstring)
	
	ls_modstring = ls_column_name + ".tabsequence='10'" //Enable
	ls_rtn = This.Modify(ls_modstring)
Else
	ls_modstring = ls_column_name + ".Background.Color='553648127'" //Transparent
	ls_rtn = This.Modify(ls_modstring)
	
	ls_modstring = ls_column_name + ".tabsequence='0'" //Disable
	ls_rtn = This.Modify(ls_modstring)
End If
//Alex Gerlants. 03/27/2017. End
end event

type tabpage_pack from userobject within tab_production
integer x = 102
integer y = 13
integer width = 3412
integer height = 854
long backcolor = 12632256
string text = "Pack"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Parameter!"
long picturemaskcolor = 79741120
dw_package_term dw_package_term
end type

on tabpage_pack.create
this.dw_package_term=create dw_package_term
this.Control[]={this.dw_package_term}
end on

on tabpage_pack.destroy
destroy(this.dw_package_term)
end on

type dw_package_term from u_dw within tabpage_pack
integer x = 51
integer y = 77
integer width = 3324
integer height = 515
integer taborder = 2
string dataobject = "d_order_item_detail_proc_pack"
boolean vscrollbar = false
boolean livescroll = false
end type

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve(ii_item, il_order )
end event

event constructor;call super::constructor;SetTransObject(SQLCA)
end event

event rbuttondown;//disabled
Return 0
end event

event rbuttonup;//disabled
Return 0
end event

type cb_prod_save from u_cb within w_production
string tag = "Save changes"
integer x = 1613
integer y = 2077
integer width = 391
integer height = 77
integer taborder = 100
boolean bringtotop = true
string facename = "Arial"
string text = "&Save"
end type

event clicked;call super::clicked;Parent.Event pfc_save()
end event

type cb_orderopen from u_cb within w_production
string tag = "Open an order"
integer x = 150
integer y = 2077
integer width = 391
integer height = 77
integer taborder = 70
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Open"
end type

event clicked;Parent.Event ue_open()
end event

type cb_close from u_cb within w_production
string tag = "Close"
integer x = 3072
integer y = 2077
integer width = 391
integer height = 77
integer taborder = 130
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_sum from u_cb within w_production
string tag = "Show summary of current order"
integer x = 2099
integer y = 2077
integer width = 391
integer height = 77
integer taborder = 110
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "S&ummary..."
end type

event clicked;SetPointer(HourGlass!)
Int li_rc, li_status
Long ll_row
IF wf_updatespending() > 0 THEN
	li_rc = MessageBox("Question","Save current production order first?",Question!, OKCancel!, 1)
	IF li_rc = 1 THEN
		//Date: 03/09/04
		//Author: victor huang
		//Problem: Est. wt excesss Max skid wt
		if wf_save_order() < 0 then
			return -1
		end if	
	ELSE
		Return -1
	END IF
END IF
IF ib_new_order THEN
		MessageBox("Error","Failed to print an new & unsaved production order!", StopSign!)
		Return -2
END IF
ll_row = dw_prod_order.GetRow()
IF ll_row > 0 THEN
	li_status = dw_prod_order.GetItemNumber(ll_row, "job_status", Primary!, FALSE)
ELSE
	MessageBox("Error","Failed to retrieve this production order!", StopSign!)
	Return -3
END IF

openwithparm(w_prod_order_summary,il_current_ab_job_id)
RETURN 1

end event

type gb_3 from groupbox within w_production
integer x = 22
integer y = 333
integer width = 1371
integer height = 819
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sketch"
end type

type mle_desc from u_mle within w_production
integer x = 40
integer y = 381
integer width = 1335
integer height = 157
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
end type

event rbuttonup;RETURN 0
end event

type cb_newsketch from u_cb within w_production
integer x = 1075
integer y = 557
integer width = 307
integer height = 77
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Get &Sketch"
end type

event clicked;Long ll_id
Blob lb_pic
Long ll_r

IF wf_ok_to_modify() < 0 THEN RETURN -1

Open(w_sketch_list)
ll_id = Message.DoubleParm
IF ll_id > 0 THEN
	il_pic_id = ll_id

	SetPointer(HourGlass!)

	CONNECT USING SQLCA;
	SELECT sketch_notes
	INTO :mle_desc.Text
	FROM sketch_jpg
	WHERE sketch_id = :il_pic_id
	USING SQLCA;

	SELECTBLOB sketch_view 
	INTO :lb_pic
	FROM sketch_jpg
	WHERE sketch_id = :il_pic_id
	USING SQLCA;
	IF SQLCA.SQLCode = -1 THEN
		MessageBox("SQL ERROR", SQLCA.SQLErrText, StopSign!)
		Return
	END IF
	p_1.SetPicture(lb_pic)
	p_1.Show()
END IF
ll_r = dw_prod_order.GetRow()
IF ll_r > 0 THEN
	dw_prod_order.SetItem(ll_r, "ab_job_sketch_id", il_pic_id)
END IF
RETURN 1
end event

type cb_clearsketch from u_cb within w_production
integer x = 1075
integer y = 643
integer width = 307
integer height = 77
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Clear Sketch"
end type

event clicked;Long ll_r

IF wf_ok_to_modify() < 0 THEN RETURN -1
SetNULL(il_pic_id)
mle_desc.Event pfc_SelectAll()
mle_desc.Event pfc_Clear()
ll_r = dw_prod_order.GetRow()
IF ll_r > 0 THEN
	dw_prod_order.SetItem(ll_r, "ab_job_sketch_id", il_pic_id)
	p_1.Hide()
END IF
RETURN 1
end event

type dw_prod_order from u_dw within w_production
integer width = 3617
integer height = 333
integer taborder = 140
string dataobject = "d_product_order_detail"
boolean livescroll = false
end type

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve(il_current_ab_job_id)
end event

event pfc_addrow;call super::pfc_addrow;long ll_new_id
Long ll_row
Integer li_rc
Long ll_cust, ll_enduser
String ls_custpo, ls_enduserpo, ls_scrap, ls_ref
DateTime ldt_t

Long ll_sketch,ll_order
Int li_line, li_item,li_men
Real lr_yield,lr_pitch, lr_pp, lr_pm
String ls_sketch_note

//Alex Gerlants. 10/17/2016. Begin
String		ls_trimming_required
Integer		li_trim_type_code
Decimal{3}	ld_incoming_coil_width, ld_trimmed_coil_width
//Alex Gerlants. 10/17/2016. End

ll_new_id = f_get_next_value("ab_job_num_seq")

ll_row = this.GetRow()
li_rc = SetItem(ll_row,"ab_job_num",ll_new_id )
ldt_t = DateTime(Today(), Now())
li_rc = SetItem(ll_row,"create_date", ldt_t )
li_rc = SetItem(ll_row,"time_date_started", ldt_t )
li_rc = SetItem(ll_row,"job_status", 2 )  //new job
IF il_old_job_id > 0 THEN
	CONNECT USING SQLCA;
	SELECT sketch_id,line_num,order_item_num, material_yield,order_abc_num,number_of_men_used,sketch_job_note, pitch, pitch_plus,pitch_minus
	INTO :ll_sketch, :li_line, :li_item, :lr_yield, :ll_order, :li_men, :ls_sketch_note,  :lr_pitch, :lr_pp, :lr_pm
	FROM ab_job
	WHERE ab_job_num = :il_old_job_id
	USING SQLCA;
	li_rc = SetItem(ll_row,"line_num", li_line )
	li_rc = SetItem(ll_row,"order_item_num", li_item )
	li_rc = SetItem(ll_row,"material_yield", lr_yield)
	li_rc = SetItem(ll_row,"order_abc_num", ll_order)
	li_rc = SetItem(ll_row,"number_of_men_used", li_men)
	li_rc = SetItem(ll_row,"ab_job_sketch_id", ll_sketch)
	li_rc = SetItem(ll_row,"ab_job_sketch_job_note", ls_sketch_note)
	li_rc = SetItem(ll_row,"ab_job_pitch", lr_pitch)
	li_rc = SetItem(ll_row,"ab_job_pitch_plus", lr_pp)
	li_rc = SetItem(ll_row,"ab_job_pitch_minus", lr_pm)
	li_rc = SetItem(ll_row,"job_notes","Order copy from Job #" + String(il_old_job_id))
	il_pic_id = ll_sketch
ELSE
	li_rc = SetItem(ll_row,"order_abc_num", gstr_order.order_num )
	li_rc = SetItem(ll_row,"order_item_num", gstr_order.item_num )
	li_rc = SetItem(ll_row,"line_num", 0)
	li_rc = SetItem(ll_row,"number_of_men_used", 6)
	li_rc = SetItem(ll_row,"material_yield", 0.0)
	ll_order = gstr_order.order_num
END IF
il_current_ab_job_id = ll_new_id
il_old_job_id = 0

DataWindowChild ldddw_cni
IF this.GetChild("line_num", ldddw_cni) = -1 THEN Return -1
this.Event pfc_PopulateDDDW("line_num", ldddw_cni)
//this.Event pfc_RetrieveDDDW("line_num")

CONNECT USING SQLCA;
SELECT orig_customer_id, enduser_id, orig_customer_po, enduser_po, scrap_handing_type, reference
INTO :ll_cust, :ll_enduser, :ls_custpo, :ls_enduserpo, :ls_scrap, :ls_ref
FROM customer_order
WHERE order_abc_num = :ll_order
USING SQLCA;

SetItem(ll_row, "customer_order_orig_customer_id", ll_cust)
SetItem(ll_row, "customer_order_enduser_id", ll_enduser)
SetItem(ll_row, "customer_order_orig_customer_po", ls_custpo)
SetItem(ll_row, "customer_order_enduser_po", ls_enduserpo)
SetItem(ll_row, "customer_order_scrap_handing_type",ls_scrap)
SetItem(ll_row, "customer_order_reference", ls_ref)

//Alex Gerlants. 10/17/2016. Begin
If Not sqlca.of_isconnected() Then
	connect using sqlca;
End If

select	nvl(order_item.trimming_required, 'N'), order_item.trim_type_code, order_item.incoming_coil_width, order_item.trimmed_coil_width
into		:ls_trimming_required, :li_trim_type_code, :ld_incoming_coil_width, :ld_trimmed_coil_width
from		order_item
where		order_item.order_abc_num = :gstr_order.order_num
and		order_item.order_item_num = :gstr_order.item_num
using		sqlca;

This.Object.trimming_required[ll_row] = ls_trimming_required
This.Object.trim_type_code[ll_row] = li_trim_type_code
This.Object.incoming_coil_width[ll_row] = ld_incoming_coil_width
This.Object.trimmed_coil_width[ll_row] = ld_trimmed_coil_width
//Alex Gerlants. 10/17/2016. End

dw_prod_order.SetFocus()
dw_prod_order.Visible = TRUE

Return ll_new_id

end event

event pfc_retrievedddw;call super::pfc_retrievedddw;DataWindowChild dddw_cni

IF this.GetChild(as_column, dddw_cni) = -1 THEN
	Return -1
ELSE
	dddw_cni.SetTransObject(SQLCA)
	
	Return dddw_cni.Retrieve() 
END IF
end event

event constructor;call super::constructor;SetTransObject(sqlca) 
end event

event rbuttondown;//disabled
Return 0
end event

event rbuttonup;//disabled
Return 0
end event

event pfc_populatedddw;call super::pfc_populatedddw;IF adwc_obj.SetTransObject(SQLCA) = -1 THEN  
	Return -1  
ELSE   
	Return adwc_obj.Retrieve()  
END IF
end event

event itemchanged;call super::itemchanged;String ls_ColName
Long ll_row, ll_coilrow, ll_c, ll_bwt, ll_cwt
Int li_status, li_flag
DateTime ldt_t

li_flag = 1

ls_ColName = this.GetColumnName()
IF ls_ColName = "job_status" THEN
	this.AcceptText()
	ll_row = this.GetRow()
	li_status = this.GetItemNumber(ll_row,"job_status")
	
	is_job_status_desc_new = wf_get_job_status_desc(li_status) //Alex Gerlants. 09/16/2016
	
	IF li_status = 0 THEN
		this.SetItem(ll_row, "ab_job_job_done_time", Datetime(Today(), Now()))
		ll_coilrow = tab_mat.tabpage_coil.dw_prod_coil.RowCount()
		IF ll_coilrow > 0 THEN 
			li_flag = 0 //no
			FOR ll_c = 1 TO ll_coilrow
				ll_bwt = tab_mat.tabpage_coil.dw_prod_coil.GetItemNumber(ll_c,"process_coil_process_quantity", Primary!, FALSE)
				ll_cwt = tab_mat.tabpage_coil.dw_prod_coil.GetItemNumber(ll_c,"coil_net_wt_balance", Primary!, FALSE)			
				IF ll_bwt <> ll_cwt THEN li_flag = 1 //yes
			NEXT
		END IF
	ELSE
		SetNULL(ldt_t)
		this.SetItem(ll_row, "ab_job_job_done_time", ldt_t)
	END IF
END IF

IF li_flag = 0 THEN openwithparm(w_ab_job_coil_cut, tab_mat.tabpage_coil.dw_prod_coil)

end event

type tab_mat from tab within w_production
event create ( )
event destroy ( )
integer x = 1404
integer y = 336
integer width = 2150
integer height = 819
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean fixedwidth = true
boolean raggedright = true
boolean pictureonright = true
alignment alignment = center!
integer selectedtab = 1
tabpage_coil tabpage_coil
tabpage_wh tabpage_wh
tabpage_partial tabpage_partial
end type

on tab_mat.create
this.tabpage_coil=create tabpage_coil
this.tabpage_wh=create tabpage_wh
this.tabpage_partial=create tabpage_partial
this.Control[]={this.tabpage_coil,&
this.tabpage_wh,&
this.tabpage_partial}
end on

on tab_mat.destroy
destroy(this.tabpage_coil)
destroy(this.tabpage_wh)
destroy(this.tabpage_partial)
end on

type tabpage_coil from userobject within tab_mat
event create ( )
event destroy ( )
integer x = 15
integer y = 102
integer width = 2121
integer height = 704
long backcolor = 79741120
string text = "Coil"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Database!"
long picturemaskcolor = 553648127
dw_prod_coil dw_prod_coil
st_1 st_1
st_coil# st_coil#
st_2 st_2
st_total_wt st_total_wt
cb_addcoil cb_addcoil
cb_coil_remove cb_coil_remove
cb_finished cb_finished
cb_detail_coil cb_detail_coil
cb_resetwt cb_resetwt
end type

on tabpage_coil.create
this.dw_prod_coil=create dw_prod_coil
this.st_1=create st_1
this.st_coil#=create st_coil#
this.st_2=create st_2
this.st_total_wt=create st_total_wt
this.cb_addcoil=create cb_addcoil
this.cb_coil_remove=create cb_coil_remove
this.cb_finished=create cb_finished
this.cb_detail_coil=create cb_detail_coil
this.cb_resetwt=create cb_resetwt
this.Control[]={this.dw_prod_coil,&
this.st_1,&
this.st_coil#,&
this.st_2,&
this.st_total_wt,&
this.cb_addcoil,&
this.cb_coil_remove,&
this.cb_finished,&
this.cb_detail_coil,&
this.cb_resetwt}
end on

on tabpage_coil.destroy
destroy(this.dw_prod_coil)
destroy(this.st_1)
destroy(this.st_coil#)
destroy(this.st_2)
destroy(this.st_total_wt)
destroy(this.cb_addcoil)
destroy(this.cb_coil_remove)
destroy(this.cb_finished)
destroy(this.cb_detail_coil)
destroy(this.cb_resetwt)
end on

type dw_prod_coil from u_dw within tabpage_coil
integer x = 4
integer y = 3
integer width = 1774
integer height = 717
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_ab_job_process_coil"
end type

event constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.inv_sort.of_SetColumnHeader(TRUE)
this.inv_RowSelect.of_SetStyle ( 0 ) 


end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

this.ScrollToRow(li_Row)

Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.event pfc_rowchanged()
end event

event rbuttondown;//Override
RETURN 0
end event

event rbuttonup;//Override
RETURN 0
end event

event doubleclicked;tab_mat.tabpage_coil.cb_detail_coil.Event Clicked()
end event

type st_1 from statictext within tabpage_coil
integer x = 1799
integer y = 448
integer width = 110
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
string text = "Coil:"
boolean focusrectangle = false
end type

type st_coil# from statictext within tabpage_coil
integer x = 1799
integer y = 499
integer width = 278
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
string text = "       "
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within tabpage_coil
integer x = 1799
integer y = 557
integer width = 179
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
boolean enabled = false
string text = "NetWT:"
boolean focusrectangle = false
end type

type st_total_wt from statictext within tabpage_coil
integer x = 1799
integer y = 621
integer width = 307
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
string text = "            "
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_addcoil from commandbutton within tabpage_coil
integer x = 1796
integer y = 3
integer width = 307
integer height = 77
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Add Coil"
end type

event clicked;long ll_row, ll_order_id, ll_cust_id
Int li_status
Long	ll_order_item_num //Alex Gerlants. Wrong_Coil_4Job

ll_row = dw_prod_order.GetRow()
IF ll_row > 0 THEN 
	ll_order_id = dw_prod_order.GetItemNumber(ll_row, "order_abc_num", Primary!, FALSE)
	li_status = dw_prod_order.GetItemNumber(ll_row, "job_status", Primary!, FALSE)
	ll_order_item_num = dw_prod_order.Object.order_item_num[ll_row] //Alex Gerlants. Wrong_Coil_4Job
ELSE
	MessageBox("Warning", "NO ABC Order specified in the production order")
	Return
END IF
IF li_status = 0 THEN 
	MessageBox("Warning", "This job is done, no more coil can be added to it now.")
	Return
END IF
	
ll_row = dw_prod_order.GetRow()
IF ll_row > 0 THEN 
	ll_cust_id =  dw_prod_order.GetItemNumber(ll_row, "customer_order_orig_customer_id", Primary!, FALSE)
ELSE
	MessageBox("Warning", "NO customer specified in the production order")
	Return
END IF

s_order_data  lstr_data
lstr_data.order_num = ll_order_id
lstr_data.customer_num = ll_cust_id
lstr_data.ab_job_num = il_current_ab_job_id
lstr_data.order_item_num = ll_order_item_num //Alex Gerlants. Wrong_Coil_4Job
OpenWithParm(w_coil_order, lstr_data)

end event

type cb_coil_remove from commandbutton within tabpage_coil
integer x = 1796
integer y = 93
integer width = 307
integer height = 77
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Delete Coil"
end type

event clicked;Long ll_row, ll_coil
datastore lds_items

Long		ll_child_count, ll_item_count //Alex Gerlants. 09/13/2016
Integer	li_answer, li_return //Alex Gerlants. 09/13/2016
String	ls_system_log_msg //Alex Gerlants. 09/14/2016

IF wf_ok_to_modify() < 0 THEN RETURN -1

ll_row = tab_mat.tabpage_coil.dw_prod_coil.GetRow()
IF ll_row > 0 THEN 
	if messagebox("Delete", "About to delete coil from this order.",&
             Question!, OkCancel!,1)<>1 then
  		 Return 0
	else
		ll_coil = tab_mat.tabpage_coil.dw_prod_coil.GetItemNumber(ll_row,"process_coil_coil_abc_num", Primary!, FALSE)
		
		lds_items = CREATE datastore  
		lds_items.DataObject = "d_prod_item_job_and_coil"  
		lds_items.SetTransObject (SQLCA)  
		lds_items.Retrieve(ll_coil, il_current_ab_job_id)
		
		//MessageBox("Clicked for cb_coil_remove", "il_current_ab_job_id = " + String(il_current_ab_job_id) + "~n~Rll_coil = " + String(ll_coil))
		
		ll_item_count = lds_items.RowCount()
		
		//Alex Gerlants. 09/13/2016
		//ll_item_count = 0 //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY
		
		//IF lds_items.RowCount() > 0 THEN
		IF ll_item_count > 0 THEN
			messagebox("Warning", "Failed to delete this coil : Sheets had been cut from this coil in this job.",StopSign!)
		 	Return	-3		
		ELSE
			
			//Alex Gerlants. 09/13/2016. Begin
			//Check if row(s) exist in table shift_coil for child coil(s) for il_current_ab_job_id and ll_coil
		
			select	count(*)
			into		:ll_child_count
			from		shift_coil
			where		ab_job_num = :il_current_ab_job_id
			and		coil_abc_num = :ll_coil
			using		sqlca;
			
			If sqlca.sqlcode = 0 Then
				If ll_child_count > 0 Then
					If ll_child_count > 1 Then
						li_answer = MessageBox("Child Coil Records Exist", &
									"Child coil records exist for job " + &
									String(il_current_ab_job_id) + " and coil " + String(ll_coil) + &
									"~n~rAre you sure you want to delete coil " + String(ll_coil) + "?", &
									Question!, YesNo!, 2)
					Else //ll_child_count = 1
						li_answer = MessageBox("Child Coil Record Exists", &
									"Child coil record exists for job " + &
									String(il_current_ab_job_id) + " and coil " + String(ll_coil) + &
									"~n~rAre you sure you want to delete coil " + String(ll_coil) + "?", &
									Question!, YesNo!, 2)
					End If
					
					Choose Case li_answer
						Case 1 //Yes
							//Open a window to allow user to delete child coil(s) from table shift_coil
							OpenWithParm(w_shift_coil_delete, String(il_current_ab_job_id) + "," + String(ll_coil))
							
							//Initialize
							ib_ok_2delete_child_coil_records = False
							il_coil_abc_num_2delete = 0
							
							li_return = Message.DoubleParm
							
							Choose Case li_return
								Case 0 //User clicked on Cancel button on w_shift_coil_delete	
									Return 0
								Case 1 //OK to delete
									//These 2 variables are used in pfc_save event for w_production
									ib_ok_2delete_child_coil_records = True
									il_coil_abc_num_2delete = ll_coil
								Case -1
									MessageBox("DB Error", &
												"Database error while trying to retrieve child coil records" + &
												" for job " + String(il_current_ab_job_id) + " and coil " + String(ll_coil) + &
												".~n~rCannot continue." + &
												"~n~r~n~rPlease contact Application Support." + &
												"~n~r~n~rError:~n~r" + sqlca.sqlerrtext, StopSign!)
									Return -3
							End Choose
						Case 2 //No
							Return 0
					End Choose
				End If
			Else
				MessageBox("DB Error", 	"Database error while trying to count child coils for job " + &
												String(il_current_ab_job_id) + " and coil " + String(ll_coil) + "."  + &
												"~n~rCannot continue." + &
												"~n~r~n~rPlease contact Application Support.", StopSign!)
				Return -3
			End If
			
			//Return 0 //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY
			//Alex Gerlants. 09/13/2016. End
			
			//tab_production.tabpage_coil.dw_prod_coil.Event pfc_deleterow()
			tab_mat.tabpage_coil.dw_prod_coil.inv_rowmanager.of_DeleteRow(0)
			
			//Alex Gerlants. 09/14/2016. Begin
			//Update system log
			ls_system_log_msg = 	"Job " + String(il_current_ab_job_id) + &
										" Customer " + is_customer + &
										" by " + gnv_app.of_GetUserId() + ". " + &
										String(Today(), "mm-dd-yyyy @HH:MM.") + &
										" Deleted coil " + String(ll_coil)
		
			f_add_system_log_tran(ls_system_log_msg, sqlca)
			//Alex Gerlants. 09/14/2016. End
		END IF
		
		DESTROY lds_items
		
	end if
	wf_tabpage_coil_wt()
	ib_coilchanged = TRUE
ELSE
	MessageBox("Warning", "No coil specified")
END IF

RETURN 1


end event

type cb_finished from commandbutton within tabpage_coil
integer x = 1796
integer y = 176
integer width = 307
integer height = 77
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Done &Coil"
end type

event clicked;openwithparm(w_ab_job_coil_cut, tab_mat.tabpage_coil.dw_prod_coil)
end event

type cb_detail_coil from commandbutton within tabpage_coil
integer x = 1796
integer y = 269
integer width = 307
integer height = 77
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Detail"
end type

event clicked;Long ll_row, ll_coil

ll_row = tab_mat.tabpage_coil.dw_prod_coil.GetRow()
IF ll_row > 0 THEN 
	ll_coil = tab_mat.tabpage_coil.dw_prod_coil.GetItemNumber(ll_row,"process_coil_coil_abc_num", Primary!, FALSE)
	OpenWithParm(w_job_coil_detail_display, ll_coil)
END IF
end event

type cb_resetwt from commandbutton within tabpage_coil
string tag = "reset coil~'s current wt"
integer x = 1796
integer y = 349
integer width = 307
integer height = 77
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Reset WT"
end type

event clicked;Long ll_row, ll_coil
Long ll_wtbal

IF wf_ok_to_modify() < 0 THEN RETURN -1

ll_row = tab_mat.tabpage_coil.dw_prod_coil.GetRow()
IF ll_row > 0 THEN 
	ll_coil = tab_mat.tabpage_coil.dw_prod_coil.GetItemNumber(ll_row,"process_coil_coil_abc_num", Primary!, FALSE)

	IF MessageBox("Question","About to reset this coil's beginning WT for this job to coil's current WT, continue?", Question!, YesNo!, 2) = 2 THEN RETURN 0

	CONNECT USING SQLCA;
	SELECT net_wt_balance
	INTO :ll_wtbal
	FROM coil
	WHERE coil_abc_num = :ll_coil
	USING SQLCA;
	
	tab_mat.tabpage_coil.dw_prod_coil.SetItem(ll_row,"process_coil_process_quantity",  ll_wtbal )	
	
	wf_tabpage_coil_wt()
	ib_coilchanged = TRUE
ELSE
	MessageBox("Warning", "No coil specified")
END IF
RETURN 1
end event

type tabpage_wh from userobject within tab_mat
event create ( )
event destroy ( )
integer x = 15
integer y = 102
integer width = 2121
integer height = 704
long backcolor = 79741120
string text = "Warehouse"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Library5!"
long picturemaskcolor = 553648127
dw_job_wh_item dw_job_wh_item
end type

on tabpage_wh.create
this.dw_job_wh_item=create dw_job_wh_item
this.Control[]={this.dw_job_wh_item}
end on

on tabpage_wh.destroy
destroy(this.dw_job_wh_item)
end on

type dw_job_wh_item from u_dw within tabpage_wh
integer y = 3
integer width = 2107
integer height = 704
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_prod_wh_list"
boolean hscrollbar = true
end type

event constructor;SetTransObject(SQLCA)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

event rbuttondown;//Override
RETURN 0
end event

event rbuttonup;//Override
RETURN 0
end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

this.ScrollToRow(li_Row)

Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.event pfc_rowchanged()
end event

event pfc_populatedddw;call super::pfc_populatedddw;IF adwc_obj.SetTransObject(SQLCA) = -1 THEN  
	Return -1  
ELSE   
	Return adwc_obj.Retrieve()  
END IF
end event

type tabpage_partial from userobject within tab_mat
integer x = 15
integer y = 102
integer width = 2121
integer height = 704
long backcolor = 79741120
string text = "Partial"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Cascade!"
long picturemaskcolor = 553648127
dw_partial dw_partial
cb_addpartial cb_addpartial
cb_delpartial cb_delpartial
end type

on tabpage_partial.create
this.dw_partial=create dw_partial
this.cb_addpartial=create cb_addpartial
this.cb_delpartial=create cb_delpartial
this.Control[]={this.dw_partial,&
this.cb_addpartial,&
this.cb_delpartial}
end on

on tabpage_partial.destroy
destroy(this.dw_partial)
destroy(this.cb_addpartial)
destroy(this.cb_delpartial)
end on

type dw_partial from u_dw within tabpage_partial
integer y = 13
integer width = 1818
integer height = 707
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_ab_job_process_partial"
boolean livescroll = false
end type

event constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.inv_sort.of_SetColumnHeader(TRUE)
this.inv_RowSelect.of_SetStyle ( 0 ) 

end event

event rbuttondown;//Override
RETURN 0
end event

event rbuttonup;//Override
RETURN 0
end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

this.ScrollToRow(li_Row)

Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.event pfc_rowchanged()
end event

type cb_addpartial from u_cb within tabpage_partial
integer x = 1832
integer y = 16
integer width = 278
integer height = 77
integer taborder = 11
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Add &Partial"
end type

event clicked;long ll_row, ll_order_id, ll_cust_id
Int li_status

ll_row = dw_prod_order.GetRow()
IF ll_row > 0 THEN 
	ll_order_id = dw_prod_order.GetItemNumber(ll_row, "order_abc_num", Primary!, FALSE)
	li_status = dw_prod_order.GetItemNumber(ll_row, "job_status", Primary!, FALSE)
ELSE
	MessageBox("Warning", "NO ABC Order specified in the production order")
	Return
END IF
IF li_status = 0 THEN 
	MessageBox("Warning", "This job is done, no more coil can be added to it now.")
	Return
END IF
	
ll_row = dw_prod_order.GetRow()
IF ll_row > 0 THEN 
	ll_cust_id =  dw_prod_order.GetItemNumber(ll_row, "customer_order_orig_customer_id", Primary!, FALSE)
ELSE
	MessageBox("Warning", "NO customer specified in the production order")
	Return
END IF

OpenWithParm(w_partial_skid_list, ll_cust_id)

end event

type cb_delpartial from u_cb within tabpage_partial
integer x = 1832
integer y = 109
integer width = 278
integer height = 77
integer taborder = 11
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Del P&artial"
end type

event clicked;Long ll_row

IF wf_ok_to_modify() < 0 THEN RETURN -1

ll_row = tab_mat.tabpage_partial.dw_partial.GetRow()
IF ll_row > 0 THEN
	tab_mat.tabpage_partial.dw_partial.DeleteRow(ll_row)
END IF
RETURN 1
end event

type cb_viewsketch from u_cb within w_production
integer x = 1075
integer y = 733
integer width = 307
integer height = 77
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&View Sketch"
end type

event clicked;IF il_pic_id < 1 OR IsNULL(il_pic_id) THEN
	MessageBox("Info", "No sketch here.")
	RETURN 0
END IF
OpenWithParm(w_sketch_viewer, il_pic_id)
end event

type cb_wizard from u_cb within w_production
string tag = "create new info for this job"
integer x = 1126
integer y = 2077
integer width = 391
integer height = 77
integer taborder = 90
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Wizard"
end type

event clicked;Long ll_row, ll_order_id
Int li_status

dw_prod_order.AcceptText()
ll_row = dw_prod_order.GetRow()
IF ll_row > 0 THEN 
	ll_order_id = dw_prod_order.GetItemNumber(ll_row, "order_abc_num", Primary!, FALSE)
	li_status = dw_prod_order.GetItemNumber(ll_row, "job_status", Primary!, FALSE)
ELSE
	MessageBox("Warning", "NO ABC Order specified in the production order")
	Return -1
END IF
IF li_status = 0 THEN 
	MessageBox("Warning", "This job is done, no more modification can be added to it now.")
	Return -2
END IF

RETURN Parent.Event ue_job_wizard()

end event

type p_1 from u_p within w_production
integer x = 51
integer y = 541
integer width = 1017
integer height = 605
boolean bringtotop = true
boolean enabled = false
end type

