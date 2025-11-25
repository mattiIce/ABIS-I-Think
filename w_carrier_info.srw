$PBExportHeader$w_carrier_info.srw
$PBExportComments$<Sheet>Carrier inforamtion inherited from pfemain\w_sheet
forward
global type w_carrier_info from w_sheet
end type
type dw_carrier_list from u_dw within w_carrier_info
end type
type dw_carrier_detail from u_dw within w_carrier_info
end type
type cb_new from u_cb within w_carrier_info
end type
type cb_save from u_cb within w_carrier_info
end type
type cb_close from u_cb within w_carrier_info
end type
type cb_delete from u_cb within w_carrier_info
end type
end forward

global type w_carrier_info from w_sheet
integer x = 841
integer y = 374
integer width = 2044
integer height = 1738
string title = "Carrier Information"
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
event ue_read_only ( )
dw_carrier_list dw_carrier_list
dw_carrier_detail dw_carrier_detail
cb_new cb_new
cb_save cb_save
cb_close cb_close
cb_delete cb_delete
end type
global w_carrier_info w_carrier_info

event ue_whoami;RETURN "w_carrier_info"
end event

event ue_read_only;dw_carrier_list.Object.DataWindow.ReadOnly = "YES"
dw_carrier_detail.Object.DataWindow.ReadOnly = "YES"
cb_new.Enabled = FALSE
cb_delete.Enabled = FALSE
cb_save.Enabled = FALSE

end event

on w_carrier_info.create
int iCurrent
call super::create
this.dw_carrier_list=create dw_carrier_list
this.dw_carrier_detail=create dw_carrier_detail
this.cb_new=create cb_new
this.cb_save=create cb_save
this.cb_close=create cb_close
this.cb_delete=create cb_delete
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_carrier_list
this.Control[iCurrent+2]=this.dw_carrier_detail
this.Control[iCurrent+3]=this.cb_new
this.Control[iCurrent+4]=this.cb_save
this.Control[iCurrent+5]=this.cb_close
this.Control[iCurrent+6]=this.cb_delete
end on

on w_carrier_info.destroy
call super::destroy
destroy(this.dw_carrier_list)
destroy(this.dw_carrier_detail)
destroy(this.cb_new)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.cb_delete)
end on

event open;call super::open;s_security_data  lds_sec

IF f_security_door("Carrier Information") < 0 THEN
	OpenWithParm(w_security_check, "Carrier Information")
	lds_sec = Message.PowerObjectParm
	IF lds_sec.security_level < 0 THEN
		Close(this)
		RETURN 0
	END IF
END IF

//share list and detail
dw_carrier_list.ShareData(dw_carrier_detail)

dw_carrier_list.SetFocus()


end event

event closequery;Int li_rc

IF of_UpdateChecks() = 1 THEN
	li_rc = MessageBox("Question", "Save Changes first?", Question!, YesNo!, 2)
	IF li_rc = 1 THEN 
		dw_carrier_list.Event pfc_Update( True, True)
	END IF
END IF
end event

event activate;call super::activate;gnv_app.of_getFrame().event pfc_cascade()
IF f_security_door("Carrier Information") = 1 THEN RETURN 1
This.Event ue_read_only()
end event

event close;call super::close;f_display_app()
end event

type dw_carrier_list from u_dw within w_carrier_info
integer x = 37
integer y = 13
integer width = 1953
integer height = 1056
integer taborder = 10
string dataobject = "d_carrier_list"
end type

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve()
end event

event rbuttondown;Return 1
end event

event rbuttonup;Return 1
end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long li_Row

dw_carrier_list.AcceptText()
li_Row = dw_carrier_list.GetRow()
dw_carrier_list.SelectRow(0, False)
dw_carrier_list.SelectRow(li_Row, True)

dw_carrier_detail.ScrollToRow(li_Row)

//Nochange
Return 

end event

event pfc_addrow;call super::pfc_addrow;long ll_new_id
Long ll_row
Integer li_rc

ll_new_id = f_get_next_value("carrier_id_seq")

ll_row =GetRow()
li_rc =SetItem(ll_row,"carrier_id", ll_new_id)

Return ll_new_id
end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

event pfc_deleterow;call super::pfc_deleterow;return 1
end event

event constructor;of_SetBase(TRUE)
of_SettransObject(SQLCA)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetRowFocusIndicator(Hand!)

This.retrieve()

end event

type dw_carrier_detail from u_dw within w_carrier_info
integer x = 33
integer y = 1085
integer width = 1609
integer height = 576
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_carrier_detail"
boolean vscrollbar = false
boolean livescroll = false
end type

event pfc_retrievedddw;call super::pfc_retrievedddw;DataWindowChild dddw_cni

IF this.GetChild(as_column, dddw_cni) = -1 THEN
	Return -1
ELSE
	dddw_cni.SetTransObject(SQLCA)
	Return dddw_cni.Retrieve()
END IF
end event

event constructor;//this.Event pfc_RetrieveDDDW("carrier_state")
DataWindowChild ldddw_cni

IF this.GetChild("carrier_state", ldddw_cni) = -1 THEN
	Return -1
ELSE
	this.Event pfc_PopulateDDDW("carrier_state", ldddw_cni)
END IF
end event

event rbuttondown;//disbaled
Return 0
end event

event rbuttonup;//disbaled
Return 0
end event

event rowfocuschanged;return 1
end event

event pfc_populatedddw;call super::pfc_populatedddw;IF adwc_obj.SetTransObject(SQLCA) = -1 THEN  
	Return -1  
ELSE   
	Return adwc_obj.Retrieve()  
END IF
end event

type cb_new from u_cb within w_carrier_info
string tag = "New Carrier"
integer x = 1671
integer y = 1123
integer width = 315
integer height = 77
integer taborder = 30
string facename = "Arial"
string text = "&Add"
end type

event clicked;call super::clicked;dw_carrier_list.Event pfc_addrow()
dw_carrier_detail.SetFocus()

end event

type cb_save from u_cb within w_carrier_info
integer x = 1671
integer y = 1366
integer width = 315
integer height = 77
integer taborder = 50
boolean bringtotop = true
string facename = "Arial"
string text = "&Save"
end type

event clicked;call super::clicked;dw_carrier_list.Event pfc_Update( True, True)
end event

type cb_close from u_cb within w_carrier_info
integer x = 1671
integer y = 1488
integer width = 315
integer height = 77
integer taborder = 60
boolean bringtotop = true
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_delete from u_cb within w_carrier_info
event clicked pbm_bnclicked
string tag = "New Carrier"
integer x = 1671
integer y = 1245
integer width = 315
integer height = 77
integer taborder = 40
string facename = "Arial"
string text = "&Delete"
end type

event clicked;call super::clicked;//dw_carrier_list.Event pfc_deleterow()
dw_carrier_list.inv_rowmanager.of_DeleteRow(0)
end event

