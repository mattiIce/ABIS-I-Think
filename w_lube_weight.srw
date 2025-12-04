$PBExportHeader$w_lube_weight.srw
forward
global type w_lube_weight from w_sheet
end type
type dw_lube_weight from u_dw within w_lube_weight
end type
type dw_lube_weight_editor from u_dw within w_lube_weight
end type
type st_1 from statictext within w_lube_weight
end type
type cb_new from commandbutton within w_lube_weight
end type
type cb_modify from commandbutton within w_lube_weight
end type
type cb_delete from commandbutton within w_lube_weight
end type
type cb_save from commandbutton within w_lube_weight
end type
type cb_send from commandbutton within w_lube_weight
end type
type cb_close from commandbutton within w_lube_weight
end type
type gb_2 from groupbox within w_lube_weight
end type
type gb_1 from groupbox within w_lube_weight
end type
type cb_cancle from commandbutton within w_lube_weight
end type
type cb_print from commandbutton within w_lube_weight
end type
type dw_lube_weight_edi_status from u_dw within w_lube_weight
end type
end forward

global type w_lube_weight from w_sheet
integer x = 622
integer y = 208
integer width = 1840
integer height = 1718
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 82042848
event type integer ue_new ( )
event type integer ue_modify ( )
event type integer ue_delete ( )
event type integer ue_save ( )
event type integer ue_send ( )
event ue_cancle ( )
dw_lube_weight dw_lube_weight
dw_lube_weight_editor dw_lube_weight_editor
st_1 st_1
cb_new cb_new
cb_modify cb_modify
cb_delete cb_delete
cb_save cb_save
cb_send cb_send
cb_close cb_close
gb_2 gb_2
gb_1 gb_1
cb_cancle cb_cancle
cb_print cb_print
dw_lube_weight_edi_status dw_lube_weight_edi_status
end type
global w_lube_weight w_lube_weight

type variables
long il_coil_abc_num
boolean ib_new
end variables

event ue_new;Int li_rc

ib_new = true

li_rc = dw_lube_weight_editor.RowCount()
IF li_rc > 0 THEN
	dw_lube_weight_editor.event pfc_deleterow()
END IF

dw_lube_weight_editor.event pfc_addrow()


return 0
end event

event ue_modify;SetPointer(HourGlass!)

Long ll_row, ll_coil
Int li_item_num
Date ld_date
String ls_user
Real lr_lube_weight

ll_row = dw_lube_weight.GetRow()
IF ll_row < 1 THEN RETURN -1

li_item_num = dw_lube_weight.GetItemNumber(ll_row, "lube_weight_item_num", Primary!, FALSE)

/*
//ld_date = dw_lube_weight.GetItemDate(ll_row, "process_date", Primary!, FALSE)
ls_user = dw_lube_weight.GetItemString(ll_row, "process_by", Primary!, FALSE)
lr_lube_weight = dw_lube_weight.GetItemNumber(ll_row, "lube_weight", Primary!, FALSE)
dw_lube_weight_editor.SetItem(1, "lube_weight_item_num", li_item_num)
dw_lube_weight_editor.SetItem(1, "coil_abc_num", il_coil_abc_num)
dw_lube_weight_editor.SetItem(1, "lube_weight", lr_lube_weight)
dw_lube_weight_editor.SetItem(1, "process_date", ld_date)
dw_lube_weight_editor.SetItem(1, "process_by", ls_user)
*/	
dw_lube_weight_editor.Retrieve(il_coil_abc_num, li_item_num)

RETURN -1
end event

event ue_delete;SetPointer(HourGlass!)

integer li_rc
Long ll_row//, ll_lube_weight_item_num


li_rc = MessageBox("Warning!", "Are you sure to delete this lube weight?", Exclamation!, OKCancel!, 2 )
IF li_rc = 1 THEN
	//ll_row = dw_lube_weight.GetRow()
	//ll_lube_weight_item_num = dw_lube_weight.GetItemNumber(ll_row, "lube_weight_item_num", Primary!, FALSE)
	dw_lube_weight_editor.inv_rowmanager.of_DeleteRow(1)
	li_rc = dw_lube_weight_editor.Update()
	IF li_rc = 1 THEN
		COMMIT USING SQLCA;
	ELSE
		ROLLBACK USING SQLCA;
		RETURN -1
	END IF
END IF

dw_lube_weight_editor.Reset()
dw_lube_weight.Retrieve(il_coil_abc_num)

ll_row = dw_lube_weight.RowCount()
if ll_row <= 0 then
	UPDATE "COIL_LUBE_WEIGHT"  
   SET "READY_STATUS" = 0,
		 "SET_READY_TIME" = NULL
   WHERE "COIL_LUBE_WEIGHT"."COIL_ABC_NUM" = :il_coil_abc_num 
	using SQLCA;
	commit;
end if

dw_lube_weight_edi_status.Retrieve(il_coil_abc_num)

RETURN 1


end event

event ue_save;Long li_rc

