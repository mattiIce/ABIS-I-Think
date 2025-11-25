$PBExportHeader$w_shipping_dock.srw
$PBExportComments$<Sheet>w_shipping_dock inherited from pfemain\w_sheet
forward
global type w_shipping_dock from w_sheet
end type
type dw_carrier from u_dw within w_shipping_dock
end type
type sle_input from u_sle within w_shipping_dock
end type
type st_plist from statictext within w_shipping_dock
end type
type dw_item from u_dw within w_shipping_dock
end type
type st_1 from statictext within w_shipping_dock
end type
type st_total from statictext within w_shipping_dock
end type
type st_2 from statictext within w_shipping_dock
end type
type st_loaded from statictext within w_shipping_dock
end type
type cb_send from u_cb within w_shipping_dock
end type
type cb_close from u_cb within w_shipping_dock
end type
type cb_print from u_cb within w_shipping_dock
end type
type st_3 from statictext within w_shipping_dock
end type
type st_error from statictext within w_shipping_dock
end type
type dw_error from u_dw within w_shipping_dock
end type
type st_4 from statictext within w_shipping_dock
end type
end forward

global type w_shipping_dock from w_sheet
int Width=2604
int Height=1600
boolean TitleBar=true
string Title="Shipping dock application"
boolean MaxBox=false
boolean Resizable=false
event ue_shipment_sent ( )
event type string ue_whoami ( )
dw_carrier dw_carrier
sle_input sle_input
st_plist st_plist
dw_item dw_item
st_1 st_1
st_total st_total
st_2 st_2
st_loaded st_loaded
cb_send cb_send
cb_close cb_close
cb_print cb_print
st_3 st_3
st_error st_error
dw_error dw_error
st_4 st_4
end type
global w_shipping_dock w_shipping_dock

type variables
Long il_barinput
Long il_current_packing_list
datastore ids_sheet_skid
datastore ids_scrap_skid
datastore ids_wh_item
datastore ids_rej_coil
Long il_err_id
Int ii_err_type


end variables

forward prototypes
public subroutine wf_barinput_decoder ()
public subroutine wf_display_items (long al_packing_list)
public subroutine wf_ok_item (long al_item_id, integer ai_type)
public function integer wf_set_status_to_done ()
public function integer wf_add_del_errors (long al_item_id, integer ai_type)
end prototypes

event ue_shipment_sent;call super::ue_shipment_sent;String as_vehicle_id
long ll_row
integer li_rc

li_rc = MessageBox("Warning!", "Sending this shipment.. Are you sure?", Exclamation!, OKCancel!, 2 )
IF Li_rc = 1 THEN 
	dw_carrier.AcceptText()
	ll_row = dw_carrier.GetRow()
	IF ll_row > 0 THEN
		as_vehicle_id = dw_carrier.GetItemString(ll_row, "vehicle_id", Primary!, TRUE)
	END IF
	IF (Len(as_vehicle_id) <= 1) OR IsNULL(as_vehicle_id) THEN
		MessageBox("Warning", "Invalid carrier ID!", StopSign! )
		Return 
	ELSE
		dw_carrier.Update(TRUE, TRUE)
	END IF
	
	IF wf_set_status_to_done() = 1 THEN
		MessageBox("Info", "Shipment has been sent!" )
	END IF
	
	li_rc = f_edi_856(il_current_packing_list)
	CHOOSE CASE li_rc
		CASE 1
			MessageBox("Info", "EDI sent successfully!" )
		CASE -1
			MessageBox("Error","EDI failed, see EDI log file for details!", StopSign!)
		CASE 100
			MessageBox("Info","EDI failed due to one of the following:~r~n 1) EDI had been sent already ~r~n 2) Customer does NOT require EDI transaction ~r~n 3) Shipment contains NO item " )
	END CHOOSE
	
END IF

end event

event ue_whoami;RETURN "w_shipping_dock"
end event

public subroutine wf_barinput_decoder ();String ls_input, ls_plate
Long ll_input, ll_row
Int li_flag, li_len
n_cst_datetime inv_datetime

li_len = Len(sle_input.Text)

