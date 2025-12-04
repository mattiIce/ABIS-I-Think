$PBExportHeader$w_coil_detail_new_import.srw
forward
global type w_coil_detail_new_import from w_child
end type
type dw_coil_detail from u_dw within w_coil_detail_new_import
end type
type cb_coil_cancel from u_cb within w_coil_detail_new_import
end type
type cb_activate from u_cb within w_coil_detail_new_import
end type
end forward

global type w_coil_detail_new_import from w_child
int X=388
int Y=179
int Width=1799
int Height=986
WindowType WindowType=response!
boolean TitleBar=true
string Title=" New Coil Information"
string Tag="detail information of an new coil"
long BackColor=82042848
boolean ControlMenu=false
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
event ue_activate ( )
dw_coil_detail dw_coil_detail
cb_coil_cancel cb_coil_cancel
cb_activate cb_activate
end type
global w_coil_detail_new_import w_coil_detail_new_import

type variables
long il_customer_id
end variables

event ue_activate;Long ll_row
Long ll_id, ll_old_id
String ls_org_num, ls_mid_num
Int li_rc

dw_coil_detail.AcceptText()

ll_row = dw_coil_detail.GetRow()
ll_id = dw_coil_detail.GetItemNumber(ll_row, "coil_abc_num" )
ls_org_num = dw_coil_detail.GetItemString(ll_row, "coil_org_num")
ls_mid_num = dw_coil_detail.GetItemString(ll_row, "coil_mid_num")

ll_old_id = 0
CONNECT USING SQLCA;
SELECT coil_abc_num INTO :ll_old_id
FROM coil
WHERE coil_org_num = :ls_org_num AND coil_mid_num = :ls_mid_num AND customer_id = :il_customer_id
USING SQLCA;
IF (ll_id <> ll_old_id) AND (ll_old_id > 1) THEN
	MessageBox("Duplicated Coil","This coil and coil #" + String(ll_old_id) +" have duplicated coil original/alternative numbers.",StopSign!)
	CloseWithReturn(this, 0)
	RETURN
	/*
	li_rc = MessageBox("Warning","This coil and coil #" + String(ll_old_id) +" have duplicated coil original/alternative numbers, Continue?", Question!,YesNo!, 2)
	IF li_rc = 2 THEN 
		CloseWithReturn(this, 0)
		RETURN
	END IF
	*/
END IF

li_rc = dw_coil_detail.Update()
IF li_rc = 1 THEN
	COMMIT USING SQLCA;
ELSE
	ROLLBACK USING SQLCA;
	dw_coil_detail.Reset()
	CloseWithReturn(this, 0)
	RETURN
END IF

dw_coil_detail.Reset()
CloseWithReturn(this, 1)
RETURN


end event

on w_coil_detail_new_import.create
int iCurrent
call super::create
this.dw_coil_detail=create dw_coil_detail
this.cb_coil_cancel=create cb_coil_cancel
this.cb_activate=create cb_activate
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_coil_detail
this.Control[iCurrent+2]=this.cb_coil_cancel
this.Control[iCurrent+3]=this.cb_activate
end on

on w_coil_detail_new_import.destroy
call super::destroy
destroy(this.dw_coil_detail)
destroy(this.cb_coil_cancel)
destroy(this.cb_activate)
end on

event pfc_close;call super::pfc_close;//dw_coil_detail.Reset()
CloseWithReturn(this, 0)
end event

event open;call super::open;s_coil_info_import lds_data
Long ll_row, ll_new_coil_abc_num
dw_coil_detail.SetTransObject(SQLCA)

lds_data = message.PowerObjectParm
this.title = "New coil"

dw_coil_detail.InsertRow(1)
ll_row = 1

il_customer_id = lds_data.customer_id

