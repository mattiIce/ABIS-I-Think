$PBExportHeader$w_shipping_2_disabled_buttons.srw
$PBExportComments$<Sheet>w_shipping version 2 inherited from pfemain\w_sheet
forward
global type w_shipping_2_disabled_buttons from w_sheet
end type
type dw_error_message from datawindow within w_shipping_2_disabled_buttons
end type
type cb_1 from commandbutton within w_shipping_2_disabled_buttons
end type
type st_10 from statictext within w_shipping_2_disabled_buttons
end type
type cb_browse from commandbutton within w_shipping_2_disabled_buttons
end type
type cb_save from commandbutton within w_shipping_2_disabled_buttons
end type
type cb_edi from commandbutton within w_shipping_2_disabled_buttons
end type
type cb_new from commandbutton within w_shipping_2_disabled_buttons
end type
type cb_close from commandbutton within w_shipping_2_disabled_buttons
end type
type tab_shiped_items from tab within w_shipping_2_disabled_buttons
end type
type tabpage_sheet_ed from userobject within tab_shiped_items
end type
type dw_sheet_item from u_dw within tabpage_sheet_ed
end type
type st_tswt from u_st within tabpage_sheet_ed
end type
type st_tit from u_st within tabpage_sheet_ed
end type
type st_ti from statictext within tabpage_sheet_ed
end type
type st_tsw from statictext within tabpage_sheet_ed
end type
type st_tp from statictext within tabpage_sheet_ed
end type
type st_tnt from statictext within tabpage_sheet_ed
end type
type cb_addsheet from u_cb within tabpage_sheet_ed
end type
type cb_delsheet from u_cb within tabpage_sheet_ed
end type
type cb_detailsheet from u_cb within tabpage_sheet_ed
end type
type st_4 from statictext within tabpage_sheet_ed
end type
type st_5 from statictext within tabpage_sheet_ed
end type
type tabpage_sheet_ed from userobject within tab_shiped_items
dw_sheet_item dw_sheet_item
st_tswt st_tswt
st_tit st_tit
st_ti st_ti
st_tsw st_tsw
st_tp st_tp
st_tnt st_tnt
cb_addsheet cb_addsheet
cb_delsheet cb_delsheet
cb_detailsheet cb_detailsheet
st_4 st_4
st_5 st_5
end type
type tabpage_scrap_ed from userobject within tab_shiped_items
end type
type st_16 from u_st within tabpage_scrap_ed
end type
type st_3 from statictext within tabpage_scrap_ed
end type
type st_scti from statictext within tabpage_scrap_ed
end type
type st_sctw from statictext within tabpage_scrap_ed
end type
type st_stnt from statictext within tabpage_scrap_ed
end type
type cb_addscrap from u_cb within tabpage_scrap_ed
end type
type cb_delscrap from u_cb within tabpage_scrap_ed
end type
type cb_detailscrap from u_cb within tabpage_scrap_ed
end type
type dw_scrap_item from u_dw within tabpage_scrap_ed
end type
type st_1 from statictext within tabpage_scrap_ed
end type
type tabpage_scrap_ed from userobject within tab_shiped_items
st_16 st_16
st_3 st_3
st_scti st_scti
st_sctw st_sctw
st_stnt st_stnt
cb_addscrap cb_addscrap
cb_delscrap cb_delscrap
cb_detailscrap cb_detailscrap
dw_scrap_item dw_scrap_item
st_1 st_1
end type
type tabpage_rej_coil_ed from userobject within tab_shiped_items
end type
type dw_rej_coil_item from u_dw within tabpage_rej_coil_ed
end type
type st_17 from u_st within tabpage_rej_coil_ed
end type
type st_20 from statictext within tabpage_rej_coil_ed
end type
type st_rti from statictext within tabpage_rej_coil_ed
end type
type st_rtw from statictext within tabpage_rej_coil_ed
end type
type cb_addcoil from u_cb within tabpage_rej_coil_ed
end type
type cb_delcoil from u_cb within tabpage_rej_coil_ed
end type
type cb_detailcoil from u_cb within tabpage_rej_coil_ed
end type
type tabpage_rej_coil_ed from userobject within tab_shiped_items
dw_rej_coil_item dw_rej_coil_item
st_17 st_17
st_20 st_20
st_rti st_rti
st_rtw st_rtw
cb_addcoil cb_addcoil
cb_delcoil cb_delcoil
cb_detailcoil cb_detailcoil
end type
type tabpage_wh_ed from userobject within tab_shiped_items
end type
type st_18 from u_st within tabpage_wh_ed
end type
type st_21 from statictext within tabpage_wh_ed
end type
type st_whti from statictext within tabpage_wh_ed
end type
type st_whtw from statictext within tabpage_wh_ed
end type
type st_whnt from statictext within tabpage_wh_ed
end type
type cb_addwh from u_cb within tabpage_wh_ed
end type
type cb_delwh from u_cb within tabpage_wh_ed
end type
type cb_detailwh from u_cb within tabpage_wh_ed
end type
type dw_wh_item from u_dw within tabpage_wh_ed
end type
type st_6 from statictext within tabpage_wh_ed
end type
type st_9 from statictext within tabpage_wh_ed
end type
type st_whtp from statictext within tabpage_wh_ed
end type
type tabpage_wh_ed from userobject within tab_shiped_items
st_18 st_18
st_21 st_21
st_whti st_whti
st_whtw st_whtw
st_whnt st_whnt
cb_addwh cb_addwh
cb_delwh cb_delwh
cb_detailwh cb_detailwh
dw_wh_item dw_wh_item
st_6 st_6
st_9 st_9
st_whtp st_whtp
end type
type tab_shiped_items from tab within w_shipping_2_disabled_buttons
tabpage_sheet_ed tabpage_sheet_ed
tabpage_scrap_ed tabpage_scrap_ed
tabpage_rej_coil_ed tabpage_rej_coil_ed
tabpage_wh_ed tabpage_wh_ed
end type
type st_19 from u_st within w_shipping_2_disabled_buttons
end type
type st_shipmentwt from u_st within w_shipping_2_disabled_buttons
end type
type cb_print from commandbutton within w_shipping_2_disabled_buttons
end type
type dw_shipment_detail from u_dw within w_shipping_2_disabled_buttons
end type
type st_2 from u_st within w_shipping_2_disabled_buttons
end type
type st_shipmentitem from u_st within w_shipping_2_disabled_buttons
end type
type st_12 from statictext within w_shipping_2_disabled_buttons
end type
type st_ti1 from statictext within w_shipping_2_disabled_buttons
end type
type st_13 from statictext within w_shipping_2_disabled_buttons
end type
type st_scti1 from statictext within w_shipping_2_disabled_buttons
end type
type st_14 from statictext within w_shipping_2_disabled_buttons
end type
type st_rti1 from statictext within w_shipping_2_disabled_buttons
end type
type st_15 from statictext within w_shipping_2_disabled_buttons
end type
type st_whti1 from statictext within w_shipping_2_disabled_buttons
end type
type cb_revise from commandbutton within w_shipping_2_disabled_buttons
end type
type st_7 from statictext within w_shipping_2_disabled_buttons
end type
type st_bol from statictext within w_shipping_2_disabled_buttons
end type
type st_8 from statictext within w_shipping_2_disabled_buttons
end type
type ddlb_packinglist from u_ddlb within w_shipping_2_disabled_buttons
end type
type st_multistop from statictext within w_shipping_2_disabled_buttons
end type
type cb_newstop from commandbutton within w_shipping_2_disabled_buttons
end type
type gb_bol from groupbox within w_shipping_2_disabled_buttons
end type
end forward

global type w_shipping_2_disabled_buttons from w_sheet
string tag = "Shipping "
integer x = 7
integer y = 3
integer width = 3368
integer height = 1920
string title = "Open Shipments Report. Shipment"
string menuname = "m_shipment_shipping"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
event type integer ue_open_shippment ( long ship_id,  long cust_id )
event type integer ue_link_retrieve ( )
event ue_inventory ( )
event ue_canceled ( integer ai_id )
event ue_open ( )
event ue_add_skid ( long al_skid_num )
event ue_add_scrap ( long al_scrap_num )
event ue_add_rejcoil ( long al_coil_num )
event ue_add_wh ( long al_skid )
event type long ue_check_skid ( long al_skid )
event type long ue_check_scrap ( long al_skid )
event type long ue_check_rej_coil ( long al_coil )
event type long ue_check_wh ( long al_skid )
event type integer ue_shipment_sent ( )
event ue_retrieve_rehashed ( long al_shipment )
event type string ue_whoami ( )
event ue_read_only ( )
event type integer ue_reverse ( )
dw_error_message dw_error_message
cb_1 cb_1
st_10 st_10
cb_browse cb_browse
cb_save cb_save
cb_edi cb_edi
cb_new cb_new
cb_close cb_close
tab_shiped_items tab_shiped_items
st_19 st_19
st_shipmentwt st_shipmentwt
cb_print cb_print
dw_shipment_detail dw_shipment_detail
st_2 st_2
st_shipmentitem st_shipmentitem
st_12 st_12
st_ti1 st_ti1
st_13 st_13
st_scti1 st_scti1
st_14 st_14
st_rti1 st_rti1
st_15 st_15
st_whti1 st_whti1
cb_revise cb_revise
st_7 st_7
st_bol st_bol
st_8 st_8
ddlb_packinglist ddlb_packinglist
st_multistop st_multistop
cb_newstop cb_newstop
gb_bol gb_bol
end type
global w_shipping_2_disabled_buttons w_shipping_2_disabled_buttons

type variables
//0 = display mode , 1= create mode
integer ii_display_mode

//0 = no shipment selected
integer ii_ok_add

// right mouse indicator
Boolean ib_down

String is_message="Select an item and use right mouse to drag it"

//item number
Int ii_packing_number

Long il_current_customer
Long il_current_shippment
Long il_bol

//New shipment flag
Boolean ib_new_shipment

//packing ticket
DataStore ids_packing_ticket

Boolean ib_newstop

s_shipinfo istr_shipinfo

//Alex Gerlants. Communication_Code_Error_Message. 11/01/2017. Begin
n_smtp 	in_smtp

//Populated in Open event for w_customer_contact
String	is_from_email //Sender email address
String	is_from_name //Sender name
String	is_server //SMTP server IP address
Integer	ii_port //SMTP port
String	is_send_email //Recipient email address
String	is_send_name //Recipient name
String	is_logfile //Log file where we record SMTP email messages if email fails
String	is_subject //Email subject line
Boolean	ib_debugviewer = False

//String	is_from_email_edi_error //Sender email address
//String	is_from_name_edi_error //Sender name
//String	is_server_edi_error //SMTP server IP address
//Integer	ii_port_edi_error //SMTP port
//String	is_send_email_edi_error //Recipient email address
//String	is_send_name_edi_error //Recipient name
//String	is_logfile_edi_error //Log file where we record SMTP email messages if email fails
//String	is_subject_edi_error //Email subject line
//Boolean	ib_debugviewer_edi_error = False
//Alex Gerlants. Communication_Code_Error_Message. 11/01/2017. End

Boolean	ib_use_customer_website_4shipping //Alex Gerlants. Tesla_Shipping_Message


end variables

forward prototypes
public function integer wf_get_sh_packing_item_number ()
public function integer wf_show_total_wt ()
public function integer wf_shipment_status ()
public function integer wf_shipment_sent ()
public subroutine wf_display_when_done ()
public function integer wf_verify_values ()
public function integer wf_check_readytosent ()
public function integer wf_verify_before_printing ()
public function integer wf_reset_display_info ()
public function boolean wf_check_multi_stop ()
public function integer wf_reset_orig_shipment ()
public subroutine wf_set_non_updatable ()
public subroutine wf_set_updatable ()
public function integer wf_check_shipmentnew ()
public function integer wf_update_skid_notes (datawindow adw_dw)
public subroutine wf_update_edi_triggered (long al_packing_list)
public function boolean wf_edi_sent (n_tr_abc01 at_tran, long al_current_shipment)
public function string wf_get_customer_name (n_tr_abc01 at_tran, long al_current_customer)
public function integer wf_validate ()
public subroutine wf_update_shipment_edi_required (n_tr_abc01 at_tran)
protected function integer wf_equipment_type_standard_validate (n_tr_abc01 at_tran, long al_customer_id, string as_equipment_type_code_user)
public function boolean wf_edi_required (n_tr_abc01 at_tran, long al_current_customer, long al_shipment_enduser_id)
public subroutine wf_delay_asn (n_tr_abc01 atr_tran)
public subroutine wf_get_customer_4shipment (long al_current_shipment, ref long al_customer_id, ref string as_customer_short_name)
public subroutine wf_get_des_sh_cust_4shipment (long al_current_shipment, ref long al_des_sh_cust_id, ref string as_customer_short_name)
public function boolean wf_get_use_customer_website_4shipping (n_tr_abc01 atr, long al_customer_id)
public subroutine wf_display_notice ()
end prototypes

event ue_open_shippment;il_current_shippment = ship_id
il_current_customer = cust_id
ii_display_mode = 0

This.Event ue_link_retrieve()


Return 1
end event

event ue_link_retrieve;SetPointer(HourGlass!)
IF ii_ok_add <> 0 THEN 
	dw_shipment_detail.inv_Linkage.of_Reset()
END IF

dw_shipment_detail.inv_Linkage.of_SetTransObject(sqlca) 
IF dw_shipment_detail.inv_linkage.of_retrieve() = -1 THEN
	SQLCA.of_Rollback()
	MessageBox("Error", "w_shipping::ue_link_retrieve event" )
	Return 0
ELSE
	SQLCA.of_Commit()
	dw_shipment_detail.SetFocus()
	ii_ok_add = 1
	wf_show_total_wt()
	wf_display_when_done()
	wf_check_multi_stop()
	Return 1
End IF

end event

event ue_inventory;IF ii_ok_add < 1 THEN 
	MessageBox("Error", "please open an shipment first!", StopSign! )
	Return
END IF

Int li_status
li_status = wf_shipment_status()
IF li_status < 0 THEN Return
IF li_status = 0 THEN 
	MessageBox("Warning", "This shipment is done, no more new item can be added now!", StopSign!)
	Return
END IF

ii_display_mode = 1
ii_packing_number = 0

Long ll_customer, ll_row
ll_row = dw_shipment_detail.GetRow()
ll_customer = dw_shipment_detail.GetItemNumber(ll_row, "customer_id", Primary!, FALSE)
IF ll_customer < 1 THEN
	MessageBox("Warning", "Select a SOLD TO customer first!", StopSign!)
	RETURN
END IF

CHOOSE CASE tab_shiped_items.SelectedTab
	CASE 1 //skid
		OpenWithParm(w_shipment_skid_select, ll_customer)
	CASE 2 //scrap
		OpenWithParm(w_shipment_scrap_select, ll_customer)		
	CASE 3 //rej coil
		OpenWithParm(w_shipment_rej_coil_select, ll_customer)
	CASE 4 //wh
		OpenWithParm(w_shipment_wh_select, ll_customer)
END CHOOSE




end event

event ue_canceled;call super::ue_canceled;IF il_current_shippment = 0 THEN Close(this)
end event

event ue_open;int li_rc

dw_shipment_detail.AcceptText()
tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.AcceptText()
tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.AcceptText()
tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.AcceptText()
tab_shiped_items.tabpage_wh_ed.dw_wh_item.AcceptText()
IF dw_shipment_detail.inv_Linkage.of_GetUpdatesPending() = 1 THEN
	li_rc = MessageBox("Warning", "This shipment has NOT been saved! Save it now?",Question!, OKCancel!, 2) 	
	CHOOSE CASE li_rc
		CASE 1 //yes
			this.Event pfc_save()
		CASE ELSE
			Return 
	END CHOOSE		
END IF

Close(this)

SetPointer(HourGlass!)
Message.StringParm = "w_shipment_list" 
gnv_app.of_getFrame().Event pfc_open()

end event

event ue_add_skid;tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.Event pfc_addrow()
tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.Event ue_fill_new_row(al_skid_num)
tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.Event pfc_rowchanged()
wf_show_total_wt()
RETURN
end event

event ue_add_scrap;tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.SetTabOrder("scrap_packaging_ticket", 0)
tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.Event pfc_addrow()
tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.Event ue_fill_new_row(al_scrap_num)
tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.Event pfc_rowchanged()
wf_show_total_wt()
tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.SetTabOrder("scrap_packaging_ticket", 10)
RETURN

end event

event ue_add_rejcoil;tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.SetTabOrder("rej_coil_packaging_ticket", 0)
tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.Event pfc_addrow()
tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.Event ue_fill_new_row(al_coil_num)
tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.Event pfc_rowchanged()
wf_show_total_wt()
tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.SetTabOrder("rej_coil_packaging_ticket", 10)
RETURN
end event

event ue_add_wh;tab_shiped_items.tabpage_wh_ed.dw_wh_item.Event pfc_addrow()
tab_shiped_items.tabpage_wh_ed.dw_wh_item.Event ue_fill_new_row(al_skid)
tab_shiped_items.tabpage_wh_ed.dw_wh_item.Event pfc_rowchanged()
wf_show_total_wt()
RETURN

end event

event ue_check_skid;Long ll_row, ll_i, ll_shipment

//The following modification is for getting rid of the delay in skid-adding in shipment
//Victor Huang on 01/08/04
/*
DataStore lds_skid

lds_skid = CREATE DataStore
lds_skid.DataObject = "d_assigned_to_shipment_skid"
lds_skid.SetTransObject(SQLCA)
lds_skid.Retrieve()
ll_row = lds_skid.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		IF lds_skid.GetItemNumber(ll_i, "sheet_packing_item_sheet_skid_num") = al_skid THEN
			ll_shipment = lds_skid.GetItemNumber(ll_i, "sheet_packing_item_Packing_list")
			DESTROY lds_skid
			RETURN ll_shipment
		END IF
	NEXT
END IF
DESTROY lds_skid
*/

SELECT MAX(packing_list) INTO :ll_shipment FROM sheet_packing_item
WHERE sheet_skid_num = :al_skid
USING SQLCA;

IF NOT ISNULL(ll_shipment) THEN
	RETURN ll_shipment
END IF


ll_row = tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		IF tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.GetItemNumber(ll_i, "sheet_skid_num", Primary!, FALSE) = al_skid THEN
			RETURN -1
		END IF
	NEXT
END IF

RETURN 0
end event

event ue_check_scrap;Long ll_row, ll_i, ll_shipment
DataStore lds_skid

lds_skid = CREATE DataStore
lds_skid.DataObject = "d_assigned_to_shipment_scrap"
lds_skid.SetTransObject(SQLCA)
lds_skid.Retrieve()
ll_row = lds_skid.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		IF lds_skid.GetItemNumber(ll_i, "scrap_packing_item_scrap_skid_num") = al_skid THEN
			ll_shipment = lds_skid.GetItemNumber(ll_i, "scrap_packing_item_Packing_list")
			DESTROY lds_skid
			RETURN ll_shipment
		END IF
	NEXT
END IF
DESTROY lds_skid

ll_row = tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		IF tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.GetItemNumber(ll_i, "scrap_skid_num", Primary!, FALSE) = al_skid THEN
			RETURN -1
		END IF
	NEXT
END IF

RETURN 0
end event

event ue_check_rej_coil;Long ll_row, ll_i, ll_shipment
DataStore lds_rejcoil

lds_rejcoil = CREATE DataStore
lds_rejcoil.DataObject = "d_assigned_to_shipment_rejcoil"
lds_rejcoil.SetTransObject(SQLCA)
lds_rejcoil.Retrieve()
ll_row = lds_rejcoil.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		IF lds_rejcoil.GetItemNumber(ll_i, "reject_coil_packing_item_coil_abc_num") = al_coil THEN
			ll_shipment = lds_rejcoil.GetItemNumber(ll_i, "reject_coil_packing_item_Packing_list")
			DESTROY lds_rejcoil
			RETURN ll_shipment
		END IF
	NEXT
END IF
DESTROY lds_rejcoil

ll_row = tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		IF tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.GetItemNumber(ll_i, "coil_abc_num", Primary!, FALSE) = al_coil THEN
			RETURN -1
		END IF
	NEXT
END IF

RETURN 0
end event

event ue_check_wh;Long  ll_row, ll_i, ll_shipment
DataStore lds_skid

lds_skid = CREATE DataStore
lds_skid.DataObject = "d_assigned_to_shipment_skid"
lds_skid.SetTransObject(SQLCA)
lds_skid.Retrieve()
ll_row = lds_skid.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		IF lds_skid.GetItemNumber(ll_i, "sheet_packing_item_sheet_skid_num") = al_skid THEN
			ll_shipment = lds_skid.GetItemNumber(ll_i, "sheet_packing_item_Packing_list")
			DESTROY lds_skid
			RETURN ll_shipment
		END IF
	NEXT
END IF
DESTROY lds_skid

ll_row = tab_shiped_items.tabpage_wh_ed.dw_wh_item.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		IF tab_shiped_items.tabpage_wh_ed.dw_wh_item.GetItemNumber(ll_i, "sheet_skid_num", Primary!, FALSE) = al_skid THEN
			RETURN -1
		END IF
	NEXT
END IF

RETURN 0
end event

event type integer ue_shipment_sent();SetPointer(HourGlass!)

Long ll_row, ll_skid
integer li_row, li_totalrow, li_int, li_rc
String ls_packing_ticket
//Boolean	lb_edi_required, lb_edi_sent //Alex Gerlants, 11/28/2016
//Integer	ll_answer //Alex Gerlants, 11/28/2016
//String	ls_customer_name //Alex Gerlants, 11/28/2016
//Long		ll_des_sh_cust_id //Alex Gerlants, 11/28/2016

ll_row = dw_shipment_detail.GetRow()
IF ll_row <= 0 THEN Return -1
dw_shipment_detail.SetItem(ll_row, "shipment_status", 0 )
dw_shipment_detail.SetItem(ll_row, "vehicle_status", 0 )
//dw_shipment_detail.SetItem(ll_row, "shipment_actualed_date_time", Today() )

//sheet skid
li_totalrow = tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.RowCount()
IF li_totalrow > 0 THEN 
	FOR li_int = 1 TO li_totalrow
		ll_skid = tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.GetItemNumber( li_int, "sheet_skid_num", Primary!, FALSE)
		CONNECT USING SQLCA;
		UPDATE sheet_skid 
		SET Skid_sheet_status = 0
		WHERE sheet_skid_num = :ll_skid
		USING SQLCA;
	NEXT
END IF

// warehouse items
li_totalrow = 0
li_totalrow = tab_shiped_items.tabpage_wh_ed.dw_wh_item.RowCount()
IF li_totalrow > 0 THEN 
	FOR li_int = 1 TO li_totalrow
		ll_skid = tab_shiped_items.tabpage_wh_ed.dw_wh_item.GetItemNumber( li_int, "sheet_skid_num", Primary!, FALSE)
		CONNECT USING SQLCA;
		UPDATE sheet_skid 
		SET Skid_sheet_status = 0
		WHERE sheet_skid_num = :ll_skid
		USING SQLCA;
	NEXT
