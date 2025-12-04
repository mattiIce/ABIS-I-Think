$PBExportHeader$w_truck_plate_input.srw
$PBExportComments$<Popup> let user input license plate number during shipment  inherited from pfemain\w_popup
forward
global type w_truck_plate_input from w_popup
end type
type cb_1 from u_cb within w_truck_plate_input
end type
type st_1 from statictext within w_truck_plate_input
end type
type sle_plate from singlelineedit within w_truck_plate_input
end type
end forward

global type w_truck_plate_input from w_popup
int X=574
int Y=397
int Width=1379
int Height=598
WindowType WindowType=response!
boolean TitleBar=true
string Title="Input truck licence plate number"
long BackColor=255
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_1 cb_1
st_1 st_1
sle_plate sle_plate
end type
global w_truck_plate_input w_truck_plate_input

type variables
Long il_coil_num
end variables

event open;call super::open;SetFocus(sle_plate)
end event

on w_truck_plate_input.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.st_1=create st_1
this.sle_plate=create sle_plate
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.sle_plate
end on

on w_truck_plate_input.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.sle_plate)
end on

event key;call super::key;IF KeyDown(KeyEnter!) THEN 
	IF len(sle_plate.Text) > 1 THEN CloseWithReturn(this, sle_plate.Text)
END IF

end event

type cb_1 from u_cb within w_truck_plate_input
int X=501
int Y=394
int Height=86
string Text="OK"
end type

event clicked;call super::clicked;IF len(sle_plate.Text) > 1 THEN
	CloseWithReturn(Parent, sle_plate.Text)
ELSE
	MessageBox("Warning","Licence plate number must be keyed in here!")
END IF
end event

type st_1 from statictext within w_truck_plate_input
int X=4
int Y=6
int Width=1050
int Height=93
boolean Enabled=false
boolean BringToTop=true
string Text="LICENSE PLATE NUMBER"
boolean FocusRectangle=false
long BackColor=255
int TextSize=-14
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_plate from singlelineedit within w_truck_plate_input
int X=15
int Y=122
int Width=1339
int Height=214
int TabOrder=1
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
TextCase TextCase=Upper!
long BackColor=16777215
int TextSize=-28
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

