$PBExportHeader$w_display_app_backup.srw
$PBExportComments$display applications of this system (original version)
forward
global type w_display_app_backup from w_sheet
end type
type st_recap_bl110 from statictext within w_display_app_backup
end type
type st_doc from statictext within w_display_app_backup
end type
type st_bl110 from statictext within w_display_app_backup
end type
type st_line from statictext within w_display_app_backup
end type
type st_camera from statictext within w_display_app_backup
end type
type p_2 from picture within w_display_app_backup
end type
type st_sheetpro from statictext within w_display_app_backup
end type
type st_circlepro from statictext within w_display_app_backup
end type
type st_orderentry from statictext within w_display_app_backup
end type
type st_production from statictext within w_display_app_backup
end type
type st_scrap from statictext within w_display_app_backup
end type
type st_warehouse from statictext within w_display_app_backup
end type
type st_shipping from statictext within w_display_app_backup
end type
type st_receiving from statictext within w_display_app_backup
end type
type st_loading from statictext within w_display_app_backup
end type
type st_coil from statictext within w_display_app_backup
end type
type st_skid from statictext within w_display_app_backup
end type
type st_recap from statictext within w_display_app_backup
end type
type st_skidentry from statictext within w_display_app_backup
end type
type st_2 from statictext within w_display_app_backup
end type
type st_shipment from statictext within w_display_app_backup
end type
type st_inventory from statictext within w_display_app_backup
end type
type p_3 from picture within w_display_app_backup
end type
type st_edi from statictext within w_display_app_backup
end type
type st_qc from statictext within w_display_app_backup
end type
type cb_1 from commandbutton within w_display_app_backup
end type
type st_schedule from statictext within w_display_app_backup
end type
type p_1 from picture within w_display_app_backup
end type
type st_dailyprod from statictext within w_display_app_backup
end type
type st_1 from statictext within w_display_app_backup
end type
type st_downtime from statictext within w_display_app_backup
end type
type st_shiftschedule from statictext within w_display_app_backup
end type
end forward

global type w_display_app_backup from w_sheet
integer x = 519
integer y = 282
integer width = 2011
integer height = 1213
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = child!
long backcolor = 12632256
boolean toolbarvisible = false
event type string ue_whoami ( )
st_recap_bl110 st_recap_bl110
st_doc st_doc
st_bl110 st_bl110
st_line st_line
st_camera st_camera
p_2 p_2
st_sheetpro st_sheetpro
st_circlepro st_circlepro
st_orderentry st_orderentry
st_production st_production
st_scrap st_scrap
st_warehouse st_warehouse
st_shipping st_shipping
st_receiving st_receiving
st_loading st_loading
st_coil st_coil
st_skid st_skid
st_recap st_recap
st_skidentry st_skidentry
st_2 st_2
st_shipment st_shipment
st_inventory st_inventory
p_3 p_3
st_edi st_edi
st_qc st_qc
cb_1 cb_1
st_schedule st_schedule
p_1 p_1
st_dailyprod st_dailyprod
st_1 st_1
st_downtime st_downtime
st_shiftschedule st_shiftschedule
end type
global w_display_app_backup w_display_app_backup

event ue_whoami;RETURN "w_display_app"
end event

on w_display_app_backup.create
int iCurrent
call super::create
this.st_recap_bl110=create st_recap_bl110
this.st_doc=create st_doc
this.st_bl110=create st_bl110
this.st_line=create st_line
this.st_camera=create st_camera
this.p_2=create p_2
this.st_sheetpro=create st_sheetpro
this.st_circlepro=create st_circlepro
this.st_orderentry=create st_orderentry
this.st_production=create st_production
this.st_scrap=create st_scrap
this.st_warehouse=create st_warehouse
this.st_shipping=create st_shipping
this.st_receiving=create st_receiving
this.st_loading=create st_loading
this.st_coil=create st_coil
this.st_skid=create st_skid
this.st_recap=create st_recap
this.st_skidentry=create st_skidentry
this.st_2=create st_2
this.st_shipment=create st_shipment
this.st_inventory=create st_inventory
this.p_3=create p_3
this.st_edi=create st_edi
this.st_qc=create st_qc
this.cb_1=create cb_1
this.st_schedule=create st_schedule
this.p_1=create p_1
this.st_dailyprod=create st_dailyprod
this.st_1=create st_1
this.st_downtime=create st_downtime
this.st_shiftschedule=create st_shiftschedule
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_recap_bl110
this.Control[iCurrent+2]=this.st_doc
this.Control[iCurrent+3]=this.st_bl110
this.Control[iCurrent+4]=this.st_line
this.Control[iCurrent+5]=this.st_camera
this.Control[iCurrent+6]=this.p_2
this.Control[iCurrent+7]=this.st_sheetpro
this.Control[iCurrent+8]=this.st_circlepro
this.Control[iCurrent+9]=this.st_orderentry
this.Control[iCurrent+10]=this.st_production
this.Control[iCurrent+11]=this.st_scrap
this.Control[iCurrent+12]=this.st_warehouse
this.Control[iCurrent+13]=this.st_shipping
this.Control[iCurrent+14]=this.st_receiving
this.Control[iCurrent+15]=this.st_loading
this.Control[iCurrent+16]=this.st_coil
this.Control[iCurrent+17]=this.st_skid
this.Control[iCurrent+18]=this.st_recap
this.Control[iCurrent+19]=this.st_skidentry
this.Control[iCurrent+20]=this.st_2
this.Control[iCurrent+21]=this.st_shipment
this.Control[iCurrent+22]=this.st_inventory
this.Control[iCurrent+23]=this.p_3
this.Control[iCurrent+24]=this.st_edi
this.Control[iCurrent+25]=this.st_qc
this.Control[iCurrent+26]=this.cb_1
this.Control[iCurrent+27]=this.st_schedule
this.Control[iCurrent+28]=this.p_1
this.Control[iCurrent+29]=this.st_dailyprod
this.Control[iCurrent+30]=this.st_1
this.Control[iCurrent+31]=this.st_downtime
this.Control[iCurrent+32]=this.st_shiftschedule
end on

