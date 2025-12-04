$PBExportHeader$w_shipment_scrap_select.srw
$PBExportComments$<popup> select scrap for an shipment inherited from pfemain/w_popup
forward
global type w_shipment_scrap_select from w_popup
end type
type dw_list from u_dw within w_shipment_scrap_select
end type
type cb_select from u_cb within w_shipment_scrap_select
end type
type cb_close from u_cb within w_shipment_scrap_select
end type
end forward

global type w_shipment_scrap_select from w_popup
integer x = 73
integer y = 252
integer width = 3611
integer height = 1748
string title = "Select scrap skids for this shipment"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 12632256
dw_list dw_list
cb_select cb_select
cb_close cb_close
end type
global w_shipment_scrap_select w_shipment_scrap_select

on w_shipment_scrap_select.create
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

on w_shipment_scrap_select.destroy
call super::destroy
destroy(this.dw_list)
destroy(this.cb_select)
destroy(this.cb_close)
end on

event open;call super::open;Long ll_cust
String ls_modify, ls_select, ls_where, ls_temp
DataStore lds_cust
Long ll_row, ll_i, ll_cid

ll_cust = Message.DoubleParm
IF ll_cust > 0 THEN
	ls_select = dw_list.Describe("DataWindow.Table.Select")
	ls_where =  " WHERE  ( ~~~"SCRAP_SKID~~~".~~~"SKID_SCRAP_STATUS~~~" = 2 ) "   
	ls_temp = " ( ~~~"SCRAP_SKID~~~".~~~"CUSTOMER_ID~~~" = " + String(ll_cust) + " )"
	
	lds_cust = CREATE datastore  
	lds_cust.DataObject = "d_dddw_parent"  
	lds_cust.SetTransObject(SQLCA)  
	lds_cust.Retrieve()
	ll_row = lds_cust.RowCount()
	FOR ll_i = 1 TO ll_row
		ll_cid = 0
		IF lds_cust.GetItemNumber(ll_i, "parent_id") = ll_cust THEN
			ll_cid = lds_cust.GetItemNumber(ll_i, "customer_id")
			ls_temp = ls_temp + " OR ( ~~~"SCRAP_SKID~~~".~~~"CUSTOMER_ID~~~" = " + String(ll_cid) + " )"
		END IF
	NEXT
	DESTROY lds_cust
	
	ls_where = ls_where + " AND ( " + ls_temp + " )"
	ls_modify ="DataWindow.Table.Select = '" + ls_select + ls_where + " '"
	dw_list.Modify(ls_modify)
	dw_list.Retrieve()
END IF
end event

type dw_list from u_dw within w_shipment_scrap_select
integer x = 9
integer y = 12
integer width = 3561
integer height = 1504
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_shipment_avi_scrap_list"
boolean hscrollbar = true
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

type cb_select from u_cb within w_shipment_scrap_select
integer x = 1239
integer y = 1532
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Select"
end type

event clicked;Window lw_parent
Long ll_skid, ll_row, ll_rc
Long ll_selected[], ll_selectedcount, ll_r, ll_i

ll_selectedcount = dw_list.inv_rowselect.of_selectedCount(ll_selected)

ll_r = UpperBound(ll_selected)
IF ll_r > 0 THEN
	FOR ll_i = ll_r TO 1 STEP -1
		ll_row = ll_selected[ll_i]
		IF ll_row < 1 THEN Return -1
		ll_skid = dw_list.GetItemNumber(ll_row, "scrap_skid_num")
		lw_parent = gnv_app.of_GetFrame().GetActiveSheet()
		IF IsValid(lw_parent) THEN
			ll_rc = lw_Parent.Dynamic Event ue_check_scrap(ll_skid)
				CHOOSE CASE ll_rc
				CASE 0
					lw_Parent.Dynamic Event ue_add_scrap(ll_skid)
					dw_list.DeleteRow(ll_row)
					dw_list.ResetUpdate()
				CASE -1
					MessageBox("Error","This skid has been assigned to this shipment already.", StopSign!) 
				CASE ELSE
					MessageBox("Error","This skid has been assigned to shipment# " + String(ll_rc) + " already.", StopSign!)
			END CHOOSE
		END IF
	NEXT
END IF

Return 0

end event

type cb_close from u_cb within w_shipment_scrap_select
integer x = 1998
integer y = 1532
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;Close(Parent)
end event

