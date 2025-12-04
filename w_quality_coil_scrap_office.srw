$PBExportHeader$w_quality_coil_scrap_office.srw
$PBExportComments$<Sheet>Quality Control coil scrap info used in office inherited from pfemain\w_sheet
forward
global type w_quality_coil_scrap_office from w_sheet
end type
type cb_go from u_cb within w_quality_coil_scrap_office
end type
type cb_export from u_cb within w_quality_coil_scrap_office
end type
type cb_print from u_cb within w_quality_coil_scrap_office
end type
type sle_coil from u_sle within w_quality_coil_scrap_office
end type
type em_job from u_em within w_quality_coil_scrap_office
end type
type st_4 from statictext within w_quality_coil_scrap_office
end type
type dw_scrap from u_dw within w_quality_coil_scrap_office
end type
type cb_remove from u_cb within w_quality_coil_scrap_office
end type
type cb_save from u_cb within w_quality_coil_scrap_office
end type
type cb_add from u_cb within w_quality_coil_scrap_office
end type
type dw_coil_info from u_dw within w_quality_coil_scrap_office
end type
type cb_retrieve from u_cb within w_quality_coil_scrap_office
end type
type st_3 from statictext within w_quality_coil_scrap_office
end type
type st_2 from statictext within w_quality_coil_scrap_office
end type
type st_1 from statictext within w_quality_coil_scrap_office
end type
type cb_close from u_cb within w_quality_coil_scrap_office
end type
type gb_info from u_gb within w_quality_coil_scrap_office
end type
type gb_1 from u_gb within w_quality_coil_scrap_office
end type
type gb_3 from u_gb within w_quality_coil_scrap_office
end type
end forward

global type w_quality_coil_scrap_office from w_sheet
integer x = 841
integer y = 374
integer width = 3661
integer height = 1632
string title = "Quality Control Coil Scrap Application"
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
event ue_read_only ( )
cb_go cb_go
cb_export cb_export
cb_print cb_print
sle_coil sle_coil
em_job em_job
st_4 st_4
dw_scrap dw_scrap
cb_remove cb_remove
cb_save cb_save
cb_add cb_add
dw_coil_info dw_coil_info
cb_retrieve cb_retrieve
st_3 st_3
st_2 st_2
st_1 st_1
cb_close cb_close
gb_info gb_info
gb_1 gb_1
gb_3 gb_3
end type
global w_quality_coil_scrap_office w_quality_coil_scrap_office

type variables
Long il_coil
end variables

event type string ue_whoami();RETURN "w_quality_coil_scrap_office"
end event

on w_quality_coil_scrap_office.create
int iCurrent
call super::create
this.cb_go=create cb_go
this.cb_export=create cb_export
this.cb_print=create cb_print
this.sle_coil=create sle_coil
this.em_job=create em_job
this.st_4=create st_4
this.dw_scrap=create dw_scrap
this.cb_remove=create cb_remove
this.cb_save=create cb_save
this.cb_add=create cb_add
this.dw_coil_info=create dw_coil_info
this.cb_retrieve=create cb_retrieve
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_close=create cb_close
this.gb_info=create gb_info
this.gb_1=create gb_1
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_go
this.Control[iCurrent+2]=this.cb_export
this.Control[iCurrent+3]=this.cb_print
this.Control[iCurrent+4]=this.sle_coil
this.Control[iCurrent+5]=this.em_job
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.dw_scrap
this.Control[iCurrent+8]=this.cb_remove
this.Control[iCurrent+9]=this.cb_save
this.Control[iCurrent+10]=this.cb_add
this.Control[iCurrent+11]=this.dw_coil_info
this.Control[iCurrent+12]=this.cb_retrieve
this.Control[iCurrent+13]=this.st_3
this.Control[iCurrent+14]=this.st_2
this.Control[iCurrent+15]=this.st_1
this.Control[iCurrent+16]=this.cb_close
this.Control[iCurrent+17]=this.gb_info
this.Control[iCurrent+18]=this.gb_1
this.Control[iCurrent+19]=this.gb_3
end on

on w_quality_coil_scrap_office.destroy
call super::destroy
destroy(this.cb_go)
destroy(this.cb_export)
destroy(this.cb_print)
destroy(this.sle_coil)
destroy(this.em_job)
destroy(this.st_4)
destroy(this.dw_scrap)
destroy(this.cb_remove)
destroy(this.cb_save)
destroy(this.cb_add)
destroy(this.dw_coil_info)
destroy(this.cb_retrieve)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_close)
destroy(this.gb_info)
destroy(this.gb_1)
destroy(this.gb_3)
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

type cb_go from u_cb within w_quality_coil_scrap_office
integer x = 3507
integer y = 1283
integer width = 110
integer height = 86
integer taborder = 90
boolean bringtotop = true
string facename = "Arial"
string text = "&Go"
end type

type cb_export from u_cb within w_quality_coil_scrap_office
string tag = "export data into Excel format"
integer x = 2304
integer y = 1286
integer width = 315
integer height = 86
integer taborder = 70
boolean bringtotop = true
string facename = "Arial"
string text = "&Export"
end type

