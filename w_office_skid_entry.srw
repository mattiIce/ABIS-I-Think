$PBExportHeader$w_office_skid_entry.srw
$PBExportComments$<Sheet> Used in office to input skid information inherited from pfemain/sheet
forward
global type w_office_skid_entry from w_sheet
end type
type cb_refresh_all from commandbutton within w_office_skid_entry
end type
type tab_skids from tab within w_office_skid_entry
end type
type tabpage_sheet from userobject within tab_skids
end type
type cb_converttoscrap from u_cb within tabpage_sheet
end type
type cb_refresh from u_cb within tabpage_sheet
end type
type cb_modify from u_cb within tabpage_sheet
end type
type cb_delete from u_cb within tabpage_sheet
end type
type cb_insert from u_cb within tabpage_sheet
end type
type cb_print from u_cb within tabpage_sheet
end type
type cb_new from u_cb within tabpage_sheet
end type
type cb_cancel from u_cb within tabpage_sheet
end type
type cb_save from u_cb within tabpage_sheet
end type
type dw_skid_editor from u_dw within tabpage_sheet
end type
type dw_skid_list from u_dw within tabpage_sheet
end type
type gb_1 from groupbox within tabpage_sheet
end type
type tabpage_sheet from userobject within tab_skids
cb_converttoscrap cb_converttoscrap
cb_refresh cb_refresh
cb_modify cb_modify
cb_delete cb_delete
cb_insert cb_insert
cb_print cb_print
cb_new cb_new
cb_cancel cb_cancel
cb_save cb_save
dw_skid_editor dw_skid_editor
dw_skid_list dw_skid_list
gb_1 gb_1
end type
type tabpage_scrap from userobject within tab_skids
end type
type cb_convertback from u_cb within tabpage_scrap
end type
type cb_scrapcredit from u_cb within tabpage_scrap
end type
type dw_report from u_dw within tabpage_scrap
end type
type cb_ref from u_cb within tabpage_scrap
end type
type cb_sort from u_cb within tabpage_scrap
end type
type cb_print_scrap from u_cb within tabpage_scrap
end type
type cb_edit from u_cb within tabpage_scrap
end type
type cb_removeitem from u_cb within tabpage_scrap
end type
type cb_remove from u_cb within tabpage_scrap
end type
type cb_newitem from u_cb within tabpage_scrap
end type
type cb_new_scrap from u_cb within tabpage_scrap
end type
type cb_ereset from u_cb within tabpage_scrap
end type
type cb_esave from u_cb within tabpage_scrap
end type
type dw_editor from u_dw within tabpage_scrap
end type
type st_9 from statictext within tabpage_scrap
end type
type dw_scrap_item from u_dw within tabpage_scrap
end type
type st_6 from statictext within tabpage_scrap
end type
type st_7 from statictext within tabpage_scrap
end type
type st_5 from statictext within tabpage_scrap
end type
type st_3 from statictext within tabpage_scrap
end type
type st_4 from statictext within tabpage_scrap
end type
type st_2 from statictext within tabpage_scrap
end type
type st_8 from statictext within tabpage_scrap
end type
type dw_scrap_list from u_dw within tabpage_scrap
end type
type tabpage_scrap from userobject within tab_skids
cb_convertback cb_convertback
cb_scrapcredit cb_scrapcredit
dw_report dw_report
cb_ref cb_ref
cb_sort cb_sort
cb_print_scrap cb_print_scrap
cb_edit cb_edit
cb_removeitem cb_removeitem
cb_remove cb_remove
cb_newitem cb_newitem
cb_new_scrap cb_new_scrap
cb_ereset cb_ereset
cb_esave cb_esave
dw_editor dw_editor
st_9 st_9
dw_scrap_item dw_scrap_item
st_6 st_6
st_7 st_7
st_5 st_5
st_3 st_3
st_4 st_4
st_2 st_2
st_8 st_8
dw_scrap_list dw_scrap_list
end type
type tabpage_scrap_credit from userobject within tab_skids
end type
type cb_convertbacktoscrap from u_cb within tabpage_scrap_credit
end type
type cb_print_scrap_credit from u_cb within tabpage_scrap_credit
end type
type dw_scrap_credit from u_dw within tabpage_scrap_credit
end type
type tabpage_scrap_credit from userobject within tab_skids
cb_convertbacktoscrap cb_convertbacktoscrap
cb_print_scrap_credit cb_print_scrap_credit
dw_scrap_credit dw_scrap_credit
end type
type tab_skids from tab within w_office_skid_entry
tabpage_sheet tabpage_sheet
tabpage_scrap tabpage_scrap
tabpage_scrap_credit tabpage_scrap_credit
end type
type dw_prod_order_detail from u_dw within w_office_skid_entry
end type
type cb_close from u_cb within w_office_skid_entry
end type
type st_title1 from u_st within w_office_skid_entry
end type
type st_title# from u_st within w_office_skid_entry
end type
type dw_coil_status from u_dw within w_office_skid_entry
end type
end forward

global type w_office_skid_entry from w_sheet
integer x = 73
integer y = 160
integer width = 4520
integer height = 1997
string title = "Skid Entry"
string menuname = "m_office_entry"
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
event type integer ue_partial_exist ( long al_skid )
event ue_new_scrap_skid ( )
event ue_delete_scrap_skid ( )
event ue_delete_scrap_item ( )
event ue_scrap_report ( )
event ue_sort_scrap ( )
event ue_ref_scrap ( )
event ue_read_only ( )
cb_refresh_all cb_refresh_all
tab_skids tab_skids
dw_prod_order_detail dw_prod_order_detail
cb_close cb_close
st_title1 st_title1
st_title# st_title#
dw_coil_status dw_coil_status
end type
global w_office_skid_entry w_office_skid_entry

type variables
Long il_current_job_num
Long il_current_order
Real ir_theo_pcwt
Long il_partial[]
Long il_cur_skid
Boolean ib_partial
Int ii_action  //0 - nothing  1 - newskid 2- new item 3-delect 4 - modify
Int il_current_order_item

//scrap handling
integer ii_dw_flag
String is_select
s_dw_db  istr_dwdb[]
s_search_condition istr_search[]
Boolean ib_readonly
Integer ii_action_scrap
Long il_cur_scrap_skid, il_cur_item

Long		il_modified_row //Alex Gerlants. 05/07/2018
Boolean	ib_use_package_num //Alex Gerlants. 06/15/2018. Arconic_Package_Num
Long		il_selected_row //Alex Gerlants. Scrap Credit
end variables

forward prototypes
public subroutine wf_get_prodorder# ()
public function integer wf_check_coil ()
public function string wf_filter_condition ()
public function integer wf_get_partial_skid ()
public function boolean wf_is_partial (long al_skid)
public function real wf_get_pc_theowt ()
public subroutine wf_set_action (integer ai_action)
public function integer wf_check_skid_wt (long al_skid, long al_item)
public function long wf_item_netwts (long al_skid, long al_item)
public function long wf_get_skid_theowt ()
public function integer wf_coil_sheet_wt (long al_coil, long al_item, long al_itemwt)
public function long wf_new_scrap_skid# ()
public subroutine wf_display_total_info ()
public function integer wf_check_info ()
public subroutine wf_set_scrap_action (integer ai_action)
public subroutine wf_coil_info ()
public subroutine wf_update_skid_list ()
public function integer wf_assign_package_num_2sheet_skid ()
public function long wf_get_package_num_4skid (long al_sheet_skid_num, n_tr_abc01 atr)
public subroutine wf_retrieve_scrap_handling (ref string as_scrap_handling_cust_order)
public function integer wf_scrap_credit (boolean ab_display_message, long al_scrap_skid_num, boolean ab_new_skid)
public function boolean wf_check_scrap_skid_status ()
public function boolean wf_check_sheet_skid_status ()
end prototypes

event ue_whoami;RETURN "w_offics_skid_entry"
end event

event type integer ue_partial_exist(long al_skid);Long ll_row, ll_l

ll_row = tab_skids.tabpage_sheet.dw_skid_list.RowCount()
IF ll_row > 0 THEN
	FOR ll_l = 1 TO ll_row
		IF tab_skids.tabpage_sheet.dw_skid_list.getItemNumber(ll_l, "sheet_skid_sheet_skid_num", Primary!, FALSE) = al_skid THEN
			RETURN 1
		END IF
	NEXT
END IF

RETURN 0
end event

event ue_new_scrap_skid();Int li_i
Long ll_skid
li_i = MessageBox("Question","Use a existing pallet?",Question!, YesNoCancel!, 1)
IF li_i = 3 THEN RETURN
IF li_i = 1 THEN
	Open(w_select_new_scrap_skid)
	ll_skid = Message.DoubleParm
	tab_skids.tabpage_scrap.dw_editor.Event ue_addscrap(ll_skid)
	tab_skids.tabpage_scrap.dw_scrap_list.SetFilter("skid_scrap_status <> 6")
	tab_skids.tabpage_scrap.dw_scrap_list.Filter()
ELSE
	tab_skids.tabpage_scrap.dw_editor.ResetUpdate()
	tab_skids.tabpage_scrap.dw_editor.DataObject = "d_office_entry_scrap_skid_list_editor"
	tab_skids.tabpage_scrap.dw_editor.SetTransObject(sqlca) 
	tab_skids.tabpage_scrap.dw_editor.Event pfc_addrow()
END IF
end event

event ue_delete_scrap_skid();SetPointer(HourGlass!)

integer li_rc, li_status, li_rowcount
Long ll_row, ll_scrap_item, li_return, scrap_skid_id
li_rc = MessageBox("Warning!", "Are you sure?", Exclamation!, OKCancel!, 2 )
IF Li_rc = 1 THEN
	ll_row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
	If ll_row < 1 THEN RETURN
	li_status = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "skid_scrap_status", Primary!, FALSE)
	IF li_status = 0 THEN
		MessageBox("Error", "This scrap skid had been shipped!", StopSign!)
		RETURN
	END IF
	/*
	li_rowcount = tab_skids.tabpage_scrap.dw_scrap_item.RowCount()
	IF li_rowcount > 1 THEN
		MessageBox("Warning", "There are more than one items on this skid, Please delete items first.", StopSign!)
		RETURN
	END IF	
	
	*/
	il_cur_scrap_skid = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "scrap_skid_num", Primary!, FALSE)
	//MessageBox ("info", il_cur_scrap_skid)
	scrap_skid_id = il_cur_scrap_skid
	//transaction dboconnect
	//dboconnect = create transaction
	//dboconnect.DBMS = ProfileString(gs_ini_file,"Database","DBMS","")
	//dboconnect.Servername = ProfileString(gs_ini_file,"Database","ServerName","")
	//dboconnect.LogID = gs_LogID
	//dboconnect.LogPass = gs_LogPass
	//connect using SQLCA;
	//if dboconnect.SQLCode<0 then 
	//	MessageBox ("Connection Failed!!!!",dboconnect.sqlerrtext,exclamation!)
   //return
	//end if

	DECLARE p_delete procedure for f_delete_scrap_skid (:scrap_skid_id) using sqlca;
	execute p_delete;
if sqlca.SQLCode <> 0 then 
	MessageBox ("Stored Procedure Failed!!!",sqlca.sqlerrtext,exclamation!)
	return
end if
fetch p_delete INTO :li_return; 
//close p_edi;

close p_delete;
IF li_return >10000 THEN
	MessageBox("Warning", "Skid assigned to shipment " +String(li_return) + "!!! Please delete in shipment first!", StopSign! )
	return
end if
//disconnect using sqlca;
//destroy dboconnect;
	

		IF tab_skids.tabpage_scrap.dw_scrap_list.GetRow() > 0 THEN
			tab_skids.tabpage_scrap.dw_scrap_list.DeleteRow(tab_skids.tabpage_scrap.dw_scrap_list.GetRow() )
		END IF









//	ll_row = tab_skids.tabpage_scrap.dw_scrap_item.GetRow()
//	il_cur_item =  tab_skids.tabpage_scrap.dw_scrap_item.GetItemNumber(ll_row, "return_scrap_item_return_scrap_item_num", Primary!, FALSE)
//	tab_skids.tabpage_scrap.dw_scrap_list.RowsCopy(tab_skids.tabpage_scrap.dw_scrap_list.GetRow(), tab_skids.tabpage_scrap.dw_scrap_list.GetRow(), Primary!, tab_skids.tabpage_scrap.dw_editor, 1, Primary!)
//	wf_set_scrap_action(5)
//	tab_skids.tabpage_scrap.dw_editor.Event ue_del_row()

END IF
RETURN
end event

event ue_delete_scrap_item();SetPointer(HourGlass!)

integer li_rc, li_status, li_rowcount
Long ll_row
li_rc = MessageBox("Warning!", "Are you sure?", Exclamation!, OKCancel!, 2 )
IF Li_rc = 1 THEN
	ll_row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
	If ll_row < 1 THEN RETURN
	li_status = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "skid_scrap_status", Primary!, FALSE)
	IF li_status = 0 THEN
		MessageBox("Warning", "This scrap skid had been shipped!", StopSign!)
		RETURN
	END IF
	li_rowcount = tab_skids.tabpage_scrap.dw_scrap_item.RowCount()
	IF li_rowcount = 1 THEN
		MessageBox("Warning", "This is the last item on the skid!", StopSign!)
		RETURN
	END IF	
	il_cur_scrap_skid = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "scrap_skid_num", Primary!, FALSE)
	tab_skids.tabpage_scrap.dw_scrap_item.RowsCopy(tab_skids.tabpage_scrap.dw_scrap_item.GetRow(), tab_skids.tabpage_scrap.dw_scrap_item.GetRow(), Primary!, tab_skids.tabpage_scrap.dw_editor, 1, Primary!)
	wf_set_scrap_action(3)
	tab_skids.tabpage_scrap.dw_editor.Event ue_del_row()
END IF
RETURN

end event

event ue_scrap_report();//tab_skids.tabpage_scrap.dw_scrap_list.Print(TRUE)
	
//	Datawindow lds_temp
//lds_temp = Message.PowerObjectParm
SetPointer(HourGlass!)

tab_skids.tabpage_scrap.dw_scrap_list.ShareData(tab_skids.tabpage_scrap.dw_report )

long ll_row_cust
String ls_cust_name, ls_mod

//ll_row_cust = dw_customer.GetRow()
//ls_cust_name = dw_customer.GetItemString(ll_row_cust, "customer_short_name", Primary!, TRUE)
select customer_short_name into :ls_cust_name
from customer_order, customer
where customer.customer_id = customer_order.orig_customer_id and order_abc_num = :il_current_order
using SQLCA;

ls_cust_name = Upper(ls_cust_name)
ls_cust_name = Trim(ls_cust_name)

ls_mod = "cust_t.Text = ~"" + ls_cust_name + "~""
tab_skids.tabpage_scrap.dw_report.Modify(ls_mod) 

//dw_report.SetFocus()
	tab_skids.tabpage_scrap.dw_report.SetFocus()
	Printsetup()
	tab_skids.tabpage_scrap.dw_report.Print(TRUE)

end event

event ue_sort_scrap();String ls_null
SetNULL(ls_null)
tab_skids.tabpage_scrap.dw_scrap_list.inv_sort.of_SetSort(ls_null)
tab_skids.tabpage_scrap.dw_scrap_list.inv_sort.of_Sort()
//tab_skids.tabpage_scrap.dw_report.inv_sort.of_SetSort(ls_null)
//tab_skids.tabpage_scrap.dw_report.inv_sort.of_Sort()

end event

event ue_ref_scrap();Long ll_row, ll_id

//CHOOSE CASE tab_skids.SelectedTab
	//CASE 1 //skid
		ll_row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
		IF ll_row < 1 THEN RETURN
		ll_id = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "scrap_skid_num", Primary!, FALSE)
		IF ll_id > 0 THEN
			OpenWithParm(w_scrap_skid_detail_info, ll_id)
		END IF		
	//CASE 2 //rej coil
		//ll_row = tab_skid.tabpage_rejcoil.dw_rejcoils.GetRow()
		//IF ll_row < 1 THEN RETURN
		//ll_id = tab_scrap.tabpage_rejcoil.dw_rejcoils.GetItemNumber(ll_row, "coil_coil_abc_num", Primary!, FALSE)
		//IF ll_id > 0 THEN
		//	OpenWithParm(w_coil_detail_info, ll_id)
		//END IF		
//END CHOOSE
end event

event ue_read_only();tab_skids.tabpage_scrap.cb_new_scrap.Enabled = FALSE
tab_skids.tabpage_scrap.cb_newitem.Enabled = FALSE
tab_skids.tabpage_scrap.cb_edit.Enabled = FALSE
tab_skids.tabpage_scrap.cb_esave.Enabled = FALSE
tab_skids.tabpage_scrap.cb_ereset.Enabled = FALSE
tab_skids.tabpage_scrap.cb_remove.Enabled = FALSE
tab_skids.tabpage_scrap.cb_removeitem.Enabled = TRUE		

//m_prod_scrap.m_file.m_new.Disable()
//m_prod_scrap.m_file.m_save.Disable()
//m_prod_scrap.m_file.m_delete.Disable()

end event

public subroutine wf_get_prodorder# ();SingleLineEdit sle_order#
sle_order# = Message.PowerObjectParm
st_title#.Text = sle_order#.Text
il_current_job_num = Long(st_title#.Text)

end subroutine

public function integer wf_check_coil ();Long ll_coil, ll_trows, ll_i, ll_trowc, ll_j

dw_coil_status.AcceptText()
ll_trowc = dw_coil_status.RowCount()
IF ll_trowc < 1 THEN RETURN 0

FOR ll_i = 1 TO ll_trows
	ll_coil = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_i, "production_sheet_item_coil_abc_num", Primary!, FALSE)
	FOR ll_j = 1 TO ll_trowc
		IF dw_coil_status.GetItemNumber(ll_j, "coil_coil_abc_num", Primary!, FALSE) = ll_coil THEN 
			IF dw_coil_status.GetItemNumber(ll_j, "coil_coil_status", Primary!, FALSE) = 2 THEN
				dw_coil_status.SetItem(ll_j, "coil_coil_status", 1) //processing
			END IF
		END IF
	NEXT
NEXT 

RETURN 1
end function

public function string wf_filter_condition ();Int li_up, li_i
String ls_terms

ls_terms = " ( sheet_skid_ab_job_num = " + String(il_current_job_num) + ") "
li_up = UpperBound(il_partial)
IF li_up > 0 THEN
	FOR li_i = 1 TO li_up
		IF il_partial[li_i] > 0 THEN
			ls_terms = ls_terms + " OR (sheet_skid_sheet_skid_num = " + String(il_partial[li_i]) + " ) "
		END IF
	NEXT
END IF

RETURN ls_terms
end function

public function integer wf_get_partial_skid ();Long ll_skid
Long ll_i
Long ll_row, ll_l
DataStore lds_d

lds_d = CREATE DataStore
lds_d.DataObject = "d_job_partial_skid_list"
lds_d.setTransObject(SQLCA)
lds_d.retrieve(il_current_job_num)

IF RowCount(lds_d) = 0 THEN RETURN 0

FOR ll_i = 1 TO rowCount(lds_d) 
	ll_skid = lds_d.GetItemNumber(ll_i, "sheet_skid_num")
	il_partial[Upperbound(il_partial) + 1] = ll_skid

	ll_row = tab_skids.tabpage_sheet.dw_skid_list.RowCount()
	IF ll_row > 0 THEN
		FOR ll_l = 1 TO ll_row
			IF tab_skids.tabpage_sheet.dw_skid_list.getItemNumber(ll_l, "sheet_skid_sheet_skid_num", Primary!, FALSE) = ll_skid THEN
				IF tab_skids.tabpage_sheet.dw_skid_list.getItemNumber(ll_l,"sheet_skid_ab_job_num", Primary!, FALSE) <> il_current_job_num THEN
					tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_l, "sheet_skid_ab_job_num", il_current_job_num)
				END IF
			END IF
		NEXT
	END IF
	
