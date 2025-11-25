$PBExportHeader$w_asn_reminder.srw
forward
global type w_asn_reminder from window
end type
type p_1 from picture within w_asn_reminder
end type
type p_2 from picture within w_asn_reminder
end type
type sle_packing_list from singlelineedit within w_asn_reminder
end type
type cb_close from commandbutton within w_asn_reminder
end type
type sle_2 from singlelineedit within w_asn_reminder
end type
type sle_1 from singlelineedit within w_asn_reminder
end type
type st_1 from statictext within w_asn_reminder
end type
type r_1 from rectangle within w_asn_reminder
end type
end forward

global type w_asn_reminder from window
integer width = 4765
integer height = 1965
boolean titlebar = true
string title = "ASN Reminder"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 255
string icon = "AppIcon!"
boolean toolbarvisible = false
boolean center = true
p_1 p_1
p_2 p_2
sle_packing_list sle_packing_list
cb_close cb_close
sle_2 sle_2
sle_1 sle_1
st_1 st_1
r_1 r_1
end type
global w_asn_reminder w_asn_reminder

type variables

end variables

on w_asn_reminder.create
this.p_1=create p_1
this.p_2=create p_2
this.sle_packing_list=create sle_packing_list
this.cb_close=create cb_close
this.sle_2=create sle_2
this.sle_1=create sle_1
this.st_1=create st_1
this.r_1=create r_1
this.Control[]={this.p_1,&
this.p_2,&
this.sle_packing_list,&
this.cb_close,&
this.sle_2,&
this.sle_1,&
this.st_1,&
this.r_1}
end on

on w_asn_reminder.destroy
destroy(this.p_1)
destroy(this.p_2)
destroy(this.sle_packing_list)
destroy(this.cb_close)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.r_1)
end on

event open;Long	ll_packing_list

ll_packing_list = Message.doubleparm

sle_packing_list.Text = "  " + String(ll_packing_list)
end event

type p_1 from picture within w_asn_reminder
integer x = 3628
integer y = 1238
integer width = 1093
integer height = 582
string picturename = "I:\abis\USA_flag.gif"
boolean focusrectangle = false
end type

type p_2 from picture within w_asn_reminder
integer x = 37
integer y = 1238
integer width = 1093
integer height = 582
string picturename = "I:\abis\USA_flag.gif"
boolean focusrectangle = false
end type

type sle_packing_list from singlelineedit within w_asn_reminder
integer x = 1419
integer y = 1274
integer width = 1818
integer height = 307
integer taborder = 30
integer textsize = -60
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 255
boolean border = false
borderstyle borderstyle = stylelowered!
end type

type cb_close from commandbutton within w_asn_reminder
integer x = 2037
integer y = 1715
integer width = 355
integer height = 134
integer taborder = 30
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
end type

event clicked;Close(Parent)
end event

type sle_2 from singlelineedit within w_asn_reminder
integer x = 208
integer y = 912
integer width = 4436
integer height = 355
integer taborder = 20
integer textsize = -60
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 255
string text = "       for this shipment"
boolean border = false
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_asn_reminder
integer x = 205
integer y = 560
integer width = 4436
integer height = 355
integer taborder = 10
integer textsize = -60
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 255
string text = "           to send ASN"
boolean border = false
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_asn_reminder
integer x = 263
integer y = 118
integer width = 4290
integer height = 390
integer textsize = -72
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "DO NOT FORGET"
alignment alignment = center!
long bordercolor = 255
boolean focusrectangle = false
end type

type r_1 from rectangle within w_asn_reminder
integer linethickness = 3
long fillcolor = 65535
integer x = 176
integer y = 58
integer width = 4436
integer height = 506
end type

