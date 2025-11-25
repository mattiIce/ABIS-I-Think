$PBExportHeader$w_coil_detail_display.srw
$PBExportComments$<Child> display coil detail info but can not be update
forward
global type w_coil_detail_display from w_child
end type
type dw_coil_detail from u_dw within w_coil_detail_display
end type
type cb_coil_ok from u_cb within w_coil_detail_display
end type
type cb_property_report from commandbutton within w_coil_detail_display
end type
type cb_lube_weight from commandbutton within w_coil_detail_display
end type
end forward

global type w_coil_detail_display from w_child
string tag = "detail information of an coil"
integer x = 640
integer y = 394
integer width = 2458
integer height = 826
string title = "Coil Information"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
event ue_property_report ( )
event ue_lube_weight ( )
dw_coil_detail dw_coil_detail
cb_coil_ok cb_coil_ok
cb_property_report cb_property_report
cb_lube_weight cb_lube_weight
end type
global w_coil_detail_display w_coil_detail_display

type variables
Long il_coil_abc_num;
end variables

event ue_property_report;OpenWithParm(w_property_report,il_coil_abc_num)
end event

event ue_lube_weight;OpenWithParm(w_lube_weight,il_coil_abc_num)
end event

on w_coil_detail_display.create
int iCurrent
call super::create
this.dw_coil_detail=create dw_coil_detail
this.cb_coil_ok=create cb_coil_ok
this.cb_property_report=create cb_property_report
this.cb_lube_weight=create cb_lube_weight
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_coil_detail
this.Control[iCurrent+2]=this.cb_coil_ok
this.Control[iCurrent+3]=this.cb_property_report
this.Control[iCurrent+4]=this.cb_lube_weight
end on

on w_coil_detail_display.destroy
call super::destroy
destroy(this.dw_coil_detail)
destroy(this.cb_coil_ok)
destroy(this.cb_property_report)
destroy(this.cb_lube_weight)
end on

event open;call super::open;//d_order_detail
il_coil_abc_num = Message.DoubleParm

dw_coil_detail.SetTransObject(sqlca)
dw_coil_detail.Retrieve(message.doubleparm)
this.title = "Coil:  " + String(message.doubleparm)


end event

type dw_coil_detail from u_dw within w_coil_detail_display
string tag = "Detail information of an coil"
integer x = 40
integer y = 13
integer width = 2348
integer height = 611
integer taborder = 20
string dataobject = "d_coil_detail_display"
boolean vscrollbar = false
end type

event rbuttondown;//disbaled
Return 0
end event

event rbuttonup;//disbaled
Return 0
end event

type cb_coil_ok from u_cb within w_coil_detail_display
event clicked pbm_bnclicked
string tag = "Close"
integer x = 1679
integer y = 634
integer width = 351
integer height = 93
integer taborder = 10
string facename = "Arial"
string text = "&Close"
end type

event clicked;Close(parent)
end event

type cb_property_report from commandbutton within w_coil_detail_display
integer x = 322
integer y = 634
integer width = 435
integer height = 86
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Property &Report"
end type

event clicked;Parent.Event ue_property_report()

end event

type cb_lube_weight from commandbutton within w_coil_detail_display
integer x = 995
integer y = 634
integer width = 435
integer height = 86
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Lube Weight"
end type

event clicked;parent.event ue_lube_weight()
end event