event clicked;call super::clicked;SetPointer(HourGlass!)
String ls_file, ls_today, ls_now
Date ld_today
Time ld_now

ld_today = Today()
ld_now = Now()
ls_today = string(ld_today,"yymmdd")
ls_now = string(ld_now,"hhmm")

ls_file = ProfileString(gs_ini_file, "EMAIL","email_out","c:\temp")+'\abis_' + ls_today + ls_now + ".xls"
if dw_scrap.SaveAs(ls_file,Excel8!, TRUE) =-1 then
   MessageBox("Data SaveAs", "Error")
	return -1
else
	messageBox("Success", "Data have been successfully saved as " + ls_file)
end if

RETURN 1
end event

type cb_print from u_cb within w_quality_coil_scrap_office
integer x = 1126
integer y = 1421
integer width = 453
integer height = 102
integer taborder = 100
boolean bringtotop = true
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;s_job_and_coil lstr_s
Long ll_job, ll_row, ll_i
DataStore lds_s

ll_row = dw_scrap.RowCount()
IF ll_row = 0 THEN
	MessageBox("Warning", "There is scrap information associates with this coil.")
	RETURN 0
END IF

lds_s = CREATE datastore  
lds_s.DataObject = "d_quality_coil_eval_coil_job"  
lds_s.SetTransObject (SQLCA)  
lds_s.Retrieve(il_coil)

ll_row = lds_s.RowCount()
IF ll_row = 0 THEN
	MessageBox("Warning", "There is not job associates with this coil.")
	DESTROY lds_s
	RETURN 0
END IF

IF ll_row = 1 THEN	//only one
	lstr_s.job_num = lds_s.GetItemNumber(1, "ab_job_num")
	lstr_s.coil_num = il_coil
	DESTROY lds_s
	//OpenWithParm(w_report_coil_eval_office, lstr_s)
	RETURN 1
END IF

IF ll_row > 1 THEN
	ll_row = dw_scrap.GetRow()
	IF ll_row > 0 THEN
		lstr_s.job_num = dw_scrap.GetItemNumber(ll_row, "ab_job_num")
		lstr_s.coil_num = il_coil
		IF MessageBox("Question", "This coil has been assigned to more than one job. The current job you selected on the screen is " + String(lstr_s.job_num) + ". Do you want to print coil evaluation based on this job?", Question!, YesNo!, 1) = 1 THEN
			//OpenWithParm(w_report_coil_eval_office, lstr_s)
			RETURN 1
		END IF
	END IF
END IF
			
RETURN 1
end event

type sle_coil from u_sle within w_quality_coil_scrap_office
event ue_enter pbm_keydown
integer x = 333
integer y = 115
integer width = 666
integer height = 96
integer taborder = 10
integer textsize = -10
integer weight = 700
string facename = "Arial"
end type

event ue_enter;if   key   =   Keyenter!   then  
        RETURN parent.cb_retrieve.Event clicked()
end   if  

RETURN 0
end event

type em_job from u_em within w_quality_coil_scrap_office
event ue_enter pbm_keydown
integer x = 3200
integer y = 1290
integer width = 296
integer height = 74
integer taborder = 80
integer weight = 700
string facename = "Arial"
alignment alignment = center!
string mask = "########"
end type

event ue_enter;if   key   =   Keyenter!   then  
        RETURN parent.cb_go.Event clicked()
end   if  

RETURN 0
end event

event modified;call super::modified;RETURN parent.cb_go.event  clicked()
end event

type st_4 from statictext within w_quality_coil_scrap_office
integer x = 2640
integer y = 1302
integer width = 552
integer height = 67
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80263581
string text = "Only show scrap from job"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_scrap from u_dw within w_quality_coil_scrap_office
event type long ue_save ( )
integer x = 1057
integer y = 64
integer width = 2556
integer height = 1206
integer taborder = 30
string dataobject = "d_quality_coil_eval_input"
end type

event type long ue_save();RETURN This.Event pfc_update(TRUE, TRUE)
 
end event

event constructor;call super::constructor;of_SetBase(TRUE)
of_SettransObject(SQLCA)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
of_SetFilter(TRUE)




end event

event rbuttondown;return 0
end event

event rbuttonup;return 0
end event

event pfc_populatedddw;call super::pfc_populatedddw;IF adwc_obj.SetTransObject(SQLCA) = -1 THEN  
	Return -1  
ELSE 
	IF il_coil <= 0 THEN RETURN -2
	Return adwc_obj.Retrieve(il_coil)  
END IF
end event

event pfc_retrieve;call super::pfc_retrieve;DataWindowChild ldddw_cni
IF this.GetChild("ab_job_num", ldddw_cni) = -1 THEN 
	Return -1
ELSE
	this.Event pfc_PopulateDDDW("ab_job_num", ldddw_cni)
END IF

IF this.GetChild("scrap_item_type", ldddw_cni) = -1 THEN 
	Return -1
ELSE
	this.Event pfc_PopulateDDDW("scrap_item_type", ldddw_cni)
END IF

