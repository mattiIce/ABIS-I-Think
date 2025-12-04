$PBExportHeader$w_scrap_skid_detail_info.srw
$PBExportComments$<Response> display all information about a scrap skid inherited from pfemain/w_response
forward
global type w_scrap_skid_detail_info from w_response
end type
type cb_close from u_cb within w_scrap_skid_detail_info
end type
type dw_detail from u_dw within w_scrap_skid_detail_info
end type
end forward

global type w_scrap_skid_detail_info from w_response
int X=1181
int Y=269
int Width=1635
int Height=1571
boolean TitleBar=true
string Title="Coil Reference Window"
cb_close cb_close
dw_detail dw_detail
end type
global w_scrap_skid_detail_info w_scrap_skid_detail_info

type variables
Long il_skid
Long il_job
end variables

forward prototypes
public subroutine wf_skid_detail (long al_skid)
public subroutine wf_skid_item_detail (long al_item, integer al_id)
public subroutine wf_shipment_detail (long al_skid)
end prototypes

public subroutine wf_skid_detail (long al_skid);String ls_status, ls_line
Long ll_net, ll_tare
Int li_status
Long ll_c
String ls_modstring
DataStore lds_item
Long ll_row, ll_r

dw_detail.Reset()
ls_modstring = "item_t.Text = ~"Scrap Skid Detail~""
dw_detail.Modify(ls_modstring) 

CONNECT USING SQLCA;
SELECT scrap_net_wt, scrap_tare_wt, skid_scrap_status
INTO :ll_net, :ll_tare, :li_status
FROM scrap_skid
WHERE scrap_skid_num = :al_skid
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
END CHOOSE

ll_c = dw_detail.InsertRow(0)
dw_detail.SetItem(ll_c, "item", "Skid Net WT:")
dw_detail.setItem(ll_c, "value", String(ll_net, "##,###,###"))
ll_c = dw_detail.InsertRow(0)
dw_detail.SetItem(ll_c, "item", "Skid Tare WT:")
dw_detail.setItem(ll_c, "value", String(ll_tare,"###,###"))
ll_c = dw_detail.InsertRow(0)
dw_detail.SetItem(ll_c, "item", "Status:")
dw_detail.setItem(ll_c, "value", ls_status)

lds_item = Create DataStore
lds_item.DataObject = "d_scrap_skid_item_list_datastore"
lds_item.SetTransObject(SQLCA)
lds_item.Retrieve(al_skid)
ll_row = lds_item.RowCount()
IF ll_row > 0 THEN
	FOR ll_r = 1 TO ll_row
		wf_skid_item_detail(lds_item.GetItemNumber(ll_r, "return_scrap_item_num"), ll_r)
	NEXT
END IF
DESTROY lds_item

wf_shipment_detail(al_skid)

dw_detail.AcceptText()
dw_detail.ResetUpdate()
end subroutine

public subroutine wf_skid_item_detail (long al_item, integer al_id);Long ll_c
Long ll_net, ll_coil, ll_job

CONNECT USING SQLCA;
SELECT coil_abc_num, ab_job_num, return_item_net_wt 
INTO :ll_coil, :ll_job, :ll_net
FROM return_scrap_item
WHERE return_scrap_item_num = :al_item
USING SQLCA;

ll_c = dw_detail.InsertRow(0)
ll_c = dw_detail.InsertRow(0)
dw_detail.SetItem(ll_c, "item", "Item" + String(al_id) + " :")

ll_c = dw_detail.InsertRow(0)
dw_detail.SetItem(ll_c, "item", "Net WT:")
dw_detail.setItem(ll_c, "value", String(ll_net, "##,###,###"))
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
SELECT SCRAP_PACKING_ITEM.SCRAP_SKID_NUM, SHIPMENT.PACKING_LIST,SHIPMENT.SHIPMENT_SCHEDULED_DATE_TIME, SHIPMENT.des_sh_cust_id, SHIPMENT.SHIPMENT_ACTUALED_DATE_TIME,SHIPMENT.SHIPMENT_STATUS  
INTO	:ll_skid, :ll_shipment, :ld_sche, :ll_cust, :ld_actual, :li_status
FROM SCRAP_PACKING_ITEM, SHIPMENT  
WHERE SHIPMENT.PACKING_LIST = SCRAP_PACKING_ITEM.PACKING_LIST AND  SCRAP_PACKING_ITEM.SCRAP_SKID_NUM = :al_skid   
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

on w_scrap_skid_detail_info.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.dw_detail=create dw_detail
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.dw_detail
end on

on w_scrap_skid_detail_info.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.dw_detail)
end on

event open;call super::open;il_skid = message.DoubleParm
this.Title = "Scrap skid #" + String(il_skid) + "'s related info"
wf_skid_detail(il_skid)



end event

type cb_close from u_cb within w_scrap_skid_detail_info
int X=574
int Y=1379
int Height=80
int TabOrder=10
boolean BringToTop=true
string Text="&Close"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Close(Parent)
end event

type dw_detail from u_dw within w_scrap_skid_detail_info
int X=11
int Y=3
int Width=1595
int Height=1357
int TabOrder=20
boolean BringToTop=true
string DataObject="d_skid_detail_info_item_list"
end type

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
//inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)

end event

