$PBExportHeader$w_coil_detail_2_import.srw
forward
global type w_coil_detail_2_import from w_child
end type
type dw_coil_detail_import from u_dw within w_coil_detail_2_import
end type
type cb_ok from u_cb within w_coil_detail_2_import
end type
type cb_cancel from u_cb within w_coil_detail_2_import
end type
end forward

global type w_coil_detail_2_import from w_child
int X=1009
int Y=467
int Width=1854
int Height=1226
WindowType WindowType=response!
boolean TitleBar=true
string Title="Coil Information"
string Tag="detail information of an coil"
boolean ControlMenu=false
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
dw_coil_detail_import dw_coil_detail_import
cb_ok cb_ok
cb_cancel cb_cancel
end type
global w_coil_detail_2_import w_coil_detail_2_import

on w_coil_detail_2_import.create
int iCurrent
call super::create
this.dw_coil_detail_import=create dw_coil_detail_import
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_coil_detail_import
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_cancel
end on

on w_coil_detail_2_import.destroy
call super::destroy
destroy(this.dw_coil_detail_import)
destroy(this.cb_ok)
destroy(this.cb_cancel)
end on

event open;call super::open;s_coil_info lds_data
Long ll_row
dw_coil_detail_import.SetTransObject(sqlca)

lds_data = message.PowerObjectParm
this.title = "Coil:  " + String(lds_data.ab_coil_num)
ll_row = dw_coil_detail_import.InsertRow(0)

dw_coil_detail_import.SetItem(ll_row, "customer_id",lds_data.customer_id)
dw_coil_detail_import.SetItem(ll_row, "coil_abc_num", lds_data.ab_coil_num )
dw_coil_detail_import.SetItem(ll_row, "coil_org_num",lds_data.coil_orig_num  )
dw_coil_detail_import.SetItem(ll_row, "coil_mid_num",lds_data.coil_alt_num)
dw_coil_detail_import.SetItem(ll_row, "lot_num", lds_data.lot_num   )
dw_coil_detail_import.SetItem(ll_row, "pieces_per_case", lds_data.pieces)
dw_coil_detail_import.SetItem(ll_row, "coil_line_num", lds_data.coil_line_num)
dw_coil_detail_import.SetItem(ll_row, "icra", lds_data.icra )
dw_coil_detail_import.SetItem(ll_row, "coil_alloy2", lds_data.alloy)
dw_coil_detail_import.SetItem(ll_row, "coil_gauge",lds_data.gauge )
dw_coil_detail_import.SetItem(ll_row, "coil_temper",lds_data.Temper )
dw_coil_detail_import.SetItem(ll_row, "net_wt",lds_data.net_wt )
dw_coil_detail_import.SetItem(ll_row, "net_wt_balance", lds_data.net_balance)
dw_coil_detail_import.SetItem(ll_row, "coil_width",lds_data.width )
dw_coil_detail_import.SetItem(ll_row, "date_received", lds_data.date_received)
dw_coil_detail_import.SetItem(ll_row, "coil_location", lds_data.location )
dw_coil_detail_import.SetItem(ll_row, "coil_status",lds_data.status )
dw_coil_detail_import.SetItem(ll_row, "coil_notes", lds_data.notes )
dw_coil_detail_import.SetItem(ll_row, "coil_from_cust_id", lds_data.coil_from_cust_id )
dw_coil_detail_import.SetItem(ll_row, "damage_fault", lds_data.damage_fault )
dw_coil_detail_import.SetItem(ll_row, "damage_code", lds_data.damage_code )

IF lds_data.status = 0 THEN
	dw_coil_detail_import.Object.DataWindow.ReadOnly = "YES"
END IF

dw_coil_detail_import.ResetUpdate()

dw_coil_detail_import.SetFocus()

end event

type dw_coil_detail_import from u_dw within w_coil_detail_2_import
int X=40
int Y=19
int Width=1755
int Height=877
int TabOrder=10
string Tag="Detail information of an coil"
string DataObject="d_coil_detail_import"
boolean VScrollBar=false
boolean LiveScroll=false
end type

event rbuttondown;//disbaled
Return 0
end event

event rbuttonup;//disbaled
Return 0
end event

event itemchanged;call super::itemchanged;this.ResetUpdate()
end event