//	ll_row = dw_skid_data.RowCount()
//	IF ll_row > 0 THEN
//		FOR ll_l = 1 TO ll_row
//			IF dw_skid_data.getItemNumber(ll_l, "sheet_skid_num", Primary!, FALSE) = ll_skid THEN
//				IF dw_skid_data.getItemNumber(ll_l,"ab_job_num", Primary!, FALSE) <> il_current_job_num THEN
//					dw_skid_data.SetItem(ll_l, "ab_job_num", il_current_job_num)
//				END IF
//			END IF
//		NEXT
//	END IF
	
NEXT
tab_skids.tabpage_sheet.dw_skid_list.AcceptText()
tab_skids.tabpage_sheet.dw_skid_list.inv_filter.of_SetFilter(wf_filter_condition())
tab_skids.tabpage_sheet.dw_skid_list.inv_filter.of_Filter()


DESTROY lds_d

RETURN 0
end function

public function boolean wf_is_partial (long al_skid);Boolean lb_partial

lb_partial = FALSE

RETURN lb_partial
end function

public function real wf_get_pc_theowt ();Long ll_order_item, ll_order
Real lr_wt

lr_wt = 0
CONNECT USING SQLCA;
SELECT order_item_num, order_abc_num INTO :ll_order_item, :ll_order
FROM ab_job
WHERE ab_job_num = :il_current_job_num
USING SQLCA;

IF ll_order_item > 0 AND ll_order > 0 THEN
	SELECT theoretical_unit_wt INTO :lr_wt
	FROM order_item
	WHERE order_abc_num = :ll_order AND order_item_num = :ll_order_item
	USING SQLCA;
END IF
IF IsNULL(lr_wt) THEN lr_wt = 0

RETURN lr_wt
end function

public subroutine wf_set_action (integer ai_action);IF ai_action = 0 THEN
	tab_skids.tabpage_sheet.cb_new.Enabled = TRUE
	tab_skids.tabpage_sheet.cb_insert.Enabled = TRUE
	tab_skids.tabpage_sheet.cb_delete.Enabled = TRUE
	tab_skids.tabpage_sheet.cb_modify.Enabled = TRUE
	tab_skids.tabpage_sheet.cb_refresh.Enabled = TRUE
ELSE
	tab_skids.tabpage_sheet.cb_new.Enabled = FALSE
	tab_skids.tabpage_sheet.cb_insert.Enabled = FALSE
	tab_skids.tabpage_sheet.cb_delete.Enabled = FALSE
	tab_skids.tabpage_sheet.cb_modify.Enabled = FALSE
	tab_skids.tabpage_sheet.cb_refresh.Enabled = FALSE
END IF
ii_action = ai_action

end subroutine

public function integer wf_check_skid_wt (long al_skid, long al_item);Long ll_row, ll_pc, ll_totalpc, ll_totalwt
Long ll_trow, ll_skid, ll_item, ll_i, ll_net
Long ll_otherpc, ll_othernet

tab_skids.tabpage_sheet.dw_skid_editor.AcceptText()
ll_row = tab_skids.tabpage_sheet.dw_skid_editor.GetRow()
ll_pc = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row,"production_sheet_item_prod_item_pieces", Primary!, FALSE)
ll_net = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row, "production_sheet_item_prod_item_net_wt", Primary!, FALSE)

ll_totalpc = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row,"sheet_skid_skid_pieces", Primary!, FALSE)
ll_totalwt = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row,"sheet_skid_sheet_net_wt", Primary!, FALSE)

ll_trow = tab_skids.tabpage_sheet.dw_skid_list.RowCount()
IF (ll_trow < 1) OR IsNULL(ll_trow) THEN RETURN 0
ll_otherpc = 0
ll_othernet = 0
FOR ll_i = 1 TO ll_trow
	ll_skid = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_i, "sheet_skid_sheet_skid_num", Primary!, FALSE)
	ll_item = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_i, "production_sheet_item_prod_item_num", Primary!, FALSE)
	IF ll_skid = al_skid AND al_item <> ll_item THEN
		ll_otherpc = ll_otherpc + tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_i,"production_sheet_item_prod_item_pieces", Primary!, FALSE)
		ll_othernet = ll_othernet + tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_i, "production_sheet_item_prod_item_net_wt", Primary!, FALSE)		
	END IF
NEXT
IF ll_otherpc <> ll_totalpc - ll_pc THEN
	IF MessageBox("Question", "Skid pieces do not add up right, save it anyway?", Question!, YesNo!, 2) = 2 THEN RETURN -1	
END IF
IF ll_othernet <> ll_totalwt - ll_net THEN
	IF MessageBox("Question", "Skid net wt does not add up right, save it anyway?", Question!, YesNo!, 2) = 2 THEN RETURN -2
END IF

RETURN 1
end function

public function long wf_item_netwts (long al_skid, long al_item);Long ll_net
Long ll_row, ll_i

ll_net = 0
ll_row = tab_skids.tabpage_sheet.dw_skid_list.RowCount()
IF ll_row < 1 THEN RETURN ll_net
FOR ll_i = 1 TO ll_row
	IF al_skid = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_i,"sheet_skid_sheet_skid_num", Primary!, FALSE) THEN
		IF al_item <> tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_i, "sheet_skid_detail_prod_item_num", Primary!, FALSE) THEN
			ll_net = ll_net + tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_i, "production_sheet_item_prod_item_net_wt", Primary!, FALSE)
		END IF
	END IF
NEXT	

RETURN ll_net
end function

public function long wf_get_skid_theowt ();Long ll_theowt
Long ll_row, ll_i, ll_skid, ll_item

ll_row = tab_skids.tabpage_sheet.dw_skid_editor.GetRow()
IF ll_row < 1 THEN RETURN ll_theowt
ll_skid = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num", Primary!, FALSE)
ll_item = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row, "production_sheet_item_prod_item_num", Primary!, FALSE)
ll_theowt = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row, "production_sheet_item_prod_item_theoreti", Primary!, FALSE)

ll_row = tab_skids.tabpage_sheet.dw_skid_list.RowCount()
IF ll_row < 1 THEN RETURN ll_theowt	
FOR ll_i = 1 TO ll_row
	IF ll_skid = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_i,"sheet_skid_sheet_skid_num", Primary!, FALSE) THEN
		IF ll_item <> tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_i, "sheet_skid_detail_prod_item_num", Primary!, FALSE) THEN
			ll_theowt = ll_theowt + tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_i, "production_sheet_item_prod_item_theoreti", Primary!, FALSE)
		END IF
	END IF
NEXT	

RETURN ll_theowt
end function

public function integer wf_coil_sheet_wt (long al_coil, long al_item, long al_itemwt);Long ll_coilwt, ll_sheetwt, ll_othersheet

IF IsNULL(al_item) OR IsNULL(al_coil) OR IsNULL(al_itemwt) THEN RETURN 0

CONNECT USING SQLCA;
SELECT process_quantity INTO :ll_coilwt
FROM process_coil
WHERE coil_abc_num = :al_coil AND ab_job_num = :il_current_job_num
USING SQLCA;

IF ll_coilwt < 1 OR IsNULL(ll_coilwt) THEN RETURN 0

SELECT SUM(prod_item_net_wt) INTO :ll_othersheet
FROM production_sheet_item
WHERE coil_abc_num = :al_coil AND ab_job_num = :il_current_job_num AND prod_item_num <> :al_item
USING SQLCA;
ll_sheetwt = al_itemwt + ll_othersheet

IF ll_sheetwt > ll_coilwt THEN
	IF MessageBox("Question", "This coil has more net sheet wt than the beginning coil wt, continue?", Question!, YesNo!, 1) <> 1 THEN RETURN -1
END IF 

RETURN 1
end function

public function long wf_new_scrap_skid# ();Long  ll_int_next_id
String ls_col_name

ls_col_name = 'scrap_skid_num_seq'
SELECT scrap_skid_num_seq.NEXTVAL INTO :ll_int_next_id FROM DUAL;

// generate next id using oracle sequence 
UPDATE sequence_key
SET sequence_curval = :ll_int_next_id
WHERE sequence_name = :ls_col_name
USING SQLCA;

IF SQLCA.SQLCode = -1 THEN
	MessageBox("Database Error", SQLCA.SQLErrText, Exclamation!)
	ROLLBACK using SQLCA;
	Return -2
ELSE
	COMMIT using SQLCA;
END IF

Return ll_int_next_id
end function

public subroutine wf_display_total_info ();/*
String ls_where, ls_select
Long ll_item

CONNECT USING SQLCA;
//ls_select = "SELECT COUNT(scrap_skid.scrap_skid_num) FROM scrap_skid "
//ls_where = wf_display_total_terms()
//IF IsNULL(ls_where) THEN RETURN 

DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA ;
String ls_Mysql
ls_Mysql = "SELECT COUNT(scrap_skid.scrap_skid_num) FROM scrap_skid where ((scrap_ab_job_num = " + String (il_current_job_num) + ")  OR ( SKID_SCRAP_STATUS = 6 ))   AND	( CUSTOMER_ID <> 1054 )"//ls_select + ls_where

PREPARE SQLSA FROM :ls_Mysql;
OPEN DYNAMIC my_cursor;
FETCH my_cursor INTO :ll_item;
CLOSE my_cursor ;

IF IsNULL(ll_item) THEN ll_item = 0

IF ll_item < 2 THEN
	tab_skids.tabpage_scrap.dw_scrap_list.Object.item_t.Text = String(ll_item, "#,###,###")
	tab_skids.tabpage_scrap.dw_scrap_list.Object.skid_t.Text = "Scrap Skid"
ELSE
	tab_skids.tabpage_scrap.dw_scrap_list.Object.item_t.Text = String(ll_item, "#,###,###")
	tab_skids.tabpage_scrap.dw_scrap_list.Object.skid_t.Text = "Scrap Skids"
END IF
*/
RETURN 
end subroutine

public function integer wf_check_info ();Long ll_row, ll_row2, ll_cust, ll_job, ll_icoil
String ls_alloy, ls_calloy
Long ll_ccust

//ll_row = dw_customer.GetRow()
//IF ll_row > 0 THEN
//	ll_cust = dw_customer.GetITemNumber(ll_row, "customer_id")
//END IF
select orig_customer_id into :ll_cust
from customer_order
where order_abc_num = :il_current_order
using SQLCA;

tab_skids.tabpage_scrap.dw_editor.AcceptText()
ll_row = tab_skids.tabpage_scrap.dw_editor.GetRow()
IF (ll_row < 1) OR IsNULL(ll_row) THEN RETURN 0
CHOOSE CASE ii_action
	CASE 1, 4  //skid
		ll_job = Long(tab_skids.tabpage_scrap.dw_editor.GetItemString(ll_row, "scrap_ab_job_num", Primary!, FALSE))
	CASE 2, 6   //item
		ll_icoil = tab_skids.tabpage_scrap.dw_editor.GetItemNumber(ll_row, "return_scrap_item_coil_abc_num", Primary!, FALSE)
		ll_job = tab_skids.tabpage_scrap.dw_editor.GetItemNumber(ll_row, "return_scrap_item_ab_job_num", Primary!, FALSE)
		ll_row2 = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
		IF (ll_row2 > 0) THEN
			ls_alloy = tab_skids.tabpage_scrap.dw_scrap_list.GetItemString(ll_row2, "scrap_alloy2", Primary!, FALSE)
		ELSE
			ls_alloy = ""
		END IF
END CHOOSE
IF ll_job > 0 THEN
	CONNECT USING SQLCA;
	SELECT customer_order.orig_customer_id INTO :ll_ccust
	FROM customer_order, ab_job
	WHERE ab_job.ab_job_num = :ll_job and ab_job.order_abc_num = customer_order.order_abc_num
	USING SQLCA;
	IF ll_ccust <> ll_cust THEN
		IF MessageBox("Warning", "Job number and customer do NOT match! Continue?", Question!, YesNo!, 2) = 2 THEN RETURN -1
	END IF
	SELECT order_item.alloy2 INTO :ls_calloy
	FROM order_item, ab_job
	WHERE ab_job.ab_job_num = :ll_job and ab_job.order_abc_num = order_item.order_abc_num and ab_job.order_item_num = order_item.order_item_num
	USING SQLCA;
	IF (ls_calloy <> ls_alloy) and (ls_alloy <> "") THEN
		IF MessageBox("Warning", "Job and scrap skid alloy do not match! Continue?", Question!, YesNo!, 2) = 2 THEN RETURN -2
	END IF
END IF
IF ll_icoil > 0 THEN
	CONNECT USING SQLCA;
	SELECT coil_alloy2 INTO :ls_calloy
	FROM coil
	WHERE coil_abc_num = :ll_icoil
	USING SQLCA;
	IF (ls_calloy <> ls_alloy) and (ls_alloy <> "") THEN
		IF MessageBox("Warning", "Coil and scrap skid alloy do not match! Continue?", Question!, YesNo!, 2) = 2 THEN RETURN -3
	END IF	
END IF
	
RETURN 1
end function

public subroutine wf_set_scrap_action (integer ai_action);IF ai_action = 0 THEN
	IF f_security_door("Scrap Handling") = 1 THEN
		tab_skids.tabpage_scrap.cb_new_scrap.Enabled = TRUE
		tab_skids.tabpage_scrap.cb_newitem.Enabled = TRUE
		tab_skids.tabpage_scrap.cb_edit.Enabled = TRUE
		tab_skids.tabpage_scrap.cb_esave.Enabled = FALSE
		tab_skids.tabpage_scrap.cb_ereset.Enabled = FALSE
		tab_skids.tabpage_scrap.cb_remove.Enabled = TRUE		
		tab_skids.tabpage_scrap.cb_removeitem.Enabled = TRUE		
	ELSE
		//This.Event ue_read_only()
	END IF
ELSE
	tab_skids.tabpage_scrap.cb_new_scrap.Enabled = FALSE
	tab_skids.tabpage_scrap.cb_newitem.Enabled = FALSE
	tab_skids.tabpage_scrap.cb_edit.Enabled = FALSE
	tab_skids.tabpage_scrap.cb_remove.Enabled = FALSE
	tab_skids.tabpage_scrap.cb_removeitem.Enabled = TRUE		
	tab_skids.tabpage_scrap.cb_esave.Enabled = TRUE
	tab_skids.tabpage_scrap.cb_ereset.Enabled = TRUE
END IF
ii_action_scrap = ai_action
end subroutine

public subroutine wf_coil_info ();//Alex Gerlants. 03/14/2018. Begin
/*
Function:	wf_coil_info
				It will update information needed to show in compute_1 on dw_skid_list
Returns:		none
Arguments:	none
*/

Long		ll_coil_abc_num
String	ls_coil_org_num, ls_coil_mid_num, ls_lot_num


ll_coil_abc_num = tab_skids.tabpage_sheet.dw_skid_editor.Object.production_sheet_item_coil_abc_num[tab_skids.tabpage_sheet.dw_skid_editor.GetRow()]

select	coil_org_num, coil_mid_num, lot_num
into		:ls_coil_org_num, :ls_coil_mid_num, :ls_lot_num
from		coil
where		coil_abc_num = :ll_coil_abc_num
using		sqlca;

tab_skids.tabpage_sheet.dw_skid_editor.Object.coil_org_num[tab_skids.tabpage_sheet.dw_skid_editor.GetRow()] = ls_coil_org_num
tab_skids.tabpage_sheet.dw_skid_editor.Object.coil_mid_num[tab_skids.tabpage_sheet.dw_skid_editor.GetRow()] = ls_coil_mid_num
tab_skids.tabpage_sheet.dw_skid_editor.Object.lot_num[tab_skids.tabpage_sheet.dw_skid_editor.GetRow()] = ls_lot_num
//Alex Gerlants. 03/14/2018. End
end subroutine

public subroutine wf_update_skid_list ();//Alex Gerlants. 05/07/2018. Begin
/*
Function:	wf_update_skid_list
Returns:		None
Arguments:	None
*/
String	ls_coil_org_num, ls_coil_mid_num, ls_lot_num
Long		ll_editor_rows, ll_coil_abc_num, ll_editor_row

//Get coil_org_num, coil_mid_num, lot_num, and coil_abc_num from dw_skid_editor
tab_skids.tabpage_sheet.dw_skid_editor.GetRow()

ll_editor_row = tab_skids.tabpage_sheet.dw_skid_editor.GetRow()
//ll_editor_rows = tab_skids.tabpage_sheet.dw_skid_editor.RowCount()

If ll_editor_row > 0 Then
	ls_coil_org_num = tab_skids.tabpage_sheet.dw_skid_editor.Object.coil_org_num[ll_editor_row]
	ls_coil_mid_num = tab_skids.tabpage_sheet.dw_skid_editor.Object.coil_mid_num[ll_editor_row]
	ls_lot_num = tab_skids.tabpage_sheet.dw_skid_editor.Object.lot_num[ll_editor_row]
	ll_coil_abc_num = tab_skids.tabpage_sheet.dw_skid_editor.Object.production_sheet_item_coil_abc_num[ll_editor_row]
	
	//Update dw_skid_list
	If il_modified_row > 0 Then
		tab_skids.tabpage_sheet.dw_skid_list.Object.coil_org_num[il_modified_row] = ls_coil_org_num
		tab_skids.tabpage_sheet.dw_skid_list.Object.coil_mid_num[il_modified_row] = ls_coil_mid_num
		tab_skids.tabpage_sheet.dw_skid_list.Object.lot_num[il_modified_row] = ls_lot_num
		tab_skids.tabpage_sheet.dw_skid_list.Object.production_sheet_item_coil_abc_num[il_modified_row] = ll_coil_abc_num
		
		il_modified_row = 0 //Reset
	End If
End If
//Alex Gerlants. 05/07/2018. End
end subroutine

public function integer wf_assign_package_num_2sheet_skid ();//Alex Gerlants. 06/15/2018. Arconic_Package_Num. Begin
/*
Function:	wf_assign_package_num_2sheet_skid
Returns:		integer	 1 if ok
							-1 if DB error
Arguments:	none							
*/

Integer	li_rtn = 1
Long		ll_ab_job_num, ll_rows, ll_row, ll_sheet_skid_num
Boolean	lb_use_package_num


li_rtn = f_get_use_package_num_4job(il_current_job_num, sqlca, lb_use_package_num)

If li_rtn = 0 Then //OK in f_get_use_package_num_4job(). li_rtn = sqlca.sqlcode in f_get_use_package_num_4job().
	If IsNull(lb_use_package_num) Then lb_use_package_num = False
Else //DB error in f_get_use_package_num_4job(). Error message is in this function.
	lb_use_package_num = False
End If

If lb_use_package_num Then
	tab_skids.tabpage_sheet.dw_skid_list.AcceptText()
	
	ll_rows = tab_skids.tabpage_sheet.dw_skid_list.RowCount()
	
	For ll_row = 1 To ll_rows
		ll_ab_job_num = tab_skids.tabpage_sheet.dw_skid_list.Object.sheet_skid_ab_job_num[ll_row]
		ll_sheet_skid_num = tab_skids.tabpage_sheet.dw_skid_list.Object.sheet_skid_sheet_skid_num[ll_row]
		
		li_rtn = f_assign_package_num(ll_ab_job_num, ll_sheet_skid_num, sqlca)
		
		If li_rtn <> 0 Then //Error in f_assign_package_num()
			Return -1
		End If
	Next
	End If

Return li_rtn
//Alex Gerlants. 06/15/2018. Arconic_Package_Num. End
end function

public function long wf_get_package_num_4skid (long al_sheet_skid_num, n_tr_abc01 atr);//Alex Gerlants. 06/15/2018. Arconic_Package_Num. Begin
/*
Function:	wf_get_package_num_4skid
Returns:		long <== package_num if ok
					  <== -1 if db error
Arguments:	value	long			al_sheet_skid_num
				value	n_tr_abc01	atr
*/
Long		ll_package_num

