$PBExportHeader$w_inv_skid_neworder.srw
$PBExportComments$<Response> return new customer order number for a skid
forward
global type w_inv_skid_neworder from w_popup
end type
type cb_ok from u_cb within w_inv_skid_neworder
end type
type st_1 from statictext within w_inv_skid_neworder
end type
type sle_neworder from singlelineedit within w_inv_skid_neworder
end type
type st_2 from statictext within w_inv_skid_neworder
end type
type cb_cancel from u_cb within w_inv_skid_neworder
end type
type st_3 from statictext within w_inv_skid_neworder
end type
type sle_neworder_item from singlelineedit within w_inv_skid_neworder
end type
end forward

global type w_inv_skid_neworder from w_popup
int X=1140
int Y=477
int Width=1624
int Height=621
WindowType WindowType=response!
boolean TitleBar=true
string Title="Input New Order Number"
long BackColor=12632256
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_ok cb_ok
st_1 st_1
sle_neworder sle_neworder
st_2 st_2
cb_cancel cb_cancel
st_3 st_3
sle_neworder_item sle_neworder_item
end type
global w_inv_skid_neworder w_inv_skid_neworder

type variables
Long il_cust
end variables

event open;call super::open;Long ll_order
ll_order = Message.DoubleParm
st_1.Text = "Current customer Order: " + String(ll_order)

SELECT orig_customer_id INTO :il_cust
FROM customer_order
WHERE order_abc_num = :ll_order
USING SQLCA;

SetFocus(sle_neworder)
end event

on w_inv_skid_neworder.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.st_1=create st_1
this.sle_neworder=create sle_neworder
this.st_2=create st_2
this.cb_cancel=create cb_cancel
this.st_3=create st_3
this.sle_neworder_item=create sle_neworder_item
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.sle_neworder
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.cb_cancel
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.sle_neworder_item
end on

on w_inv_skid_neworder.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.st_1)
destroy(this.sle_neworder)
destroy(this.st_2)
destroy(this.cb_cancel)
destroy(this.st_3)
destroy(this.sle_neworder_item)
end on

type cb_ok from u_cb within w_inv_skid_neworder
int X=271
int Y=381
int Height=85
int TabOrder=10
string Text="Ok"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Long ll_order, ll_cust
int ll_order_item
String neworder_str

ll_order = Long(sle_neworder.Text)
ll_order_item = Integer(sle_neworder_item.Text)
neworder_str = sle_neworder.Text + "+++" + sle_neworder_item.Text

SELECT orig_customer_id INTO :ll_cust
FROM customer_order
WHERE order_abc_num = :ll_order
USING SQLCA;

IF ll_cust < 1 OR IsNULL(ll_cust) THEN
	MessageBox("Warning","Invalid customer order number.")
	RETURN -1
END IF

IF ll_cust <> il_cust THEN
	MessageBox("Warning","New order's customer does not match current one.")
	RETURN -2
END IF

CloseWithReturn(Parent, neworder_str)

end event

type st_1 from statictext within w_inv_skid_neworder
int X=3
int Y=5
int Width=1469
int Height=93
boolean Enabled=false
boolean BringToTop=true
string Text="Current Customer Order:"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_neworder from singlelineedit within w_inv_skid_neworder
int X=771
int Y=115
int Width=750
int Height=96
int TabOrder=30
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
TextCase TextCase=Upper!
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_inv_skid_neworder
int X=3
int Y=115
int Width=713
int Height=93
boolean Enabled=false
boolean BringToTop=true
string Text="New Customer Order:"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_cancel from u_cb within w_inv_skid_neworder
int X=762
int Y=381
int Height=85
int TabOrder=20
string Text="Cancel"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;CloseWithReturn(Parent, 0)
end event

type st_3 from statictext within w_inv_skid_neworder
int X=3
int Y=243
int Width=719
int Height=93
boolean Enabled=false
boolean BringToTop=true
string Text="New Customer Order item:"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_neworder_item from singlelineedit within w_inv_skid_neworder
int X=771
int Y=227
int Width=259
int Height=96
int TabOrder=40
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="1"
TextCase TextCase=Upper!
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

