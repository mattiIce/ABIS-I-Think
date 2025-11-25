$PBExportHeader$w_shipment_rehash.srw
$PBExportComments$<sheet> Reverse a shipment from DONE to new status
forward
global type w_shipment_rehash from w_sheet
end type
type dw_customer from u_dw within w_shipment_rehash
end type
type dw_shipment from u_dw within w_shipment_rehash
end type
type cb_apply from u_cb within w_shipment_rehash
end type
type cb_close from u_cb within w_shipment_rehash
end type
end forward

global type w_shipment_rehash from w_sheet
int X=300
int Y=144
int Width=3204
int Height=1814
boolean TitleBar=true
string Title="Reverse a shipment "
boolean MaxBox=false
boolean Resizable=false
event type string ue_whoami ( )
event ue_read_only ( )
dw_customer dw_customer
dw_shipment dw_shipment
cb_apply cb_apply
cb_close cb_close
end type
global w_shipment_rehash w_shipment_rehash

type variables
String is_modifier

end variables

forward prototypes
public function integer wf_display_total_info ()
end prototypes

event ue_whoami;RETURN "w_shipment_rehash"
end event

event ue_read_only;cb_apply.Enabled = FALSE
end event

public function integer wf_display_total_info ();Long ll_row, ll_cust, ll_item

ll_row = dw_customer.GetRow()
IF ll_row <= 0 THEN RETURN 0
ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")

CONNECT USING SQLCA;
SELECT COUNT(packing_list) INTO :ll_item
FROM shipment
WHERE (customer_id = :ll_cust) AND (shipment_status = 0)
USING SQLCA;

IF IsNULL(ll_item) THEN ll_item = 0

IF ll_item < 2 THEN
	dw_shipment.Object.item_t.Text = String(ll_item, "#,###,###") 
	dw_shipment.Object.ship_t.Text = "shipment listed here" 
ELSE
	dw_shipment.Object.item_t.Text = String(ll_item, "#,###,###") 
	dw_shipment.Object.ship_t.Text = "shipments listed here" 
END IF

RETURN 1
	
end function

on w_shipment_rehash.create
int iCurrent
call super::create
this.dw_customer=create dw_customer
this.dw_shipment=create dw_shipment
this.cb_apply=create cb_apply
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_customer
this.Control[iCurrent+2]=this.dw_shipment
this.Control[iCurrent+3]=this.cb_apply
this.Control[iCurrent+4]=this.cb_close
end on

on w_shipment_rehash.destroy
call super::destroy
destroy(this.dw_customer)
destroy(this.dw_shipment)
destroy(this.cb_apply)
destroy(this.cb_close)
end on

event open;call super::open;s_security_data  lds_sec

IF f_security_door("Shipment(Rehash)") < 0 THEN
	OpenWithParm(w_security_check, "Shipment(Rehash)")
	lds_sec = Message.PowerObjectParm
	IF lds_sec.security_level < 0 THEN
		Close(this)
		RETURN 0
	END IF
END IF

is_modifier = lds_sec.who

dw_customer.of_SetLinkage(TRUE)

dw_shipment.of_SetLinkage( TRUE ) 
dw_shipment.inv_Linkage.of_SetMaster(dw_customer)
IF NOT dw_shipment.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked customer & shipment in win w_shipping_2!" )
ELSE
	dw_shipment.inv_Linkage.of_Register( "customer_id", "customer_id" ) 
	dw_shipment.inv_Linkage.of_SetStyle( 2 ) 
END IF

dw_customer.inv_Linkage.of_SetTransObject(SQLCA) 
IF dw_customer.inv_linkage.of_retrieve() = -1 THEN
	ROLLBACK USING SQLCA;
	MessageBox("Error", "w_shipment_rehash::open function" )
ELSE
	COMMIT USING SQLCA;
	dw_customer.SelectRow(1,TRUE)
	dw_customer.SetFocus()
End IF
end event

event close;call super::close;f_display_app()
end event

event activate;call super::activate;IF f_security_door("Shipment(Rehash)") = 1 THEN RETURN 1
This.Event ue_read_only()
end event

type dw_customer from u_dw within w_shipment_rehash
int X=33
int Y=3
int Width=633
int Height=1606
int TabOrder=10
boolean BringToTop=true
string DataObject="d_customer_short_display"
boolean LiveScroll=false
end type