SetNull(ll_package_num)

select	package_num
into		:ll_package_num
from		dbo.sheet_skid_package
where		sheet_skid_num = :al_sheet_skid_num
using		atr;

Choose Case atr.sqlcode
	Case 0 //Row found. OK
		//
	Case 100 //Row not found
		//ll_package_num = Null. OK
	Case Else //DB error
		ll_package_num = -1
	
		MessageBox("DB error", 	"Database error occurred in wf_get_package_num_4skid for w_office_skid_entry " + &
										"while triyng to retrieve package number from table sheet_skid_package " + &
										"for skid " + String(al_sheet_skid_num) + &
										"~n~r~n~rError:~n~r" + atr.sqlerrtext)
End Choose

Return ll_package_num
//Alex Gerlants. 06/15/2018. Arconic_Package_Num. End
end function

public subroutine wf_retrieve_scrap_handling (ref string as_scrap_handling_cust_order);//Alex Gerlants. Scrap Credit. Begin
/*
Function:	wf_retrieve_scrap_handling
Returns:		none
Arguments:	value	string	as_scrap_handling_cust_order
*/
DataWindowChild 	ldwc
Integer				li_rtn
String				ls_find_string
Long					ll_found_row

Long					ll_rows, ll_inserted_row, ll_null
String				ls_null

li_rtn = tab_skids.tabpage_scrap.dw_editor.GetChild("scrap_handling_type", ldwc)

If li_rtn = 1 Then
	ldwc.SetTransObject(sqlca)
	ll_rows = ldwc.Retrieve()
	
	ls_find_string = "scrap_handling_type = '" + as_scrap_handling_cust_order + "'"
	
	ll_found_row = ldwc.Find(ls_find_string, 1, ldwc.RowCount())
	
	If ll_found_row > 0 Then
		ldwc.ScrollToRow(ll_found_row)
		tab_skids.tabpage_scrap.dw_editor.Object.scrap_handling_type[1] = as_scrap_handling_cust_order
	End If
	
	//ll_inserted_row = ldwc.InsertRow(1)

	//If ll_inserted_row > 0 Then
		//SetNull(ll_null)
		//SetNull(ls_null)
		//
		//ldwc.SetItem(ll_inserted_row, "customer_id", ll_null)
		//ldwc.SetItem(ll_inserted_row, "customer_short_name", ls_null)
	//End If
End If
//Alex Gerlants. Scrap Credit. End
end subroutine

public function integer wf_scrap_credit (boolean ab_display_message, long al_scrap_skid_num, boolean ab_new_skid);//Alex Gerlants. Scrap Credit. Begin
/*
Function:	wf_scrap_credit
Return:		integer	<==	 1 if OK
									-1 if DB error
Arguments:	value	boolean	ab_display_message
				value	long		al_scrap_skid_num
				value	boolean	ab_new_skid
*/

Integer	li_rtn = 1
Boolean	lb_window_open
Long		ll_row
Int 		li_status,  li_answer

If ab_new_skid Then
	li_answer = 1
Else //Modify skid
	ll_row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
	
	If ll_row < 1 Then Return -1
	
	li_status = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "skid_scrap_status", Primary!, False)
	
	If li_status = 0 Then
		MessageBox("Error","Failed to modify this scrap skid because it has been shipped to customer already.", StopSign!)
		Return 0
	//Else
	//	ll_scrap_skid_num = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "scrap_skid_num", Primary!, FALSE)
	End If
	
	If ab_display_message Then //This comes from Clicked event for cb_esave on Scrap tab
		li_answer = MessageBox("Confirmation","Please confirm making scrap skid #" + String(al_scrap_skid_num) + " into scrap credit.", Question!, YesNo!)
	Else
		li_answer = 1
	End If
End If

If li_answer  =  1 Then
	update	scrap_skid  
	set		customer_id = 1054  
	where	scrap_skid.scrap_skid_num =  :al_scrap_skid_num  
	using	sqlca;
	
	IF sqlca.sqlcode = -1 THEN 
	  MessageBox("Database error", "Error in wf_scrap_credit for w_office_skid_entry while modifying table scrap_skid." + &
												"~n~r~n~rError:~n~r" + sqlca.sqlerrtext)
	  li_rtn = -1
	Else //OK
		//lb_window_open = f_other_window_open("Scrap & Reject Sheets")
		//If lb_window_open Then Close(w_prod_scrap)
	End If

	tab_skids.tabpage_scrap.dw_scrap_list.Retrieve(il_current_job_num)
	tab_skids.tabpage_scrap_credit.dw_scrap_credit.Retrieve(il_current_job_num)
Else
	Return 0
End If	

Return li_rtn
//Alex Gerlants. Scrap Credit. End

end function

public function boolean wf_check_scrap_skid_status ();//Alex Gerlants. 07/10/2019. Skid_Status_Change_Warning. Begin
/*
Function:	wf_check_scrap_skid_status
Returns:		boolean	True if OK to change skid status
							False if not OK to change skid status
*/

Long		ll_row, ll_scrap_skid_num, ll_scrap_skid_status_new, ll_scrap_skid_status_prev, ll_found_row
Integer	li_answer
String	ls_find_string, ls_yes_no
Boolean	lb_ok_2change_status = True

//tab_skids.tabpage_scrap.dw_editor.AcceptText()
//
//ll_row = tab_skids.tabpage_scrap.dw_editor.GetRow()
//ll_scrap_skid_num = tab_skids.tabpage_scrap.dw_editor.Object.scrap_skid_detail_scrap_skid_num[ll_row]
//ll_scrap_skid_status_new = tab_skids.tabpage_scrap.dw_editor.Object.skid_scrap_status[ll_row]
//
//ls_find_string = "sheet_skid_sheet_skid_num = " + String(ll_scrap_skid_num)
//ll_found_row = tab_skids.tabpage_sheet.dw_skid_list.Find(ls_find_string, 1, tab_skids.tabpage_sheet.dw_skid_list.RowCount())
//
//If ll_found_row > 0 Then
//	ll_scrap_skid_status_prev = tab_skids.tabpage_scrap.dw_scrap_list.Object.skid_scrap_status[ll_found_row]
//	
//	If ll_scrap_skid_status_prev = 0 And ll_scrap_skid_status_new <> 0 Then //Skid is Gone
	
		ll_row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
		ll_scrap_skid_num = tab_skids.tabpage_scrap.dw_scrap_list.Object.scrap_skid_num[ll_row]
	
		//Display warning
		OpenWithParm(w_skid_status_change_warning, ll_scrap_skid_num)
		ls_yes_no = Message.StringParm
		
		If ls_yes_no = "YES" Then
			lb_ok_2change_status = True
		Else
			lb_ok_2change_status = False
		End If
//	
//		////Display warning
//		//li_answer = MessageBox("Are you sure?", "Skid "  + String(ll_scrap_skid_num) + " is gone.~n~r" + &
//		//								"Are you sure you want to change its status?", &
//		//								Question!, YesNo!, 2)
//		//														
//		//If li_answer = 2 Then //No
//		//	lb_ok_2change_status = False
//		//End If
//	End If
//End If

Return lb_ok_2change_status
//Alex Gerlants. 07/10/2019. Skid_Status_Change_Warning. End
end function

public function boolean wf_check_sheet_skid_status ();//Alex Gerlants. 07/10/2019. Skid_Status_Change_Warning. Begin
/*
Function:	wf_check_sheet_skid_status
Returns:		boolean	True if OK to change skid status
							False if not OK to change skid status
*/

Long		ll_row, ll_skid_sheet_num, ll_skid_sheet_status_new, ll_skid_sheet_status_prev, ll_found_row
Integer	li_answer
String	ls_find_string, ls_yes_no
Boolean	lb_ok_2change_status = True

tab_skids.tabpage_sheet.dw_skid_editor.AcceptText()

ll_row = tab_skids.tabpage_sheet.dw_skid_editor.GetRow()

If ll_row <= 0 Then Return False

ll_skid_sheet_num = tab_skids.tabpage_sheet.dw_skid_editor.Object.sheet_skid_sheet_skid_num[ll_row]
ll_skid_sheet_status_new = tab_skids.tabpage_sheet.dw_skid_editor.Object.sheet_skid_skid_sheet_status[ll_row]

ls_find_string = "sheet_skid_sheet_skid_num = " + String(ll_skid_sheet_num)
ll_found_row = tab_skids.tabpage_sheet.dw_skid_list.Find(ls_find_string, 1, tab_skids.tabpage_sheet.dw_skid_list.RowCount())

If ll_found_row > 0 Then
	ll_skid_sheet_status_prev = tab_skids.tabpage_sheet.dw_skid_list.Object.sheet_skid_skid_sheet_status[ll_found_row]
	
	If ll_skid_sheet_status_prev = 0 And ll_skid_sheet_status_new <> 0 Then //Skid is Gone
	
		//Display warning
		OpenWithParm(w_skid_status_change_warning, ll_skid_sheet_num)
		ls_yes_no = Message.StringParm
		
		If ls_yes_no = "YES" Then
			lb_ok_2change_status = True
		Else
			lb_ok_2change_status = False
		End If
	
		////Display warning
		//li_answer = MessageBox("Are you sure?", "Skid "  + String(ll_skid_sheet_num) + " is gone.~n~r" + &
		//								"Are you sure you want to change its status?", &
		//								Question!, YesNo!, 2)
		//														
		//If li_answer = 2 Then //No
		//	lb_ok_2change_status = False
		//End If
	End If
End If

Return lb_ok_2change_status
//Alex Gerlants. 07/10/2019. Skid_Status_Change_Warning. End
end function

on w_office_skid_entry.create
int iCurrent
call super::create
if this.MenuName = "m_office_entry" then this.MenuID = create m_office_entry
this.cb_refresh_all=create cb_refresh_all
this.tab_skids=create tab_skids
this.dw_prod_order_detail=create dw_prod_order_detail
this.cb_close=create cb_close
this.st_title1=create st_title1
this.st_title#=create st_title#
this.dw_coil_status=create dw_coil_status
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_refresh_all
this.Control[iCurrent+2]=this.tab_skids
this.Control[iCurrent+3]=this.dw_prod_order_detail
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.st_title1
this.Control[iCurrent+6]=this.st_title#
this.Control[iCurrent+7]=this.dw_coil_status
end on

on w_office_skid_entry.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_refresh_all)
destroy(this.tab_skids)
destroy(this.dw_prod_order_detail)
destroy(this.cb_close)
destroy(this.st_title1)
destroy(this.st_title#)
destroy(this.dw_coil_status)
end on

event open;call super::open;Long	ll_row, ll_rows //Alex Gerlants. 06/15/2018. Arconic_Package_Num

Open(w_office_entry_open)

il_current_job_num = Message.DoubleParm
IF il_current_job_num < 1 THEN 
	Close(this)
	RETURN 0
END IF
st_title#.Text = String(il_current_job_num)

CONNECT USING SQLCA;
SELECT order_abc_num INTO :il_current_order
FROM ab_job
WHERE ab_job_num = :il_current_job_num
USING SQLCA;

CONNECT USING SQLCA;
SELECT order_item_num INTO :il_current_order_item
FROM ab_job
WHERE ab_job_num = :il_current_job_num
USING SQLCA;


dw_coil_status.Retrieve(il_current_job_num)
dw_prod_order_detail.Event pfc_Retrieve()

tab_skids.tabpage_sheet.dw_skid_list.Event pfc_Retrieve()
tab_skids.tabpage_sheet.dw_skid_list.SetFocus()
IF il_current_job_num > 0 THEN
	ir_theo_pcwt = wf_get_pc_theowt()
	tab_skids.tabpage_sheet.dw_skid_list.inv_filter.of_SetFilter("sheet_skid_ab_job_num = " + String(il_current_job_num))
	tab_skids.tabpage_sheet.dw_skid_list.inv_filter.of_Filter()
ELSE
	ir_theo_pcwt = 0
END IF
tab_skids.tabpage_sheet.dw_skid_editor.Event pfc_Retrieve()
tab_skids.tabpage_sheet.dw_skid_editor.Reset()

dw_coil_status.visible = FALSE

wf_get_partial_skid()

//handling scrap skids tab
tab_skids.tabpage_scrap.dw_scrap_list.of_SetLinkage(TRUE)
tab_skids.tabpage_scrap.dw_scrap_list.inv_Linkage.of_SetStyle(2)
tab_skids.tabpage_scrap.dw_scrap_list.inv_linkage.of_SetConfirmOnRowChange (True)
tab_skids.tabpage_scrap.dw_scrap_list.inv_linkage.of_setUpdateOnRowChange (TRUE)

tab_skids.tabpage_scrap.dw_scrap_item.of_SetLinkage( TRUE ) 
tab_skids.tabpage_scrap.dw_scrap_item.inv_Linkage.of_SetMaster(tab_skids.tabpage_scrap.dw_scrap_list)
IF NOT tab_skids.tabpage_scrap.dw_scrap_item.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to link tab_skids.tabpage_scrap.dw_scrap_list & tab_skids.tabpage_scrap.dw_scrap_item!" )
ELSE
	tab_skids.tabpage_scrap.dw_scrap_item.inv_Linkage.of_Register( "scrap_skid_num", "scrap_skid_detail_scrap_skid_num" ) 
	tab_skids.tabpage_scrap.dw_scrap_item.inv_Linkage.of_SetStyle( 2 ) 
END IF

tab_skids.tabpage_scrap.dw_scrap_list.inv_Linkage.of_SetTransObject(sqlca) 
tab_skids.tabpage_scrap.dw_scrap_list.inv_linkage.of_retrieve() 

tab_skids.tabpage_scrap.dw_scrap_list.Retrieve(il_current_job_num)
tab_skids.tabpage_scrap_credit.dw_scrap_credit.Retrieve(il_current_job_num)
//wf_display_total_info()

//Alex Gerlants. 06/15/2018. Arconic_Package_Num. Begin
f_get_use_package_num_4job(il_current_job_num, sqlca, ib_use_package_num)

ll_rows = tab_skids.tabpage_sheet.dw_skid_list.RowCount()

If ib_use_package_num Then
	For ll_row = 1 To ll_rows
		tab_skids.tabpage_sheet.dw_skid_list.Object.package_num_visible[ll_row] = 1 //Make package_num visible
		tab_skids.tabpage_sheet.dw_skid_list.SetItemStatus(ll_row, 0, Primary!, NotModified!)
	Next
Else
	For ll_row = 1 To ll_rows
		tab_skids.tabpage_sheet.dw_skid_list.Object.package_num_visible[ll_row] = 0 //Make package_num invisible
		tab_skids.tabpage_sheet.dw_skid_list.SetItemStatus(ll_row, 0, Primary!, NotModified!)
	Next
End If
//Alex Gerlants. 06/15/2018. Arconic_Package_Num. End


end event

event pfc_save;Int li_rc
Long ll_skid, ll_item, ll_row, ll_i

Long ll_snet, ll_stare, ll_spc, ll_theo, ll_job
Int li_sstatus 
DateTime ld_sdate

Long ll_inet, ll_icoil, ll_ipc, ll_itheo 
Int li_istatus
DateTime ld_idate
String ls_place

String	ls_coil_org_num, ls_coil_mid_num, ls_lot_num //Alex Gerlants. 03/14/2018
Long		ll_coil_abc_num  //Alex Gerlants. 05/07/2018

Integer	li_rtn //Alex Gerlants. 06/15/2018. Arconic_Package_Num
Long		ll_sheet_skid_num, ll_package_num, ll_row_skid, ll_row_item //Alex Gerlants. 06/15/2018. Arconic_Package_Num
		


IF wf_check_coil() < 0 THEN 
	MessageBox("Info", "Failed to save data.")
	RETURN -1
END IF

tab_skids.tabpage_sheet.dw_skid_editor.AcceptText()
ll_row = tab_skids.tabpage_sheet.dw_skid_editor.GetRow()
IF (ll_row < 1) OR IsNULL(ll_row) THEN RETURN -2
ll_skid = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num", Primary!, FALSE)
ll_item = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row, "production_sheet_item_prod_item_num", Primary!, FALSE)

ll_snet = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row, "sheet_skid_sheet_net_wt", Primary!, FALSE)
ll_stare = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row, "sheet_skid_sheet_tare_wt", Primary!, FALSE)
ll_spc = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row, "sheet_skid_skid_pieces", Primary!, FALSE)
li_sstatus = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row, "sheet_skid_skid_sheet_status", Primary!, FALSE)
ld_sdate = tab_skids.tabpage_sheet.dw_skid_editor.GetItemDateTime(ll_row, "sheet_skid_skid_date", Primary!, FALSE)
ll_theo = wf_get_skid_theowt()

ll_icoil = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row, "production_sheet_item_coil_abc_num", Primary!, FALSE)
ll_job = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row, "production_sheet_item_ab_job_num", Primary!, FALSE)
li_istatus = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row, "production_sheet_item_prod_item_status", Primary!, FALSE)
ll_ipc = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row, "production_sheet_item_prod_item_pieces", Primary!, FALSE)
ll_inet = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row, "production_sheet_item_prod_item_net_wt", Primary!, FALSE)
ll_itheo = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row, "production_sheet_item_prod_item_theoreti", Primary!, FALSE)
ld_idate = tab_skids.tabpage_sheet.dw_skid_editor.GetItemDateTime(ll_row, "production_sheet_item_prod_item_date", Primary!, FALSE)
ls_place = tab_skids.tabpage_sheet.dw_skid_editor.GetItemString(ll_row, "production_sheet_item_prod_item_placemen", Primary!, FALSE)

//Alex Gerlants. 03/14/2018. Begin
wf_coil_info() //First, update coil_org_num, coil_mid_num, and lot_num in dw_skid_editor

//Then, get coil_org_num, coil_mid_num, and lot_num from dw_skid_editor
ls_coil_org_num = tab_skids.tabpage_sheet.dw_skid_editor.Object.coil_org_num[ll_row]
ls_coil_mid_num = tab_skids.tabpage_sheet.dw_skid_editor.Object.coil_mid_num[ll_row]
ls_lot_num = tab_skids.tabpage_sheet.dw_skid_editor.Object.lot_num[ll_row]
//Alex Gerlants. 03/14/2018. End

IF wf_coil_sheet_wt(ll_icoil,ll_item,ll_inet) < 0 THEN 
	MessageBox("Info", "Failed to save data.")
	RETURN -1
END IF

CHOOSE CASE ii_action
	CASE 1 //new skid
		IF (li_sstatus <> 7) AND (ll_spc <> ll_ipc) THEN
			IF MessageBox("Question", "Skid pieces do not add up right, save it anyway?", Question!, YesNo!, 2) = 2 THEN RETURN -1	
		END IF
	CASE 2 //new item
		IF wf_check_skid_wt(ll_skid, ll_item) < 0 THEN RETURN -2
	CASE 3 //delete item
		IF wf_check_skid_wt(ll_skid, ll_item) < 0 THEN RETURN -3
	CASE 4 //modify
		If Not wf_check_sheet_skid_status() Then Return -4 //Alex Gerlants. 07/10/2019. Skid_Status_Change_Warning
		IF wf_check_skid_wt(ll_skid, ll_item) < 0 THEN RETURN -4
END CHOOSE