END IF

//Scrap
li_totalrow = 0
li_totalrow = tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.RowCount()
IF li_totalrow > 0 THEN 
	FOR li_int = 1 TO li_totalrow
		ll_skid = tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.GetItemNumber(li_int, "scrap_skid_num", Primary!, TRUE)
		CONNECT USING SQLCA;
		UPDATE Scrap_skid 
		SET skid_scrap_status = 0
		WHERE scrap_skid_num = :ll_skid
		USING SQLCA;
	NEXT
END IF

//rej coil
li_totalrow = 0
li_totalrow = tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.RowCount()
IF li_totalrow > 0 THEN 
	FOR li_int = 1 TO li_totalrow
		ll_skid = tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.GetItemNumber(li_int, "coil_abc_num", Primary!, FALSE)
		CONNECT USING SQLCA;
		UPDATE coil
		SET coil_status = 10
		WHERE coil_abc_num = :ll_skid
		USING SQLCA;
	NEXT
END IF

li_rc = dw_shipment_detail.Update()
IF li_rc = 1 AND SQLCA.SQLNRows > 0 THEN
	
	//Alex Gerlants. 04/05/2016. Begin
	//Update production_sheet_item.prod_item_note for each skid
	//wf_update_skid_note() doesn't error out if DB error
	wf_update_skid_notes(tab_shiped_items.tabpage_sheet_ed.dw_sheet_item)
	
	//Disable column notes
	tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.Modify("notes.tabsequence = '0'")
	tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.Modify("notes.pointer = 'Arrow!'")
	tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.Modify("notes.Background.Color = '67108864'") //Button face color
	//Alex Gerlants. 04/05/2016. End
	
	COMMIT USING SQLCA;
	wf_display_when_done()
	
	wf_display_notice() //Alex Gerlants. Tesla_Shipping_Message
	
//	//Alex Gerlants, 11/28/2016. Begin
//	//Shipment is done. Push EDI button now if customer requires EDI
//	ll_des_sh_cust_id = dw_shipment_detail.Object.des_sh_cust_id[dw_shipment_detail.GetRow()]
//	lb_edi_required = wf_edi_required(sqlca, il_current_customer)
//	
//	If lb_edi_required Then //Customer requires EDI
//		lb_edi_sent = wf_edi_sent(sqlca, il_current_shippment)
//		
//		If Not lb_edi_sent Then
//			ll_answer = MessageBox("Please confirm", &
//									"Ready to click on 'ASN All' button." + &
//									"~n~rIs this OK?", &
//									Question!, YesNo!, 2)
//			
//			If ll_answer = 1 Then //OK to click on EDI button
//				cb_1.Event Clicked()
//			End If
//		Else
//			ls_customer_name = wf_get_customer_name(sqlca, il_current_customer)
//			
//			ll_answer = MessageBox("EDI already sent", &
//									"EDI already sent for customer " + ls_customer_name + &
//									" and shipment " + String(il_current_shippment) + &
//									"~n~r~n~rWould you like to send EDI again?", &
//									Question!, YesNo!, 2)
//				
//			If ll_answer = 1 Then //OK to send EDI again
//			
//				ll_answer = MessageBox("Please confirm", &
//									"Ready to click on 'ASN All' button." + &
//									"~n~rIs this OK?", &
//									Question!, YesNo!, 2)
//				
//				If ll_answer = 1 Then //OK to click on EDI button
//					cb_1.Event Clicked()
//				End If
//			End If
//		End If
//	End If
//	//Alex Gerlants, 11/28/2016. End
ELSE
	ROLLBACK USING SQLCA;
END IF

RETURN 1
end event

event ue_retrieve_rehashed;Int li_status
li_status = wf_shipment_status()
IF al_shipment <> il_current_shippment THEN RETURN
this.Event ue_link_retrieve()


end event

event type string ue_whoami();//RETURN "w_shipping_2"

RETURN "w_shipping_2" + This.Title //Alex Gerlants. 05/20/2016
end event

event ue_read_only();cb_save.Enabled = FALSE
cb_edi.Enabled = FALSE
cb_new.Enabled = FALSE
cb_newstop.Enabled = FALSE

dw_shipment_detail.Object.DataWindow.ReadOnly = "YES"
tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.Object.DataWindow.ReadOnly = "YES"
tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.Object.DataWindow.ReadOnly = "YES"
tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.Object.DataWindow.ReadOnly = "YES"
tab_shiped_items.tabpage_wh_ed.dw_wh_item.Object.DataWindow.ReadOnly = "YES"

m_shipment_shipping.m_file.m_new.Disable()
m_shipment_shipping.m_file.m_save.Disable()


end event

event type integer ue_reverse();Long ll_row, ll_skid
integer li_row, li_totalrow, li_int, li_rc
Int li_status
String ls_packing_ticket
String ls_message
DateTime ld_1
Long ll_system_log
Int li_coilstatus
//Int li_skid_pc
//Int li_skidstatus

ll_row = dw_shipment_detail.Getrow()
IF ll_row < 1 THEN RETURN 0
li_status = dw_shipment_detail.GetItemNumber(ll_row, "shipment_status", Primary!, TRUE)
IF li_status <> 0 THEN
	MessageBox("Warning", "Shipment can not be revised because it is not gone yet.")
	RETURN 0
END IF
IF MessageBox("Question", "Reversing current shipment, are you sure?", Question!, YESNO!) <> 1 THEN RETURN -1

SetPointer(HourGlass!)
ls_message = "Shipment# " + String(il_current_shippment, "########") + " by " + gnv_app.of_GetUserId() + " @" + String(Today(), "mm-dd-yyyy HH:MM.")

//sheet skid
li_totalrow = tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.RowCount()
IF li_totalrow > 0 THEN 
	ls_message = ls_message + " " + String(li_totalrow, "####") + " Skid: "
	FOR li_int = 1 TO li_totalrow
		ll_skid = tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.GetItemNumber(li_int, "sheet_skid_num", Primary!, FALSE)
	//	li_skid_pc = tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.GetItemNumber(li_int, "sheet_pieces", Primary!, FALSE)
	//	IF li_skid_pc = 1 then
	//		CONNECT USING SQLCA;
	//		UPDATE sheet_skid 
	//		SET Skid_sheet_status = 12
	//		WHERE sheet_skid_num = :ll_skid
	//		USING SQLCA;
	//	else
	//		CONNECT USING SQLCA;
	//		UPDATE sheet_skid 
	//		SET Skid_sheet_status = 2
	//		WHERE sheet_skid_num = :ll_skid
	//		USING SQLCA;
	//	end if
		
		CONNECT USING SQLCA;
		UPDATE sheet_skid 
		SET Skid_sheet_status = 2
		WHERE sheet_skid_num = :ll_skid
		USING SQLCA;
		IF SQLCA.SQLNRows > 0 THEN
			//COMMIT USING SQLCA;
			ls_message = ls_message + " #" + String(ll_skid, "########") + ", "
		ELSE
			MessageBox("Error", "Reverse failed at skid table!", StopSign!)
			ROLLBACK USING SQLCA;
			RETURN -1
		END IF
	NEXT
END IF

// warehouse items
li_totalrow = 0
li_totalrow = tab_shiped_items.tabpage_wh_ed.dw_wh_item.RowCount()
IF li_totalrow > 0 THEN 
	ls_message = ls_message + " and " + String(li_totalrow, "####") + " Warehouse skid: "
	FOR li_int = 1 TO li_totalrow
		ll_skid = tab_shiped_items.tabpage_wh_ed.dw_wh_item.GetItemNumber(li_int, "sheet_skid_num", Primary!, FALSE)
		CONNECT USING SQLCA;
		UPDATE sheet_skid 
		SET Skid_sheet_status = 8   //wh-ready
		WHERE sheet_skid_num = :ll_skid
		USING SQLCA;
		IF SQLCA.SQLNRows > 0 THEN
			//COMMIT USING SQLCA;
			ls_message = ls_message + " #" + String(ll_skid, "########") + ", "
		ELSE
			MessageBox("Error", "Reverse failed at skid table!", StopSign!)
			ROLLBACK USING SQLCA;
			RETURN -2
		END IF
	NEXT
END IF

//Scrap
li_totalrow = 0
li_totalrow = tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.RowCount()
IF li_totalrow > 0 THEN 
	ls_message = ls_message + " and " + String(li_totalrow, "####") + " scrap skid: "
	FOR li_int = 1 TO li_totalrow
		ll_skid = tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.GetItemNumber(li_int, "scrap_skid_num", Primary!, TRUE)
		CONNECT USING SQLCA;
		UPDATE Scrap_skid 
		SET skid_scrap_status = 2
		WHERE scrap_skid_num = :ll_skid
		USING SQLCA;
		IF SQLCA.SQLNRows > 0 THEN
			//COMMIT USING SQLCA;
			ls_message = ls_message + " #" + String(ll_skid, "######")
		ELSE
			MessageBox("Error", "Reverse failed at scrap table!", StopSign!)
			ROLLBACK USING SQLCA;
			RETURN -3
		END IF	
	NEXT
END IF

//rej coil
li_totalrow = 0
li_totalrow = tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.RowCount()
IF li_totalrow > 0 THEN 
	ls_message = ls_message + " and " + String(li_totalrow, "####") + " coils: "
	FOR li_int = 1 TO li_totalrow
		ll_skid = tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.GetItemNumber(li_int, "coil_abc_num", Primary!, FALSE)
		
		CONNECT USING SQLCA;
		SELECT reject_coil_status INTO :li_coilstatus
		FROM reject_coil
		WHERE coil_abc_num = :ll_skid
		USING SQLCA;
		
		UPDATE coil
		SET coil_status = :li_coilstatus
		WHERE coil_abc_num = :ll_skid
		USING SQLCA;
		IF SQLCA.SQLNRows > 0 THEN
			//COMMIT USING SQLCA;
		ELSE
			MessageBox("Error", "Reverse failed at coil table!", StopSign!)
			ROLLBACK USING SQLCA;
			RETURN -4
		END IF	
		
		IF SQLCA.SQLNRows > 0 THEN
			//COMMIT USING SQLCA;
			ls_message = ls_message + " #" + String(ll_skid, "######")
		ELSE
			MessageBox("Error", "Reverse failed at rejected coil table!", StopSign!)
			ROLLBACK USING SQLCA;
			RETURN -5
		END IF	
	NEXT
END IF

//shipment info
ll_row = dw_shipment_detail.GetRow()
IF ll_row <= 0 THEN Return -1
ld_1 = dw_shipment_detail.GetItemDateTime(ll_row,"shipment_actualed_date_time")
ls_message = ls_message + ". actualed=" + String(ld_1, "mm-dd-yyyy HH:MM")
ld_1 = dw_shipment_detail.GetItemDateTime(ll_row,"shipment_des_edi856_date")
ls_message = ls_message + ". des_edi856_date=" + String(ld_1, "mm-dd-yyyy HH:MM")
ld_1 = dw_shipment_detail.GetItemDateTime(ll_row,"shipment_edi856_date")
ls_message = ls_message + ".edi856_date=" + String(ld_1, "mm-dd-yyyy HH:MM")
SetNULL(ld_1)
dw_shipment_detail.SetItem(ll_row, "shipment_status", 2 )
dw_shipment_detail.SetItem(ll_row, "vehicle_status", 2 )
dw_shipment_detail.SetItem(ll_row, "shipment_actualed_date_time", ld_1 )
dw_shipment_detail.SetItem(ll_row, "shipment_des_edi856_date", ld_1 )
dw_shipment_detail.SetItem(ll_row, "shipment_edi856_date", ld_1 )

//Alex Gerlants. 01/08/2018. f_edi_desadv_bolt updates this column. Thus when reversing shipment, set NULL to this column.
dw_shipment_detail.SetItem(ll_row, "shipment_desadv_date", ld_1 )

li_rc = dw_shipment_detail.Update()
IF li_rc = 1 AND SQLCA.SQLNRows > 0 THEN
	COMMIT USING SQLCA;
ELSE
	MessageBox("Error", "Reverse failed at shipment table!", StopSign!)
	ROLLBACK USING SQLCA;
	RETURN -7
END IF

MessageBox("Reverse success", ls_message)
f_add_system_log(ls_message)
this.Event ue_retrieve_rehashed(il_current_shippment)

RETURN 1

end event

public function integer wf_get_sh_packing_item_number ();SetPointer(HourGlass!)

Integer li_items, li_int, li_max, li_cur
tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.AcceptText()
tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.AcceptText()
tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.AcceptText()
tab_shiped_items.tabpage_wh_ed.dw_wh_item.AcceptText()

li_items = 0
li_max = 0
li_items = tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.RowCount()
IF li_items > 0 THEN
	FOR li_int = 1 TO li_items
		li_cur = tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.GetItemNumber(li_int, "sh_packing_item", Primary!, FALSE)
		IF li_cur > li_max THEN li_max = li_cur
	NEXT
END IF
li_items = tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.RowCount()
IF li_items > 0 THEN
	FOR li_int = 1 TO li_items
		li_cur = tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.GetItemNumber(li_int, "sc_packing_item", Primary!, FALSE)
		IF li_cur > li_max THEN li_max = li_cur
	NEXT
END IF
li_items = tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.RowCount()
IF li_items > 0 THEN
	FOR li_int = 1 TO li_items
		li_cur = tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.GetItemNumber(li_int, "rej_coil_packing_item", Primary!, FALSE)
		IF li_cur > li_max THEN li_max = li_cur
	NEXT
END IF
li_items = tab_shiped_items.tabpage_wh_ed.dw_wh_item.RowCount()
IF li_items > 0 THEN
	FOR li_int = 1 TO li_items
		li_cur = tab_shiped_items.tabpage_wh_ed.dw_wh_item.GetItemNumber(li_int, "sh_packing_item", Primary!, FALSE)
		IF li_cur > li_max THEN li_max = li_cur
	NEXT
END IF

Return (li_max + 1)
end function

public function integer wf_show_total_wt ();integer li_row, li_totalrow, li_int
Long ll_skid_num, ll_total_wt, ll_nwt, ll_twt, ll_shipment_wt, ll_sitem, ll_tnt, ll_tp, ll_p

ll_shipment_wt = 0
ll_sitem = 0

//sheet skid
li_totalrow = tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.RowCount()
tab_shiped_items.tabpage_sheet_ed.st_ti.Text = String(li_totalrow)
st_ti1.Text = String(li_totalrow)
ll_sitem = ll_sitem + li_totalrow 
ll_total_wt = 0
ll_tnt = 0
ll_tp = 0
IF li_totalrow > 0 THEN 
	FOR li_int = 1 TO li_totalrow
		ll_nwt = 0
		ll_twt = 0
		ll_p = 0
		ll_skid_num = tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.GetItemNumber( li_int, "sheet_skid_num", Primary!, FALSE)
		
		SELECT sheet_net_wt, sheet_tare_wt, skid_pieces
		INTO :ll_nwt, :ll_twt, :ll_p
		FROM sheet_skid
		WHERE sheet_skid_num = :ll_skid_num
		USING SQLCA;
		
		ll_total_wt = ll_total_wt + ll_nwt + ll_twt
		ll_tp = ll_tp + ll_p
		ll_tnt = ll_tnt + ll_nwt
	NEXT
END IF
tab_shiped_items.tabpage_sheet_ed.st_tsw.Text = String(ll_total_wt, "###,###,###")+ " lbs"	
tab_shiped_items.tabpage_sheet_ed.st_tnt.Text = String(ll_tnt, "###,###,###")+ " lbs"	
tab_shiped_items.tabpage_sheet_ed.st_tp.Text = String(ll_tp, "###,###,###")

ll_shipment_wt = ll_shipment_wt + ll_total_wt

// warehouse items
li_totalrow = 0
li_totalrow = tab_shiped_items.tabpage_wh_ed.dw_wh_item.RowCount()
tab_shiped_items.tabpage_wh_ed.st_whti.Text = String(li_totalrow)
st_whti1.Text = String(li_totalrow)
ll_sitem = ll_sitem + li_totalrow 
ll_total_wt = 0
ll_tnt = 0
ll_tp = 0
IF li_totalrow > 0 THEN 
	FOR li_int = 1 TO li_totalrow
		ll_nwt = 0
		ll_twt = 0
		
		ll_p = 0
		ll_skid_num = tab_shiped_items.tabpage_wh_ed.dw_wh_item.GetItemNumber( li_int, "sheet_skid_num", Primary!, FALSE)
		
		SELECT sheet_net_wt, sheet_tare_wt, skid_pieces
		INTO :ll_nwt, :ll_twt, :ll_p
		FROM sheet_skid
		WHERE sheet_skid_num = :ll_skid_num
		USING SQLCA;
		
		ll_total_wt = ll_total_wt + ll_nwt + ll_twt
		ll_tp = ll_tp + ll_p
		ll_tnt = ll_tnt + ll_nwt
	NEXT
END IF
tab_shiped_items.tabpage_wh_ed.st_whtw.Text = String(ll_total_wt, "###,###,###")+ " lbs"	
tab_shiped_items.tabpage_wh_ed.st_whnt.Text = String(ll_tnt, "###,###,###")+ " lbs"	
tab_shiped_items.tabpage_wh_ed.st_whtp.Text = String(ll_tp, "###,###,###")

ll_shipment_wt = ll_shipment_wt + ll_total_wt

//Scrap
li_totalrow = 0
li_totalrow = tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.RowCount()
tab_shiped_items.tabpage_scrap_ed.st_scti.Text = String(li_totalrow)
st_scti1.Text = String(li_totalrow)
ll_sitem = ll_sitem + li_totalrow 
ll_total_wt = 0
ll_tnt = 0
ll_tp = 0
IF li_totalrow > 0 THEN 
	FOR li_int = 1 TO li_totalrow
		ll_nwt = 0
		ll_twt = 0
		ll_nwt = tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.GetItemNumber(li_int, "scrap_skid_scrap_net_wt", Primary!, FALSE)
		ll_twt = tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.GetItemNumber(li_int, "scrap_skid_scrap_tare_wt", Primary!, FALSE)
		IF IsNULL(ll_twt) THEN ll_twt = 0
		ll_total_wt = ll_total_wt + ll_nwt + ll_twt
		ll_tnt = ll_tnt + ll_nwt
	NEXT
END IF
tab_shiped_items.tabpage_scrap_ed.st_sctw.Text = String(ll_total_wt, "###,###,###")+ " lbs"	
tab_shiped_items.tabpage_scrap_ed.st_stnt.Text = String(ll_tnt, "###,###,###")+ " lbs"	

ll_shipment_wt = ll_shipment_wt + ll_total_wt

//rej coil
li_totalrow = 0
li_totalrow = tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.RowCount()
tab_shiped_items.tabpage_rej_coil_ed.st_rti.Text = String(li_totalrow)
st_rti1.Text = String(li_totalrow)
ll_sitem = ll_sitem + li_totalrow 
ll_total_wt = 0
ll_tnt = 0
ll_tp = 0
IF li_totalrow > 0 THEN 
	FOR li_int = 1 TO li_totalrow
		ll_nwt = 0
		ll_nwt = tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.GetItemNumber(li_int, "coil_net_wt_balance", Primary!, FALSE)
		IF IsNULL(ll_nwt) THEN ll_nwt = 0
		ll_total_wt = ll_total_wt + ll_nwt 
	NEXT
END IF
tab_shiped_items.tabpage_rej_coil_ed.st_rtw.Text = String(ll_total_wt, "###,###,###")+ " lbs"	

ll_shipment_wt = ll_shipment_wt + ll_total_wt

st_shipmentitem.Text = String(ll_sitem, "###,###" )
st_shipmentwt.Text =String(ll_shipment_wt, "###,###,###") + " lbs"

dw_shipment_detail.Event ue_fix_soldto(ll_shipment_wt)

Return 1
end function

public function integer wf_shipment_status ();Int li_row, li_status

li_row = dw_shipment_detail.GetRow()
IF li_row <= 0 THEN 
	MessageBox("Error", "InValid shipment information", StopSign! )
	Return -1
END IF

li_status = dw_shipment_detail.GetItemNumber(li_row,"shipment_status", Primary!, FALSE)

Return li_status

end function

public function integer wf_shipment_sent ();SetPointer(HourGlass!)
integer li_row, li_totalrow, li_int
Long ll_skid
String ls_packing_ticket

//sheet skid
li_totalrow = tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.RowCount()
IF li_totalrow > 0 THEN 
	FOR li_int = 1 TO li_totalrow
		ll_skid = tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.GetItemNumber( li_int, "sheet_skid_num", Primary!, FALSE)
		CONNECT USING SQLCA;
		UPDATE sheet_skid 
		SET Skid_sheet_status = 0
		WHERE sheet_skid_num = :ll_skid
		USING SQLCA;
		IF f_check_sqlcode(SQLCA, TRUE, TRUE) < 0 THEN RETURN -1
	NEXT
END IF

// warehouse items
li_totalrow = 0
li_totalrow = tab_shiped_items.tabpage_wh_ed.dw_wh_item.RowCount()
IF li_totalrow > 0 THEN 
	FOR li_int = 1 TO li_totalrow
		ll_skid = tab_shiped_items.tabpage_wh_ed.dw_wh_item.GetItemNumber( li_int, "sheet_skid_num", Primary!, FALSE)
		CONNECT USING SQLCA;
		UPDATE sheet_skid 
		SET Skid_sheet_status = 0
		WHERE sheet_skid_num = :ll_skid
		USING SQLCA;
		IF f_check_sqlcode(SQLCA, TRUE, TRUE) < 0 THEN RETURN -1
	NEXT
END IF

//Scrap
li_totalrow = 0
li_totalrow = tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.RowCount()
IF li_totalrow > 0 THEN 
	FOR li_int = 1 TO li_totalrow
		ll_skid = tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.GetItemNumber(li_int, "scrap_skid_num", Primary!, TRUE)
		CONNECT USING SQLCA;
		UPDATE Scrap_skid 
		SET skid_scrap_status = 0
		WHERE scrap_skid_num = :ll_skid
		USING SQLCA;
		IF f_check_sqlcode(SQLCA, TRUE, TRUE) < 0 THEN RETURN -3
	NEXT
END IF

//rej coil
li_totalrow = 0
li_totalrow = tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.RowCount()
IF li_totalrow > 0 THEN 
	FOR li_int = 1 TO li_totalrow
		ll_skid = tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.GetItemNumber(li_int, "coil_abc_num", Primary!, FALSE)
		CONNECT USING SQLCA;
		UPDATE coil
		SET coil_status = 10
		WHERE coil_abc_num = :ll_skid
		USING SQLCA;
		IF f_check_sqlcode(SQLCA, TRUE, TRUE) < 0 THEN RETURN -4
	NEXT
END IF

Return 1
end function

public subroutine wf_display_when_done ();//when a shipment is done information are display only except shipment_notes
Long ll_row
Int li_status