event rbuttondown;//Override
RETURN 1
end event

event rbuttonup;//Override
RETURN 1
end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

event constructor;SetRowFocusIndicator(Hand!)
of_SetBase(TRUE)
of_SetRowManager(TRUE)
of_SetRowSelect(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

event clicked;call super::clicked;SelectRow(0, FALSE)

// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

// Notify the RowSelect service that the row has been clicked.
IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF
SelectRow(row, TRUE)

// Sort services.
IF IsValid (inv_Sort) THEN 
	// Notify the Sort service, since it may have have a request
	// to sort on colum header.
	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
END IF 


end event

event pfc_retrieve;call super::pfc_retrieve;RETURN this.Retrieve()
end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)
wf_display_total_info()

Return 

end event

type dw_shipment from u_dw within w_shipment_rehash
event type integer ue_reverse ( )
int X=673
int Y=3
int Width=2487
int Height=1610
int TabOrder=30
boolean BringToTop=true
string DataObject="d_shipment_done_list"
boolean HScrollBar=true
boolean VScrollBar=false
end type

event ue_reverse;Long ll_row, ll_shipment, ll_skid
integer li_row, li_totalrow, li_int, li_rc
String ls_packing_ticket
DataStore lds_item
String ls_message
DateTime ld_1
Long ll_system_log
Int li_coilstatus

ll_row = this.Getrow()
IF ll_row < 1 THEN RETURN 0
ll_shipment = GetItemNumber(ll_row, "packing_list")
IF MessageBox("Question", "Reverse shipment# " + String(ll_shipment, "########") + " ?", Question!, YESNO!) <> 1 THEN RETURN -1


SetPointer(HourGlass!)
ls_message = "Shipment# " + String(ll_shipment, "########") + " by " + is_modifier + " @" + String(Today(), "mm-dd-yyyy HH:MM.")
lds_item = CREATE DataStore

//sheet skid
lds_item.dataObject = "d_sheet_packing_item"
lds_item.SetTransObject(SQLCA)
lds_item.Retrieve(ll_shipment)

li_totalrow = lds_item.RowCount()
IF li_totalrow > 0 THEN 
	ls_message = ls_message + " " + String(li_totalrow, "####") + " Skid: "
	FOR li_int = 1 TO li_totalrow
		ll_skid = lds_item.GetItemNumber( li_int, "sheet_skid_num", Primary!, FALSE)
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
			DESTROY lds_item
			ROLLBACK USING SQLCA;
			RETURN -1
		END IF
	NEXT
END IF

// warehouse items
lds_item.dataObject = "d_wh_packing_item"
lds_item.SetTransObject(SQLCA)
lds_item.Retrieve(ll_shipment)

li_totalrow = 0
li_totalrow = lds_item.RowCount()
IF li_totalrow > 0 THEN 
	ls_message = ls_message + " and " + String(li_totalrow, "####") + " Warehouse skid: "
	FOR li_int = 1 TO li_totalrow
		ll_skid = lds_item.GetItemNumber( li_int, "sheet_skid_num", Primary!, FALSE)
		CONNECT USING SQLCA;
		UPDATE sheet_skid 
		SET Skid_sheet_status = 8  //wh-ready
		WHERE sheet_skid_num = :ll_skid
		USING SQLCA;
		IF SQLCA.SQLNRows > 0 THEN
			//COMMIT USING SQLCA;
			ls_message = ls_message + " #" + String(ll_skid, "########") + ", "
		ELSE
			MessageBox("Error", "Reverse failed at skid table! - WH", StopSign!)
			DESTROY lds_item
			ROLLBACK USING SQLCA;
			RETURN -2
		END IF
	NEXT
END IF

//Scrap
lds_item.dataObject = "d_scrap_packing_item"
lds_item.SetTransObject(SQLCA)
lds_item.Retrieve(ll_shipment)

li_totalrow = 0
li_totalrow = lds_item.RowCount()
IF li_totalrow > 0 THEN 
	ls_message = ls_message + " and " + String(li_totalrow, "####") + " scrap skid: "
	FOR li_int = 1 TO li_totalrow
		ll_skid = lds_item.GetItemNumber(li_int, "scrap_skid_num", Primary!, TRUE)
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
			DESTROY lds_item
			ROLLBACK USING SQLCA;
			RETURN -3
		END IF	
	NEXT