CONNECT USING SQLCA;
CHOOSE CASE ii_action
	CASE 0 	//nothing
	CASE 1 	//new skid
		INSERT INTO sheet_skid (sheet_skid_num, ab_job_num, sheet_net_wt , sheet_tare_wt, skid_date, skid_pieces , skid_sheet_status, sheet_theoretical_wt, ref_order_abc_num, ref_order_abc_item)
		VALUES (:ll_skid, :il_current_job_num, :ll_snet, :ll_stare,:ld_sdate,:ll_spc, :li_sstatus, :ll_theo, :il_current_order, :il_current_order_item)
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			Messagebox("DBError", "Insert Skid function: skid table" + "~n~r~n~r" + sqlca.sqlerrtext ) //Alex Gerlants. 06/15/2018. Arconic_Package_Num. Added ~n~r~n~r" + sqlca.sqlerrtext
			ROLLBACK USING SQLCA;
			RETURN -5
		END IF
		INSERT INTO production_sheet_item (prod_item_num, coil_abc_num , ab_job_num , prod_item_status, prod_item_net_wt, prod_item_date, prod_item_pieces , prod_item_theoretical_wt, prod_item_placement)
		VALUES (:ll_item, :ll_icoil,:il_current_job_num,:li_istatus,:ll_inet, SYSDATE,:ll_ipc, :ll_itheo, :ls_place)
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			Messagebox("DBError", "Insert Skid function: skid item table" + "~n~r~n~r" + sqlca.sqlerrtext ) //Alex Gerlants. 06/15/2018. Arconic_Package_Num. Added ~n~r~n~r" + sqlca.sqlerrtext
			ROLLBACK USING SQLCA;
			RETURN -5
		END IF
		
		INSERT INTO sheet_skid_detail (sheet_skid_num, prod_item_num )
		VALUES (:ll_skid, :ll_item)
		USING SQLCA;		
		IF SQLCA.SQLCode <> 0 then
			Messagebox("DBError", "Insert Skid function: skid detail table" + "~n~r~n~r" + sqlca.sqlerrtext ) //Alex Gerlants. 06/15/2018. Arconic_Package_Num. Added ~n~r~n~r" + sqlca.sqlerrtext
			ROLLBACK USING SQLCA;
			RETURN -5
		END IF
		
		//Alex Gerlants. 06/15/2018. Arconic_Package_Num. Begin
		li_rtn = f_insert_sheet_skid_package(il_current_job_num, ll_skid, sqlca)
		
		If li_rtn <> 0 Then //li_rtn = sqlca.sqlcode in f_insert_sheet_skid_package()
			rollback using sqlca;
			Return -5
		End If
		//Alex Gerlants. 06/15/2018. Arconic_Package_Num. End
	CASE 2	//item
		UPDATE sheet_skid
		SET sheet_net_wt = :ll_snet, ab_job_num = :il_current_job_num, sheet_tare_wt = :ll_stare, skid_date = :ld_sdate, skid_pieces = :ll_spc, skid_sheet_status = :li_sstatus, sheet_theoretical_wt = :ll_theo, ref_order_abc_num = :il_current_order, ref_order_abc_item=:il_current_order_item
		WHERE sheet_skid_num = :ll_skid
		USING SQLCA;
		IF SQLCA.SQLNRows = 0 THEN
			Messagebox("DBError", "add item function" + "~n~r~n~r" + sqlca.sqlerrtext ) //Alex Gerlants. 06/15/2018. Arconic_Package_Num. Added ~n~r~n~r" + sqlca.sqlerrtext
			ROLLBACK USING SQLCA;
			RETURN -4
		END IF			
		INSERT INTO production_sheet_item (prod_item_num, coil_abc_num , ab_job_num , prod_item_status, prod_item_net_wt, prod_item_date, prod_item_pieces , prod_item_theoretical_wt, prod_item_placement)
		VALUES (:ll_item, :ll_icoil,:il_current_job_num,:li_istatus,:ll_inet,SYSDATE,:ll_ipc, :ll_itheo, :ls_place)
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			Messagebox("DBError", "Insert Item function: skid item table" + "~n~r~n~r" + sqlca.sqlerrtext ) //Alex Gerlants. 06/15/2018. Arconic_Package_Num. Added ~n~r~n~r" + sqlca.sqlerrtext
			ROLLBACK USING SQLCA;
			RETURN -5
		END IF
		INSERT INTO sheet_skid_detail (sheet_skid_num, prod_item_num )
		VALUES (:ll_skid, :ll_item)
		USING SQLCA;		
		IF SQLCA.SQLCode <> 0 then
			Messagebox("DBError", "Insert Item function: skid detail table" + "~n~r~n~r" + sqlca.sqlerrtext ) //Alex Gerlants. 06/15/2018. Arconic_Package_Num. Added ~n~r~n~r" + sqlca.sqlerrtext
			ROLLBACK USING SQLCA;
			RETURN -5
		END IF
	CASE 3	//delete item
		DELETE FROM sheet_skid_detail
		WHERE sheet_skid_num = :ll_skid AND prod_item_num = :ll_item
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			Messagebox("DBError", "Delete item function: skid detail table" + "~n~r~n~r" + sqlca.sqlerrtext ) //Alex Gerlants. 06/15/2018. Arconic_Package_Num. Added ~n~r~n~r" + sqlca.sqlerrtext
			ROLLBACK USING SQLCA;
			RETURN -5
		END IF
		DELETE FROM production_sheet_item
		WHERE prod_item_num = :ll_item
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			Messagebox("DBError", "Delete item function: skid item table" + "~n~r~n~r" + sqlca.sqlerrtext ) //Alex Gerlants. 06/15/2018. Arconic_Package_Num. Added ~n~r~n~r" + sqlca.sqlerrtext
			ROLLBACK USING SQLCA;
			RETURN -5
		END IF
	CASE 4	//modify
		UPDATE sheet_skid
		SET sheet_net_wt = :ll_snet, sheet_tare_wt = :ll_stare, skid_date = :ld_sdate, skid_pieces = :ll_spc, skid_sheet_status = :li_sstatus, sheet_theoretical_wt = :ll_theo
		WHERE sheet_skid_num = :ll_skid
		USING SQLCA;
		IF SQLCA.SQLNRows = 0 THEN
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Modify function" )
			RETURN -5
		END IF			
		UPDATE production_sheet_item
		SET coil_abc_num = :ll_icoil, ab_job_num = :il_current_job_num, prod_item_status = :li_istatus, prod_item_net_wt = :ll_inet, prod_item_date = SYSDATE, prod_item_pieces = :ll_ipc, prod_item_theoretical_wt = :ll_itheo, prod_item_placement = :ls_place		WHERE prod_item_num = :ll_item
		USING SQLCA;
		IF SQLCA.SQLNRows = 0 THEN
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Modify function" )
			RETURN -5
		END IF
	CASE 5	//delete skid
		DELETE FROM sheet_skid_detail
		WHERE sheet_skid_num = :ll_skid AND prod_item_num = :ll_item
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			Messagebox("DBError", "Delete function: skid detail table" + "~n~r~n~r" + sqlca.sqlerrtext ) //Alex Gerlants. 06/15/2018. Arconic_Package_Num. Added ~n~r~n~r" + sqlca.sqlerrtext
			ROLLBACK USING SQLCA;
			RETURN -5
		END IF
 		DELETE FROM production_sheet_item
		WHERE prod_item_num = :ll_item
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			Messagebox("DBError", "Delete function: skid item table" + "~n~r~n~r" + sqlca.sqlerrtext ) //Alex Gerlants. 06/15/2018. Arconic_Package_Num. Added ~n~r~n~r" + sqlca.sqlerrtext
			ROLLBACK USING SQLCA;
			RETURN -5
		END IF
		DELETE FROM sheet_skid
		WHERE sheet_skid_num = :ll_skid
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			Messagebox("DBError", "Delete function: skid table" + "~n~r~n~r" + sqlca.sqlerrtext ) //Alex Gerlants. 06/15/2018. Arconic_Package_Num. Added ~n~r~n~r" + sqlca.sqlerrtext
			ROLLBACK USING SQLCA;
			RETURN -5
		END IF
END CHOOSE

dw_coil_status.AcceptText()
li_rc = dw_coil_status.Update()
IF li_rc = 1 THEN
	//COMMIT USING SQLCA;
ELSE
	ROLLBACK USING SQLCA;
	Messagebox("DBError", "dw_coil_status" )
	RETURN -6
END IF

IF li_rc = 1 THEN
	COMMIT USING SQLCA;
ELSE
	ROLLBACK USING SQLCA;
	Messagebox("DBError", "dw_skid_detail during adding" )
	RETURN -7
END IF

MessageBox("Info", "Data had been saved.")

CHOOSE CASE ii_action
	CASE 0 	//nothing
	CASE 1 	//new skid
		wf_coil_info() //Alex Gerlants. 03/14/2018
		tab_skids.tabpage_sheet.dw_skid_editor.RowsCopy(tab_skids.tabpage_sheet.dw_skid_editor.GetRow(), tab_skids.tabpage_sheet.dw_skid_editor.GetRow(), Primary!, tab_skids.tabpage_sheet.dw_skid_list, (tab_skids.tabpage_sheet.dw_skid_list.RowCount() + 1), Primary!)		
		
		//Alex Gerlants. 06/15/2018. Arconic_Package_Num. Begin
		If ib_use_package_num Then
			ll_row_skid = tab_skids.tabpage_sheet.dw_skid_list.RowCount()
			ll_sheet_skid_num = tab_skids.tabpage_sheet.dw_skid_list.Object.sheet_skid_sheet_skid_num[ll_row_skid] //Get sheet_skid_num from the last row
			ll_package_num = wf_get_package_num_4skid(ll_sheet_skid_num, sqlca)
			tab_skids.tabpage_sheet.dw_skid_list.Object.package_num[ll_row_skid] = ll_package_num
			
			tab_skids.tabpage_sheet.dw_skid_list.Object.package_num_visible[ll_row_skid] = 1 //Make package_num visible
			tab_skids.tabpage_sheet.dw_skid_list.SetItemStatus(ll_row_skid, 0, Primary!, NotModified!)
		End If
		//Alex Gerlants. 06/15/2018. Arconic_Package_Num. End
	CASE 2	//item
		ll_row = tab_skids.tabpage_sheet.dw_skid_list.GetRow()
		
		ll_row_skid = ll_row //Alex Gerlants. 06/15/2018. Arconic_Package_Num.
		
		IF ll_row = tab_skids.tabpage_sheet.dw_skid_list.RowCount() THEN
			ll_row = 0
		ELSE
			ll_row = ll_row + 1
		END IF

		ll_row = tab_skids.tabpage_sheet.dw_skid_list.InsertRow(ll_row)
		
		ll_row_item = ll_row //Alex Gerlants. 06/15/2018. Arconic_Package_Num
		
		tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_row, "sheet_skid_sheet_skid_num", ll_skid)
		tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_row, "production_sheet_item_prod_item_num", ll_item)
		tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_row, "sheet_skid_sheet_net_wt", ll_snet)
		tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_row, "sheet_skid_sheet_tare_wt",ll_stare)
		tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_row, "sheet_skid_skid_pieces",ll_spc)
		tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_row, "sheet_skid_skid_sheet_status", li_sstatus)
		tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_row, "sheet_skid_skid_date",ld_sdate) 
		tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_row, "production_sheet_item_coil_abc_num", ll_icoil)
		tab_skids.tabpage_sheet.dw_skid_list.setItem(ll_row, "production_sheet_item_ab_job_num", ll_job)
		tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_row, "production_sheet_item_prod_item_status", li_istatus)
		tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_row, "production_sheet_item_prod_item_pieces", ll_ipc)
		tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_row, "production_sheet_item_prod_item_net_wt", ll_inet)
		tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_row, "production_sheet_item_prod_item_theoreti", ll_itheo)
		tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_row, "production_sheet_item_prod_item_date", ld_idate)
		tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_row, "production_sheet_item_prod_item_placemen",ls_place)
		
		//Alex Gerlants. 03/14/2018. Begin
		tab_skids.tabpage_sheet.dw_skid_list.Object.coil_org_num[ll_row] = ls_coil_org_num
		tab_skids.tabpage_sheet.dw_skid_list.Object.coil_mid_num[ll_row] = ls_coil_mid_num
		tab_skids.tabpage_sheet.dw_skid_list.Object.lot_num[ll_row] = ls_lot_num
		//Alex Gerlants. 03/14/2018. End
		
		ll_row = tab_skids.tabpage_sheet.dw_skid_list.RowCount()
		FOR ll_i = 1 TO ll_row
			IF ll_skid = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_i, "sheet_skid_sheet_skid_num", Primary!, FALSE) THEN		
				tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "sheet_skid_sheet_net_wt", ll_snet)
				tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "sheet_skid_sheet_tare_wt",ll_stare)
				tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "sheet_skid_skid_pieces",ll_spc)
				tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "sheet_skid_skid_sheet_status", li_sstatus)
				tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "sheet_skid_skid_date",ld_sdate) 
			END IF
		NEXT
		
		//Alex Gerlants. 06/15/2018. Arconic_Package_Num. Begin
		If ib_use_package_num Then
			//ll_row_package = tab_skids.tabpage_sheet.dw_skid_list.RowCount()
			ll_sheet_skid_num = tab_skids.tabpage_sheet.dw_skid_list.Object.sheet_skid_sheet_skid_num[ll_row_skid] //Get sheet_skid_num from the last row
			ll_package_num = wf_get_package_num_4skid(ll_sheet_skid_num, sqlca)
			tab_skids.tabpage_sheet.dw_skid_list.Object.package_num[ll_row_item] = ll_package_num
			
			tab_skids.tabpage_sheet.dw_skid_list.Object.package_num_visible[ll_row_item] = 1 //Make package_num visible
			tab_skids.tabpage_sheet.dw_skid_list.SetItemStatus(ll_row_item, 0, Primary!, NotModified!)
		End If
		//Alex Gerlants. 06/15/2018. Arconic_Package_Num. End
	CASE 3	//delete item
		IF tab_skids.tabpage_sheet.dw_skid_list.GetRow() > 0 THEN
			tab_skids.tabpage_sheet.dw_skid_list.DeleteRow(tab_skids.tabpage_sheet.dw_skid_list.GetRow() )
		END IF
	CASE 4	//modify
		ll_row = tab_skids.tabpage_sheet.dw_skid_list.RowCount()
		FOR ll_i = 1 TO ll_row
			IF ll_skid = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_i, "sheet_skid_sheet_skid_num", Primary!, FALSE) THEN		
				tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "sheet_skid_sheet_net_wt", ll_snet)
				tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "sheet_skid_sheet_tare_wt",ll_stare)
				tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "sheet_skid_skid_pieces",ll_spc)
				tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "sheet_skid_skid_sheet_status", li_sstatus)
				tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "sheet_skid_skid_date",ld_sdate)
				
				wf_update_skid_list() //Alex Gerlants. 06/07/2018
				
				IF ll_item = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_i, "production_sheet_item_prod_item_num", Primary!, FALSE) THEN
					tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "production_sheet_item_coil_abc_num", ll_icoil)
					tab_skids.tabpage_sheet.dw_skid_list.setItem(ll_row, "production_sheet_item_ab_job_num", ll_job)
					tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "production_sheet_item_prod_item_status", li_istatus)
					tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "production_sheet_item_prod_item_pieces", ll_ipc)
					tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "production_sheet_item_prod_item_net_wt", ll_inet)
					tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "production_sheet_item_prod_item_theoreti", ll_itheo)
					tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "production_sheet_item_prod_item_date", ld_idate)
					tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "production_sheet_item_prod_item_placemen",ls_place)
					
					//wf_update_skid_list() //Alex Gerlants. 06/07/2018

				END IF
			END IF
		NEXT
	CASE 5	//delete skid
		IF tab_skids.tabpage_sheet.dw_skid_list.GetRow() > 0 THEN
			tab_skids.tabpage_sheet.dw_skid_list.DeleteRow(tab_skids.tabpage_sheet.dw_skid_list.GetRow() )
		END IF
END CHOOSE
tab_skids.tabpage_sheet.dw_skid_list.ResetUpdate()
tab_skids.tabpage_sheet.dw_skid_list.Event ue_goto_row()

tab_skids.tabpage_sheet.dw_skid_editor.ResetUpdate()
tab_skids.tabpage_sheet.dw_skid_editor.Reset()
wf_set_action(0)

RETURN 1
end event

event pfc_print;OpenwithParm(w_report_skid_entry, il_current_job_num)
RETURN 1
end event

event close;call super::close;f_display_app()
end event

type cb_refresh_all from commandbutton within w_office_skid_entry
integer x = 4085
integer y = 1731
integer width = 391
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Refresh All Tabs"
end type

event clicked;//Alex Gerlants. Scrap Credit. Begin
tab_skids.tabpage_sheet.dw_skid_list.Retrieve(il_current_job_num)
tab_skids.tabpage_scrap.dw_scrap_list.Retrieve(il_current_job_num)
tab_skids.tabpage_scrap_credit.dw_scrap_credit.Retrieve(il_current_job_num)
//Alex Gerlants. Scrap Credit. End
end event

type tab_skids from tab within w_office_skid_entry
event create ( )
event destroy ( )
integer x = 15
integer y = 192
integer width = 4462
integer height = 1504
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_sheet tabpage_sheet
tabpage_scrap tabpage_scrap
tabpage_scrap_credit tabpage_scrap_credit
end type

on tab_skids.create
this.tabpage_sheet=create tabpage_sheet
this.tabpage_scrap=create tabpage_scrap
this.tabpage_scrap_credit=create tabpage_scrap_credit
this.Control[]={this.tabpage_sheet,&
this.tabpage_scrap,&
this.tabpage_scrap_credit}
end on

on tab_skids.destroy
destroy(this.tabpage_sheet)
destroy(this.tabpage_scrap)
destroy(this.tabpage_scrap_credit)
end on

type tabpage_sheet from userobject within tab_skids
event create ( )
event destroy ( )
integer x = 15
integer y = 90
integer width = 4432
integer height = 1402
long backcolor = 79741120
string text = "Sheet Skids"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_converttoscrap cb_converttoscrap
cb_refresh cb_refresh
cb_modify cb_modify
cb_delete cb_delete
cb_insert cb_insert
cb_print cb_print
cb_new cb_new
cb_cancel cb_cancel
cb_save cb_save
dw_skid_editor dw_skid_editor
dw_skid_list dw_skid_list
gb_1 gb_1
end type

on tabpage_sheet.create
this.cb_converttoscrap=create cb_converttoscrap
this.cb_refresh=create cb_refresh
this.cb_modify=create cb_modify
this.cb_delete=create cb_delete
this.cb_insert=create cb_insert
this.cb_print=create cb_print
this.cb_new=create cb_new
this.cb_cancel=create cb_cancel
this.cb_save=create cb_save
this.dw_skid_editor=create dw_skid_editor
this.dw_skid_list=create dw_skid_list
this.gb_1=create gb_1
this.Control[]={this.cb_converttoscrap,&
this.cb_refresh,&
this.cb_modify,&
this.cb_delete,&
this.cb_insert,&
this.cb_print,&
this.cb_new,&
this.cb_cancel,&
this.cb_save,&
this.dw_skid_editor,&
this.dw_skid_list,&
this.gb_1}
end on

on tabpage_sheet.destroy
destroy(this.cb_converttoscrap)
destroy(this.cb_refresh)
destroy(this.cb_modify)
destroy(this.cb_delete)
destroy(this.cb_insert)
destroy(this.cb_print)
destroy(this.cb_new)
destroy(this.cb_cancel)
destroy(this.cb_save)
destroy(this.dw_skid_editor)
destroy(this.dw_skid_list)
destroy(this.gb_1)
end on

type cb_converttoscrap from u_cb within tabpage_sheet
integer x = 2008
integer y = 1251
integer width = 402
integer height = 80
integer taborder = 120
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Convert to &Scrap"
end type

event clicked;call super::clicked;Long ll_row, ll_skid_num, ll_packing_list
Int li_status, li_rc, li_return

ll_row = tab_skids.tabpage_sheet.dw_skid_list.GetRow()
IF ll_row < 1 THEN Return 0
li_status = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_row, "sheet_skid_skid_sheet_status", Primary!, FALSE)
IF li_status = 0 THEN
	MessageBox("Error","Failed to convert. This skid has been shipped to customer already.", StopSign!)
	RETURN
END IF

ll_skid_num = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num", Primary!, FALSE)
select count(*) into :li_rc from sheet_packing_item
where sheet_skid_num = :ll_skid_num
using SQLCA;
if li_rc > 0 then
	select packing_list into :ll_packing_list from sheet_packing_item
	where sheet_skid_num = :ll_skid_num
	using SQLCA;
	MessageBox("Error","Failed to convert. This skid has been loaded into BOL#" + String(ll_packing_list), StopSign!)
	return 0