ll_row = dw_shipment_detail.GetRow()
IF ll_row < 1 THEN Return
li_status = dw_shipment_detail.GetItemNumber(ll_row, "shipment_status", Primary!, FALSE)
IF li_status = 0 THEN
	//display only
	dw_shipment_detail.SetTabOrder("shipment_status", 0)
	dw_shipment_detail.SetTabOrder("des_sh_cust_id", 0)
	dw_shipment_detail.SetTabOrder("customer_id", 0)
	dw_shipment_detail.SetTabOrder("shipment_scheduled_date_time", 0)
	dw_shipment_detail.SetTabOrder("vehicle_id", 0)
	dw_shipment_detail.SetTabOrder("vehicle_status", 0)
	dw_shipment_detail.SetTabOrder("shipment_actualed_date_time", 0)
	dw_shipment_detail.SetTabOrder("shipment_notes", 0)
	dw_shipment_detail.SetTabOrder("carrier_id", 0)
	dw_shipment_detail.SetTabOrder("carrier_initial", 0)
	dw_shipment_detail.SetTabOrder("carrier_description_code", 0)
	dw_shipment_detail.SetTabOrder("transportation_method_code", 0)
	dw_shipment_detail.SetTabOrder("shipment_enduser_id", 0)
	dw_shipment_detail.SetTabOrder("shipment_athorization_code", 0)
	dw_shipment_detail.SetTabOrder("vehicle_id_prefix", 0)
	dw_shipment_detail.SetTabOrder("scrap_sales_order_num", 0)
	
	dw_shipment_detail.SetTabOrder("equipment_type", 0) //Alex Gerlants. 07/12/2016
	
	tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.SetTabOrder("scrap_packaging_ticket", 0)
	tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.SetTabOrder("rej_coil_packaging_ticket", 0)

ELSE
	//editable
	dw_shipment_detail.SetTabOrder("shipment_status", 10)
	dw_shipment_detail.SetTabOrder("des_sh_cust_id", 20)
	dw_shipment_detail.SetTabOrder("shipment_athorization_code", 30)
	dw_shipment_detail.SetTabOrder("customer_id", 40)
	dw_shipment_detail.SetTabOrder("shipment_scheduled_date_time", 50)
	dw_shipment_detail.SetTabOrder("shipment_enduser_id", 60)
	dw_shipment_detail.SetTabOrder("shipment_actualed_date_time", 70)
	dw_shipment_detail.SetTabOrder("shipment_notes", 80)
	dw_shipment_detail.SetTabOrder("vehicle_status", 90)
	dw_shipment_detail.SetTabOrder("carrier_id", 100)
	dw_shipment_detail.SetTabOrder("carrier_initial", 110)
	dw_shipment_detail.SetTabOrder("vehicle_id_prefix", 120)
	dw_shipment_detail.SetTabOrder("vehicle_id", 130)
	dw_shipment_detail.SetTabOrder("carrier_description_code", 140)
	dw_shipment_detail.SetTabOrder("transportation_method_code", 150)
	dw_shipment_detail.SetTabOrder("scrap_sales_order_num", 160)
	
	dw_shipment_detail.SetTabOrder("equipment_type", 170) //Alex Gerlants. 07/12/2016

	tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.SetTabOrder("scrap_packaging_ticket", 10)
	tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.SetTabOrder("rej_coil_packaging_ticket", 10)

END IF	



end subroutine

public function integer wf_verify_values ();String ls_vehicle_id, ls_car_init, ls_car_desc_code
Long ll_carrier_id
Int li_items, li_status

CONNECT USING SQLCA;
SELECT vehicle_id, carrier_initial, carrier_description_code, carrier_id, shipment_status
INTO :ls_vehicle_id, :ls_car_init, :ls_car_desc_code, :ll_carrier_id, :li_status
FROM Shipment
WHERE packing_list = :il_current_shippment
USING SQLCA;

IF (Len(ls_vehicle_id) < 2)  OR IsNULL(ls_vehicle_id) THEN
	MessageBox("Warning", "Invalid vehicle ID!", StopSign! )
	Return -1
END IF
IF (Len(ls_car_init) <= 1) OR IsNULL(ls_car_init) THEN
	MessageBox("Warning", "Invalid carier initial!", StopSign! )
	Return -2
END IF
IF (Len(ls_car_desc_code) < 2) OR IsNULL(ls_car_desc_code) THEN
	MessageBox("Warning", "Invalid carrier description code!", StopSign! )
	Return -3
END IF
IF (ll_carrier_id <= 0) OR IsNULL(ll_carrier_id) THEN
	MessageBox("Warning", "Invalid carrier ID!", StopSign! )
	Return -4
END IF
IF li_status <> 0 THEN
	MessageBox("Warning", "EDI can only be created when this shipment's status is DONE.", StopSign! )
	Return -5
END IF

li_items = 0
li_items = li_items + tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.RowCount()
li_items = li_items + tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.RowCount()
li_items = li_items + tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.RowCount()
li_items = li_items + tab_shiped_items.tabpage_wh_ed.dw_wh_item.RowCount()
IF li_items < 1 THEN
	MessageBox("Warning", "Shipment contains no items!", StopSign! )
	Return -6
END IF

Return 1
end function

public function integer wf_check_readytosent ();Long ll_row, ll_item
String ls_item

Integer	li_rtn //Alex Gerlants. 12/06/2016
String	ls_equipment_type_code_user //Alex Gerlants. 12/06/2016

ll_row = dw_shipment_detail.GetRow()
IF ll_row <= 0 THEN Return -1

//Alex Gerlants. 12/06/2016. Begin
li_rtn = wf_validate()

If li_rtn = -1 Then
	Return -7
End If

ls_equipment_type_code_user = dw_shipment_detail.Object.equipment_type[ll_row]

li_rtn = wf_equipment_type_standard_validate(sqlca, il_current_customer, ls_equipment_type_code_user)

If li_rtn = -1 Then
	Return -8
End If
//Alex Gerlants. 12/06/2016. End

ll_item = dw_shipment_detail.GetItemNumber(ll_row, "carrier_id", Primary!, FALSE)
IF ll_item < 1 THEN 
	MessageBox("Error", "Invalid carrier name!")
	RETURN -2
END IF
ls_item = dw_shipment_detail.GetItemString(ll_row, "carrier_initial", Primary!, FALSE)
IF Len(ls_item) < 2 THEN 
	MessageBox("Error", "Invalid driver initial!")
	RETURN -3
END IF

ls_item = dw_shipment_detail.GetItemString(ll_row, "Vehicle_id", Primary!, FALSE)
IF Len(ls_item) < 2 THEN 
	MessageBox("Error", "Invalid vehicle number!")
	RETURN -4
END IF

ls_item = dw_shipment_detail.GetItemString(ll_row, "carrier_description_code", Primary!, FALSE)
IF Len(ls_item) < 2 THEN 
	MessageBox("Error", "Invalid description code!")
	RETURN -5
END IF
ls_item = dw_shipment_detail.GetItemString(ll_row, "transportation_method_code", Primary!, FALSE)
IF Len(ls_item) < 2 THEN 
	MessageBox("Error", "Invalid transportation method code!")
	RETURN -6
END IF

Datetime ldt_shipped_date
Int li_rc
ldt_shipped_date = dw_shipment_detail.GetItemDateTime(ll_row, "shipment_actualed_date_time", Primary!, FALSE)
IF isnull(ldt_shipped_date) THEN 	 
	li_rc = MessageBox("Shipped Date Missing", "Do you want to set the current system datetime as the shipped date?", Question!, YesNo!)
	if li_rc = 1 then
		dw_shipment_detail.SetItem(ll_row, "shipment_actualed_date_time", today())
	end if
END IF

Long ll_skidnum, ll_scrapnum, ll_whnum
String ls_novelisid
Long ll_soldto
//Novelis SAP Code only available when shipping to endusers
ls_item = dw_shipment_detail.GetItemString(ll_row, "shipment_athorization_code", Primary!, FALSE)
ll_soldto = dw_shipment_detail.GetItemNumber(ll_row, "customer_id", Primary!, FALSE)
ll_skidnum = tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.RowCount()
ll_scrapnum = tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.RowCount()
ll_whnum = tab_shiped_items.tabpage_wh_ed.dw_wh_item.RowCount()
IF (ll_skidnum > 0) OR (ll_scrapnum > 0) OR (ll_whnum > 0) THEN
	SELECT system_option_value INTO :ls_novelisid
	FROM system_options
	WHERE system_option_name = 'Novelis SAP ID'
	USING SQLCA;
	IF Pos(ls_novelisid, ','+String(ll_soldto)+',') > 0 THEN//existing in the list
		IF Len(ls_item) < 2 OR ISNULL(ls_item) THEN 
			li_rc = MessageBox("Authorization Code Missing", "Do you want to save the current shipment without Authorization Code?", Question!, YesNo!)
			if li_rc <> 1 then
				RETURN -8
			end if
		END IF
	END IF
END IF

RETURN 1
end function

public function integer wf_verify_before_printing ();Int li_items 
li_items = 0
li_items = li_items + tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.RowCount()
li_items = li_items + tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.RowCount()
li_items = li_items + tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.RowCount()
li_items = li_items + tab_shiped_items.tabpage_wh_ed.dw_wh_item.RowCount()
IF li_items < 1 THEN
	MessageBox("Warning", "Shipment contains no items!", StopSign! )
	Return -1
END IF

Return 1
end function

public function integer wf_reset_display_info ();st_ti1.Text = "0"
st_whti1.Text = "0"
st_scti1.Text = "0"
st_rti1.Text = "0"

tab_shiped_items.tabpage_sheet_ed.st_ti.Text = "0"
tab_shiped_items.tabpage_sheet_ed.st_tsw.Text = "0 lbs"	
tab_shiped_items.tabpage_sheet_ed.st_tnt.Text = "0 lbs"	
tab_shiped_items.tabpage_sheet_ed.st_tp.Text = "0"

tab_shiped_items.tabpage_wh_ed.st_whti.Text = "0"
tab_shiped_items.tabpage_wh_ed.st_whtw.Text = "0 lbs"	
tab_shiped_items.tabpage_wh_ed.st_whnt.Text = "0 lbs"	

tab_shiped_items.tabpage_scrap_ed.st_scti.Text = "0"
tab_shiped_items.tabpage_scrap_ed.st_sctw.Text = "0 lbs"	
tab_shiped_items.tabpage_scrap_ed.st_stnt.Text = "0 lbs"	


tab_shiped_items.tabpage_rej_coil_ed.st_rti.Text = "0"
tab_shiped_items.tabpage_rej_coil_ed.st_rtw.Text = "0 lbs"	

st_shipmentitem.Text = "0"
st_shipmentwt.Text ="0 lbs"

Return 1
end function

public function boolean wf_check_multi_stop ();Boolean lb_ms
Int li_row, li_i, li_stop
Long ll_bol
DataStore lds_shipment

lb_ms = FALSE
ddlb_packinglist.Reset()

CONNECT USING SQLCA;
SELECT bill_of_lading INTO :ll_bol
FROM SHIPMENT 
WHERE packing_list = :il_current_shippment
USING SQLCA;
IF IsNULL(ll_bol) THEN RETURN lb_ms

st_bol.Text = String(ll_bol)
il_bol = ll_bol

lds_shipment = CREATE datastore  
lds_shipment.DataObject = "d_shipment_per_bol"  
lds_shipment.SetTransObject (SQLCA)
lds_shipment.retrieve(ll_bol)
li_row = lds_shipment.RowCount()

IF li_row > 1 THEN
	lb_ms = TRUE
	st_multistop.Text = "Multi Stop"
ELSE
	st_multistop.Text = "Single Stop"
END IF

FOR li_i = 1 TO li_row
	IF lds_shipment.GetItemNumber(li_i, "packing_list") = il_current_shippment THEN
		li_stop = li_i
		gb_bol.text = "BOL#: " + String(lds_shipment.GetItemNumber(li_i, "packing_list"))
	end if
ddlb_packinglist.AddItem(String(lds_shipment.GetItemNumber(li_i, "packing_list")))	
NEXT
ddlb_packinglist.SelectItem(li_stop)

RETURN lb_ms
end function

public function integer wf_reset_orig_shipment ();il_current_shippment = Long(il_bol)
ii_display_mode = 0

dw_shipment_detail.inv_Linkage.of_SetTransObject(sqlca) 
IF dw_shipment_detail.inv_linkage.of_retrieve() = -1 THEN
	SQLCA.of_Rollback()
	MessageBox("Error", "w_shipping::ddlb_packinglist selectionchange event" )
	Return 0
ELSE
	SQLCA.of_Commit()
	dw_shipment_detail.SetFocus()
	ii_ok_add = 1
	wf_show_total_wt()
	wf_display_when_done()
	wf_check_multi_stop()
End IF
RETURN 1

end function

public subroutine wf_set_non_updatable ();dw_shipment_detail.SetTabOrder("shipment_status", 0)
dw_shipment_detail.SetTabOrder("des_sh_cust_id", 0)
dw_shipment_detail.SetTabOrder("customer_id", 0)
dw_shipment_detail.SetTabOrder("shipment_scheduled_date_time", 0)
dw_shipment_detail.SetTabOrder("vehicle_id", 0)
dw_shipment_detail.SetTabOrder("vehicle_status", 0)
dw_shipment_detail.SetTabOrder("shipment_actualed_date_time", 0)
dw_shipment_detail.SetTabOrder("shipment_notes", 0)
dw_shipment_detail.SetTabOrder("carrier_id", 0)
dw_shipment_detail.SetTabOrder("carrier_initial", 0)
dw_shipment_detail.SetTabOrder("carrier_description_code", 0)
dw_shipment_detail.SetTabOrder("transportation_method_code", 0)
dw_shipment_detail.SetTabOrder("shipment_enduser_id", 0)
dw_shipment_detail.SetTabOrder("shipment_athorization_code", 0)
dw_shipment_detail.SetTabOrder("vehicle_id_prefix", 0)
dw_shipment_detail.SetTabOrder("scrap_sales_order_num", 0)

dw_shipment_detail.SetTabOrder("equipment_type", 0) //Alex Gerlants. 07/12/2016
	
tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.SetTabOrder("scrap_packaging_ticket", 0)
tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.SetTabOrder("rej_coil_packaging_ticket", 0)

end subroutine

public subroutine wf_set_updatable ();dw_shipment_detail.SetTabOrder("shipment_status", 10)
dw_shipment_detail.SetTabOrder("des_sh_cust_id", 20)
dw_shipment_detail.SetTabOrder("shipment_athorization_code", 30)
dw_shipment_detail.SetTabOrder("customer_id", 40)
dw_shipment_detail.SetTabOrder("shipment_scheduled_date_time", 50)
dw_shipment_detail.SetTabOrder("shipment_enduser_id", 60)
dw_shipment_detail.SetTabOrder("shipment_actualed_date_time", 70)
dw_shipment_detail.SetTabOrder("shipment_notes", 80)
dw_shipment_detail.SetTabOrder("vehicle_status", 90)
dw_shipment_detail.SetTabOrder("carrier_id", 100)
dw_shipment_detail.SetTabOrder("carrier_initial", 110)
dw_shipment_detail.SetTabOrder("vehicle_id_prefix", 120)
dw_shipment_detail.SetTabOrder("vehicle_id", 130)
dw_shipment_detail.SetTabOrder("carrier_description_code", 140)
dw_shipment_detail.SetTabOrder("transportation_method_code", 150)
dw_shipment_detail.SetTabOrder("scrap_sales_order_num", 160)

dw_shipment_detail.SetTabOrder("equipment_type", 170) //Alex Gerlants. 07/12/2016

tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.SetTabOrder("scrap_packaging_ticket", 10)
tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.SetTabOrder("rej_coil_packaging_ticket", 10)

end subroutine

public function integer wf_check_shipmentnew ();Long ll_row, ll_item
String ls_item
Int li_rc

ll_row = dw_shipment_detail.GetRow()
IF ll_row <= 0 THEN Return -1

Long ll_skidnum, ll_scrapnum, ll_whnum
String ls_novelisid
Long ll_soldto
//Novelis SAP Code only available when shipping to endusers
ls_item = dw_shipment_detail.GetItemString(ll_row, "shipment_athorization_code", Primary!, FALSE)
ll_soldto = dw_shipment_detail.GetItemNumber(ll_row, "customer_id", Primary!, FALSE)
ll_skidnum = tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.RowCount()
ll_scrapnum = tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.RowCount()
ll_whnum = tab_shiped_items.tabpage_wh_ed.dw_wh_item.RowCount()
IF (ll_skidnum > 0) OR (ll_scrapnum > 0) OR (ll_whnum > 0) THEN
	SELECT system_option_value INTO :ls_novelisid
	FROM system_options
	WHERE system_option_name = 'Novelis SAP ID'
	USING SQLCA;
	IF Pos(ls_novelisid, ','+String(ll_soldto)+',') > 0 THEN//existing in the list
		IF Len(ls_item) < 2 OR ISNULL(ls_item) THEN 
			li_rc = MessageBox("Authorization Code Missing", "Do you want to save the current shipment without Authorization Code?", Question!, YesNo!)
			if li_rc <> 1 then
				RETURN -2
			end if
		END IF
	END IF
END IF

RETURN 1
end function

public function integer wf_update_skid_notes (datawindow adw_dw);//Alex Gerlants. 04/05/2016. Begin
/*
Function:	wf_update_skid_notes
				Update  prod_item_note in table PRODUCTION_SHEET_ITEM with values taken from dw_sheet_item
Returns:		integer:	 1 if ok
							-1 if DB error
Arguments:	value		datawindow	adw_dw							
*/

Integer	li_rtn = 1
Long		ll_rows, ll_row, ll_skid_num
String	ls_notes

ll_rows = adw_dw.RowCount()

For ll_row = 1 To ll_rows
	ll_skid_num = adw_dw.Object.sheet_skid_num[ll_row]
	ls_notes = adw_dw.Object.notes[ll_row]
	
	update production_sheet_item set prod_item_note = :ls_notes
	where production_sheet_item.prod_item_num in 
			  (	select	production_sheet_item.prod_item_num
				 	from 		production_sheet_item   
								join sheet_skid_detail on production_sheet_item.prod_item_num = sheet_skid_detail.prod_item_num
					where 	sheet_skid_detail.sheet_skid_num = :ll_skid_num
			  )
		using sqlca;
	
	//Don't stop processing if DB error
	//If sqlca.sqlcode = -1 Then //DB error
		//li_rtn = -1
		//MessageBox("DB Error", "Database error occurred wile updating prod_item_note in table PRODUCTION_SHEET_ITEM " + &
		//								"for skid " + String(ll_skid_num) + "with value" + ls_notes + &
		//								"Error: " + sqlca.sqlerrtext, StopSign!)
		//
		//Exit
	//End If
Next

Return li_rtn
//Alex Gerlants. 04/05/2016. End
end function

public subroutine wf_update_edi_triggered (long al_packing_list);//Alex Gerlants. 09/07/2016. Begin
/*
Function:	wf_update_edi_triggered
Returns:		none
Arguments:	value	long		al_packing_list
*/

update	shipment
set		edi_triggered = 'Y'
where		packing_list = :al_packing_list
using		sqlca;

If sqlca.sqlcode = 0 Then //OK
	commit using sqlca;
Else
	rollback using sqlca;
End If

//Alex Gerlants. 09/07/2016. End
end subroutine

public function boolean wf_edi_sent (n_tr_abc01 at_tran, long al_current_shipment);/*
Function:	wf_edi_sent
Returns:		boolean	True if shipment.shipment_edi856_date <> NULL for shipment.packing_list = al_current_shipment
							False if if shipment.shipment_edi856_date = NULL for shipment.packing_list = al_current_shipment
Arguments:	value	n_tr_abc01	at_tran
				value	long			al_current_shipment
*/

Boolean	lb_edi_sent = True
//Date		ld_ship_date
Long		ll_edi_file_id_856

If Not at_tran.of_isconnected() Then
	connect using at_tran;
End If

select	edi_file_id_856
into		:ll_edi_file_id_856
from		shipment
where		packing_list = :al_current_shipment
using		at_tran;

If isnull(ll_edi_file_id_856) Then //EDI has not been sent
	lb_edi_sent = False
End If

Return lb_edi_sent

end function

public function string wf_get_customer_name (n_tr_abc01 at_tran, long al_current_customer);/*
Function:	wf_get_customer_name
Returns:		string				<== Customer name
Arguments:	value	n_tr_abc01	at_tran
				value	long			al_current_customer
*/

Boolean	lb_edi_sent = True
String	ls_customer_short_name

If Not at_tran.of_isconnected() Then
	connect using at_tran;
End If

select	customer_short_name
into		:ls_customer_short_name
from		customer
where		customer_id = :al_current_customer
using		at_tran;

If IsNull(ls_customer_short_name) Then
	ls_customer_short_name = ""
End If

Return ls_customer_short_name

end function

public function integer wf_validate ();//Alex Gerlants. 11/07/2016. Begin
/*
Function:	wf_validate
Returns:		integer	<== 	 1 if warning or no errors
									-1 if error
Arguments:	none											
*/

Integer	li_rtn = 1, li_shipment_status_prev
String	ls_vehicle_id, ls_vehicle_id_prefix, ls_bad_char_vehicle_id, ls_bad_char_vehicle_id_prefix
String	ls_err_string
Boolean	lb_vehicle_id_valid = True, lb_vehicle_id_prefix_valid = True

ls_vehicle_id = dw_shipment_detail.Object.vehicle_id[dw_shipment_detail.GetRow()]
If IsNull(ls_vehicle_id) Then ls_vehicle_id = ""
ls_vehicle_id_prefix = dw_shipment_detail.Object.vehicle_id_prefix[dw_shipment_detail.GetRow()]
If IsNull(ls_vehicle_id_prefix) Then ls_vehicle_id_prefix = ""

If ls_vehicle_id = "" Or ls_vehicle_id_prefix = "" Then
	If ls_vehicle_id = "" And ls_vehicle_id_prefix = "" Then
		li_rtn = -1
		ls_err_string = ls_err_string + "~n~rTruck # (Error) and Trailer # (Warning) missing"
	ElseIf ls_vehicle_id = "" Then
		li_rtn = -1
		ls_err_string = ls_err_string + "~n~rTruck # missing"
	Else //ls_vehicle_id_prefix = ""
		ls_err_string = ls_err_string + "~n~rTrailer # missing"
	End If
End If

