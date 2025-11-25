$PBExportHeader$w_property_report.srw
forward
global type w_property_report from w_sheet
end type
type cb_close from commandbutton within w_property_report
end type
type cb_print from commandbutton within w_property_report
end type
type dw_job_list from u_dw within w_property_report
end type
type cb_check from commandbutton within w_property_report
end type
type st_1 from statictext within w_property_report
end type
type st_2 from statictext within w_property_report
end type
type sle_po from singlelineedit within w_property_report
end type
type dw_alcan_coil_info from u_dw within w_property_report
end type
end forward

global type w_property_report from w_sheet
integer x = 150
integer y = 125
integer width = 3412
integer height = 2109
boolean minbox = false
boolean maxbox = false
boolean vscrollbar = true
boolean resizable = false
windowtype windowtype = response!
long backcolor = 82042848
event ue_check ( )
cb_close cb_close
cb_print cb_print
dw_job_list dw_job_list
cb_check cb_check
st_1 st_1
st_2 st_2
sle_po sle_po
dw_alcan_coil_info dw_alcan_coil_info
end type
global w_property_report w_property_report

type variables
Long il_coil_abc_num


end variables
event ue_check;String ls_yts_1_max, ls_yts_1_min, ls_yts_2_max, ls_yts_2_min, ls_yts_3_max, ls_yts_3_min
String ls_uts_1_max, ls_uts_1_min, ls_uts_2_max, ls_uts_2_min, ls_uts_3_max, ls_uts_3_min
String ls_elong_1_max, ls_elong_1_min, ls_elong_2_max, ls_elong_2_min, ls_elong_3_max, ls_elong_3_min
String ls_n_1_max, ls_n_1_min, ls_n_2_max, ls_n_2_min, ls_n_3_max, ls_n_3_min
String ls_thickness_max, ls_thickness_min
String ls_po
Int li_row, i
String ls_cur_pos
Real lr_cur_yts, lr_cur_uts, lr_cur_elong, lr_cur_n, lr_cur_thickness
string ls_coil


If len(sle_po.text) > 0 then
	ls_po = sle_po.text
else
	MessageBox("Error", "Invalid Customer PO Number.", StopSign!, OK!)
	return
end if

  
   SELECT "INBOUND_841"."TTY_MAX",   
         "INBOUND_841"."TTY_MIN",   
         "INBOUND_841"."TTU_MAX",   
         "INBOUND_841"."TTU_MIN",   
         "INBOUND_841"."TEL_MAX",   
         "INBOUND_841"."TEL_MIN",   
         "INBOUND_841"."TNL_MAX",   
         "INBOUND_841"."TNL_MIN",   
         "INBOUND_841"."TTO_MAX",   
         "INBOUND_841"."TTO_MIN",   
         "INBOUND_841"."TTS_MAX",   
         "INBOUND_841"."TTS_MIN",   
         "INBOUND_841"."TES_MAX",   
         "INBOUND_841"."TES_MIN",   
         "INBOUND_841"."TND_MAX",   
         "INBOUND_841"."TND_MIN",   
         "INBOUND_841"."TTT_MAX",   
         "INBOUND_841"."TTT_MIN",   
         "INBOUND_841"."TTL_MAX",   
         "INBOUND_841"."TTL_MIN",   
         "INBOUND_841"."TET_MAX",   
         "INBOUND_841"."TET_MIN",   
         "INBOUND_841"."TNT_MAX",   
         "INBOUND_841"."TNT_MIN",   
         "INBOUND_841"."MAX_GAUGE",   
         "INBOUND_841"."MIN_GAUGE"  
   INTO  :ls_yts_1_max,   
         :ls_yts_1_min,   
         :ls_uts_1_max,   
         :ls_uts_1_min,   
         :ls_elong_1_max,   
         :ls_elong_1_min,   
         :ls_n_1_max,   
         :ls_n_1_min,   
         :ls_yts_2_max,   
         :ls_yts_2_min,   
         :ls_uts_2_max,   
         :ls_uts_2_min,   
         :ls_elong_2_max,   
         :ls_elong_2_min,   
         :ls_n_2_max,   
         :ls_n_2_min,   
         :ls_yts_3_max,   
         :ls_yts_3_min,   
         :ls_uts_3_max,   
         :ls_uts_3_min,   
         :ls_elong_3_max,   
         :ls_elong_3_min,   
         :ls_n_3_max,   
         :ls_n_3_min,
         :ls_thickness_max,   
         :ls_thickness_min
	FROM "INBOUND_841"
	WHERE "INBOUND_841"."PO" = :ls_po and
   		"INBOUND_841"."EDI_FILE_ID" = ( SELECT Max("INBOUND_841"."EDI_FILE_ID") from "INBOUND_841" where "INBOUND_841"."PO" = :ls_po ) 
	USING SQLCA;
	