ll_new_coil_abc_num = f_get_next_value("coil_abc_num_seq")
dw_coil_detail.SetItem(ll_row, "customer_id",lds_data.customer_id )
dw_coil_detail.SetItem(ll_row, "coil_abc_num",ll_new_coil_abc_num)
dw_coil_detail.SetItem(ll_row, "coil_org_num",lds_data.coil_number )
dw_coil_detail.SetItem(ll_row, "coil_mid_num",lds_data.pack_id )
//dw_coil_detail.SetItem(ll_row, "customer_id",1153)
dw_coil_detail.SetItem(ll_row, "coil_from_cust_id", lds_data.customer_id)
dw_coil_detail.SetItem(ll_row, "coil_status",2 )
dw_coil_detail.SetItem(ll_row, "date_received", Today())
dw_coil_detail.SetItem(ll_row, "coil_entry_date", Today())
dw_coil_detail.SetItem(ll_row, "coil_temper",lds_data.temper )
dw_coil_detail.SetItem(ll_row, "coil_alloy2",lds_data.alloy )
dw_coil_detail.SetItem(ll_row, "net_wt",lds_data.net_weight )
dw_coil_detail.SetItem(ll_row, "net_wt_balance",lds_data.net_weight )
dw_coil_detail.SetItem(ll_row, "coil_width",lds_data.coil_width )
dw_coil_detail.SetItem(ll_row, "coil_gauge",lds_data.coil_gauge )
dw_coil_detail.SetItem(ll_row, "lot_num",lds_data.lot )

//dw_coil_detail.ResetUpdate()

dw_coil_detail.SetFocus()

return 1
end event

type dw_coil_detail from u_dw within w_coil_detail_new_import
int X=40
int Y=22
int Width=1697
int Height=752
int TabOrder=20
string Tag="Detail information of an  new coil"
string DataObject="d_coil_detail_new_import"
boolean VScrollBar=false
boolean LiveScroll=false
end type

event rbuttondown;//disbaled
//Return 0
end event

event rbuttonup;//disbaled
//Return 0
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

event clicked;call super::clicked;//Override pfc_clicked

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

event rowfocuschanged;call super::rowfocuschanged;//this.Event pfc_rowchanged()
end event

type cb_coil_cancel from u_cb within w_coil_detail_new_import
event clicked pbm_bnclicked
int X=1108
int Y=784
int TabOrder=10
string Tag="Close this window"
string Text="&Cancel"
string FaceName="Arial"
end type

event clicked;parent.event pfc_close()
end event

type cb_activate from u_cb within w_coil_detail_new_import
int X=351
int Y=784
int TabOrder=11
string Tag="Close this window and pass the information"
string Text="&Activate"
string FaceName="Arial"
end type

event clicked;parent.event ue_activate()

/*
Long ll_row
Long ll_id, ll_old_id
String ls_org_num, ls_mid_num
Int li_rc

dw_coil_detail.AcceptText()

ll_row = dw_coil_detail.GetRow()
ll_id = dw_coil_detail.GetItemNumber(ll_row, "coil_abc_num" )
ls_org_num = dw_coil_detail.GetItemString(ll_row, "coil_org_num")
ls_mid_num = dw_coil_detail.GetItemString(ll_row, "coil_mid_num")

ll_old_id = 0
CONNECT USING SQLCA;
SELECT coil_abc_num INTO :ll_old_id
FROM coil
WHERE coil_org_num = :ls_org_num AND coil_mid_num = :ls_mid_num
USING SQLCA;
IF (ll_id <> ll_old_id) AND (ll_old_id > 1) THEN
	li_rc = MessageBox("Warning","This coil and coil #" + String(ll_old_id) +" have duplicated coil original/alternative numbers, Continue?", Question!,YesNo!, 2)
	IF li_rc = 2 THEN 
		CloseWithReturn(parent, 0)
		RETURN
	END IF	
END IF

li_rc = dw_coil_detail.Update()
IF li_rc = 1 THEN
	COMMIT USING SQLCA;
ELSE
	ROLLBACK USING SQLCA;
	dw_coil_detail.Reset()
	CloseWithReturn(parent, 0)
	RETURN
END IF

dw_coil_detail.Reset()
CloseWithReturn(parent, 1)
RETURN
*/


end event