If ls_vehicle_id <> "" Or ls_vehicle_id_prefix <> "" Then
	If ls_vehicle_id <> "" Then
		lb_vehicle_id_valid = f_validate_a_to_z_and_dash(ls_vehicle_id, ls_bad_char_vehicle_id)
	End If
	
	If ls_vehicle_id_prefix <> "" Then
		lb_vehicle_id_prefix_valid = f_validate_a_to_z_and_dash(ls_vehicle_id_prefix, ls_bad_char_vehicle_id_prefix)
	End If
	
	If Not lb_vehicle_id_valid Or Not lb_vehicle_id_prefix_valid Then
		If Not lb_vehicle_id_valid And Not lb_vehicle_id_prefix_valid Then
			li_rtn = -1
			
			ls_err_string = ls_err_string + "~n~r~n~rTruck # and Trailer # invalid.~n~rAllowed characters are:  A to Z, 0 to 9, or a dash." + &
														"~n~r~n~rTruck # bad characters are: " + ls_bad_char_vehicle_id + &
														"~n~rTrailer # bad characters are: " + ls_bad_char_vehicle_id_prefix
		ElseIf Not lb_vehicle_id_valid Then
			li_rtn = -1
			
			ls_err_string = ls_err_string + "~n~r~n~rTruck # invalid.~n~rAllowed characters are:  A to Z, 0 to 9, or a dash." + &
													  "~n~r~n~rBad characters are: " + ls_bad_char_vehicle_id
		Else //Not lb_vehicle_id_prefix_valid
			li_rtn = -1
			
			ls_err_string = ls_err_string + "~n~r~n~rTrailer # invalid.~n~rAllowed characters are:  A to Z, 0 to 9, or a dash." + &
													  "~n~r~n~rBad characters are: " + ls_bad_char_vehicle_id_prefix
		End If
	End If
End If

If ls_err_string <> "" Then
	If li_rtn = 1 Then
		MessageBox("Warning", ls_err_string, Exclamation!)
	Else //li_rtn = -1
		MessageBox("Error", ls_err_string, StopSign!)
		
		//Change status back to the status before it was changed to "Done"
		li_shipment_status_prev = dw_shipment_detail.GetItemNumber(dw_shipment_detail.GetRow(), "shipment_status", Primary!, True)
		dw_shipment_detail.Object.shipment_status[dw_shipment_detail.GetRow()] = li_shipment_status_prev
	End If
End If

Return li_rtn
//Alex Gerlants. 11/07/2016. End
end function

public subroutine wf_update_shipment_edi_required (n_tr_abc01 at_tran);//Alex Gerlants. 11/05/2016. Begin
/*
Function:	wf_update_shipment_edi_required
Returns:		none
Arguments:	value	n_tr_abc01	at_tran
*/

Long		ll_customer_id, ll_shipment_enduser_id, ll_row, ll_i, ll_skid_sheet_status
Long		ll_rows_sheets, ll_rows_scrap, ll_rows_rej, ll_rows_wh
Long		ll_count_status_12, ll_count_status_not_12
Long		ll_count_status_15, ll_count_status_not_15
Boolean	lb_edi_required_sheets, lb_edi_required__rej, lb_edi_required_wh, lb_edi_required
String	ls_null

SetNull(ls_null)

ll_row = dw_shipment_detail.GetRow()
ll_customer_id = dw_shipment_detail.Object.customer_id[ll_row]
ll_shipment_enduser_id = dw_shipment_detail.Object.shipment_enduser_id[ll_row]

lb_edi_required = wf_edi_required(sqlca, ll_customer_id, ll_shipment_enduser_id)

If lb_edi_required Then //Customer ll_customer_id and ll_shipment_enduser_id require EDI
	ll_rows_sheets = tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.RowCount()
	ll_rows_rej 	= tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.RowCount()
	ll_rows_wh 		= tab_shiped_items.tabpage_wh_ed.dw_wh_item.RowCount()
	
	If ll_rows_sheets > 0 Or ll_rows_rej > 0 Or ll_rows_wh > 0 Then
		//At this point, we have to check sheet_skid.skid_sheet_status for all skids on all 3 tabs.
		//If sheet_skid.skid_sheet_status <> 12, this is a regular shipment. It does require EDI.
		//If sheet_skid.skid_sheet_status = 12, this is a sample shipment. It does not require EDI.
		
		//If out of the 3 tabs, at least 1 skid requires EDI, this shipment requires EDI.
		
		If ll_rows_sheets > 0 Then
			//Check if are shipping samples or regular sheets. Samples do not require EDI.
			For ll_i = 1 To ll_rows_sheets
				ll_skid_sheet_status = tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.Object.sheet_skid_skid_sheet_status[ll_i]
				
				If ll_skid_sheet_status = 12 Then //Sample
					ll_count_status_12++
				Else //Regular shipment
					ll_count_status_not_12++
				End If					
			Next
			
			If ll_count_status_12 > 0 And ll_count_status_not_12 = 0 Then //This sheet tab has sample skid(s) only
				lb_edi_required_sheets = False
			Else
				lb_edi_required_sheets = True
			End If
		End If
		
		If ll_rows_wh > 0 Then
			//Check if are shipping WH samples or regular sheets. WH samples do not require EDI.
			For ll_i = 1 To ll_rows_wh
				ll_skid_sheet_status = tab_shiped_items.tabpage_wh_ed.dw_wh_item.Object.sheet_skid_skid_sheet_status[ll_i]
				
				If ll_skid_sheet_status = 15 Then //WH sample
					ll_count_status_15++
				Else //Regular shipment
					ll_count_status_not_15++
				End If					
			Next
			
			If ll_count_status_15 > 0 And ll_count_status_not_15 = 0 Then //This WH tab has sample skid(s) only
				lb_edi_required_wh = False
			Else
				lb_edi_required_wh = True
			End If
		End If
		
		If ll_rows_sheets > 0 Or ll_rows_wh > 0 Then
			If ll_rows_sheets > 0 And ll_rows_wh > 0 Then
				If lb_edi_required_sheets Or lb_edi_required_wh Then
					dw_shipment_detail.Object.edi_req[ll_row] = "Y"
				Else
					dw_shipment_detail.Object.edi_req[ll_row] = ls_null //EDI not required
				End If
			ElseIf ll_rows_sheets > 0 Then
				If lb_edi_required_sheets Then
					dw_shipment_detail.Object.edi_req[ll_row] = "Y"
				Else
					dw_shipment_detail.Object.edi_req[ll_row] = ls_null //EDI not required
				End If
			Else //ll_rows_wh > 0
				If lb_edi_required_wh Then
					dw_shipment_detail.Object.edi_req[ll_row] = "Y"
				Else
					dw_shipment_detail.Object.edi_req[ll_row] = ls_null //EDI not required
				End If
			End If
		Else //ll_rows_rej > 0
			If lb_edi_required Then
				dw_shipment_detail.Object.edi_req[ll_row] = "Y"
			Else
				dw_shipment_detail.Object.edi_req[ll_row] = ls_null
			End If
		End If
	Else
		If lb_edi_required Then
			dw_shipment_detail.Object.edi_req[ll_row] = "Y"
		Else
			dw_shipment_detail.Object.edi_req[ll_row] = ls_null
		End If
	End If
Else //Customer ll_customer_id and ll_shipment_enduser_id DO NOT require EDI
	dw_shipment_detail.Object.edi_req[ll_row] = ls_null
End If
//Alex Gerlants. 11/05/2016. End

end subroutine

protected function integer wf_equipment_type_standard_validate (n_tr_abc01 at_tran, long al_customer_id, string as_equipment_type_code_user);//Alex Gerlants. 12/06/2016. Begin
/*
Function:	wf_equipment_type_standard_validate
Returns:		integer	 1 Allow saving as Done
							-1 Do not allow saving as Done
Arguments:	value	n_tr_abc01	at_tran
				value	long			al_customer_id
				value	string		as_equipment_type_code_user
*/

Integer		li_rtn = 1, li_answer, li_shipment_status_prev
Long			ll_row, ll_rows, ll_found_row
String		ls_find_string, ls_standard_equipment_types
String		ls_equipment_type, ls_customer_short_name, ls_equipment_type_desc
DataStore	lds_equipment_type, lds_equipment_type_customer

If IsNull(as_equipment_type_code_user) Then as_equipment_type_code_user = "NULL"

If Not at_tran.of_isconnected() Then
	connect using at_tran;
End If

lds_equipment_type_customer = Create DataStore
lds_equipment_type_customer.DataObject = "d_equipment_type_customer"
lds_equipment_type_customer.SetTransObject(at_tran)

lds_equipment_type = Create DataStore
lds_equipment_type.DataObject = "d_equipment_type"
lds_equipment_type.SetTransObject(at_tran)

ll_rows = lds_equipment_type_customer.Retrieve(al_customer_id)

If ll_rows > 0 Then //This customer has standard equipment types
	ls_find_string = "equipment_type_code = '" + as_equipment_type_code_user + "'"
	
	ll_found_row = lds_equipment_type_customer.Find(ls_find_string, 1, lds_equipment_type_customer.RowCount())
	
	If ll_found_row > 0 Then //User selected a standard equipment type...Good
		//
	Else //User selected equipment type other than standard, or just left it blank
		//Build a list of standard equipment types
		For ll_row = 1 To ll_rows
			ls_equipment_type = lds_equipment_type_customer.Object.equipment_type_code[ll_row]
			ls_standard_equipment_types = ls_standard_equipment_types + ls_equipment_type + ", "
		Next
		
		If ls_standard_equipment_types <> "" Then
			//Remove the last comma
			ls_standard_equipment_types = Left(ls_standard_equipment_types, Len(ls_standard_equipment_types) - 2)

			ls_customer_short_name = lds_equipment_type_customer.Object.customer_short_name[1]
			
			ll_rows = lds_equipment_type.Retrieve(as_equipment_type_code_user)
			
			If ll_rows > 0 Then //Should be 1 row
				ls_equipment_type_desc = lds_equipment_type.Object.equipment_type_desc[1]
			End If
			
			//Issue a friendly reminder
			If as_equipment_type_code_user <> "NULL" Then //User selected equipment type
				li_answer = MessageBox(	"Warning: Non-standard equipment type", &
									"Selected equipment type " + as_equipment_type_code_user + "-" + &
									ls_equipment_type_desc + " is non-standard for customer " + ls_customer_short_name + "." + &
									"~n~rStandard equipment types are: " + ls_standard_equipment_types + &
									"~n~rPlease contact dispatch.logistics@novelis.com " + &
									"to verify equipment code for this shipment." + &
									"~n~r~n~rPlease click on:" + &
									"~n~r   'Yes' to continue saving'" + &
									"~n~r   'No'  to go back, and change equipment type", &										
									Question!, YesNo!, 2)
									
			Else //User left equipment type unselected
				li_answer = MessageBox(	"Warning: Equipment type not selected", &
									"Equipment type not selected"+ &
									" for customer " + ls_customer_short_name + "." + &
									"~n~rStandard equipment types for this customer" + &
									" are: " + ls_standard_equipment_types + &
									"~n~rPlease contact dispatch.logistics@novelis.com " + &
									"to verify equipment code for this shipment." + &
									"~n~r~n~rPlease click on:" + &
									"~n~r   'Yes' to continue saving'" + &
									"~n~r   'No'  to go back, and change equipment type", &										
									Question!, YesNo!, 2)
									
			End If
			
			If li_answer = 1 Then //Yes
				//li_rtn = 1 at this point. Allow saving
			Else //No
				li_rtn = -1 //Do not allow saving
				
				//Change status back to the status before it was changed to "Done"
				li_shipment_status_prev = dw_shipment_detail.GetItemNumber(dw_shipment_detail.GetRow(), "shipment_status", Primary!, True)
				dw_shipment_detail.Object.shipment_status[dw_shipment_detail.GetRow()] = li_shipment_status_prev
			End If
		End If
	End If
	
Else //This customer has no standard equipment types. Thus issue a generic reminder message if equipment type not selected.
	If as_equipment_type_code_user = "NULL" Then //User left equipment type blank
	
		select	customer_short_name
		into		:ls_customer_short_name
		from		customer
		where		customer_id = :al_customer_id
		using		at_tran;
	
		li_answer = MessageBox(	"Warning: Equipment type not selected", &
										"Equipment type not selected"+ &
										" for customer " + ls_customer_short_name + "." + &
										"~n~r~n~rPlease click on:" + &
										"~n~r   'Yes' to continue saving" + &
										"~n~r   'No'  to go back, and change equipment type", &										
										Question!, YesNo!, 2)
										
		If li_answer = 1 Then //Yes
			//li_rtn = 1 at this point. Allow saving
		Else //No
			li_rtn = -1 //Do not allow saving
			
			//Change status back to the status before it was changed to "Done"
			li_shipment_status_prev = dw_shipment_detail.GetItemNumber(dw_shipment_detail.GetRow(), "shipment_status", Primary!, True)
			dw_shipment_detail.Object.shipment_status[dw_shipment_detail.GetRow()] = li_shipment_status_prev
		End If
	End If
End If

Return li_rtn
//Alex Gerlants. 12/06/2016. End
end function

public function boolean wf_edi_required (n_tr_abc01 at_tran, long al_current_customer, long al_shipment_enduser_id);/*
Function:	wf_edi_required
Returns:		boolean	True if customer.edi_req = "Y" or customer.desadv_req = "Y" for customer al_current_customer
							False if both of those columns are equal to NULL or "N"
Arguments:	value	n_tr_abc01	at_tran
				value	long			al_current_customer
				value	long			al_shipment_enduser_id
*/

Boolean	lb_edi_required = False, lb_edi_required_customer = False, lb_edi_required_enduser = False
Integer	li_counter

If Not at_tran.of_isconnected() Then
	connect using at_tran;
End If

select	count(*)
into		:li_counter
from		customer
where		customer_id = :al_current_customer
and		(upper(nvl(edi_req, 'N')) = 'Y' or upper(nvl(desadv_req, 'N')) = 'Y')
using		at_tran;

If li_counter > 0 Then
	lb_edi_required_customer = True
End If

//---

select	count(*)
into		:li_counter
from		customer
where		customer_id = :al_shipment_enduser_id
and		(upper(nvl(edi_req, 'N')) = 'Y' or upper(nvl(desadv_req, 'N')) = 'Y')
using		at_tran;

If li_counter > 0 Then
	lb_edi_required_enduser = True
End If

If lb_edi_required_customer And lb_edi_required_enduser Then
	lb_edi_required = True
End If

Return lb_edi_required

end function

public subroutine wf_delay_asn (n_tr_abc01 atr_tran);//Alex Gerlants. 03/20/2017. Begin
/*
Function:	wf_delay_asn
Returns:		none
Arguments:	value	n_tr_abc01	atr_tran
*/

DateTime		ldt_dbdatetime
Time			lt_start_time, lt_temp_time
Time			lt_curr_time
Integer		li_slash1_pos, li_slash2_pos, li_colon1_pos, li_colon2_pos, ll_space_pos
Integer		li_curr_minutes, li_curr_seconds, li_minutes, li_seconds
Integer		li_curr_hour
String		ls_dbdatetime, ls_minutes, ls_seconds, ls_min_sec, ls_time
String		ls_find_string
DataStore	lds_min_sec
Long			ll_rows, ll_row
Long			ll_inserted_row, ll_found_row, ll_time_diff
w_wait		lw_wait
str_wait		lstr_wait

ldt_dbdatetime = f_get_db_date(atr_tran) //Get database date/time

ls_dbdatetime = String(ldt_dbdatetime)

//ls_dbdatetime = "3/21/2017 02:55:58" //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

ll_space_pos = Pos(ls_dbdatetime, " ", 1)

If ll_space_pos > 0 Then
	ls_time = Mid(ls_dbdatetime, ll_space_pos + 1, Len(ls_dbdatetime) - ll_space_pos)
	lt_curr_time = Time(ls_time)
	li_curr_hour = Hour(lt_curr_time)
Else
	Return
End If
//

li_slash1_pos = Pos(ls_dbdatetime, "/", 1)

If li_slash1_pos > 0 Then
	li_slash2_pos = Pos(ls_dbdatetime, "/", li_slash1_pos + 1)
	
	If li_slash2_pos > 0 Then
		li_colon1_pos = Pos(ls_dbdatetime, ":", 1)
		
		If li_colon1_pos > 0 Then
			li_colon2_pos = Pos(ls_dbdatetime, ":", li_colon1_pos + 1)
			
			If li_colon2_pos > 0 Then
				ls_minutes = Mid(ls_dbdatetime, li_colon1_pos + 1, li_colon2_pos - li_colon1_pos - 1)
				ls_seconds = Mid(ls_dbdatetime, li_colon2_pos + 1, Len(ls_dbdatetime) - li_colon2_pos)
				
				li_curr_minutes = Integer(ls_minutes)
				li_curr_seconds = Integer(ls_seconds)
				
				lds_min_sec = Create DataStore
				lds_min_sec.DataObject = "d_min_sec"
				
				li_minutes = 0
				
				//Populate lds_min_sec with 'time from' and 'time to' we want to wait for 15 seconds
				//before creating an ASN file
				Do While li_minutes < 60
					ll_inserted_row = lds_min_sec.InsertRow(0)
					
					If ll_inserted_row > 0 Then
						lt_temp_time = Time(li_curr_hour, li_minutes, 55)
						
						lds_min_sec.Object.time_from[ll_inserted_row] = lt_temp_time
				
						lt_temp_time = Time(li_curr_hour, li_minutes + 1, 10)
						lds_min_sec.Object.time_to[ll_inserted_row] = lt_temp_time
					End If
					
					li_minutes = li_minutes + 5
				Loop
				
				//lds_min_sec.Print()
				
				ls_find_string = "time_from <= " + String(lt_curr_time) + " and time_to >= " + String(lt_curr_time)
				ll_found_row = lds_min_sec.Find(ls_find_string, 1, lds_min_sec.RowCount())
				
				If ll_found_row > 0 Then
					
					lstr_wait.number_of_seconds = 15 //Close lw_wait in 15 seconds
					lstr_wait.unit_of_measure = "seconds"
					lstr_wait.header_line1 = "while UNIX scheduled task is running."
					lstr_wait.header_line2 = "This task moves EDI files to VAN,"
					lstr_wait.header_line3 = "and then, it moves them to archive."
					
					OpenWithParm(lw_wait, lstr_wait)
				End If
			End If
		End If
	End If
End If
//Alex Gerlants. 03/20/2017. End
end subroutine

public subroutine wf_get_customer_4shipment (long al_current_shipment, ref long al_customer_id, ref string as_customer_short_name);//Alex Gerlants. Communication_Code_Error_Message. 11/01/2017. Begin
/*
Function:	wf_get_customer_4shipment
Returns:		none
Arguments:	value			long		al_current_shipment
				reference	long		al_customer_id
				reference	string	as_customer_short_name
*/

select	shipment.customer_id, customer.customer_short_name
into		:al_customer_id, :as_customer_short_name
from		shipment
			join customer on customer.customer_id = shipment.customer_id
where		shipment.packing_list = :al_current_shipment
using		sqlca;

If sqlca.sqlcode <> 0 Then
	al_customer_id = -1
	as_customer_short_name = ""
End If
//Alex Gerlants. Communication_Code_Error_Message. 11/01/2017. End
end subroutine

public subroutine wf_get_des_sh_cust_4shipment (long al_current_shipment, ref long al_des_sh_cust_id, ref string as_customer_short_name);//Alex Gerlants. Communication_Code_Error_Message. 11/01/2017. Begin
/*
Function:	wf_get_des_sh_cust_4shipment
Returns:		none
Arguments:	value			long		al_current_shipment
				reference	long		al_des_sh_cust_id
				reference	string	as_customer_short_name
*/

select	shipment.des_sh_cust_id, customer.customer_short_name
into		:al_des_sh_cust_id, :as_customer_short_name
from		shipment
			join customer on customer.customer_id = shipment.des_sh_cust_id
where		shipment.packing_list = :al_current_shipment
using		sqlca;

If sqlca.sqlcode <> 0 Then
	al_des_sh_cust_id = -1
	as_customer_short_name = ""
End If
//Alex Gerlants. Communication_Code_Error_Message. 11/01/2017. End
end subroutine

public function boolean wf_get_use_customer_website_4shipping (n_tr_abc01 atr, long al_customer_id);//Alex Gerlants. Tesla_Shipping_Message. Begin
/*
Function:	wf_get_use_customer_website_4shipping
Returns:		boolean	True  if customer.use_customer_website_4shipping = 'y'
							False if customer.use_customer_website_4shipping <> 'y'
Arguments:	value			n_tr_abc01	atr
				value			long			al_customer_id
*/

String	ls_use_customer_website_4shipping
Boolean	lb_use_customer_website_4shipping

select	upper(nvl(use_customer_website_4shipping, 'N'))
into		:ls_use_customer_website_4shipping
from		customer
where		customer_id = :al_customer_id
using		atr;

If atr.sqlcode = 0 Then
	If ls_use_customer_website_4shipping = "Y" Then
		lb_use_customer_website_4shipping = True
	Else
		lb_use_customer_website_4shipping = False
	End If
Else
	lb_use_customer_website_4shipping = False
End If

Return lb_use_customer_website_4shipping
//Alex Gerlants. Tesla_Shipping_Message. End
end function

public subroutine wf_display_notice ();//Alex Gerlants. Tesla_Shipping_Message. Begin
/*
Function:	wf_display_notice
Returns:		none
Arguments:	none
*/
Boolean					lb_use_customer_website_4shipping
str_all_data_types	lstr_all_data_types
String					ls_customer_name

lb_use_customer_website_4shipping = wf_get_use_customer_website_4shipping(sqlca, il_current_customer)
ls_customer_name = wf_get_customer_name(sqlca, il_current_customer)

If lb_use_customer_website_4shipping Then
	lstr_all_data_types.string_var[1] = ls_customer_name
	lstr_all_data_types.long_var[1] = il_bol						//BOL
	lstr_all_data_types.long_var[2] = il_current_shippment	//Packing list
	
	OpenWithParm(w_tesla_shipping_message, lstr_all_data_types)
End If
//Alex Gerlants. Tesla_Shipping_Message. End
end subroutine

on w_shipping_2_disabled_buttons.create
int iCurrent
call super::create
if this.MenuName = "m_shipment_shipping" then this.MenuID = create m_shipment_shipping
this.dw_error_message=create dw_error_message
this.cb_1=create cb_1
this.st_10=create st_10
this.cb_browse=create cb_browse
this.cb_save=create cb_save
this.cb_edi=create cb_edi
this.cb_new=create cb_new
this.cb_close=create cb_close
this.tab_shiped_items=create tab_shiped_items
this.st_19=create st_19
this.st_shipmentwt=create st_shipmentwt
this.cb_print=create cb_print
this.dw_shipment_detail=create dw_shipment_detail
this.st_2=create st_2
this.st_shipmentitem=create st_shipmentitem
this.st_12=create st_12
this.st_ti1=create st_ti1
this.st_13=create st_13
this.st_scti1=create st_scti1
this.st_14=create st_14
this.st_rti1=create st_rti1
this.st_15=create st_15
this.st_whti1=create st_whti1
this.cb_revise=create cb_revise
this.st_7=create st_7
this.st_bol=create st_bol
this.st_8=create st_8
this.ddlb_packinglist=create ddlb_packinglist
this.st_multistop=create st_multistop
this.cb_newstop=create cb_newstop
this.gb_bol=create gb_bol
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_error_message
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.st_10
this.Control[iCurrent+4]=this.cb_browse
this.Control[iCurrent+5]=this.cb_save
this.Control[iCurrent+6]=this.cb_edi
this.Control[iCurrent+7]=this.cb_new
this.Control[iCurrent+8]=this.cb_close
this.Control[iCurrent+9]=this.tab_shiped_items
this.Control[iCurrent+10]=this.st_19
this.Control[iCurrent+11]=this.st_shipmentwt
this.Control[iCurrent+12]=this.cb_print
this.Control[iCurrent+13]=this.dw_shipment_detail
this.Control[iCurrent+14]=this.st_2
this.Control[iCurrent+15]=this.st_shipmentitem
this.Control[iCurrent+16]=this.st_12
this.Control[iCurrent+17]=this.st_ti1
this.Control[iCurrent+18]=this.st_13
this.Control[iCurrent+19]=this.st_scti1
this.Control[iCurrent+20]=this.st_14
this.Control[iCurrent+21]=this.st_rti1
this.Control[iCurrent+22]=this.st_15
this.Control[iCurrent+23]=this.st_whti1
this.Control[iCurrent+24]=this.cb_revise
this.Control[iCurrent+25]=this.st_7
this.Control[iCurrent+26]=this.st_bol
this.Control[iCurrent+27]=this.st_8
this.Control[iCurrent+28]=this.ddlb_packinglist
this.Control[iCurrent+29]=this.st_multistop
this.Control[iCurrent+30]=this.cb_newstop
this.Control[iCurrent+31]=this.gb_bol
end on