li_row = dw_alcan_coil_info.RowCount()
If li_row > 0 then
	FOR i = 1 TO li_row
		ls_cur_pos = dw_alcan_coil_info.GetItemString(i,"pst_test_result_position")
		lr_cur_yts = dw_alcan_coil_info.GetItemNumber(i,"pst_test_result_yts_val") 
		lr_cur_uts = dw_alcan_coil_info.GetItemNumber(i,"pst_test_result_uts_val")
		lr_cur_elong = dw_alcan_coil_info.GetItemNumber(i,"pst_test_result_elong_val")
		lr_cur_n = dw_alcan_coil_info.GetItemNumber(i,"pst_test_result_n_val")
		lr_cur_thickness = dw_alcan_coil_info.GetItemNumber(i,"pst_test_result_thickness")
		
		CHOOSE CASE ls_cur_pos
		CASE "11"
			IF ( (Len(ls_yts_1_max)=0) OR (Len(ls_yts_1_min)=0) OR ISNULL(ls_yts_1_max) OR ISNULL(ls_yts_1_min)) THEN
				dw_alcan_coil_info.Setitem(i, "cyts_status", 2)			
			ELSEIF  (lr_cur_yts > Real(ls_yts_1_max)) or (lr_cur_yts < Real(ls_yts_1_min)) THEN
				dw_alcan_coil_info.Setitem(i, "cyts_status", 0)
			ELSE 
				dw_alcan_coil_info.Setitem(i, "cyts_status", 1)
			END IF
			IF ( (Len(ls_uts_1_max)=0) OR (Len(ls_uts_1_min)=0) OR ISNULL(ls_uts_1_max) OR ISNULL(ls_uts_1_min)) THEN
				dw_alcan_coil_info.Setitem(i, "cuts_status", 2)			
			ELSEIF  (lr_cur_uts > Real(ls_uts_1_max)) or (lr_cur_uts < Real(ls_uts_1_min)) THEN
				dw_alcan_coil_info.Setitem(i, "cuts_status", 0)
			ELSE 
				dw_alcan_coil_info.Setitem(i, "cuts_status", 1)
			END IF
			IF ( (Len(ls_elong_1_max)=0) OR (Len(ls_elong_1_min)=0) OR ISNULL(ls_elong_1_max) OR ISNULL(ls_elong_1_min)) THEN
				dw_alcan_coil_info.Setitem(i, "celong_status", 2)			
			ELSEIF  (lr_cur_elong > Real(ls_elong_1_max)) or (lr_cur_elong < Real(ls_elong_1_min)) THEN
				dw_alcan_coil_info.Setitem(i, "celong_status", 0)
			ELSE 
				dw_alcan_coil_info.Setitem(i, "celong_status", 1)	
			END IF
			IF ( (Len(ls_n_1_max)=0) OR (Len(ls_n_1_min)=0) OR ISNULL(ls_n_1_max) OR ISNULL(ls_n_1_min)) THEN
				dw_alcan_coil_info.Setitem(i, "cn_status", 2)			
			ELSEIF  (lr_cur_n > Real(ls_n_1_max)) or (lr_cur_n < Real(ls_n_1_min)) THEN
				dw_alcan_coil_info.Setitem(i, "cn_status", 0)
			ELSE 
				dw_alcan_coil_info.Setitem(i, "cn_status", 1)	
			END IF
			IF ( (Len(ls_thickness_max)=0) OR (Len(ls_thickness_min)=0) OR ISNULL(ls_thickness_max) OR ISNULL(ls_thickness_min)) THEN
				dw_alcan_coil_info.Setitem(i, "cthickness_status", 2)			
			ELSEIF  (lr_cur_thickness > Real(ls_thickness_max)) or (lr_cur_thickness < Real(ls_thickness_min)) THEN
				dw_alcan_coil_info.Setitem(i, "cthickness_status", 0)
			ELSE 
				dw_alcan_coil_info.Setitem(i, "cthickness_status", 1)	
			END IF
		CASE "21"
			IF ( (Len(ls_yts_1_max)=0) OR (Len(ls_yts_1_min)=0) OR ISNULL(ls_yts_1_max) OR ISNULL(ls_yts_1_min)) THEN
				dw_alcan_coil_info.Setitem(i, "cyts_status", 2)			
			ELSEIF  (lr_cur_yts > Real(ls_yts_1_max)) or (lr_cur_yts < Real(ls_yts_1_min)) THEN
				dw_alcan_coil_info.Setitem(i, "cyts_status", 0)
			ELSE 
				dw_alcan_coil_info.Setitem(i, "cyts_status", 1)
			END IF
			IF ( (Len(ls_uts_1_max)=0) OR (Len(ls_uts_1_min)=0) OR ISNULL(ls_uts_1_max) OR ISNULL(ls_uts_1_min)) THEN
				dw_alcan_coil_info.Setitem(i, "cuts_status", 2)			
			ELSEIF  (lr_cur_uts > Real(ls_uts_1_max)) or (lr_cur_uts < Real(ls_uts_1_min)) THEN
				dw_alcan_coil_info.Setitem(i, "cuts_status", 0)
			ELSE 
				dw_alcan_coil_info.Setitem(i, "cuts_status", 1)
			END IF
			IF ( (Len(ls_elong_1_max)=0) OR (Len(ls_elong_1_min)=0) OR ISNULL(ls_elong_1_max) OR ISNULL(ls_elong_1_min)) THEN
				dw_alcan_coil_info.Setitem(i, "celong_status", 2)			
			ELSEIF  (lr_cur_elong > Real(ls_elong_1_max)) or (lr_cur_elong < Real(ls_elong_1_min)) THEN
				dw_alcan_coil_info.Setitem(i, "celong_status", 0)
			ELSE 
				dw_alcan_coil_info.Setitem(i, "celong_status", 1)	
			END IF
			IF ( (Len(ls_n_1_max)=0) OR (Len(ls_n_1_min)=0) OR ISNULL(ls_n_1_max) OR ISNULL(ls_n_1_min)) THEN
				dw_alcan_coil_info.Setitem(i, "cn_status", 2)			
			ELSEIF  (lr_cur_n > Real(ls_n_1_max)) or (lr_cur_n < Real(ls_n_1_min)) THEN
				dw_alcan_coil_info.Setitem(i, "cn_status", 0)
			ELSE 
				dw_alcan_coil_info.Setitem(i, "cn_status", 1)	
			END IF
			IF ( (Len(ls_thickness_max)=0) OR (Len(ls_thickness_min)=0) OR ISNULL(ls_thickness_max) OR ISNULL(ls_thickness_min)) THEN
				dw_alcan_coil_info.Setitem(i, "cthickness_status", 2)			
			ELSEIF  (lr_cur_thickness > Real(ls_thickness_max)) or (lr_cur_thickness < Real(ls_thickness_min)) THEN
				dw_alcan_coil_info.Setitem(i, "cthickness_status", 0)
			ELSE 
				dw_alcan_coil_info.Setitem(i, "cthickness_status", 1)	
			END IF
		CASE "12"
			IF ( (Len(ls_yts_2_max)=0) OR (Len(ls_yts_2_min)=0) OR ISNULL(ls_yts_2_max) OR ISNULL(ls_yts_2_min)) THEN
				dw_alcan_coil_info.Setitem(i, "cyts_status", 2)			
			ELSEIF  (lr_cur_yts > Real(ls_yts_2_max)) or (lr_cur_yts < Real(ls_yts_2_min)) THEN
				dw_alcan_coil_info.Setitem(i, "cyts_status", 0)
			ELSE 
				dw_alcan_coil_info.Setitem(i, "cyts_status", 1)
			END IF
			IF ( (Len(ls_uts_2_max)=0) OR (Len(ls_uts_2_min)=0) OR ISNULL(ls_uts_2_max) OR ISNULL(ls_uts_2_min)) THEN
				dw_alcan_coil_info.Setitem(i, "cuts_status", 2)			
			ELSEIF  (lr_cur_uts > Real(ls_uts_2_max)) or (lr_cur_uts < Real(ls_uts_2_min)) THEN
				dw_alcan_coil_info.Setitem(i, "cuts_status", 0)
			ELSE 
				dw_alcan_coil_info.Setitem(i, "cuts_status", 1)
			END IF
			IF ( (Len(ls_elong_2_max)=0) OR (Len(ls_elong_2_min)=0) OR ISNULL(ls_elong_2_max) OR ISNULL(ls_elong_2_min)) THEN
				dw_alcan_coil_info.Setitem(i, "celong_status", 2)			
			ELSEIF  (lr_cur_elong > Real(ls_elong_2_max)) or (lr_cur_elong < Real(ls_elong_2_min)) THEN
				dw_alcan_coil_info.Setitem(i, "celong_status", 0)
			ELSE 
				dw_alcan_coil_info.Setitem(i, "celong_status", 1)	
			END IF
			IF ( (Len(ls_n_2_max)=0) OR (Len(ls_n_2_min)=0) OR ISNULL(ls_n_2_max) OR ISNULL(ls_n_2_min)) THEN
				dw_alcan_coil_info.Setitem(i, "cn_status", 2)			
			ELSEIF  (lr_cur_n > Real(ls_n_2_max)) or (lr_cur_n < Real(ls_n_2_min)) THEN
				dw_alcan_coil_info.Setitem(i, "cn_status", 0)
			ELSE 
				dw_alcan_coil_info.Setitem(i, "cn_status", 1)	
			END IF
			IF ( (Len(ls_thickness_max)=0) OR (Len(ls_thickness_min)=0) OR ISNULL(ls_thickness_max) OR ISNULL(ls_thickness_min)) THEN
				dw_alcan_coil_info.Setitem(i, "cthickness_status", 2)			
			ELSEIF  (lr_cur_thickness > Real(ls_thickness_max)) or (lr_cur_thickness < Real(ls_thickness_min)) THEN
				dw_alcan_coil_info.Setitem(i, "cthickness_status", 0)
			ELSE 
				dw_alcan_coil_info.Setitem(i, "cthickness_status", 1)	
			END IF
		CASE "13"
			IF ( (Len(ls_yts_3_max)=0) OR (Len(ls_yts_3_min)=0) OR ISNULL(ls_yts_3_max) OR ISNULL(ls_yts_3_min)) THEN
				dw_alcan_coil_info.Setitem(i, "cyts_status", 2)			
			ELSEIF  (lr_cur_yts > Real(ls_yts_3_max)) or (lr_cur_yts < Real(ls_yts_3_min)) THEN
				dw_alcan_coil_info.Setitem(i, "cyts_status", 0)
			ELSE 
				dw_alcan_coil_info.Setitem(i, "cyts_status", 1)
			END IF
			IF ( (Len(ls_uts_3_max)=0) OR (Len(ls_uts_3_min)=0) OR ISNULL(ls_uts_3_max) OR ISNULL(ls_uts_3_min)) THEN
				dw_alcan_coil_info.Setitem(i, "cuts_status", 2)			
			ELSEIF  (lr_cur_uts > Real(ls_uts_3_max)) or (lr_cur_uts < Real(ls_uts_3_min)) THEN
				dw_alcan_coil_info.Setitem(i, "cuts_status", 0)
			ELSE 
				dw_alcan_coil_info.Setitem(i, "cuts_status", 1)
			END IF
			IF ( (Len(ls_elong_3_max)=0) OR (Len(ls_elong_3_min)=0) OR ISNULL(ls_elong_3_max) OR ISNULL(ls_elong_3_min)) THEN
				dw_alcan_coil_info.Setitem(i, "celong_status", 2)			
			ELSEIF  (lr_cur_elong > Real(ls_elong_3_max)) or (lr_cur_elong < Real(ls_elong_3_min)) THEN
				dw_alcan_coil_info.Setitem(i, "celong_status", 0)
			ELSE 
				dw_alcan_coil_info.Setitem(i, "celong_status", 1)	
			END IF
			IF ( (Len(ls_n_3_max)=0) OR (Len(ls_n_3_min)=0) OR ISNULL(ls_n_3_max) OR ISNULL(ls_n_3_min)) THEN
				dw_alcan_coil_info.Setitem(i, "cn_status", 2)			
			ELSEIF  (lr_cur_n > Real(ls_n_3_max)) or (lr_cur_n < Real(ls_n_3_min)) THEN
				dw_alcan_coil_info.Setitem(i, "cn_status", 0)
			ELSE 
				dw_alcan_coil_info.Setitem(i, "cn_status", 1)	
			END IF
			IF ( (Len(ls_thickness_max)=0) OR (Len(ls_thickness_min)=0) OR ISNULL(ls_thickness_max) OR ISNULL(ls_thickness_min)) THEN
				dw_alcan_coil_info.Setitem(i, "cthickness_status", 2)			
			ELSEIF  (lr_cur_thickness > Real(ls_thickness_max)) or (lr_cur_thickness < Real(ls_thickness_min)) THEN
				dw_alcan_coil_info.Setitem(i, "cthickness_status", 0)
			ELSE 
				dw_alcan_coil_info.Setitem(i, "cthickness_status", 1)	
			END IF
		END CHOOSE
	NEXT