CHOOSE CASE Left(sle_input.Text, 1)
	CASE "T"
		sle_input.BackColor = RGB(0, 255, 0)
		inv_datetime.of_Wait(1)
		Beep(1)
		st_plist.Text = "Shipment: " + Right(sle_input.Text, (li_len - 1))
		il_current_packing_list = Long(Right(sle_input.Text, (li_len - 1)))
		dw_carrier.Event pfc_retrieve()
		Open(w_truck_plate_input)
		ls_plate = Message.StringParm
		ll_row = dw_carrier.GetRow()
		IF ll_row > 0 THEN
			dw_carrier.SetItem(ll_row,"Vehicle_id", ls_plate)
		END IF
		wf_display_items(il_current_packing_list)
	CASE "S"
		wf_ok_item(Long(Right(sle_input.Text, (li_len - 1))), 1)
	CASE "C"
		wf_ok_item(Long(Right(sle_input.Text, (li_len - 1))), 4)
	CASE "W"
		wf_ok_item(Long(Right(sle_input.Text, (li_len - 1))), 3)
	CASE "R"
		wf_ok_item(Long(Right(sle_input.Text, (li_len - 1))), 2)
	CASE ELSE
		sle_input.BackColor = RGB(255, 0, 0)
		Beep(3)
		MessageBox("Error", "Unidentified data!", StopSign!)
END CHOOSE

//ending
sle_input.BackColor = RGB(192, 192, 192)

end subroutine

public subroutine wf_display_items (long al_packing_list);Long ll_row, ll_i, ll_item_row
Long ll_item, ll_orig_num
String ls_packing_ticket
//sheet_skid
ids_sheet_skid.Retrieve(il_current_packing_list)
ll_row = ids_sheet_skid.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		ll_item = ids_sheet_skid.GetItemNumber(ll_i, "sh_packing_item" )
		ls_packing_ticket = String(ids_sheet_skid.GetItemNumber(ll_i, "sheet_packaging_ticket" ), "########")
		ll_orig_num = ids_sheet_skid.GetItemNumber(ll_i, "sheet_skid_num" )
		ll_item_row = dw_item.Event pfc_addrow()
		dw_item.Event ue_fill_new_row(ll_item_row,ll_item, ls_packing_ticket, ll_orig_num, 1)
	NEXT
END IF

//Scrap_skid
ids_scrap_skid.Retrieve(il_current_packing_list)
ll_row = ids_scrap_skid.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		ll_item = ids_scrap_skid.GetItemNumber(ll_i, "sc_packing_item" )
		ls_packing_ticket = String(ids_scrap_skid.GetItemNumber(ll_i, "scrap_packaging_ticket" ), "########")
		ll_orig_num = ids_scrap_skid.GetItemNumber(ll_i, "scrap_skid_num" )
		ll_item_row = dw_item.Event pfc_addrow()
		dw_item.Event ue_fill_new_row(ll_item_row,ll_item, ls_packing_ticket, ll_orig_num, 2)
	NEXT
END IF

//rej_coil
ids_rej_coil.Retrieve(il_current_packing_list)
ll_row = ids_rej_coil.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		ll_item = ids_rej_coil.GetItemNumber(ll_i, "rej_coil_packing_item" )
		ls_packing_ticket = String(ids_rej_coil.GetItemNumber(ll_i, "rej_coil_packaging_ticket" ), "########")
		ll_orig_num = ids_rej_coil.GetItemNumber(ll_i, "coil_abc_num" )
		ll_item_row = dw_item.Event pfc_addrow()
		dw_item.Event ue_fill_new_row(ll_item_row, ll_item, ls_packing_ticket, ll_orig_num, 4)
	NEXT
END IF

//wh_item
ids_wh_item.Retrieve(il_current_packing_list)
ll_row = ids_wh_item.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		ll_item = ids_wh_item.GetItemNumber(ll_i, "wh_packing_item" )
		ls_packing_ticket = ids_wh_item.GetItemString(ll_i, "wh_packing_ticket" )
		ll_orig_num = ids_wh_item.GetItemNumber(ll_i, "wh_item_num" )
		ll_item_row = dw_item.Event pfc_addrow()
		dw_item.Event ue_fill_new_row(ll_item_row, ll_item, ls_packing_ticket, ll_orig_num, 3)
	NEXT
END IF

dw_item.inv_sort.of_SetSort("item_num")
dw_item.inv_sort.of_Sort()
ll_row = dw_item.RowCount()
IF ll_row > 0 THEN 
	st_total.Text = String(ll_row, "#####")
	st_loaded.Text = "0"
	st_error.Text = "0"
END IF
end subroutine

public subroutine wf_ok_item (long al_item_id, integer ai_type);Long ll_row, ll_i, ll_id
String ls_s
Boolean lb_yesitem