end if

//Alex_Skid_Convert_2Scrap_Message. Begin
//Copied from the the same check in Clicked event for cb_modify
//Modified by Victor Huang in 08/05
//Check if the skid has been assigned to a new job. If "yes", force user to remove the skid from the new job.
Long ll_skid, ll_orig_ab_job, ll_current_job_num
ll_skid = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num", Primary!, FALSE)
ll_current_job_num = il_current_job_num

SetNull(ll_orig_ab_job)
select ab_job_num into :ll_orig_ab_job
from process_partial_skid
where sheet_skid_num = :ll_skid
using SQLCA;

IF not isnull(ll_orig_ab_job) THEN 
	IF (ll_orig_ab_job <> ll_current_job_num) THEN
		MessageBox("Warning","This skid has been assigned to a new job#" + String(ll_orig_ab_job) +". Please remove it from the new job before any modification!", StopSign!)
		RETURN
	END IF	
END IF
//Alex_Skid_Convert_2Scrap_Message. End

li_rc = MessageBox("Confirmation","Please confirm converting skid#" + String(ll_skid_num) +" to scrap.", Question!, YesNo!)
if li_rc = 1 then
	setpointer(hourglass!)
	transaction dboconnect
	dboconnect = create transaction
	dboconnect.DBMS = ProfileString(gs_ini_file,"Database","DBMS","")
	dboconnect.Servername = ProfileString(gs_ini_file,"Database","ServerName","")
	dboconnect.LogID = gs_LogID
	dboconnect.LogPass = gs_LogPass
	connect using dboconnect;
	if dboconnect.SQLCode<0 then 
		MessageBox ("Connection Failed!!!!",dboconnect.sqlerrtext,exclamation!)
		return -1
	end if
	
	DECLARE p_convert_to_scrap procedure for f_convert_to_scrap (:ll_skid_num) using dboconnect;
	execute p_convert_to_scrap;
	if dboconnect.SQLCode < 0 then 
		MessageBox ("Stored Procedure Failed!!!",dboconnect.sqlerrtext,exclamation!)
		disconnect using dboconnect;
		destroy dboconnect;
		return 0
	end if
	fetch p_convert_to_scrap INTO :li_return; 
	close p_convert_to_scrap;
	
	disconnect using dboconnect;
	destroy dboconnect;
	
	choose case li_return
	case 1
		Messagebox("Convert","Convert skid successfully. Please click OK then wait while this window is refreshing..." )		
		tab_skids.tabpage_sheet.cb_refresh.event clicked()
		tab_skids.tabpage_scrap.dw_scrap_list.Retrieve(il_current_job_num)
	case else
		MessageBox("Convert", "Convert skid failed.", StopSign!)
   end choose
	
else
	return 0
	
end if


end event

type cb_refresh from u_cb within tabpage_sheet
integer x = 2450
integer y = 1251
integer width = 402
integer height = 80
integer taborder = 110
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Refresh"
end type

event clicked;tab_skids.tabpage_sheet.dw_skid_list.Event pfc_Retrieve()
tab_skids.tabpage_sheet.dw_skid_list.SetFocus()
IF il_current_job_num > 0 THEN
	tab_skids.tabpage_sheet.dw_skid_list.inv_filter.of_SetFilter("sheet_skid_ab_job_num = " + String(il_current_job_num))
	tab_skids.tabpage_sheet.dw_skid_list.inv_filter.of_Filter()
END IF
tab_skids.tabpage_sheet.dw_skid_list.Event ue_goto_row()

end event

type cb_modify from u_cb within tabpage_sheet
integer x = 1562
integer y = 1251
integer width = 402
integer height = 80
integer taborder = 100
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Modify"
end type

event clicked;Long ll_row, ll_item
Int li_status

ll_row = tab_skids.tabpage_sheet.dw_skid_list.GetRow()
IF ll_row < 1 THEN Return

il_modified_row = ll_row //Alex Gerlants. 05/07/2018

/*
li_status = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_row, "sheet_skid_skid_sheet_status", Primary!, FALSE)
IF li_status = 0 THEN
	MessageBox("Error","Failed to modify item to this skid because it has been shipped to customer already.", StopSign!)
	RETURN
END IF
*/ 
//by james Ni - 05/18/2015

IF tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_row, "production_sheet_item_ab_job_num", Primary!, FALSE) <> il_current_job_num THEN 
	MessageBox("Error","Failed to modify item to this skid because it was created by other job.", StopSign!)
	RETURN
END IF

//Modified by Victor Huang in 08/05
//Check if the skid has been assigned to a new job. If "yes", force user to remove the skid from the new job.
Long ll_skid, ll_orig_ab_job
ll_skid = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num", Primary!, FALSE)

SetNull(ll_orig_ab_job)
select ab_job_num into :ll_orig_ab_job
from process_partial_skid
where sheet_skid_num = :ll_skid
using SQLCA;

IF not isnull(ll_orig_ab_job) THEN 
	IF (ll_orig_ab_job <> il_current_job_num) THEN
		MessageBox("Warning","This skid has been assigned to a new job#" + String(ll_orig_ab_job) +". Please remove it from the new job before any modification!", StopSign!)
		RETURN
	END IF	
END IF
//End

il_cur_skid = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num", Primary!, FALSE)

tab_skids.tabpage_sheet.dw_skid_list.RowsCopy(tab_skids.tabpage_sheet.dw_skid_list.GetRow(), tab_skids.tabpage_sheet.dw_skid_list.GetRow(), Primary!, tab_skids.tabpage_sheet.dw_skid_editor, 1, Primary!)

wf_set_action(4)
end event

type cb_delete from u_cb within tabpage_sheet
integer x = 1119
integer y = 1251
integer width = 402
integer height = 80
integer taborder = 90
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Delete"
end type

event clicked;tab_skids.tabpage_sheet.dw_skid_editor.Event ue_del_row()
RETURN 1
end event

type cb_insert from u_cb within tabpage_sheet
integer x = 677
integer y = 1251
integer width = 402
integer height = 80
integer taborder = 70
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Insert Item"
end type

event clicked;tab_skids.tabpage_sheet.dw_skid_editor.Event ue_insertitem()
end event

type cb_print from u_cb within tabpage_sheet
integer x = 2893
integer y = 1251
integer width = 402
integer height = 80
integer taborder = 80
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;window lw_parent

lw_parent = tab_skids.GetParent()
lw_parent.dynamic Event pfc_print()
end event

type cb_new from u_cb within tabpage_sheet
integer x = 234
integer y = 1251
integer width = 402
integer height = 80
integer taborder = 60
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&New Skid"
end type

event clicked;tab_skids.tabpage_sheet.dw_skid_editor.Event pfc_addrow()


end event

type cb_cancel from u_cb within tabpage_sheet
integer x = 3917
integer y = 1251
integer width = 289
integer height = 77
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Cancel"
end type

event clicked;tab_skids.tabpage_sheet.dw_skid_editor.ResetUpdate()
tab_skids.tabpage_sheet.dw_skid_editor.Reset()
wf_set_action(0)
end event

type cb_save from u_cb within tabpage_sheet
integer x = 3595
integer y = 1251
integer width = 289
integer height = 77
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Save"
end type

event clicked;window lw_parent

lw_parent = tab_skids.GetParent()
lw_parent.dynamic Event pfc_save()

end event

type dw_skid_editor from u_dw within tabpage_sheet
event ue_insertitem ( )
event ue_del_row ( )
integer x = 37
integer y = 931
integer width = 4370
integer height = 243
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_office_entry_skid_list_input"
boolean hscrollbar = true
boolean vscrollbar = false
boolean livescroll = false
end type

event ue_insertitem();Long ll_row, ll_item
Int li_status

ll_row = tab_skids.tabpage_sheet.dw_skid_list.GetRow()
IF ll_row < 1 THEN Return
li_status = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_row, "sheet_skid_skid_sheet_status", Primary!, FALSE)
IF li_status = 0 THEN
	MessageBox("Error","Failed to add item to this skid because it has been shipped to customer already!", StopSign!)
	RETURN
END IF

ib_partial = FALSE
IF tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_row, "production_sheet_item_ab_job_num", Primary!, FALSE) <> il_current_job_num THEN ib_partial = TRUE

tab_skids.tabpage_sheet.dw_skid_list.RowsCopy(tab_skids.tabpage_sheet.dw_skid_list.GetRow(), tab_skids.tabpage_sheet.dw_skid_list.GetRow(), Primary!, this, 1, Primary!)
ll_row = this.GetRow()
il_cur_skid = this.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num", Primary!, FALSE)
IF ib_partial THEN
	this.SetItem(ll_row, "sheet_skid_skid_date", Today())
	this.SetItem(ll_row, "production_sheet_item_ab_job_num", il_current_job_num)
	this.SetItem(ll_row, "sheet_skid_ab_job_num",  il_current_job_num)
END IF
ll_item = f_get_next_value("prod_item_num_seq")
this.SetItem(ll_row, "sheet_skid_detail_prod_item_num", ll_item)
this.SetItem(ll_row, "production_sheet_item_prod_item_num", ll_item)

wf_set_action(2)
end event

event ue_del_row();Long ll_row, ll_item, ll_i, ll_numitem, ll_skid
Int li_status

ll_row = tab_skids.tabpage_sheet.dw_skid_list.GetRow()
IF ll_row < 1 THEN Return
li_status = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_row, "sheet_skid_skid_sheet_status", Primary!, FALSE)
IF li_status = 0 THEN
	MessageBox("Error","Failed to delete item to this skid because it has been shipped to customer already.", StopSign!)
	RETURN
END IF

IF tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_row, "production_sheet_item_ab_job_num", Primary!, FALSE) <> il_current_job_num THEN 
	MessageBox("Error","Failed to delete item to this skid because it was created by other job.", StopSign!)
	RETURN
END IF
ll_skid =  tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num", Primary!, FALSE)
IF ll_row > 1 THEN
	il_cur_skid = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber((ll_row - 1), "sheet_skid_sheet_skid_num", Primary!, FALSE)
ELSE
	il_cur_skid = 0
END IF

tab_skids.tabpage_sheet.dw_skid_list.RowsCopy(tab_skids.tabpage_sheet.dw_skid_list.GetRow(), tab_skids.tabpage_sheet.dw_skid_list.GetRow(), Primary!, dw_skid_editor, 1, Primary!)

IF MessageBox("Warning","About to delete the item in editor box, are you sure?", Question!, OKCancel!, 2) = 1 THEN
	ll_numitem = 0
	ll_row = tab_skids.tabpage_sheet.dw_skid_list.RowCount()
	FOR ll_i = 1 TO ll_row
		IF  tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_i, "sheet_skid_sheet_skid_num", Primary!, FALSE) = ll_skid THEN ll_numitem = ll_numitem + 1
	NEXT
	IF ll_numitem > 1 THEN
		wf_set_action(3)
	ELSE
		wf_set_action(5)
	END IF
	cb_save.Event Clicked()
ELSE
	cb_cancel.Event Clicked()
END IF

end event

event constructor;of_SetBase(TRUE)
of_SettransObject(SQLCA)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
of_SetFilter(TRUE)



end event

event itemchanged;call super::itemchanged;String ls_ColName
Long ll_row, ll_pc, ll_totalpc, ll_totalwt, ll_skid, ll_netwt, ll_item

ls_ColName = this.GetColumnName()
IF ls_ColName = "production_sheet_item_prod_item_pieces" THEN
	this.AcceptText()
	ll_row = this.GetRow()
	ll_skid = this.GetItemNumber(ll_row,"sheet_skid_sheet_skid_num", Primary!, FALSE)
	ll_item = this.GetItemNumber(ll_row, "sheet_skid_detail_prod_item_num", Primary!, FALSE)
	ll_pc = this.GetItemNumber(ll_row,"production_sheet_item_prod_item_pieces", Primary!, FALSE)
	ll_totalpc = this.GetItemNumber(ll_row,"sheet_skid_skid_pieces", Primary!, FALSE)
	ll_totalwt = this.GetItemNumber(ll_row,"sheet_skid_sheet_net_wt", Primary!, FALSE)
	this.SetItem(ll_row,"production_sheet_item_prod_item_theoreti", Long(ir_theo_pcwt * ll_pc + 0.5) )
	IF ll_totalpc > 0 THEN
		ll_netwt = wf_item_netwts(ll_skid, ll_item)
		IF ll_netwt = 0 THEN
			this.setItem(ll_row, "production_sheet_item_prod_item_net_wt", Ceiling(ll_totalwt * (ll_pc / ll_totalpc)))
		ELSE
			this.setItem(ll_row, "production_sheet_item_prod_item_net_wt", (ll_totalwt - ll_netwt))
		END IF			
	END IF
END IF
IF ls_ColName = "sheet_skid_sheet_net_wt" THEN
	this.AcceptText()
	ll_row = this.GetRow()
	ll_skid = this.GetItemNumber(ll_row,"sheet_skid_sheet_skid_num", Primary!, FALSE)
	ll_item = this.GetItemNumber(ll_row, "sheet_skid_detail_prod_item_num", Primary!, FALSE)
	ll_pc = this.GetItemNumber(ll_row,"production_sheet_item_prod_item_pieces", Primary!, FALSE)
	ll_totalpc = this.GetItemNumber(ll_row,"sheet_skid_skid_pieces", Primary!, FALSE)
	ll_totalwt = this.GetItemNumber(ll_row,"sheet_skid_sheet_net_wt", Primary!, FALSE)
	this.SetItem(ll_row,"production_sheet_item_prod_item_theoreti", Long(ir_theo_pcwt * ll_pc + 0.5) )
	IF ll_totalpc > 0 THEN
		ll_netwt = wf_item_netwts(ll_skid, ll_item)
		IF ll_netwt = 0 THEN
			this.setItem(ll_row, "production_sheet_item_prod_item_net_wt", Ceiling(ll_totalwt * (ll_pc / ll_totalpc)))
		ELSE
			this.setItem(ll_row, "production_sheet_item_prod_item_net_wt", (ll_totalwt - ll_netwt))
		END IF			
	END IF
END IF

end event

event losefocus;this.ResetUpdate()
end event

event rbuttondown;//Override
RETURN 0
end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

event rbuttonup;//Override
RETURN 0
end event

event pfc_addrow;call super::pfc_addrow;Long ll_row, ll_skid, ll_item, ll_l, ll_job
Int li_i
Long ll_lrow

ll_row = this.GetRow()
IF ll_row < 1 THEN RETURN 0
ib_partial = FALSE

ll_skid = f_get_next_value("sheet_skid_num_seq")
il_cur_skid = ll_skid
this.SetItem(ll_row, "sheet_skid_sheet_skid_num", ll_skid)
this.SetItem(ll_row, "sheet_skid_detail_sheet_skid_num", ll_skid)
ll_item = f_get_next_value("prod_item_num_seq")
this.SetItem(ll_row, "sheet_skid_detail_prod_item_num", ll_item)
this.SetItem(ll_row, "production_sheet_item_prod_item_num", ll_item)
this.SetItem(ll_row, "sheet_skid_ab_job_num",  il_current_job_num)
this.SetItem(ll_row, "production_sheet_item_ab_job_num",il_current_job_num)
this.SetItem(ll_row, "sheet_skid_skid_date",Today())
this.SetItem(ll_row, "production_sheet_item_prod_item_date", Today())		
this.SetItem(ll_row, "sheet_skid_skid_sheet_status", 5)  //new

ll_lrow = tab_skids.tabpage_sheet.dw_skid_list.GetRow()
IF ll_lrow > 0 THEN
	li_i = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_lrow, "sheet_skid_skid_pieces", Primary!, FALSE)
	this.SetItem(ll_row, "sheet_skid_skid_pieces", li_i)

	//production sheet item
	ll_l = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_lrow, "production_sheet_item_coil_abc_num", Primary!, FALSE)
	this.SetItem(ll_row, "production_sheet_item_coil_abc_num", ll_l)
	ll_l = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_lrow, "production_sheet_item_ab_job_num", Primary!, FALSE)
	this.SetItem(ll_row, "production_sheet_item_ab_job_num", ll_l)
	//li_i = this.GetItemNumber((ll_row -1), "production_sheet_item_prod_item_status", Primary!, FALSE)
	this.SetItem(ll_row, "production_sheet_item_prod_item_status", 2 ) //new
	ll_l = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_lrow, "production_sheet_item_prod_item_theoreti", Primary!, FALSE)
	this.SetItem(ll_row, "production_sheet_item_prod_item_theoreti", ll_l)
	ll_l = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_lrow, "production_sheet_item_prod_item_pieces", Primary!, FALSE)
	this.SetItem(ll_row, "production_sheet_item_prod_item_pieces", ll_l)
END IF

wf_set_action(1)

RETURN ll_skid

end event

event pfc_retrieve;call super::pfc_retrieve;DataWindowChild ldddw_cni
IF this.GetChild("production_sheet_item_coil_abc_num", ldddw_cni) = -1 THEN 
	Return -1
ELSE
	this.Event pfc_PopulateDDDW("production_sheet_item_coil_abc_num", ldddw_cni)
END IF

Return this.Retrieve(il_current_job_num)
end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

end event

event pfc_populatedddw;call super::pfc_populatedddw;IF adwc_obj.SetTransObject(SQLCA) = -1 THEN  
	Return -1  
ELSE 
	IF il_current_job_num <= 0 THEN RETURN -2
	Return adwc_obj.Retrieve(il_current_job_num)  
END IF
end event

type dw_skid_list from u_dw within tabpage_sheet
event ue_goto_row ( )
integer x = 15
integer y = 19
integer width = 4385
integer height = 832
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_office_entry_skid_list_display"
boolean hscrollbar = true
boolean livescroll = false
end type

event ue_goto_row;Long ll_crow, ll_trow, ll_i

IF il_cur_skid <= 0 THEN RETURN

ll_trow = RowCount()
IF ll_trow > 0 THEN
	ll_crow = 0
	FOR ll_i = 1 TO ll_trow
		IF GetItemNumber(ll_i, "sheet_skid_sheet_skid_num", Primary!, FALSE) = il_cur_skid THEN
			ll_crow = ll_i
		END IF
	NEXT
	IF ll_crow > 0 THEN
		SelectRow(0, False)
		SelectRow(ll_crow, True)
		SetRow(ll_crow)
		ScrollToRow(ll_crow)
	END IF
END IF


end event

event constructor;of_SetBase(TRUE)
of_SettransObject(SQLCA)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
of_SetFilter(TRUE)





end event

event rbuttondown;//Override
RETURN 0
end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

event rbuttonup;//Override
RETURN 0
end event

event pfc_retrieve;call super::pfc_retrieve;DataWindowChild ldddw_cni
IF this.GetChild("production_sheet_item_coil_abc_num", ldddw_cni) = -1 THEN 
	Return -1
ELSE
	this.Event pfc_PopulateDDDW("production_sheet_item_coil_abc_num", ldddw_cni)
END IF

RETURN this.Retrieve(il_current_job_num)



end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

end event

event pfc_populatedddw;call super::pfc_populatedddw;IF adwc_obj.SetTransObject(SQLCA) = -1 THEN  
	Return -1  
ELSE 
	IF il_current_job_num <= 0 THEN RETURN -2
	Return adwc_obj.Retrieve(il_current_job_num)  
END IF
end event

type gb_1 from groupbox within tabpage_sheet
integer x = 7
integer y = 880
integer width = 4440
integer height = 317
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Editor"
borderstyle borderstyle = styleraised!
end type