End if

dw_alcan_coil_info.ResetUpdate()


end event

event open;call super::open;Int li_row
Real lr_lube_weight, lr_yts, lr_uts, lr_elong, lr_r, lr_n, lr_thickness
String ls_modstring
String ls_si,ls_fe,ls_cu,ls_mn,ls_mg,ls_cr,ls_ni,ls_zn,ls_ti,ls_gh,ls_al,ls_bb,ls_v   
String ls_coil_org_num, ls_pos
Int li_test_type
DateTime ld_bbd, ld_created_date
Real lr_r_11, lr_r_12, lr_r_13, lr_r_bar
il_coil_abc_num = Message.DoubleParm

This.title = "ALCAN Coil Property Report for ABCo Coil#" + string(il_coil_abc_num)

SELECT "COIL"."COIL_ORG_NUM"  
INTO :ls_coil_org_num  
FROM "COIL"  
where "COIL"."COIL_ABC_NUM" = :il_coil_abc_num 
using SQLCA;

SELECT avg("LUBE_WEIGHT"."LUBE_WEIGHT")  
INTO :lr_lube_weight  
FROM "LUBE_WEIGHT"  
where "LUBE_WEIGHT"."COIL_ABC_NUM" = :il_coil_abc_num 
using SQLCA;

SELECT "ALCAN_COIL_RETEST_DATE"."RETEST_DATE"  
INTO :ld_bbd  
FROM "ALCAN_COIL_RETEST_DATE"  
where "ALCAN_COIL_RETEST_DATE"."COIL_ORG_NUM" = :ls_coil_org_num  
using SQLCA;



  SELECT "INBOUND_863"."SI",   
         "INBOUND_863"."FE",   
         "INBOUND_863"."CU",   
         "INBOUND_863"."MN",   
         "INBOUND_863"."MG",   
         "INBOUND_863"."CR",   
         "INBOUND_863"."NI",   
         "INBOUND_863"."ZN",   
         "INBOUND_863"."TI",   
         "INBOUND_863"."GH",   
         "INBOUND_863"."AL",   
         "INBOUND_863"."BB",   
         "INBOUND_863"."V"  
    INTO :ls_si,   
         :ls_fe,   
         :ls_cu,   
         :ls_mn,   
         :ls_mg,   
         :ls_cr,   
         :ls_ni,   
         :ls_zn,   
         :ls_ti,   
         :ls_gh,   
         :ls_al,   
         :ls_bb,   
         :ls_v  
    FROM "COIL",   
         "INBOUND_863"  
   WHERE ( "COIL"."COIL_ORG_NUM" = "INBOUND_863"."COIL_NUM" ) and  
         ( "COIL"."COIL_ABC_NUM" = :il_coil_abc_num ) and
			("INBOUND_863"."EDI_FILE_ID" = ( SELECT MAX("INBOUND_863"."EDI_FILE_ID") FROM "INBOUND_863" 
														WHERE ( "COIL"."COIL_ORG_NUM" = "INBOUND_863"."COIL_NUM" ) and  
        														( "COIL"."COIL_ABC_NUM" = :il_coil_abc_num )))
	USING SQLCA;