event constructor;of_SetBase(TRUE)
end event

type cb_ok from u_cb within w_coil_detail_2_import
event clicked pbm_bnclicked
int X=435
int Y=957
int TabOrder=20
string Tag="Close this window and save data"
string Text="&Ok"
string FaceName="Arial"
end type

event clicked;s_coil_info lds_data
long ll_row, rc

dw_coil_detail_import.AcceptText()
dw_coil_detail_import.ResetUpdate()

ll_row = dw_coil_detail_import.GetRow()
IF ll_row < 1 THEN RETURN
lds_data.customer_id = dw_coil_detail_import.GetItemNumber(ll_row, "customer_id",Primary!, FALSE)
lds_data.ab_coil_num = dw_coil_detail_import.GetItemNumber(ll_row, "coil_abc_num", Primary!, FALSE)
lds_data.coil_orig_num = dw_coil_detail_import.GetItemString(ll_row, "coil_org_num", Primary!, FALSE)
lds_data.coil_alt_num = dw_coil_detail_import.GetItemString(ll_row, "coil_mid_num", Primary!, FALSE)
lds_data.lot_num = dw_coil_detail_import.GetItemString(ll_row, "lot_num",Primary!, FALSE)
lds_data.pieces = dw_coil_detail_import.GetItemNumber(ll_row, "pieces_per_case", Primary!, FALSE)
lds_data.coil_line_num = dw_coil_detail_import.GetItemNumber(ll_row, "coil_line_num", Primary!, FALSE)
lds_data.icra = dw_coil_detail_import.GetItemString(ll_row, "icra", Primary!, FALSE)
lds_data.alloy = dw_coil_detail_import.GetItemString(ll_row, "coil_alloy2",Primary!, FALSE)
lds_data.gauge = dw_coil_detail_import.GetItemNumber(ll_row, "coil_gauge", Primary!, FALSE)
lds_data.Temper = dw_coil_detail_import.GetItemString(ll_row, "coil_temper", Primary!, FALSE)
lds_data.net_wt = dw_coil_detail_import.GetItemNumber(ll_row, "net_wt", Primary!, FALSE)
lds_data.net_balance = dw_coil_detail_import.GetItemNumber(ll_row, "net_wt_balance", Primary!, FALSE)
lds_data.width = dw_coil_detail_import.GetItemNumber(ll_row, "coil_width", Primary!, FALSE)
lds_data.date_received = dw_coil_detail_import.GetItemDateTime(ll_row, "date_received", Primary!, FALSE)
lds_data.location = dw_coil_detail_import.GetItemString(ll_row, "coil_location", Primary!, FALSE)
lds_data.status = dw_coil_detail_import.GetItemNumber(ll_row, "coil_status", Primary!, FALSE)
lds_data.notes = dw_coil_detail_import.GetItemString(ll_row, "coil_notes", Primary!, FALSE)
lds_data.coil_from_cust_id = dw_coil_detail_import.GetItemNumber(ll_row, "coil_from_cust_id", Primary!, FALSE)
lds_data.damage_fault = dw_coil_detail_import.GetItemNumber(ll_row, "damage_fault", Primary!, FALSE)
lds_data.damage_code = dw_coil_detail_import.GetItemNumber(ll_row, "damage_code", Primary!, FALSE)

IF ( ( (lds_data.status = 12) AND ( (lds_data.damage_fault = 0) OR (lds_data.damage_code = 0) ) ) &
OR ( (lds_data.status <> 12) AND ( (lds_data.damage_fault <> 0) OR (lds_data.damage_code <> 0) ) ) )THEN
	rc = MessageBox("Error", "Coil Status mismatches with Damage Cold/Damage Fault", Exclamation!, OK!)
	parent.event open()
	return
END IF

dw_coil_detail_import.Reset()
CloseWithReturn(parent, lds_data)
end event

type cb_cancel from u_cb within w_coil_detail_2_import
int X=1072
int Y=957
int TabOrder=30
string Tag="Close this window without save data"
string Text="&Cancel"
string FaceName="Arial"
end type

event clicked;s_coil_info lds_data

lds_data.ab_coil_num = 0

dw_coil_detail_import.Reset()

CloseWithReturn(parent, lds_data)
end event

