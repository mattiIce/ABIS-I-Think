$PBExportHeader$w_calendar.srw
$PBExportComments$Calendar utility. Return "mm/dd/yyyy" formated string
forward
global type w_calendar from w_sheet
end type
type em_calendar from u_em within w_calendar
end type
type uo_calendar_1 from u_calendar within w_calendar
end type
type cb_ok from u_cb within w_calendar
end type
end forward

global type w_calendar from w_sheet
int X=1170
int Y=352
int Width=702
int Height=822
WindowType WindowType=response!
boolean TitleBar=true
string Title="Calendar"
long BackColor=80269524
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
em_calendar em_calendar
uo_calendar_1 uo_calendar_1
cb_ok cb_ok
end type
global w_calendar w_calendar

type variables
Int ii_refresh_flag =0 
end variables

on w_calendar.create
int iCurrent
call super::create
this.em_calendar=create em_calendar
this.uo_calendar_1=create uo_calendar_1
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_calendar
this.Control[iCurrent+2]=this.uo_calendar_1
this.Control[iCurrent+3]=this.cb_ok
end on

on w_calendar.destroy
call super::destroy
destroy(this.em_calendar)
destroy(this.uo_calendar_1)
destroy(this.cb_ok)
end on

event open;call super::open;em_calendar.Text =  String(Today(), "mm/dd/yyyy")


end event

type em_calendar from u_em within w_calendar
int X=29
int Y=637
int Width=644
int Height=67
int TabOrder=20
boolean Visible=false
boolean BringToTop=true
string Mask="mm/dd/yyyy"
MaskDataType MaskDataType=DateMask!
double Increment=0
string MinMax=""
FontCharSet FontCharSet=Ansi!
end type

event constructor;uo_calendar_1.of_SetRequestor(this)
end event

event other;if ii_refresh_flag = 1 then
	//CloseWithReturn(Parent, em_calendar.Text)
end if
RETURN 1


end event

type uo_calendar_1 from u_calendar within w_calendar
int X=0
int Y=0
int TabOrder=10
boolean BringToTop=true
long BackColor=79741120
end type

on uo_calendar_1.destroy
call u_calendar::destroy
end on

type cb_ok from u_cb within w_calendar
int X=190
int Y=646
int Width=304
int Height=77
int TabOrder=11
boolean BringToTop=true
string Text="OK"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;CloseWithReturn(Parent, em_calendar.Text)
RETURN 1
end event