ll_row = dw_item.RowCount()
IF ll_row < 1 THEN Return
lb_yesitem = FALSE
FOR ll_i = 1 TO ll_row
	ll_id = dw_item.GetItemNumber(ll_i, "skid_or_coil_num")
	IF ll_id = al_item_id THEN
		CHOOSE CASE ai_type
			CASE 1
				ls_s = dw_item.GetItemString(ll_i, "type")
				IF ls_s = "Sheet" THEN
					dw_item.SetItem(ll_i,"ok","X")
					st_loaded.Text = String((Long(st_loaded.Text) + 1), "####")
					lb_yesitem = TRUE
				END IF
			CASE 2
				ls_s = dw_item.GetItemString(ll_i, "type")
				IF ls_s = "Scrap" THEN
					dw_item.SetItem(ll_i,"ok","X")
					st_loaded.Text = String((Long(st_loaded.Text) + 1), "####")
					lb_yesitem = TRUE
				END IF
			CASE 3
				ls_s = dw_item.GetItemString(ll_i, "type")
				IF ls_s = "Warehouse" THEN
					dw_item.SetItem(ll_i,"ok","X")
					st_loaded.Text = String((Long(st_loaded.Text) + 1), "####")
					lb_yesitem = TRUE
				END IF
			CASE 4
				ls_s = dw_item.GetItemString(ll_i, "type")
				IF ls_s = "Coil" THEN
					dw_item.SetItem(ll_i,"ok","X")
					st_loaded.Text = String((Long(st_loaded.Text) + 1), "####")
					lb_yesitem = TRUE
				END IF
			CASE ELSE
				ls_s = dw_item.GetItemString(ll_i, "type")
				IF ls_s = "Other" THEN
					dw_item.SetItem(ll_i,"ok","X")
					st_loaded.Text = String((Long(st_loaded.Text) + 1), "####")
					lb_yesitem = TRUE
				END IF
		END CHOOSE
	END IF
NEXT

IF NOT(lb_yesitem) THEN
	wf_add_del_errors(al_item_id, ai_type)
END IF

IF (st_total.Text = st_loaded.Text) AND (Long(st_error.Text) = 0)THEN
	Beep(5)
	cb_send.Enabled = TRUE
END IF
end subroutine

public function integer wf_set_status_to_done ();Long ll_skid, ll_row, ll_i

CONNECT USING SQLCA;
UPDATE Shipment
SET shipment_status = 0
WHERE packing_list = : il_current_packing_list
USING SQLCA;
IF SQLCA.SQLNRows <= 0 THEN
	ROLLBACK USING SQLCA;
	Return -1
END IF

//sheet_skid
ll_row = ids_sheet_skid.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		ll_skid = ids_sheet_skid.GetItemNumber(ll_i, "sheet_skid_num" )
		UPDATE sheet_skid
		SET skid_sheet_status = 0
		WHERE sheet_skid_num = :ll_skid
		USING SQLCA;
		IF SQLCA.SQLNRows <= 0 THEN
			ROLLBACK USING SQLCA;
			Return -2
		END IF		
	NEXT
END IF

//Scrap_skid
ll_row = ids_scrap_skid.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		ll_skid = ids_scrap_skid.GetItemNumber(ll_i, "scrap_skid_num" )
		UPDATE scrap_skid
		SET skid_scrap_status = 0
		WHERE scrap_skid_num = :ll_skid
		USING SQLCA;
		IF SQLCA.SQLNRows <= 0 THEN
			ROLLBACK USING SQLCA;
			Return -3
		END IF		
	NEXT
END IF

//rej_coil
ll_row = ids_rej_coil.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		ll_skid = ids_rej_coil.GetItemNumber(ll_i, "coil_abc_num" )
		UPDATE coil
		SET coil_status = 10
		WHERE coil_abc_num = :ll_skid
		USING SQLCA;
		IF SQLCA.SQLNRows <= 0 THEN
			ROLLBACK USING SQLCA;
			Return -4
		END IF		
	NEXT
END IF

//wh_item
ll_row = ids_wh_item.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		ll_skid = ids_wh_item.GetItemNumber(ll_i, "wh_item_num" )
		UPDATE wh_item
		SET wh_status = 0
		WHERE wh_item_num = :ll_skid
		USING SQLCA;
		IF SQLCA.SQLNRows <= 0 THEN
			ROLLBACK USING SQLCA;
			Return -5
		END IF		
	NEXT