Return this.Retrieve(il_coil)
end event

event pfc_addrow;call super::pfc_addrow;Long ll_row

ll_row = this.GetRow()
IF ll_row < 1 THEN RETURN 0
this.SetItem(ll_row, "coil_abc_num", il_coil)
this.SetItem(ll_row, "data_source", gnv_app.of_GetUserId())

RETURN 1


end event

type cb_remove from u_cb within w_quality_coil_scrap_office
integer x = 1499
integer y = 1286
integer width = 315
integer height = 86
integer taborder = 50
boolean bringtotop = true
string facename = "Arial"
string text = "&Remove"
end type

event clicked;call super::clicked;RETURN dw_scrap.Event pfc_deleterow()
end event

type cb_save from u_cb within w_quality_coil_scrap_office
integer x = 1902
integer y = 1286
integer width = 315
integer height = 86
integer taborder = 60
boolean bringtotop = true
string facename = "Arial"
string text = "&Save"
end type

event clicked;call super::clicked;RETURN dw_scrap.Event ue_save()
end event

type cb_add from u_cb within w_quality_coil_scrap_office
integer x = 1097
integer y = 1286
integer width = 315
integer height = 86
integer taborder = 40
boolean bringtotop = true
string facename = "Arial"
string text = "&Add"
end type

event clicked;call super::clicked;IF il_coil > 0 THEN RETURN dw_scrap.Event pfc_addrow()

RETURN 0
end event

type dw_coil_info from u_dw within w_quality_coil_scrap_office
integer x = 11
integer y = 477
integer width = 1006
integer height = 899
integer taborder = 0
boolean enabled = false
string dataobject = "d_quality_coil_eval_coil_detail"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;of_SetBase(TRUE)
SetTransObject(SQLCA)
end event

event pfc_populatedddw;call super::pfc_populatedddw;IF adwc_obj.SetTransObject(SQLCA) = -1 THEN  
	Return -1  
ELSE   
	Return adwc_obj.Retrieve()  
END IF
end event

event pfc_retrievedddw;call super::pfc_retrievedddw;DataWindowChild dddw_cni

IF this.GetChild(as_column, dddw_cni) = -1 THEN
	Return -1
ELSE
	dddw_cni.SetTransObject(SQLCA)
	
	Return dddw_cni.Retrieve() 
END IF
end event

event rbuttondown;return 0
end event

event rbuttonup;return 0
end event

type cb_retrieve from u_cb within w_quality_coil_scrap_office
integer x = 347
integer y = 285
integer width = 351
integer height = 96
integer taborder = 20
string facename = "Arial"
string text = "Retrieve"
end type

event clicked;call super::clicked;Int li_rc
String ls_c

dw_coil_info.Reset()
dw_scrap.Reset()
il_coil = 0

il_coil = Long(sle_coil.Text)
IF IsNULL(il_coil) THEN
	il_coil = 0
	MessageBox("Warning", "Invalid coil ID")
	RETURN -1
END IF
IF il_coil > 0 THEN
	SELECT Count(*) INTO :li_rc
	FROM coil
	where coil_abc_num = :il_coil
	USING SQLCA;
	IF li_rc = 1 THEN
		dw_coil_info.Retrieve(il_coil)
		dw_scrap.Event pfc_Retrieve()
		RETURN 1
	END IF
END IF
ls_c = Trim(sle_coil.Text)
SELECT coil_abc_num INTO :il_coil
FROM coil
WHERE coil_org_num = :ls_c
USING SQLCA;
IF il_coil > 0 THEN
	dw_coil_info.Retrieve(il_coil)
	dw_scrap.Event pfc_Retrieve()
	RETURN 1
END IF

MessageBox("Warning", "Invalid coil ID")
il_coil = 0
RETURN -2

end event

type st_3 from statictext within w_quality_coil_scrap_office
integer x = 73
integer y = 202
integer width = 230
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80263581
string text = "Orig NUM:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_quality_coil_scrap_office
integer x = 26
integer y = 131
integer width = 296
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80263581
string text = "OR"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_quality_coil_scrap_office
integer x = 26
integer y = 74
integer width = 296
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80263581
string text = "ABCO NUM:"
boolean focusrectangle = false
end type

type cb_close from u_cb within w_quality_coil_scrap_office
integer x = 1957
integer y = 1421
integer width = 453
integer height = 102
integer taborder = 110
boolean bringtotop = true
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type gb_info from u_gb within w_quality_coil_scrap_office
integer y = 6
integer width = 1031
integer height = 394
integer taborder = 0
integer weight = 700
string facename = "Arial"
string text = "Coil ID"
end type

type gb_1 from u_gb within w_quality_coil_scrap_office
integer y = 422
integer width = 1031
integer height = 979
integer taborder = 0
integer weight = 700
string facename = "Arial"
string text = "Coil Information"
end type

type gb_3 from u_gb within w_quality_coil_scrap_office
integer x = 1042
integer y = 6
integer width = 2589
integer height = 1395
integer taborder = 0
integer weight = 700
string facename = "Arial"
string text = "Coil Scrap Information"
end type