END IF

//rej coil
lds_item.dataObject = "d_rej_coil_packing_item"
lds_item.SetTransObject(SQLCA)
lds_item.Retrieve(ll_shipment)

li_totalrow = 0
li_totalrow = lds_item.RowCount()
IF li_totalrow > 0 THEN 
	ls_message = ls_message + " and " + String(li_totalrow, "####") + " coils: "
	FOR li_int = 1 TO li_totalrow
		ll_skid = lds_item.GetItemNumber(li_int, "coil_abc_num", Primary!, FALSE)
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
			DESTROY lds_item
			ROLLBACK USING SQLCA;
			RETURN -4
		END IF	
		
		IF SQLCA.SQLNRows > 0 THEN
			//COMMIT USING SQLCA;
			ls_message = ls_message + " #" + String(ll_skid, "######")
		ELSE
			MessageBox("Error", "Reverse failed at rejected coil table!", StopSign!)
			DESTROY lds_item
			ROLLBACK USING SQLCA;
			RETURN -5
		END IF	
	NEXT
END IF

//shipment info
lds_item.dataObject = "d_shipment_detail"
lds_item.SetTransObject(SQLCA)
lds_item.Retrieve(ll_shipment)

ll_row = lds_item.GetRow()
IF ll_row <= 0 THEN Return -1
ld_1 = lds_item.GetItemDateTime(ll_row,"shipment_actualed_date_time")
ls_message = ls_message + ". actualed=" + String(ld_1, "mm-dd-yyyy HH:MM")
ld_1 = lds_item.GetItemDateTime(ll_row,"shipment_des_edi856_date")
ls_message = ls_message + ". des_edi856_date=" + String(ld_1, "mm-dd-yyyy HH:MM")
ld_1 = lds_item.GetItemDateTime(ll_row,"shipment_edi856_date")
ls_message = ls_message + ".edi856_date=" + String(ld_1, "mm-dd-yyyy HH:MM")
SetNULL(ld_1)
lds_item.SetItem(ll_row, "shipment_status", 2 )
lds_item.SetItem(ll_row, "vehicle_status", 2 )
lds_item.SetItem(ll_row, "shipment_actualed_date_time", ld_1 )
lds_item.SetItem(ll_row, "shipment_des_edi856_date", ld_1 )
lds_item.SetItem(ll_row, "shipment_edi856_date", ld_1 )

li_rc = lds_item.Update()
IF li_rc = 1 AND SQLCA.SQLNRows > 0 THEN
	COMMIT USING SQLCA;
ELSE
	MessageBox("Error", "Reverse failed at shipment table!", StopSign!)
	DESTROY lds_item
	ROLLBACK USING SQLCA;
	RETURN -7
END IF

DESTROY lds_item
MessageBox("Reverse success", ls_message)
f_add_system_log(ls_message)
ll_row = this.Getrow()
this.DeleteRow(ll_row)
this.ResetUpdate()

Window lw_sheet, lw_frame
Boolean lb_v
lw_frame = gnv_app.of_GetFrame()
lw_sheet = lw_frame.GetFirstSheet()
IF IsValid(lw_sheet) THEN
	DO
		lw_sheet = lw_frame.GetNextSheet(lw_sheet)
		lb_v = IsValid(lw_sheet)
		IF lb_v THEN
			lw_sheet.Dynamic Event ue_retrieve_rehashed(ll_shipment)
		END IF
	LOOP WHILE lb_v
END IF

RETURN 1

end event

event rbuttondown;//Override
RETURN 1
end event

event rbuttonup;call super::rbuttonup;//Override
RETURN 1
end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

event constructor;of_SetBase(TRUE)
of_SettransObject(SQLCA)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

this.ScrollToRow(li_Row)

Return 

end event

event clicked;integer li_rc

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

type cb_apply from u_cb within w_shipment_rehash
int X=936
int Y=1626
int Height=83
int TabOrder=20
boolean BringToTop=true
string Text="&Apply"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;dw_shipment.Event ue_reverse()

end event

type cb_close from u_cb within w_shipment_rehash
int X=1810
int Y=1626
int Height=83
int TabOrder=11
boolean BringToTop=true
string Text="&Close"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Close(Parent)
end event

