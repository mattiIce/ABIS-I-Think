$PBExportHeader$nv_test.sru
$PBExportComments$Thread test object
forward
global type nv_test from nonvisualobject
end type
end forward

global type nv_test from nonvisualobject
end type
global nv_test nv_test

type variables
nonvisualobject inv_arg
long il_count

String	is_object
DataWindow	idw1, idw2, idw3

Boolean	ib_coils_done, ib_scrap_done, ib_skids_done

OleObject 	iole_OLE, iole_Sheet


String	is_work_folder //Work folder where work files are created and deleted after they are used
end variables

forward prototypes
public function long of_getcount ()
public function integer of_setparent (nonvisualobject anv_arg)
public function string of_getobject ()
public function integer of_connect_transaction ()
public function integer of_start ()
public function integer of_update_data_export (ref datastore ads)
protected function integer of_saveas (ref datastore ads, string as_report_folder, string as_report_name, string as_saveastype, boolean ab_colheading)
public function integer of_saveas (ref datawindow adw, string as_report_folder, string as_report_name, string as_saveastype, boolean ab_colheading)
public function string of_get_customer_name (long al_customer_id)
public function integer of_specs_scrap (ref datastore ads)
public function integer of_specs_skids (ref datastore ads)
public function string of_job_specs (long al_job)
public function boolean of_get_coils_done ()
public function boolean of_get_scrap_done ()
public function boolean of_get_skids_done ()
public function string inttocolumn (integer ai_col)
public function any getdata (datastore adw_dw, long al_row, string as_column)
public subroutine getcolumns (datastore adw_dw, ref string as_columns[])
public subroutine exporttoexcel_coils (datastore adw_dw, long al_rows, string as_folder, string as_report_name, string as_report_header)
public subroutine create_excel_ole ()
public subroutine destroy_excel_ole ()
public subroutine excel_open_csv_saveas_xls (string as_folder, string as_report_name)
public subroutine exporttoexcel_scrap (datastore adw_dw, long al_rows, string as_folder, string as_report_name, string as_report_header)
protected subroutine excel_open_xls_saveas_csv (string as_folder, string as_report_name)
public subroutine exporttoexcel_skids (datastore adw_dw, long al_rows, string as_folder, string as_report_name, string as_report_header)
public subroutine of_set_work_folder (string as_work_folder)
public function integer of_report_inv_cust_coils (long al_customer_id[], string as_customer_short_name, string as_filetype_2create)
public function integer of_report_inv_cust_scrap_skids (long al_customer_id[], string as_customer_short_name, string as_filetype_2create)
public function integer of_report_inv_cust_skids (long al_customer_id[], string as_customer_short_name, string as_filetype_2create)
public function integer of_report_inv_cust_coils_comb (long al_customer_id[], ref datastore ads_report_inv_cust_coils_comb)
public function integer of_report_inv_cust_scrap_skids_comb (long al_customer_id[], ref datastore ads_report_inv_cust_scrap_skids_comb)
public function integer of_report_inv_cust_skids_comb (long al_customer_id[], ref datastore ads_report_inv_cust_skids_comb)
public subroutine of_eliminate_duplicate_weight (ref datastore ads_report_inv_cust_coils_comb)
public subroutine exporttoexcel_skids_t (datastore adw_dw, long al_rows, string as_folder, string as_report_name, string as_report_header)
public subroutine of_remove_duplicate_coils (ref datastore ads_report_coils)
public function integer of_unmatched_coils (long al_customer_id[])
public function integer of_unmatched_coils_auto (long al_customer_id[])
public function integer of_report_inv_cust_coils_comb_auto (long al_customer_id[], ref datastore ads_report_inv_cust_coils_comb)
public function integer of_report_inv_cust_coils_auto (long al_customer_id[], string as_customer_short_name, string as_filetype_2create)
end prototypes

public function long of_getcount ();return il_count
end function

public function integer of_setparent (nonvisualobject anv_arg);inv_arg = anv_arg
return 1
end function

public function string of_getobject ();Return is_object
end function

public function integer of_connect_transaction ();Integer	li_rtn

sqlca.dbms = "O90 Oracle9i (9.0.1)"
sqlca.dbparm = "ConnectString='UID=dbo;PWD=obd#157'"
sqlca.logid = "dbo"
sqlca.logpass = "obd#157"
sqlca.servername = "PDB_ABC11"
sqlca.database = "ABC11"

connect using sqlca;

li_rtn = sqlca.sqlcode

//MessageBox("of_connect_transaction for nv_test", "li_rtn = " + String(li_rtn) + "~n~rsqlca.database = " + sqlca.database + "~n~rsqlca.servername = " + sqlca.servername)

Return li_rtn
end function

public function integer of_start ();time t1

//MessageBox("of_start for nv_test", "is_object = " + is_object)

//Choose Case Lower(is_object)
//	Case "object1" 	
//		//MessageBox("of_start for nv_test", "Case for object1. is_object = " + is_object)
//		of_report_inv_cust_skids()
//	Case "object2"
//		//MessageBox("of_start for nv_test", "Case for object2. is_object = " + is_object)
//		of_report_inv_cust_scrap_skids()
//	Case "object3" 	
//		//MessageBox("of_start for nv_test", "Case for object3. is_object = " + is_object)
//		of_report_inv_cust_coils()
//End Choose

t1 = now()

//do while secondsafter(t1,now()) < 5 
//	il_Count++
//	inv_arg.triggerevent('ue_thread')
//loop
	
return 1
end function

public function integer of_update_data_export (ref datastore ads);/*
Function:	of_update_data_export
Returns:		integer
Arguments:	reference	datastore	ads
*/

Integer	li_rtn = 1
String	ls_modstring, ls_rtn

ls_modstring = "DataWindow.Printer='PDFPrinter'"
ls_rtn = ads.Modify(ls_modstring)

ls_modstring = "DataWindow.Export.PDF.Method=Distill!"
ls_rtn = ads.Modify(ls_modstring)

ls_modstring = "DataWindow.Export.PDF.Distill.CustomPostScript=1"
ls_rtn = ads.Modify(ls_modstring)

Return li_rtn

//ads.Object.DataWindow.Export.PDF.Method = Distill!
//ads.Object.DataWindow.Export.PDF.Distill.CustomPostScript="no"
end function

protected function integer of_saveas (ref datastore ads, string as_report_folder, string as_report_name, string as_saveastype, boolean ab_colheading);/*
Function:	of_saveas
Returns:		integer
Arguments:	reference	datastore	ads
				value			string		as_report_folder
				value			string		as_report_name
				value			string		as_saveastype
				value			boolean		ab_colheading
*/

Integer	li_rtn = 1