dw_alcan_coil_info.SetTransObject(SQLCA)
dw_job_list.SetTransObject(SQLCA)
dw_alcan_coil_info.Retrieve(il_coil_abc_num)
dw_job_list.Retrieve(il_coil_abc_num)

ls_modstring = "t_coil_abc_num.Text = ~"" + String(il_coil_abc_num, "###") + "~""	
dw_alcan_coil_info.Modify(ls_modstring)
ls_modstring = "t_coil_org_num.Text = ~"" + ls_coil_org_num  + "~""	
dw_alcan_coil_info.Modify(ls_modstring)
ls_modstring = "t_lube_weight.Text = ~"" + String(lr_lube_weight, "###") + "~""	
dw_alcan_coil_info.Modify(ls_modstring)
if (ld_bbd <> Datetime(Date("1/1/1900"), Time("00:00:00") ) ) then
	ls_modstring = "t_bbd.Text = ~"" + String(ld_bbd,"mm/dd/yyyy hh:ss") + "~""	
	dw_alcan_coil_info.Modify(ls_modstring)
end if
ls_modstring = "t_si.Text = ~"" + String(Double(ls_si),"0.00") + "~""
dw_alcan_coil_info.Modify(ls_modstring)
ls_modstring = "t_al.Text = ~"" + String(Double(ls_al),"00.00") + "~""
dw_alcan_coil_info.Modify(ls_modstring)
ls_modstring = "t_be.Text = ~"" + String(Double(ls_bb),"0.0000") + "~""
dw_alcan_coil_info.Modify(ls_modstring)
ls_modstring = "t_cr.Text = ~"" + String(Double(ls_cr),"0.00") + "~""
dw_alcan_coil_info.Modify(ls_modstring)
ls_modstring = "t_cu.Text = ~"" + String(Double(ls_cu),"0.00") + "~""
dw_alcan_coil_info.Modify(ls_modstring)
ls_modstring = "t_fe.Text = ~"" + String(Double(ls_fe),"0.00") + "~""
dw_alcan_coil_info.Modify(ls_modstring)
ls_modstring = "t_ga.Text = ~"" + String(Double(ls_gh),"0.00") + "~""
dw_alcan_coil_info.Modify(ls_modstring)
ls_modstring = "t_mg.Text = ~"" + String(Double(ls_mg),"0.00") + "~""
dw_alcan_coil_info.Modify(ls_modstring)
ls_modstring = "t_mn.Text = ~"" + String(Double(ls_mn),"0.00") + "~""
dw_alcan_coil_info.Modify(ls_modstring)
ls_modstring = "t_ni.Text = ~"" + String(Double(ls_ni),"0.00") + "~""
dw_alcan_coil_info.Modify(ls_modstring)
ls_modstring = "t_ti.Text = ~"" + String(Double(ls_ti),"0.00") + "~""
dw_alcan_coil_info.Modify(ls_modstring)
ls_modstring = "t_zn.Text = ~"" + String(Double(ls_zn),"0.00") + "~""
dw_alcan_coil_info.Modify(ls_modstring)
ls_modstring = "t_v.Text = ~"" + String(Double(ls_v),"0.00") + "~""
dw_alcan_coil_info.Modify(ls_modstring)