on w_shipping_2_disabled_buttons.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_error_message)
destroy(this.cb_1)
destroy(this.st_10)
destroy(this.cb_browse)
destroy(this.cb_save)
destroy(this.cb_edi)
destroy(this.cb_new)
destroy(this.cb_close)
destroy(this.tab_shiped_items)
destroy(this.st_19)
destroy(this.st_shipmentwt)
destroy(this.cb_print)
destroy(this.dw_shipment_detail)
destroy(this.st_2)
destroy(this.st_shipmentitem)
destroy(this.st_12)
destroy(this.st_ti1)
destroy(this.st_13)
destroy(this.st_scti1)
destroy(this.st_14)
destroy(this.st_rti1)
destroy(this.st_15)
destroy(this.st_whti1)
destroy(this.cb_revise)
destroy(this.st_7)
destroy(this.st_bol)
destroy(this.st_8)
destroy(this.ddlb_packinglist)
destroy(this.st_multistop)
destroy(this.cb_newstop)
destroy(this.gb_bol)
end on

event open;call super::open;Boolean	lb_this_window_open //Alex Gerlants. 05/16/2016
String	ls_port //Alex Gerlants. Communication_Code_Error_Message. 11/01/2017

dw_shipment_detail.of_SetLinkage(TRUE)

//Set the transaction object for all datawindows in the linked chain.
tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.of_Setlinkage(TRUE)
tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.inv_Linkage.of_SetMaster(dw_shipment_detail)
IF NOT tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked sheet skids and shippment!" )
ELSE
	tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.inv_Linkage.of_Register( "packing_list", "packing_list" ) 
	tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.inv_Linkage.of_SetStyle( 2 ) 
END IF

tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.of_Setlinkage(TRUE)
tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.inv_Linkage.of_SetMaster(dw_shipment_detail)
IF NOT tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked scrap skids and shippment!" )
ELSE
	tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.inv_Linkage.of_Register( "packing_list", "packing_list" ) 
	tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.inv_Linkage.of_SetStyle( 2 ) 
END IF

tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.of_Setlinkage(TRUE)
tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.inv_Linkage.of_SetMaster(dw_shipment_detail)
IF NOT tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked rej_coil skids and shippment!" )
ELSE
	tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.inv_Linkage.of_Register( "packing_list", "packing_list" ) 
	tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.inv_Linkage.of_SetStyle( 2 ) 
END IF

tab_shiped_items.tabpage_wh_ed.dw_wh_item.of_Setlinkage(TRUE)
tab_shiped_items.tabpage_wh_ed.dw_wh_item.inv_Linkage.of_SetMaster(dw_shipment_detail)
IF NOT tab_shiped_items.tabpage_wh_ed.dw_wh_item.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked WH skids and shippment!" )
ELSE
	tab_shiped_items.tabpage_wh_ed.dw_wh_item.inv_Linkage.of_Register( "packing_list", "packing_list" ) 
	tab_shiped_items.tabpage_wh_ed.dw_wh_item.inv_Linkage.of_SetStyle( 2 ) 
END IF

dw_shipment_detail.inv_Linkage.of_SetTransObject(sqlca) 

//set to display mode user can not created a new order
ii_display_mode = 0
ii_ok_add = 0
ib_new_shipment = FALSE
ib_newstop = FALSE
il_current_customer = 1
il_current_shippment = 0

CHOOSE CASE gl_message
	CASE 0
		this.Event pfc_new()
	CASE ELSE
		//Alex Gerlants. 05/16/2016. Begin
		This.Title = This.Title + ": " + String(gl_message) + "  *** Controls disabled."
		
		//Check if this window is already open.
		lb_this_window_open = f_window_open(This.Title)
		
		If lb_this_window_open Then //Window open
			Close(This) //Close this window
			Return
		End If		
		//Alex Gerlants. 05/16/2016. End
		
		this.Event ue_open_shippment(gl_message, gl_customer)
END CHOOSE

//Alex Gerlants. 07/12/2016. Begin
DataWindowChild	ldwc
Integer				li_rtn, li_rows

li_rtn = dw_shipment_detail.GetChild("equipment_type", ldwc)

If li_rtn = 1 Then //OK
	ldwc.SetTransObject(sqlca)
	li_rows = ldwc.Retrieve() //Table: equipment_type
	
	dw_shipment_detail.SetColumn("shipment_status") //This is where the focus was before this change...just keep it the same.
End If
//Alex Gerlants. 07/12/2016. End

//Alex Gerlants. Communication_Code_Error_Message. 11/01/2017. Begin
dw_error_message.Visible = False

//Get SMTP email variables from abis_ini
is_from_email = gnv_app.of_GetUserId() + "@albl.com" //Email address "from"
is_from_name = gnv_app.of_GetUserId() //Name "from"

is_server = f_get_ini_value("edi_error","smtp_email","server","192.168.3.67") //From table abis_ini

ls_port = f_get_ini_value("edi_error","smtp_email","port","25")

If IsNumber(ls_port) Then
	ii_port = Integer(ls_port)
Else
	ii_port = 25
End If

is_send_email = f_get_ini_value("edi_error","smtp_email","SupportEmail","it-support@albl.com")
is_send_name = f_get_ini_value("edi_error","smtp_email","send_name","Support")
is_logfile = f_get_ini_value("edi_error","smtp_email","logfile","P:\Email_Errors_LogFiles\SMTP_Email_LogFile.txt")
is_subject = f_get_ini_value("edi_error","smtp_email","subject","EDI Error")
//Alex Gerlants. Communication_Code_Error_Message. 11/01/2017. End

cb_1.Enabled = False
cb_revise.Enabled = False
cb_edi.Enabled = False
end event

event pfc_new;int li_rc
Long ll_row

dw_shipment_detail.AcceptText()
tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.AcceptText()
tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.AcceptText()
tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.AcceptText()
tab_shiped_items.tabpage_wh_ed.dw_wh_item.AcceptText()
IF dw_shipment_detail.inv_Linkage.of_GetUpdatesPending() = 1 THEN
	li_rc = MessageBox("Warning", "This shipment has NOT been saved! Save it now?",Question!, OKCancel!, 2) 	
	CHOOSE CASE li_rc
		CASE 1 //yes
			this.Event pfc_save()
		CASE ELSE
			Return 
	END CHOOSE		
END IF
ll_row = dw_shipment_detail.GetRow()
IF ll_row > 0 THEN
	istr_shipinfo.cust_id = dw_shipment_detail.GetItemNumber(ll_row, "customer_id", Primary!, FALSE)
	istr_shipinfo.carrier_id = dw_shipment_detail.GetItemNumber(ll_row, "carrier_id", Primary!, FALSE)
	istr_shipinfo.bol = dw_shipment_detail.GetItemNumber(ll_row, "bill_of_lading", Primary!, FALSE)
	istr_shipinfo.vehicle_id = dw_shipment_detail.GetItemString(ll_row, "vehicle_id", Primary!, FALSE)
	istr_shipinfo.carrier_initial = dw_shipment_detail.GetItemString(ll_row, "carrier_initial", Primary!, FALSE)
	istr_shipinfo.vehicle_id_prefix = dw_shipment_detail.GetItemString(ll_row, "vehicle_id_prefix", Primary!, FALSE)
END IF
dw_shipment_detail.inv_Linkage.of_Reset()

wf_set_non_updatable()
dw_shipment_detail.Event pfc_addrow()
wf_set_updatable()
end event

event pfc_save;integer li_return
Long ll_row
Int li_status
Date ld_ship_date

Boolean 	lb_valid //Alex Gerlants. 05/26/2016
String	ls_title //Alex Gerlants. 05/26/2016
Window 	lw_sheet //Alex Gerlants. 05/26/2016

ll_row = dw_shipment_detail.GetRow()
IF ll_row <= 0 THEN 
	MessageBox("Error", "InValid shipment information", StopSign! )
	Return -1
END IF

li_status = dw_shipment_detail.GetItemNumber(ll_row,"shipment_status", Primary!, TRUE)
IF li_status = 0 THEN 
	Return 0
END IF

dw_shipment_detail.AcceptText()

tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.AcceptText()
tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.AcceptText()
tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.AcceptText()
tab_shiped_items.tabpage_wh_ed.dw_wh_item.AcceptText()

li_return = dw_shipment_detail.inv_Linkage.of_GetUpdatesPending()
IF li_return = -1 THEN
	//accceptText error
	MessageBox("Edit Errors", "Check for valid data", StopSign! )
	Return -1 
END IF

ll_row = dw_shipment_detail.GetRow()
li_status = dw_shipment_detail.GetItemNumber(ll_row,"shipment_status", Primary!, FALSE)
IF li_status = 0 THEN
	IF wf_check_readytosent() > 0 THEN
		RETURN this.Event ue_shipment_sent()
	ELSE
		MessageBox("Error", "Failed to save shipment as DONE!")
	END IF	
	Return 1
END IF	

Open(w_shipping_saveas)

CHOOSE CASE Message.DoubleParm
	CASE 1
		//save as DONE shipment
		CONNECT USING SQLCA;
		SELECT shipment_edi856_date
		INTO :ld_ship_date
		FROM Shipment
		WHERE packing_list = :il_current_shippment
		USING SQLCA;
		
		if isnull(ld_ship_date) then
			li_return = MessageBox("Send EDI", "Do you need to send EDI?", Question!, YesNo!)
			if li_return = 1 then
				MessageBox("Send EDI", "Please click button to send EDI after this shipment has been saved to DONE.")
			end if
		end if

		IF wf_check_readytosent() > 0 THEN
				RETURN this.Event ue_shipment_sent()
		ELSE
				MessageBox("Error", "Failed to save shipment as DONE!")
		END IF
		
		//Alex Gerlants. 12/05/2016. Begin
		//Update shipment_edi_req on dw_shipment_detail
		wf_update_shipment_edi_required(sqlca)
		//Alex Gerlants. 12/05/2016. End
		
	CASE 2
		ll_row = dw_shipment_detail.GetRow()
		li_status = dw_shipment_detail.GetItemNumber(ll_row,"shipment_status", Primary!, FALSE)
		IF li_status = 0 THEN
			IF wf_check_readytosent() < 0 THEN
				MessageBox("Error", "Failed to save shipment as DONE!")
				RETURN -2
			END IF
		ELSE
			IF wf_check_shipmentnew() < 0 THEN
				MessageBox("Error", "Failed to save shipment due to missing data!")
				RETURN -2
			END IF			
		END IF
		
		//Alex Gerlants. 12/05/2016. Begin
		//Update shipment_edi_req on dw_shipment_detail
		wf_update_shipment_edi_required(sqlca)
		//Alex Gerlants. 12/05/2016. End
		
		li_return = dw_shipment_detail.inv_Linkage.of_update(TRUE,FALSE)
		IF li_return <> 1 THEN
			ROLLBACK USING SQLCA;
			IF SQLCA.SQLCODE <> 0 THEN
				MessageBox("Rollback Error", SQLCA.SQLErrText, StopSign!)
			ELSE
				MessageBox("Update Failed", "Rollback Succeeded")
			END IF
		ELSE
			
			//Alex Gerlants. 04/05/2016. Begin
			//Update production_sheet_item.prod_item_note for each skid
			//wf_update_skid_note() doesn't error out if DB error
			wf_update_skid_notes(tab_shiped_items.tabpage_sheet_ed.dw_sheet_item)
			//Alex Gerlants. 04/05/2016. End
			
			COMMIT using SQLCA;
			IF SQLCA.SQLCODE <> 0 THEN
				MessageBox("Commit Error", SQLCA.SQLErrText, StopSign!)
				Return -3
			END IF
			dw_shipment_detail.inv_Linkage.of_ResetUpdate()
			wf_display_when_done()
			ib_new_shipment = FALSE
			
			//---
			
			Long	ll_rows_sheets, ll_rows_scrap, ll_rows_rej, ll_rows_wh
			
			ll_rows_sheets = tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.RowCount()
			ll_rows_scrap = tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.RowCount()
			ll_rows_rej = tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.RowCount()
			ll_rows_wh = tab_shiped_items.tabpage_wh_ed.dw_wh_item.RowCount()
			
			//---
			
			//Alex Gerlants. 05/26/2016. Begin
			//After successful update on this window, re-retrieve dw_shipment_list on w_shipment_list.
			//Thus changes on this window will be reflected on w_shipment_list.
			
			lw_sheet = gnv_app.of_getFrame().GetFirstSheet()
			lb_valid = IsValid(lw_sheet)
			
			If lb_valid Then
				ls_title = lw_sheet.Title //Get the first sheet title
				
				Do
					lw_sheet = gnv_app.of_getFrame().GetNextSheet(lw_sheet)
					lb_valid = IsValid (lw_sheet)
					
					If lb_valid Then
						ls_title = lw_sheet.Title //Get the next sheet title
						If Upper(ls_title) = "ABCO SHIPMENT MANAGEMENT" Then
							lw_sheet.Function Dynamic wf_retrieve() //Re-retrieve shipment list
						End If
					End If
				Loop While lb_valid
			End If
			//Alex Gerlants. 05/26/2016. End
		END IF
	CASE ELSE
		//nothing
END CHOOSE

//Alex Gerlants. Tesla_Shipping_Message. Begin
//Boolean					lb_use_customer_website_4shipping
//str_all_data_types	lstr_all_data_types
//String					ls_customer_name
//
//lb_use_customer_website_4shipping = wf_get_use_customer_website_4shipping(sqlca, il_current_customer)
//ls_customer_name = wf_get_customer_name(sqlca, il_current_customer)
//
//If lb_use_customer_website_4shipping Then
//	lstr_all_data_types.string_var[1] = ls_customer_name
//	lstr_all_data_types.long_var[1] = il_bol						//BOL
//	lstr_all_data_types.long_var[2] = il_current_shippment	//Packing list
//	
//	OpenWithParm(w_tesla_shipping_message, lstr_all_data_types)
//End If
//Alex Gerlants. Tesla_Shipping_Message. End

Return 1
end event

event pfc_print;int li_return
Long ll_row
s_shipment_customer lstr_data

SetPointer(HourGlass!)

IF ii_ok_add < 1 THEN 
	MessageBox("Error", "please open an shipment first!", StopSign! )
	Return -1
END IF

li_return = dw_shipment_detail.inv_Linkage.of_GetUpdatesPending()
IF li_return = -1 THEN
	//accceptText error
	MessageBox("Edit Errors", "Check for valid data" )
	Return -2
ELSEIF li_return = 1 THEN
	if messagebox("Save", "Save updated information first?",&
	             Question!, OkCancel!,1) = 1 then
		this.Event pfc_Save()
	else
		MessageBox("Warning", "Failed to print active data!", StopSign! )
		Return -3
	end if
END IF

IF wf_verify_before_printing() < 0 THEN 
	Return -4
End IF

openwithparm(w_report_shipping, il_current_shippment)

RETURN 1
end event

event close;call super::close;f_display_app()
end event

event activate;call super::activate;IF f_security_door("Shipment(Control)") = 1 THEN RETURN 1
This.Event ue_read_only()
end event

type dw_error_message from datawindow within w_shipping_2_disabled_buttons
integer x = 51
integer y = 1328
integer width = 249
integer height = 122
integer taborder = 50
boolean enabled = false
string dataobject = "d_error_message"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;MessageBox("DB Error", 	"sqldbcode: " + String(sqldbcode) + &
								"~n~rsqlerrtext: " + sqlerrtext, StopSign!)
end event

type cb_1 from commandbutton within w_shipping_2_disabled_buttons
integer x = 18
integer y = 1069
integer width = 336
integer height = 93
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "ASN All"
end type

event clicked;SetPointer(HourGlass!)
Int i, li_return, li_total_num_of_packinglist, li_status
Long ll_shippment

Long		ll_rows, ll_row, ll_packing_list //Alex Gerlants. 09/07/2016
Integer	li_rtn //Alex Gerlants. 09/07/2016

//Alex Gerlants. 10/25/2017. Begin
Long			ll_des_sh_cust_id, ll_customer_id
String		ls_customer_short_name, ls_error_message_temp, ls_error_message
DataStore	lds_error_message

If IsValid(lds_error_message) Then Destroy lds_error_message
lds_error_message = Create DataStore
lds_error_message.DataObject = "d_error_message"
lds_error_message.SetTransObject(sqlca)

select	shipment.des_sh_cust_id, customer.customer_short_name
into		:ll_des_sh_cust_id, :ls_customer_short_name
from		shipment
			join customer on customer.customer_id = shipment.des_sh_cust_id
where		shipment.packing_list = :il_current_shippment
using		sqlca;
//Alex Gerlants. 10/25/2017. End

IF ii_ok_add < 1 THEN 
	MessageBox("Error", "please open a shipment first!", StopSign! )
	Return
END IF

li_return = dw_shipment_detail.inv_Linkage.of_GetUpdatesPending()
IF li_return = -1 THEN
	//accceptText error
	MessageBox("Edit Errors", "Check for valid data" )
	Return -1
ELSEIF li_return = 1 THEN
	if messagebox("Save", "Save updated information first?",&
	             Question!, OkCancel!,1) = 1 then
		Parent.Event pfc_Save()
	else
		MessageBox("Warning", "Failed to edi active data!", StopSign! )
		Return -2
	end if
END IF

IF wf_verify_values() <> 1 THEN 
	Return -1
End IF

li_total_num_of_packinglist =  ddlb_packinglist.totalitems()
if li_total_num_of_packinglist < 1 then
	Return
else 
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
end if

