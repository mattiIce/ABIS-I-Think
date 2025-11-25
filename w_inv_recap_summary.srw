$PBExportHeader$w_inv_recap_summary.srw
$PBExportComments$<popup> inherited from pfemain/w_popup
forward
global type w_inv_recap_summary from w_popup
end type
type cb_close from u_cb within w_inv_recap_summary
end type
type dw_list from u_dw within w_inv_recap_summary
end type
end forward

global type w_inv_recap_summary from w_popup
int X=688
int Y=333
int Width=1697
int Height=1190
boolean TitleBar=true
string Title="Recap sum by production"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_close cb_close
dw_list dw_list
end type
global w_inv_recap_summary w_inv_recap_summary

on w_inv_recap_summary.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.dw_list=create dw_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.dw_list
end on

on w_inv_recap_summary.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.dw_list)
end on

event open;call super::open;Long ll_row, ll_i, ll_k
Long ll_skid, ll_tare, ll_net, ll_gross, ll_theo, ll_job, ll_taret, ll_nett, ll_theot
Long ll_srow, ll_j
Int li_done
DataWindow ldw_data

ldw_data = message.PowerObjectParm
ll_row = ldw_data.RowCount()
IF ll_row <= 0 THEN RETURN

FOR ll_i = 1 TO ll_row
	li_done = 0
	ll_job = ldw_data.GetItemNumber(ll_i, "sheet_skid_ab_job_num", primary!, FALSE)
	ll_srow = dw_list.rowCount()
	IF ll_srow > 0 THEN
		FOR ll_j = 1 TO ll_srow
			IF dw_list.GetItemNumber(ll_j, "job_num", Primary!, FALSE) = ll_job THEN li_done = 1		
		NEXT		
	END IF
	IF li_done = 0 THEN
		ll_skid = 0
		ll_tare = 0
		ll_net = 0
		ll_theo = 0
		ll_gross = 0

		FOR ll_k = 1 TO ll_row
			IF ldw_data.GetItemNumber(ll_k, "sheet_skid_ab_job_num", primary!, FALSE) = ll_job THEN
				ll_skid = ll_skid + 1
				ll_taret = ldw_data.GetItemNumber(ll_k, "sheet_skid_sheet_tare_wt", Primary!, FALSE)
				If IsNULL(ll_taret) THEN ll_taret = 0
				ll_nett = ldw_data.GetItemNumber(ll_k, "sheet_skid_sheet_net_wt", Primary!, FALSE)
				IF isNULL(ll_nett) THEN ll_nett = 0
				ll_theot = ldw_data.GetItemNumber(ll_k, "sheet_skid_sheet_theoretical_wt", Primary!, FALSE)
				IF IsNULL(ll_theot) THEN ll_theot = 0
				
				ll_tare = ll_tare + ll_taret
				ll_net = ll_net + ll_nett
				ll_theo = ll_theo + ll_theot
				
			END IF
		NEXT	
		ll_gross = ll_net + ll_tare
		
		ll_srow = dw_list.InsertRow(0)
		dw_list.SetItem(ll_srow, "job_num", ll_job)
		dw_list.SetItem(ll_srow, "skid_num", ll_skid)
		dw_list.SetItem(ll_srow, "tare", ll_tare)
		dw_list.SetItem(ll_srow, "net", ll_net)
		dw_list.SetItem(ll_srow, "gross", ll_gross)
		dw_list.SetItem(ll_srow, "theo", ll_theo)
		dw_list.AcceptText()
	END IF
NEXT

dw_list.ResetUpdate()

end event

type cb_close from u_cb within w_inv_recap_summary
int X=603
int Y=998
int Height=80
int TabOrder=10
boolean BringToTop=true
string Text="&Close"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Close(Parent)
end event

type dw_list from u_dw within w_inv_recap_summary
int X=26
int Y=22
int Width=1631
int Height=954
int TabOrder=10
boolean BringToTop=true
string DataObject="d_inv_recap_summary"
end type

event itemchanged;call super::itemchanged;of_SetBase(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
of_SetRowSelect(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)
end event

