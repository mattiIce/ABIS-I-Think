$PBExportHeader$w_shipment_rej_coil_select.srw
$PBExportComments$<popup> select rej coil for an shipment inherited from pfemain/w_popup
forward
global type w_shipment_rej_coil_select from w_popup
end type
type dw_list from u_dw within w_shipment_rej_coil_select
end type
type cb_select from u_cb within w_shipment_rej_coil_select
end type
type cb_close from u_cb within w_shipment_rej_coil_select
end type
end forward

global type w_shipment_rej_coil_select from w_popup
integer x = 347
integer y = 301
integer width = 3090
integer height = 1686
string title = "Select rejected and return coils for this shipment"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 12632256
dw_list dw_list
cb_select cb_select
cb_close cb_close
end type
global w_shipment_rej_coil_select w_shipment_rej_coil_select

on w_shipment_rej_coil_select.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.cb_select=create cb_select
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.cb_select
this.Control[iCurrent+3]=this.cb_close
end on

on w_shipment_rej_coil_select.destroy
call super::destroy
destroy(this.dw_list)
destroy(this.cb_select)
destroy(this.cb_close)
end on

event open;call super::open;Long ll_cust
String ls_select, ls_where, ls_modify, ls_temp
DataStore lds_cust
Long ll_row, ll_i, ll_cid

String	ls_rtn
Long		ll_rows

ll_cust = Message.DoubleParm
IF ll_cust > 0 THEN

	//Alex Gerlants. novelis testing. Added " or  ( ~~~"COIL~~~".~~~"COIL_STATUS~~~" = 14". 14 is scrap coil status
	ls_select =  " SELECT  ~~~"COIL~~~".~~~"COIL_ABC_NUM~~~" ,~~~"COIL~~~".~~~"CUSTOMER_ID~~~" ,~~~"COIL~~~".~~~"COIL_ORG_NUM~~~" ,~~~"COIL~~~".~~~"LOT_NUM~~~" ,~~~"COIL~~~".~~~"COIL_STATUS~~~" ,~~~"COIL~~~".~~~"COIL_TEMPER~~~" ,~~~"COIL~~~".~~~"COIL_GAUGE~~~" ,~~~"COIL~~~".~~~"NET_WT_BALANCE~~~" ,~~~"COIL~~~".~~~"COIL_NOTES~~~"   FROM ~~~"COIL~~~"   "
	ls_where =  "  WHERE ( ~~~"COIL~~~".~~~"COIL_STATUS~~~" = 6 ) or  ( ~~~"COIL~~~".~~~"COIL_STATUS~~~" = 3 ) or  ( ~~~"COIL~~~".~~~"COIL_STATUS~~~" = 14 )  "   
	ls_temp = " ( ~~~"COIL~~~".~~~"CUSTOMER_ID~~~" = " + String(ll_cust) + " )"
	
	lds_cust = CREATE datastore  
	lds_cust.DataObject = "d_dddw_parent"  
	lds_cust.SetTransObject(SQLCA)  
	lds_cust.Retrieve()
	ll_row = lds_cust.RowCount()
	FOR ll_i = 1 TO ll_row
		ll_cid = 0
		IF lds_cust.GetItemNumber(ll_i, "parent_id") = ll_cust THEN
			ll_cid = lds_cust.GetItemNumber(ll_i, "customer_id")
			ls_temp = ls_temp + " OR ( ~~~"COIL~~~".~~~"CUSTOMER_ID~~~" = " + String(ll_cid) + " )"
		END IF
	NEXT
	DESTROY lds_cust
	
	ls_where = ls_where + " AND ( " + ls_temp + " )"
	ls_modify ="DataWindow.Table.Select = '" + ls_select + ls_where + " '"
	ls_rtn = dw_list.Modify(ls_modify)
	ll_rows = dw_list.Retrieve()
END IF
  

end event

type dw_list from u_dw within w_shipment_rej_coil_select
integer x = 26
integer y = 6
integer width = 3028
integer height = 1456
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_shipment_avi_rej_coil_list"
boolean livescroll = false
end type

event constructor;of_SetBase(TRUE)
of_SettransObject(SQLCA)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 2 )
SetTransObject(SQLCA)

end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long ll_Row

ll_Row = this.GetRow()
IF ll_row < 1 THEN RETURN
SelectRow(0, False)
SelectRow(ll_Row, True)

RETURN

end event

event rbuttondown;//Override
RETURN 1
end event

event rbuttonup;//Override
RETURN 1
end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

event doubleclicked;cb_select.Event Clicked()
end event

type cb_select from u_cb within w_shipment_rej_coil_select
integer x = 951
integer y = 1475
integer width = 351
integer height = 93
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Select"
end type

event clicked;Window lw_parent
Long ll_coil, ll_row, ll_rc
Long ll_selected[], ll_selectedcount, ll_r, ll_i

ll_selectedcount = dw_list.inv_rowselect.of_selectedCount(ll_selected)

ll_r = UpperBound(ll_selected)
IF ll_r > 0 THEN
	FOR ll_i = ll_r TO 1 STEP -1
		ll_row = ll_selected[ll_i]
		IF ll_row < 1 THEN Return -1
		ll_coil = dw_list.GetItemNumber(ll_row, "coil_coil_abc_num")
		lw_parent = gnv_app.of_GetFrame().GetActiveSheet()
		IF IsValid(lw_parent) THEN
			ll_rc = lw_Parent.Dynamic Event ue_check_rej_coil(ll_coil)
			CHOOSE CASE ll_rc
				CASE 0
					lw_Parent.Dynamic Event ue_add_rejcoil(ll_coil)
					dw_list.DeleteRow(ll_row)
					dw_list.ResetUpdate()
				CASE -1
					MessageBox("Error","This coil has been assigned to this shipment already.", StopSign!) 
				CASE ELSE
					MessageBox("Error","This coil has been assigned to shipment# " + String(ll_rc) + " already.", StopSign!)
			END CHOOSE
		END IF
	NEXT
END IF

Return 0

end event

type cb_close from u_cb within w_shipment_rej_coil_select
integer x = 1704
integer y = 1475
integer width = 351
integer height = 93
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;Close(Parent)
end event

