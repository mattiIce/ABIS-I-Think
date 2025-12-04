$PBExportHeader$w_tesla_shipping_message.srw
forward
global type w_tesla_shipping_message from window
end type
type p_2 from picture within w_tesla_shipping_message
end type
type st_bol from statictext within w_tesla_shipping_message
end type
type st_customer_name from statictext within w_tesla_shipping_message
end type
type st_3 from statictext within w_tesla_shipping_message
end type
type st_2 from statictext within w_tesla_shipping_message
end type
type st_1 from statictext within w_tesla_shipping_message
end type
type cb_close from commandbutton within w_tesla_shipping_message
end type
end forward

global type w_tesla_shipping_message from window
integer width = 2384
integer height = 1136
boolean titlebar = true
string title = "Don~'t forget"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 16777215
string icon = "AppIcon!"
boolean center = true
p_2 p_2
st_bol st_bol
st_customer_name st_customer_name
st_3 st_3
st_2 st_2
st_1 st_1
cb_close cb_close
end type
global w_tesla_shipping_message w_tesla_shipping_message

on w_tesla_shipping_message.create
this.p_2=create p_2
this.st_bol=create st_bol
this.st_customer_name=create st_customer_name
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_close=create cb_close
this.Control[]={this.p_2,&
this.st_bol,&
this.st_customer_name,&
this.st_3,&
this.st_2,&
this.st_1,&
this.cb_close}
end on

on w_tesla_shipping_message.destroy
destroy(this.p_2)
destroy(this.st_bol)
destroy(this.st_customer_name)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_close)
end on

event open;str_all_data_types	lstr_all_data_types
String					ls_customer_name
Long						ll_bol, ll_packing_list

lstr_all_data_types = Message.PowerObjectParm

ls_customer_name = lstr_all_data_types.string_var[1]
ll_bol = lstr_all_data_types.long_var[1]
ll_packing_list = lstr_all_data_types.long_var[2]

st_customer_name.Text = "Customer: " + Trim(ls_customer_name)
st_bol.Text = "BOL: " + String(ll_bol)
//st_packing_list.Text = "Packing List: " + String(ll_packing_list)


end event

type p_2 from picture within w_tesla_shipping_message
integer width = 549
integer height = 192
boolean originalsize = true
string picturename = "I:\abis\Suggestion.gif"
boolean focusrectangle = false
end type

type st_bol from statictext within w_tesla_shipping_message
integer x = 77
integer y = 346
integer width = 2264
integer height = 128
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217857
long backcolor = 16777215
alignment alignment = center!
long bordercolor = 16777215
end type

type st_customer_name from statictext within w_tesla_shipping_message
integer x = 77
integer y = 214
integer width = 2264
integer height = 128
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217857
long backcolor = 16777215
alignment alignment = center!
long bordercolor = 15780518
end type

type st_3 from statictext within w_tesla_shipping_message
integer x = 91
integer y = 675
integer width = 2220
integer height = 128
integer textsize = -22
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217857
long backcolor = 16777215
string text = "Customer~'s Portal"
alignment alignment = center!
long bordercolor = 16777215
boolean focusrectangle = false
end type

type st_2 from statictext within w_tesla_shipping_message
integer x = 91
integer y = 550
integer width = 2220
integer height = 128
integer textsize = -22
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217857
long backcolor = 16777215
string text = "Please complete shipment on "
alignment alignment = center!
long bordercolor = 16777215
boolean focusrectangle = false
end type

type st_1 from statictext within w_tesla_shipping_message
integer x = 611
integer y = 19
integer width = 1141
integer height = 138
integer textsize = -22
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217857
long backcolor = 16777215
string text = "DON~'T FORGET"
alignment alignment = center!
long bordercolor = 16777215
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_tesla_shipping_message
integer x = 1075
integer y = 896
integer width = 322
integer height = 90
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
end type

event clicked;Close(Parent)
end event