for i = 1 to li_total_num_of_packinglist
	ll_shippment = long(ddlb_packinglist.text(i))
	
	CONNECT USING SQLCA;
	SELECT shipment_status
	INTO :li_status
	FROM Shipment
	WHERE packing_list = :ll_shippment
	USING SQLCA;
	
	IF li_status <> 0 THEN
		MessageBox("Warning", "EDI can NOT be created when "+ String(ll_shippment) +"'s status is not DONE.", StopSign! )
		//Return -5
	ELSE	
		
		//Alex Gerlants. 09/07/2016. Begin
		//At this point, all changes have been saved and commited.
		//Thus, I am saving shipment.edi_triggered separately, and commit if no DB errors.
		wf_update_edi_triggered(ll_shippment)
		dw_shipment_detail.Retrieve(ll_shippment)
		//Alex Gerlants. 09/07/2016. End
		
		//Alex Gerlants. 03/20/2017. Begin
		//The script that moves ASN files to VAN is scheduled to run every 5 minutes:
		//at XX:01:00, XX:06:00, XX:11:00, XX:16:00, XX:21:00, ..... XX:56:00
		//If current time falls between 5 seconds before and 10 seconds after the scheduled time,
		//wait for 15 seconds to avoid situation when the ASN file created below is moved
		//to backup directory BEFORE being moved to the van.
		wf_delay_asn(sqlca)
		//Alex Gerlants. 03/20/2017. End
		
		DECLARE p_edi procedure for f_edi_856 (:ll_shippment) using dboconnect;
		execute p_edi;
		if dboconnect.SQLCode <> 0 then 
			MessageBox ("Stored Procedure Failed!!!",dboconnect.sqlerrtext,exclamation!)
			return -1
		end if
		fetch p_edi INTO :li_return; 
		close p_edi;
		
		//Alex Gerlants. Communication_Code_Error_Message. 11/01/2017. Begin
		//Table error_message populated in f_edi_856
		If li_return <> 1 Then
			If IsValid(lds_error_message) Then Destroy lds_error_message
			lds_error_message = Create DataStore
			lds_error_message.DataObject = "d_error_message"
			lds_error_message.SetTransObject(sqlca)
		
			lds_error_message.SetTransObject(sqlca)
			ll_rows = lds_error_message.Retrieve()
			
			For ll_row = 1 To ll_rows
				ls_error_message_temp = lds_error_message.Object.error_message_text[ll_row]
				ls_error_message = ls_error_message + ls_error_message_temp + "~n~r~n~r"
			Next
		End If
		//Alex Gerlants. Communication_Code_Error_Message. 11/01/2017. End
		
		CHOOSE CASE li_return
			CASE 1
			 messagebox("Templar EDI generation","EDI generated successfully for BOL#" + String(ll_shippment) +".")
			CASE -1
				MessageBox("Error","EDI failed, see EDI log file for BOL#" + String(ll_shippment) +".", StopSign!)
			CASE 100
				MessageBox("Info","EDI previously sent for BOL#" + String(ll_shippment) +"." )
			CASE 200
				MessageBox("Info","Customer does NOT require EDI transaction for BOL#" + String(ll_shippment) +"." )
			CASE 300
				MessageBox("Info","System can not process BOL with more than 5 skids")
				
				
			//Alex Gerlants. Communication_Code_Error_Message. 11/01/2017. Begin
			Case -2 //Just in case... -2 should not be returned. I intercept this error in f_edi_856.
				f_send_smtp_email(ii_port, ls_error_message, is_server, is_logfile, ib_debugviewer, "Unexpected Error. Please contact abis Support. Packing List " + String(il_current_shippment), is_from_email, is_from_name, is_send_email, is_send_name)
				MessageBox("Error.","Unexpected error.~n~rPlease contact abis Support", StopSign!)
		
			
			Case -3 //This is for f_edi_desadv2
				wf_get_des_sh_cust_4shipment(il_current_shippment, ll_des_sh_cust_id, ls_customer_short_name)
				f_send_smtp_email(ii_port, ls_error_message, is_server, is_logfile, ib_debugviewer, "Customer ASN created, but OEM ASN Not Created. Packing List " + String(il_current_shippment), is_from_email, is_from_name, is_send_email, is_send_name)
			
				MessageBox("Error.EDI failed", 	"Customer ASN created, but OEM ASN Not Created~n~r" + "Packing List " + String(il_current_shippment) + "~n~r" + &
											"f_edi_desadv2. Communication code is NOT set up in table customer_system " + &
											"for Destination Customer " + String(ll_des_sh_cust_id) + "-" + ls_customer_short_name + &
											"~n~r~n~rPlease contact abis Support.", StopSign!)
											
			Case -6 //Novelis f_edi_desadv2 failed. This is for DESADV sent to GM.
				f_send_smtp_email(ii_port, ls_error_message, is_server, is_logfile, ib_debugviewer, "Customer ASN created, but OEM ASN Not Created. Packing List " + String(il_current_shippment), is_from_email, is_from_name, is_send_email, is_send_name)
				
				MessageBox("Error. EDI failed", "Customer ASN created, but OEM ASN Not Created~n~r~n~r" + "Packing List " + String(il_current_shippment) + "~n~r" + ls_error_message, StopSign!)
		
			Case -7 //Novelis edi_alcan_alcan_856_x12 failed. This is for 856 that is sent to Novelis before running f_edi_desadv2
				f_send_smtp_email(ii_port, ls_error_message, is_server, is_logfile, ib_debugviewer, "OEM ASN created, but Customer ASN Not Created. Packing List " + String(il_current_shippment), is_from_email, is_from_name, is_send_email, is_send_name)
				MessageBox("Error. EDI failed", "OEM ASN created, but Customer ASN Not Created~n~r~n~r" + "Packing List " + String(il_current_shippment) + "~n~r" + ls_error_message, StopSign!)
		
			Case -8 //Novelis edi_alcan_alcan_856_x12 and f_edi_desadv2 failed
				f_send_smtp_email(ii_port, ls_error_message, is_server, is_logfile, ib_debugviewer, "Customer and OEM ASN Not Created. Packing List " + String(il_current_shippment), is_from_email, is_from_name, is_send_email, is_send_name)
				
				MessageBox("Error. EDI failed", "Customer and OEM ASN Not Created~n~r~n~r" + "Packing List " + String(il_current_shippment) + "~n~r" + ls_error_message, StopSign!)
		
			Case -15 //Novelis edi_alcan_alcan_856_x12 and f_edi_desadv2 return code is not 1.
						//However, OEM file is created, but customer file is not created.
						//OEM file is created, but in f_edi_desadv2, customer.customer_duns_number_string not set up for customer
						//So send email to support asking to set it up.
				f_send_smtp_email(ii_port, ls_error_message, is_server, is_logfile, ib_debugviewer, "Customer ASN Not Created. Packing List " + String(il_current_shippment), is_from_email, is_from_name, is_send_email, is_send_name)
				
				MessageBox("Error. EDI partially failed", "OEM ASN is created; but Customer ASN Not Created~n~r~n~r" + "Packing List " + String(il_current_shippment) + "~n~r" + ls_error_message, StopSign!)
			
			Case -16 //This is for f_edi_desadv2
						//At this point, both, Customer and DESADV files are created.
						//The problem is that f_edi_desadv2 needs customer.customer_duns_number_string to insert a row into table outbound_edi_transaction;
						//and customer.customer_duns_number_string to insert a row into table outbound_edi_transaction;
						//and it is not set up.
						//Thus we should not issue an error message. Just send email to support to set up customer.customer_duns_number_string for the customer.
				wf_get_customer_4shipment(il_current_shippment, ll_customer_id, ls_customer_short_name)
		
				f_send_smtp_email(ii_port, "f_edi_desadv2. customer_duns_number_string is not set up in table customer. Please set it up.", is_server, is_logfile, ib_debugviewer, "Customer " + String(ll_customer_id) + "-" + ls_customer_short_name, is_from_email, is_from_name, is_send_email, is_send_name)
				MessageBox("Templar EDI generation","EDI generated successfully")
			
			
			Case -9 //856 sent to customer failed. Ford shipment. We send one 586 to Ford, and one 856 to customer.
				f_send_smtp_email(ii_port, ls_error_message, is_server, is_logfile, ib_debugviewer, "Ford Customer ASN Not Created. Packing List " + String(il_current_shippment), is_from_email, is_from_name, is_send_email, is_send_name)
				
				MessageBox("Error. EDI failed", "Ford OEM ASN created, but Ford Customer ASN Not Created~n~r" + "Packing List " + String(il_current_shippment) + "~n~r" + ls_error_message, StopSign!)
		
			Case -10 //856 sent to Ford failed. We send one 586 to Ford, and one 856 to customer.
				f_send_smtp_email(ii_port, ls_error_message, is_server, is_logfile, ib_debugviewer, "Ford OEM ASN Not Created. Packing List " + String(il_current_shippment), is_from_email, is_from_name, is_send_email, is_send_name)
				
				MessageBox("Error. EDI failed", "Ford Customer ASN created, but Ford OEM ASN Not Created~n~r~n~r" + "Packing List " + String(il_current_shippment) + "~n~r" + ls_error_message, StopSign!)
		
			Case -11 //856 sent to customer and Ford failed. 
				f_send_smtp_email(ii_port, ls_error_message, is_server, is_logfile, ib_debugviewer, "Ford Customer and OEM ASN Not Created. Packing List " + String(il_current_shippment), is_from_email, is_from_name, is_send_email, is_send_name)
				
				MessageBox("Error.EDI failed", "Ford Customer and OEM ASN Not Created~n~r" + "Packing List " + String(il_current_shippment) + "~n~r" + ls_error_message, StopSign!)
		
		
			Case -12 //This is for f_edi_desadv_bolt
						//At this point, DESADV file is created.
						//The problem is that f_edi_desadv_bolt needs customer.customer_duns_number_string to insert a row into table outbound_edi_transaction;
						//and customer.customer_duns_number_string to insert a row into table outbound_edi_transaction;
						//and it is not set up.
						//Thus we should not issue an error message. Just send email to support to set up customer.customer_duns_number_string for the customer.
				wf_get_customer_4shipment(il_current_shippment, ll_customer_id, ls_customer_short_name)
				f_send_smtp_email(ii_port, "customer_duns_number_string is not set up in table customer. Please set it up.", is_server, is_logfile, ib_debugviewer, "Customer " + String(ll_customer_id) + "-" + ls_customer_short_name, is_from_email, is_from_name, is_send_email, is_send_name)
				MessageBox("Templar EDI generation","EDI generated successfully")
				//MessageBox("Error.EDI failed", "Bolt OEM ASN Not Created~n~r" + "Packing List " + String(il_current_shippment) + "~n~r" + ls_error_message, StopSign!)
		
			Case -13 //This is for f_edi_desadv_bolt
				wf_get_des_sh_cust_4shipment(il_current_shippment, ll_des_sh_cust_id, ls_customer_short_name)
				f_send_smtp_email(ii_port, ls_error_message, is_server, is_logfile, ib_debugviewer, "Bolt OEM ASN Not Created. Packing List " + String(il_current_shippment), is_from_email, is_from_name, is_send_email, is_send_name)
			
				MessageBox("Error.EDI failed", 	"Bolt OEM ASN Not Created~n~r" + "Packing List " + String(il_current_shippment) + "~n~r" + &
											"f_edi_desadv_bolt. Communication code is NOT set up in table customer_system " + &
											"for Destination Customer " + String(ll_des_sh_cust_id) + "-" + ls_customer_short_name + &
											"~n~r~n~rPlease contact abis Support.", StopSign!)
		
			Case -14 //This is for f_edi_desadv_bolt. Packing list does not exist... Should not happen though
				f_send_smtp_email(ii_port, ls_error_message, is_server, is_logfile, ib_debugviewer, "Bolt OEM ASN Not Created. Packing List " + String(il_current_shippment), is_from_email, is_from_name, is_send_email, is_send_name)
			
				MessageBox("Error.EDI failed", 	"Bolt OEM ASN Not Created~n~r" + "Packing List " + String(il_current_shippment) + " does not exist" + &
															"~n~r~n~rPlease contact abis Support.", StopSign!)
															
			//Case Else
			//	f_send_smtp_email(ii_port, ls_error_message, is_server, is_logfile, ib_debugviewer, "Unexpected Error. Please contact abis Support. Packing List " + String(il_current_shippment), is_from_email, is_from_name, is_send_email, is_send_name)
			//	MessageBox("Error.","Unexpected error.~n~rPlease contact abis Support", StopSign!)													
			//Alex Gerlants. Communication_Code_Error_Message. 11/01/2017. End
		end CHOOSE
	END IF
next

disconnect using dboconnect;
destroy dboconnect;

If IsValid(lds_error_message) Then Destroy lds_error_message //Alex Gerlants. 10/25/2017

end event

event constructor;IF f_security_door("EDI") = 1 THEN 
	this.Enabled = TRUE
ELSE
	this.Enabled = FALSE
END IF
end event

type st_10 from statictext within w_shipping_2_disabled_buttons
integer x = 245
integer y = 941
integer width = 121
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
string text = "/BOL"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_browse from commandbutton within w_shipping_2_disabled_buttons
string tag = "Open a shipment"
integer x = 464
integer y = 1626
integer width = 336
integer height = 93
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Open"
end type

event clicked;Parent.Event ue_open()
end event

type cb_save from commandbutton within w_shipping_2_disabled_buttons
string tag = "Save current shipment"
integer x = 1510
integer y = 1626
integer width = 336
integer height = 93
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Save..."
end type

event clicked;Parent.Event pfc_save()
end event

type cb_edi from commandbutton within w_shipping_2_disabled_buttons
integer x = 1858
integer y = 1626
integer width = 336
integer height = 93
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "ASN Single"
end type

event clicked;//Alex Gerlants. Communication_Code_Error_Message. 11/01/2017. Begin
Long			ll_des_sh_cust_id, ll_customer_id, ll_row, ll_rows
String		ls_customer_short_name, ls_error_message_temp, ls_error_message
DataStore	lds_error_message
//Alex Gerlants. Communication_Code_Error_Message. 11/01/2017. End

SetPointer(HourGlass!)


IF ii_ok_add < 1 THEN 
	MessageBox("Error", "please open an shipment first!", StopSign! )
	Return
END IF

Int li_return 
li_return = dw_shipment_detail.inv_Linkage.of_GetUpdatesPending()
IF li_return = -1 THEN
	//accceptText error
	MessageBox("Edit Errors", "Check for valid data" )
	Return -1
ELSEIF li_return = 1 THEN
	if messagebox("Save", "Save updated information first?",&
	             Question!, OkCancel!,1) = 1 then
		Parent.Event pfc_Save()
	else
		MessageBox("Warning", "Failed to edi active data!", StopSign! )
		Return -2
	end if
END IF

IF wf_verify_values() <> 1 THEN 
	Return -1
End IF

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

//Alex Gerlants. 03/20/2017. Begin
//The script that moves ASN files to VAN is scheduled to run every 5 minutes:
//at XX:01:00, XX:06:00, XX:11:00, XX:16:00, XX:21:00, ..... XX:56:00
//If current time falls between 5 seconds before and 10 seconds after the scheduled time,
//wait for 15 seconds to avoid situation when the ASN file created below is moved
//to backup directory BEFORE being moved to the van.
wf_delay_asn(sqlca)
//Alex Gerlants. 03/20/2017. End

DECLARE p_edi procedure for f_edi_856 (:il_current_shippment) using dboconnect;
execute p_edi;
if dboconnect.SQLCode <> 0 then 
	MessageBox ("Stored Procedure Failed!!!",dboconnect.sqlerrtext,exclamation!)
	return -1
end if
fetch p_edi INTO :li_return; 
close p_edi;

disconnect using dboconnect;

//Alex Gerlants. Communication_Code_Error_Message. 11/01/2017. Begin
//Table error_message populated in f_edi_856
If li_return <> 1 Then
	If IsValid(lds_error_message) Then Destroy lds_error_message
	lds_error_message = Create DataStore
	lds_error_message.DataObject = "d_error_message"
	lds_error_message.SetTransObject(sqlca)

	lds_error_message.SetTransObject(sqlca)
	ll_rows = lds_error_message.Retrieve()
	
	For ll_row = 1 To ll_rows
		ls_error_message_temp = lds_error_message.Object.error_message_text[ll_row]
		ls_error_message = ls_error_message + ls_error_message_temp + "~n~r~n~r"
	Next
End If
//Alex Gerlants. Communication_Code_Error_Message. 11/01/2017. End

CHOOSE CASE li_return
   CASE 1
    messagebox("Templar EDI generation","EDI generated successfully")
   CASE -1
		MessageBox("Error","EDI failed, see EDI log file for details!", StopSign!)
	CASE 100
		MessageBox("Info","EDI previously sent." )
	CASE 200
		MessageBox("Info","Customer does NOT require EDI transaction." )
	CASE 300
		MessageBox("Info","System can not process BOL with more than 5 skids")
		
	
	//Alex Gerlants. Communication_Code_Error_Message. 11/01/2017. Begin
	Case -2 //Just in case... -2 should not be returned. I intercept this error in f_edi_856.
		f_send_smtp_email(ii_port, ls_error_message, is_server, is_logfile, ib_debugviewer, "Unexpected Error. Please contact abis Support. Packing List " + String(il_current_shippment), is_from_email, is_from_name, is_send_email, is_send_name)
		MessageBox("Error.","Unexpected error.~n~rPlease contact abis Support", StopSign!)

	
	Case -3 //This is for f_edi_desadv2
		wf_get_des_sh_cust_4shipment(il_current_shippment, ll_des_sh_cust_id, ls_customer_short_name)
		f_send_smtp_email(ii_port, ls_error_message, is_server, is_logfile, ib_debugviewer, "Customer ASN created, but OEM ASN Not Created. Packing List " + String(il_current_shippment), is_from_email, is_from_name, is_send_email, is_send_name)
	
		MessageBox("Error.EDI failed", 	"Customer ASN created, but OEM ASN Not Created~n~r" + "Packing List " + String(il_current_shippment) + "~n~r" + &
									"f_edi_desadv2. Communication code is NOT set up in table customer_system " + &
									"for Destination Customer " + String(ll_des_sh_cust_id) + "-" + ls_customer_short_name + &
									"~n~r~n~rPlease contact abis Support.", StopSign!)
									
	Case -6 //Novelis f_edi_desadv2 failed. This is for DESADV sent to GM.
		f_send_smtp_email(ii_port, ls_error_message, is_server, is_logfile, ib_debugviewer, "Customer ASN created, but OEM ASN Not Created. Packing List " + String(il_current_shippment), is_from_email, is_from_name, is_send_email, is_send_name)
		
		MessageBox("Error. EDI failed", "Customer ASN created, but OEM ASN Not Created~n~r~n~r" + "Packing List " + String(il_current_shippment) + "~n~r" + ls_error_message, StopSign!)

	Case -7 //Novelis edi_alcan_alcan_856_x12 failed. This is for 856 that is sent to Novelis before running f_edi_desadv2
		f_send_smtp_email(ii_port, ls_error_message, is_server, is_logfile, ib_debugviewer, "OEM ASN created, but Customer ASN Not Created. Packing List " + String(il_current_shippment), is_from_email, is_from_name, is_send_email, is_send_name)
		MessageBox("Error. EDI failed", "OEM ASN created, but Customer ASN Not Created~n~r~n~r" + "Packing List " + String(il_current_shippment) + "~n~r" + ls_error_message, StopSign!)

	Case -8 //Novelis edi_alcan_alcan_856_x12 and f_edi_desadv2 failed
		f_send_smtp_email(ii_port, ls_error_message, is_server, is_logfile, ib_debugviewer, "Customer and OEM ASN Not Created. Packing List " + String(il_current_shippment), is_from_email, is_from_name, is_send_email, is_send_name)
		
		MessageBox("Error. EDI failed", "Customer and OEM ASN Not Created~n~r~n~r" + "Packing List " + String(il_current_shippment) + "~n~r" + ls_error_message, StopSign!)

	Case -15 //Novelis edi_alcan_alcan_856_x12 and f_edi_desadv2 return code is not 1.
				//However, OEM file is created, but customer file is not created.
				//OEM file is created, but in f_edi_desadv2, customer.customer_duns_number_string not set up for customer
				//So send email to support asking to set it up.
		f_send_smtp_email(ii_port, ls_error_message, is_server, is_logfile, ib_debugviewer, "Customer ASN Not Created. Packing List " + String(il_current_shippment), is_from_email, is_from_name, is_send_email, is_send_name)
		
		MessageBox("Error. EDI partially failed", "OEM ASN is created; but Customer ASN Not Created~n~r~n~r" + "Packing List " + String(il_current_shippment) + "~n~r" + ls_error_message, StopSign!)
	
	Case -16 //This is for f_edi_desadv2
				//At this point, both, Customer and DESADV files are created.
				//The problem is that f_edi_desadv2 needs customer.customer_duns_number_string to insert a row into table outbound_edi_transaction;
				//and customer.customer_duns_number_string to insert a row into table outbound_edi_transaction;
				//and it is not set up.
				//Thus we should not issue an error message. Just send email to support to set up customer.customer_duns_number_string for the customer.
		wf_get_customer_4shipment(il_current_shippment, ll_customer_id, ls_customer_short_name)

		f_send_smtp_email(ii_port, "f_edi_desadv2. customer_duns_number_string is not set up in table customer. Please set it up.", is_server, is_logfile, ib_debugviewer, "Customer " + String(ll_customer_id) + "-" + ls_customer_short_name, is_from_email, is_from_name, is_send_email, is_send_name)
		MessageBox("Templar EDI generation","EDI generated successfully")
	
	
	Case -9 //856 sent to customer failed. Ford shipment. We send one 586 to Ford, and one 856 to customer.
		f_send_smtp_email(ii_port, ls_error_message, is_server, is_logfile, ib_debugviewer, "Ford Customer ASN Not Created. Packing List " + String(il_current_shippment), is_from_email, is_from_name, is_send_email, is_send_name)
		
		MessageBox("Error. EDI failed", "Ford OEM ASN created, but Ford Customer ASN Not Created~n~r" + "Packing List " + String(il_current_shippment) + "~n~r" + ls_error_message, StopSign!)

	Case -10 //856 sent to Ford failed. We send one 586 to Ford, and one 856 to customer.
		f_send_smtp_email(ii_port, ls_error_message, is_server, is_logfile, ib_debugviewer, "Ford OEM ASN Not Created. Packing List " + String(il_current_shippment), is_from_email, is_from_name, is_send_email, is_send_name)
		
		MessageBox("Error. EDI failed", "Ford Customer ASN created, but Ford OEM ASN Not Created~n~r~n~r" + "Packing List " + String(il_current_shippment) + "~n~r" + ls_error_message, StopSign!)

	Case -11 //856 sent to customer and Ford failed. 
		f_send_smtp_email(ii_port, ls_error_message, is_server, is_logfile, ib_debugviewer, "Ford Customer and OEM ASN Not Created. Packing List " + String(il_current_shippment), is_from_email, is_from_name, is_send_email, is_send_name)
		
		MessageBox("Error.EDI failed", "Ford Customer and OEM ASN Not Created~n~r" + "Packing List " + String(il_current_shippment) + "~n~r" + ls_error_message, StopSign!)


	Case -12 //This is for f_edi_desadv_bolt
				//At this point, DESADV file is created.
				//The problem is that f_edi_desadv_bolt needs customer.customer_duns_number_string to insert a row into table outbound_edi_transaction;
				//and customer.customer_duns_number_string to insert a row into table outbound_edi_transaction;
				//and it is not set up.
				//Thus we should not issue an error message. Just send email to support to set up customer.customer_duns_number_string for the customer.
		wf_get_customer_4shipment(il_current_shippment, ll_customer_id, ls_customer_short_name)
		f_send_smtp_email(ii_port, "customer_duns_number_string is not set up in table customer. Please set it up.", is_server, is_logfile, ib_debugviewer, "Customer " + String(ll_customer_id) + "-" + ls_customer_short_name, is_from_email, is_from_name, is_send_email, is_send_name)
		MessageBox("Templar EDI generation","EDI generated successfully")
		//MessageBox("Error.EDI failed", "Bolt OEM ASN Not Created~n~r" + "Packing List " + String(il_current_shippment) + "~n~r" + ls_error_message, StopSign!)

	Case -13 //This is for f_edi_desadv_bolt
		wf_get_des_sh_cust_4shipment(il_current_shippment, ll_des_sh_cust_id, ls_customer_short_name)
		f_send_smtp_email(ii_port, ls_error_message, is_server, is_logfile, ib_debugviewer, "Bolt OEM ASN Not Created. Packing List " + String(il_current_shippment), is_from_email, is_from_name, is_send_email, is_send_name)
	
		MessageBox("Error.EDI failed", 	"Bolt OEM ASN Not Created~n~r" + "Packing List " + String(il_current_shippment) + "~n~r" + &
									"f_edi_desadv_bolt. Communication code is NOT set up in table customer_system " + &
									"for Destination Customer " + String(ll_des_sh_cust_id) + "-" + ls_customer_short_name + &
									"~n~r~n~rPlease contact abis Support.", StopSign!)

	Case -14 //This is for f_edi_desadv_bolt. Packing list does not exist... Should not happen though
		f_send_smtp_email(ii_port, ls_error_message, is_server, is_logfile, ib_debugviewer, "Bolt OEM ASN Not Created. Packing List " + String(il_current_shippment), is_from_email, is_from_name, is_send_email, is_send_name)
	
		MessageBox("Error.EDI failed", 	"Bolt OEM ASN Not Created~n~r" + "Packing List " + String(il_current_shippment) + " does not exist" + &
													"~n~r~n~rPlease contact abis Support.", StopSign!)
													
	//Case Else
	//	f_send_smtp_email(ii_port, ls_error_message, is_server, is_logfile, ib_debugviewer, "Unexpected Error. Please contact abis Support. Packing List " + String(il_current_shippment), is_from_email, is_from_name, is_send_email, is_send_name)
	//	MessageBox("Error.","Unexpected error.~n~rPlease contact abis Support", StopSign!)											
	//Alex Gerlants. Communication_Code_Error_Message. 11/01/2017. End
	
	
end CHOOSE

destroy dboconnect;

If IsValid(lds_error_message) Then Destroy lds_error_message //Alex Gerlants. 10/25/2017


//CHOOSE CASE f_edi_856(il_current_shippment)
//	CASE 1
//		MessageBox("Info", "EDI generated successfully!" )
//	CASE -1
//		MessageBox("Error","EDI failed, see EDI log file for details!", StopSign!)
//	CASE 100
//		MessageBox("Info","EDI had been sent." )
//	CASE 200
//		MessageBox("Info","Customer does NOT require EDI transaction." )
//END CHOOSE


end event

event constructor;IF f_security_door("EDI") = 1 THEN 
	this.Enabled = TRUE
ELSE
	this.Enabled = FALSE
END IF
end event

type cb_new from commandbutton within w_shipping_2_disabled_buttons
string tag = "Create a shipment"
integer x = 812
integer y = 1626
integer width = 336
integer height = 93
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&New Shipment"
end type

event clicked;ib_newstop = FALSE
Parent.Event pfc_new()
tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.Reset()
tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.Reset()
tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.Reset()
tab_shiped_items.tabpage_wh_ed.dw_wh_item.Reset()
wf_show_total_wt()