END IF

COMMIT USING SQLCA;

RETURN 1
end function

public function integer wf_add_del_errors (long al_item_id, integer ai_type);Long ll_row, ll_i
Boolean lb_add

ll_row = dw_error.RowCount()
lb_add = TRUE
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		IF (dw_error.GetItemNumber(ll_i,"type") = ai_type) AND (dw_error.GetItemNumber(ll_i,"id") = al_item_id) THEN
			IF (Long(st_error.Text) - 1) = 0 THEN
				st_error.Text = '0'
			ELSE
				st_error.Text = String((Long(st_error.Text) - 1), "####")
			END IF
			dw_error.DeleteRow(ll_i)
			lb_add = FALSE
		END IF
	NEXT
END IF

IF lb_add THEN
	ii_err_type = ai_type
	il_err_id = al_item_id
	dw_error.Event pfc_addrow()
	st_error.Text = String((Long(st_error.Text) + 1), "####")
	cb_send.Enabled = FALSE
END IF

dw_error.ResetUpdate()
RETURN 1
end function

on w_shipping_dock.create
int iCurrent
call super::create
this.dw_carrier=create dw_carrier
this.sle_input=create sle_input
this.st_plist=create st_plist
this.dw_item=create dw_item
this.st_1=create st_1
this.st_total=create st_total
this.st_2=create st_2
this.st_loaded=create st_loaded
this.cb_send=create cb_send
this.cb_close=create cb_close
this.cb_print=create cb_print
this.st_3=create st_3
this.st_error=create st_error
this.dw_error=create dw_error
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_carrier
this.Control[iCurrent+2]=this.sle_input
this.Control[iCurrent+3]=this.st_plist
this.Control[iCurrent+4]=this.dw_item
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_total
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.st_loaded
this.Control[iCurrent+9]=this.cb_send
this.Control[iCurrent+10]=this.cb_close
this.Control[iCurrent+11]=this.cb_print
this.Control[iCurrent+12]=this.st_3
this.Control[iCurrent+13]=this.st_error
this.Control[iCurrent+14]=this.dw_error
this.Control[iCurrent+15]=this.st_4
end on

on w_shipping_dock.destroy
call super::destroy
destroy(this.dw_carrier)
destroy(this.sle_input)
destroy(this.st_plist)
destroy(this.dw_item)
destroy(this.st_1)
destroy(this.st_total)
destroy(this.st_2)
destroy(this.st_loaded)
destroy(this.cb_send)
destroy(this.cb_close)
destroy(this.cb_print)
destroy(this.st_3)
destroy(this.st_error)
destroy(this.dw_error)
destroy(this.st_4)
end on

event key;call super::key;IF KeyDown(KeyEnter!) THEN 
	IF il_barinput = 1 THEN
		wf_barinput_decoder()
		sle_input.Event pfc_SelectAll()
		sle_input.Event pfc_Clear()
		sle_input.SetFocus()
		il_barinput = 1
	END IF
END IF

end event

event close;call super::close;Destroy(ids_sheet_skid)
Destroy(ids_scrap_skid)
Destroy(ids_wh_item)
Destroy(ids_rej_coil)
f_display_app()

end event

event open;call super::open;ids_sheet_skid = CREATE datastore  
ids_sheet_skid.DataObject = "d_sheet_packing_item"  
ids_sheet_skid.SetTransObject (SQLCA)  

ids_scrap_skid = CREATE datastore  
ids_scrap_skid.DataObject = "d_scrap_packing_item"  
ids_scrap_skid.SetTransObject (SQLCA)  

ids_wh_item = CREATE datastore  
ids_wh_item.DataObject = "d_wh_packing_item"  
ids_wh_item.SetTransObject (SQLCA)  

ids_rej_coil = CREATE datastore  
ids_rej_coil.DataObject = "d_rej_coil_packing_item"  
ids_rej_coil.SetTransObject (SQLCA)  

cb_send.Enabled = FALSE
st_error.Text = '0'
sle_input.SetFocus()

end event

type dw_carrier from u_dw within w_shipping_dock
int X=7
int Y=147
int Width=1485
int Height=272
int TabOrder=50
string DataObject="d_shipment_carrier_info_dock"
boolean VScrollBar=false
boolean LiveScroll=false
end type

event constructor;call super::constructor;this.SetTransObject(SQLCA)
end event

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve(il_current_packing_list)
end event

