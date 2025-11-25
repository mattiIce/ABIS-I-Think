$PBExportHeader$w_shipping_saveas.srw
$PBExportComments$<Response> select save mode in w_shipping inherited from pfemain/w_response
forward
global type w_shipping_saveas from w_response
end type
type cb_cancel from u_cb within w_shipping_saveas
end type
type cb_ok from u_cb within w_shipping_saveas
end type
type rb_1 from u_rb within w_shipping_saveas
end type
type rb_2 from u_rb within w_shipping_saveas
end type
type st_1 from statictext within w_shipping_saveas
end type
type st_2 from statictext within w_shipping_saveas
end type
end forward

global type w_shipping_saveas from w_response
int X=1295
int Y=550
int Width=1203
int Height=800
boolean TitleBar=true
string Title="Save as"
cb_cancel cb_cancel
cb_ok cb_ok
rb_1 rb_1
rb_2 rb_2
st_1 st_1
st_2 st_2
end type
global w_shipping_saveas w_shipping_saveas

on w_shipping_saveas.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.rb_1=create rb_1
this.rb_2=create rb_2
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.rb_1
this.Control[iCurrent+4]=this.rb_2
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_2
end on

on w_shipping_saveas.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.st_1)
destroy(this.st_2)
end on

type cb_cancel from u_cb within w_shipping_saveas
int X=699
int Y=570
int TabOrder=20
boolean BringToTop=true
string Text="&Cancel"
end type

event clicked;CloseWithReturn(Parent, 0)
end event

type cb_ok from u_cb within w_shipping_saveas
int X=117
int Y=570
int TabOrder=10
boolean BringToTop=true
string Text="&Ok"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;IF rb_1.Checked THEN 
	CloseWithReturn(Parent, 1)
ELSE
	CloseWithReturn(Parent, 2)
END IF
end event

type rb_1 from u_rb within w_shipping_saveas
int X=161
int Y=58
int Width=892
boolean BringToTop=true
string Text="Save as DONE shipment"
long BackColor=79741120
int TextSize=-10
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

type rb_2 from u_rb within w_shipping_saveas
int X=161
int Y=326
int Width=256
boolean BringToTop=true
string Text="Save "
boolean Checked=true
long BackColor=79741120
int TextSize=-10
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

type st_1 from statictext within w_shipping_saveas
int X=227
int Y=138
int Width=834
int Height=166
boolean Enabled=false
boolean BringToTop=true
string Text="Shipment is DONE and no change can be made to this shipment anymore. Are you sure?"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_shipping_saveas
int X=227
int Y=406
int Width=848
int Height=90
boolean Enabled=false
boolean BringToTop=true
string Text="Save current data into database"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