SELECT created_date,test_type,position,yts_val,uts_val,elong_val,r_val,n_val,thickness
INTO :ld_created_date,:li_test_type,:ls_pos,:lr_yts,:lr_uts,:lr_elong,:lr_r,:lr_n,:lr_thickness
FROM pst_test_result
WHERE (coil_abc_num = :il_coil_abc_num) AND position = '11' AND source_id = '1153' AND
  created_date = ( SELECT MAX(created_date) 
  						 FROM pst_test_result 
						 WHERE (coil_abc_num = :il_coil_abc_num) AND (position = '11') AND source_id = '1153')
USING SQLCA;

IF SQLCA.SQLCODE = 0 THEN
	ls_modstring = "t_alcan_date_11.Text = ~"" + String(ld_created_date) + "~""
	dw_alcan_coil_info.Modify(ls_modstring)
	ls_modstring = "t_alcan_type_11.Text = ~"Full Test~""
	dw_alcan_coil_info.Modify(ls_modstring)
	ls_modstring = "t_alcan_pos_11.Text = ~"11~""
	dw_alcan_coil_info.Modify(ls_modstring)
	ls_modstring = "t_alcan_yts_11.Text = ~"" + String(lr_yts, "##0.0") + "~""
	dw_alcan_coil_info.Modify(ls_modstring)
	ls_modstring = "t_alcan_uts_11.Text = ~"" + String(lr_uts, "##0.0") + "~""
	dw_alcan_coil_info.Modify(ls_modstring)
	ls_modstring = "t_alcan_elong_11.Text = ~"" + String(lr_elong,"##.0") + "~""
	dw_alcan_coil_info.Modify(ls_modstring)
	ls_modstring = "t_alcan_r_11.Text = ~"" + String(lr_r,"0.000") + "~""
	dw_alcan_coil_info.Modify(ls_modstring)
	ls_modstring = "t_alcan_n_11.Text = ~"" + String(lr_n,"0.000") + "~""
	dw_alcan_coil_info.Modify(ls_modstring)
	ls_modstring = "t_alcan_thickness_11.Text = ~"" + String(lr_thickness,"0.00") + "~""
	dw_alcan_coil_info.Modify(ls_modstring)
