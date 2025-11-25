$PBExportHeader$w_shipment_wh_select.srw
$PBExportComments$<popup> select whl for an shipment inherited from pfemain/w_popup
forward
global type w_shipment_wh_select from w_popup
end type
type dw_list from u_dw within w_shipment_wh_select
end type
type cb_select from u_cb within w_shipment_wh_select
end type
type cb_close from u_cb within w_shipment_wh_select
end type
type dw_detail from u_dw within w_shipment_wh_select
end type
type st_1 from statictext within w_shipment_wh_select
end type
end forward

global type w_shipment_wh_select from w_popup
int X=622
int Y=186
int Width=2670
int Height=1622
boolean TitleBar=true
string Title="Select warehouse items for this shipment"
long BackColor=12632256
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
dw_list dw_list
cb_select cb_select
cb_close cb_close
dw_detail dw_detail
st_1 st_1
end type
global w_shipment_wh_select w_shipment_wh_select

on w_shipment_wh_select.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.cb_select=create cb_select
this.cb_close=create cb_close
this.dw_detail=create dw_detail
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.cb_select
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.dw_detail
this.Control[iCurrent+5]=this.st_1
end on

on w_shipment_wh_select.destroy
call super::destroy
destroy(this.dw_list)
destroy(this.cb_select)
destroy(this.cb_close)
destroy(this.dw_detail)
destroy(this.st_1)
end on

event open;call super::open;long ll_cust
ll_cust = Message.DoubleParm
dw_list.Retrieve(ll_cust)

end event

type dw_list from u_dw within w_shipment_wh_select
int X=11
int Y=6
int Width=2619
int Height=1040
int TabOrder=10
boolean BringToTop=true
string DataObject="d_shipment_avi_wh_list"
boolean HScrollBar=true
end type

event constructor;of_SetBase(TRUE)
of_SettransObject(SQLCA)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 2 )
SetTransObject(SQLCA)

end event

event rbuttondown;//Override
RETURN 0
end event

event rbuttonup;//Override
RETURN 1
end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
RETURN 1
end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long ll_Row, ll_skid

ll_Row = this.GetRow()
IF ll_row < 1 THEN RETURN
SelectRow(0, False)
SelectRow(ll_Row, True)

ll_skid = this.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num")
dw_detail.Retrieve(ll_skid)

RETURN

end event

event doubleclicked;cb_select.Event Clicked()
end event

type cb_select from u_cb within w_shipment_wh_select
int X=666
int Y=1405
int TabOrder=40
boolean BringToTop=true
string Text="&Select"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Window lw_parent
Long ll_skid, ll_row, ll_rc
Long ll_selected[], ll_selectedcount, ll_r, ll_i

ll_selectedcount = dw_list.inv_rowselect.of_selectedCount(ll_selected)

ll_r = UpperBound(ll_selected)
IF ll_r > 0 THEN
	FOR ll_i = ll_r TO 1 STEP -1
		ll_row = ll_selected[ll_i]
		IF ll_row < 1 THEN Return -1
		ll_skid = dw_list.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num")
		lw_parent = gnv_app.of_GetFrame().GetActiveSheet()
		IF IsValid(lw_parent) THEN
			ll_rc = lw_Parent.Dynamic Event ue_check_skid(ll_skid)
			CHOOSE CASE ll_rc
				CASE 0
					lw_Parent.Dynamic Event ue_add_wh(ll_skid)
					dw_list.DeleteRow(ll_row)
					dw_list.ResetUpdate()
				CASE -1
					MessageBox("Error","This skid has been assigned to this shipment already.", StopSign!) 
				CASE ELSE
					MessageBox("Error","This skid has been assigned to shipment# " + String(ll_rc) + " already.", StopSign!)
			END CHOOSE
		END IF
	NEXT
END IF

Return 0

end event

type cb_close from u_cb within w_shipment_wh_select
int X=1536
int Y=1405
int TabOrder=30
boolean BringToTop=true
string Text="&Close"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Close(Parent)
end event

type dw_detail from u_dw within w_shipment_wh_select
int X=453
int Y=1050
int Width=1664
int Height=320
int TabOrder=20
boolean Enabled=false
boolean BringToTop=true
string DataObject="d_shipment_avi_skid_detail"
BorderStyle BorderStyle=StyleBox!
boolean VScrollBar=false
boolean LiveScroll=false
end type

event constructor;SetTransObject(SQLCA)
end event

type st_1 from statictext within w_shipment_wh_select
int X=161
int Y=1050
int Width=256
int Height=77
boolean Enabled=false
boolean BringToTop=true
string Text="Skid Detail:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