end event

type cb_close from commandbutton within w_shipping_2_disabled_buttons
string tag = "Close this window"
integer x = 2900
integer y = 1626
integer width = 336
integer height = 93
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Close"
end type

event clicked;Close(Parent)
end event

type tab_shiped_items from tab within w_shipping_2_disabled_buttons
integer x = 388
integer y = 493
integer width = 2483
integer height = 1130
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean raggedright = true
boolean boldselectedtext = true
boolean pictureonright = true
alignment alignment = center!
integer selectedtab = 1
tabpage_sheet_ed tabpage_sheet_ed
tabpage_scrap_ed tabpage_scrap_ed
tabpage_rej_coil_ed tabpage_rej_coil_ed
tabpage_wh_ed tabpage_wh_ed
end type

on tab_shiped_items.create
this.tabpage_sheet_ed=create tabpage_sheet_ed
this.tabpage_scrap_ed=create tabpage_scrap_ed
this.tabpage_rej_coil_ed=create tabpage_rej_coil_ed
this.tabpage_wh_ed=create tabpage_wh_ed
this.Control[]={this.tabpage_sheet_ed,&
this.tabpage_scrap_ed,&
this.tabpage_rej_coil_ed,&
this.tabpage_wh_ed}
end on

on tab_shiped_items.destroy
destroy(this.tabpage_sheet_ed)
destroy(this.tabpage_scrap_ed)
destroy(this.tabpage_rej_coil_ed)
destroy(this.tabpage_wh_ed)
end on

type tabpage_sheet_ed from userobject within tab_shiped_items
integer x = 15
integer y = 90
integer width = 2454
integer height = 1027
long backcolor = 12632256
string text = "Sheet Skid"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
string picturename = "Horizontal!"
long picturemaskcolor = 553648127
dw_sheet_item dw_sheet_item
st_tswt st_tswt
st_tit st_tit
st_ti st_ti
st_tsw st_tsw
st_tp st_tp
st_tnt st_tnt
cb_addsheet cb_addsheet
cb_delsheet cb_delsheet
cb_detailsheet cb_detailsheet
st_4 st_4
st_5 st_5
end type

on tabpage_sheet_ed.create
this.dw_sheet_item=create dw_sheet_item
this.st_tswt=create st_tswt
this.st_tit=create st_tit
this.st_ti=create st_ti
this.st_tsw=create st_tsw
this.st_tp=create st_tp
this.st_tnt=create st_tnt
this.cb_addsheet=create cb_addsheet
this.cb_delsheet=create cb_delsheet
this.cb_detailsheet=create cb_detailsheet
this.st_4=create st_4
this.st_5=create st_5
this.Control[]={this.dw_sheet_item,&
this.st_tswt,&
this.st_tit,&
this.st_ti,&
this.st_tsw,&
this.st_tp,&
this.st_tnt,&
this.cb_addsheet,&
this.cb_delsheet,&
this.cb_detailsheet,&
this.st_4,&
this.st_5}
end on

on tabpage_sheet_ed.destroy
destroy(this.dw_sheet_item)
destroy(this.st_tswt)
destroy(this.st_tit)
destroy(this.st_ti)
destroy(this.st_tsw)
destroy(this.st_tp)
destroy(this.st_tnt)
destroy(this.cb_addsheet)
destroy(this.cb_delsheet)
destroy(this.cb_detailsheet)
destroy(this.st_4)
destroy(this.st_5)
end on

type dw_sheet_item from u_dw within tabpage_sheet_ed
event type integer ue_fill_new_row ( long al_skid_num )
integer x = 7
integer y = 26
integer width = 2033
integer height = 973
integer taborder = 2
string dataobject = "d_sheet_packing_item"
boolean hscrollbar = true
end type

event ue_fill_new_row;Long ll_row
Long ll_p, ll_net, ll_tare
Int li_status

ll_row = this.GetRow()
IF ll_row <= 0 THEN Return -1

This.SetItem(ll_row,"sh_packing_item", wf_get_sh_packing_item_number()) 
This.SetItem(ll_row,"packing_list",  il_current_shippment) 
This.SetItem(ll_row,"sheet_skid_num",al_skid_num)
//This.SetItem(ll_row,"sheet_packaging_ticket", wf_new_packaging_ticket#() )
//This.SetItem(ll_row,"sheet_packaging_ticket", f_get_next_value("sheet_packaging_ticket_seq") )
This.SetItem(ll_row,"sheet_packaging_ticket", al_skid_num )

CONNECT USING SQLCA;
SELECT sheet_net_wt, sheet_tare_wt, skid_pieces, skid_sheet_status
INTO :ll_net, :ll_tare, :ll_p, :li_status
FROM sheet_skid
WHERE sheet_skid_num = :al_skid_num
USING SQLCA;

This.SetItem(ll_row,"sheet_skid_skid_pieces",ll_p)
This.SetItem(ll_row,"sheet_skid_sheet_net_wt",ll_net)
This.SetItem(ll_row,"sheet_skid_sheet_tare_wt",ll_tare)
This.SetItem(ll_row,"sheet_skid_skid_sheet_status",li_status)

Return 1
end event

event rbuttondown;//Override
Return 0
end event

event rbuttonup;//Override
Return 0
end event

event constructor;call super::constructor;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetRowFocusIndicator(FocusRect!)
end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

this.AcceptText()
li_Row = this.GetRow()
IF li_row < 1 THEN RETURN
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.event pfc_rowchanged()
end event

event doubleclicked;tab_shiped_items.tabpage_sheet_ed.cb_detailsheet.Event Clicked()
end event

event retrieveend;call super::retrieveend;//Alex Gerlants. 04/05/2016. Begin
Long		ll_rows, ll_row, ll_skid_num
Integer	li_status
String	ls_notes

//li_status = dw_shipment_detail.GetItemNumber(1,"shipment_status", Primary!, False)
li_status = dw_shipment_detail.Object.shipment_status[1]

//MessageBox("", "li_status = " + String(li_status))

If li_status = 0 Then //Shipment is done. Do not allow editing
	This.Modify("notes.tabsequence = 0")
	This.Modify("notes.pointer = 'Arrow!'")
	This.Modify("notes.Background.Color = 67108864") //Button face color
Else //Allow editing
	This.Modify("notes.tabsequence = 10")
	This.Modify("notes.pointer = 'IBeam!'")
	This.Modify("notes.Background.Color = 16777215") //White color
End If

ls_notes = dw_shipment_detail.Object.shipment_notes[1]

//dw_sheet_item.Print() //TEST ONLY. TEST ONLY. TEST ONLY. TEST ONLY. TEST ONLY. TEST ONLY. TEST ONLY

ll_rows = dw_sheet_item.RowCount()

//Update item notes for each skid
For ll_row = 1 To ll_rows
	ll_skid_num = dw_sheet_item.Object.sheet_skid_num[ll_row]
	
	select	distinct nvl(production_sheet_item.prod_item_note, '')
	into		:ls_notes
	from		production_sheet_item,
			 	sheet_skid_detail   
	where  	production_sheet_item.prod_item_num = sheet_skid_detail.prod_item_num
	and    	sheet_skid_detail.sheet_skid_num = :ll_skid_num
	using		sqlca;
	
	If IsNull(ls_notes) Then ls_notes = ""
	
	//Do not stop if DB error. Just make ls_notes = ""
	If sqlca.sqlcode <> 0 Then
		ls_notes = ""
	End If
	
	dw_sheet_item.Object.notes[ll_row] = ls_notes //Populate notes/comments for each skid
	
	dw_sheet_item.SetItemStatus(ll_row, 0, Primary!, NotModified!)
Next
//Alex Gerlants. 04/05/2016. End
end event

type st_tswt from u_st within tabpage_sheet_ed
integer x = 2066
integer y = 851
integer width = 358
boolean bringtotop = true
string facename = "Arial"
long backcolor = 79741120
string text = "Total Gross WT:"
alignment alignment = center!
end type

type st_tit from u_st within tabpage_sheet_ed
integer x = 2066
integer y = 387
integer width = 234
integer height = 61
string facename = "Arial"
long backcolor = 79741120
string text = "Total Item:"
end type

type st_ti from statictext within tabpage_sheet_ed
integer x = 2066
integer y = 464
integer width = 377
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
boolean focusrectangle = false
end type

type st_tsw from statictext within tabpage_sheet_ed
integer x = 2066
integer y = 928
integer width = 358
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
boolean focusrectangle = false
end type

type st_tp from statictext within tabpage_sheet_ed
integer x = 2066
integer y = 611
integer width = 358
integer height = 61
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
boolean focusrectangle = false
end type

type st_tnt from statictext within tabpage_sheet_ed
integer x = 2066
integer y = 774
integer width = 333
integer height = 61
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
boolean focusrectangle = false
end type

type cb_addsheet from u_cb within tabpage_sheet_ed
integer x = 2059
integer y = 32
integer width = 351
integer height = 93
integer taborder = 11
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "&Add"
end type

event clicked;IF ii_ok_add < 1 THEN 
	MessageBox("Error", "please open an shipment first!", StopSign! )
	Return
END IF

Int li_status
li_status = wf_shipment_status()
IF li_status < 0 THEN Return
IF li_status = 0 THEN 
	MessageBox("Warning", "This shipment is done, no more new items can be added now!", StopSign!)
	Return
END IF

ii_display_mode = 1
ii_packing_number = 0

Long ll_customer, ll_row
ll_row = dw_shipment_detail.GetRow()
ll_customer = dw_shipment_detail.GetItemNumber(ll_row, "customer_id", Primary!, FALSE)
IF ll_customer < 1 THEN
	MessageBox("Warning", "Select a SOLD TO customer first!", StopSign!)
	RETURN
END IF

OpenWithParm(w_shipment_skid_select, ll_customer)

end event

type cb_delsheet from u_cb within tabpage_sheet_ed
integer x = 2059
integer y = 147
integer width = 351
integer height = 93
integer taborder = 11
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "&Delete"
end type

event clicked;Int li_status
li_status = wf_shipment_status()
IF li_status < 0 THEN Return
IF li_status = 0 THEN 
	MessageBox("Warning", "This shipment is done, no item can be deleted now!", StopSign!)
	Return
END IF

integer li_rc
li_rc = MessageBox("Warning!", "Are you sure?", Exclamation!, OKCancel!, 2 )
IF Li_rc <> 1 THEN
	Return 0
END IF

tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.inv_rowmanager.of_DeleteRow(0)

//Do NOT need to reset item number
wf_show_total_wt()
end event

type cb_detailsheet from u_cb within tabpage_sheet_ed
integer x = 2059
integer y = 259
integer width = 351
integer height = 93
integer taborder = 11
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "De&tail"
end type

event clicked;Long ll_row, ll_skid

ll_Row = tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.GetRow()

IF ll_row < 1 THEN RETURN 0

ll_skid = tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.GetItemNumber(ll_row, "sheet_skid_num", Primary!, FALSE)

IF ll_skid < 1 THEN RETURN -1

OpenwithParm(w_shipping_skid_detail, ll_skid)
end event

type st_4 from statictext within tabpage_sheet_ed
integer x = 2066
integer y = 534
integer width = 252
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
string text = "Total PCs:"
boolean focusrectangle = false
end type

type st_5 from statictext within tabpage_sheet_ed
integer x = 2066
integer y = 688
integer width = 325
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
string text = "Total Net WT:"
boolean focusrectangle = false
end type

type tabpage_scrap_ed from userobject within tab_shiped_items
integer x = 15
integer y = 90
integer width = 2454
integer height = 1027
long backcolor = 79741120
string text = "Scrap Skid"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
string picturename = "ArrangeIcons!"
long picturemaskcolor = 553648127
st_16 st_16
st_3 st_3
st_scti st_scti
st_sctw st_sctw
st_stnt st_stnt
cb_addscrap cb_addscrap
cb_delscrap cb_delscrap
cb_detailscrap cb_detailscrap
dw_scrap_item dw_scrap_item
st_1 st_1
end type

on tabpage_scrap_ed.create
this.st_16=create st_16
this.st_3=create st_3
this.st_scti=create st_scti
this.st_sctw=create st_sctw
this.st_stnt=create st_stnt
this.cb_addscrap=create cb_addscrap
this.cb_delscrap=create cb_delscrap
this.cb_detailscrap=create cb_detailscrap
this.dw_scrap_item=create dw_scrap_item
this.st_1=create st_1
this.Control[]={this.st_16,&
this.st_3,&
this.st_scti,&
this.st_sctw,&
this.st_stnt,&
this.cb_addscrap,&
this.cb_delscrap,&
this.cb_detailscrap,&
this.dw_scrap_item,&
this.st_1}
end on

on tabpage_scrap_ed.destroy
destroy(this.st_16)
destroy(this.st_3)
destroy(this.st_scti)
destroy(this.st_sctw)
destroy(this.st_stnt)
destroy(this.cb_addscrap)
destroy(this.cb_delscrap)
destroy(this.cb_detailscrap)
destroy(this.dw_scrap_item)
destroy(this.st_1)
end on

type st_16 from u_st within tabpage_scrap_ed
integer x = 2063
integer y = 672
integer width = 358
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 12632256
string text = "Total Gross WT:"
alignment alignment = center!
end type

type st_3 from statictext within tabpage_scrap_ed
integer x = 2055
integer y = 384
integer width = 256
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Total Item:"
boolean focusrectangle = false
end type

type st_scti from statictext within tabpage_scrap_ed
integer x = 2055
integer y = 451
integer width = 358
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
boolean focusrectangle = false
end type

type st_sctw from statictext within tabpage_scrap_ed
integer x = 2063
integer y = 749
integer width = 336
integer height = 67
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type st_stnt from statictext within tabpage_scrap_ed
integer x = 2055
integer y = 598
integer width = 322
integer height = 61
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
boolean focusrectangle = false
end type

type cb_addscrap from u_cb within tabpage_scrap_ed
integer x = 2055
integer y = 29
integer width = 351
integer height = 93
integer taborder = 11
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "&Add"
end type

event clicked;IF ii_ok_add < 1 THEN 
	MessageBox("Error", "please open an shipment first!", StopSign! )
	Return
END IF

Int li_status
li_status = wf_shipment_status()
IF li_status < 0 THEN Return
IF li_status = 0 THEN 
	MessageBox("Warning", "This shipment is done, no more new items can be added now!", StopSign!)
	Return
END IF

ii_display_mode = 1
ii_packing_number = 0

Long ll_customer, ll_row
ll_row = dw_shipment_detail.GetRow()
ll_customer = dw_shipment_detail.GetItemNumber(ll_row, "customer_id", Primary!, FALSE)
IF ll_customer < 1 THEN
	MessageBox("Warning", "Select a SOLD TO customer first!", StopSign!)
	RETURN
END IF

OpenWithParm(w_shipment_scrap_select, ll_customer)		

end event

type cb_delscrap from u_cb within tabpage_scrap_ed
integer x = 2055
integer y = 144
integer width = 351
integer height = 93
integer taborder = 11
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "&Delete"
end type

event clicked;Int li_status
li_status = wf_shipment_status()
IF li_status < 0 THEN Return
IF li_status = 0 THEN 
	MessageBox("Warning", "This shipment is done, no item can be deleted now!", StopSign!)
	Return
END IF

integer li_rc
li_rc = MessageBox("Warning!", "Are you sure?", Exclamation!, OKCancel!, 2 )
IF Li_rc <> 1 THEN
	Return 0
END IF

tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.inv_rowmanager.of_DeleteRow(0)

//Do NOT need to reset item number
wf_show_total_wt()
end event

type cb_detailscrap from u_cb within tabpage_scrap_ed
integer x = 2055
integer y = 256
integer width = 351
integer height = 93
integer taborder = 11
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "De&tail"
end type

event clicked;Long ll_row, ll_skid

ll_Row = tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.GetRow()

IF ll_row < 1 THEN RETURN 0

ll_skid = tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.GetItemNumber(ll_row, "scrap_skid_num", Primary!, FALSE)

IF ll_skid < 1 THEN RETURN -1

OpenwithParm(w_shipping_scrap_detail, ll_skid)
end event

type dw_scrap_item from u_dw within tabpage_scrap_ed
event type integer ue_fill_new_row ( long al_skid_num )
integer x = 26
integer y = 19
integer width = 2004
integer height = 957
integer taborder = 2
string dataobject = "d_scrap_packing_item"
boolean hscrollbar = true
end type

event type integer ue_fill_new_row(long al_skid_num);Long ll_row, ll_net, ll_tare, ll_job
String ls_temp, ls_alloy
Int li_tote_num

ll_row = this.GetRow()
IF ll_row <= 0 THEN Return -1

This.SetItem(ll_row,"sc_packing_item", wf_get_sh_packing_item_number()) 
This.SetItem(ll_row,"packing_list",  il_current_shippment) 
This.SetItem(ll_row,"scrap_skid_num",al_skid_num) 
//This.SetItem(ll_row,"scrap_packaging_ticket", f_get_next_value("sheet_packaging_ticket_seq") )
This.SetItem(ll_row,"scrap_packaging_ticket", al_skid_num )

CONNECT USING SQLCA;
SELECT scrap_net_wt, scrap_tare_wt, scrap_alloy2, scrap_temper, scrap_ab_job_num, tote_num
INTO :ll_net, :ll_tare, :ls_alloy, :ls_temp, :ll_job, :li_tote_num
FROM scrap_skid
WHERE scrap_skid_num = :al_skid_num
USING SQLCA;

This.SetItem(ll_row,"scrap_skid_scrap_net_wt", ll_net)
This.SetItem(ll_row,"scrap_skid_scrap_tare_wt", ll_tare)
This.SetItem(ll_row,"scrap_skid_scrap_alloy2", ls_alloy)
This.SetItem(ll_row,"scrap_skid_scrap_temper", ls_temp)
This.SetItem(ll_row,"scrap_skid_scrap_ab_job_num", ll_job)
This.SetItem(ll_row,"scrap_skid_tote_num", li_tote_num)

Return 1
end event

event constructor;call super::constructor;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetRowFocusIndicator(FocusRect!)
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
IF li_row < 1 THEN RETURN
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.event pfc_rowchanged()
end event

event doubleclicked;tab_shiped_items.tabpage_scrap_ed.cb_detailscrap.Event Clicked()
end event

type st_1 from statictext within tabpage_scrap_ed
integer x = 2055
integer y = 525
integer width = 307
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
boolean enabled = false
string text = "Total Net WT:"
boolean focusrectangle = false
end type

type tabpage_rej_coil_ed from userobject within tab_shiped_items
integer x = 15
integer y = 90
integer width = 2454
integer height = 1027
long backcolor = 79741120
string text = "Rejected/Return Coil"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
string picturename = "CheckStatus!"
long picturemaskcolor = 553648127
dw_rej_coil_item dw_rej_coil_item
st_17 st_17
st_20 st_20
st_rti st_rti
st_rtw st_rtw
cb_addcoil cb_addcoil
cb_delcoil cb_delcoil
cb_detailcoil cb_detailcoil
end type

on tabpage_rej_coil_ed.create
this.dw_rej_coil_item=create dw_rej_coil_item
this.st_17=create st_17
this.st_20=create st_20
this.st_rti=create st_rti
this.st_rtw=create st_rtw
this.cb_addcoil=create cb_addcoil
this.cb_delcoil=create cb_delcoil
this.cb_detailcoil=create cb_detailcoil
this.Control[]={this.dw_rej_coil_item,&
this.st_17,&
this.st_20,&
this.st_rti,&
this.st_rtw,&
this.cb_addcoil,&
this.cb_delcoil,&
this.cb_detailcoil}
end on

on tabpage_rej_coil_ed.destroy
destroy(this.dw_rej_coil_item)
destroy(this.st_17)
destroy(this.st_20)
destroy(this.st_rti)
destroy(this.st_rtw)
destroy(this.cb_addcoil)
destroy(this.cb_delcoil)
destroy(this.cb_detailcoil)
end on

type dw_rej_coil_item from u_dw within tabpage_rej_coil_ed
event type integer ue_fill_new_row ( long al_coil_num )
integer x = 15
integer y = 29
integer width = 2011
integer height = 973
integer taborder = 2
string dataobject = "d_rej_coil_packing_item"
boolean hscrollbar = true
end type

event ue_fill_new_row;Long ll_row, ll_netbal
Real lr_gauge
String ls_org, ls_mid, ls_temp, ls_lot, ls_alloy

ll_row = this.GetRow()
IF ll_row <= 0 THEN Return -1

This.SetItem(ll_row,"rej_coil_packing_item", wf_get_sh_packing_item_number()) 
This.SetItem(ll_row,"packing_list",  il_current_shippment) 
This.SetItem(ll_row,"coil_abc_num",al_coil_num) 
This.SetItem(ll_row,"rej_coil_packaging_ticket", f_get_next_value("sheet_packaging_ticket_seq") )

CONNECT USING SQLCA;
SELECT coil_org_num, coil_mid_num, coil_alloy2, coil_temper, lot_num, coil_gauge, net_wt_balance
INTO :ls_org, :ls_mid, :ls_alloy, :ls_temp, :ls_lot, :lr_gauge, :ll_netbal
FROM coil
WHERE coil_abc_num = :al_coil_num
USING SQLCA;

This.SetItem(ll_row,"coil_coil_org_num", ls_org)
This.SetItem(ll_row,"coil_coil_mid_num", ls_mid)
This.SetItem(ll_row,"coil_coil_alloy2",ls_alloy)
This.SetItem(ll_row,"coil_coil_temper", ls_temp)
This.SetItem(ll_row,"coil_lot_num", ls_lot)
This.SetItem(ll_row,"coil_coil_gauge", lr_gauge)
This.SetItem(ll_row,"coil_net_wt_balance", ll_netbal)

Return 1
end event

event constructor;call super::constructor;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetRowFocusIndicator(FocusRect!)
end event

event rbuttondown;//Override
Return 0
end event

event rbuttonup;//Override
Return 0
end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

This.AcceptText()
li_Row = this.GetRow()
IF li_row < 1 THEN RETURN
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.event pfc_rowchanged()
end event

event doubleclicked;tab_shiped_items.tabpage_rej_coil_ed.cb_detailcoil.Event Clicked()
end event

type st_17 from u_st within tabpage_rej_coil_ed
integer x = 2066
integer y = 554
integer width = 230
integer height = 61
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 12632256
string text = "Total WT:"
alignment alignment = center!
end type

type st_20 from statictext within tabpage_rej_coil_ed
integer x = 2066
integer y = 419
integer width = 234
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Total Item:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_rti from statictext within tabpage_rej_coil_ed
integer x = 2066
integer y = 480
integer width = 165
integer height = 74
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type st_rtw from statictext within tabpage_rej_coil_ed
integer x = 2066
integer y = 611
integer width = 336
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type cb_addcoil from u_cb within tabpage_rej_coil_ed
integer x = 2052
integer y = 35
integer width = 322
integer height = 93
integer taborder = 11
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "&Add"
end type

event clicked;IF ii_ok_add < 1 THEN 
	MessageBox("Error", "please open an shipment first!", StopSign! )
	Return
