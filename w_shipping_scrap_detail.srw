$PBExportHeader$w_shipping_scrap_detail.srw
$PBExportComments$<Response> display scrap skid detail in a shipmenet inherited from pfemain/w_response
forward
global type w_shipping_scrap_detail from w_response
end type
type dw_1 from u_dw within w_shipping_scrap_detail
end type
type cb_1 from u_cb within w_shipping_scrap_detail
end type
type st_1 from statictext within w_shipping_scrap_detail
end type
type st_2 from statictext within w_shipping_scrap_detail
end type
end forward

global type w_shipping_scrap_detail from w_response
int X=1115
int Y=426
int Width=1507
int Height=1082
boolean TitleBar=true
string Title="Scrap Skid Detail"
dw_1 dw_1
cb_1 cb_1
st_1 st_1
st_2 st_2
end type
global w_shipping_scrap_detail w_shipping_scrap_detail

on w_shipping_scrap_detail.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
end on

on w_shipping_scrap_detail.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.st_2)
end on

event open;call super::open;Long ll_skid

ll_skid = Message.DoubleParm
IF ll_skid > 0 THEN
	st_1.Text = "*R" + String(ll_skid) + "*"
	st_2.Text = String(ll_skid)
	dw_1.Retrieve(ll_skid)
END IF
end event

type dw_1 from u_dw within w_shipping_scrap_detail
int X=37
int Y=16
int Width=1423
int Height=614
int TabOrder=10
boolean Enabled=false
boolean BringToTop=true
string DataObject="d_shipping_scrap_skid_detail_list"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean VScrollBar=false
boolean LiveScroll=false
end type

event constructor;SetTransObject(SQLCA)
end event

type cb_1 from u_cb within w_shipping_scrap_detail
int X=581
int Y=877
int Height=90
int TabOrder=20
boolean BringToTop=true
string Text="&Close"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Close(Parent)
end event

type st_1 from statictext within w_shipping_scrap_detail
int X=252
int Y=669
int Width=984
int Height=157
boolean Enabled=false
boolean BringToTop=true
string Text="00000000"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
int TextSize=-28
int Weight=400
string FaceName="C39 Medium 24pt LJ4"
FontCharSet FontCharSet=Ansi!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_shipping_scrap_detail
int X=413
int Y=784
int Width=629
int Height=54
boolean Enabled=false
boolean BringToTop=true
string Text="00000000"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

