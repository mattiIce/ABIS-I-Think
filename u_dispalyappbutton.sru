$PBExportHeader$u_dispalyappbutton.sru
$PBExportComments$Button used on display app window
forward
global type u_dispalyappbutton from userobject
end type
type p_1 from picture within u_dispalyappbutton
end type
type cb_1 from commandbutton within u_dispalyappbutton
end type
end forward

global type u_dispalyappbutton from userobject
integer width = 1364
integer height = 262
long backcolor = 134217856
string text = "none"
borderstyle borderstyle = styleraised!
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event clicked ( )
event lostfocus ( )
p_1 p_1
cb_1 cb_1
end type
global u_dispalyappbutton u_dispalyappbutton

type variables

end variables

forward prototypes
public subroutine set_select ()
public subroutine set_no_selected ()
public function boolean is_selected ()
end prototypes

event clicked();this.BackColor=RGB(255,0,0)
cb_1.Italic = TRUE
end event

event lostfocus();this.BackColor = RGB(0,0,255)
cb_1.Italic = FALSE
end event

public subroutine set_select ();
end subroutine

public subroutine set_no_selected ();
end subroutine

public function boolean is_selected ();RETURN TRUE
end function

on u_dispalyappbutton.create
this.p_1=create p_1
this.cb_1=create cb_1
this.Control[]={this.p_1,&
this.cb_1}
end on

on u_dispalyappbutton.destroy
destroy(this.p_1)
destroy(this.cb_1)
end on

type p_1 from picture within u_dispalyappbutton
integer x = 7
integer y = 6
integer width = 249
integer height = 243
boolean focusrectangle = false
end type

event clicked;parent.postevent( "clicked")
end event

type cb_1 from commandbutton within u_dispalyappbutton
integer x = 252
integer y = 10
integer width = 1108
integer height = 243
integer taborder = 10
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
end type

event clicked;parent.postevent("clicked")


end event