END IF

Int li_status
li_status = wf_shipment_status()
IF li_status < 0 THEN Return
IF li_status = 0 THEN 
	MessageBox("Warning", "This shipment is done, no more new items can be added now!", StopSign!)
	Return
END IF

ii_display_mode = 1
ii_packing_number = 0

Long ll_customer, ll_row
ll_row = dw_shipment_detail.GetRow()
ll_customer = dw_shipment_detail.GetItemNumber(ll_row, "customer_id", Primary!, FALSE)
IF ll_customer < 1 THEN
	MessageBox("Warning", "Select a SOLD TO customer first!", StopSign!)
	RETURN
END IF

OpenWithParm(w_shipment_rej_coil_select, ll_customer)

end event

type cb_delcoil from u_cb within tabpage_rej_coil_ed
integer x = 2052
integer y = 157
integer width = 322
integer height = 93
integer taborder = 11
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "&Delete"
end type

event clicked;Int li_status
li_status = wf_shipment_status()
IF li_status < 0 THEN Return
IF li_status = 0 THEN 
	MessageBox("Warning", "This shipment is done, no item can be deleted now!", StopSign!)
	Return
END IF

integer li_rc
li_rc = MessageBox("Warning!", "Are you sure?", Exclamation!, OKCancel!, 2 )
IF Li_rc <> 1 THEN
	Return 0
END IF

tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.inv_rowmanager.of_DeleteRow(0)

//Do NOT need to reset item number
wf_show_total_wt()
end event

type cb_detailcoil from u_cb within tabpage_rej_coil_ed
integer x = 2052
integer y = 282
integer width = 322
integer height = 93
integer taborder = 11
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "De&tail"
end type

event clicked;Long ll_row, ll_coil

ll_Row = tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.GetRow()

IF ll_row < 1 THEN RETURN 0

ll_coil = tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.GetItemNumber(ll_row, "coil_abc_num", Primary!, FALSE)

IF ll_coil < 1 THEN RETURN -1

OpenwithParm(w_shipping_rejcoil_detail, ll_coil)
end event

type tabpage_wh_ed from userobject within tab_shiped_items
integer x = 15
integer y = 90
integer width = 2454
integer height = 1027
long backcolor = 12632256
string text = "Warehouse"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
string picturename = "Library!"
long picturemaskcolor = 553648127
st_18 st_18
st_21 st_21
st_whti st_whti
st_whtw st_whtw
st_whnt st_whnt
cb_addwh cb_addwh
cb_delwh cb_delwh
cb_detailwh cb_detailwh
dw_wh_item dw_wh_item
st_6 st_6
st_9 st_9
st_whtp st_whtp
end type

on tabpage_wh_ed.create
this.st_18=create st_18
this.st_21=create st_21
this.st_whti=create st_whti
this.st_whtw=create st_whtw
this.st_whnt=create st_whnt
this.cb_addwh=create cb_addwh
this.cb_delwh=create cb_delwh
this.cb_detailwh=create cb_detailwh
this.dw_wh_item=create dw_wh_item
this.st_6=create st_6
this.st_9=create st_9
this.st_whtp=create st_whtp
this.Control[]={this.st_18,&
this.st_21,&
this.st_whti,&
this.st_whtw,&
this.st_whnt,&
this.cb_addwh,&
this.cb_delwh,&
this.cb_detailwh,&
this.dw_wh_item,&
this.st_6,&
this.st_9,&
this.st_whtp}
end on

on tabpage_wh_ed.destroy
destroy(this.st_18)
destroy(this.st_21)
destroy(this.st_whti)
destroy(this.st_whtw)
destroy(this.st_whnt)
destroy(this.cb_addwh)
destroy(this.cb_delwh)
destroy(this.cb_detailwh)
destroy(this.dw_wh_item)
destroy(this.st_6)
destroy(this.st_9)
destroy(this.st_whtp)
end on

type st_18 from u_st within tabpage_wh_ed
integer x = 2074
integer y = 688
integer width = 358
integer height = 58
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Total Gross WT:"
alignment alignment = center!
end type

type st_21 from statictext within tabpage_wh_ed
integer x = 2074
integer y = 406
integer width = 234
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Total Item:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_whti from statictext within tabpage_wh_ed
integer x = 2074
integer y = 474
integer width = 282
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "    "
boolean focusrectangle = false
end type

type st_whtw from statictext within tabpage_wh_ed
integer x = 2074
integer y = 749
integer width = 351
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
boolean focusrectangle = false
end type

type st_whnt from statictext within tabpage_wh_ed
integer x = 2074
integer y = 621
integer width = 362
integer height = 61
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
boolean focusrectangle = false
end type

type cb_addwh from u_cb within tabpage_wh_ed
integer x = 2070
integer y = 32
integer width = 351
integer height = 93
integer taborder = 11
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "&Add"
end type

event clicked;IF ii_ok_add < 1 THEN 
	MessageBox("Error", "please open an shipment first!", StopSign! )
	Return
END IF

Int li_status
li_status = wf_shipment_status()
IF li_status < 0 THEN Return
IF li_status = 0 THEN 
	MessageBox("Warning", "This shipment is done, no more new items can be added now!", StopSign!)
	Return
END IF

ii_display_mode = 1
ii_packing_number = 0

Long ll_customer, ll_row
ll_row = dw_shipment_detail.GetRow()
ll_customer = dw_shipment_detail.GetItemNumber(ll_row, "customer_id", Primary!, FALSE)
IF ll_customer < 1 THEN
	MessageBox("Warning", "Select a SOLD TO customer first!", StopSign!)
	RETURN
END IF

OpenWithParm(w_shipment_wh_select, ll_customer)

end event

type cb_delwh from u_cb within tabpage_wh_ed
integer x = 2070
integer y = 154
integer width = 351
integer height = 93
integer taborder = 11
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "&Delete"
end type

event clicked;Int li_status
li_status = wf_shipment_status()
IF li_status < 0 THEN Return
IF li_status = 0 THEN 
	MessageBox("Warning", "This shipment is done, no item can be deleted now!", StopSign!)
	Return
END IF

integer li_rc
li_rc = MessageBox("Warning!", "Are you sure?", Exclamation!, OKCancel!, 2 )
IF Li_rc <> 1 THEN
	Return 0
END IF

tab_shiped_items.tabpage_wh_ed.dw_wh_item.inv_rowmanager.of_DeleteRow(0)

//Do NOT need to reset item number
wf_show_total_wt()
end event

type cb_detailwh from u_cb within tabpage_wh_ed
integer x = 2070
integer y = 272
integer width = 351
integer height = 93
integer taborder = 11
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "De&tail"
end type

event clicked;Long ll_row, ll_skid

ll_Row = tab_shiped_items.tabpage_wh_ed.dw_wh_item.GetRow()

IF ll_row < 1 THEN RETURN 0

ll_skid = tab_shiped_items.tabpage_wh_ed.dw_wh_item.GetItemNumber(ll_row, "sheet_skid_num", Primary!, FALSE)

IF ll_skid < 1 THEN RETURN -1

OpenwithParm(w_shipping_skid_detail, ll_skid)
end event

type dw_wh_item from u_dw within tabpage_wh_ed
event type integer ue_fill_new_row ( long al_skid )
integer x = 15
integer y = 26
integer width = 2026
integer height = 970
integer taborder = 2
string dataobject = "d_wh_packing_item"
boolean hscrollbar = true
end type

event ue_fill_new_row;Long ll_row
Long ll_p, ll_net, ll_tare
Int li_status

ll_row = this.GetRow()
IF ll_row <= 0 THEN Return -1

This.SetItem(ll_row,"sh_packing_item", wf_get_sh_packing_item_number()) 
This.SetItem(ll_row,"packing_list",  il_current_shippment) 
This.SetItem(ll_row,"sheet_skid_num",al_skid)
//This.SetItem(ll_row,"sheet_packaging_ticket", wf_new_packaging_ticket#() )
//This.SetItem(ll_row,"sheet_packaging_ticket", f_get_next_value("sheet_packaging_ticket_seq") )
This.SetItem(ll_row,"sheet_packaging_ticket", al_skid )

CONNECT USING SQLCA;
SELECT sheet_net_wt, sheet_tare_wt, skid_pieces, skid_sheet_status
INTO :ll_net, :ll_tare, :ll_p, :li_status
FROM sheet_skid
WHERE sheet_skid_num = :al_skid
USING SQLCA;

This.SetItem(ll_row,"sheet_skid_skid_pieces",ll_p)
This.SetItem(ll_row,"sheet_skid_sheet_net_wt",ll_net)
This.SetItem(ll_row,"sheet_skid_sheet_tare_wt",ll_tare)
This.SetItem(ll_row,"sheet_skid_skid_sheet_status",li_status)

Return 1
end event

event constructor;call super::constructor;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetRowFocusIndicator(FocusRect!)
end event

event rbuttondown;//Override
Return 0
end event

event rbuttonup;//Override
Return 0
end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

this.AcceptText()
li_Row = this.GetRow()
IF li_row < 1 THEN RETURN
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.event pfc_rowchanged()
end event

event doubleclicked;tab_shiped_items.tabpage_wh_ed.cb_detailwh.Event Clicked()
end event

type st_6 from statictext within tabpage_wh_ed
integer x = 2074
integer y = 538
integer width = 307
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
boolean enabled = false
string text = "Total Net WT:"
boolean focusrectangle = false
end type

type st_9 from statictext within tabpage_wh_ed
integer x = 2074
integer y = 813
integer width = 252
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
string text = "Total PCs:"
boolean focusrectangle = false
end type

type st_whtp from statictext within tabpage_wh_ed
integer x = 2074
integer y = 877
integer width = 252
integer height = 58
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
boolean focusrectangle = false
end type

type st_19 from u_st within w_shipping_2_disabled_buttons
integer x = 2970
integer y = 1389
integer width = 230
string text = "Total WT:"
end type

type st_shipmentwt from u_st within w_shipping_2_disabled_buttons
integer x = 2970
integer y = 1450
integer width = 293
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = ""
end type

type cb_print from commandbutton within w_shipping_2_disabled_buttons
string tag = "print documents"
integer x = 2205
integer y = 1626
integer width = 336
integer height = 93
integer taborder = 90
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Print..."
end type

event clicked;Parent.Event pfc_print()
end event

type dw_shipment_detail from u_dw within w_shipping_2_disabled_buttons
event ue_fix_soldto ( long al_shipmentwt )
integer x = 391
integer y = 86
integer width = 2937
integer height = 406
integer taborder = 10
boolean enabled = false
string dataobject = "d_shipment_detail"
boolean vscrollbar = false
end type

event ue_fix_soldto;IF al_shipmentwt > 0 THEN
	this.Modify("customer_id.protect = 1")
ELSE
	this.Modify("customer_id.protect = 0")
END IF
end event

event constructor;DataWindowChild ldddw_cni

IF this.GetChild("dws_sh_cust_id", ldddw_cni) = -1 THEN 
	Return -1
ELSE
	this.Event pfc_PopulateDDDW("des_sh_cust_id", ldddw_cni)
END IF
IF this.GetChild("customer_id", ldddw_cni) = -1 THEN 
	Return -2
ELSE
	this.Event pfc_PopulateDDDW("customer_id", ldddw_cni)
END IF
IF this.GetChild("shipment_enduser_id", ldddw_cni) = -1 THEN 
	Return -3
ELSE
	this.Event pfc_PopulateDDDW("shipment_enduser_id", ldddw_cni)
END IF
IF this.GetChild("carrier_description_code", ldddw_cni) = -1 THEN 
	Return -4
ELSE
	this.Event pfc_PopulateDDDW("carrier_description_code", ldddw_cni)
END IF
IF this.GetChild("transportation_method_code", ldddw_cni) = -1 THEN 
	Return -5
ELSE
	this.Event pfc_PopulateDDDW("transportation_method_code", ldddw_cni)
END IF

end event

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve(il_current_shippment)
end event

event pfc_retrievedddw;call super::pfc_retrievedddw;DataWindowChild dddw_cni

IF this.GetChild(as_column, dddw_cni) = -1 THEN
	Return -1
ELSE
	dddw_cni.SetTransObject(SQLCA)
	
	IF il_current_customer <= 0 THEN Return -1
	
	Return dddw_cni.Retrieve(il_current_customer) 
END IF
end event

event rbuttondown;//disbaled
Return 0
end event

event rbuttonup;//disbaled
Return 0
end event

event pfc_addrow;call super::pfc_addrow;Int li_rc
Long ll_packinglist, ll_row
Long ll_new_packlist, ll_new_billoflading
Long ll_customer, ll_carrier

ll_new_packlist = f_get_next_value("packing_list_num_seq")
ll_new_billoflading = f_get_next_value("bill_of_lading_seq")

IF ib_newstop THEN
	st_multistop.Text = "Multi Stop"
	ddlb_packinglist.SelectItem(ddlb_packinglist.AddItem(String(ll_new_packlist)))
	il_bol = istr_shipinfo.bol
ELSE
	st_multistop.Text = "Single Stop"
	st_bol.Text = String(ll_new_packlist)
	ddlb_packinglist.Reset()
	ddlb_packinglist.AddItem(String(ll_new_packlist))
	ddlb_packinglist.SelectItem(1)
	st_bol.Text = String(ll_new_billoflading)
	gb_bol.text = "BOL#: " + String(ll_new_packlist)
	il_bol = ll_new_billoflading
END IF

ll_row = this.Getrow()
this.SetItem(ll_row, "bill_of_lading", il_bol )
IF ib_newstop THEN
	this.SetItem(ll_row, "customer_id", istr_shipinfo.cust_id )
	this.SetItem(ll_row, "carrier_id", istr_shipinfo.carrier_id )
	this.SetItem(ll_row, "vehicle_id", istr_shipinfo.vehicle_id )
	this.SetItem(ll_row, "carrier_initial", istr_shipinfo.carrier_initial )
	this.SetItem(ll_row, "vehicle_id_prefix", istr_shipinfo.vehicle_id_prefix )
ELSE
	ib_new_shipment = TRUE
	this.SetItem(ll_row, "customer_id", 0 )
	this.SetItem(ll_row, "carrier_id", 0 )
	this.SetItem(ll_row, "vehicle_id", "" )
	this.SetItem(ll_row, "carrier_initial", "" )
	this.SetItem(ll_row, "vehicle_id_prefix", "" )
END IF
this.SetItem(ll_row, "packing_list", ll_new_packlist )
this.SetItem(ll_row, "shipment_status", 2)
this.SetItem(ll_row, "vehicle_status", 2)
this.SetItem(ll_row, "des_sh_cust_id", 0)
this.SetItem(ll_row, "shipment_enduser_id", 0)
this.SetItem(ll_row, "transportation_method_code", "MOTOR")
this.SetItem(ll_row, "carrier_description_code", "TL")
this.SetItem(ll_row, "shipment_scheduled_date_time", Today())

tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.Reset()
tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.Reset()
tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.Reset()
tab_shiped_items.tabpage_wh_ed.dw_wh_item.Reset()
wf_reset_display_info()

il_current_shippment = ll_new_packlist
this.SetFocus()
ii_ok_add = 1

Return 1
end event

event pfc_populatedddw;call super::pfc_populatedddw;IF adwc_obj.SetTransObject(SQLCA) = -1 THEN  
	Return -1  
ELSE  
	IF il_current_customer <= 0 THEN Return -2
	Return adwc_obj.Retrieve(il_current_customer)  
END IF
end event

event itemchanged;call super::itemchanged;//Alex Gerlants. 04/05/2016. Begin
Integer	li_rtn
Long		ll_rows, ll_row
String	ls_shipment_status, ls_column_name, ls_note, ls_notes[]


ls_column_name = dwo.name

If ls_column_name = "shipment_status" Then
	tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.AcceptText()
	
	ls_shipment_status = data
	
	If ls_shipment_status = "0" Then //Status = "Done"
		//Disable column notes for all skids
		tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.Modify("notes.tabsequence = '0'")
		tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.Modify("notes.pointer = 'Arrow!'")
		tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.Modify("notes.Background.Color = '67108864'") //Button face color
	Else
		//Allow editing
		tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.Modify("notes.tabsequence = '10'")
		tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.Modify("notes.pointer = 'IBeam!'")
		tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.Modify("notes.Background.Color = '16777215'") //White color
	End If
End If

	
end event

type st_2 from u_st within w_shipping_2_disabled_buttons
integer x = 2970
integer y = 1216
integer width = 263
string text = "Total items:"
end type

type st_shipmentitem from u_st within w_shipping_2_disabled_buttons
integer x = 2970
integer y = 1283
integer width = 249
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = ""
alignment alignment = center!
end type

type st_12 from statictext within w_shipping_2_disabled_buttons
integer x = 2970
integer y = 525
integer width = 260
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
string text = "Sheet Skid:"
boolean focusrectangle = false
end type

type st_ti1 from statictext within w_shipping_2_disabled_buttons
integer x = 2970
integer y = 614
integer width = 249
integer height = 61
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
alignment alignment = center!
boolean focusrectangle = false
end type

type st_13 from statictext within w_shipping_2_disabled_buttons
integer x = 2970
integer y = 698
integer width = 260
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
string text = "Scrap Skid:"
boolean focusrectangle = false
end type

type st_scti1 from statictext within w_shipping_2_disabled_buttons
integer x = 2970
integer y = 781
integer width = 249
integer height = 61
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
alignment alignment = center!
boolean focusrectangle = false
end type

type st_14 from statictext within w_shipping_2_disabled_buttons
integer x = 2970
integer y = 867
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
string text = "Rej./Ret. Coil:"
boolean focusrectangle = false
end type

type st_rti1 from statictext within w_shipping_2_disabled_buttons
integer x = 2970
integer y = 950
integer width = 249
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_15 from statictext within w_shipping_2_disabled_buttons
integer x = 2970
integer y = 1030
integer width = 252
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
string text = "Warehouse"
boolean focusrectangle = false
end type

type st_whti1 from statictext within w_shipping_2_disabled_buttons
integer x = 2970
integer y = 1110
integer width = 249
integer height = 61
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
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_revise from commandbutton within w_shipping_2_disabled_buttons
string tag = "Reverse a shipment"
integer x = 2553
integer y = 1626
integer width = 336
integer height = 93
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Reverse"
end type

event constructor;IF f_security_door("Shipment(Rehash)") = 1 THEN
	this.Enabled = TRUE
ELSE
	this.Enabled = FALSE
END IF

end event

event clicked;RETURN Parent.Event ue_reverse()
end event

type st_7 from statictext within w_shipping_2_disabled_buttons
integer x = 22
integer y = 13
integer width = 336
integer height = 61
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
string text = "Master BOL#:"
boolean focusrectangle = false
end type

type st_bol from statictext within w_shipping_2_disabled_buttons
integer x = 51
integer y = 77
integer width = 252
integer height = 64
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
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_8 from statictext within w_shipping_2_disabled_buttons
integer x = 22
integer y = 144
integer width = 336
integer height = 64
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
string text = "BOL#:"
boolean focusrectangle = false
end type

type ddlb_packinglist from u_ddlb within w_shipping_2_disabled_buttons
integer x = 22
integer y = 211
integer width = 318
integer height = 698
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
boolean allowedit = true
boolean autohscroll = true
boolean showlist = true
boolean hscrollbar = true
end type

event selectionchanged;SetPointer(HourGlass!)
String ls_text
Int li_rc

ls_text = Text(index)
il_current_shippment = Long(ls_text)
gb_bol.text = "BOL#: " + String(il_current_shippment)
ii_display_mode = 0

IF ii_ok_add <> 0 THEN 
	dw_shipment_detail.inv_Linkage.of_Reset()
END IF

dw_shipment_detail.inv_Linkage.of_SetTransObject(sqlca) 
IF dw_shipment_detail.inv_linkage.of_retrieve() = -1 THEN
	SQLCA.of_Rollback()
	MessageBox("Error", "w_shipping::ddlb_packinglist selectionchange event" )
	Return 0
ELSE
	SQLCA.of_Commit()
	dw_shipment_detail.SetFocus()
	ii_ok_add = 1
	wf_show_total_wt()
	wf_display_when_done()
	wf_check_multi_stop()
End IF
Return 1
end event

event rbuttonup;//Override
RETURN 0
end event

event getfocus;call super::getfocus;Int li_rc

dw_shipment_detail.AcceptText()
tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.AcceptText()
tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.AcceptText()
tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.AcceptText()
tab_shiped_items.tabpage_wh_ed.dw_wh_item.AcceptText()

IF dw_shipment_detail.inv_Linkage.of_GetUpdatesPending() = 1 THEN
	IF ib_newstop THEN
		li_rc = MessageBox("Warning", "This new stop has NOT been saved! Save it now?",Question!, YesNo!, 2) 	
		CHOOSE CASE li_rc
			CASE 1 //yes
				parent.Event pfc_save()
			CASE ELSE
				dw_shipment_detail.inv_Linkage.of_ResetUpdate()
				dw_shipment_detail.inv_Linkage.of_Reset()
				wf_reset_orig_shipment()
		END CHOOSE
	END IF
	IF ib_new_shipment THEN
		li_rc = MessageBox("Warning", "This new shipment has NOT been saved! Save it now?",Question!, YesNo!, 2) 	
		CHOOSE CASE li_rc
			CASE 1 //yes
				parent.Event pfc_save()
			CASE ELSE
				dw_shipment_detail.inv_Linkage.of_ResetUpdate()
		END CHOOSE
	END IF
	IF NOT(ib_new_shipment) AND NOT(ib_newstop) THEN
		li_rc = MessageBox("Warning", "Shipment information has NOT been saved! Save it now?",Question!, YesNo!, 2) 	
		CHOOSE CASE li_rc
			CASE 1 //yes
				parent.Event pfc_save()
			CASE ELSE
				dw_shipment_detail.inv_Linkage.of_ResetUpdate()
		END CHOOSE
	END IF	
END IF

end event

type st_multistop from statictext within w_shipping_2_disabled_buttons
integer y = 941
integer width = 245
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
string text = "Single Stop"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_newstop from commandbutton within w_shipping_2_disabled_buttons
string tag = "Create a new stop for this shipment"
integer x = 1159
integer y = 1626
integer width = 336
integer height = 93
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "N&ew Stop/BOL"
end type

event clicked;IF wf_shipment_status() = 0 THEN
	MessageBox("Warning", "Shipment is gone.", StopSign! )
	RETURN 0
END IF
ib_newstop = TRUE
Parent.Event pfc_new()
tab_shiped_items.tabpage_sheet_ed.dw_sheet_item.Reset()
tab_shiped_items.tabpage_scrap_ed.dw_scrap_item.Reset()
tab_shiped_items.tabpage_rej_coil_ed.dw_rej_coil_item.Reset()
tab_shiped_items.tabpage_wh_ed.dw_wh_item.Reset()

end event

type gb_bol from groupbox within w_shipping_2_disabled_buttons
integer x = 377
integer y = 26
integer width = 2966
integer height = 1709
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "BOL"
end type

