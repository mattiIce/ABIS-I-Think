$PBExportHeader$w_quality_control.srw
$PBExportComments$<Sheet>Quality Control inherited from pfemain\w_sheet
forward
global type w_quality_control from w_sheet
end type
type st_qc_doc from u_st within w_quality_control
end type
type p_1 from picture within w_quality_control
end type
type st_1 from statictext within w_quality_control
end type
type cb_close from u_cb within w_quality_control
end type
end forward

global type w_quality_control from w_sheet
integer x = 841
integer y = 374
integer width = 2044
integer height = 1226
string title = "Quality Control"
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
event ue_read_only ( )
st_qc_doc st_qc_doc
p_1 p_1
st_1 st_1
cb_close cb_close
end type
global w_quality_control w_quality_control

event type string ue_whoami();RETURN "w_quality_control"
end event

on w_quality_control.create
int iCurrent
call super::create
this.st_qc_doc=create st_qc_doc
this.p_1=create p_1
this.st_1=create st_1
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_qc_doc
this.Control[iCurrent+2]=this.p_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cb_close
end on

on w_quality_control.destroy
call super::destroy
destroy(this.st_qc_doc)
destroy(this.p_1)
destroy(this.st_1)
destroy(this.cb_close)
end on

event open;call super::open;s_security_data  lds_sec

IF f_security_door("Quality Control") < 0 THEN
	OpenWithParm(w_security_check, "Quality Control")
	lds_sec = Message.PowerObjectParm
	IF lds_sec.security_level < 0 THEN
		Close(this)
		RETURN 0
	END IF
END IF


end event

event activate;call super::activate;gnv_app.of_getFrame().event pfc_cascade()
IF f_security_door("Quality Control") = 1 THEN RETURN 1
This.Event ue_read_only()
end event

event close;call super::close;f_display_app()
end event

type st_qc_doc from u_st within w_quality_control
integer x = 267
integer y = 592
integer width = 1379
integer height = 102
integer textsize = -18
string facename = "Arial"
boolean underline = true
long textcolor = 16711680
boolean enabled = true
string text = "Quality Control Documents"
boolean focusrectangle = true
end type

event clicked;call super::clicked;String ls_command
ls_command = "Explorer " + ProfileString(gs_ini_file, "QC","file_path","c:\temp")

Run(ls_command)
end event

type p_1 from picture within w_quality_control
integer x = 282
integer y = 83
integer width = 1510
integer height = 320
boolean originalsize = true
string picturename = "hevequip2.gif"
boolean focusrectangle = false
end type

type st_1 from statictext within w_quality_control
integer x = 362
integer y = 422
integer width = 1353
integer height = 86
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "This application will be available soon. Thanks."
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_close from u_cb within w_quality_control
integer x = 1627
integer y = 998
integer width = 315
integer height = 77
integer taborder = 60
boolean bringtotop = true
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