event rbuttondown;Return 1
end event

event rbuttonup;Return 1
end event

type sle_input from u_sle within w_shipping_dock
int X=2019
int Y=0
int TabOrder=60
boolean Border=false
BorderStyle BorderStyle=StyleBox!
long TextColor=79741120
long BackColor=12632256
string FaceName="Arial"
end type

event losefocus;call super::losefocus;il_barinput = 0
end event

event getfocus;call super::getfocus;il_barinput = 1
end event

type st_plist from statictext within w_shipping_dock
int Width=1492
int Height=150
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
string Text="shipment :"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-22
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_item from u_dw within w_shipping_dock
event type integer ue_fill_new_row ( long al_row,  long al_item_num,  string as_ticket,  long al_orig,  integer ai_type )
int X=7
int Y=426
int Width=2132
int Height=1066
int TabOrder=40
string DataObject="d_shipment_dock_detail"
end type

event ue_fill_new_row;SetItem(al_row, "item_num", al_item_num )
SetItem(al_row, "packing_ticket", as_ticket)
SetItem(al_row, "skid_or_coil_num", al_orig)
CHOOSE CASE ai_type
	CASE 1
		SetItem(al_row, "type", "Sheet" )
	CASE 2
		SetItem(al_row, "type", "Scrap" )
	CASE 3
		SetItem(al_row, "type", "Warehouse" )
	CASE 4
		SetItem(al_row, "type", "Coil" )
	CASE ELSE
		SetItem(al_row, "type", "Other" )
END CHOOSE

Return 1
		
end event

event rbuttondown;Return 1
end event

event rbuttonup;Return 1
end event

event pfc_addrow;call super::pfc_addrow;Long ll_row
ll_row = This.GetRow()
Return ll_row
end event

event constructor;call super::constructor;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

type st_1 from statictext within w_shipping_dock
int X=1547
int Y=109
int Width=307
int Height=77
boolean Enabled=false
boolean BringToTop=true
string Text="TOTAL:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-12
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_total from statictext within w_shipping_dock
int X=1547
int Y=198
int Width=296
int Height=189
boolean Enabled=false
boolean BringToTop=true
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-28
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_shipping_dock
int X=1869
int Y=109
int Width=325
int Height=77
boolean Enabled=false
boolean BringToTop=true
string Text="LOADED:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-12
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_loaded from statictext within w_shipping_dock
int X=1858
int Y=195
int Width=355
int Height=192
boolean Enabled=false
boolean BringToTop=true
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-28
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_send from u_cb within w_shipping_dock
int X=2187
int Y=1078
int TabOrder=30
string Text="&Send"
int Weight=700
string FaceName="Arial"
end type

event clicked;call super::clicked;Parent.Event ue_shipment_sent()
this.Enabled = FALSE
end event

type cb_close from u_cb within w_shipping_dock
int X=2187
int Y=1363
int TabOrder=20
string Text="&Close"
int Weight=700
string FaceName="Arial"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_print from u_cb within w_shipping_dock
int X=2187
int Y=1219
int TabOrder=10
string Text="&Print"
int Weight=700
string FaceName="Arial"
end type

type st_3 from statictext within w_shipping_dock
int X=2235
int Y=106
int Width=289
int Height=77
boolean Enabled=false
boolean BringToTop=true
string Text="ERROR:"
boolean FocusRectangle=false
long TextColor=255
long BackColor=12632256
int TextSize=-12
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_error from statictext within w_shipping_dock
int X=2245
int Y=195
int Width=260
int Height=192
boolean Enabled=false
boolean BringToTop=true
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=255
long BackColor=12632256
int TextSize=-28
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_error from u_dw within w_shipping_dock
int X=2150
int Y=483
int Width=417
int Height=547
int TabOrder=2
string DataObject="d_error_id_list_shipping"
end type

event pfc_addrow;call super::pfc_addrow;Long ll_row
ll_row = this.GetRow()
IF ll_row > 0 THEN
	this.SetItem(ll_row, "type", ii_err_type)
	this.SetItem(ll_row, "id", il_err_id)
END IF

Return 1
 
end event

event constructor;call super::constructor;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

event rbuttondown;//Override

Return 1
end event

event rbuttonup;//Override
Return 1
end event

type st_4 from statictext within w_shipping_dock
int X=2150
int Y=426
int Width=307
int Height=58
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
string Text="Wrong items:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