type tabpage_scrap from userobject within tab_skids
event create ( )
event destroy ( )
integer x = 15
integer y = 90
integer width = 4432
integer height = 1402
long backcolor = 79741120
string text = "Scrap Skids"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_convertback cb_convertback
cb_scrapcredit cb_scrapcredit
dw_report dw_report
cb_ref cb_ref
cb_sort cb_sort
cb_print_scrap cb_print_scrap
cb_edit cb_edit
cb_removeitem cb_removeitem
cb_remove cb_remove
cb_newitem cb_newitem
cb_new_scrap cb_new_scrap
cb_ereset cb_ereset
cb_esave cb_esave
dw_editor dw_editor
st_9 st_9
dw_scrap_item dw_scrap_item
st_6 st_6
st_7 st_7
st_5 st_5
st_3 st_3
st_4 st_4
st_2 st_2
st_8 st_8
dw_scrap_list dw_scrap_list
end type

on tabpage_scrap.create
this.cb_convertback=create cb_convertback
this.cb_scrapcredit=create cb_scrapcredit
this.dw_report=create dw_report
this.cb_ref=create cb_ref
this.cb_sort=create cb_sort
this.cb_print_scrap=create cb_print_scrap
this.cb_edit=create cb_edit
this.cb_removeitem=create cb_removeitem
this.cb_remove=create cb_remove
this.cb_newitem=create cb_newitem
this.cb_new_scrap=create cb_new_scrap
this.cb_ereset=create cb_ereset
this.cb_esave=create cb_esave
this.dw_editor=create dw_editor
this.st_9=create st_9
this.dw_scrap_item=create dw_scrap_item
this.st_6=create st_6
this.st_7=create st_7
this.st_5=create st_5
this.st_3=create st_3
this.st_4=create st_4
this.st_2=create st_2
this.st_8=create st_8
this.dw_scrap_list=create dw_scrap_list
this.Control[]={this.cb_convertback,&
this.cb_scrapcredit,&
this.dw_report,&
this.cb_ref,&
this.cb_sort,&
this.cb_print_scrap,&
this.cb_edit,&
this.cb_removeitem,&
this.cb_remove,&
this.cb_newitem,&
this.cb_new_scrap,&
this.cb_ereset,&
this.cb_esave,&
this.dw_editor,&
this.st_9,&
this.dw_scrap_item,&
this.st_6,&
this.st_7,&
this.st_5,&
this.st_3,&
this.st_4,&
this.st_2,&
this.st_8,&
this.dw_scrap_list}
end on

on tabpage_scrap.destroy
destroy(this.cb_convertback)
destroy(this.cb_scrapcredit)
destroy(this.dw_report)
destroy(this.cb_ref)
destroy(this.cb_sort)
destroy(this.cb_print_scrap)
destroy(this.cb_edit)
destroy(this.cb_removeitem)
destroy(this.cb_remove)
destroy(this.cb_newitem)
destroy(this.cb_new_scrap)
destroy(this.cb_ereset)
destroy(this.cb_esave)
destroy(this.dw_editor)
destroy(this.st_9)
destroy(this.dw_scrap_item)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_5)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_2)
destroy(this.st_8)
destroy(this.dw_scrap_list)
end on

type cb_convertback from u_cb within tabpage_scrap
string tag = "Scarp skid reports"
integer x = 2103
integer y = 1251
integer width = 325
integer height = 83
integer taborder = 140
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Convert Back"
end type

event clicked;call super::clicked;Long ll_row, ll_scrap_skid_num, ll_packing_list
Int li_status, li_rc, li_return

ll_row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
IF ll_row < 1 THEN Return 0
li_status = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "skid_scrap_status", Primary!, FALSE)
IF li_status = 0 THEN
	MessageBox("Error","Failed to convert back. This scrap skid has been shipped to customer already.", StopSign!)
	RETURN
END IF

ll_scrap_skid_num = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "scrap_skid_num", Primary!, FALSE)
select count(*) into :li_rc from scrap_packing_item
where scrap_skid_num = :ll_scrap_skid_num
using SQLCA;
if li_rc > 0 then
	select packing_list into :ll_packing_list from scrap_packing_item
	where scrap_skid_num = :ll_scrap_skid_num
	using SQLCA;
	MessageBox("Error","Failed to convert. This scrap skid has been loaded into BOL#" + String(ll_packing_list), StopSign!)
	return 0
end if

select count(*) into :li_rc from scraped_sheet_skid
where scrap_skid_num = :ll_scrap_skid_num
using SQLCA;
if li_rc <= 0 then
	MessageBox("Error","Failed to convert. The scrap skid#" + String(ll_scrap_skid_num) +" was NOT converted from a sheet skid.", StopSign!)
	return 0
end if

li_rc = MessageBox("Confirmation","Please confirm converting scrap skid#" + String(ll_scrap_skid_num) +" back to sheet skid.", Question!, YesNo!)
if li_rc = 1 then
	setpointer(hourglass!)
	transaction dboconnect
	dboconnect = create transaction
	dboconnect.DBMS = ProfileString(gs_ini_file,"Database","DBMS","")
	dboconnect.Servername = ProfileString(gs_ini_file,"Database","ServerName","")
	dboconnect.LogID = gs_LogID
	dboconnect.LogPass = gs_LogPass
	connect using dboconnect;
	if dboconnect.SQLCode<0 then 
		MessageBox ("Connection Failed!!!!",dboconnect.sqlerrtext,exclamation!)
		return -1
	end if
	
	DECLARE p_convert_back_to_sheet procedure for f_convert_back_to_sheet(:ll_scrap_skid_num) using dboconnect;
	execute p_convert_back_to_sheet;
	if dboconnect.SQLCode < 0 then 
		MessageBox ("Stored Procedure Failed!!!",dboconnect.sqlerrtext,exclamation!)
		disconnect using dboconnect;
		destroy dboconnect;
		return 0
	end if
	fetch p_convert_back_to_sheet INTO :li_return; 
	close p_convert_back_to_sheet;
	
	disconnect using dboconnect;
	destroy dboconnect;
	
	choose case li_return
	case 1
		Messagebox("Convert","Convert back to sheet skid successfully. Please click OK then wait while this window refreshing..." )		
		tab_skids.tabpage_sheet.cb_refresh.event clicked()
		tab_skids.tabpage_scrap.dw_scrap_list.Retrieve(il_current_job_num)
	case else
		MessageBox("Convert", "Convert skid failed.", StopSign!)
   end choose
	
else
	return 0
	
end if


end event

type cb_scrapcredit from u_cb within tabpage_scrap
integer x = 1766
integer y = 1251
integer width = 325
integer height = 83
integer taborder = 80
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Scrap Credit"
end type

event clicked;call super::clicked;Long ll_row, ll_scrap_skid_num
Int li_status,  li_rc

ll_row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
IF ll_row < 1 THEN Return -1
li_status = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "skid_scrap_status", Primary!, FALSE)
IF li_status = 0 THEN
	MessageBox("Error","Failed to modify this scrap skid because it has been shipped to customer already.", StopSign!)
	RETURN 0
ELSE
	ll_scrap_skid_num = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "scrap_skid_num", Primary!, FALSE)
END IF

li_rc = MessageBox("Confirmation","Please confirm converting scrap skid #" + String(ll_scrap_skid_num) + " into scrap credit.", Question!, YesNo!)

if li_rc  =  1 then
	  UPDATE "SCRAP_SKID"  
     SET "CUSTOMER_ID" = 1054  
     WHERE "SCRAP_SKID"."SCRAP_SKID_NUM" =  :ll_scrap_skid_num  
	  Using SQLCA;
	  IF SQLCA.SQLCode = -1 THEN 
	        MessageBox("SQL error", SQLCA.SQLErrText)
			  rollback using SQLCA;
	  END IF
	  commit using SQLCA;
	  tab_skids.tabpage_scrap.dw_scrap_list.Retrieve(il_current_job_num)
	  tab_skids.tabpage_scrap_credit.dw_scrap_credit.Retrieve(il_current_job_num)
else
	return 0
end if	

RETURN ll_row
end event

type dw_report from u_dw within tabpage_scrap
boolean visible = false
integer x = 3416
integer y = 1251
integer width = 106
integer height = 74
integer taborder = 170
boolean bringtotop = true
string dataobject = "d_office_entry_report_scrap_list"
boolean livescroll = false
end type

type cb_ref from u_cb within tabpage_scrap
integer x = 3120
integer y = 1251
integer width = 325
integer height = 83
integer taborder = 160
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Re&ference"
end type

event clicked;window lw_parent

lw_parent = tab_skids.GetParent()
lw_parent.dynamic Event ue_ref_scrap()
RETURN 1
end event

type cb_sort from u_cb within tabpage_scrap
integer x = 2779
integer y = 1251
integer width = 325
integer height = 83
integer taborder = 150
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "S&ort"
end type

event clicked;
SetPointer(HourGlass!)
window lw_parent

lw_parent = tab_skids.GetParent()
lw_parent.dynamic Event ue_sort_scrap()

end event

type cb_print_scrap from u_cb within tabpage_scrap
string tag = "Scarp skid reports"
integer x = 2439
integer y = 1251
integer width = 325
integer height = 83
integer taborder = 130
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;window lw_parent

lw_parent = tab_skids.GetParent()
lw_parent.dynamic Event ue_scrap_report()

end event

type cb_edit from u_cb within tabpage_scrap
integer x = 1426
integer y = 1251
integer width = 325
integer height = 83
integer taborder = 120
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Modify"
end type

event clicked;RETURN	tab_skids.tabpage_scrap.dw_editor.Event ue_modify()
end event

type cb_removeitem from u_cb within tabpage_scrap
integer x = 1090
integer y = 1251
integer width = 325
integer height = 83
integer taborder = 110
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "R&emove Item"
end type

event clicked;//Parent.Event ue_deleteitem()
window lw_parent

lw_parent = tab_skids.GetParent()
lw_parent.dynamic Event ue_delete_scrap_item()
end event

type cb_remove from u_cb within tabpage_scrap
integer x = 750
integer y = 1251
integer width = 325
integer height = 83
integer taborder = 100
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Remove Skid"
end type

event clicked;//Parent.Event ue_deleteskid()
window lw_parent

lw_parent = tab_skids.GetParent()
lw_parent.dynamic Event ue_delete_scrap_skid()
end event

type cb_newitem from u_cb within tabpage_scrap
integer x = 410
integer y = 1251
integer width = 325
integer height = 83
integer taborder = 90
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "New &Item"
end type

event clicked;
tab_skids.tabpage_scrap.dw_editor.ResetUpdate()
tab_skids.tabpage_scrap.dw_editor.DataObject = "d_return_scrap_item_editor"
tab_skids.tabpage_scrap.dw_editor.SetTransObject(sqlca) 

RETURN	tab_skids.tabpage_scrap.dw_editor.Event ue_additem()

end event

type cb_new_scrap from u_cb within tabpage_scrap
integer x = 73
integer y = 1251
integer width = 325
integer height = 83
integer taborder = 70
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&New Skid"
end type

event clicked;SetPointer(HourGlass!)
//Parent.Event pfc_new()
window lw_parent

lw_parent = tab_skids.GetParent()
lw_parent.dynamic Event ue_new_scrap_skid()
end event

type cb_ereset from u_cb within tabpage_scrap
integer x = 3504
integer y = 1251
integer width = 263
integer height = 83
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "&Cancel"
end type

event clicked;
tab_skids.tabpage_scrap.dw_editor.ResetUpdate()
tab_skids.tabpage_scrap.dw_editor.Reset()
wf_set_scrap_action(0)

end event

type cb_esave from u_cb within tabpage_scrap
integer x = 3807
integer y = 1251
integer width = 263
integer height = 83
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "&Save"
end type

event clicked;
SetPointer(HourGlass!)
Int li_rc
Long ll_skid, ll_item, ll_row, ll_i

Long ll_snet, ll_stare, ll_scust, ll_cur_net, item_total_net
Int li_sstatus, li_itype 
DateTime ld_sdate
String ls_stemper, ls_spo, ls_location, ls_salloy, ls_snotes, ls_sjob

Long ll_inet, ll_icoil, ll_ijob
DateTime ld_idate
String ls_inotes

//Added by Victor Huang in 10/05 for tote number handling
Int li_tote_num

String	ls_trailer_name //Alex Gerlants. Tote_Trailer_Name. 06/12/2018

String	ls_scrap_handling_type //Alex Gerlants. Scrap Credit
Integer	li_answer, li_rtn //Alex Gerlants. Scrap Credit
Boolean	lb_display_message, lb_new_skid //Alex Gerlants. Scrap Credit

IF wf_check_info() < 0 THEN 
	MessageBox("Info", "Failed to save data.")
	RETURN -1
END IF





tab_skids.tabpage_scrap.dw_editor.AcceptText()
ll_row = tab_skids.tabpage_scrap.dw_editor.GetRow()
IF (ll_row < 1) OR IsNULL(ll_row) THEN RETURN -2

CHOOSE CASE ii_action_scrap
	CASE 1,5,4  //skid
		ll_scust = tab_skids.tabpage_scrap.dw_editor.GetItemNumber(ll_row, "customer_id", Primary!, FALSE)
		ll_skid = tab_skids.tabpage_scrap.dw_editor.GetItemNumber(ll_row, "scrap_skid_num", Primary!, FALSE)
		ll_snet = tab_skids.tabpage_scrap.dw_editor.GetItemNumber(ll_row, "scrap_net_wt", Primary!, FALSE)

		//Alex Gerlants. Tote_Trailer_Name. 06/12/2018. Begin
		If IsNull(ll_snet) Then ll_snet = 0
		
		If ll_snet = 0 Then
			Messagebox("Error!", "Skid Net Weight must be populated", StopSign!)
			Return 0
		End If
		//Alex Gerlants. Tote_Trailer_Name. 06/12/2018. End

		ll_stare = tab_skids.tabpage_scrap.dw_editor.GetItemNumber(ll_row, "scrap_tare_wt", Primary!, FALSE)
		ls_sjob = tab_skids.tabpage_scrap.dw_editor.GetItemString(ll_row, "scrap_ab_job_num", Primary!, FALSE)
		li_sstatus = tab_skids.tabpage_scrap.dw_editor.GetItemNumber(ll_row, "skid_scrap_status", Primary!, FALSE)
		ld_sdate = tab_skids.tabpage_scrap.dw_editor.GetItemDateTime(ll_row, "scrap_date", Primary!, FALSE)
		li_itype = tab_skids.tabpage_scrap.dw_editor.GetItemNumber(ll_row, "scrap_type", Primary!, FALSE)
		ls_stemper = tab_skids.tabpage_scrap.dw_editor.GetItemString(ll_row, "scrap_temper", Primary!, FALSE)
		ls_spo = tab_skids.tabpage_scrap.dw_editor.GetItemString(ll_row, "scrap_cust_po", Primary!, FALSE)
		ls_location = tab_skids.tabpage_scrap.dw_editor.GetItemString(ll_row, "scrap_location", Primary!, FALSE)
		ls_snotes = tab_skids.tabpage_scrap.dw_editor.GetItemString(ll_row, "scrap_notes", Primary!, FALSE)
		ls_salloy = tab_skids.tabpage_scrap.dw_editor.GetItemString(ll_row, "scrap_alloy2", Primary!, FALSE)
		
		//Added by Victor Huang in 10/05 for tote number handling
		li_tote_num = tab_skids.tabpage_scrap.dw_editor.GetItemNumber(ll_row, "tote_num", Primary!, FALSE)
		
		ls_trailer_name = tab_skids.tabpage_scrap.dw_editor.Object.trailer_name[ll_row] //Alex Gerlants. Tote_Trailer_Name. 06/12/2018
		ls_scrap_handling_type = tab_skids.tabpage_scrap.dw_editor.Object.scrap_handling_type[ll_row] //Alex Gerlants. Scrap Credit
	CASE 2,3,6   //item
		ll_item = tab_skids.tabpage_scrap.dw_editor.GetItemNumber(ll_row, "return_scrap_item_return_scrap_item_num", Primary!, FALSE)
		ll_icoil = tab_skids.tabpage_scrap.dw_editor.GetItemNumber(ll_row, "return_scrap_item_coil_abc_num", Primary!, FALSE)
		IF ll_icoil = 0 THEN SetNULL(ll_icoil)
		ll_ijob = tab_skids.tabpage_scrap.dw_editor.GetItemNumber(ll_row, "return_scrap_item_ab_job_num", Primary!, FALSE)
		ll_inet = tab_skids.tabpage_scrap.dw_editor.GetItemNumber(ll_row, "return_scrap_item_return_item_net_wt", Primary!, FALSE)
		
		//Alex Gerlants. Tote_Trailer_Name. 06/12/2018. Begin
		If IsNull(ll_inet) Then ll_inet = 0
		
		If ll_inet = 0 Then
			Messagebox("Error!", "Item Net Weight must be populated", StopSign!)
			Return 0
		End If
		//Alex Gerlants. Tote_Trailer_Name. 06/12/2018. End
		
		ld_idate = tab_skids.tabpage_scrap.dw_editor.GetItemDateTime(ll_row, "return_scrap_item_return_item_date", Primary!, FALSE)
		ls_snotes = tab_skids.tabpage_scrap.dw_editor.GetItemString(ll_row, "return_scrap_item_return_item_notes", Primary!, FALSE)
END CHOOSE




ll_row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
IF  (ll_row < 1) AND (ii_action_scrap <> 1) THEN
	Messagebox("You did not select a skid", "Please select a skid!!")
	RETURN -1
END IF

IF ii_action_scrap <> 1 THEN
il_cur_scrap_skid = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "scrap_skid_num", Primary!, FALSE)
END IF



//checking values
CHOOSE CASE ii_action_scrap
	CASE 1 //new skid
//		IF ll_snet <> ll_inet THEN
//			IF MessageBox("Question", "Skid net weight does not add up right, save it anyway?", Question!, YesNo!, 2) = 2 THEN RETURN -1	
//		END IF
	CASE 2 //new item
		//IF wf_check_skid_wt(ll_skid, ll_item) < 0 THEN RETURN -2
	CASE 3 //delete item
		//IF wf_check_skid_wt(ll_skid, ll_item) < 0 THEN RETURN -3
	CASE 4 //modify skid
		//ll_row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
		//ll_cur_net = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "scrap_net_wt", Primary!, FALSE)
		
		li_rc = tab_skids.tabpage_scrap.dw_scrap_item.RowCount()
		IF (li_rc < 1) OR IsNULL(li_rc) THEN 
			Messagebox("Warning!", "No item seleted!")
			RETURN 0
		END IF
		item_total_net = 0
		FOR ll_i = 1 TO li_rc
			item_total_net = item_total_net + tab_skids.tabpage_scrap.dw_scrap_item.GetItemNumber(ll_i, "return_scrap_item_return_item_net_wt", Primary!, FALSE)
		NEXT
		IF ll_snet <> item_total_net THEN
			Messagebox("Net weight did not add up right!!", "Please Modify item net weight first!!")
			RETURN 0
		END IF
		//IF wf_check_skid_wt(ll_skid, ll_item) < 0 THEN RETURN -4
	CASE 5 //del skid
	CASE 6 //modify item
END CHOOSE