END IF

SELECT created_date,test_type,position,yts_val,uts_val,elong_val,r_val,n_val,thickness
INTO :ld_created_date,:li_test_type,:ls_pos,:lr_yts,:lr_uts,:lr_elong,:lr_r,:lr_n,:lr_thickness
FROM pst_test_result
WHERE (coil_abc_num = :il_coil_abc_num) AND position = '12' AND source_id = '1153' AND
  created_date = ( SELECT MAX(created_date) 
  						 FROM pst_test_result 
						 WHERE (coil_abc_num = :il_coil_abc_num) AND (position = '12') AND source_id = '1153')
USING SQLCA;

IF SQLCA.SQLCODE = 0 THEN
	ls_modstring = "t_alcan_date_12.Text = ~"" + String(ld_created_date) + "~""
	dw_alcan_coil_info.Modify(ls_modstring)
	ls_modstring = "t_alcan_type_12.Text = ~"Full Test~""
	dw_alcan_coil_info.Modify(ls_modstring)
	ls_modstring = "t_alcan_pos_12.Text = ~"12~""
	dw_alcan_coil_info.Modify(ls_modstring)
	ls_modstring = "t_alcan_yts_12.Text = ~"" + String(lr_yts, "##0.0") + "~""
	dw_alcan_coil_info.Modify(ls_modstring)
	ls_modstring = "t_alcan_uts_12.Text = ~"" + String(lr_uts, "##0.0") + "~""
	dw_alcan_coil_info.Modify(ls_modstring)
	ls_modstring = "t_alcan_elong_12.Text = ~"" + String(lr_elong,"##.0") + "~""
	dw_alcan_coil_info.Modify(ls_modstring)
	ls_modstring = "t_alcan_r_12.Text = ~"" + String(lr_r,"0.000") + "~""
	dw_alcan_coil_info.Modify(ls_modstring)
	ls_modstring = "t_alcan_n_12.Text = ~"" + String(lr_n,"0.000") + "~""
	dw_alcan_coil_info.Modify(ls_modstring)
	ls_modstring = "t_alcan_thickness_12.Text = ~"" + String(lr_thickness,"0.00") + "~""
	dw_alcan_coil_info.Modify(ls_modstring)
END IF

SELECT created_date,test_type,position,yts_val,uts_val,elong_val,r_val,n_val,thickness
INTO :ld_created_date,:li_test_type,:ls_pos,:lr_yts,:lr_uts,:lr_elong,:lr_r,:lr_n,:lr_thickness
FROM pst_test_result
WHERE (coil_abc_num = :il_coil_abc_num) AND position = '13' AND source_id = '1153' AND
  created_date = ( SELECT MAX(created_date) 
  						 FROM pst_test_result 
						 WHERE (coil_abc_num = :il_coil_abc_num) AND (position = '13') AND source_id = '1153' )
USING SQLCA;

