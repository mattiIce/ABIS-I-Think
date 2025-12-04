$PBExportHeader$w_select_new_scrap_skid.srw
$PBExportComments$<Responds>List all new scrap skid for use inherited from pfemain/w_responds
forward
global type w_select_new_scrap_skid from w_response
end type
type dw_new from u_dw within w_select_new_scrap_skid
end type
type cb_select from u_cb within w_select_new_scrap_skid
end type
type cb_close from u_cb within w_select_new_scrap_skid
end type
end forward

global type w_select_new_scrap_skid from w_response
int X=1189
int Y=560
int Width=1298
int Height=1142
boolean TitleBar=true
string Title="New scrap skids"
dw_new dw_new
cb_select cb_select
cb_close cb_close
end type
global w_select_new_scrap_skid w_select_new_scrap_skid

on w_select_new_scrap_skid.create
int iCurrent
call super::create
this.dw_new=create dw_new
this.cb_select=create cb_select
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_new
this.Control[iCurrent+2]=this.cb_select
this.Control[iCurrent+3]=this.cb_close
end on

on w_select_new_scrap_skid.destroy
call super::destroy
destroy(this.dw_new)
destroy(this.cb_select)
destroy(this.cb_close)
end on

type dw_new from u_dw within w_select_new_scrap_skid
int X=33
int Y=13
int Width=1214
int Height=896
int TabOrder=10
string DataObject="d_new_scrap_skid_list"
end type

event constructor;call super::constructor;of_SetBase(TRUE)
of_SettransObject(SQLCA)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetRowFocusIndicator(Hand!)

retrieve()

end event

event rbuttondown;//override
Return 1
end event

event rbuttonup;//override
Return 1
end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

this.ScrollToRow(li_Row)

Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

event doubleclicked;call super::doubleclicked;IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

// Notify the RowSelect service that the row has been clicked.
IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF

// Sort services.
IF IsValid (inv_Sort) THEN 
	// Notify the Sort service, since it may have have a request
	// to sort on colum header.
	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
END IF 

SelectRow(row, TRUE)
cb_select.TriggerEvent (clicked!)

end event

type cb_select from u_cb within w_select_new_scrap_skid
int X=183
int Y=925
int TabOrder=20
string Tag="select and close"
string Text="&Select"
end type

event clicked;call super::clicked;Long ll_row, ll_skid
ll_row = dw_new.GetRow()
IF ll_row > 0 THEN
	ll_skid = dw_new.GetItemNumber(ll_row, "scrap_skid_num" )
	CloseWithReturn(Parent, ll_skid)
	Return 1
END IF
MessageBox("Warning","Select a new skid first!")
Return 0


end event

type cb_close from u_cb within w_select_new_scrap_skid
int X=709
int Y=925
int TabOrder=2
string Text="&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