CONNECT USING SQLCA;
CHOOSE CASE ii_action_scrap
	CASE 0 	//nothing
	CASE 1 	//new skid
		ll_ijob = Long(ls_sjob)
		ll_item = f_get_next_value("return_scrap_item_id_seq")
		SetNULL(ll_icoil)
		INSERT INTO scrap_skid (scrap_skid_num, customer_id, scrap_type, scrap_temper, scrap_net_wt, scrap_tare_wt, scrap_cust_po, scrap_ab_job_num, scrap_location,scrap_date, skid_scrap_status, scrap_notes, scrap_alloy2, tote_num, trailer_name, scrap_handling_type )
		VALUES (:ll_skid, :ll_scust, :li_itype, :ls_stemper,:ll_snet, :ll_stare, :ls_spo, :ls_sjob, :ls_location, :ld_sdate, :li_sstatus, :ls_snotes, :ls_salloy, :li_tote_num, :ls_trailer_name, :ls_scrap_handling_type)
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Insert Skid function: scrap skid table" )
			RETURN -5
		END IF
		INSERT INTO return_scrap_item (return_scrap_item_num, coil_abc_num , ab_job_num , return_item_net_wt, return_item_date, return_item_notes)
		VALUES (:ll_item, :ll_icoil, :ll_ijob, :ll_snet, :ld_sdate, :ls_inotes)
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Insert Skid function:  scrap skid item table" )
			RETURN -5
		END IF
		INSERT INTO scrap_skid_detail
		VALUES (:ll_skid, :ll_item)
		USING SQLCA;		
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Insert Skid function: skid detail table" )
			RETURN -5
		END IF
	CASE 2	//new item
		INSERT INTO return_scrap_item (return_scrap_item_num, coil_abc_num , ab_job_num , return_item_net_wt, return_item_date, return_item_notes)
		VALUES (:ll_item, :ll_icoil, :ll_ijob, :ll_inet, :ld_idate, :ls_inotes)
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Insert item function:  scrap skid item table" )
			RETURN -5
		END IF
		INSERT INTO scrap_skid_detail
		VALUES (:il_cur_scrap_skid, :ll_item)
		USING SQLCA;		
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Insert item function: skid detail table" )
			RETURN -5
		END IF
		
		UPDATE scrap_skid SET scrap_net_wt = scrap_net_wt + :ll_inet
		WHERE SCRAP_SKID_NUM = :il_cur_scrap_skid
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Insert item function: scrap skid table" )
			RETURN -5
		END IF
		
	CASE 3	//delete item
		DELETE FROM scrap_skid_detail
		WHERE scrap_skid_num = :il_cur_scrap_skid AND return_scrap_item_num = :ll_item
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Delete item function: skid detail table" )
			RETURN -5
		END IF
		DELETE FROM return_scrap_item
		WHERE return_scrap_item_num = :ll_item
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Delete item function: skid item table" )
			RETURN -5
		END IF
		
		UPDATE scrap_skid SET scrap_net_wt = scrap_net_wt - :ll_inet
		WHERE SCRAP_SKID_NUM = :il_cur_scrap_skid
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Delete item function: scrap skid table" )
			RETURN -5
		END IF
		
		
		
	CASE 4	//modify skid
		UPDATE scrap_skid
		SET customer_id = :ll_scust, scrap_type = :li_itype, scrap_temper = :ls_stemper, scrap_net_wt = :ll_snet, scrap_tare_wt = :ll_stare, scrap_cust_po = :ls_spo, scrap_ab_job_num = :ls_sjob, scrap_location = :ls_location, scrap_date = :ld_sdate, skid_scrap_status = :li_sstatus, scrap_notes = :ls_snotes, scrap_alloy2 = :ls_salloy, tote_num = :li_tote_num, trailer_name = :ls_trailer_name, scrap_handling_type = :ls_scrap_handling_type
		WHERE scrap_skid_num = :ll_skid
		USING SQLCA;
		IF SQLCA.SQLNRows = 0 THEN
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Modify function" )
			RETURN -5
		END IF			
	CASE 5	//delete skid
		DELETE FROM scrap_skid_detail
		WHERE scrap_skid_num = :ll_skid AND return_scrap_item_num = :il_cur_item
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Delete function: scrap skid detail table" )
			RETURN -5
		END IF
 		DELETE FROM return_scrap_item
		WHERE return_scrap_item_num = :il_cur_item
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Delete function: scrap skid item table" )
			RETURN -5
		END IF
		DELETE FROM scrap_skid
		WHERE scrap_skid_num = :ll_skid
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Delete function: skid table" )
			RETURN -5
		END IF
	CASE 6	//modify item
		ll_row = tab_skids.tabpage_scrap.dw_scrap_item.GetRow()
		ll_cur_net = tab_skids.tabpage_scrap.dw_scrap_item.GetItemNumber(ll_row, "return_scrap_item_return_item_net_wt", Primary!, FALSE)
		//Messagebox("current net wt", ll_cur_net)
		ll_cur_net = ll_inet - ll_cur_net
		//Messagebox("net wt diff", ll_cur_net)
		
		UPDATE return_scrap_item
		SET coil_abc_num = :ll_icoil, ab_job_num = :ll_ijob, return_item_net_wt = :ll_inet, return_item_date = :ld_idate, return_item_notes = :ls_inotes
		WHERE return_scrap_item_num = :ll_item
		USING SQLCA;
		IF SQLCA.SQLNRows = 0 THEN
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Modify function" )
			RETURN -5
		END IF
		
		//Messagebox("current skid", il_cur_scrap_skid)
		UPDATE scrap_skid SET scrap_net_wt = scrap_net_wt + :ll_cur_net
		WHERE SCRAP_SKID_NUM = :il_cur_scrap_skid
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Modify item function: scrap skid table" )
			RETURN -5
		END IF
		
		//tab_skids.tabpage_scrap.dw_scrap_list.SetItem(ll_row, "scrap_net_wt", ll_snet)
		
		
END CHOOSE

//Alex Gerlants. Scrap Credit. Begin
If lower(ls_scrap_handling_type) = "scrap credit" Then
	If ii_action_scrap = 1 Then //New skid
		li_answer =  MessageBox("Confirmation","Please confirm saving scrap skid #" + String(ll_skid) + " as scrap credit.", Question!, YesNo!)
	ElseIf ii_action_scrap = 4 Then //Modify skid
		li_answer =  MessageBox("Confirmation","Please confirm converting scrap skid #" + String(ll_skid) + " into scrap credit.", Question!, YesNo!)
	End If
	
	If li_answer = 1 Then //Yes
		lb_display_message = False
	
		If ii_action_scrap = 1 Then //New skid
			lb_new_skid = True
		ElseIf ii_action_scrap = 4 Then //Modify skid
			lb_new_skid = False
		End If
		
		li_rtn = wf_scrap_credit(lb_display_message, ll_skid, lb_new_skid)
		
		If li_rtn = -1 Then //DB error in wf_scrap_credit()
			rollback using sqlca;
			Return 0
		End If
		
		tab_skids.tabpage_scrap.dw_editor.Reset()
	Else
		rollback using sqlca;
		Return 0
	End if
	
	//If ii_action_scrap = 1 Then //New skid
	//
	//	li_answer =  MessageBox("Confirmation","Please confirm making scrap skid #" + String(ll_skid) + " into scrap credit.", Question!, YesNo!)
	//
	//	If li_answer = 1 Then //Yes
	//		lb_display_message = False
	//		lb_new_skid = True
	//		wf_scrap_credit(lb_display_message, ll_skid, lb_new_skid)
	//		tab_skids.tabpage_scrap.dw_editor.Reset()
	//	Else
	//		rollback using sqlca;
	//		Return 0
	//	End if
	//ElseIf ii_action_scrap = 4 Then //Modify skid
	//	li_answer =  MessageBox("Confirmation","Please confirm making scrap skid #" + String(ll_skid) + " into scrap credit.", Question!, YesNo!)
	//
	//	If li_answer = 1 Then //Yes
	//		tab_skids.tabpage_scrap.dw_scrap_list.SelectRow(0, False)
	//		tab_skids.tabpage_scrap.dw_scrap_list.SelectRow(ll_row, True)
	//		tab_skids.tabpage_scrap.dw_scrap_list.SetRow(ll_row) //Make this row current because Clicked event for cb_scrapcredit uses GetRow()
	//		
	//		lb_display_message = False
	//		lb_new_skid = False
	//		wf_scrap_credit(lb_display_message, ll_skid, lb_new_skid)
	//	Else //No
	//		rollback using sqlca;
	//		Return 0
	//	End If
	//End If
End If
//Alex Gerlants. Scrap Credit. End

COMMIT USING SQLCA;

MessageBox("Info", "Data had been saved.")

CHOOSE CASE ii_action_scrap
	CASE 0 	//nothing
	CASE 1 	//new skid
		If lower(ls_scrap_handling_type) <> "scrap credit" Then //Alex Gerlants. Scrap Credit. For scrap credit, tab_skids.tabpage_scrap.dw_editor is reset above
			tab_skids.tabpage_scrap.dw_editor.RowsCopy(tab_skids.tabpage_scrap.dw_editor.GetRow(), tab_skids.tabpage_scrap.dw_editor.GetRow(), Primary!, tab_skids.tabpage_scrap.dw_scrap_list, (tab_skids.tabpage_scrap.dw_scrap_list.RowCount() + 1), Primary!)		
		End If //Alex Gerlants. Scrap Credit
	CASE 2	//new item
		tab_skids.tabpage_scrap.dw_editor.RowsCopy(tab_skids.tabpage_scrap.dw_editor.GetRow(), tab_skids.tabpage_scrap.dw_editor.GetRow(), Primary!, tab_skids.tabpage_scrap.dw_scrap_item, (tab_skids.tabpage_scrap.dw_scrap_item.RowCount() + 1), Primary!)		
			ll_row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
			ll_cur_net = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "scrap_net_wt", Primary!, FALSE)
			tab_skids.tabpage_scrap.dw_scrap_list.SetItem(ll_row, "scrap_net_wt", ll_cur_net + ll_inet)
	CASE 3	//delete item
		IF tab_skids.tabpage_scrap.dw_scrap_item.GetRow() > 0 THEN
			tab_skids.tabpage_scrap.dw_scrap_item.DeleteRow(tab_skids.tabpage_scrap.dw_scrap_item.GetRow() )
			ll_row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
			ll_cur_net = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "scrap_net_wt", Primary!, FALSE)
			tab_skids.tabpage_scrap.dw_scrap_list.SetItem(ll_row, "scrap_net_wt", ll_cur_net - ll_inet)
		END IF
	CASE 4	//modify skid
		ll_row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
		IF ll_row > 0 THEN
			IF ll_skid = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "scrap_skid_num", Primary!, FALSE) THEN		
				tab_skids.tabpage_scrap.dw_scrap_list.SetItem(ll_row, "scrap_net_wt", ll_snet)
				tab_skids.tabpage_scrap.dw_scrap_list.SetItem(ll_row, "scrap_tare_wt",ll_stare)
				tab_skids.tabpage_scrap.dw_scrap_list.SetItem(ll_row, "scrap_ab_job_num",ls_sjob)
				tab_skids.tabpage_scrap.dw_scrap_list.SetItem(ll_row, "skid_scrap_status", li_sstatus)
				tab_skids.tabpage_scrap.dw_scrap_list.SetItem(ll_row, "scrap_date",ld_sdate) 
				tab_skids.tabpage_scrap.dw_scrap_list.SetItem(ll_row, "scrap_type", li_itype)
				tab_skids.tabpage_scrap.dw_scrap_list.SetItem(ll_row, "scrap_temper",ls_stemper)
				tab_skids.tabpage_scrap.dw_scrap_list.SetItem(ll_row, "scrap_cust_po",ls_spo)
				tab_skids.tabpage_scrap.dw_scrap_list.SetItem(ll_row, "scrap_location", ls_location)
				tab_skids.tabpage_scrap.dw_scrap_list.SetItem(ll_row, "scrap_notes",ls_snotes)
				tab_skids.tabpage_scrap.dw_scrap_list.SetItem(ll_row, "scrap_alloy2",ls_salloy)
				tab_skids.tabpage_scrap.dw_scrap_list.SetItem(ll_row, "tote_num",ls_salloy)
				
				tab_skids.tabpage_scrap.dw_scrap_list.Object.trailer_name[ll_row] = ls_trailer_name //Alex Gerlants. Tote_Trailer_Name. 06/12/2018
				tab_skids.tabpage_scrap.dw_scrap_list.Object.scrap_handling_type[ll_row] = ls_scrap_handling_type //Alex Gerlants. Scrap Credit 
			END IF
		END IF
	CASE 5	//delete skid
		IF tab_skids.tabpage_scrap.dw_scrap_list.GetRow() > 0 THEN
			tab_skids.tabpage_scrap.dw_scrap_list.DeleteRow(tab_skids.tabpage_scrap.dw_scrap_list.GetRow() )
		END IF
	CASE 6   //modify item
		ll_row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
		ll_snet = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "scrap_net_wt", Primary!, FALSE)
		tab_skids.tabpage_scrap.dw_scrap_list.SetItem(ll_row, "scrap_net_wt", ll_snet + ll_cur_net)
		
		ll_row = tab_skids.tabpage_scrap.dw_scrap_item.GetRow()
		IF ll_row > 0 THEN
			IF ll_item = tab_skids.tabpage_scrap.dw_scrap_item.GetItemNumber(ll_row, "return_scrap_item_return_scrap_item_num", Primary!, FALSE) THEN
				tab_skids.tabpage_scrap.dw_scrap_item.SetItem(ll_row, "return_scrap_item_coil_abc_num", ll_icoil)
				tab_skids.tabpage_scrap.dw_scrap_item.SetItem(ll_row, "return_scrap_item_ab_job_num", ll_ijob)
				tab_skids.tabpage_scrap.dw_scrap_item.SetItem(ll_row, "return_scrap_item_return_item_net_wt",ll_inet)
				tab_skids.tabpage_scrap.dw_scrap_item.SetItem(ll_row, "return_scrap_item_return_item_date", ld_idate)
				tab_skids.tabpage_scrap.dw_scrap_item.SetItem(ll_row, "return_scrap_item_return_item_notes", ls_snotes)
				
			END IF
		END IF
END CHOOSE
tab_skids.tabpage_scrap.dw_scrap_list.ResetUpdate()
tab_skids.tabpage_scrap.dw_scrap_item.ResetUpdate()
tab_skids.tabpage_scrap.dw_scrap_list.Retrieve(il_current_job_num)

////Alex Gerlants. Scrap Credit. Begin
//If lower(ls_scrap_handling_type) = "scrap credit" Then
//	If ii_action_scrap = 1 Then //New skid
//		ls_find_string = "scrap_skid_num = " + String(ll_skid)
//		ll_found_row = tab_skids.tabpage_scrap.dw_scrap_list.Find(ls_find_string, 1, tab_skids.tabpage_scrap.dw_scrap_list.RowCount())
//		
//		If ll_found_row > 0 Then
//			ll_row = ll_found_row
//			
//			tab_skids.tabpage_scrap.dw_scrap_list.SelectRow(0, False)
//			tab_skids.tabpage_scrap.dw_scrap_list.SelectRow(ll_row, True)
//			tab_skids.tabpage_scrap.dw_scrap_list.SetRow(ll_row) //Make this row current because Clicked event for cb_scrapcredit uses GetRow()
//		
//			cb_scrapcredit.Event Clicked()
//		End If
//	ElseIf ii_action_scrap = 4 Then //Modify skid	
//		tab_skids.tabpage_scrap.dw_scrap_list.SelectRow(0, False)
//		tab_skids.tabpage_scrap.dw_scrap_list.SelectRow(ll_row, True)
//		tab_skids.tabpage_scrap.dw_scrap_list.SetRow(ll_row) //Make this row current because Clicked event for cb_scrapcredit uses GetRow()
//		
//		cb_scrapcredit.Event Clicked()
//	End If
//End If
////Alex Gerlants. Scrap Credit. End

wf_display_total_info()
tab_skids.tabpage_scrap.dw_scrap_list.Event ue_goto_row()


tab_skids.tabpage_scrap.dw_editor.ResetUpdate()
tab_skids.tabpage_scrap.dw_editor.Reset()
wf_set_scrap_action(0)

RETURN 1


end event

type dw_editor from u_dw within tabpage_scrap
event type integer ue_additem ( )
event type integer ue_addscrap ( long al_skid )
event type integer ue_del_row ( )
event type integer ue_modify ( )
integer x = 4
integer y = 979
integer width = 4425
integer height = 237
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_office_entry_return_scrap_item_editor"
boolean hscrollbar = true
boolean vscrollbar = false
boolean livescroll = false
end type

event type integer ue_additem();
Long ll_item, ll_row
Int li_status

ll_row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
IF ll_row < 1 THEN Return 0
li_status = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "skid_scrap_status", Primary!, FALSE)
IF li_status = 0 THEN
	MessageBox("Error","Failed to add item to this skid because it has been shipped to customer already!", StopSign!)
	RETURN 0
END IF
il_cur_scrap_skid = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "scrap_skid_num", Primary!, FALSE)

ll_row = this.Insertrow(0)
ll_item = f_get_next_value("return_scrap_item_id_seq")

SetItem(ll_row, "return_scrap_item_return_scrap_item_num", ll_item)
SetItem(ll_row, "return_scrap_item_return_item_date", Today())

wf_set_scrap_action(2)

Return ll_item


end event

event type integer ue_addscrap(long al_skid);
Long ll_row, ll_i, ll_new_skid, ll_row_cut, ll_c_id
Int li_cut_status

IF al_skid < 1 THEN Return 0

SetFilter("")
Filter()

ll_row = this.RowCount()
IF ll_row <= 0 THEN Return 0

FOR ll_i = 1 TO ll_row 
	ll_new_skid = this.GetItemNumber(ll_i, "Scrap_skid_num" )
	IF ll_new_skid = al_skid THEN
		li_cut_status = this.GetItemNumber(ll_i,"skid_scrap_status")
		IF li_cut_status <> 6 THEN 
			this.SetFilter("skid_scrap_status <> 6")
			this.Filter()
			MessageBox("Error","This pallet has been used already!", StopSign!)
			Return 0
		END IF
		this.SetItem(ll_i, "skid_scrap_status", 2)
		
		//ll_row_cut = dw_customer.GetRow()
		//ll_c_id = dw_customer.GetItemNumber(ll_row_cut, "customer_id", Primary!, FALSE)
		select orig_customer_id into :ll_c_id
		from customer_order
		where order_abc_num = :il_current_order
		using SQLCA;
		SetItem(ll_i, "customer_id", ll_c_id)
		SetItem(ll_i, "scrap_date", Today() )
		Return 0
	END IF
NEXT

RETURN al_skid
end event

event type integer ue_del_row();
IF MessageBox("Warning","About to delete the item in editor box, are you sure?", Question!, OKCancel!, 2) = 1 THEN
	tab_skids.tabpage_scrap.cb_esave.Event Clicked()
ELSE
	tab_skids.tabpage_scrap.dw_editor.ResetUpdate()
	tab_skids.tabpage_scrap.dw_editor.Reset()
	wf_set_scrap_action(0)
END IF

RETURN 1

end event

event type integer ue_modify();Long ll_row
Int li_status

Integer	li_rtn //Alex Gerlants. Scrap Credit
String	ls_scrap_handling_cust_order //Alex Gerlants. Scrap Credit

ll_row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
IF ll_row < 1 THEN Return -1
li_status = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "skid_scrap_status", Primary!, FALSE)
IF li_status = 0 THEN
	
	//Leave it as it is
	//If Not wf_check_scrap_skid_status() Then Return 0 //Alex Gerlants. 07/10/2019. Skid_Status_Change_Warning
	
	MessageBox("Error","Failed to modify item to this skid because it has been shipped to customer already.", StopSign!)
	RETURN 0
END IF

//Messagebox("info", ii_dw_flag)

CHOOSE CASE ii_dw_flag
	CASE 1  //scrap skid
		li_rtn = tab_skids.tabpage_scrap.dw_scrap_list.RowsCopy(ll_row, ll_row, Primary!, tab_skids.tabpage_scrap.dw_editor, 1, Primary!)
		
		ls_scrap_handling_cust_order = tab_skids.tabpage_scrap.dw_scrap_list.Object.scrap_handling_type[ll_row] //Alex Gerlants. Scrap Credit
		wf_retrieve_scrap_handling(ls_scrap_handling_cust_order) //Alex Gerlants. Scrap Credit
		
		wf_set_scrap_action(4)
	CASE 2  //scrap item
		tab_skids.tabpage_scrap.dw_scrap_item.RowsCopy(tab_skids.tabpage_scrap.dw_scrap_item.GetRow(), tab_skids.tabpage_scrap.dw_scrap_item.GetRow(), Primary!, tab_skids.tabpage_scrap.dw_editor, 1, Primary!)
		wf_set_scrap_action(6)