Choose Case Lower(as_saveastype)
	Case "excel"
		li_rtn = ads.SaveAs(as_report_folder + "\" + as_report_name, excel!, ab_colheading)
	Case "excel8"
		li_rtn = ads.SaveAs(as_report_folder + "\" + as_report_name, excel8!, ab_colheading)
	Case "text"
		li_rtn = ads.SaveAs(as_report_folder + "\" + as_report_name, text!, ab_colheading)
	Case "csv"
		li_rtn = ads.SaveAs(as_report_folder + "\" + as_report_name, csv!, ab_colheading)
	Case "pdf"
		li_rtn = ads.SaveAs(as_report_folder + "\" + as_report_name, pdf!, ab_colheading)
	Case "xml"
		li_rtn = ads.SaveAs(as_report_folder + "\" + as_report_name, xml!, ab_colheading)
	Case "psreport"
		li_rtn = ads.SaveAs(as_report_folder + "\" + as_report_name, psreport!, ab_colheading)
	Case "htmltable"
		li_rtn = ads.SaveAs(as_report_folder + "\" + as_report_name, htmltable!, ab_colheading)
	Case Else
		li_rtn = -1
End Choose

Return li_rtn
end function

public function integer of_saveas (ref datawindow adw, string as_report_folder, string as_report_name, string as_saveastype, boolean ab_colheading);/*
Function:	of_saveas
Returns:		integer
Arguments:	reference	datawindow	adw
				value			string		as_report_folder
				value			string		as_report_name
				value			string		as_saveastype
				value			boolean		ab_colheading
*/

Integer	li_rtn = 1

Choose Case Lower(as_saveastype)
	Case "excel"
		li_rtn = adw.SaveAs(as_report_folder + "\" + as_report_name, excel!, ab_colheading)
	Case "excel8"
		li_rtn = adw.SaveAs(as_report_folder + "\" + as_report_name, excel8!, ab_colheading)
	Case "text"
		li_rtn = adw.SaveAs(as_report_folder + "\" + as_report_name, text!, ab_colheading)
	Case "csv"
		li_rtn = adw.SaveAs(as_report_folder + "\" + as_report_name, csv!, ab_colheading)
	Case "pdf"
		li_rtn = adw.SaveAs(as_report_folder + "\" + as_report_name, pdf!, ab_colheading)
	Case "xml"
		li_rtn = adw.SaveAs(as_report_folder + "\" + as_report_name, xml!, ab_colheading)
	Case "psreport"
		li_rtn = adw.SaveAs(as_report_folder + "\" + as_report_name, psreport!, ab_colheading)
	Case "htmltable"
		li_rtn = adw.SaveAs(as_report_folder + "\" + as_report_name, htmltable!, ab_colheading)
	Case Else
		li_rtn = -1
End Choose

Return li_rtn
end function

public function string of_get_customer_name (long al_customer_id);
String	ls_customer_name

select	customer_short_name
into		:ls_customer_name
from		customer
where		customer_id = :al_customer_id
using 	sqlca;

Return ls_customer_name
end function

public function integer of_specs_scrap (ref datastore ads);Long ll_days, ll_skid, ll_pskid, ll_nskid, ll_rows, ll_c
Date ld_skiddate

ll_rows = ads.RowCount()

If ll_rows <= 0 Then Return 1

ll_skid = ads.GetItemNumber(1, "scrap_skid_scrap_skid_num")	
ld_skiddate = Date(ads.GetItemDateTime(1, "scrap_skid_scrap_date"))
ll_days = DaysAfter(ld_skiddate, Today())
ads.SetItem(1, "duration", ll_days)

ll_pskid = ll_skid

If ll_rows > 1 Then
	For ll_c = 2 To ll_rows
		ll_skid = ads.GetItemNumber(ll_c, "scrap_skid_scrap_skid_num")
		
		If ll_skid = ll_pskid Then
			SetNULL(ll_days)
			ads.SetItem(ll_c, "duration", ll_days)
		Else
			ll_pskid = ll_skid
			ld_skiddate = Date(ads.GetItemDateTime(ll_c, "scrap_skid_scrap_date"))
			ll_days = DaysAfter(ld_skiddate, Today())
			ads.SetItem(ll_c, "duration", ll_days)
		End If
		
	Next
End If

ads.ResetUpdate()

Return 1
end function

public function integer of_specs_skids (ref datastore ads);Long 		ll_row, ll_c
Long 		ll_job, ll_bal_due
String	ls_spec
Integer	li_rtn = 1

ll_row = ads.RowCount()

IF ll_row > 0 THEN
	FOR ll_c = 1 TO ll_row
		ll_job = ads.GetItemNumber(ll_c, "ab_job_ab_job_num")
		ls_spec = of_job_specs(ll_job)
		ads.SetItem(ll_c, "cspec_t", ls_spec)
	NEXT
END IF
ads.ResetUpdate()

Return li_rtn
end function

public function string of_job_specs (long al_job);SetPointer(HourGlass!)

String ls_spec
Long ll_order
Int li_item
String ls_shape
Real lr_l, lr_s, lr_w, lr_gauge

CONNECT USING SQLCA;

SELECT order_abc_num, order_item_num INTO :ll_order, :li_item
FROM ab_job 
WHERE ab_job_num = :al_job
USING SQLCA;

SELECT sheet_type, gauge INTO :ls_shape, :lr_gauge
FROM order_item
WHERE order_abc_num = :ll_order AND order_item_num = :li_item
USING SQLCA;

ls_spec = String(lr_gauge, "#.#####")
CHOOSE CASE Upper(Trim(ls_shape))
	CASE "RECTANGLE"
		SELECT rt_length, rt_width INTO :lr_l, :lr_w
		FROM rectangle
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + " X " + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "PARALLELOGRAM"
		SELECT p_length, p_width INTO :lr_l, :lr_w
		FROM parallelogram
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + " X " + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "FENDER"
		SELECT fe_side INTO :lr_l
		FROM fender
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + " X " + String(lr_l, "#####.#####") 
	CASE "CHEVRON"
		SELECT ch_length, ch_width INTO :lr_l, :lr_w
		FROM chevron
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + " X " + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "CIRCLE"
		SELECT c_diameter INTO :lr_l
		FROM circle
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + " X " + String(lr_l, "#####.#####") 
	CASE "TRAPEZOID"
		SELECT tr_long_length, tr_short_length, tr_width INTO :lr_l, :lr_s, :lr_w
		FROM trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + " X " + String(lr_w, "#####.#####") + " X " + String(lr_s, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "L.TRAPEZOID"
		SELECT ltr_long_length, ltr_short_length, ltr_width INTO :lr_l, :lr_s, :lr_w
		FROM left_trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + " X " + String(lr_w, "#####.#####") + " X " + String(lr_s, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "R.TRAPEZOID"
		SELECT rtr_long_length, rtr_short_length, rtr_width INTO :lr_l, :lr_s, :lr_w
		FROM right_trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + " X " + String(lr_w, "#####.#####") + " X " + String(lr_s, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "OTHER"
		SELECT x_1, x_2 INTO :lr_w, :lr_l
		FROM x1_shape
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + " X " + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE ELSE
		ls_spec = ls_spec + " X " + "VAR"
END CHOOSE	

RETURN ls_spec
end function

public function boolean of_get_coils_done ();Return ib_coils_done
end function

public function boolean of_get_scrap_done ();Return ib_scrap_done
end function

public function boolean of_get_skids_done ();Return ib_skids_done
end function

public function string inttocolumn (integer ai_col);//Alex Gerlants. 05/02/2016. Begin
/*
Function:	inttocolumn
				Convert a column number into a spreadsheet column reference
Returns:		string
Arguments:	value	integer	ai_col
*/

String ls_Col
Integer li_Min, li_Max

IF ai_col <= 0 THEN RETURN ""

// calc the major/minor letters
li_Max = ai_col / 26
li_Min = ai_col - ( li_Max * 26 )

// Convert min and max to letters
IF li_Max > 0 THEN
	ls_Col = Char( 64 + li_Max )
END IF

ls_Col += String( Char( 64 + li_Min ) )

RETURN ls_Col
//Alex Gerlants. 05/02/2016. End
end function

public function any getdata (datastore adw_dw, long al_row, string as_column);//Alex Gerlants. 05/02/2016. Begin
/*
Function:	getdata
Returns:		any
Arguments:	value	datastore	adw_dw
				value	long			al_row
				value	string		as_column
*/

Long ll_Col
Any la_A

IF al_Row > adw_DW.RowCount() THEN RETURN ""
ll_Col = Long( adw_DW.Describe( as_Column + ".ID" ) )
IF ll_Col > 0 THEN &
   la_A = adw_DW.object.data.primary.current[ al_Row, ll_Col ]

RETURN la_A
//Alex Gerlants. 05/02/2016. End
end function

public subroutine getcolumns (datastore adw_dw, ref string as_columns[]);//Alex Gerlants. 05/02/2016. Begin
/*
Function:	getcolumns
				Get a list of all the columns in the DW
				Note this function could be replaced with
				a function that allows the developer to specify
				the column names to be exported.
Returns:		none
Arguments:	value	datastore	adw_dw
				reference	string	as_columns[]
*/

Long ll_I, ll_Cols
String	ls_column_name

ll_Cols = Long( adw_DW.Describe( 'datawindow.column.count' ) )
FOR ll_I = ll_cols TO 1 STEP -1
	ls_column_name = adw_DW.Describe( '#' + String( ll_I ) + '.Name' )
	as_columns[ ll_I ] = ls_column_name
NEXT

////Alex Gerlants. 05/02/2016. End
end subroutine

public subroutine exporttoexcel_coils (datastore adw_dw, long al_rows, string as_folder, string as_report_name, string as_report_header);/* 
Function:	exporttoexcel_coils
Returns:		none
Arguments:	value		datastore	adw_dw
				value		long			al_rows	
				value		string		as_folder
				value		string		as_report_name 	<== Report file name
				value		string		as_report_header	<== Report header

*/

// Export the data to Excel
OleObject 	lole_OLE, lole_Sheet
String 		ls_Columns[]
Long 			ll_report_rows, ll_Row, ll_Col, ll_Cols, ll_total_line1, ll_total_line2
String		ls_range, ls_total_coil_orig_net_wt, ls_total_coil_current_net_wt_balance, ls_total_coil_count
Boolean		lb_rtn, lb_directoryexists, lb_fileexists, lb_rtn_delete

String 		ls_file, ls_today, ls_now, ls_folder
Date 			ld_today
Time 			ld_now
Integer		li_answer

String		ls_report_name, ls_received_date, ls_status, ls_gauge, ls_width
Long			ll_start_row = 1

lole_OLE = CREATE OleObject

SetPointer( HourGlass! )

lole_OLE.ConnectToNewObject( 'excel.application' )
lole_OLE.Workbooks.Add
lole_sheet = lole_OLE.Application.ActiveWorkbook.WorkSheets[1]

//---

ll_report_rows = al_rows

ls_folder = as_folder
ls_report_name = as_report_name
ls_received_date = "All"
ls_status = "All"
ls_gauge = "All"
ls_width = "All"

//Get report totals
If al_rows > 0 Then
	ls_total_coil_count = String(adw_dw.Object.compute_2[1])
	ls_total_coil_orig_net_wt = String(adw_dw.Object.compute_3[1])
	ls_total_coil_current_net_wt_balance = String(adw_dw.Object.compute_4[1])
Else
	Return
End If

This.GetColumns( adw_DW, ls_Columns )

ll_Cols = UpperBound( ls_Columns )

//Load data
FOR ll_col = 1 TO ll_cols
	lole_Sheet.Cells[ 1, ll_Col ] = ls_Columns[ ll_Col ]
NEXT

FOR ll_Row = 2 TO al_rows + 1
	FOR ll_Col = 1 TO ll_cols
		lole_Sheet.Cells[ ll_Row, ll_Col ] = This.GetData( adw_DW, ll_Row - 1, ls_Columns[ ll_Col ] )
	NEXT
NEXT

lole_Sheet.Range( inttocolumn( 1 ) + "1:" + inttocolumn( ll_Cols ) + "1").Select
lole_OLE.Selection.Font.Bold = True

lole_Sheet.Range("A1:A1").Select
lole_Sheet.Columns( inttocolumn( 1 ) + ":" + inttocolumn( ll_cols ) ).EntireColumn.AutoFit


//Column Headings
lole_OLE.cells[1,1]  = "Coil ID"
lole_OLE.cells[1,2]  = "Coil Orig No."
lole_OLE.cells[1,3]  = "Alt. Coil No."
lole_OLE.cells[1,4]  = "Lot No."
lole_OLE.cells[1,5]  = "Alloy"
lole_OLE.cells[1,6]  = "Temp"
lole_OLE.cells[1,7]  = "End User"
lole_OLE.cells[1,8]  = "Reference"
lole_OLE.cells[1,9] = "Begin Wt"
lole_OLE.cells[1,10] = "Orig NetWT"
lole_OLE.cells[1,11] = "Received"
lole_OLE.cells[1,12] = "Cur.WT"
lole_OLE.cells[1,13] = "Gauge"
lole_OLE.cells[1,14] = "Width"
lole_OLE.cells[1,15] = "Status"
lole_OLE.cells[1,16] = "Duration"
lole_OLE.cells[1,17] = "Cons.Coil #"
lole_OLE.cells[1,18] = "Material#"
lole_OLE.cells[1,19] = "CASH"

//Insert Lines for Header & Miscellaneous Details (3 lines above columnar data)
lole_Sheet.Range("A1:Q3").Select
lole_Sheet.Application.Selection.EntireRow.Insert 

lole_OLE.cells[1,9] = as_report_header
lole_Sheet.Range("I1:I1").Select
lole_OLE.Selection.Font.Bold = True
lole_OLE.Selection.Font.Size = 24 //Change font size
lole_OLE.Selection.Font.Underline = True

lole_OLE.cells[1,19] = String(Today(), "mm/dd/yyyy")
lole_Sheet.Range("S1:S1").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[2,3] = "Received Date: " + ls_received_date
lole_Sheet.Range("C2:C2").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[2,8] = "Status: " + ls_status
lole_Sheet.Range("H2:H2").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[2,10] = "Gauge: " + ls_gauge
lole_Sheet.Range("J2:J2").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[2,13] = "Width: " + ls_width
lole_Sheet.Range("M2:M2").Select
lole_OLE.Selection.Font.Bold = True

//---

ll_total_line1 = ll_report_rows + 5
ll_total_line2 = ll_report_rows + 6

//Insert 2 lines for totals (below columnar data)
ls_range = "A" + String(ll_total_line1) + ":" + "S" + String(ll_total_line1)
lole_Sheet.Range(ls_range).Select
lole_Sheet.Application.Selection.EntireRow.Insert

lole_OLE.cells[ll_total_line2,7] = "Total:"
ls_range = "G" + String(ll_total_line2) + ":" + "G" + String(ll_total_line2)
lole_Sheet.Range(ls_range).Select
//lole_OLE.Selection.Font.Bold = True
lole_OLE.Selection.Font.FontStyle = "Bold" //Another way to bold a cell

lole_OLE.cells[ll_total_line2,8] = ls_total_coil_count
ls_range = "H" + String(ll_total_line2) + ":" + "H" + String(ll_total_line2)
lole_Sheet.Range(ls_range).Select
//lole_OLE.Selection.Font.Bold = True
lole_OLE.Selection.Font.FontStyle = "Bold" //Another way to bold a cell

lole_OLE.cells[ll_total_line1,10] = "-------------"
ls_range = "J" + String(ll_total_line1) + ":" + "J" + String(ll_total_line1)
lole_Sheet.Range(ls_range).Select
//lole_OLE.Selection.Font.Bold = True
lole_OLE.Selection.Font.FontStyle = "Bold"

lole_OLE.cells[ll_total_line2,10] = ls_total_coil_orig_net_wt
ls_range = "J" + String(ll_total_line2) + ":" + "J" + String(ll_total_line2)
lole_Sheet.Range(ls_range).Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[ll_total_line1,12] = "-------------"
ls_range = "L" + String(ll_total_line1) + ":" + "L" + String(ll_total_line1)
lole_Sheet.Range(ls_range).Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[ll_total_line2,12] = ls_total_coil_current_net_wt_balance
ls_range = "L" + String(ll_total_line2) + ":" + "L" + String(ll_total_line2)
lole_Sheet.Range(ls_range).Select
lole_OLE.Selection.Font.Bold = True

//--------

//Delete extra columns
lole_Sheet.columns("T:W").Delete

//Justify
//lole_OLE.Selection.HorizontalAlignment = -4108 //Center
//lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
//lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

lole_Sheet.Range("A3:H" + String(ll_report_rows + 6)).Select
lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify

lole_Sheet.Range("I3:J" + String(ll_report_rows + 6)).Select
lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

lole_Sheet.Range("K3:K" + String(ll_report_rows + 6)).Select
lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify

lole_Sheet.Range("L3:N" + String(ll_report_rows + 6)).Select
lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

lole_Sheet.Range("O3:O" + String(ll_report_rows + 6)).Select
lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify

lole_Sheet.Range("P3:P" + String(ll_report_rows + 6)).Select
lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

lole_Sheet.Range("Q3:S" + String(ll_report_rows + 6)).Select
lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify

//Underline column headers
lole_Sheet.Range("A4:S4").Select
lole_OLE.Selection.Font.Underline = True

//Change date format for a column
lole_Sheet.Range("K5:K" + String(ll_report_rows + 6)).Select
lole_OLE.Selection.NumberFormat = "mm/dd/yyyy"

//Increase column width
lole_Sheet.Range("A5:S" + String(ll_report_rows + 6)).Select
lole_OLE.Selection.ColumnWidth = 18.9

//Save the changes
SetPointer(HourGlass!)
ld_today = Today()
ld_now = Now()
ls_today = String(ld_today,"yymmdd")
ls_now = String(ld_now,"hhmmss")

//ls_folder = ProfileString(gs_ini_file, "EMAIL","email_out","c:\temp\")
If Right(ls_folder, 1) <> "\" Then ls_folder = ls_folder + "\"

ls_file = ls_folder + ls_report_name + ".xls"
//ls_file = ls_folder + "\" + ls_report_name + ".csv"

//Check if ls_folder exists.
lb_directoryexists = DirectoryExists(ls_folder)

If Not lb_directoryexists Then //Folder ls_folder doesn't exist
	CreateDirectory(ls_folder) //Create ls_folder
End If

lb_fileexists = FileExists(ls_file)

If lb_fileexists Then
	lb_rtn_delete = FileDelete(ls_file)
End If

lole_sheet.SaveAs(ls_file, Excel8!)
//lole_sheet.SaveAs(ls_file, CSV!)

//---

lole_OLE.Application.quit()
lole_OLE.DisconnectObject()

DESTROY lole_OLE

GarbageCollect()



end subroutine

public subroutine create_excel_ole ();iole_OLE = CREATE OleObject

SetPointer( HourGlass! )

iole_OLE.ConnectToNewObject( 'excel.application' )
iole_OLE.Workbooks.Add
iole_sheet = iole_OLE.Application.ActiveWorkbook.WorkSheets[1]
end subroutine

public subroutine destroy_excel_ole ();iole_OLE.Application.quit()
iole_OLE.DisconnectObject()

DESTROY iole_OLE

Garbagecollect()
end subroutine

public subroutine excel_open_csv_saveas_xls (string as_folder, string as_report_name);/* 
Function:	excel_open_csv_saveas_xls
Returns:		none
Arguments:	value		string		as_folder
				value		string		as_report_name 	<== Report file name

*/

// Export the data to Excel
OleObject 	lole_OLE, lole_Sheet
Boolean		lb_rtn, lb_directoryexists, lb_fileexists, lb_rtn_delete

String 		ls_file
Integer		li_rtn
String		ls_report_name, ls_received_date, ls_status, ls_gauge, ls_width
Long			ll_start_row = 1

SetPointer( HourGlass! )

//Replace "xls" with "csv"
as_report_name = Left(as_report_name, Len(as_report_name) - 3) + "csv"

ls_file = as_folder + "\" + as_report_name

MessageBox("excel_open_csv_saveas_xls for nv_test", "ls_file = " + ls_file)

lole_OLE = CREATE OleObject
li_rtn = lole_OLE.ConnectToNewObject('excel.application')

If li_rtn = 0 Then
	lole_OLE.Application.DisplayAlerts = "False"
	lole_OLE.Workbooks.Open(ls_file)
	lole_OLE.Visible=FALSE
	
	FileDelete(ls_file)
	lole_OLE.ActiveWorkbook.SaveAs(ls_file, 56) //56 means excel8 <== xls
	lole_OLE.Application.DisplayAlerts = "False"
End If

lole_OLE.Application.quit()
lole_OLE.DisconnectObject()

DESTROY lole_OLE

GarbageCollect()



end subroutine

public subroutine exporttoexcel_scrap (datastore adw_dw, long al_rows, string as_folder, string as_report_name, string as_report_header);//Alex Gerlants. 05/02/2016. Begin
/*
Function:	exporttoexcel_scrap
Returns:		none
Arguments:	value		datastore	adw_dw
				value		long			al_rows	
				value		string		as_folder
				value		string		as_report_name 	<== Report file name
				value		string		as_report_header	<== Report header	

*/

// Export the data to Excel
OleObject 	lole_OLE, lole_Sheet
String 		ls_Columns[]
Long 			ll_report_rows, ll_Row, ll_Col, ll_Cols, ll_total_line1, ll_total_line2
String		ls_range, ls_total_skid, ls_total_Net_wt
Boolean		lb_rtn, lb_directoryexists, lb_fileexists, lb_rtn_delete

String 		ls_file, ls_today, ls_now, ls_folder
Date 			ld_today
Time 			ld_now
Integer		li_answer, li_count

ll_report_rows = adw_dw.RowCount()

If ll_report_rows > 0 Then
	//Get report totals
	If adw_dw.DataObject = "d_report_inv_abc_scrap_skids" Then
		ls_total_skid = String(adw_dw.Object.compute_3[1])
		ls_total_Net_wt = String(adw_dw.Object.compute_2[1])
	Else
		ls_total_skid = String(adw_dw.Object.compute_2[1])
		ls_total_Net_wt = String(adw_dw.Object.compute_3[1])
	End If
Else
	Return
End If

lole_OLE = CREATE OleObject

SetPointer( HourGlass! )

lole_OLE.ConnectToNewObject( 'excel.application' )
lole_OLE.Workbooks.Add
lole_sheet = lole_OLE.Application.ActiveWorkbook.WorkSheets[1]

This.GetColumns( adw_dw, ls_Columns )
ll_Cols = UpperBound( ls_Columns )
FOR ll_col = 1 TO ll_cols
	lole_Sheet.Cells[ 1, ll_Col ] = ls_Columns[ ll_Col ]
NEXT

FOR ll_Row = 2 TO al_rows + 1
	FOR ll_Col = 1 TO ll_cols
		lole_Sheet.Cells[ ll_Row, ll_Col ] = &
		This.GetData( adw_DW, ll_Row - 1, ls_Columns[ ll_Col ] )
	NEXT
NEXT

lole_Sheet.Range( inttocolumn( 1 ) + "1:" + inttocolumn( ll_Cols ) + "1").Select
lole_OLE.Selection.Font.Bold = True

lole_Sheet.Range("A1:A1").Select
lole_Sheet.Columns( inttocolumn( 1 ) + ":" + inttocolumn( ll_cols ) ).EntireColumn.AutoFit


//Column Headings
If adw_dw.DataObject = "d_report_inv_abc_scrap_skids" Then
	lole_OLE.cells[1,1]  = "Skid #"
	lole_OLE.cells[1,2]  = "Customer"
	lole_OLE.cells[1,3]  = "Scrap Handling"
	lole_OLE.cells[1,4]  = "Scrap Type"
	lole_OLE.cells[1,5]  = "Scrap Ref"
	lole_OLE.cells[1,6]  = "Net WT"
	lole_OLE.cells[1,7]  = "Tare"
	lole_OLE.cells[1,8]  = "Status"
	lole_OLE.cells[1,9] = "Skid Job"
	lole_OLE.cells[1,10]  = "Alloy"
	lole_OLE.cells[1,11]  = "Temp"
	lole_OLE.cells[1,12] = "Skid Date"
	lole_OLE.cells[1,13] = "Duration"
	lole_OLE.cells[1,14] = "Item NetWT"
	lole_OLE.cells[1,15] = "Item Job"
	lole_OLE.cells[1,16] = "Item Date"
Else
	lole_OLE.cells[1,1]  = "Skid #"
	lole_OLE.cells[1,2]  = "Scrap Handling"
	lole_OLE.cells[1,3]  = "Scrap Type"
	lole_OLE.cells[1,4]  = "Scrap Ref"
	lole_OLE.cells[1,5]  = "Net WT"
	lole_OLE.cells[1,6]  = "Tare"
	lole_OLE.cells[1,7]  = "Status"
	lole_OLE.cells[1,8] = "Skid Job"
	lole_OLE.cells[1,9]  = "Alloy"
	lole_OLE.cells[1,10]  = "Temp"
	lole_OLE.cells[1,11] = "Skid Date"
	lole_OLE.cells[1,12] = "Duration"
	lole_OLE.cells[1,13] = "Item NetWT"
	lole_OLE.cells[1,14] = "Item Job"
	lole_OLE.cells[1,15] = "Item Date"
End If

//Insert Lines for Header & Miscellaneous Details (3 lines above columnar data)
lole_Sheet.Range("A1:Q3").Select
lole_Sheet.Application.Selection.EntireRow.Insert 

//Change font size for report title
lole_OLE.cells[1,6] = as_report_header
lole_Sheet.Range("F1:F1").Select
lole_OLE.Selection.Font.Bold = True
lole_OLE.Selection.Font.Size = 24
lole_OLE.Selection.Font.Underline = True

//Underline column headers
If adw_dw.DataObject = "d_report_inv_abc_scrap_skids" Then
	lole_Sheet.Range("A4:P4").Select
	lole_OLE.Selection.Font.Underline = True
Else
	lole_Sheet.Range("A4:O4").Select
	lole_OLE.Selection.Font.Underline = True
End If

//Change date format for current date
If adw_dw.DataObject = "d_report_inv_abc_scrap_skids" Then
	lole_OLE.cells[1,16] = String(Today(), "mm/dd/yyyy")
	lole_Sheet.Range("P1:P1").Select
	lole_OLE.Selection.Font.Bold = True
Else
	lole_OLE.cells[1,15] = String(Today(), "mm/dd/yyyy")
	lole_Sheet.Range("O1:O1").Select
	lole_OLE.Selection.Font.Bold = True
End If

//Format date columns
If adw_dw.DataObject = "d_report_inv_abc_scrap_skids" Then
	lole_Sheet.Range("L3:L" + String(ll_report_rows + 4)).Select
	lole_OLE.Selection.NumberFormat = "mm/dd/yyyy"
	
	lole_Sheet.Range("P3:P" + String(ll_report_rows + 4)).Select
	lole_OLE.Selection.NumberFormat = "mm/dd/yyyy"
Else
	lole_Sheet.Range("K3:K" + String(ll_report_rows + 4)).Select
	lole_OLE.Selection.NumberFormat = "mm/dd/yyyy"
	
	lole_Sheet.Range("O3:O" + String(ll_report_rows + 4)).Select
	lole_OLE.Selection.NumberFormat = "mm/dd/yyyy"
End If

//Bold report arguments row
lole_OLE.cells[2,6] = "Skid Created Date: " + "All"
lole_Sheet.Range("F2:F2").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[2,9] = "Status: " + "All"
lole_Sheet.Range("I2:I2").Select
lole_OLE.Selection.Font.Bold = True

//Make some columns italics
If adw_dw.DataObject = "d_report_inv_abc_scrap_skids" Then
	lole_Sheet.Range("M2:P" + String(ll_report_rows + 5)).Select
	lole_OLE.Selection.Font.Italic = True
Else
	lole_Sheet.Range("L2:O" + String(ll_report_rows + 5)).Select
	lole_OLE.Selection.Font.Italic = True
End If



//---

ll_total_line1 = ll_report_rows + 5
ll_total_line2 = ll_report_rows + 6

//Insert 2 lines for totals (below columnar data)
ls_range = "A" + String(ll_total_line1) + ":" + "N" + String(ll_total_line1)
lole_Sheet.Range(ls_range).Select
lole_Sheet.Application.Selection.EntireRow.Insert

//Insert totals
//ls_total_skid, ls_total_Net_wt
If adw_dw.DataObject = "d_report_inv_abc_scrap_skids" Then
	lole_OLE.cells[ll_total_line1,8] = "----------------"
	ls_range = "H" + String(ll_total_line1) + ":" + "H" + String(ll_total_line1)
	lole_Sheet.Range(ls_range).Select
	//lole_OLE.Selection.Font.Bold = True
	lole_OLE.Selection.Font.FontStyle = "Bold"
	
	lole_OLE.cells[ll_total_line2,8] = "Total Skids: " + ls_total_skid
	ls_range = "H" + String(ll_total_line2) + ":" + "H" + String(ll_total_line2)
	lole_Sheet.Range(ls_range).Select
	//lole_OLE.Selection.Font.Bold = True
	lole_OLE.Selection.Font.FontStyle = "Bold" //Another way to bold a cell
	
	lole_OLE.cells[ll_total_line1,13] = "----------------"
	ls_range = "M" + String(ll_total_line1) + ":" + "M" + String(ll_total_line1)
	lole_Sheet.Range(ls_range).Select
	//lole_OLE.Selection.Font.Bold = True
	lole_OLE.Selection.Font.FontStyle = "Bold"
	
	lole_OLE.cells[ll_total_line2,13] = "Total Net Wt: " + ls_total_Net_wt
	ls_range = "M" + String(ll_total_line2) + ":" + "M" + String(ll_total_line2)
	lole_Sheet.Range(ls_range).Select
	//lole_OLE.Selection.Font.Bold = True
	lole_OLE.Selection.Font.FontStyle = "Bold" //Another way to bold a cell
Else
	lole_OLE.cells[ll_total_line1,7] = "----------------"
	ls_range = "G" + String(ll_total_line1) + ":" + "G" + String(ll_total_line1)
	lole_Sheet.Range(ls_range).Select
	//lole_OLE.Selection.Font.Bold = True
	lole_OLE.Selection.Font.FontStyle = "Bold"
	
	lole_OLE.cells[ll_total_line2,7] = "Total Skids: " + ls_total_skid
	ls_range = "G" + String(ll_total_line2) + ":" + "G" + String(ll_total_line2)
	lole_Sheet.Range(ls_range).Select
	//lole_OLE.Selection.Font.Bold = True
	lole_OLE.Selection.Font.FontStyle = "Bold" //Another way to bold a cell
	
	lole_OLE.cells[ll_total_line1,13] = "----------------"
	ls_range = "M" + String(ll_total_line1) + ":" + "M" + String(ll_total_line1)
	lole_Sheet.Range(ls_range).Select
	//lole_OLE.Selection.Font.Bold = True
	lole_OLE.Selection.Font.FontStyle = "Bold"
	
	lole_OLE.cells[ll_total_line2,13] = "Total Net Wt: " + ls_total_Net_wt
	ls_range = "M" + String(ll_total_line2) + ":" + "M" + String(ll_total_line2)
	lole_Sheet.Range(ls_range).Select
	//lole_OLE.Selection.Font.Bold = True
	lole_OLE.Selection.Font.FontStyle = "Bold" //Another way to bold a cell
End If

//Delete extra columns	
If adw_dw.DataObject = "d_report_inv_abc_scrap_skids" Then
	lole_Sheet.columns("Q:T").Delete
	//lole_Sheet.columns("O:T").Delete
Else
	lole_Sheet.columns("P:T").Delete
End If

//Justify
//lole_OLE.Selection.HorizontalAlignment = -4108 //Center
//lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
//lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

If adw_dw.DataObject = "d_report_inv_abc_scrap_skids" Then
	lole_Sheet.Range("A3:D" + String(ll_report_rows + 6)).Select
	lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
	
	lole_Sheet.Range("E3:F" + String(ll_report_rows + 6)).Select
	lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify
	
	lole_Sheet.Range("G3:K" + String(ll_report_rows + 6)).Select
	lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
	
	lole_Sheet.Range("L3:N" + String(ll_report_rows + 6)).Select
	lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify
	
	lole_Sheet.Range("M3:M" + String(ll_report_rows + 6)).Select
	lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify
	
	lole_Sheet.Range("O3:O" + String(ll_report_rows + 6)).Select
	lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
	
	lole_Sheet.Range("P3:P" + String(ll_report_rows + 6)).Select
	lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
	
Else //Selecting for one customer
	lole_Sheet.Range("A3:C" + String(ll_report_rows + 6)).Select
	lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
	
	lole_Sheet.Range("D3:E" + String(ll_report_rows + 6)).Select
	lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify
	
	lole_Sheet.Range("F3:J" + String(ll_report_rows + 6)).Select
	lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
	
	lole_Sheet.Range("K3:L" + String(ll_report_rows + 6)).Select
	lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify
	
	lole_Sheet.Range("M3:M" + String(ll_report_rows + 6)).Select
	lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify
	
	lole_Sheet.Range("N3:N" + String(ll_report_rows + 6)).Select
	lole_OLE.Selection.HorizontalAlignment = -4131 //Right justify
	
	lole_Sheet.Range("O3:O" + String(ll_report_rows + 6)).Select
	lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
End If

//Increase column width
lole_Sheet.Range("A3:S" + String(ll_report_rows + 6)).Select
lole_OLE.Selection.ColumnWidth = 18.9

//---

//Save the changes
SetPointer(HourGlass!)
ld_today = Today()
ld_now = Now()
ls_today = String(ld_today,"yymmdd")
ls_now = String(ld_now,"hhmmss")

ls_folder = as_folder
If Right(ls_folder, 1) <> "\" Then ls_folder = ls_folder + "\"

ls_file = ls_folder + as_report_name + ".xls"

//Check if ls_folder exists.
lb_directoryexists = DirectoryExists(ls_folder)

If Not lb_directoryexists Then //Folder ls_folder doesn't exist
	CreateDirectory(ls_folder) //Create ls_folder
End If

lb_fileexists = FileExists(ls_file)

If lb_fileexists Then
	lb_rtn_delete = FileDelete(ls_file)
End If

lole_sheet.SaveAs(ls_file, Excel8!)

////Open the worksheet for user to veiw and save
//li_answer = MessageBox("Open Worksheet?", "Would you like to open worksheet " + ls_file + "?", Question!, YesNo!, 1)
//
//If li_answer = 1 Then //Yes
//	lole_OLE.Application.Visible = True
//Else
//	lole_OLE.Application.Visible = False
//End If

lole_OLE.Application.quit()
lole_OLE.DisconnectObject()

DESTROY lole_OLE

GarbageCollect()
//Alex Gerlants. 05/02/2016. End
end subroutine

protected subroutine excel_open_xls_saveas_csv (string as_folder, string as_report_name);/* 
Function:	excel_open_xls_saveas_csv
Returns:		none
Arguments:	value		string		as_folder
				value		string		as_report_name 	<== Report file name

*/

// Export the data to Excel
OleObject 	lole_OLE, lole_Sheet
String 		ls_Columns[]
Long 			ll_report_rows, ll_Row, ll_Col, ll_Cols, ll_total_line1, ll_total_line2
String		ls_range, ls_total_coil_orig_net_wt, ls_total_coil_current_net_wt_balance, ls_total_coil_count
Boolean		lb_rtn, lb_directoryexists, lb_fileexists, lb_rtn_delete

String 		ls_file_in, ls_file_out, ls_today, ls_now, ls_folder
Date 			ld_today
Time 			ld_now
Integer		li_rtn

String		ls_report_name, ls_received_date, ls_status, ls_gauge, ls_width
Long			ll_start_row = 1

SetPointer( HourGlass! )

If Right(as_folder, 1) <> "\" Then as_folder = as_folder + "\"

ls_file_in = as_folder + as_report_name + ".xls"

lole_OLE = CREATE OleObject
li_rtn = lole_OLE.ConnectToNewObject('excel.application')

If li_rtn = 0 Then
	lole_OLE.Application.DisplayAlerts = "False"
	lole_OLE.Workbooks.Open(ls_file_in)
	lole_OLE.Visible=FALSE
	
	ls_file_out = Left(ls_file_in, Len(ls_file_in) -3) + "csv"
	
	FileDelete(ls_file_out) //Delete CSV if any are there
	
	lole_OLE.ActiveWorkbook.SaveAs(ls_file_out, 6) //csv
	lole_OLE.Application.DisplayAlerts = "False"
	
	FileDelete(ls_file_in) //Delete XLS
End If

lole_OLE.Application.quit()
lole_OLE.DisconnectObject()

DESTROY lole_OLE

Garbagecollect()



end subroutine

public subroutine exporttoexcel_skids (datastore adw_dw, long al_rows, string as_folder, string as_report_name, string as_report_header);//Alex Gerlants. 05/02/2016. Begin
/*
Function:	exporttoexcel
Returns:		none
Arguments:	value		datastore	adw_dw
				value		long			al_rows	
				value		string		as_folder
				value		string		as_report_name 	<== Report file name
				value		string		as_report_header	<== Report header	

*/

// Export the data to Excel
OleObject 	lole_OLE, lole_Sheet
String 		ls_Columns[]
Long 			ll_report_rows, ll_Row, ll_Col, ll_Cols, ll_total_line1, ll_total_line2
String		ls_range, ls_total_prod_item_net_wt
Boolean		lb_rtn, lb_directoryexists, lb_fileexists, lb_rtn_delete

String 		ls_file, ls_today, ls_now, ls_folder
Date 			ld_today
Time 			ld_now
Integer		li_answer, li_count

ll_report_rows = adw_dw.RowCount()

If ll_report_rows > 0 Then
	//Get report totals
	ls_total_prod_item_net_wt = String(adw_dw.Object.compute_2[1])
Else
	Return
End If

lole_OLE = CREATE OleObject

SetPointer( HourGlass! )

lole_OLE.ConnectToNewObject( 'excel.application' )
lole_OLE.Workbooks.Add
lole_sheet = lole_OLE.Application.ActiveWorkbook.WorkSheets[1]

this.GetColumns( adw_DW, ls_Columns )
ll_Cols = UpperBound( ls_Columns )
FOR ll_col = 1 TO ll_cols
	lole_Sheet.Cells[ 1, ll_Col ] = ls_Columns[ ll_Col ]
NEXT

FOR ll_Row = 2 TO al_rows + 1
	FOR ll_Col = 1 TO ll_cols
		lole_Sheet.Cells[ ll_Row, ll_Col ] = &
		this.GetData( adw_DW, ll_Row - 1, ls_Columns[ ll_Col ] )
	NEXT
NEXT

lole_Sheet.Range( inttocolumn( 1 ) + "1:" + inttocolumn( ll_Cols ) + "1").Select
lole_OLE.Selection.Font.Bold = True

lole_Sheet.Range("A1:A1").Select
lole_Sheet.Columns( inttocolumn( 1 ) + ":" + inttocolumn( ll_cols ) ).EntireColumn.AutoFit


//Column Headings
lole_OLE.cells[1,1]  = "Skid #"
lole_OLE.cells[1,2]  = "End User"
lole_OLE.cells[1,3]  = "Ab Job"
lole_OLE.cells[1,4]  = "EndUser Part #"
lole_OLE.cells[1,5]  = "Pieces"
lole_OLE.cells[1,6]  = "Net Wt."
lole_OLE.cells[1,7]  = "Status"
lole_OLE.cells[1,8]  = "Coil Orig #"
lole_OLE.cells[1,9]  = "Spec"
lole_OLE.cells[1,10] = "Material"
lole_OLE.cells[1,11] = "Lot #"
lole_OLE.cells[1,12] = "Item PCs"
lole_OLE.cells[1,13] = "NonConf."
lole_OLE.cells[1,14] = "Item NetWT"
lole_OLE.cells[1,15] = "Duration"

If adw_dw.DataObject = "d_report_inv_cust_skids_pn" Then
	lole_OLE.cells[1,16] = "Package No"
End If

//Insert Lines for Header & Miscellaneous Details (3 lines above columnar data)
lole_Sheet.Range("A1:Q3").Select
lole_Sheet.Application.Selection.EntireRow.Insert 

//Change font size for report title
lole_OLE.cells[1,6] = as_report_header
lole_Sheet.Range("F1:F1").Select
lole_OLE.Selection.Font.Bold = True
lole_OLE.Selection.Font.Size = 24
lole_OLE.Selection.Font.Underline = True

//Change date format for current date
lole_OLE.cells[1,14] = String(Today(), "mm/dd/yyyy")
lole_Sheet.Range("N1:N1").Select
lole_OLE.Selection.Font.Bold = True

//Bold report arguments row
lole_OLE.cells[2,3] = "End User: " + "All"
lole_Sheet.Range("C2:C2").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[2,8] = "Status: " + "All"
lole_Sheet.Range("H2:H2").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[2,10] = "Created Date: " + "All"
lole_Sheet.Range("J2:J2").Select
lole_OLE.Selection.Font.Bold = True

//---

ll_total_line1 = ll_report_rows + 5
ll_total_line2 = ll_report_rows + 6

//Insert 2 lines for totals (below columnar data)
ls_range = "A" + String(ll_total_line1) + ":" + "N" + String(ll_total_line1)
lole_Sheet.Range(ls_range).Select
lole_Sheet.Application.Selection.EntireRow.Insert

//Insert totals
lole_OLE.cells[ll_total_line1,5] = "----------------"
ls_range = "E" + String(ll_total_line1) + ":" + "E" + String(ll_total_line1)
lole_Sheet.Range(ls_range).Select
//lole_OLE.Selection.Font.Bold = True
lole_OLE.Selection.Font.FontStyle = "Bold"

lole_OLE.cells[ll_total_line2,5] = "Total: " + ls_total_prod_item_net_wt
ls_range = "E" + String(ll_total_line2) + ":" + "E" + String(ll_total_line2)
lole_Sheet.Range(ls_range).Select
//lole_OLE.Selection.Font.Bold = True
lole_OLE.Selection.Font.FontStyle = "Bold" //Another way to bold a cell

//lole_OLE.cells[ll_total_line2,6] = ls_total_prod_item_net_wt
//ls_range = "D" + String(ll_total_line2) + ":" + "D" + String(ll_total_line2)
//lole_Sheet.Range(ls_range).Select
//lole_OLE.Selection.Font.Bold = True
//lole_OLE.Selection.Font.FontStyle = "Bold" //Another way to bold a cell

//Delete extra columns	
If adw_dw.DataObject = "d_report_inv_cust_skids_pn" Then //Alex Gerlants. 06/15/2018. Arconic_Package_Num
	lole_Sheet.columns("Q:X").Delete //Alex Gerlants. 06/15/2018. Arconic_Package_Num
Else //Alex Gerlants. 06/15/2018. Arconic_Package_Num
	lole_Sheet.columns("P:W").Delete
End If //Alex Gerlants. 06/15/2018. Arconic_Package_Num

//Justify
//lole_OLE.Selection.HorizontalAlignment = -4108 //Center
//lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
//lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

lole_Sheet.Range("A3:C" + String(ll_report_rows + 6)).Select
lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify

lole_Sheet.Range("D3:E" + String(ll_report_rows + 6)).Select
lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

lole_Sheet.Range("F3:J" + String(ll_report_rows + 6)).Select
lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify

lole_Sheet.Range("K3:L" + String(ll_report_rows + 6)).Select
lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

lole_Sheet.Range("M3:M" + String(ll_report_rows + 6)).Select
lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify

lole_Sheet.Range("N3:N" + String(ll_report_rows + 6)).Select
lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

//Underline column headers
lole_Sheet.Range("A4:O4").Select
lole_OLE.Selection.Font.Underline = True

//---

//Save the changes
SetPointer(HourGlass!)
ld_today = Today()
ld_now = Now()
ls_today = String(ld_today,"yymmdd")
ls_now = String(ld_now,"hhmmss")

ls_folder = as_folder
If Right(ls_folder, 1) <> "\" Then ls_folder = ls_folder + "\"

//ls_file = ls_folder + "Customer Skid Inventory Report" + "_" + ls_today + ls_now + ".xls"
ls_file = ls_folder + as_report_name + ".xls"

//Check if ls_folder exists.
lb_directoryexists = DirectoryExists(ls_folder)

If Not lb_directoryexists Then //Folder ls_folder doesn't exist
	CreateDirectory(ls_folder) //Create ls_folder
End If

lb_fileexists = FileExists(ls_file)

If lb_fileexists Then
	lb_rtn_delete = FileDelete(ls_file)
End If

lole_sheet.SaveAs(ls_file, Excel8!)

////Open the worksheet for user to veiw and save
//li_answer = MessageBox("Open Worksheet?", "Would you like to open worksheet " + ls_file + "?", Question!, YesNo!, 1)
//
//If li_answer = 1 Then //Yes
//	lole_OLE.Application.Visible = True
//Else
//	lole_OLE.Application.Visible = False
//End If

lole_OLE.Application.quit()
lole_OLE.DisconnectObject()

DESTROY lole_OLE

GarbageCollect()
//Alex Gerlants. 05/02/2016. End
end subroutine

public subroutine of_set_work_folder (string as_work_folder);is_work_folder = as_work_folder
end subroutine

public function integer of_report_inv_cust_coils (long al_customer_id[], string as_customer_short_name, string as_filetype_2create);/*
******************************************** Install ************************************************

P:\Dev\Install\PDF Printer\Setup_BullzipPDFPrinter_10_25_0_2552_PRO_EXP.exe. Then rename to "PDFPrinter"
P:\Dev\Install\ghostscript\gs920w32.exe
P:\Dev\Install\PdfTK\pdftk_free-2.02-win-setup.exe
P:\Dev\Install\PSTools\pskill.exe

c:\abis\combpdf.bat
c:\abis\taskkill.bat

Add to system path:
		C:\Program Files\gs\gs9.20\bin 				<== Windows XP
		C:\Program Files (x86)\gs\gs9.20\bin 		<== Windows 7

******************************************** Install ************************************************
*/

/*
Function:	of_report_inv_cust_coils
Returns:		integer
Arguments:	value	long		al_customer_id[]
				value	string	as_customer_short_name
				value	string	as_filetype_2create
*/


Boolean		lb_report_4multiple_customers //Alex Gerlants. 06/08/2017
DataStore	lds_report_inv_cust_coils
String		ls_sql_orig, ls_sql_new, ls_add, ls_report_folder, ls_report_name, ls_today, ls_now
String		ls_modstring, ls_rtn, ls_report_header
String		ls_pdf_method, ls_custompostscript
String		ls_customer_name, ls_customer_id, ls_title,ls_title_save
String		ls_sql_orig_part_1, ls_sql_orig_part_2, ls_string_2add //Alex Gerlants. 06/08/2017
DateTime		ldt_add_from, ldt_add_to
Date			ld_from, ld_to
Long			ll_rtn, ll_rows, ll_customer_id[], ll_customer_id_temp, ll_i, ll_counter = 0
Long			ll_pos_union_all //Alex Gerlants. 06/08/2017
Integer		li_rtn, li_rtn_setsqlselect, li_rtn_saveas

SetPointer(HourGlass!)
ib_coils_done = False

ll_customer_id[] = al_customer_id[]

//Alex Gerlants. 10/03/2017. Begin
li_rtn = of_unmatched_coils(ll_customer_id[])

If li_rtn = -1 Then Return li_rtn //Unmatched coils found, or DB error in of_unmatched_coils()
//Alex Gerlants. 10/03/2017. End

If Not sqlca.of_isconnected() Then
	sqlca.of_connect()
End If

//Alex Gerlants. 06/08/2017. Begin
lb_report_4multiple_customers = False

If ll_customer_id[1] = -99 Then
	lb_report_4multiple_customers = True
Else
	//
End If

If lb_report_4multiple_customers Then
	If IsValid(lds_report_inv_cust_coils) Then Destroy lds_report_inv_cust_coils
	lds_report_inv_cust_coils = Create DataStore
	lds_report_inv_cust_coils.DataObject = "d_report_inv_cust_coils_name"
	li_rtn = lds_report_inv_cust_coils.SetTransObject(sqlca)
	
	ls_sql_orig = lds_report_inv_cust_coils.GetSqlSelect()
	
	If ls_sql_orig <> "" Then
		ll_pos_union_all = Pos(ls_sql_orig, "union all", 1)
		
		If ll_pos_union_all > 0 Then
			ls_sql_orig_part_1 = Left(ls_sql_orig, ll_pos_union_all - 8)
			ls_sql_orig_part_2 = Right(ls_sql_orig, Len(ls_sql_orig) - ll_pos_union_all - 14)
			ls_sql_orig_part_2 = Left(ls_sql_orig_part_2, Len(ls_sql_orig_part_2) - 1)
			
			ls_string_2add = " ~r~n and ( coil.customer_id in (select customer_id from customer where lower(customer_short_name) like lower('%" + as_customer_short_name + "%'))))"
			
			ls_sql_orig_part_1 = ls_sql_orig_part_1 + ls_string_2add
			ls_sql_orig_part_2 = ls_sql_orig_part_2 + ls_string_2add
			
			ls_sql_new = ls_sql_orig_part_1 + "~r~n union all ~r~n" + ls_sql_orig_part_2
			li_rtn_setsqlselect = lds_report_inv_cust_coils.SetSqlSelect(ls_sql_new)
			
			li_rtn = lds_report_inv_cust_coils.SetTransObject(sqlca)
			
			ll_rows = lds_report_inv_cust_coils.Retrieve()
		
			If ll_rows > 0 Then
				of_remove_duplicate_coils(lds_report_inv_cust_coils) //Alex Gerlants. 09/18/2017
				
				//Sort
				lds_report_inv_cust_coils.SetSort("coil_coil_status A, coil_coil_gauge A, coil_coil_width A")
				lds_report_inv_cust_coils.Sort()
				
				//Update title date
				ls_modstring = "date_t.Text = 'All'"
				ls_rtn = lds_report_inv_cust_coils.Modify(ls_modstring)
				
				//Update customer name in report title
				ls_title = lds_report_inv_cust_coils.Describe("title_t.Text")
				ls_customer_name = Upper(as_customer_short_name)
				ls_title = ls_customer_name + " " + ls_title
				ls_modstring = "title_t.Text = '" + ls_title + "'"
				ls_rtn = lds_report_inv_cust_coils.Modify(ls_modstring)
				
				//status_t
				ls_modstring = "status_t.Text = ~"" + "All" + "~""
				ls_rtn = lds_report_inv_cust_coils.Modify(ls_modstring)
				
				//gauge_t
				ls_modstring = "gauge_t.Text = ~"" + "All" + "~""
				ls_rtn = lds_report_inv_cust_coils.Modify(ls_modstring)
				
				//width_t
				ls_modstring = "width_t.Text = ~"" + "All" + "~""
				ls_rtn = lds_report_inv_cust_coils.Modify(ls_modstring)
			
				ls_report_folder = is_work_folder
				
				If Lower(as_filetype_2create) = "pdf" Then
					ls_report_name = "Coils1" + ".pdf"
				ElseIf Lower(as_filetype_2create) = "xls" Then
					ls_report_name = "Coils1"
				End If
				
				If Lower(as_filetype_2create) = "pdf" Then
					of_update_data_export(lds_report_inv_cust_coils)
				End If
				
				If Lower(as_filetype_2create) = "pdf" Then
					li_rtn_saveas = of_saveas(lds_report_inv_cust_coils, ls_report_folder, ls_report_name, "pdf", True)
				ElseIf Lower(as_filetype_2create) = "xls" Then
		
					ls_report_header = ls_customer_name + " " + "Coil Inventory Report"
					
					exporttoexcel_coils(lds_report_inv_cust_coils, ll_rows, ls_report_folder, ls_report_name, ls_report_header)
					
					excel_open_xls_saveas_csv(ls_report_folder, ls_report_name)
				End If
			End if
		End If
	Else
		Return -1
	End If
Else
//Alex Gerlants. 06/08/2017. End

	If IsValid(lds_report_inv_cust_coils) Then Destroy lds_report_inv_cust_coils
	lds_report_inv_cust_coils = Create DataStore
	lds_report_inv_cust_coils.DataObject = "d_report_inv_cust_coils"
	li_rtn = lds_report_inv_cust_coils.SetTransObject(sqlca)
	
	ls_today = String(Today(),"mmddyyyy")
	ls_today = Left(ls_today, 2) + "/" + Mid(ls_today, 3, 2) + "/" + Right(ls_today, 2)
	ls_now = String(Now(),"hhmmss")
	
	ldt_add_from = DateTime(Date("01/01/1980"), Time("00:00:00"))
	ldt_add_to = DateTime(Date("12/31/2050"), Time("23:59:59"))
	
	ld_from = Date("01/01/1980")
	ld_to = Date("12/31/2050")
	
	li_rtn = lds_report_inv_cust_coils.SetTransObject(sqlca)
	
	For ll_i = 1 To UpperBound(ll_customer_id[])
		
		ll_customer_id_temp = ll_customer_id[ll_i]
	
		lds_report_inv_cust_coils.Reset()
		ll_rows = lds_report_inv_cust_coils.Retrieve(ll_customer_id_temp, ldt_add_from, ldt_add_to)
		
		If ll_rows > 0 Then
			of_remove_duplicate_coils(lds_report_inv_cust_coils) //Alex Gerlants. 09/18/2017
			
			ll_counter++
			
			//Sort
			lds_report_inv_cust_coils.SetSort("coil_coil_status A, coil_coil_gauge A, coil_coil_width A")
			lds_report_inv_cust_coils.Sort()
			
			//Update title date
			ls_modstring = "date_t.Text = 'All'"
			ls_rtn = lds_report_inv_cust_coils.Modify(ls_modstring)
			
			//Save title_t
			ls_title = lds_report_inv_cust_coils.Describe("title_t.Text")
			ls_title_save = ls_title
			
			ls_customer_name = of_get_customer_name(ll_customer_id_temp)
			
			//Update customer name in report title
			ls_title = ls_customer_name + ls_title
			ls_modstring = "title_t.Text = '" + ls_title + "'"
			ls_rtn = lds_report_inv_cust_coils.Modify(ls_modstring)
			
			//status_t
			ls_modstring = "status_t.Text = ~"" + "All" + "~""
			ls_rtn = lds_report_inv_cust_coils.Modify(ls_modstring)
			
			//gauge_t
			ls_modstring = "gauge_t.Text = ~"" + "All" + "~""
			ls_rtn = lds_report_inv_cust_coils.Modify(ls_modstring)
			
			//width_t
			ls_modstring = "width_t.Text = ~"" + "All" + "~""
			ls_rtn = lds_report_inv_cust_coils.Modify(ls_modstring)
		
			ls_report_folder = is_work_folder
			
			If Lower(as_filetype_2create) = "pdf" Then
				ls_report_name = "Coils" + String(ll_counter) + ".pdf"
			ElseIf Lower(as_filetype_2create) = "xls" Then
				//ls_report_name = "Coils" + String(ll_i) + ".xls"
				ls_report_name = "Coils" + String(ll_counter)
			End If
			
			If Lower(as_filetype_2create) = "pdf" Then
				of_update_data_export(lds_report_inv_cust_coils)
			End If
			
			If Lower(as_filetype_2create) = "pdf" Then
				li_rtn_saveas = of_saveas(lds_report_inv_cust_coils, ls_report_folder, ls_report_name, "pdf", True)
			ElseIf Lower(as_filetype_2create) = "xls" Then
	
				ls_report_header = ls_customer_name + " " + "Coil Inventory Report"
				
				exporttoexcel_coils(lds_report_inv_cust_coils, ll_rows, ls_report_folder, ls_report_name, ls_report_header)
				
				excel_open_xls_saveas_csv(ls_report_folder, ls_report_name)
			End If
			
			//Reinstate report title
			ls_title = ls_title_save
			ls_modstring = "title_t.Text = '" + ls_title + "'"
			ls_rtn = lds_report_inv_cust_coils.Modify(ls_modstring)
			ls_title_save = ""
		End If
	Next
	
	If IsValid(lds_report_inv_cust_coils) Then Destroy lds_report_inv_cust_coils
End If //Alex Gerlants. 06/08/2017

SetPointer(Arrow!)
	
return 1
end function

public function integer of_report_inv_cust_scrap_skids (long al_customer_id[], string as_customer_short_name, string as_filetype_2create);//d_report_inv_abc_scrap_skids

/*
******************************************** Install ************************************************

P:\Dev\Install\PDF Printer\Setup_BullzipPDFPrinter_10_25_0_2552_PRO_EXP.exe. Then rename to "PDFPrinter"
P:\Dev\Install\ghostscript\gs920w32.exe
P:\Dev\Install\PdfTK\pdftk_free-2.02-win-setup.exe
P:\Dev\Install\PSTools\pskill.exe

c:\abis\combpdf.bat
c:\abis\taskkill.bat

Add to system path:
		C:\Program Files\gs\gs9.20\bin 				<== Windows XP
		C:\Program Files (x86)\gs\gs9.20\bin 		<== Windows 7

******************************************** Install ************************************************

Function:	of_report_inv_cust_scrap_skids
Returns;		integer
Arguments:	value	long		al_customer_id[]
				value string	as_customer_short_name
				value string	as_filetype_2create
*/

DataStore	lds_report_inv_cust_scrap_skids
String		ls_sql_orig, ls_sql_new, ls_add, ls_report_folder, ls_report_name, ls_today, ls_now
String		ls_customer_name, ls_customer_ids, ls_modstring, ls_rtn, ls_title, ls_title_save
String		ls_report_header
DateTime		ldt_add_from, ldt_add_to
Long			ll_rtn, ll_rows, ll_customer_id[], ll_customer_id_temp, ll_i, ll_counter = 0
Integer		li_rtn, li_rtn_setsqlselect, li_rtn_saveas
Boolean		lb_report_4multiple_customers //Alex Gerlants. 06/08/2017

SetPointer(HourGlass!)
ib_scrap_done = False

ll_customer_id[] = al_customer_id[]

//Alex Gerlants. 06/08/2017. Begin
lb_report_4multiple_customers = False

If ll_customer_id[1] = -99 Then
	lb_report_4multiple_customers = True
Else
	//
End If
//Alex Gerlants. 06/08/2017. End

If Not sqlca.of_isconnected() Then
	sqlca.of_connect()
End If

If IsValid(lds_report_inv_cust_scrap_skids) Then Destroy lds_report_inv_cust_scrap_skids
lds_report_inv_cust_scrap_skids = Create DataStore
lds_report_inv_cust_scrap_skids.DataObject = "d_report_inv_cust_scrap_skids"
lds_report_inv_cust_scrap_skids.SetTransObject(sqlca)

ls_sql_orig = lds_report_inv_cust_scrap_skids.GetSqlSelect()

ls_today = String(Today(),"mmddyyyy")
ls_today = Left(ls_today, 2) + "/" + Mid(ls_today, 3, 2) + "/" + Right(ls_today, 2)
ls_now = String(Now(),"hhmmss")

ldt_add_from = DateTime(Date(ls_today), Time("00:00:00"))
ldt_add_to = DateTime(Date(ls_today), Time("23:59:59"))

If lb_report_4multiple_customers Then
	ls_add = " and scrap_skid.customer_id in (select customer_id from customer where lower(customer_short_name) like lower('%" + as_customer_short_name + "%'))"
	
	ls_sql_new = ls_sql_orig + ls_add
	li_rtn_setsqlselect = lds_report_inv_cust_scrap_skids.SetSqlSelect(ls_sql_new)

	lds_report_inv_cust_scrap_skids.Reset()
	ll_rows = lds_report_inv_cust_scrap_skids.Retrieve()
	
	If ll_rows > 0 Then
		//Sort
		lds_report_inv_cust_scrap_skids.SetSort("scrap_skid_scrap_skid_num A")
		lds_report_inv_cust_scrap_skids.Sort()
		
		//li_rtn = -99
		
		//---
		
		of_specs_scrap(lds_report_inv_cust_scrap_skids)
		
		ls_modstring = "date_t.Text = 'All'"
		ls_rtn = lds_report_inv_cust_scrap_skids.Modify(ls_modstring)
		
		//title_t
		ls_title = lds_report_inv_cust_scrap_skids.Describe("title_t.Text")
		ls_title_save = ls_title
		
		//ls_customer_name = of_get_customer_name(ll_customer_id_temp)
		
		ls_title = Upper(as_customer_short_name) + " Customer Scrap Skid Inventory Report"
		ls_modstring = "title_t.Text = '" + ls_title + "'"
		ls_rtn = lds_report_inv_cust_scrap_skids.Modify(ls_modstring)
		
		//status_t
		ls_modstring = "status_t.Text = 'All'"
		ls_rtn = lds_report_inv_cust_scrap_skids.Modify(ls_modstring)
		
		ls_report_folder = is_work_folder

		If Lower(as_filetype_2create) = "pdf" Then
			ls_report_name = "Scrap1" + ".pdf"
			of_update_data_export(lds_report_inv_cust_scrap_skids)
		ElseIf Lower(as_filetype_2create) = "xls" Then
			ls_report_name = "Scrap1"
		End If
		
		//If Lower(as_filetype_2create) = "pdf" Then
		//	of_update_data_export(lds_report_inv_cust_scrap_skids)
		//End If
		
		If Lower(as_filetype_2create) = "pdf" Then
			li_rtn_saveas = of_saveas(lds_report_inv_cust_scrap_skids, ls_report_folder, ls_report_name, "pdf", True)
		ElseIf Lower(as_filetype_2create) = "xls" Then
			ls_report_header = ls_customer_name + " " + "ABCO Customer Scrap Skid Inventory Report"
			exporttoexcel_scrap(lds_report_inv_cust_scrap_skids, ll_rows, ls_report_folder, ls_report_name, ls_report_header)
			excel_open_xls_saveas_csv(ls_report_folder, ls_report_name)
		End If
		
		If li_rtn_saveas = 1 Then ib_scrap_done = True
		
		//Reinstate report title
		ls_title = ls_title_save
		ls_modstring = "title_t.Text = '" + ls_title + "'"
		ls_rtn = lds_report_inv_cust_scrap_skids.Modify(ls_modstring)
		ls_title_save = ""
	End If

Else
	
	For ll_i = 1 To UpperBound(ll_customer_id[])
		
		//Sort
		lds_report_inv_cust_scrap_skids.SetSort("scrap_skid_scrap_skid_num A")
		lds_report_inv_cust_scrap_skids.Sort()
		
		ll_customer_id_temp = ll_customer_id[ll_i]
	
		ls_add = " and scrap_skid.customer_id = " + String(ll_customer_id_temp)
		
		ls_sql_new = ls_sql_orig + ls_add
		li_rtn_setsqlselect = lds_report_inv_cust_scrap_skids.SetSqlSelect(ls_sql_new)
	
		lds_report_inv_cust_scrap_skids.Reset()
		ll_rows = lds_report_inv_cust_scrap_skids.Retrieve()
		
		If ll_rows > 0 Then
			ll_counter++
			
			li_rtn = -99
			
			//---
			
			of_specs_scrap(lds_report_inv_cust_scrap_skids)
			
			ls_modstring = "date_t.Text = 'All'"
			ls_rtn = lds_report_inv_cust_scrap_skids.Modify(ls_modstring)
			
			//title_t
			ls_title = lds_report_inv_cust_scrap_skids.Describe("title_t.Text")
			ls_title_save = ls_title
			
			ls_customer_name = of_get_customer_name(ll_customer_id_temp)
			
			ls_title = ls_customer_name + " Customer Scrap Skid Inventory Report"
			ls_modstring = "title_t.Text = '" + ls_title + "'"
			ls_rtn = lds_report_inv_cust_scrap_skids.Modify(ls_modstring)
			
			//status_t
			ls_modstring = "status_t.Text = 'All'"
			ls_rtn = lds_report_inv_cust_scrap_skids.Modify(ls_modstring)
			
			ls_report_folder = is_work_folder
	
			If Lower(as_filetype_2create) = "pdf" Then
				ls_report_name = "Scrap" + String(ll_counter) + ".pdf"
			ElseIf Lower(as_filetype_2create) = "xls" Then
				ls_report_name = "Scrap" + String(ll_counter)
			End If
			
			If Lower(as_filetype_2create) = "pdf" Then
				of_update_data_export(lds_report_inv_cust_scrap_skids)
			End If
			
			If Lower(as_filetype_2create) = "pdf" Then
				li_rtn_saveas = of_saveas(lds_report_inv_cust_scrap_skids, ls_report_folder, ls_report_name, "pdf", True)
			ElseIf Lower(as_filetype_2create) = "xls" Then
				ls_report_header = ls_customer_name + " " + "ABCO Customer Scrap Skid Inventory Report"
				exporttoexcel_scrap(lds_report_inv_cust_scrap_skids, ll_rows, ls_report_folder, ls_report_name, ls_report_header)
				excel_open_xls_saveas_csv(ls_report_folder, ls_report_name)
			End If
			
			If li_rtn_saveas = 1 Then ib_scrap_done = True
			
			//Reinstate report title
			ls_title = ls_title_save
			ls_modstring = "title_t.Text = '" + ls_title + "'"
			ls_rtn = lds_report_inv_cust_scrap_skids.Modify(ls_modstring)
			ls_title_save = ""
		End If
	Next
End If //Alex Gerlants. 06/08/2017

If IsValid(lds_report_inv_cust_scrap_skids) Then Destroy lds_report_inv_cust_scrap_skids

SetPointer(Arrow!)
	
return 1
end function

public function integer of_report_inv_cust_skids (long al_customer_id[], string as_customer_short_name, string as_filetype_2create);/*
******************************************** Install ************************************************

P:\Dev\Install\PDF Printer\Setup_BullzipPDFPrinter_10_25_0_2552_PRO_EXP.exe. Then rename to "PDFPrinter"
P:\Dev\Install\ghostscript\gs920w32.exe
P:\Dev\Install\PdfTK\pdftk_free-2.02-win-setup.exe
P:\Dev\Install\PSTools\pskill.exe

c:\abis\combpdf.bat
c:\abis\taskkill.bat

Add to system path:
		C:\Program Files\gs\gs9.20\bin 				<== Windows XP
		C:\Program Files (x86)\gs\gs9.20\bin 		<== Windows 7

******************************************** Install ************************************************

Function:	of_report_inv_cust_skids
Returns:		integer
Arguments:	value	long		al_customer_id[]
				value	string	as_customer_short_name
				value	string	as_filetype_2create
*/


DataStore	lds_report_inv_cust_skids
String		ls_sql_orig, ls_sql_new, ls_add, ls_report_folder, ls_report_name, ls_today, ls_now
String		ls_modstring, ls_rtn
String		ls_pdf_method, ls_custompostscript
String		ls_customer_name, ls_customer_ids, ls_title, ls_title_save
String		ls_report_header
DateTime		ldt_add_from, ldt_add_to
Long			ll_rtn, ll_rows, ll_customer_id[], ll_customer_id_temp, ll_i, ll_counter = 0
Integer		li_rtn, li_rtn_setsqlselect,li_rtn_saveas
Boolean		lb_report_4multiple_customers //Alex Gerlants. 06/08/2017
Long			ll_pos_toyota //Alex Gerlants. 09/11/2017
Integer		li_count_toyota //Alex Gerlants. 09/11/2017
Boolean		lb_use_package_num //Alex Gerlants. 06/15/2018. Arconic_Package_Num

SetPointer(HourGlass!)
ib_skids_done = False

ll_customer_id[] = al_customer_id[]

//Alex Gerlants. 06/08/2017. Begin
lb_report_4multiple_customers = False

If ll_customer_id[1] = -99 Then
	lb_report_4multiple_customers = True
Else
	//
End If
//Alex Gerlants. 06/08/2017. End

If Not sqlca.of_isconnected() Then
	sqlca.of_connect()
End If

If IsValid(lds_report_inv_cust_skids) Then Destroy lds_report_inv_cust_skids
lds_report_inv_cust_skids = Create DataStore
lds_report_inv_cust_skids.DataObject = "d_report_inv_cust_skids"
li_rtn = lds_report_inv_cust_skids.SetTransObject(sqlca)

ls_sql_orig = lds_report_inv_cust_skids.GetSqlSelect()

ls_today = String(Today(),"mmddyyyy")
ls_today = Left(ls_today, 2) + "/" + Mid(ls_today, 3, 2) + "/" + Right(ls_today, 2)
ls_now = String(Now(),"hhmmss")

ldt_add_from = DateTime(Date(ls_today), Time("00:00:00"))
ldt_add_to = DateTime(Date(ls_today), Time("23:59:59"))

If lb_report_4multiple_customers Then
	
	//Alex Gerlants. 09/11/2017. Begin
	ll_pos_toyota = Pos(Lower(as_customer_short_name), "toyota", 1)
	
	If ll_pos_toyota > 0 Then //Toyota
		lds_report_inv_cust_skids.DataObject = "d_report_inv_cust_skids_t" //New DW
		li_rtn = lds_report_inv_cust_skids.SetTransObject(sqlca)
	End If
	
	ls_sql_orig = lds_report_inv_cust_skids.GetSqlSelect()
	//Alex Gerlants. 09/11/2017. End
	
	ls_add = "~n~r and (lower(customer_order.orig_customer_id) in (select customer_id from customer where lower(customer_short_name) like lower('%" + as_customer_short_name + "%')))"
	
	ls_sql_new = ls_sql_orig + ls_add
	li_rtn_SetSqlSelect = lds_report_inv_cust_skids.SetSqlSelect(ls_sql_new)
	
	lds_report_inv_cust_skids.Reset()
	li_rtn = lds_report_inv_cust_skids.SetTransObject(sqlca)
	ll_rows = lds_report_inv_cust_skids.Retrieve()

	If ll_rows > 0 Then
		//Sort
		lds_report_inv_cust_skids.SetSort("customer_order_orig_customer_id A, customer_order_enduser_id A, sheet_skid_sheet_skid_num A")
		lds_report_inv_cust_skids.Sort()
		
		li_rtn = -99
		
		lds_report_inv_cust_skids.SetSort("sheet_skid_sheet_skid_display_num Asc")
		lds_report_inv_cust_skids.Sort()
		
		of_specs_skids(lds_report_inv_cust_skids)
		
		ls_modstring = "date_t.Text = 'All'"
		ls_rtn = lds_report_inv_cust_skids.Modify(ls_modstring)
		
		//title_t
		ls_title = lds_report_inv_cust_skids.Describe("title_t.Text")
		ls_title_save = ls_title
		
		ls_customer_name = Upper(as_customer_short_name)
		
		ls_title = ls_customer_name + ls_title
		ls_modstring = "title_t.Text = '" + ls_title + "'"
		ls_rtn = lds_report_inv_cust_skids.Modify(ls_modstring)
		
		//enduser_t
		ls_modstring = "enduser_t.Text = 'All'"
		ls_rtn = lds_report_inv_cust_skids.Modify(ls_modstring)
		
		//status_t
		ls_modstring = "status_t.Text = 'All'"
		ls_rtn = lds_report_inv_cust_skids.Modify(ls_modstring)

		ls_report_folder = is_work_folder

		If Lower(as_filetype_2create) = "pdf" Then
			ls_report_name = "Skids1.pdf"
			of_update_data_export(lds_report_inv_cust_skids)
			
			li_rtn_saveas = of_saveas(lds_report_inv_cust_skids, ls_report_folder, ls_report_name, "pdf", True)
		ElseIf Lower(as_filetype_2create) = "xls" Then
			ls_report_name = "Skids1"
			ls_report_header = ls_customer_name + " " + "Customer Skid Inventory Report"
			
			//li_rtn_saveas = of_saveas(lds_report_inv_cust_skids, ls_report_folder, ls_report_name, "excel8", True)
			
			If ll_pos_toyota <= 0 Then //Alex Gerlants. 09/11/2017
				exporttoexcel_skids(lds_report_inv_cust_skids, ll_rows, ls_report_folder, ls_report_name, ls_report_header) //Alex Gerlants. 09/11/2017
			Else //Toyota. Alex Gerlants. 09/11/2017
				exporttoexcel_skids_t(lds_report_inv_cust_skids, ll_rows, ls_report_folder, ls_report_name, ls_report_header)
			End If //Alex Gerlants. 09/11/2017
			
			excel_open_xls_saveas_csv(ls_report_folder, ls_report_name)
		End If
		
		If li_rtn_saveas = 1 Then ib_skids_done = True
	End If
Else
	For ll_i = 1 To UpperBound(ll_customer_id[])
		ll_customer_id_temp = ll_customer_id[ll_i]
		
		f_get_use_package_num_2customer(ll_customer_id_temp, sqlca, lb_use_package_num) //ib_use_package_num is by reference in f_get_use_package_num_2customer()
		
		//Alex Gerlants. 09/11/2017. Begin
		select	count(*)
		into		:li_count_toyota
		from		customer
		where		customer_id = :ll_customer_id_temp
		and		(lower(customer_full_name) like '%toyota%' or lower(customer_short_name) like '%toyota%')
		using		sqlca;
		
		If li_count_toyota > 0 Then
			lds_report_inv_cust_skids.DataObject = "d_report_inv_cust_skids_t" //New DW
		ElseIf lb_use_package_num Then
			lds_report_inv_cust_skids.DataObject = "d_report_inv_cust_skids_pn" //New DW
		End If
		//Alex Gerlants. 09/11/2017. End
		
		ls_sql_orig = lds_report_inv_cust_skids.GetSqlSelect() //Alex Gerlants. 09/11/2017. End
		
	
		ls_add = " and customer_order.orig_customer_id = " + String(ll_customer_id_temp)
		
		ls_sql_new = ls_sql_orig + ls_add
		li_rtn_SetSqlSelect = lds_report_inv_cust_skids.SetSqlSelect(ls_sql_new)
		
		lds_report_inv_cust_skids.Reset()
		li_rtn = lds_report_inv_cust_skids.SetTransObject(sqlca)
		ll_rows = lds_report_inv_cust_skids.Retrieve()
	
		If ll_rows > 0 Then
			ll_counter++
			
			//Sort
			lds_report_inv_cust_skids.SetSort("customer_order_orig_customer_id A, customer_order_enduser_id A, sheet_skid_sheet_skid_num A")
			lds_report_inv_cust_skids.Sort()
			
			li_rtn = -99
			
			lds_report_inv_cust_skids.SetSort("sheet_skid_sheet_skid_display_num Asc")
			lds_report_inv_cust_skids.Sort()
			
			of_specs_skids(lds_report_inv_cust_skids)
			
			ls_modstring = "date_t.Text = 'All'"
			ls_rtn = lds_report_inv_cust_skids.Modify(ls_modstring)
			
			//title_t
			ls_title = lds_report_inv_cust_skids.Describe("title_t.Text")
			ls_title_save = ls_title
			
			ls_customer_name = of_get_customer_name(ll_customer_id_temp)
			
			ls_title = ls_customer_name + ls_title
			ls_modstring = "title_t.Text = '" + ls_title + "'"
			ls_rtn = lds_report_inv_cust_skids.Modify(ls_modstring)
			
			//enduser_t
			ls_modstring = "enduser_t.Text = 'All'"
			ls_rtn = lds_report_inv_cust_skids.Modify(ls_modstring)
			
			//status_t
			ls_modstring = "status_t.Text = 'All'"
			ls_rtn = lds_report_inv_cust_skids.Modify(ls_modstring)
	
			ls_report_folder = is_work_folder
	
			If Lower(as_filetype_2create) = "pdf" Then
				ls_report_name = "Skids" + String(ll_counter) + ".pdf"
				of_update_data_export(lds_report_inv_cust_skids)
				
				li_rtn_saveas = of_saveas(lds_report_inv_cust_skids, ls_report_folder, ls_report_name, "pdf", True)
			ElseIf Lower(as_filetype_2create) = "xls" Then
				ls_report_name = "Skids" + String(ll_counter)
				ls_report_header = ls_customer_name + " " + "Customer Skid Inventory Report"
				
				//li_rtn_saveas = of_saveas(lds_report_inv_cust_skids, ls_report_folder, ls_report_name, "excel8", True)
				
				If li_count_toyota <= 0 Then //Alex Gerlants. 09/11/2017
					exporttoexcel_skids(lds_report_inv_cust_skids, ll_rows, ls_report_folder, ls_report_name, ls_report_header)
				Else //Alex Gerlants. 09/11/2017. Toyota
					exporttoexcel_skids_t(lds_report_inv_cust_skids, ll_rows, ls_report_folder, ls_report_name, ls_report_header) //Alex Gerlants. 09/11/2017
				End If //Alex Gerlants. 09/11/2017
				
				excel_open_xls_saveas_csv(ls_report_folder, ls_report_name)
			End If
			
			//If li_rtn_saveas = 1 Then ib_skids_done = True
			
			//Reinstate report title
			ls_title = ls_title_save
			ls_modstring = "title_t.Text = '" + ls_title + "'"
			ls_rtn = lds_report_inv_cust_skids.Modify(ls_modstring)
			ls_title_save = ""
		End If
		
		//Reinstate original SQL
		li_rtn_SetSqlSelect = lds_report_inv_cust_skids.SetSqlSelect(ls_sql_orig) //Alex Gerlants. 09/11/2017
	Next
End If //Alex Gerlants. 06/08/2017

If IsValid(lds_report_inv_cust_skids) Then Destroy lds_report_inv_cust_skids

SetPointer(Arrow!)
	
return 1
end function

public function integer of_report_inv_cust_coils_comb (long al_customer_id[], ref datastore ads_report_inv_cust_coils_comb);//Alex Gerlants. Novelis Inv. Combined Report. 08/01/2017. Begin
/*
Function:	of_report_inv_cust_coils_comb
Returns:		integer
Arguments:	value			long			al_customer_id[]
				reference	datastore	ads_report_inv_cust_coils_comb <== Combine report rows
*/

DataStore	lds_report_inv_cust_coils
DateTime		ldt_add_from, ldt_add_to
Long			ll_rtn, ll_rows, ll_customer_id[], ll_customer_id_temp, ll_i, ll_counter = 0
Integer		li_rtn
Pointer		lp_current_pointer

SetPointer(HourGlass!)
ib_coils_done = False

ll_customer_id[] = al_customer_id[]

//Alex Gerlants. 10/03/2017. Begin
li_rtn = of_unmatched_coils(ll_customer_id[])

If li_rtn = -1 Then Return -1 //Unmatched coils found, or DB error in of_unmatched_coils()
//Alex Gerlants. 10/03/2017. End

If Not sqlca.of_isconnected() Then
	sqlca.of_connect()
End If

If IsValid(lds_report_inv_cust_coils) Then Destroy lds_report_inv_cust_coils
lds_report_inv_cust_coils = Create DataStore
lds_report_inv_cust_coils.DataObject = "d_report_inv_cust_coils_comb"
li_rtn = lds_report_inv_cust_coils.SetTransObject(sqlca)

ldt_add_from = DateTime(Date("01/01/1980"), Time("00:00:00"))
ldt_add_to = DateTime(Date("12/31/2050"), Time("23:59:59"))

li_rtn = lds_report_inv_cust_coils.SetTransObject(sqlca)

For ll_i = 1 To UpperBound(ll_customer_id[])
	
	ll_customer_id_temp = ll_customer_id[ll_i]

	lds_report_inv_cust_coils.Reset()
	//ll_rows = lds_report_inv_cust_coils.Retrieve(ll_customer_id_temp, ldt_add_from, ldt_add_to)
	ll_rows = lds_report_inv_cust_coils.Retrieve(ll_customer_id_temp)
	
	If ll_rows > 0 Then
		//Collect rows in ads_report_inv_cust_coils_comb passed by reference from Clicked event for cb_create_comb of w_inventory_reports
		ll_rtn = lds_report_inv_cust_coils.RowsCopy(1, lds_report_inv_cust_coils.RowCount(), Primary!, &
						ads_report_inv_cust_coils_comb, ads_report_inv_cust_coils_comb.RowCount() + 1, Primary!)
	End If
Next

ll_rows = ads_report_inv_cust_coils_comb.RowCount()

//of_eliminate_duplicate_weight(ads_report_inv_cust_coils_comb)

If IsValid(lds_report_inv_cust_coils) Then Destroy lds_report_inv_cust_coils

SetPointer(lp_current_pointer)
	
return 1
//Alex Gerlants. Novelis Inv. Combined Report. 08/01/2017. End
end function

public function integer of_report_inv_cust_scrap_skids_comb (long al_customer_id[], ref datastore ads_report_inv_cust_scrap_skids_comb);//Alex Gerlants. Novelis Inv. Combined Report. 08/01/2017. Begin
/*
Function:	of_report_inv_cust_scrap_skids_comb
Returns;		integer
Arguments:	value	long			al_customer_id[]
				value datastore	ads_report_inv_cust_scrap_skids_comb <== Combine report rows
*/

DataStore	lds_report_inv_cust_scrap_skids
String		ls_sql_orig, ls_sql_new, ls_add
Long			ll_rtn, ll_rows, ll_customer_id[], ll_customer_id_temp, ll_i
Integer		li_rtn, li_rtn_setsqlselect
Pointer		lp_current_pointer

lp_current_pointer = SetPointer(HourGlass!)
ib_scrap_done = False

ll_customer_id[] = al_customer_id[]

If Not sqlca.of_isconnected() Then
	sqlca.of_connect()
End If

If IsValid(lds_report_inv_cust_scrap_skids) Then Destroy lds_report_inv_cust_scrap_skids
lds_report_inv_cust_scrap_skids = Create DataStore
lds_report_inv_cust_scrap_skids.DataObject = "d_report_inv_cust_scrap_skids_comb"
lds_report_inv_cust_scrap_skids.SetTransObject(sqlca)

ls_sql_orig = lds_report_inv_cust_scrap_skids.GetSqlSelect()

For ll_i = 1 To UpperBound(ll_customer_id[])
	ll_customer_id_temp = ll_customer_id[ll_i]
	
	ls_add = " and scrap_skid.customer_id = " + String(ll_customer_id_temp)
	
	ls_sql_new = ls_sql_orig + ls_add
	li_rtn_setsqlselect = lds_report_inv_cust_scrap_skids.SetSqlSelect(ls_sql_new)
		
	If li_rtn_setsqlselect = 1 Then //OK
		lds_report_inv_cust_scrap_skids.Reset()
		ll_rows = lds_report_inv_cust_scrap_skids.Retrieve()
		
		If ll_rows > 0 Then
			//Collect rows in ads_report_inv_cust_coils_comb passed by reference from Clicked event for cb_create_comb of w_inventory_reports
			ll_rtn = lds_report_inv_cust_scrap_skids.RowsCopy(1, lds_report_inv_cust_scrap_skids.RowCount(), Primary!, &
							ads_report_inv_cust_scrap_skids_comb, ads_report_inv_cust_scrap_skids_comb.RowCount() + 1, Primary!)
		End If
	End if
Next

ll_rows = ads_report_inv_cust_scrap_skids_comb.RowCount()

If IsValid(lds_report_inv_cust_scrap_skids) Then Destroy lds_report_inv_cust_scrap_skids

SetPointer(lp_current_pointer)
	
return 1
//Alex Gerlants. Novelis Inv. Combined Report. 08/01/2017. End
end function

public function integer of_report_inv_cust_skids_comb (long al_customer_id[], ref datastore ads_report_inv_cust_skids_comb);//Alex Gerlants. Novelis Inv. Combined Report. 08/01/2017. Begin
/*
Function:	of_report_inv_cust_skids_comb
Returns:		integer
Arguments:	value			long			al_customer_id[]
				reference	datastore	ads_report_inv_cust_skids_comb
*/


DataStore	lds_report_inv_cust_skids
String		ls_sql_orig, ls_sql_new, ls_add, ls_skid_status_desc, ls_prod_item_status_desc
Long			ll_rtn, ll_row, ll_rows, ll_customer_id[], ll_customer_id_temp, ll_i
Integer		li_rtn, li_rtn_setsqlselect
Pointer		lp_current_pointer

lp_current_pointer = SetPointer(HourGlass!)
ib_skids_done = False

ll_customer_id[] = al_customer_id[]

If Not sqlca.of_isconnected() Then
	sqlca.of_connect()
End If

If IsValid(lds_report_inv_cust_skids) Then Destroy lds_report_inv_cust_skids
lds_report_inv_cust_skids = Create DataStore
lds_report_inv_cust_skids.DataObject = "d_report_inv_cust_skids_comb"
li_rtn = lds_report_inv_cust_skids.SetTransObject(sqlca)

ls_sql_orig = lds_report_inv_cust_skids.GetSqlSelect()

For ll_i = 1 To UpperBound(ll_customer_id[])
	ll_customer_id_temp = ll_customer_id[ll_i]

	ls_add = " and customer_order.orig_customer_id = " + String(ll_customer_id_temp)
	
	ls_sql_new = ls_sql_orig + ls_add
	li_rtn_SetSqlSelect = lds_report_inv_cust_skids.SetSqlSelect(ls_sql_new)
	
	If li_rtn_SetSqlSelect = 1 Then //OK
		lds_report_inv_cust_skids.Reset()
		li_rtn = lds_report_inv_cust_skids.SetTransObject(sqlca)
		ll_rows = lds_report_inv_cust_skids.Retrieve()
	
		If ll_rows > 0 Then
			//Collect rows in ads_report_inv_cust_coils_comb passed by reference from Clicked event for cb_create_comb of w_inventory_reports
			ll_rtn = lds_report_inv_cust_skids.RowsCopy(1, lds_report_inv_cust_skids.RowCount(), Primary!, &
							ads_report_inv_cust_skids_comb, ads_report_inv_cust_skids_comb.RowCount() + 1, Primary!)

			//For ll_row = 1 To ll_rows
			//	ls_skid_status_desc = ads_report_inv_cust_skids_comb.Object.skid_status_desc[ll_row]
			//	ls_prod_item_status_desc = ads_report_inv_cust_skids_comb.Object.prod_item_status_desc[ll_row]
			//Next
		End If
	End if
Next

ll_rows = ads_report_inv_cust_skids_comb.RowCount()

If IsValid(lds_report_inv_cust_skids) Then Destroy lds_report_inv_cust_skids

SetPointer(lp_current_pointer)
	
return 1
//Alex Gerlants. Novelis Inv. Combined Report. 08/01/2017. End
end function

public subroutine of_eliminate_duplicate_weight (ref datastore ads_report_inv_cust_coils_comb);//Alex Gerlants. Novelis Inv. Combined Report. 08/11/2017. Begin
/*
Function:	of_eliminate_duplicate_weight
				Blank out coil_net_wt and coil_net_wt_balance on all subsequent rows if coil_abc_num occurs more than once 
Returns:		integer
Arguments:	reference	datastore	ads_report_inv_cust_coils_comb
*/
Long		ll_rows, ll_row, ll_coil_abc_num_prev, ll_coil_abc_num
Long		ll_coil_net_wt, ll_coil_net_wt_balance
String	ls_enduser_name

ll_rows = ads_report_inv_cust_coils_comb.RowCount()

ads_report_inv_cust_coils_comb.SetSort("coil_coil_abc_num Asc")
ads_report_inv_cust_coils_comb.Sort()

ll_coil_abc_num_prev = 0

For ll_row = 1 To ll_rows
	ll_coil_abc_num = ads_report_inv_cust_coils_comb.Object.coil_coil_abc_num[ll_row]
	ls_enduser_name = ads_report_inv_cust_coils_comb.Object.enduser_name[ll_row]
	
	If ll_coil_abc_num = ll_coil_abc_num_prev Then
		//ads_report_inv_cust_coils_comb.Object.coil_coil_org_num[ll_row] = ""
		//ads_report_inv_cust_coils_comb.Object.coil_coil_mid_num[ll_row] = ""
		//ads_report_inv_cust_coils_comb.Object.coil_lot_num[ll_row] = ""
		//ads_report_inv_cust_coils_comb.Object.coil_coil_alloy2[ll_row] = ""
		//ads_report_inv_cust_coils_comb.Object.coil_coil_temper[ll_row] = ""
		//ads_report_inv_cust_coils_comb.Object.customer_order_reference[ll_row] = ""
		//ads_report_inv_cust_coils_comb.Object.coil_date_received[ll_row] = ""
		ads_report_inv_cust_coils_comb.Object.coil_net_wt[ll_row] = "0"
		ads_report_inv_cust_coils_comb.Object.coil_net_wt_balance[ll_row] = "0"
		//ads_report_inv_cust_coils_comb.Object.coil_coil_gauge[ll_row] = ""
		//ads_report_inv_cust_coils_comb.Object.coil_coil_width[ll_row] = ""
		//ads_report_inv_cust_coils_comb.Object.coil_material_num[ll_row] = ""
		//ads_report_inv_cust_coils_comb.Object.duration[ll_row] = ""
	End If
	
	ll_coil_abc_num_prev = ll_coil_abc_num
Next

//Sort again so the row with data that are not blanked out for the same coil is displayed first for a group
ads_report_inv_cust_coils_comb.SetSort("coil_coil_abc_num Asc, coil_net_wt Asc")
ads_report_inv_cust_coils_comb.Sort()
//Alex Gerlants. Novelis Inv. Combined Report. 08/11/2017. End
end subroutine

public subroutine exporttoexcel_skids_t (datastore adw_dw, long al_rows, string as_folder, string as_report_name, string as_report_header);//Alex Gerlants. 09/11/2017. Begin
/*
Function:	exporttoexcel_skids_t
Returns:		none
Arguments:	value		datastore	adw_dw
				value		long			al_rows	
				value		string		as_folder
				value		string		as_report_name 	<== Report file name
				value		string		as_report_header	<== Report header	

*/

// Export the data to Excel
OleObject 	lole_OLE, lole_Sheet
String 		ls_Columns[]
Long 			ll_report_rows, ll_Row, ll_Col, ll_Cols, ll_total_line1, ll_total_line2
String		ls_range, ls_total_prod_item_net_wt, ls_total_theo_skid_wt
Boolean		lb_rtn, lb_directoryexists, lb_fileexists, lb_rtn_delete

String 		ls_file, ls_today, ls_now, ls_folder
Date 			ld_today
Time 			ld_now
Integer		li_answer, li_count

ll_report_rows = adw_dw.RowCount()

If ll_report_rows > 0 Then
	//Get report totals
	ls_total_prod_item_net_wt = String(adw_dw.Object.compute_2[1])
	ls_total_theo_skid_wt = String(adw_dw.Object.compute_4[1])
Else
	Return
End If

lole_OLE = CREATE OleObject

SetPointer( HourGlass! )

lole_OLE.ConnectToNewObject( 'excel.application' )
lole_OLE.Workbooks.Add
lole_sheet = lole_OLE.Application.ActiveWorkbook.WorkSheets[1]

this.GetColumns( adw_DW, ls_Columns )
ll_Cols = UpperBound( ls_Columns )
FOR ll_col = 1 TO ll_cols
	lole_Sheet.Cells[ 1, ll_Col ] = ls_Columns[ ll_Col ]
NEXT

FOR ll_Row = 2 TO al_rows + 1
	FOR ll_Col = 1 TO ll_cols
		lole_Sheet.Cells[ ll_Row, ll_Col ] = &
		this.GetData( adw_DW, ll_Row - 1, ls_Columns[ ll_Col ] )
	NEXT
NEXT

lole_Sheet.Range( inttocolumn( 1 ) + "1:" + inttocolumn( ll_Cols ) + "1").Select
lole_OLE.Selection.Font.Bold = True

lole_Sheet.Range("A1:A1").Select
lole_Sheet.Columns( inttocolumn( 1 ) + ":" + inttocolumn( ll_cols ) ).EntireColumn.AutoFit


//Column Headings
lole_OLE.cells[1,1]  = "Skid #"
lole_OLE.cells[1,2]  = "End User"
lole_OLE.cells[1,3]  = "Ab Job"
lole_OLE.cells[1,4]  = "EndUser Part #"
lole_OLE.cells[1,5]  = "Pieces"
lole_OLE.cells[1,6]  = "Net Wt."
lole_OLE.cells[1,7]  = "Theo Net Wt"
lole_OLE.cells[1,8]  = "Status"
lole_OLE.cells[1,9]  = "Coil Orig #"
lole_OLE.cells[1,10] = "Spec"
lole_OLE.cells[1,11] = "Material"
lole_OLE.cells[1,12] = "Lot #"
lole_OLE.cells[1,13] = "Item PCs"
lole_OLE.cells[1,14] = "NonConf."
lole_OLE.cells[1,15] = "Item NetWT"
lole_OLE.cells[1,16] = "Duration"


//Insert Lines for Header & Miscellaneous Details (3 lines above columnar data)
lole_Sheet.Range("A1:Q3").Select
lole_Sheet.Application.Selection.EntireRow.Insert 

//Change font size for report title
lole_OLE.cells[1,6] = as_report_header
lole_Sheet.Range("F1:F1").Select
lole_OLE.Selection.Font.Bold = True
lole_OLE.Selection.Font.Size = 24
lole_OLE.Selection.Font.Underline = True

//Change date format for current date
lole_OLE.cells[1,14] = String(Today(), "mm/dd/yyyy")
lole_Sheet.Range("N1:N1").Select
lole_OLE.Selection.Font.Bold = True

//Bold report arguments row
lole_OLE.cells[2,3] = "End User: " + "All"
lole_Sheet.Range("C2:C2").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[2,8] = "Status: " + "All"
lole_Sheet.Range("H2:H2").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[2,10] = "Created Date: " + "All"
lole_Sheet.Range("J2:J2").Select
lole_OLE.Selection.Font.Bold = True

//---

ll_total_line1 = ll_report_rows + 5
ll_total_line2 = ll_report_rows + 6

//Insert 2 lines for totals (below columnar data)
ls_range = "A" + String(ll_total_line1) + ":" + "N" + String(ll_total_line1)
lole_Sheet.Range(ls_range).Select
lole_Sheet.Application.Selection.EntireRow.Insert

//Insert totals
lole_OLE.cells[ll_total_line2,4] = "Total:"
lole_OLE.cells[ll_total_line1,5] = "-------------"
lole_OLE.cells[ll_total_line1,7] = "-------------"

lole_OLE.cells[ll_total_line2,5] = ls_total_prod_item_net_wt
lole_OLE.cells[ll_total_line2,7] = ls_total_theo_skid_wt

//Range("P16").Select
//Selection.Font.Bold = True

//ls_range = "E" + String(ll_total_line2) + ":" + "E" + String(ll_total_line2)
//lole_Sheet.Range(ls_range).Select
//lole_OLE.Selection.Font.Bold = True
////lole_OLE.Selection.Font.FontStyle = "Bold"

ls_range = "D" + String(ll_total_line2) + ":" + "P" + String(ll_total_line2)
lole_Sheet.Range(ls_range).Select
lole_OLE.Selection.Font.Bold = True
//lole_OLE.Selection.Font.FontStyle = "Bold" //Another way to bold a cell

//lole_OLE.cells[ll_total_line2,6] = ls_total_prod_item_net_wt
//ls_range = "D" + String(ll_total_line2) + ":" + "D" + String(ll_total_line2)
//lole_Sheet.Range(ls_range).Select
//lole_OLE.Selection.Font.Bold = True
//lole_OLE.Selection.Font.FontStyle = "Bold" //Another way to bold a cell

//Delete extra columns	
lole_Sheet.columns("Q:AB").Delete

//Justify
//lole_OLE.Selection.HorizontalAlignment = -4108 //Center
//lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
//lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

lole_Sheet.Range("A3:C" + String(ll_report_rows + 6)).Select
lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify

lole_Sheet.Range("D3:G" + String(ll_report_rows + 6)).Select
lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

lole_Sheet.Range("F3:J" + String(ll_report_rows + 6)).Select
lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify

lole_Sheet.Range("K3:L" + String(ll_report_rows + 6)).Select
lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

lole_Sheet.Range("M3:M" + String(ll_report_rows + 6)).Select
lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify

lole_Sheet.Range("N3:P" + String(ll_report_rows + 6)).Select
lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

//Underline column headers
lole_Sheet.Range("A4:O4").Select
lole_OLE.Selection.Font.Underline = True

//Change number format for column P
ls_range = "P" + String(ll_total_line2) + ":" + "P" + String(ll_total_line2)
lole_Sheet.Range(ls_range).Select
lole_OLE.Selection.NumberFormat = "###,###,##0.00"

//---

//Save the changes
SetPointer(HourGlass!)
ld_today = Today()
ld_now = Now()
ls_today = String(ld_today,"yymmdd")
ls_now = String(ld_now,"hhmmss")

ls_folder = as_folder
If Right(ls_folder, 1) <> "\" Then ls_folder = ls_folder + "\"

//ls_file = ls_folder + "Customer Skid Inventory Report" + "_" + ls_today + ls_now + ".xls"
ls_file = ls_folder + as_report_name + ".xls"

//Check if ls_folder exists.
lb_directoryexists = DirectoryExists(ls_folder)

If Not lb_directoryexists Then //Folder ls_folder doesn't exist
	CreateDirectory(ls_folder) //Create ls_folder
End If

lb_fileexists = FileExists(ls_file)

If lb_fileexists Then
	lb_rtn_delete = FileDelete(ls_file)
End If

lole_sheet.SaveAs(ls_file, Excel8!)

////Open the worksheet for user to veiw and save
//li_answer = MessageBox("Open Worksheet?", "Would you like to open worksheet " + ls_file + "?", Question!, YesNo!, 1)
//
//If li_answer = 1 Then //Yes
//	lole_OLE.Application.Visible = True
//Else
//	lole_OLE.Application.Visible = False
//End If

lole_OLE.Application.quit()
lole_OLE.DisconnectObject()

DESTROY lole_OLE

GarbageCollect()
//Alex Gerlants. 09/11/2017. End
end subroutine

public subroutine of_remove_duplicate_coils (ref datastore ads_report_coils);//Alex Gerlants. 09/18/2017. Begin
/*
Function:	of_remove_duplicate_coils
				Remove rows with duplicate coil_org_num
Returns:		none
Arguments:	reference datastore	ads_report_coils
*/

//Alex Gerlants. 01/30/2018. Begin
/*
Remove rows with duplicate combination of coil_org_num and coil_abc_num
*/

Long		ll_rows, ll_row
Integer	li_rtn
String	ls_coil_coil_org_num_prev, ls_coil_coil_org_num
String	ls_coil_coil_abc_num_prev, ls_coil_coil_abc_num
String	ls_key, ls_key_prev

ll_rows = ads_report_coils.RowCount()
If ll_rows <= 0 Then Return

li_rtn = ads_report_coils.SetSort("coil_coil_org_num Asc, coil_coil_abc_num Asc")
li_rtn = ads_report_coils.Sort()

//ls_coil_coil_org_num_prev = ""
ls_key_prev = ""

For ll_row = ll_rows To 1 Step -1
	ls_coil_coil_org_num = ads_report_coils.Object.coil_coil_org_num[ll_row]
	ls_coil_coil_abc_num = String(ads_report_coils.Object.coil_coil_abc_num[ll_row])
	
	ls_key = ls_coil_coil_org_num + ls_coil_coil_abc_num
	
	//If ls_coil_coil_org_num = ls_coil_coil_org_num_prev Then
	If ls_key = ls_key_prev Then
		ads_report_coils.DeleteRow(ll_row)
	End If
	
	//ls_coil_coil_org_num_prev = ls_coil_coil_org_num
	ls_key_prev = ls_key
Next
//Alex Gerlants. 09/18/2017. End
end subroutine

public function integer of_unmatched_coils (long al_customer_id[]);//Alex Gerlants. 10/03/2017. Begin
/*
Function:	of_unmatched_coils
Returns:		integer	 1 if OK
							-1 if error
Arguments:	value	long	al_customer_id[]
*/

DataStore	lds_unmatched_coils, lds_unmatched_coils_out
Long			ll_i, ll_customer_id_temp,ll_rows
Integer		li_rtn = 1

lds_unmatched_coils = Create DataStore
lds_unmatched_coils.DataObject = "d_unmatched_coils"
lds_unmatched_coils.SetTransObject(sqlca)

lds_unmatched_coils_out = Create DataStore
lds_unmatched_coils_out.DataObject = "d_unmatched_coils"

For ll_i = 1 To UpperBound(al_customer_id[])
	ll_customer_id_temp = al_customer_id[ll_i]
	
	ll_rows = lds_unmatched_coils.Retrieve(ll_customer_id_temp, ll_customer_id_temp)
	
	If ll_rows >= 0 Then	
		lds_unmatched_coils.RowsCopy(1, lds_unmatched_coils.RowCount(), Primary!, lds_unmatched_coils_out, lds_unmatched_coils_out.RowCount() + 1, Primary!)
	Else //DB error
		MessageBox("DB Error", "Database error occurred in of_unmatched_coils for nv_test while retrieving data for unmatched coils." + &
				"~n~rCannot continue.", StopSign!)
		
		li_rtn = -1
	End If
Next

ll_rows = lds_unmatched_coils_out.RowCount()

//ll_rows = 2 //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

If ll_rows > 0 Then
	OpenWithParm(w_unmatched_coils, lds_unmatched_coils_out)
	li_rtn = -1
End If

Return li_rtn
//Alex Gerlants. 10/03/2017. End
end function

public function integer of_unmatched_coils_auto (long al_customer_id[]);//Alex Gerlants. 10/03/2017. Begin
/*
Function:	of_unmatched_coils_auto
Returns:		integer	 1 if OK
							-1 if error
Arguments:	value	long	al_customer_id[]
*/

DataStore	lds_unmatched_coils, lds_unmatched_coils_out
Long			ll_i, ll_customer_id_temp,ll_rows
Integer		li_rtn = 1

lds_unmatched_coils = Create DataStore
lds_unmatched_coils.DataObject = "d_unmatched_coils"
lds_unmatched_coils.SetTransObject(sqlca)

lds_unmatched_coils_out = Create DataStore
lds_unmatched_coils_out.DataObject = "d_unmatched_coils"

For ll_i = 1 To UpperBound(al_customer_id[])
	ll_customer_id_temp = al_customer_id[ll_i]
	
	ll_rows = lds_unmatched_coils.Retrieve(ll_customer_id_temp, ll_customer_id_temp)
	
	If ll_rows >= 0 Then	
		lds_unmatched_coils.RowsCopy(1, lds_unmatched_coils.RowCount(), Primary!, lds_unmatched_coils_out, lds_unmatched_coils_out.RowCount() + 1, Primary!)
	Else //DB error
		MessageBox("DB Error", "Database error occurred in of_unmatched_coils for nv_test while retrieving data for unmatched coils." + &
				"~n~rCannot continue.", StopSign!)
		
		li_rtn = -1
	End If
Next

ll_rows = lds_unmatched_coils_out.RowCount()

//ll_rows = 2 //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

If ll_rows > 0 Then
	li_rtn = -1
End If

Return li_rtn
//Alex Gerlants. 10/03/2017. End
end function

public function integer of_report_inv_cust_coils_comb_auto (long al_customer_id[], ref datastore ads_report_inv_cust_coils_comb);//Alex Gerlants. Novelis Inv. Combined Report. 08/01/2017. Begin
/*
Function:	of_report_inv_cust_coils_comb_auto
Returns:		integer
Arguments:	value			long			al_customer_id[]
				reference	datastore	ads_report_inv_cust_coils_comb <== Combine report rows
*/

Boolean		lb_unmatched_coils = False
DataStore	lds_report_inv_cust_coils
DateTime		ldt_add_from, ldt_add_to
Long			ll_rtn, ll_rows, ll_customer_id[], ll_customer_id_temp, ll_i, ll_counter = 0
Integer		li_rtn
Pointer		lp_current_pointer

SetPointer(HourGlass!)
ib_coils_done = False

ll_customer_id[] = al_customer_id[]

//Alex Gerlants. 10/03/2017. Begin
li_rtn = of_unmatched_coils_auto(ll_customer_id[])

If li_rtn = -1 Then lb_unmatched_coils = True //Unmatched coils found, or DB error in of_unmatched_coils()
//Alex Gerlants. 10/03/2017. End

If Not sqlca.of_isconnected() Then
	sqlca.of_connect()
End If

If IsValid(lds_report_inv_cust_coils) Then Destroy lds_report_inv_cust_coils
lds_report_inv_cust_coils = Create DataStore
lds_report_inv_cust_coils.DataObject = "d_report_inv_cust_coils_comb"
li_rtn = lds_report_inv_cust_coils.SetTransObject(sqlca)

ldt_add_from = DateTime(Date("01/01/1980"), Time("00:00:00"))
ldt_add_to = DateTime(Date("12/31/2050"), Time("23:59:59"))

li_rtn = lds_report_inv_cust_coils.SetTransObject(sqlca)

For ll_i = 1 To UpperBound(ll_customer_id[])
	
	ll_customer_id_temp = ll_customer_id[ll_i]

	lds_report_inv_cust_coils.Reset()
	//ll_rows = lds_report_inv_cust_coils.Retrieve(ll_customer_id_temp, ldt_add_from, ldt_add_to)
	ll_rows = lds_report_inv_cust_coils.Retrieve(ll_customer_id_temp)
	
	If ll_rows > 0 Then
		//Collect rows in ads_report_inv_cust_coils_comb passed by reference from Clicked event for cb_create_comb of w_inventory_reports
		ll_rtn = lds_report_inv_cust_coils.RowsCopy(1, lds_report_inv_cust_coils.RowCount(), Primary!, &
						ads_report_inv_cust_coils_comb, ads_report_inv_cust_coils_comb.RowCount() + 1, Primary!)
	End If
Next

ll_rows = ads_report_inv_cust_coils_comb.RowCount()

//of_eliminate_duplicate_weight(ads_report_inv_cust_coils_comb)

If IsValid(lds_report_inv_cust_coils) Then Destroy lds_report_inv_cust_coils

SetPointer(lp_current_pointer)
	
If lb_unmatched_coils Then
	Return -2
Else
	Return 1
End If
//Alex Gerlants. Novelis Inv. Combined Report. 08/01/2017. End
end function

public function integer of_report_inv_cust_coils_auto (long al_customer_id[], string as_customer_short_name, string as_filetype_2create);/*
******************************************** Install ************************************************

P:\Dev\Install\PDF Printer\Setup_BullzipPDFPrinter_10_25_0_2552_PRO_EXP.exe. Then rename to "PDFPrinter"
P:\Dev\Install\ghostscript\gs920w32.exe
P:\Dev\Install\PdfTK\pdftk_free-2.02-win-setup.exe
P:\Dev\Install\PSTools\pskill.exe

c:\abis\combpdf.bat
c:\abis\taskkill.bat

Add to system path:
		C:\Program Files\gs\gs9.20\bin 				<== Windows XP
		C:\Program Files (x86)\gs\gs9.20\bin 		<== Windows 7

******************************************** Install ************************************************
*/

/*
Function:	of_report_inv_cust_coils_auto
Returns:		integer
Arguments:	value	long		al_customer_id[]
				value	string	as_customer_short_name
				value	string	as_filetype_2create
*/


Boolean		lb_report_4multiple_customers //Alex Gerlants. 06/08/2017
DataStore	lds_report_inv_cust_coils
String		ls_sql_orig, ls_sql_new, ls_add, ls_report_folder, ls_report_name, ls_today, ls_now
String		ls_modstring, ls_rtn, ls_report_header
String		ls_pdf_method, ls_custompostscript
String		ls_customer_name, ls_customer_id, ls_title,ls_title_save
String		ls_sql_orig_part_1, ls_sql_orig_part_2, ls_string_2add //Alex Gerlants. 06/08/2017
DateTime		ldt_add_from, ldt_add_to
Date			ld_from, ld_to
Long			ll_rtn, ll_rows, ll_customer_id[], ll_customer_id_temp, ll_i, ll_counter = 0
Long			ll_pos_union_all //Alex Gerlants. 06/08/2017
Integer		li_rtn, li_rtn_setsqlselect, li_rtn_saveas

SetPointer(HourGlass!)
ib_coils_done = False

ll_customer_id[] = al_customer_id[]

////Alex Gerlants. 10/03/2017. Begin
//li_rtn = of_unmatched_coils(ll_customer_id[])
//
//If li_rtn = -1 Then Return li_rtn //Unmatched coils found, or DB error in of_unmatched_coils()
////Alex Gerlants. 10/03/2017. End

If Not sqlca.of_isconnected() Then
	sqlca.of_connect()
End If

//Alex Gerlants. 06/08/2017. Begin
lb_report_4multiple_customers = False

If ll_customer_id[1] = -99 Then
	lb_report_4multiple_customers = True
Else
	//
End If

If lb_report_4multiple_customers Then
	If IsValid(lds_report_inv_cust_coils) Then Destroy lds_report_inv_cust_coils
	lds_report_inv_cust_coils = Create DataStore
	lds_report_inv_cust_coils.DataObject = "d_report_inv_cust_coils_name"
	li_rtn = lds_report_inv_cust_coils.SetTransObject(sqlca)
	
	ls_sql_orig = lds_report_inv_cust_coils.GetSqlSelect()
	
	If ls_sql_orig <> "" Then
		ll_pos_union_all = Pos(ls_sql_orig, "union all", 1)
		
		If ll_pos_union_all > 0 Then
			ls_sql_orig_part_1 = Left(ls_sql_orig, ll_pos_union_all - 8)
			ls_sql_orig_part_2 = Right(ls_sql_orig, Len(ls_sql_orig) - ll_pos_union_all - 14)
			ls_sql_orig_part_2 = Left(ls_sql_orig_part_2, Len(ls_sql_orig_part_2) - 1)
			
			ls_string_2add = " ~r~n and ( coil.customer_id in (select customer_id from customer where lower(customer_short_name) like lower('%" + as_customer_short_name + "%'))))"
			
			ls_sql_orig_part_1 = ls_sql_orig_part_1 + ls_string_2add
			ls_sql_orig_part_2 = ls_sql_orig_part_2 + ls_string_2add
			
			ls_sql_new = ls_sql_orig_part_1 + "~r~n union all ~r~n" + ls_sql_orig_part_2
			li_rtn_setsqlselect = lds_report_inv_cust_coils.SetSqlSelect(ls_sql_new)
			
			li_rtn = lds_report_inv_cust_coils.SetTransObject(sqlca)
			
			ll_rows = lds_report_inv_cust_coils.Retrieve()
		
			If ll_rows > 0 Then
				of_remove_duplicate_coils(lds_report_inv_cust_coils) //Alex Gerlants. 09/18/2017
				
				//Sort
				lds_report_inv_cust_coils.SetSort("coil_coil_status A, coil_coil_gauge A, coil_coil_width A")
				lds_report_inv_cust_coils.Sort()
				
				//Update title date
				ls_modstring = "date_t.Text = 'All'"
				ls_rtn = lds_report_inv_cust_coils.Modify(ls_modstring)
				
				//Update customer name in report title
				ls_title = lds_report_inv_cust_coils.Describe("title_t.Text")
				ls_customer_name = Upper(as_customer_short_name)
				ls_title = ls_customer_name + " " + ls_title
				ls_modstring = "title_t.Text = '" + ls_title + "'"
				ls_rtn = lds_report_inv_cust_coils.Modify(ls_modstring)
				
				//status_t
				ls_modstring = "status_t.Text = ~"" + "All" + "~""
				ls_rtn = lds_report_inv_cust_coils.Modify(ls_modstring)
				
				//gauge_t
				ls_modstring = "gauge_t.Text = ~"" + "All" + "~""
				ls_rtn = lds_report_inv_cust_coils.Modify(ls_modstring)
				
				//width_t
				ls_modstring = "width_t.Text = ~"" + "All" + "~""
				ls_rtn = lds_report_inv_cust_coils.Modify(ls_modstring)
			
				ls_report_folder = is_work_folder
				
				If Lower(as_filetype_2create) = "pdf" Then
					ls_report_name = "Coils1" + ".pdf"
				ElseIf Lower(as_filetype_2create) = "xls" Then
					ls_report_name = "Coils1"
				End If
				
				If Lower(as_filetype_2create) = "pdf" Then
					of_update_data_export(lds_report_inv_cust_coils)
				End If
				
				If Lower(as_filetype_2create) = "pdf" Then
					li_rtn_saveas = of_saveas(lds_report_inv_cust_coils, ls_report_folder, ls_report_name, "pdf", True)
				ElseIf Lower(as_filetype_2create) = "xls" Then
		
					ls_report_header = ls_customer_name + " " + "Coil Inventory Report"
					
					exporttoexcel_coils(lds_report_inv_cust_coils, ll_rows, ls_report_folder, ls_report_name, ls_report_header)
					
					excel_open_xls_saveas_csv(ls_report_folder, ls_report_name)
				End If
			End if
		End If
	Else
		Return -1
	End If
Else
//Alex Gerlants. 06/08/2017. End

	If IsValid(lds_report_inv_cust_coils) Then Destroy lds_report_inv_cust_coils
	lds_report_inv_cust_coils = Create DataStore
	lds_report_inv_cust_coils.DataObject = "d_report_inv_cust_coils"
	li_rtn = lds_report_inv_cust_coils.SetTransObject(sqlca)
	
	ls_today = String(Today(),"mmddyyyy")
	ls_today = Left(ls_today, 2) + "/" + Mid(ls_today, 3, 2) + "/" + Right(ls_today, 2)
	ls_now = String(Now(),"hhmmss")
	
	ldt_add_from = DateTime(Date("01/01/1980"), Time("00:00:00"))
	ldt_add_to = DateTime(Date("12/31/2050"), Time("23:59:59"))
	
	ld_from = Date("01/01/1980")
	ld_to = Date("12/31/2050")
	
	li_rtn = lds_report_inv_cust_coils.SetTransObject(sqlca)
	
	For ll_i = 1 To UpperBound(ll_customer_id[])
		
		ll_customer_id_temp = ll_customer_id[ll_i]
	
		lds_report_inv_cust_coils.Reset()
		ll_rows = lds_report_inv_cust_coils.Retrieve(ll_customer_id_temp, ldt_add_from, ldt_add_to)
		
		If ll_rows > 0 Then
			of_remove_duplicate_coils(lds_report_inv_cust_coils) //Alex Gerlants. 09/18/2017
			
			ll_counter++
			
			//Sort
			lds_report_inv_cust_coils.SetSort("coil_coil_status A, coil_coil_gauge A, coil_coil_width A")
			lds_report_inv_cust_coils.Sort()
			
			//Update title date
			ls_modstring = "date_t.Text = 'All'"
			ls_rtn = lds_report_inv_cust_coils.Modify(ls_modstring)
			
			//Save title_t
			ls_title = lds_report_inv_cust_coils.Describe("title_t.Text")
			ls_title_save = ls_title
			
			ls_customer_name = of_get_customer_name(ll_customer_id_temp)
			
			//Update customer name in report title
			ls_title = ls_customer_name + ls_title
			ls_modstring = "title_t.Text = '" + ls_title + "'"
			ls_rtn = lds_report_inv_cust_coils.Modify(ls_modstring)
			
			//status_t
			ls_modstring = "status_t.Text = ~"" + "All" + "~""
			ls_rtn = lds_report_inv_cust_coils.Modify(ls_modstring)
			
			//gauge_t
			ls_modstring = "gauge_t.Text = ~"" + "All" + "~""
			ls_rtn = lds_report_inv_cust_coils.Modify(ls_modstring)
			
			//width_t
			ls_modstring = "width_t.Text = ~"" + "All" + "~""
			ls_rtn = lds_report_inv_cust_coils.Modify(ls_modstring)
		
			ls_report_folder = is_work_folder
			
			If Lower(as_filetype_2create) = "pdf" Then
				ls_report_name = "Coils" + String(ll_counter) + ".pdf"
			ElseIf Lower(as_filetype_2create) = "xls" Then
				//ls_report_name = "Coils" + String(ll_i) + ".xls"
				ls_report_name = "Coils" + String(ll_counter)
			End If
			
			If Lower(as_filetype_2create) = "pdf" Then
				of_update_data_export(lds_report_inv_cust_coils)
			End If
			
			If Lower(as_filetype_2create) = "pdf" Then
				li_rtn_saveas = of_saveas(lds_report_inv_cust_coils, ls_report_folder, ls_report_name, "pdf", True)
			ElseIf Lower(as_filetype_2create) = "xls" Then
	
				ls_report_header = ls_customer_name + " " + "Coil Inventory Report"
				
				exporttoexcel_coils(lds_report_inv_cust_coils, ll_rows, ls_report_folder, ls_report_name, ls_report_header)
				
				excel_open_xls_saveas_csv(ls_report_folder, ls_report_name)
			End If
			
			//Reinstate report title
			ls_title = ls_title_save
			ls_modstring = "title_t.Text = '" + ls_title + "'"
			ls_rtn = lds_report_inv_cust_coils.Modify(ls_modstring)
			ls_title_save = ""
		End If
	Next
	
	If IsValid(lds_report_inv_cust_coils) Then Destroy lds_report_inv_cust_coils
End If //Alex Gerlants. 06/08/2017

SetPointer(Arrow!)
	
return 1
end function

on nv_test.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nv_test.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

