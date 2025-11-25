$PBExportHeader$w_coil_detail_info.srw
$PBExportComments$<Response> display all information about a coil inherited from pfemain/w_response
forward
global type w_coil_detail_info from w_response
end type
type cb_close from u_cb within w_coil_detail_info
end type
type tv_coil from u_tv within w_coil_detail_info
end type
type dw_detail from u_dw within w_coil_detail_info
end type
end forward

global type w_coil_detail_info from w_response
integer x = 830
integer y = 342
integer width = 1997
integer height = 1478
string title = "Coil Reference Window"
cb_close cb_close
tv_coil tv_coil
dw_detail dw_detail
end type
global w_coil_detail_info w_coil_detail_info

type variables
Long il_coil
Long il_job
end variables

forward prototypes
public subroutine wf_coil_detail (long al_coil)
public subroutine wf_job_detail (long al_job)
public subroutine wf_skid_detail (long al_skid)
public subroutine wf_skid_item_detail (long al_item, integer al_id)
public subroutine wf_shipment_detail (long al_skid)
end prototypes

public subroutine wf_coil_detail (long al_coil);String ls_org_num, ls_lot_num, ls_status
Int li_status
Long ll_c, ll_shipment
String ls_modstring

dw_detail.Reset()
ls_modstring = "item_t.Text = ~"Coil Detail~""
dw_detail.Modify(ls_modstring) 

CONNECT USING SQLCA;
SELECT coil_org_num, lot_num, coil_status INTO :ls_org_num, :ls_lot_num, :li_status
FROM coil
WHERE coil_abc_num = :al_coil
USING SQLCA;
CHOOSE CASE li_status
	CASE 0
		ls_status = "Done"
	CASE 1
		ls_status = "Processing"
	CASE 2
		ls_status = "New"
	CASE 3
		ls_status = "Rejected"
	CASE 4
		ls_status = "OnHold"
	CASE 5
		ls_status = "InTransit"
	CASE 6
		ls_status = "Return"
	CASE 7
		ls_status = "Rebanded"
	CASE 8
		ls_status = "Retry"
	CASE 10
		ls_status = "Gone"
	//Alex Gerlants. 02/09/2017. Begin
	CASE 12
		ls_status = "Ready for Ownership Transfer"
	CASE 13
		ls_status = "Ownership Transferred"
	//Alex Gerlants. 02/09/2017. End
END CHOOSE

ll_c = dw_detail.InsertRow(0)
dw_detail.SetItem(ll_c, "item", "Original Number:")
dw_detail.setItem(ll_c, "value", ls_org_num)
ll_c = dw_detail.InsertRow(0)
dw_detail.SetItem(ll_c, "item", "Lot Number:")
dw_detail.setItem(ll_c, "value", ls_lot_num)
ll_c = dw_detail.InsertRow(0)
dw_detail.SetItem(ll_c, "item", "Status:")
dw_detail.setItem(ll_c, "value", ls_status)
ll_c = dw_detail.InsertRow(0)
IF li_status = 10 THEN  //shipped
	dw_detail.SetItem(ll_c, "item", "Shipment")
	SELECT packing_list INTO :ll_shipment
	FROM reject_coil_packing_item 
	WHERE coil_abc_num = :al_coil
	USING SQLCA;	
	dw_detail.setItem(ll_c, "value", String(ll_shipment))
END IF
		
dw_detail.AcceptText()
dw_detail.ResetUpdate()
end subroutine

public subroutine wf_job_detail (long al_job);DateTime ld_s, ld_e
String ls_status, ls_line
Long ll_order
Int li_status, li_line
Long ll_c
String ls_modstring

dw_detail.Reset()
ls_modstring = "item_t.Text = ~"AB Job Detail~""
dw_detail.Modify(ls_modstring) 

CONNECT USING SQLCA;
SELECT order_abc_num, time_date_started, time_date_finished, job_status, line_num INTO :ll_order, :ld_s, :ld_e, :li_status, :li_line
FROM ab_job
WHERE ab_job_num = :al_job
USING SQLCA;
SELECT line_desc INTO :ls_line
FROM line
WHERE line_num = :li_line
USING SQLCA;

CHOOSE CASE li_status
	CASE 0
		ls_status = "Done"
	CASE 1
		ls_status = "Processing"
	CASE 2
		ls_status = "New"
	CASE 3
		ls_status = "Canceled"
	CASE 4
		ls_status = "Q.C OnHold"
END CHOOSE

ll_c = dw_detail.InsertRow(0)
dw_detail.SetItem(ll_c, "item", "Customer Order:")
dw_detail.setItem(ll_c, "value", String(ll_order, "########"))
ll_c = dw_detail.InsertRow(0)
dw_detail.SetItem(ll_c, "item", "Line number:")
dw_detail.setItem(ll_c, "value", ls_line)
ll_c = dw_detail.InsertRow(0)
dw_detail.SetItem(ll_c, "item", "Time Started:")
dw_detail.setItem(ll_c, "value", String(ld_s, "MM/DD/YYYY HH:MM"))
ll_c = dw_detail.InsertRow(0)
dw_detail.SetItem(ll_c, "item", "Time Finished:")
dw_detail.setItem(ll_c, "value", String(ld_e, "MM/DD/YYYY HH:MM"))
ll_c = dw_detail.InsertRow(0)
dw_detail.SetItem(ll_c, "item", "Status:")
dw_detail.setItem(ll_c, "value", ls_status)