END CHOOSE

RETURN ll_row
end event

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

event itemchanged;call super::itemchanged;
String ls_colName, ls_po, ls_epo
Long ll_row, ll_job, ll_cust, ll_num, ll_order, ll_custrow, ll_id
DateTime ld_s, ld_e
Int li_item, li_line

SetNull(ll_id)
ls_ColName = this.GetColumnName()
IF ls_ColName = "return_scrap_item_ab_job_num" THEN
	this.AcceptText()
	ll_row = this.GetRow()
	ll_job = this.GetItemNumber(ll_row,"return_scrap_item_ab_job_num" ,Primary!, FALSE)

	ll_num = 0
	CONNECT USING SQLCA;
	SELECT Count(ab_job_num)
	INTO :ll_num
	FROM ab_job
	WHERE ab_job_num = :ll_job
	USING SQLCA;
		IF ll_num <> 1 THEN
		MessageBox("Warning", "Invalid job number!", StopSign!)
		//wf_reset_item_info(ll_row)
		RETURN -1
	END IF

	SELECT order_abc_num, order_item_num, time_date_started, time_date_finished, line_num
	INTO :ll_order, :li_item, :ld_s, :ld_e, :li_line
	FROM ab_job
	WHERE ab_job_num = :ll_job
	USING SQLCA;
	
	SELECT orig_customer_id, enduser_po, orig_customer_po INTO :ll_cust, :ls_epo, :ls_po
	FROM customer_order
	WHERE order_abc_num = :ll_order
	USING SQLCA;
	/*
	ll_custrow = dw_customer.Getrow()
	IF ll_cust <> dw_customer.GetItemNumber(ll_custrow, "customer_id") THEN
		MessageBox("Warning", "This is other customer's job!", StopSign!)
		//wf_reset_item_info(ll_row)
		RETURN -2
	END IF
	*/

	SetItem(ll_row, "ab_job_line_num", li_line)
	SetItem(ll_row, "ab_job_time_date_started", ld_s)
	SetItem(ll_row, "ab_job_time_date_finished", ld_e)
	SetItem(ll_row, "customer_order_orig_customer_id", ll_cust)
	SetItem(ll_row, "customer_order_enduser_po", ls_epo)
	SetItem(ll_row, "customer_order_orig_customer_po", ls_po)


END IF

end event

event rbuttondown;//Override
RETURN 1
end event

event rbuttonup;//Override
RETURN 1
end event

event pfc_addrow;call super::pfc_addrow;
long ll_row_skid, ll_new_id, ll_row_cut, ll_c_id, ll_prev_row
Int li_i
Long ll_long
Int li_int
Real lr_real
String ls_s

select orig_customer_id into :ll_c_id
from customer_order
where order_abc_num = :il_current_order
using SQLCA;

ll_row_skid = this.GetRow()
//ll_row_cut = dw_customer.GetRow()
//ll_c_id = dw_customer.GetItemNumber(ll_row_cut, "customer_id")
SetItem(ll_row_skid, "customer_id", ll_c_id)

ll_new_id = f_get_next_value("scrap_skid_num_seq")

SetItem(ll_row_skid, "scrap_skid_num", ll_new_id)
SetItem(ll_row_skid, "skid_scrap_status", 2 )
SetItem(ll_row_skid, "scrap_date", Today() )
SetItem(ll_row_skid, "scrap_tare_wt", 0 )

ll_prev_row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
IF ll_prev_row > 0 THEN
	li_int = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_prev_row, "scrap_type", Primary!, FALSE)
	SetItem(ll_row_skid, "scrap_type", li_int)
	ls_s = tab_skids.tabpage_scrap.dw_scrap_list.GetItemString(ll_prev_row, "scrap_ab_job_num", Primary!, FALSE)
	SetItem(ll_row_skid, "scrap_ab_job_num", ls_s)
	ls_s = tab_skids.tabpage_scrap.dw_scrap_list.GetItemString(ll_prev_row, "scrap_alloy2", Primary!, FALSE)
	SetItem(ll_row_skid, "scrap_alloy2", ls_s)
	ls_s = tab_skids.tabpage_scrap.dw_scrap_list.GetItemString(ll_prev_row, "scrap_temper", Primary!, FALSE)
	SetItem(ll_row_skid, "scrap_temper", ls_s)
	ls_s = tab_skids.tabpage_scrap.dw_scrap_list.GetItemString(ll_prev_row, "scrap_cust_po", Primary!, FALSE)
	SetItem(ll_row_skid, "scrap_cust_po", ls_s)
	ls_s = tab_skids.tabpage_scrap.dw_scrap_list.GetItemString(ll_prev_row, "scrap_notes", Primary!, FALSE)
	SetItem(ll_row_skid, "scrap_notes", ls_s)
ELSE
	String ls_alloy2, ls_temper, ls_cust_po
	
	SELECT CUSTOMER_ORDER.ORIG_CUSTOMER_PO, ORDER_ITEM.ALLOY2, ORDER_ITEM.TEMPER INTO :ls_cust_po, :ls_alloy2, :ls_temper
	FROM CUSTOMER_ORDER, ORDER_ITEM, AB_JOB
	WHERE CUSTOMER_ORDER.ORDER_ABC_NUM = ORDER_ITEM.ORDER_ABC_NUM
	AND ORDER_ITEM.ORDER_ABC_NUM = AB_JOB.ORDER_ABC_NUM
	AND ORDER_ITEM.ORDER_ITEM_NUM = AB_JOB.ORDER_ITEM_NUM
	AND AB_JOB.AB_JOB_NUM = :il_current_job_num
	USING SQLCA;	  
	
	SetItem(ll_row_skid, "scrap_ab_job_num", String(il_current_job_num))
	SetItem(ll_row_skid, "scrap_alloy2", ls_alloy2)
	SetItem(ll_row_skid, "scrap_temper", ls_temper)
	SetItem(ll_row_skid, "scrap_cust_po", ls_cust_po)
END IF

wf_set_scrap_action(1)

Return ll_row_skid

end event

type st_9 from statictext within tabpage_scrap
integer x = 4
integer y = 931
integer width = 252
integer height = 48
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
string text = "Editor:"
boolean focusrectangle = false
end type

type dw_scrap_item from u_dw within tabpage_scrap
integer x = 4
integer y = 611
integer width = 4418
integer height = 323
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_office_entry_return_scrap_item"
boolean hscrollbar = true
end type

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 


end event

event getfocus;call super::getfocus;ii_dw_flag = 2
tab_skids.tabpage_scrap.dw_editor.ResetUpdate()
tab_skids.tabpage_scrap.dw_editor.DataObject = "d_office_entry_return_scrap_item_editor"
tab_skids.tabpage_scrap.dw_editor.SetTransObject(sqlca) 

end event

event rbuttondown;//Override
RETURN 0
end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
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

type st_6 from statictext within tabpage_scrap
integer x = 3306
integer y = 560
integer width = 216
integer height = 58
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 79741120
boolean enabled = false
string text = "OnHold"
boolean focusrectangle = false
end type

type st_7 from statictext within tabpage_scrap
integer x = 3017
integer y = 560
integer width = 252
integer height = 58
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 79741120
boolean enabled = false
string text = "Canceled"
boolean focusrectangle = false
end type

type st_5 from statictext within tabpage_scrap
integer x = 2790
integer y = 560
integer width = 208
integer height = 58
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
string text = "Ready"
boolean focusrectangle = false
end type

type st_3 from statictext within tabpage_scrap
integer x = 2322
integer y = 560
integer width = 135
integer height = 58
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15793151
long backcolor = 79741120
boolean enabled = false
string text = "Gone"
boolean focusrectangle = false
end type

type st_4 from statictext within tabpage_scrap
integer x = 2505
integer y = 560
integer width = 252
integer height = 58
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 79741120
boolean enabled = false
string text = "InProcess"
boolean focusrectangle = false
end type

type st_2 from statictext within tabpage_scrap
integer x = 1971
integer y = 560
integer width = 351
integer height = 58
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
string text = "Color indication:"
boolean focusrectangle = false
end type

type st_8 from statictext within tabpage_scrap
integer y = 557
integer width = 457
integer height = 58
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
string text = "Scrap Skid Item List:"
boolean focusrectangle = false
end type

type dw_scrap_list from u_dw within tabpage_scrap
event ue_resume_where ( )
event type integer ue_search_retrieve ( )
event ue_goto_row ( )
integer y = 10
integer width = 4425
integer height = 554
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_office_entry_scrap_skid_list"
boolean hscrollbar = true
boolean livescroll = false
end type

event ue_resume_where();/*
String ls_modify, ls_where, ls_rc
Long ll_cust, ll_row

wf_reset_condition()
ll_row = dw_customer.GetRow()
ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
//ls_where = "  WHERE ( ~~~"SCRAP_SKID_DETAIL~~~".~~~"RETURN_SCRAP_ITEM_NUM~~~" = ~~~"RETURN_SCRAP_ITEM~~~".~~~"RETURN_SCRAP_ITEM_NUM~~~" ) and   ( ~~~"SCRAP_SKID~~~".~~~"SCRAP_SKID_NUM~~~" = ~~~"SCRAP_SKID_DETAIL~~~".~~~"SCRAP_SKID_NUM~~~" ) and  ( ~~~"SCRAP_SKID~~~".~~~"CUSTOMER_ID~~~" = :customer_id ) "
ls_where = "  WHERE ( ~~~"SCRAP_SKID~~~".~~~"CUSTOMER_ID~~~" = :customer_id ) "

ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
ls_rc = this.Modify(ls_modify)
IF ls_rc = "" THEN
	this.Retrieve(ll_cust)
	this.of_Retrieve()
	wf_display_total_info()	
ELSE
	MessageBox("Error","Failure to resume datawindow!", StopSign!)
END IF
st_cond.Text = "All"
*/

end event

event type integer ue_search_retrieve();/*
String ls_modify, ls_where, ls_rc
Long ll_cust, ll_row
integer ls_net

ls_where = wf_search_terms()

ll_row = dw_customer.GetRow()
ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
ls_rc = this.Modify(ls_modify)
IF ls_rc = "" THEN
	this.Retrieve(ll_cust)
	wf_display_total_info()
ELSE
	MessageBox("Error","Failure to modify datawindow: " + ls_rc + ": " + ls_where, StopSign!)
END IF
*/
Return 1

end event

event ue_goto_row();Long ll_crow, ll_trow, ll_i

IF il_cur_scrap_skid <= 0 THEN RETURN

ll_trow = RowCount()
IF ll_trow > 0 THEN
	ll_crow = 0
	FOR ll_i = 1 TO ll_trow
		IF GetItemNumber(ll_i, "scrap_skid_num", Primary!, FALSE) = il_cur_scrap_skid THEN
			ll_crow = ll_i
		END IF
	NEXT
	IF ll_crow > 0 THEN
		SelectRow(0, False)
		SelectRow(ll_crow, True)
		SetRow(ll_crow)
		ScrollToRow(ll_crow)
	END IF
END IF


end event

event clicked;//Override pfc's clicked because it is running on wrong sequence
integer li_rc

// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF

IF IsValid (inv_Sort) THEN 
	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
END IF 

IF IsValid (inv_linkage) THEN
	If inv_linkage.Event pfc_clicked ( xpos, ypos, row, dwo ) <> &
		inv_linkage.CONTINUE_ACTION Then
		// The user or a service action prevents from going to the clicked row.
		Return 1
	End If
END IF


end event

event constructor;of_SetBase(TRUE)
of_SettransObject(SQLCA)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

this.SetFilter("skid_scrap_status <> 6")
this.Filter()

end event

event getfocus;call super::getfocus;ii_dw_flag = 1
tab_skids.tabpage_scrap.dw_editor.ResetUpdate()
tab_skids.tabpage_scrap.dw_editor.DataObject = "d_office_entry_scrap_skid_list_editor"
tab_skids.tabpage_scrap.dw_editor.SetTransObject(sqlca) 


end event

event rbuttondown;//Override
RETURN 0
end event

event rowfocuschanged;call super::rowfocuschanged;this.event pfc_rowchanged()
end event

event rbuttonup;//Override
RETURN 0
end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long li_Row

this.AcceptText()
li_Row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

this.ScrollToRow(li_Row)

//il_cur_skid = tab_scrap.tabpage_skid.dw_scrap_list.GetItemNumber(lI_row, "scrap_skid_num", Primary!, FALSE)
	
//tab_scrap.tabpage_skid.dw_scrap_item.Retrieve(il_cur_skid)

Return 

end event

type tabpage_scrap_credit from userobject within tab_skids
integer x = 15
integer y = 90
integer width = 4432
integer height = 1402
long backcolor = 79741120
string text = "Scrap Credit"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_convertbacktoscrap cb_convertbacktoscrap
cb_print_scrap_credit cb_print_scrap_credit
dw_scrap_credit dw_scrap_credit
end type

on tabpage_scrap_credit.create
this.cb_convertbacktoscrap=create cb_convertbacktoscrap
this.cb_print_scrap_credit=create cb_print_scrap_credit
this.dw_scrap_credit=create dw_scrap_credit
this.Control[]={this.cb_convertbacktoscrap,&
this.cb_print_scrap_credit,&
this.dw_scrap_credit}
end on

on tabpage_scrap_credit.destroy
destroy(this.cb_convertbacktoscrap)
destroy(this.cb_print_scrap_credit)
destroy(this.dw_scrap_credit)
end on

type cb_convertbacktoscrap from u_cb within tabpage_scrap_credit
integer x = 1039
integer y = 1213
integer width = 592
integer height = 93
integer taborder = 21
string text = "&Convert Back To Scrap"
end type

event clicked;call super::clicked;Long ll_row, ll_scrap_skid_num, ll_customer_id
Int li_status,  li_rc

String					ls_scrap_handling_type //Alex Gerlants. Scrap Credit
str_all_data_types	lstr_all_data_types //Alex Gerlants. Scrap_Credit

ll_row = tab_skids.tabpage_scrap_credit.dw_scrap_credit.GetRow()
IF ll_row < 1 THEN Return -1
li_status = tab_skids.tabpage_scrap_credit.dw_scrap_credit.GetItemNumber(ll_row, "skid_scrap_status", Primary!, FALSE)
IF li_status = 0 THEN
	MessageBox("Error","Failed to modify this scrap skid because it has been shipped to customer already.", StopSign!)
	RETURN 0
ELSE
	ll_scrap_skid_num = tab_skids.tabpage_scrap_credit.dw_scrap_credit.GetItemNumber(ll_row, "scrap_skid_num", Primary!, FALSE)
END IF

li_rc = MessageBox("Confirmation","Please confirm converting scrap skid #" + String(ll_scrap_skid_num) + " back to customer's scrap skid.", Question!, YesNo!)

//Alex Gerlants. Scrap Credit. Begin
If li_rc = 1 Then //Yes
	ls_scrap_handling_type = tab_skids.tabpage_scrap_credit.dw_scrap_credit.Object.scrap_handling_type[ll_row]
	lstr_all_data_types.string_var[1] = ls_scrap_handling_type
	lstr_all_data_types.long_var[1] = ll_scrap_skid_num
	
	If Lower(ls_scrap_handling_type) = "scrap credit" Then
		li_rc  =  1
		
		//Open window so user can specify what scrap handling type to assign to skid when it comes back scrap skid tab
		OpenWithParm(w_change_scrap_handling_type, lstr_all_data_types)
	
		//Error checking is done in w_change_scrap_type
		lstr_all_data_types = Message.PowerObjectParm
		ls_scrap_handling_type = lstr_all_data_types.string_var[1]
		
		If ls_scrap_handling_type = "cancel" Then //User clicked on "Cancel" in w_change_scrap_handling_type
			li_rc = 0 //Just bail out...exit
		End If
	End If //Alex Gerlants. Scrap Credit
End If
//Alex Gerlants. Scrap Credit. End

if li_rc  =  1 then
	  SELECT CUSTOMER_ORDER.ORIG_CUSTOMER_ID INTO :ll_customer_id
	  FROM CUSTOMER_ORDER, ORDER_ITEM, AB_JOB
	  WHERE CUSTOMER_ORDER.ORDER_ABC_NUM = ORDER_ITEM.ORDER_ABC_NUM
	  AND ORDER_ITEM.ORDER_ABC_NUM = AB_JOB.ORDER_ABC_NUM
	  AND ORDER_ITEM.ORDER_ITEM_NUM = AB_JOB.ORDER_ITEM_NUM
	  AND AB_JOB.AB_JOB_NUM = :il_current_job_num
	  USING SQLCA;
	  
	  //Alex Gerlants. Scrap_Credit. Added ", scrap_handling_type = :ls_scrap_handling_type"
	  UPDATE "SCRAP_SKID"  
     SET "CUSTOMER_ID" = :ll_customer_id, scrap_handling_type = :ls_scrap_handling_type 
     WHERE "SCRAP_SKID"."SCRAP_SKID_NUM" =  :ll_scrap_skid_num  
	  Using SQLCA;
	  IF SQLCA.SQLCode = -1 THEN 
	        MessageBox("SQL error", SQLCA.SQLErrText)
			  rollback using SQLCA;
	  END IF
	  commit using SQLCA;
	  tab_skids.tabpage_scrap.dw_scrap_list.Retrieve(il_current_job_num)
	  tab_skids.tabpage_scrap_credit.dw_scrap_credit.Retrieve(il_current_job_num)
else
	return 0
end if	

RETURN ll_row
end event

type cb_print_scrap_credit from u_cb within tabpage_scrap_credit
integer x = 1946
integer y = 1213
integer width = 351
integer height = 93
integer taborder = 11
string text = "&Print"
end type

event clicked;call super::clicked;tab_skids.tabpage_scrap_credit.dw_scrap_credit.Event pfc_print()
end event

type dw_scrap_credit from u_dw within tabpage_scrap_credit
integer x = 7
integer y = 19
integer width = 3507
integer height = 1085
integer taborder = 11
string dataobject = "d_office_entry_scrap_credit_list"
boolean hscrollbar = true
boolean livescroll = false
end type

event constructor;call super::constructor;of_SetBase(TRUE)
of_SettransObject(SQLCA)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

//this.SetFilter("skid_scrap_status <> 6")
//this.Filter()

end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long li_Row

this.AcceptText()
li_Row = tab_skids.tabpage_scrap_credit.dw_scrap_credit.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

this.ScrollToRow(li_Row)

Return 

end event

event rbuttondown;call super::rbuttondown;//Override
RETURN 0
end event

event rbuttonup;call super::rbuttonup;//Override
RETURN 0
end event

event rowfocuschanged;call super::rowfocuschanged;this.event pfc_rowchanged()
end event

type dw_prod_order_detail from u_dw within w_office_skid_entry
integer x = 870
integer y = 3
integer width = 2706
integer height = 157
integer taborder = 0
string dataobject = "d_office_entry_job_detail"
boolean vscrollbar = false
boolean livescroll = false
end type

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve(il_current_job_num)
end event

event rbuttondown;//Override
Return 0
end event

event rbuttonup;//Override
Return 0
end event

event constructor;call super::constructor;of_SetTransObject(sqlca) 
end event

type cb_close from u_cb within w_office_skid_entry
integer x = 3204
integer y = 1731
integer width = 369
integer height = 80
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type st_title1 from u_st within w_office_skid_entry
integer x = 26
integer width = 805
integer height = 61
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Production Order Number"
alignment alignment = center!
boolean border = true
end type

type st_title# from u_st within w_office_skid_entry
integer x = 26
integer y = 61
integer width = 805
integer height = 99
boolean bringtotop = true
integer textsize = -18
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "100001"
alignment alignment = center!
boolean border = true
end type

type dw_coil_status from u_dw within w_office_skid_entry
integer x = 2970
integer y = 1731
integer width = 40
integer height = 35
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_coil_skid_entry_status"
end type

event constructor;of_SetBase(TRUE)
of_SettransObject(SQLCA)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)

end event