Long ll_coil_abc_num
Int li_item_num
Double ld_lube_weight
Datetime ld_process_date
String ls_process_by

li_rc = dw_lube_weight_editor.RowCount()
IF li_rc <= 0 THEN
	return 0
ELSE
	dw_lube_weight_editor.AcceptText()
	
	ll_coil_abc_num = dw_lube_weight_editor.Getitemnumber(1,"coil_abc_num", Primary!, False)
	li_item_num = dw_lube_weight_editor.Getitemnumber(1,"lube_weight_item_num", Primary!, False)
	ld_lube_weight = dw_lube_weight_editor.Getitemnumber(1,"lube_weight", Primary!, False)
	ls_process_by = dw_lube_weight_editor.Getitemstring(1,"process_by", Primary!, False)
	ld_process_date = dw_lube_weight_editor.Getitemdatetime(1,"process_date", Primary!, False)	
	
	IF ib_new = true THEN
		connect using SQLCA;
		insert into lube_weight(coil_abc_num, lube_weight_item_num, lube_weight, process_date, process_by)
		values (:ll_coil_abc_num, :li_item_num, :ld_lube_weight, :ld_process_date, :ls_process_by) using SQLCA;
		COMMIT USING SQLCA;
	ELSE
		IF dw_lube_weight_editor.RowCount() < 1 THEN RETURN 0
		li_rc = dw_lube_weight_editor.Update()
		IF li_rc = 1 THEN
			COMMIT USING SQLCA;
		ELSE
			ROLLBACK USING SQLCA;
			RETURN 0
		END IF
	END IF
	
	ib_new = false
	dw_lube_weight_editor.Reset()
	dw_lube_weight.Retrieve(il_coil_abc_num)
END IF

return 1
end event

event type integer ue_send();integer li_return
Long ll_row

li_return = MessageBox("Send lube weight", "Are you sure to send lube weight?", Exclamation!, OKCancel!, 2 )
IF li_return = 1 THEN
	ll_row = dw_lube_weight.GetRow()
	
	if ll_row <= 0 then
		MessageBox("Error", "There is no lube weight data!", Exclamation!, OK!)
		return 0;
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
		
		DECLARE p_fn procedure for F_SEND_LUBE_WEIGHT(:il_coil_abc_num) using dboconnect;
		execute p_fn;
		if dboconnect.SQLCode < 0 then 
			MessageBox ("Stored Procedure Failed!!!",dboconnect.sqlerrtext,exclamation!)
			return -1
		end if
		fetch p_fn INTO :li_return; 
		close p_fn;
		
		disconnect using dboconnect;
		
		CHOOSE CASE li_return
			CASE 1
			 messagebox("Lube Weight Send","Lube Wt. data sent successfully.")
			CASE -1
				MessageBox("Info","System error!" )
			CASE -2
				MessageBox("Error","EDI failed, Errors with UTL_FILE!", StopSign!)
			CASE -100
				MessageBox("Info","Test file ID duplicated." )
		end CHOOSE
		
		destroy dboconnect;
	end if
ELSE
	return 0
END IF

dw_lube_weight_edi_status.Retrieve(il_coil_abc_num)	
	
return li_return
end event

event ue_cancle;dw_lube_weight_editor.Reset()
end event

on w_lube_weight.create
int iCurrent
call super::create
this.dw_lube_weight=create dw_lube_weight
this.dw_lube_weight_editor=create dw_lube_weight_editor
this.st_1=create st_1
this.cb_new=create cb_new
this.cb_modify=create cb_modify
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.cb_send=create cb_send
this.cb_close=create cb_close
this.gb_2=create gb_2
this.gb_1=create gb_1
this.cb_cancle=create cb_cancle
this.cb_print=create cb_print
this.dw_lube_weight_edi_status=create dw_lube_weight_edi_status
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_lube_weight
this.Control[iCurrent+2]=this.dw_lube_weight_editor
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cb_new
this.Control[iCurrent+5]=this.cb_modify
this.Control[iCurrent+6]=this.cb_delete
this.Control[iCurrent+7]=this.cb_save
this.Control[iCurrent+8]=this.cb_send
this.Control[iCurrent+9]=this.cb_close
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.cb_cancle
this.Control[iCurrent+13]=this.cb_print
this.Control[iCurrent+14]=this.dw_lube_weight_edi_status
end on

on w_lube_weight.destroy
call super::destroy
destroy(this.dw_lube_weight)
destroy(this.dw_lube_weight_editor)
destroy(this.st_1)
destroy(this.cb_new)
destroy(this.cb_modify)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.cb_send)
destroy(this.cb_close)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.cb_cancle)
destroy(this.cb_print)
destroy(this.dw_lube_weight_edi_status)
end on

event open;call super::open;il_coil_abc_num = Message.DoubleParm
ib_new = false

SetPointer(HourGlass!)
dw_lube_weight.SetTransObject(sqlca)
dw_lube_weight_editor.SetTransObject(sqlca)
dw_lube_weight_edi_status.SetTransObject(sqlca)