dw_detail.AcceptText()
dw_detail.ResetUpdate()
end subroutine

public subroutine wf_skid_detail (long al_skid);String ls_status, ls_line
Long ll_net, ll_tare, ll_pc 
Int li_status
Long ll_c
String ls_modstring
DataStore lds_item
Long ll_row, ll_r

dw_detail.Reset()
ls_modstring = "item_t.Text = ~"Skid Detail~""
dw_detail.Modify(ls_modstring) 

CONNECT USING SQLCA;
SELECT sheet_net_wt, sheet_tare_wt, skid_pieces, skid_sheet_status
INTO :ll_net, :ll_tare, :ll_pc, :li_status
FROM sheet_skid
WHERE sheet_skid_num = :al_skid
USING SQLCA;

CHOOSE CASE li_status
	CASE 0
		ls_status = "Gone"
	CASE 1
		ls_status = "InProcess"
	CASE 2
		ls_status = "Ready"
	CASE 3
		ls_status = "Canceled"
	CASE 4
		ls_status = "OnHold"
	CASE 5
		ls_status = "PreReCap"
	CASE 6
		ls_status = "TareOnly"
	CASE 7
		ls_status = "Partial"
END CHOOSE

ll_c = dw_detail.InsertRow(0)
dw_detail.SetItem(ll_c, "item", "Skid Net WT:")
dw_detail.setItem(ll_c, "value", String(ll_net, "##,###,###"))
ll_c = dw_detail.InsertRow(0)
dw_detail.SetItem(ll_c, "item", "Skid Tare WT:")
dw_detail.setItem(ll_c, "value", String(ll_tare,"###,###"))
ll_c = dw_detail.InsertRow(0)
dw_detail.SetItem(ll_c, "item", "Skid Pieces:")
dw_detail.setItem(ll_c, "value", String(ll_pc, "#,###,###"))
ll_c = dw_detail.InsertRow(0)
dw_detail.SetItem(ll_c, "item", "Status:")
dw_detail.setItem(ll_c, "value", ls_status)

lds_item = Create DataStore
lds_item.DataObject = "d_skid_item_list_datastore"
lds_item.SetTransObject(SQLCA)
lds_item.Retrieve(al_skid)
ll_row = lds_item.RowCount()
IF ll_row > 1 THEN
	FOR ll_r = 1 TO ll_row
		wf_skid_item_detail(lds_item.GetItemNumber(ll_r, "prod_item_num"), ll_r)
	NEXT
END IF
DESTROY lds_item

wf_shipment_detail(al_skid)

dw_detail.AcceptText()
dw_detail.ResetUpdate()
end subroutine

public subroutine wf_skid_item_detail (long al_item, integer al_id);Long ll_c
Long ll_net, ll_pc, ll_coil, ll_job

CONNECT USING SQLCA;
SELECT coil_abc_num, ab_job_num, prod_item_net_wt, prod_item_pieces 
INTO :ll_coil, :ll_job, :ll_net, :ll_pc
FROM production_sheet_item
WHERE prod_item_num = :al_item
USING SQLCA;

ll_c = dw_detail.InsertRow(0)
ll_c = dw_detail.InsertRow(0)
dw_detail.SetItem(ll_c, "item", "Item" + String(al_id) + " :")

ll_c = dw_detail.InsertRow(0)
dw_detail.SetItem(ll_c, "item", "Net WT:")
dw_detail.setItem(ll_c, "value", String(ll_net, "##,###,###"))
ll_c = dw_detail.InsertRow(0)
dw_detail.SetItem(ll_c, "item", "Pieces:")
dw_detail.setItem(ll_c, "value", String(ll_pc,"###,###"))
ll_c = dw_detail.InsertRow(0)
dw_detail.SetItem(ll_c, "item", "Coil:")
dw_detail.setItem(ll_c, "value", String(ll_coil,"########"))
ll_c = dw_detail.InsertRow(0)
dw_detail.SetItem(ll_c, "item", "AB Job:")
dw_detail.setItem(ll_c, "value", String(ll_job,"#######"))

end subroutine

public subroutine wf_shipment_detail (long al_skid);Long ll_c, ll_skid, ll_shipment, ll_cust
DateTime ld_sche, ld_actual
Int li_status
String ls_cust, ls_status

CONNECT USING SQLCA;
SELECT SHEET_PACKING_ITEM.SHEET_SKID_NUM, SHIPMENT.PACKING_LIST,SHIPMENT.SHIPMENT_SCHEDULED_DATE_TIME, SHIPMENT.des_sh_cust_id, SHIPMENT.SHIPMENT_ACTUALED_DATE_TIME,SHIPMENT.SHIPMENT_STATUS  
INTO	:ll_skid, :ll_shipment, :ld_sche, :ll_cust, :ld_actual, :li_status
FROM SHEET_PACKING_ITEM, SHIPMENT  
WHERE SHIPMENT.PACKING_LIST = SHEET_PACKING_ITEM.PACKING_LIST AND  SHEET_PACKING_ITEM.SHEET_SKID_NUM = :al_skid   
USING SQLCA;

