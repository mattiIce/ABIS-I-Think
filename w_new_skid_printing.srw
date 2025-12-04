$PBExportHeader$w_new_skid_printing.srw
$PBExportComments$<Sheet>input/display a certain number of new skid information, inherited from  pfemain.pbl/w_sheet
forward
global type w_new_skid_printing from w_sheet
end type
type cb_close from u_cb within w_new_skid_printing
end type
type st_1 from statictext within w_new_skid_printing
end type
type cb_create from u_cb within w_new_skid_printing
end type
type em_num from u_em within w_new_skid_printing
end type
type st_info from statictext within w_new_skid_printing
end type
type dw_new from u_dw within w_new_skid_printing
end type
type rb_sheet from u_rb within w_new_skid_printing
end type
type rb_scrap from u_rb within w_new_skid_printing
end type
end forward

global type w_new_skid_printing from w_sheet
int Width=2081
int Height=314
boolean TitleBar=true
string Title="New Tare ID Generator"
boolean MaxBox=false
boolean Resizable=false
event ue_create ( )
event type string ue_whoami ( )
cb_close cb_close
st_1 st_1
cb_create cb_create
em_num em_num
st_info st_info
dw_new dw_new
rb_sheet rb_sheet
rb_scrap rb_scrap
end type
global w_new_skid_printing w_new_skid_printing

event ue_create;Long ll_num, ll_i, ll_last_id
datastore lds_skid

ll_num = Long(em_num.Text)
IF ll_num < 1 THEN 
	MessageBox("Error", "How many new tare tags do you want to create?", StopSign!)
	RETURN
ELSE
	ll_i = MessageBox("Just a double check", "About to create " + em_num.Text + " skid tags.", Question!, OKCancel!, 2)
	IF ll_i = 2 THEN RETURN
END IF

ll_last_id = dw_new.Event pfc_addrow()

FOR ll_i = 2 TO ll_num
	dw_new.Event pfc_addrow()
NEXT

dw_new.Update(TRUE, FALSE)
IF f_check_sqlcode(SQLCA, TRUE, TRUE ) < 0 THEN
	MessageBox("Error","Failed to create new skid numbers!", StopSign!)
	dw_new.Reset()
	Return
END IF
dw_new.ResetUpdate()

IF rb_sheet.Checked THEN
	lds_skid = CREATE datastore  
	lds_skid.DataObject = "d_report_new_skid_num"  
	lds_skid.SetTransObject (SQLCA)  
	lds_skid.Retrieve(ll_last_id)
	lds_skid.Print()
ELSE
	lds_skid = CREATE datastore  
	lds_skid.DataObject = "d_report_new_scrap_skid_num"  
	lds_skid.SetTransObject (SQLCA)  
	lds_skid.Retrieve(ll_last_id)
	lds_skid.Print()
END IF	

DESTROY lds_skid

St_info.Text = em_num.Text + " new skid tags had been printed!"
MessageBox("Info", "Printing is done!")


end event

event ue_whoami;RETURN "w_new_skid_printing"
end event

on w_new_skid_printing.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.st_1=create st_1
this.cb_create=create cb_create
this.em_num=create em_num
this.st_info=create st_info
this.dw_new=create dw_new
this.rb_sheet=create rb_sheet
this.rb_scrap=create rb_scrap
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_create
this.Control[iCurrent+4]=this.em_num
this.Control[iCurrent+5]=this.st_info
this.Control[iCurrent+6]=this.dw_new
this.Control[iCurrent+7]=this.rb_sheet
this.Control[iCurrent+8]=this.rb_scrap
end on

on w_new_skid_printing.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.st_1)
destroy(this.cb_create)
destroy(this.em_num)
destroy(this.st_info)
destroy(this.dw_new)
destroy(this.rb_sheet)
destroy(this.rb_scrap)
end on

event open;call super::open;s_security_data  lds_sec

IF f_security_door("New Pallet Ticket") < 0 THEN
	OpenWithParm(w_security_check, "New Pallet Ticket")
	lds_sec = Message.PowerObjectParm
	IF lds_sec.security_level < 0 THEN
		Close(this)
		RETURN 0
	END IF
END IF


rb_sheet.Checked = TRUE
end event

event close;call super::close;messagebox("hi", "hi")
f_display_app()

end event

type cb_close from u_cb within w_new_skid_printing
int X=1704
int Y=138
int TabOrder=20
string Text="&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type st_1 from statictext within w_new_skid_printing
int X=4
int Y=26
int Width=1488
int Height=86
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
string Text="How many new tare id tags do you want to create?"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-11
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_create from u_cb within w_new_skid_printing
int X=1335
int Y=138
int TabOrder=30
boolean BringToTop=true
string Text="C&reate"
end type

event clicked;call super::clicked;Parent.Event ue_create()
end event

type em_num from u_em within w_new_skid_printing
int X=1496
int Y=13
int Width=238
int Height=109
int TabOrder=10
Alignment Alignment=Center!
string Mask="###"
string DisplayData=""
double Increment=0
string MinMax=""
int TextSize=-14
string FaceName="Arial"
end type

type st_info from statictext within w_new_skid_printing
int X=11
int Y=150
int Width=1145
int Height=61
boolean Enabled=false
boolean BringToTop=true
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_new from u_dw within w_new_skid_printing
int X=1243
int Y=138
int Width=80
int Height=90
string DataObject="d_new_skid_tare_only"
boolean VScrollBar=false
boolean LiveScroll=false
end type

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
Visible = FALSE
SetTransObject(SQLCA)
end event

event pfc_addrow;call super::pfc_addrow;Long ll_row, ll_new_id

IF rb_Sheet.Checked THEN
	ll_row = this.GetRow()
	ll_new_id = f_get_next_value("sheet_skid_num_seq")
	this.SetItem(ll_row, "sheet_skid_num", ll_new_id)
	this.SetItem(ll_row, "skid_date", Today())
	this.SetItem(ll_row, "skid_sheet_status", 6 ) //tare only
ELSE
	ll_row = this.GetRow()
	ll_new_id = f_get_next_value("scrap_skid_num_seq")
	this.SetItem(ll_row, "scrap_skid_num", ll_new_id)
	this.SetItem(ll_row, "scrap_date", Today())
	this.SetItem(ll_row, "skid_scrap_status", 6 ) //tare only	
END IF

Return ll_new_id
end event

type rb_sheet from u_rb within w_new_skid_printing
int X=1737
int Y=3
int Width=333
int Height=61
string Text="Sheet Pallet"
long BackColor=79741120
string FaceName="Arial"
end type

event clicked;call super::clicked;dw_new.DataObject = "d_new_skid_tare_only"
dw_new.of_SetTransObject (SQLCA)  
dw_new.Retrieve()

end event

type rb_scrap from u_rb within w_new_skid_printing
int X=1737
int Y=67
int Height=58
string Text="Scrap Pallet"
long BackColor=79741120
string FaceName="Arial"
end type

event clicked;call super::clicked;dw_new.DataObject = "d_new_scrap_skid_tare_only"
dw_new.of_SetTransObject (SQLCA)  
dw_new.Retrieve()

end event