dw_lube_weight.Retrieve(il_coil_abc_num)
dw_lube_weight_edi_status.Retrieve(il_coil_abc_num)

this.title = "Lube Weight List for Coil#:  " + String(il_coil_abc_num)
end event

type dw_lube_weight from u_dw within w_lube_weight
integer x = 40
integer y = 138
integer width = 1357
integer height = 512
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_lube_weight"
boolean vscrollbar = false
end type

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

event clicked;call super::clicked;
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

// Notify the RowSelect service that the row has been clicked.
IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF

// Sort services.
IF IsValid (inv_Sort) THEN 
	// Notify the Sort service, since it may have have a request
	// to sort on colum header.
	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
END IF 

parent.event ue_modify()

//SelectRow(row, TRUE)
//cb_modify.TriggerEvent (clicked!)


end event

event doubleclicked;IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

// Notify the RowSelect service that the row has been clicked.
IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF

// Sort services.
IF IsValid (inv_Sort) THEN 
	// Notify the Sort service, since it may have have a request
	// to sort on colum header.
	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
END IF 

parent.event ue_modify()

//SelectRow(row, TRUE)
//cb_modify.TriggerEvent (clicked!)

end event

type dw_lube_weight_editor from u_dw within w_lube_weight
integer x = 55
integer y = 797
integer width = 1324
integer height = 141
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_lube_weight_editor"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
end event

event itemchanged;call super::itemchanged;this.resetupdate()
end event

event pfc_addrow;call super::pfc_addrow;

SetPointer(HourGlass!)

Long ll_row, ll_rowcount, ll_item_num
Date ld_date
String ls_user

ld_date = Today()
ls_user = gnv_app.of_GetUserId()

ll_rowcount = dw_lube_weight.RowCount()
IF ll_rowcount = 0 THEN
	ll_item_num = 1
ELSE
	ll_item_num = dw_lube_weight.GetItemNumber(ll_rowcount, "lube_weight_item_num", Primary!, FALSE)
	ll_item_num = ll_item_num + 1
END IF

//ll_row = dw_lube_weight_editor.InsertRow(0)
ll_row = 1
dw_lube_weight_editor.SetItem(ll_row, "lube_weight_item_num", ll_item_num)
dw_lube_weight_editor.SetItem(ll_row, "coil_abc_num", il_coil_abc_num)
dw_lube_weight_editor.SetItem(ll_row, "process_date", ld_date)
dw_lube_weight_editor.SetItem(ll_row, "process_by", ls_user)

//dw_lube_weight_editor.ResetUpdate()
dw_lube_weight_editor.SetFocus()

return 0
end event

type st_1 from statictext within w_lube_weight
integer x = 40
integer y = 45
integer width = 468
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 82042848
boolean enabled = false
string text = "Lube Weight List:"
boolean focusrectangle = false
end type

type cb_new from commandbutton within w_lube_weight
integer x = 1452
integer y = 762
integer width = 296
integer height = 83
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&New"
end type

event clicked;Parent.Event ue_new()
end event

type cb_modify from commandbutton within w_lube_weight
integer x = 1452
integer y = 902
integer width = 296
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Modify"
end type

event clicked;Parent.Event ue_modify()
end event

type cb_delete from commandbutton within w_lube_weight
integer x = 1452
integer y = 1040
integer width = 296
integer height = 83
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Delete"
end type

event clicked;Parent.Event ue_delete()
end event

type cb_save from commandbutton within w_lube_weight
integer x = 366
integer y = 1002
integer width = 223
integer height = 83
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "S&ave"
end type

event clicked;parent.event ue_save()

dw_lube_weight.retrieve(il_coil_abc_num)
end event

type cb_send from commandbutton within w_lube_weight
integer x = 892
integer y = 1357
integer width = 296
integer height = 83
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Send to EDI"
end type

event clicked;Parent.Event ue_send()
end event

type cb_close from commandbutton within w_lube_weight
integer x = 1452
integer y = 1395
integer width = 296
integer height = 83
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Close"
end type

event clicked;Parent.Event pfc_close()
end event

type gb_2 from groupbox within w_lube_weight
integer x = 40
integer y = 1254
integer width = 1346
integer height = 266
integer taborder = 110
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 82042848
string text = "Ready Status for EDI863"
end type

type gb_1 from groupbox within w_lube_weight
integer x = 44
integer y = 720
integer width = 1353
integer height = 422
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 82042848
string text = "Lube Weight Editor:"
end type

type cb_cancle from commandbutton within w_lube_weight
integer x = 867
integer y = 1005
integer width = 223
integer height = 83
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "C&ancel"
end type

event clicked;parent.event ue_cancle()
end event

type cb_print from commandbutton within w_lube_weight
integer x = 1452
integer y = 550
integer width = 296
integer height = 80
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Print"
end type

event clicked;dw_lube_weight.event pfc_print()
end event

type dw_lube_weight_edi_status from u_dw within w_lube_weight
integer x = 62
integer y = 1331
integer width = 614
integer height = 131
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_lube_weight_edi_status"
boolean vscrollbar = false
end type