IF SQLCA.SQLCODE = 0 THEN
	ls_modstring = "t_alcan_date_13.Text = ~"" + String(ld_created_date) + "~""
	dw_alcan_coil_info.Modify(ls_modstring)
	ls_modstring = "t_alcan_type_13.Text = ~"Full Test~""
	dw_alcan_coil_info.Modify(ls_modstring)
	ls_modstring = "t_alcan_pos_13.Text = ~"13~""
	dw_alcan_coil_info.Modify(ls_modstring)
	ls_modstring = "t_alcan_yts_13.Text = ~"" + String(lr_yts, "##0.0") + "~""
	dw_alcan_coil_info.Modify(ls_modstring)
	ls_modstring = "t_alcan_uts_13.Text = ~"" + String(lr_uts, "##0.0") + "~""
	dw_alcan_coil_info.Modify(ls_modstring)
	ls_modstring = "t_alcan_elong_13.Text = ~"" + String(lr_elong,"##.0") + "~""
	dw_alcan_coil_info.Modify(ls_modstring)
	ls_modstring = "t_alcan_r_13.Text = ~"" + String(lr_r,"0.000") + "~""
	dw_alcan_coil_info.Modify(ls_modstring)
	ls_modstring = "t_alcan_n_13.Text = ~"" + String(lr_n,"0.000") + "~""
	dw_alcan_coil_info.Modify(ls_modstring)
	ls_modstring = "t_alcan_thickness_13.Text = ~"" + String(lr_thickness,"0.00") + "~""
	dw_alcan_coil_info.Modify(ls_modstring)
END IF

SELECT created_date,test_type,position,yts_val,uts_val,elong_val,r_val,n_val,thickness
INTO :ld_created_date,:li_test_type,:ls_pos,:lr_yts,:lr_uts,:lr_elong,:lr_r,:lr_n,:lr_thickness
FROM pst_test_result
WHERE (coil_abc_num = :il_coil_abc_num) AND position = '21' AND source_id = '1153' AND
  created_date = ( SELECT MAX(created_date) 
  						 FROM pst_test_result 
						 WHERE (coil_abc_num = :il_coil_abc_num) AND (position = '21') AND source_id = '1153')
USING SQLCA;

IF SQLCA.SQLCODE = 0 THEN
	ls_modstring = "t_alcan_date_21.Text = ~"" + String(ld_created_date) + "~""
	dw_alcan_coil_info.Modify(ls_modstring)
	ls_modstring = "t_alcan_type_21.Text = ~"Full Test~""
	dw_alcan_coil_info.Modify(ls_modstring)
	ls_modstring = "t_alcan_pos_21.Text = ~"21~""
	dw_alcan_coil_info.Modify(ls_modstring)
	ls_modstring = "t_alcan_yts_21.Text = ~"" + String(lr_yts, "##0.0") + "~""
	dw_alcan_coil_info.Modify(ls_modstring)
	ls_modstring = "t_alcan_uts_21.Text = ~"" + String(lr_uts, "##0.0") + "~""
	dw_alcan_coil_info.Modify(ls_modstring)
	ls_modstring = "t_alcan_elong_21.Text = ~"" + String(lr_elong,"##.0") + "~""
	dw_alcan_coil_info.Modify(ls_modstring)
	ls_modstring = "t_alcan_r_21.Text = ~"" + String(lr_r,"0.000") + "~""
	dw_alcan_coil_info.Modify(ls_modstring)
	ls_modstring = "t_alcan_n_21.Text = ~"" + String(lr_n,"0.000") + "~""
	dw_alcan_coil_info.Modify(ls_modstring)
	ls_modstring = "t_alcan_thickness_21.Text = ~"" + String(lr_thickness,"0.00") + "~""
	dw_alcan_coil_info.Modify(ls_modstring)
END IF

SELECT r_val
INTO :lr_r_11
FROM pst_test_result
WHERE (coil_abc_num = :il_coil_abc_num) AND position = '11' AND source_id = '0' AND
  created_date = ( SELECT MAX(created_date) 
  						 FROM pst_test_result 
						 WHERE (coil_abc_num = :il_coil_abc_num) AND (position = '11') AND source_id = '0')
USING SQLCA;

SELECT r_val
INTO :lr_r_12
FROM pst_test_result
WHERE (coil_abc_num = :il_coil_abc_num) AND position = '12' AND source_id = '0' AND
  created_date = ( SELECT MAX(created_date) 
  						 FROM pst_test_result 
						 WHERE (coil_abc_num = :il_coil_abc_num) AND (position = '12') AND source_id = '0')
USING SQLCA;

SELECT r_val
INTO :lr_r_13
FROM pst_test_result
WHERE (coil_abc_num = :il_coil_abc_num) AND position = '13' AND source_id = '0' AND
  created_date = ( SELECT MAX(created_date) 
  						 FROM pst_test_result 
						 WHERE (coil_abc_num = :il_coil_abc_num) AND (position = '13') AND source_id = '0')
USING SQLCA;

IF (NOT ISNULL(lr_r_11) and (lr_r_11<>0) ) AND (NOT ISNULL(lr_r_12) and (lr_r_12<>0)) AND (NOT ISNULL(lr_r_13) and (lr_r_13<>0)) THEN
	lr_r_bar = (lr_r_11 + 2*lr_r_12 + lr_r_13)/4
	ls_modstring = "t_r_bar.Text = ~"" + String(lr_r_bar,"0.000") + "~""
	dw_alcan_coil_info.Modify(ls_modstring)