on w_display_app_backup.destroy
call super::destroy
destroy(this.st_recap_bl110)
destroy(this.st_doc)
destroy(this.st_bl110)
destroy(this.st_line)
destroy(this.st_camera)
destroy(this.p_2)
destroy(this.st_sheetpro)
destroy(this.st_circlepro)
destroy(this.st_orderentry)
destroy(this.st_production)
destroy(this.st_scrap)
destroy(this.st_warehouse)
destroy(this.st_shipping)
destroy(this.st_receiving)
destroy(this.st_loading)
destroy(this.st_coil)
destroy(this.st_skid)
destroy(this.st_recap)
destroy(this.st_skidentry)
destroy(this.st_2)
destroy(this.st_shipment)
destroy(this.st_inventory)
destroy(this.p_3)
destroy(this.st_edi)
destroy(this.st_qc)
destroy(this.cb_1)
destroy(this.st_schedule)
destroy(this.p_1)
destroy(this.st_dailyprod)
destroy(this.st_1)
destroy(this.st_downtime)
destroy(this.st_shiftschedule)
end on

event pfc_postopen;String ls_login
Int li_userid, li_group_id, li_temp
Long ll_row, ll_i, ll_row2, ll_j
DataStore lds_group_app, lds_user_group, lds_user_app
Int li_q, li_ore, li_ofe, li_pc, li_sh, li_ir, li_wh, li_ic, li_is, li_sc, li_sr, li_edi,li_pls, li_dp, li_dt, li_ss, li_sur, li_bl110

ls_login = gnv_app.of_GetUserId()
li_userid = 0

CONNECT USING SQLCA;
SELECT user_id INTO :li_userid
FROM security_user
WHERE login_id = :ls_login
USING SQLCA;

IF li_userid < 1 THEN RETURN 

li_q = -1
li_ore = -1
li_ofe = -1
li_pc = -1
li_sh = -1
li_ir = -1
li_wh = -1
li_ic = -1
li_is = -1
li_sc = -1
li_sr = -1
li_edi = -1
li_pls = -1
li_dp = -1
li_dt = -1
li_ss = -1
li_sur = -1
li_bl110 = -1