IF ll_shipment > 0 THEN 
	ll_c = dw_detail.InsertRow(0)
	ll_c = dw_detail.InsertRow(0)

	ll_c = dw_detail.InsertRow(0)
	dw_detail.SetItem(ll_c, "item", "Shipment:")
	dw_detail.setItem(ll_c, "value", String(ll_shipment, "########"))
	IF ll_cust > 0 THEN
		SELECT customer_short_name INTO :ls_cust
		FROM customer
		WHERE customer_id = :ll_cust
		USING SQLCA;
		ll_c = dw_detail.InsertRow(0)
		dw_detail.SetItem(ll_c, "item", "Shipped TO:")
		dw_detail.setItem(ll_c, "value", ls_cust)
	END IF	
	ll_c = dw_detail.InsertRow(0)
	dw_detail.SetItem(ll_c, "item", "Schedule:")
	dw_detail.setItem(ll_c, "value", String(ld_sche,"MM/DD/YYYY hh:mm"))
	ll_c = dw_detail.InsertRow(0)
	dw_detail.SetItem(ll_c, "item", "Actual:")
	dw_detail.setItem(ll_c, "value", String(ld_actual,"MM/DD/YYYY hh:mm"))
	CHOOSE CASE li_status
		CASE 0
			ls_status = "Gone"
		CASE 1
			ls_status = "InProcess"
		CASE 2
			ls_status = "Ready"
		CASE 3
			ls_status = "Canceled"
		CASE 4
			ls_status = "OnHold"
	END CHOOSE
	ll_c = dw_detail.InsertRow(0)
	dw_detail.SetItem(ll_c, "item", "Status:")
	dw_detail.setItem(ll_c, "value", ls_status)
	
END IF

end subroutine

on w_coil_detail_info.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.tv_coil=create tv_coil
this.dw_detail=create dw_detail
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.tv_coil
this.Control[iCurrent+3]=this.dw_detail
end on

on w_coil_detail_info.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.tv_coil)
destroy(this.dw_detail)
end on

event open;call super::open;il_coil = message.DoubleParm
this.Title = "Coil #" + String(il_coil) + "'s details"
Long ll_arg_list[20]

tv_coil.of_SetDatasource(1, "d_coil_detail_info_coil", SQLCA, "f_display", "", False, 1,2)
tv_coil.of_SetDatasource(2, "d_coil_detail_info_job", SQLCA, "f_display", ":parent.1.coil_abc_num", FALSE, 3, 4)
tv_coil.of_SetDatasource(3, "d_coil_detail_info_skid", SQLCA, "f_display", ":parent.2.coil_abc_num, :parent.1.ab_job_num", FALSE,5,6)
//tv_coil.of_SetDatasource(4, "d_coil_detail_info_skid_item", SQLCA, "f_display", ":parent.1.sheet_skid_detail_sheet_skid_num", False, 7, 7)

ll_arg_list[1] = il_coil
tv_coil.of_InitialRetrieve(ll_arg_list)
tv_coil.SetFocus()




end event

type cb_close from u_cb within w_coil_detail_info
integer x = 753
integer y = 1283
integer width = 351
integer height = 80
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;Close(Parent)
end event

type tv_coil from u_tv within w_coil_detail_info
integer x = 29
integer y = 3
integer width = 757
integer height = 1267
integer taborder = 10
boolean bringtotop = true
string picturename[] = {"SelectTable!","DatabaseProfile!","Project!","DatabaseProfile5!","Horizontal!","Layer!","Cascade!"}
end type

event selectionchanged;Long ll_current, ll_return, ll_row
Long ll_coil, ll_job, ll_skid
TreeViewItem ltvi_item
n_ds lds_datastore


ll_current = this.FindItem(CurrentTreeItem!, 0)
ll_return = this.GetItem(ll_current, ltvi_item)
ll_return = this.of_GetDataStore(ltvi_item.level, lds_datastore)
ll_return = this.of_GetDataRow(ll_current, lds_datastore,ll_row)

CHOOSE CASE ltvi_item.level 
	CASE 1	//coil
 		ll_coil = lds_datastore.GetItemNumber(ll_row,"coil_abc_num")
		il_job = 0
		wf_coil_detail(ll_coil)
	CASE 2	//job
 		ll_job = lds_datastore.GetItemNumber(ll_row,"ab_job_num")
		il_job = ll_job
		wf_job_detail(ll_job)
	CASE 3	//skid
 		ll_skid = lds_datastore.GetItemNumber(ll_row,"sheet_skid_detail_sheet_skid_num")
		il_job = 0
		wf_skid_detail(ll_skid)
END CHOOSE

end event

type dw_detail from u_dw within w_coil_detail_info
integer x = 797
integer y = 3
integer width = 1159
integer height = 1267
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_coil_detail_info_item_list"
end type

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
//inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)

end event