ELSE 
	ls_modstring = "t_r_bar.Text = ~"N/A~""
	dw_alcan_coil_info.Modify(ls_modstring)
END IF

Long ll_abc_job
String ls_po

li_row = dw_job_list.GetRow()

if li_row > 0 then
	ll_abc_job = dw_job_list.GetItemNumber(li_row, "ab_job_num")
	
	SELECT "CUSTOMER_ORDER"."ORIG_CUSTOMER_PO" INTO :ls_po  
	FROM "AB_JOB", "CUSTOMER_ORDER"  
	WHERE ( "AB_JOB"."ORDER_ABC_NUM" = "CUSTOMER_ORDER"."ORDER_ABC_NUM" ) and  
			( "AB_JOB"."AB_JOB_NUM" = :ll_abc_job )
	USING SQLCA;
		
	sle_po.text = ls_po	
end if

if len(sle_po.text) > 0 then
	this.event ue_check()
end if

dw_job_list.SetFocus()


end event

on w_property_report.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_print=create cb_print
this.dw_job_list=create dw_job_list
this.cb_check=create cb_check
this.st_1=create st_1
this.st_2=create st_2
this.sle_po=create sle_po
this.dw_alcan_coil_info=create dw_alcan_coil_info
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_print
this.Control[iCurrent+3]=this.dw_job_list
this.Control[iCurrent+4]=this.cb_check
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.sle_po
this.Control[iCurrent+8]=this.dw_alcan_coil_info
end on

on w_property_report.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_print)
destroy(this.dw_job_list)
destroy(this.cb_check)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.sle_po)
destroy(this.dw_alcan_coil_info)
end on

event pfc_print;PrintSetup()

dw_alcan_coil_info.print()
//dw_property_report.print()
//dw_abc_test_report.print()

return 1

end event

type cb_close from commandbutton within w_property_report
integer x = 2973
integer y = 1754
integer width = 256
integer height = 86
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Close"
end type

event clicked;close(parent)
end event

type cb_print from commandbutton within w_property_report
integer x = 2973
integer y = 1482
integer width = 271
integer height = 86
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Print"
end type

event clicked;parent.event pfc_print()

end event

type dw_job_list from u_dw within w_property_report
integer x = 2915
integer y = 672
integer width = 366
integer height = 230
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_coil_by_job"
end type

event pfc_rowchanged;call super::pfc_rowchanged;Int li_row
Long ll_abc_job
String ls_po

li_row = this.GetRow()
ll_abc_job = this.GetItemNumber(li_row, "ab_job_num")

SELECT "CUSTOMER_ORDER"."ORIG_CUSTOMER_PO" INTO :ls_po  
FROM "AB_JOB", "CUSTOMER_ORDER"  
WHERE ( "AB_JOB"."ORDER_ABC_NUM" = "CUSTOMER_ORDER"."ORDER_ABC_NUM" ) and  
      ( "AB_JOB"."AB_JOB_NUM" = :ll_abc_job )
USING SQLCA;
		
sle_po.text = ls_po	


end event

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

event clicked;call super::clicked;/*
//Override pfc_clicked

integer li_rc

// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF

IF IsValid (inv_Sort) THEN 
	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
END IF 

IF IsValid (inv_linkage) THEN
	If inv_linkage.Event pfc_clicked ( xpos, ypos, row, dwo ) <> &
		inv_linkage.CONTINUE_ACTION Then
		// The user or a service action prevents from going to the clicked row.
		Return 1
	End If
END IF
*/
Int li_row
Long ll_abc_job
String ls_po

li_row = this.GetRow()
ll_abc_job = this.GetItemNumber(li_row, "ab_job_num")

SELECT "CUSTOMER_ORDER"."ORIG_CUSTOMER_PO" INTO :ls_po  
FROM "AB_JOB", "CUSTOMER_ORDER"  
WHERE ( "AB_JOB"."ORDER_ABC_NUM" = "CUSTOMER_ORDER"."ORDER_ABC_NUM" ) and  
      ( "AB_JOB"."AB_JOB_NUM" = :ll_abc_job )
USING SQLCA;
		
sle_po.text = ls_po	

parent.event ue_check()

end event

type cb_check from commandbutton within w_property_report
integer x = 2973
integer y = 1210
integer width = 256
integer height = 86
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Chec&k"
end type

event clicked;parent.event ue_check()
end event

type st_1 from statictext within w_property_report
integer x = 2915
integer y = 592
integer width = 340
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "ABC Job List:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_property_report
integer x = 2915
integer y = 995
integer width = 340
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Customer PO:"
boolean focusrectangle = false
end type

type sle_po from singlelineedit within w_property_report
integer x = 2915
integer y = 1072
integer width = 351
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type dw_alcan_coil_info from u_dw within w_property_report
integer x = 15
integer y = 38
integer width = 2856
integer height = 1926
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_alcan_coil_info"
boolean hscrollbar = true
boolean livescroll = false
end type