lds_user_app = CREATE datastore  
lds_user_app.DataObject = "d_user_app"  
lds_user_app.SetTransObject (SQLCA)  
lds_user_app.Retrieve(li_userid)
ll_row = lds_user_app.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row 
		CHOOSE CASE lds_user_app.GetItemString(ll_i,"security_application_application_name") 
			CASE "Quotation(Sheet)"
				li_q = MAX(li_q, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
			CASE "Order Entry"
				li_ore = MAX(li_ore, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
			CASE "Office Entry"
				li_ofe = MAX(li_ofe, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
			CASE "Production Control"
				li_pc = MAX(li_pc, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
			CASE "Scrap Handling"
				li_sh = MAX(li_sh, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
			CASE "Inventory(ReCap)"
				li_ir = MAX(li_ir, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
			CASE "Warehouse"
				li_wh = MAX(li_wh, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
			CASE "Inventory(Coil)"
				li_ic = MAX(li_ic, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
			CASE "Inventory(Skid)"
				li_is = MAX(li_is, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
			CASE "Shipment(Control)"
				li_sc = MAX(li_sc, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
			CASE "Shipment(Receiving)"
				li_sr = MAX(li_sr, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
			CASE "EDI"
				li_edi = MAX(li_edi, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
			CASE "Production Line Schedule"
				li_pls = MAX(li_pls, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
			CASE "Daily Production"
				li_dp = MAX(li_dp, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
			CASE "Downtime report"
				li_dt = MAX(li_dt, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
			CASE "Shift Scheduler"
				li_ss = MAX(li_dt, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
			CASE "Shift Scheduler"
				li_ss = MAX(li_dt, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
			CASE "Surveillance"
				li_sur = MAX(li_dt, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
			CASE "Line-BL110"
				li_bl110 = MAX(li_dt, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
		END CHOOSE
	NEXT
END IF
DESTROY lds_user_app

lds_user_group = CREATE datastore  
lds_user_group.DataObject = "d_user_group"  
lds_user_group.SetTransObject (SQLCA)  
lds_user_group.Retrieve(li_userid)
ll_row = lds_user_group.RowCount()

IF ll_row > 1 THEN 
	lds_group_app = CREATE datastore  
	lds_group_app.DataObject = "d_group_app"  
	lds_group_app.SetTransObject (SQLCA)  
	FOR ll_i = 1 TO ll_row
		lds_group_app.Retrieve(lds_user_group.GetItemNumber(ll_i, "user_group_id"))
		ll_row2 = lds_group_app.RowCount()
		IF ll_row2 > 0 THEN
			FOR ll_j = 1 TO ll_row2
				CHOOSE CASE lds_group_app.GetItemString(ll_j, "security_application_application_name") 
					CASE "Quotation(Sheet)"
						li_q = MAX(li_q, lds_group_app.GetItemNumber(ll_j, "security_group_application_group_applica"))
					CASE "Order Entry"
						li_ore = MAX(li_ore, lds_group_app.GetItemNumber(ll_j, "security_group_application_group_applica"))
					CASE "Office Entry"
						li_ofe = MAX(li_ofe, lds_group_app.GetItemNumber(ll_j, "security_group_application_group_applica"))
					CASE "Production Control"
						li_pc = MAX(li_pc, lds_group_app.GetItemNumber(ll_j, "security_group_application_group_applica"))
					CASE "Scrap Handling"
						li_sh = MAX(li_sh, lds_group_app.GetItemNumber(ll_j, "security_group_application_group_applica"))
					CASE "Inventory(ReCap)"
						li_ir = MAX(li_ir, lds_group_app.GetItemNumber(ll_j, "security_group_application_group_applica"))
					CASE "Warehouse"
						li_wh = MAX(li_wh, lds_group_app.GetItemNumber(ll_j, "security_group_application_group_applica"))
					CASE "Inventory(Coil)"
						li_ic = MAX(li_ic, lds_group_app.GetItemNumber(ll_j, "security_group_application_group_applica"))
					CASE "Inventory(Skid)"
						li_is = MAX(li_is, lds_group_app.GetItemNumber(ll_j, "security_group_application_group_applica"))
					CASE "Shipment(Control)"
						li_sc = MAX(li_sc, lds_group_app.GetItemNumber(ll_j, "security_group_application_group_applica"))
					CASE "Shipment(Receiving)"
						li_sr = MAX(li_sr, lds_group_app.GetItemNumber(ll_j, "security_group_application_group_applica"))
					CASE "EDI"
						li_edi = MAX(li_edi, lds_group_app.GetItemNumber(ll_j, "security_group_application_group_applica"))
					CASE "Production Line Schedule"
						li_pls = MAX(li_pls, lds_group_app.GetItemNumber(ll_j, "security_group_application_group_applica"))
					CASE "Daily Production"
						li_dp = MAX(li_dp, lds_group_app.GetItemNumber(ll_j, "security_group_application_group_applica"))
					CASE "Downtime report"
						li_dt = MAX(li_dt, lds_group_app.GetItemNumber(ll_j, "security_group_application_group_applica"))
					CASE "Shift Scheduler"
						li_ss = MAX(li_dt, lds_group_app.GetItemNumber(ll_j, "security_group_application_group_applica"))
					CASE "Surveillance"
						li_sur = MAX(li_dt, lds_group_app.GetItemNumber(ll_i, "security_group_application_group_applica"))
					CASE "Line-BL110"
						li_bl110 = MAX(li_dt, lds_group_app.GetItemNumber(ll_i, "security_group_application_group_applica"))
				END CHOOSE
			NEXT
		END IF
	NEXT
	DESTROY lds_group_app
END IF

DESTROY lds_user_group

CHOOSE CASE li_q
	CASE 0 //Readonly
		st_sheetpro.Enabled = TRUE
		st_circlepro.Enabled = TRUE
	CASE 1 //Write
		st_sheetpro.Enabled = TRUE
		st_circlepro.Enabled = TRUE
	CASE ELSE
		st_sheetpro.Enabled = FALSE
		st_sheetpro.Textcolor = RGB(0,0,0)
		st_circlepro.Enabled = FALSE
		st_circlepro.Textcolor = RGB(0,0,0)
END CHOOSE

CHOOSE CASE li_ore
	CASE 0 //Readonly
		st_orderentry.Enabled = TRUE
	CASE 1 //Write
		st_orderentry.Enabled = TRUE
	CASE ELSE
		st_orderentry.Enabled = FALSE
		st_orderentry.TextColor = RGB(0,0,0)
END CHOOSE

CHOOSE CASE li_ofe
	CASE 0 //Readonly
		st_skidentry.Enabled = TRUE
	CASE 1 //Write
		st_skidentry.Enabled = TRUE
	CASE ELSE
		st_skidentry.Enabled = FALSE
		st_skidentry.TextColor = RGB(0,0,0)
END CHOOSE

CHOOSE CASE li_pc
	CASE 0 //Readonly
		st_production.Enabled = TRUE
	CASE 1 //Write
		st_production.Enabled = TRUE
	CASE ELSE
		st_production.Enabled = FALSE
		st_production.TextColor = RGB(0,0,0)
END CHOOSE

CHOOSE CASE li_sh
	CASE 0 //Readonly
		st_scrap.Enabled = TRUE
	CASE 1 //Write
		st_scrap.Enabled = TRUE
	CASE ELSE
		st_scrap.Enabled = FALSE
		st_scrap.TextColor = RGB(0,0,0)
END CHOOSE

CHOOSE CASE li_ir
	CASE 0 //Readonly
		st_recap.Enabled = TRUE
		st_recap_bl110.enabled = true
	CASE 1 //Write
		st_recap.Enabled = TRUE
		st_recap_bl110.enabled = true
	CASE ELSE
		st_recap.Enabled = FALSE
		st_recap_bl110.enabled = false
		st_recap.TextColor = RGB(0,0,0)
END CHOOSE

CHOOSE CASE li_wh
	CASE 0 //Readonly
		st_warehouse.Enabled = TRUE
	CASE 1 //Write
		st_warehouse.Enabled = TRUE
	CASE ELSE
		st_warehouse.Enabled = FALSE
		st_warehouse.TextColor = RGB(0,0,0)
END CHOOSE

CHOOSE CASE li_ic
	CASE 0 //Readonly
		st_coil.Enabled = TRUE
	CASE 1 //Write
		st_coil.Enabled = TRUE
	CASE ELSE
		st_coil.Enabled = FALSE
		st_coil.TextColor = RGB(0,0,0)
END CHOOSE

CHOOSE CASE li_is
	CASE 0 //Readonly
		st_skid.Enabled = TRUE
	CASE 1 //Write
		st_skid.Enabled = TRUE
	CASE ELSE
		st_skid.Enabled = FALSE
		st_skid.TextColor = RGB(0,0,0)
END CHOOSE

CHOOSE CASE li_sc
	CASE 0 //Readonly
		st_shipping.Enabled = TRUE
	CASE 1 //Write
		st_shipping.Enabled = TRUE
	CASE ELSE
		st_shipping.Enabled = FALSE
		st_shipping.TextColor = RGB(0,0,0)
END CHOOSE

CHOOSE CASE li_sr
	CASE 0 //Readonly
		st_receiving.Enabled = TRUE
	CASE 1 //Write
		st_receiving.Enabled = TRUE
	CASE ELSE
		st_receiving.Enabled = FALSE
		st_receiving.TextColor = RGB(0,0,0)
END CHOOSE

CHOOSE CASE li_edi
	CASE 0 //Readonly
		st_edi.Enabled = TRUE
	CASE 1 //Write
		st_edi.Enabled = TRUE
	CASE ELSE
		st_edi.Enabled = FALSE
		st_edi.TextColor = RGB(0,0,0)
END CHOOSE

CHOOSE CASE li_pls
	CASE 0 //Readonly
		st_schedule.Enabled = TRUE
	CASE 1 //Write
		st_schedule.Enabled = TRUE
	CASE ELSE
		st_schedule.Enabled = FALSE
		st_schedule.TextColor = RGB(0,0,0)
END CHOOSE

CHOOSE CASE li_dp
	CASE 0 //Readonly
		st_dailyprod.Enabled = TRUE
	CASE 1 //Write
		st_dailyprod.Enabled = TRUE
	CASE ELSE
		st_dailyprod.Enabled = FALSE
		st_dailyprod.TextColor = RGB(0,0,0)
END CHOOSE

CHOOSE CASE li_dt
	CASE 0 //Readonly
		st_downtime.Enabled = TRUE
	CASE 1 //Write
		st_downtime.Enabled = TRUE
	CASE ELSE
		st_downtime.Enabled = FALSE
		st_downtime.TextColor = RGB(0,0,0)
END CHOOSE

CHOOSE CASE li_ss
	CASE 0 //Readonly
		st_shiftschedule.Enabled = TRUE
	CASE 1 //Write
		st_shiftschedule.Enabled = TRUE
	CASE ELSE
		st_shiftschedule.Enabled = FALSE
		st_shiftschedule.TextColor = RGB(0,0,0)
END CHOOSE

CHOOSE CASE li_sur
	CASE 0 //Readonly
		st_camera.Enabled = TRUE
	CASE 1 //Write
		st_camera.Enabled = TRUE
	CASE ELSE
		st_camera.Enabled = FALSE
		st_camera.TextColor = RGB(0,0,0)
END CHOOSE

CHOOSE CASE li_bl110
	CASE 0 //Readonly
		st_bl110.Enabled = TRUE
	CASE 1 //Write
		st_bl110.Enabled = TRUE
	CASE ELSE
		st_bl110.Enabled = FALSE
		st_bl110.TextColor = RGB(0,0,0)
END CHOOSE
end event

type st_recap_bl110 from statictext within w_display_app_backup
boolean visible = false
integer x = 874
integer y = 573
integer width = 336
integer height = 61
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 16711680
long backcolor = 79741120
boolean enabled = false
string text = "BL110 Recap"
boolean focusrectangle = false
end type

event clicked;if this.enabled then
	Message.StringParm = "w_prod_office_auto_recap"
	w_lion_sys_frame.Event pfc_Open()
end if
end event

type st_doc from statictext within w_display_app_backup
integer x = 980
integer y = 435
integer width = 285
integer height = 61
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 16711680
long backcolor = 12632256
string text = "E-Jobfolder"
boolean focusrectangle = false
end type

event clicked;IF this.Enabled THEN
	Message.StringParm = "w_production_folder" 
	w_lion_sys_frame.Event pfc_Open()
END IF
end event

type st_bl110 from statictext within w_display_app_backup
integer x = 1532
integer y = 614
integer width = 187
integer height = 61
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
string text = "BL-110"
boolean focusrectangle = false
end type

event clicked;IF this.Enabled THEN
	Message.StringParm = "w_110_stacker_read_only" 
	w_lion_sys_frame.Event pfc_Open()
END IF
end event

type st_line from statictext within w_display_app_backup
integer x = 1357
integer y = 512
integer width = 380
integer height = 67
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Production Line"
boolean focusrectangle = false
end type

type st_camera from statictext within w_display_app_backup
integer x = 1360
integer y = 435
integer width = 307
integer height = 61
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
string text = "Surveillance"
boolean focusrectangle = false
end type

event clicked;IF this.Enabled THEN
//	Message.StringParm = "w_daily_production_scheduler" 
	Message.StringParm = "w_surveillance" 
//	Message.StringParm = "w_prod_office_auto_recap"
	w_lion_sys_frame.Event pfc_Open()
END IF

end event

type p_2 from picture within w_display_app_backup
integer width = 168
integer height = 141
boolean bringtotop = true
string picturename = "ABC1.jpg"
boolean focusrectangle = false
end type

type st_sheetpro from statictext within w_display_app_backup
integer x = 998
integer y = 147
integer width = 179
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 16711680
long backcolor = 79741120
boolean enabled = false
string text = "Sheet"
boolean focusrectangle = false
end type

event constructor;//CHOOSE CASE f_security_door("Quotation(Sheet)")
//	CASE 0 //Readonly
//		this.Enabled = TRUE
//	CASE 1 //Write
//		this.Enabled = TRUE
//	CASE ELSE
//		this.Enabled = FALSE
//		this.Textcolor = RGB(0,0,0)
//END CHOOSE
//
end event

event clicked;IF this.Enabled THEN
	Message.StringParm = "w_quotation_new" 
	w_lion_sys_frame.Event pfc_Open()
END IF

end event

type st_circlepro from statictext within w_display_app_backup
integer x = 998
integer y = 221
integer width = 179
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 16711680
long backcolor = 79741120
boolean enabled = false
string text = "Circle"
boolean focusrectangle = false
end type

event constructor;//CHOOSE CASE f_security_door("Quotation(Sheet)")
//	CASE 0 //Readonly
//		this.Enabled = TRUE
//	CASE 1 //Write
//		this.Enabled = TRUE
//	CASE ELSE
//		this.Enabled = FALSE
//		this.Textcolor = RGB(0,0,0)
//END CHOOSE
//
end event

event clicked;IF this.Enabled THEN
	Message.StringParm = "w_circlepro" 
	w_lion_sys_frame.Event pfc_Open()
END IF

end event

type st_orderentry from statictext within w_display_app_backup
integer x = 662
integer y = 269
integer width = 282
integer height = 61
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
string text = "Order Entry"
boolean focusrectangle = false
end type

event constructor;//CHOOSE CASE f_security_door("Order Entry")
//	CASE 0 //Readonly
//		this.Enabled = TRUE
//	CASE 1 //Write
//		this.Enabled = TRUE
//	CASE ELSE
//		this.Enabled = FALSE
//		this.TextColor = RGB(0,0,0)
//END CHOOSE
//
end event

event clicked;IF this.Enabled THEN
	Message.StringParm = "w_cust_order_list" 
	w_lion_sys_frame.Event pfc_Open()
END IF

end event

type st_production from statictext within w_display_app_backup
integer x = 662
integer y = 435
integer width = 307
integer height = 61
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
string text = "Production Order"
boolean focusrectangle = false
end type

event constructor;//CHOOSE CASE f_security_door("Production Control")
//	CASE 0 //Readonly
//		this.Enabled = TRUE
//	CASE 1 //Write
//		this.Enabled = TRUE
//	CASE ELSE
//		this.Enabled = FALSE
//		this.TextColor = RGB(0,0,0)
//END CHOOSE
//
end event

event clicked;IF this.Enabled THEN
	Message.StringParm = "w_ab_job_list" 
	w_lion_sys_frame.Event pfc_Open()
END IF

end event

type st_scrap from statictext within w_display_app_backup
integer x = 662
integer y = 509
integer width = 223
integer height = 61
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
string text = "Scrap Handling"
boolean focusrectangle = false
end type

event clicked;IF this.Enabled THEN
	Message.StringParm = "w_prod_scrap" 
	w_lion_sys_frame.Event pfc_Open()
END IF

end event

event constructor;//CHOOSE CASE f_security_door("Scrap Handling")
//	CASE 0 //Readonly
//		this.Enabled = TRUE
//	CASE 1 //Write
//		this.Enabled = TRUE
//	CASE ELSE
//		this.Enabled = FALSE
//		this.TextColor = RGB(0,0,0)
//END CHOOSE
//
end event

type st_warehouse from statictext within w_display_app_backup
integer x = 662
integer y = 640
integer width = 315
integer height = 61
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 16711680
long backcolor = 79741120
boolean enabled = false
string text = "Warehouse"
boolean focusrectangle = false
end type

event constructor;//CHOOSE CASE f_security_door("Warehouse")
//	CASE 0 //Readonly
//		this.Enabled = TRUE
//	CASE 1 //Write
//		this.Enabled = TRUE
//	CASE ELSE
//		this.Enabled = FALSE
//		this.TextColor = RGB(0,0,0)
//END CHOOSE
//
end event

event clicked;IF this.Enabled THEN
	Message.StringParm = "w_wh_business" 
	w_lion_sys_frame.Event pfc_Open()
END IF

end event

type st_shipping from statictext within w_display_app_backup
integer x = 1039
integer y = 845
integer width = 249
integer height = 61
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 16711680
long backcolor = 79741120
boolean enabled = false
string text = "Shipping"
boolean focusrectangle = false
end type

event constructor;//CHOOSE CASE f_security_door("Shipment(Control)")
//	CASE 0 //Readonly
//		this.Enabled = TRUE
//	CASE 1 //Write
//		this.Enabled = TRUE
//	CASE ELSE
//		this.Enabled = FALSE
//		this.TextColor = RGB(0,0,0)
//END CHOOSE
//
end event

event clicked;IF this.Enabled THEN
	Message.StringParm = "w_shipment_list" 
	w_lion_sys_frame.Event pfc_Open()
END IF

end event

type st_receiving from statictext within w_display_app_backup
integer x = 1039
integer y = 909
integer width = 241
integer height = 61
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 16711680
long backcolor = 79741120
boolean enabled = false
string text = "Receiving"
boolean focusrectangle = false
end type

event constructor;CHOOSE CASE f_security_door("Shipment(Receiving)")
	CASE 0 //Readonly
		this.Enabled = TRUE
	CASE 1 //Write
		this.Enabled = TRUE
	CASE ELSE
		this.Enabled = FALSE
		this.TextColor = RGB(0,0,0)
END CHOOSE

end event

event clicked;IF this.Enabled THEN
	Message.StringParm = "w_coil_receiving" 
	w_lion_sys_frame.Event pfc_Open()
END IF

end event

type st_loading from statictext within w_display_app_backup
integer x = 1039
integer y = 963
integer width = 219
integer height = 61
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long backcolor = 79741120
boolean enabled = false
string text = "Loading"
boolean focusrectangle = false
end type

event constructor;//CHOOSE CASE f_security_door("Shipment(Loading)")
//	CASE 0 //Readonly
//		this.Enabled = TRUE
//	CASE 1 //Write
//		this.Enabled = TRUE
//	CASE ELSE
//		this.Enabled = FALSE
//		this.TextColor = RGB(0,0,0)
//END CHOOSE
//
end event

event clicked;//IF this.Enabled THEN
//	Message.StringParm = "w_shipping_dock" 
//	w_lion_sys_frame.Event pfc_Open()
//END IF

end event

type st_coil from statictext within w_display_app_backup
integer x = 1039
integer y = 691
integer width = 102
integer height = 61
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 16711680
long backcolor = 79741120
boolean enabled = false
string text = "Coil"
boolean focusrectangle = false
end type

event constructor;//CHOOSE CASE f_security_door("Inventory(Coil)")
//	CASE 0 //Readonly
//		this.Enabled = TRUE
//	CASE 1 //Write
//		this.Enabled = TRUE
//	CASE ELSE
//		this.Enabled = FALSE
//		this.TextColor = RGB(0,0,0)
//END CHOOSE
//
end event

event clicked;IF this.Enabled THEN
	Message.StringParm = "w_inv_coil" 
	w_lion_sys_frame.Event pfc_Open()
END IF

end event

type st_skid from statictext within w_display_app_backup
integer x = 1039
integer y = 771
integer width = 106
integer height = 61
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 16711680
long backcolor = 79741120
boolean enabled = false
string text = "Skid"
boolean focusrectangle = false
end type

event constructor;//CHOOSE CASE f_security_door("Inventory(Skid)")
//	CASE 0 //Readonly
//		this.Enabled = TRUE
//	CASE 1 //Write
//		this.Enabled = TRUE
//	CASE ELSE
//		this.Enabled = FALSE
//		this.TextColor = RGB(0,0,0)
//END CHOOSE
//
end event

event clicked;IF this.Enabled THEN
	Message.StringParm = "w_inv_skid" 
	w_lion_sys_frame.Event pfc_Open()
END IF

end event

type st_recap from statictext within w_display_app_backup
integer x = 662
integer y = 573
integer width = 165
integer height = 61
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 16711680
long backcolor = 79741120
boolean enabled = false
string text = "Recap"
boolean focusrectangle = false
end type

event constructor;//CHOOSE CASE f_security_door("Inventory(ReCap)")
//	CASE 0 //Readonly
//		this.Enabled = TRUE
//	CASE 1 //Write
//		this.Enabled = TRUE
//	CASE ELSE
//		this.Enabled = FALSE
//		this.TextColor = RGB(0,0,0)
//END CHOOSE
//
end event

event clicked;IF this.Enabled THEN
//	Message.StringParm = "w_inv_recap" 
	Message.StringParm = "w_prod_order_office_recap"
	w_lion_sys_frame.Event pfc_Open()
END IF

end event

type st_skidentry from statictext within w_display_app_backup
integer x = 662
integer y = 352
integer width = 402
integer height = 61
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 16711680
long backcolor = 79741120
boolean enabled = false
string text = "Office Skid Entry"
boolean focusrectangle = false
end type

event constructor;//CHOOSE CASE f_security_door("Office Entry")
//	CASE 0 //Readonly
//		this.Enabled = TRUE
//	CASE 1 //Write
//		this.Enabled = TRUE
//	CASE ELSE
//		this.Enabled = FALSE
//		this.TextColor = RGB(0,0,0)
//END CHOOSE
//
end event

event clicked;IF this.Enabled THEN
	Message.StringParm = "w_office_skid_entry" 
	w_lion_sys_frame.Event pfc_Open()
END IF

end event

type st_2 from statictext within w_display_app_backup
integer x = 666
integer y = 157
integer width = 249
integer height = 67
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Quotation"
boolean focusrectangle = false
end type

type st_shipment from statictext within w_display_app_backup
integer x = 662
integer y = 845
integer width = 241
integer height = 61
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Shipment"
boolean focusrectangle = false
end type

type st_inventory from statictext within w_display_app_backup
integer x = 662
integer y = 717
integer width = 249
integer height = 61
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Inventory"
boolean focusrectangle = false
end type

type p_3 from picture within w_display_app_backup
integer x = 1843
integer width = 168
integer height = 141
boolean bringtotop = true
string picturename = "ABC1.jpg"
boolean focusrectangle = false
end type

type st_edi from statictext within w_display_app_backup
integer x = 742
integer y = 899
integer width = 106
integer height = 61
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 16711680
long backcolor = 79741120
boolean enabled = false
string text = "EDI"
boolean focusrectangle = false
end type

event constructor;//CHOOSE CASE f_security_door("EDI")
//	CASE 0 //Readonly
//		this.Enabled = TRUE
//	CASE 1 //Write
//		this.Enabled = TRUE
//	CASE ELSE
//		this.Enabled = FALSE
//		this.TextColor = RGB(0,0,0)
//END CHOOSE
//
end event

event clicked;IF this.Enabled THEN
	Message.StringParm = "w_edi" 
	w_lion_sys_frame.Event pfc_Open()
END IF

end event

type st_qc from statictext within w_display_app_backup
integer x = 662
integer y = 1101
integer width = 362
integer height = 61
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 16711680
long backcolor = 79741120
string text = "Quality Control"
boolean focusrectangle = false
end type

event clicked;IF this.Enabled THEN
	Message.StringParm = "w_quality_control" 
	w_lion_sys_frame.Event pfc_Open()
END IF

end event

type cb_1 from commandbutton within w_display_app_backup
integer x = 1755
integer y = 1040
integer width = 197
integer height = 64
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
end type

event clicked;close(parent)
end event

type st_schedule from statictext within w_display_app_backup
integer x = 662
integer y = 1021
integer width = 289
integer height = 61
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
string text = "Schedule"
boolean focusrectangle = false
end type

event clicked;IF this.Enabled THEN
	Message.StringParm = "w_line_priority" 
	w_lion_sys_frame.Event pfc_Open()
END IF

end event

event constructor;//CHOOSE CASE f_security_door("Production Line Schedule")
//	CASE 0 //Readonly
//		this.Enabled = TRUE
//	CASE 1 //Write
//		this.Enabled = TRUE
//	CASE ELSE
//		this.Enabled = FALSE
//		this.TextColor = RGB(0,0,0)
//END CHOOSE
end event

type p_1 from picture within w_display_app_backup
integer width = 1997
integer height = 1197
boolean originalsize = true
string picturename = "./app_back.jpg"
boolean focusrectangle = false
end type

type st_dailyprod from statictext within w_display_app_backup
integer x = 1360
integer y = 218
integer width = 377
integer height = 61
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
string text = "Shift Summary"
boolean focusrectangle = false
end type

event clicked;IF this.Enabled THEN
	Message.StringParm = "w_daily_production" 
	w_lion_sys_frame.Event pfc_Open()
END IF

end event

event constructor;//CHOOSE CASE f_security_door("Daily Production")
//	CASE 0 //Readonly
//		this.Enabled = TRUE
//	CASE 1 //Write
//		this.Enabled = TRUE
//	CASE ELSE
//		this.Enabled = FALSE
//		this.TextColor = RGB(0,0,0)
//END CHOOSE
//
end event

type st_1 from statictext within w_display_app_backup
integer x = 1284
integer y = 144
integer width = 592
integer height = 67
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Operations Management"
boolean focusrectangle = false
end type

type st_downtime from statictext within w_display_app_backup
integer x = 1360
integer y = 285
integer width = 457
integer height = 61
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
string text = "Downtime Reports"
boolean focusrectangle = false
end type

event clicked;IF this.Enabled THEN
	Message.StringParm = "w_report_downtime" 
	w_lion_sys_frame.Event pfc_Open()
END IF

end event

event constructor;//CHOOSE CASE f_security_door("Downtime Report")
//	CASE 0 //Readonly
//		this.Enabled = TRUE
//	CASE 1 //Write
//		this.Enabled = TRUE
//	CASE ELSE
//		this.Enabled = FALSE
//		this.TextColor = RGB(0,0,0)
//END CHOOSE
//
end event

type st_shiftschedule from statictext within w_display_app_backup
integer x = 1360
integer y = 365
integer width = 377
integer height = 61
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
string text = "Shift Scheduler"
boolean focusrectangle = false
end type

event clicked;IF this.Enabled THEN
//	Message.StringParm = "w_daily_production_scheduler" 
	Message.StringParm = "w_line_scheduler" 
	w_lion_sys_frame.Event pfc_Open()
END IF

end event

event constructor;//CHOOSE CASE f_security_door("Shift Scheduler")
//	CASE 0 //Readonly
//		this.Enabled = TRUE
//	CASE 1 //Write
//		this.Enabled = TRUE
//	CASE ELSE
//		this.Enabled = FALSE
//		this.TextColor = RGB(0,0,0)
//END CHOOSE
//
end event

