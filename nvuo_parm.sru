$PBExportHeader$nvuo_parm.sru
$PBExportComments$To pass parameters between objects
forward
global type nvuo_parm from nonvisualobject
end type
end forward

global type nvuo_parm from nonvisualobject autoinstantiate
end type

type variables
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// How to use: http://powerbuilder.us/parm_old.htm
// Licence: No licence needed, this utility is absolutely free for any use
// Developer: Alex Gerlants - http://ca.linkedin.com/in/zuskin
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

private:

	int					ii_int_values[] // passed parameters' values (like 1972, 185)
	string				is_int_names[] // passed parameters' names (like 'birth_year', 'height')

	long					il_long_values[]
	string				is_long_names[]

	dec					idc_dec_values[]
	string				is_dec_names[]

	double				idb_double_values[]
	string				is_double_names[]

	real					ir_real_values[]
	string				is_real_names[]

	string				is_string_values[]
	string				is_string_names[]

	char					ic_char_values[]
	string				is_char_names[]

	date					id_date_values[]
	string				is_date_names[]

	time					it_time_values[]
	string				is_time_names[]

	datetime				idt_datetime_values[]
	string				is_datetime_names[]

	boolean				ib_boolean_values[]
	string				is_boolean_names[]
	
	any					ia_any_values[]
	string				is_any_names[]
	
	NonVisualObject	inv_nvo_values[]
	string				is_nvo_names[]
	
	GraphicObject		igo_go_values[]
	string				is_go_names[]

	Window				iw_win_values[]
	string				is_win_names[]

	DataWindow			idw_dw_values[]
	string				is_dw_names[]

	DataStore			ids_ds_values[]
	string				is_ds_names[]
	
	uint					iui_idx
	uint					iui_upper_bound
end variables

forward prototypes
public function long uf_get_l (string as_parm_name)
public subroutine uf_set_l (string as_parm_name, long al_val)
public function string uf_get_s (string as_parm_name)
public function decimal uf_get_dc (string as_parm_name)
public function datetime uf_get_dt (string as_parm_name)
public subroutine uf_set_dc (string as_parm_name, decimal adc_val)
public subroutine uf_set_s (string as_parm_name, string as_val)
public subroutine uf_set_b (string as_parm_name, boolean ab_val)
public function integer uf_get_i (string as_parm_name)
public subroutine uf_set_i (string as_parm_name, integer ai_val)
public subroutine uf_set_dt (string as_parm_name, datetime adt_val)
public subroutine uf_set_d (string as_parm_name, date ad_val)
public subroutine uf_set_t (string as_parm_name, time at_val)
public function time uf_get_t (string as_parm_name)
public subroutine uf_set_db (string as_parm_name, double adb_val)
public subroutine uf_set_c (string as_parm_name, character ac_val)
public subroutine uf_set_r (string as_parm_name, real ar_val)
public function real uf_get_r (string as_parm_name)
public subroutine uf_set_a (string as_parm_name, any aa_val)
public function datastore uf_get_ds (string as_parm_name)
public subroutine uf_set_ds (string as_parm_name, datastore ads_val)
public subroutine uf_set_dw (string as_parm_name, datawindow adw_val)
public subroutine uf_set_w (string as_parm_name, window aw_val)
public function datawindow uf_get_dw (string as_parm_name)
public function double uf_get_db (string as_parm_name)
public function date uf_get_d (string as_parm_name)
public function character uf_get_c (string as_parm_name)
public function boolean uf_get_b (string as_parm_name)
public function any uf_get_a (string as_parm_name)
public function window uf_get_w (string as_parm_name)
public function nonvisualobject uf_get_nv (string as_parm_name)
public subroutine uf_set_nv (string as_parm_name, nonvisualobject anv_val)
public function graphicobject uf_get_go (string as_parm_name)
public subroutine uf_set_go (string as_parm_name, graphicobject ago_val)
end prototypes

public function long uf_get_l (string as_parm_name);/*******************************************************************************************
Dsc: returns value of parameter of type 'long'
--------------------------------------------------------------------------------------------
Arg: as_parm_name
--------------------------------------------------------------------------------------------
Ret: long
********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
as_parm_name = Lower(Trim(as_parm_name))

iui_upper_bound = UpperBound(il_long_values)
for iui_idx = 1 to iui_upper_bound
	if is_long_names[iui_idx] = as_parm_name then
		return il_long_values[iui_idx]
	end if
next
								// If this code reached then the parm doesn't exist:
long	ll_null
SetNull(ll_null)
return ll_null
end function

public subroutine uf_set_l (string as_parm_name, long al_val);/*******************************************************************************************
Dsc: adds parameter of type 'long'
--------------------------------------------------------------------------------------------
Arg: as_parm_name, al_val - parameter's value
--------------------------------------------------------------------------------------------
Ret: none
********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
as_parm_name = Lower(Trim(as_parm_name))
if IsNull(as_parm_name) or as_parm_name = '' then return
								// If this parm already exists then update it with the new value:
iui_upper_bound = UpperBound(il_long_values)
for iui_idx = 1 to iui_upper_bound
	if is_long_names[iui_idx] = as_parm_name then
		il_long_values[iui_idx] = al_val
		return
	end if
next
								// If this code reached then this parm doesn't exist yet; add it:
iui_upper_bound++
is_long_names[iui_upper_bound] = as_parm_name
il_long_values[iui_upper_bound] = al_val
end subroutine

public function string uf_get_s (string as_parm_name);/*******************************************************************************************
Dsc: returns value of parameter of type 'string'
--------------------------------------------------------------------------------------------
Arg: as_parm_name
--------------------------------------------------------------------------------------------
Ret: string
********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
as_parm_name = Lower(Trim(as_parm_name))

iui_upper_bound = UpperBound(is_string_values)
for iui_idx = 1 to iui_upper_bound
	if is_string_names[iui_idx] = as_parm_name then
		return is_string_values[iui_idx]
	end if
next
								// If this code reached then the parm doesn't exist:
string	ls_null
SetNull(ls_null)
return ls_null
end function

public function decimal uf_get_dc (string as_parm_name);/*******************************************************************************************
Dsc: returns value of parameter of type 'decimal'
--------------------------------------------------------------------------------------------
Arg: as_parm_name
--------------------------------------------------------------------------------------------
Ret: decimal
********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
dec	ldc_null

as_parm_name = Lower(Trim(as_parm_name))

iui_upper_bound = UpperBound(idc_dec_values)
for iui_idx = 1 to iui_upper_bound
	if is_dec_names[iui_idx] = as_parm_name then
		return idc_dec_values[iui_idx]
	end if
next
								// If this code reached then the parm doesn't exist:
SetNull(ldc_null)
return ldc_null
end function

public function datetime uf_get_dt (string as_parm_name);/*******************************************************************************************
Dsc: returns value of parameter of type 'datetime'
--------------------------------------------------------------------------------------------
Arg: as_parm_name
--------------------------------------------------------------------------------------------
Ret: datetime
********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
datetime	ldt_null

as_parm_name = Lower(Trim(as_parm_name))

iui_upper_bound = UpperBound(idt_datetime_values)
for iui_idx = 1 to iui_upper_bound
	if is_datetime_names[iui_idx] = as_parm_name then
		return idt_datetime_values[iui_idx]
	end if
next
								// If this code reached then the parm doesn't exist:
SetNull(ldt_null)
return ldt_null
end function

public subroutine uf_set_dc (string as_parm_name, decimal adc_val);/*******************************************************************************************
Dsc: adds parameter of type 'dec'
--------------------------------------------------------------------------------------------
Arg: as_parm_name, adc_val - parameter's value
--------------------------------------------------------------------------------------------
Ret: none
********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
as_parm_name = Lower(Trim(as_parm_name))
if IsNull(as_parm_name) or as_parm_name = "" then return
								// If this parm already exists then update it with the new value:
iui_upper_bound = UpperBound(idc_dec_values)
for iui_idx = 1 to iui_upper_bound
	if is_dec_names[iui_idx] = as_parm_name then
		idc_dec_values[iui_idx] = adc_val
		return
	end if
next
								// If this code reached then this parm doesn't exist yet; add it:
iui_upper_bound++
is_dec_names[iui_upper_bound] = as_parm_name
idc_dec_values[iui_upper_bound] = adc_val
end subroutine

public subroutine uf_set_s (string as_parm_name, string as_val);/*******************************************************************************************
Dsc: adds parameter of type 'string'
--------------------------------------------------------------------------------------------
Arg: as_parm_name, as_val - parameter's value
--------------------------------------------------------------------------------------------
Ret: none
********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
as_parm_name = Lower(Trim(as_parm_name))
if IsNull(as_parm_name) or as_parm_name = '' then return
								// If this parm already exists then update it with the new value:
iui_upper_bound = UpperBound(is_string_values)
for iui_idx = 1 to iui_upper_bound
	if is_string_names[iui_idx] = as_parm_name then
		is_string_values[iui_idx] = as_val
		return
	end if
next
								// If this code reached then this parm doesn't exist yet; add it:
iui_upper_bound++
is_string_names[iui_upper_bound] = as_parm_name
is_string_values[iui_upper_bound] = as_val
end subroutine

public subroutine uf_set_b (string as_parm_name, boolean ab_val);/*******************************************************************************************
Dsc: adds parameter of type 'boolean'
--------------------------------------------------------------------------------------------
Arg: as_parm_name, ab_val - parameter's value
--------------------------------------------------------------------------------------------
Ret: none
********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
as_parm_name = Lower(Trim(as_parm_name))
if IsNull(as_parm_name) or as_parm_name = "" then return
								// If this parm already exists then update it with the new value:
iui_upper_bound = UpperBound(ib_boolean_values)
for iui_idx = 1 to iui_upper_bound
	if is_boolean_names[iui_idx] = as_parm_name then
		ib_boolean_values[iui_idx] = ab_val
		return
	end if
next
								// If this code reached then this parm doesn't exist yet; add it:
iui_upper_bound++
is_boolean_names[iui_upper_bound] = as_parm_name
ib_boolean_values[iui_upper_bound] = ab_val
end subroutine

public function integer uf_get_i (string as_parm_name);/*******************************************************************************************
Dsc: returns value of parameter of type 'integer'
--------------------------------------------------------------------------------------------
Arg: as_parm_name
--------------------------------------------------------------------------------------------
Ret: int
********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
as_parm_name = Lower(Trim(as_parm_name))

iui_upper_bound = UpperBound(ii_int_values)
for iui_idx = 1 to iui_upper_bound
	if is_int_names[iui_idx] = as_parm_name then
		return ii_int_values[iui_idx]
	end if
next
								// If this code reached then the parm doesn't exist:
int	li_null
SetNull(li_null)
return li_null
end function

public subroutine uf_set_i (string as_parm_name, integer ai_val);/*******************************************************************************************
Dsc: adds parameter of type 'datastore'
--------------------------------------------------------------------------------------------
Arg: as_parm_name, ai_val - parameter's value
--------------------------------------------------------------------------------------------
Ret: none
********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
as_parm_name = Lower(Trim(as_parm_name))
if IsNull(as_parm_name) or as_parm_name = "" then return
								// If this parm already exists then update it with the new value:
iui_upper_bound = UpperBound(ii_int_values)
for iui_idx = 1 to iui_upper_bound
	if is_int_names[iui_idx] = as_parm_name then
		ii_int_values[iui_idx] = ai_val
		return
	end if
next
								// If this code reached then this parm doesn't exist yet; add it:
iui_upper_bound++
is_int_names[iui_upper_bound] = as_parm_name
ii_int_values[iui_upper_bound] = ai_val
end subroutine

public subroutine uf_set_dt (string as_parm_name, datetime adt_val);/*******************************************************************************************
Dsc: adds parameter of type 'datetime'
--------------------------------------------------------------------------------------------
Arg: as_parm_name, adt_val - parameter's value
--------------------------------------------------------------------------------------------
Ret: none
********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
as_parm_name = Lower(Trim(as_parm_name))
if IsNull(as_parm_name) or as_parm_name = "" then return
								// If this parm already exists then update it with the new value:
iui_upper_bound = UpperBound(idt_datetime_values)
for iui_idx = 1 to iui_upper_bound
	if is_datetime_names[iui_idx] = as_parm_name then
		idt_datetime_values[iui_idx] = adt_val
		return
	end if
next
								// If this code reached then this parm doesn't exist yet; add it
iui_upper_bound++
is_datetime_names[iui_upper_bound] = as_parm_name
idt_datetime_values[iui_upper_bound] = adt_val
end subroutine

public subroutine uf_set_d (string as_parm_name, date ad_val);/*******************************************************************************************
Dsc: adds parameter of type 'date'
--------------------------------------------------------------------------------------------
Arg: as_parm_name, ad_val - parameter's value
--------------------------------------------------------------------------------------------
Ret: none
********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
as_parm_name = Lower(Trim(as_parm_name))
if IsNull(as_parm_name) or as_parm_name = "" then return
								// If this parm already exists then update it with the new value:
iui_upper_bound = UpperBound(id_date_values)
for iui_idx = 1 to iui_upper_bound
	if is_date_names[iui_idx] = as_parm_name then
		id_date_values[iui_idx] = ad_val
		return
	end if
next
								// If this code reached then this parm doesn't exist yet; add it:
iui_upper_bound++
is_date_names[iui_upper_bound] = as_parm_name
id_date_values[iui_upper_bound] = ad_val
end subroutine

public subroutine uf_set_t (string as_parm_name, time at_val);/*******************************************************************************************
Dsc: adds parameter of type 'time'
--------------------------------------------------------------------------------------------
Arg: as_parm_name, at_val - parameter's value
--------------------------------------------------------------------------------------------
Ret: none
********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
as_parm_name = Lower(Trim(as_parm_name))
if IsNull(as_parm_name) or as_parm_name = '' then return
								// If this parm already exists then update it with the new value:
iui_upper_bound = UpperBound(it_time_values)
for iui_idx = 1 to iui_upper_bound
	if is_time_names[iui_idx] = as_parm_name then
		it_time_values[iui_idx] = at_val
		return
	end if
next
								// If this code reached then this parm doesn't exist yet; add it:
iui_upper_bound++
is_time_names[iui_upper_bound] = as_parm_name
it_time_values[iui_upper_bound] = at_val
end subroutine

public function time uf_get_t (string as_parm_name);/*******************************************************************************************
Dsc: returns value of parameter of type 'time'
--------------------------------------------------------------------------------------------
Arg: as_parm_name
--------------------------------------------------------------------------------------------
Ret: time
********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
as_parm_name = Lower(Trim(as_parm_name))

iui_upper_bound = UpperBound(it_time_values)
for iui_idx = 1 to iui_upper_bound
	if is_time_names[iui_idx] = as_parm_name then
		return it_time_values[iui_idx]
	end if
next
								// If this code reached then the parm doesn't exist:
time	lt_null
SetNull(lt_null)
return lt_null
end function

public subroutine uf_set_db (string as_parm_name, double adb_val);/*******************************************************************************************
Dsc: adds parameter of type 'double'
--------------------------------------------------------------------------------------------
Arg: as_parm_name, adb_val - parameter's value
--------------------------------------------------------------------------------------------
Ret: none


********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
as_parm_name = Lower(Trim(as_parm_name))
if IsNull(as_parm_name) or as_parm_name = "" then return
								// If this parm already exists then update it with the new value:
iui_upper_bound = UpperBound(idb_double_values)
for iui_idx = 1 to iui_upper_bound
	if is_double_names[iui_idx] = as_parm_name then
		idb_double_values[iui_idx] = adb_val
		return
	end if
next
								// If this code reached then this parm doesn't exist yet; add it:
iui_upper_bound++
is_double_names[iui_upper_bound] = as_parm_name
idb_double_values[iui_upper_bound] = adb_val
end subroutine

public subroutine uf_set_c (string as_parm_name, character ac_val);/*******************************************************************************************
Dsc: adds parameter of type 'char'
--------------------------------------------------------------------------------------------
Arg: as_parm_name, ac_val - parameter's value
--------------------------------------------------------------------------------------------
Ret: none
********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
as_parm_name = Lower(Trim(as_parm_name))
if IsNull(as_parm_name) or as_parm_name = "" then return
								// If this parm already exists then update it with the new value:
iui_upper_bound = UpperBound(ic_char_values)
for iui_idx = 1 to iui_upper_bound
	if is_char_names[iui_idx] = as_parm_name then
		ic_char_values[iui_idx] = ac_val
		return
	end if
next
								// If this code reached then this parm doesn't exist yet; add it:
iui_upper_bound++
is_char_names[iui_upper_bound] = as_parm_name
ic_char_values[iui_upper_bound] = ac_val
end subroutine

public subroutine uf_set_r (string as_parm_name, real ar_val);/*******************************************************************************************
Dsc: adds parameter of type 'real'
--------------------------------------------------------------------------------------------
Arg: as_parm_name, ar_val - parameter's value
--------------------------------------------------------------------------------------------
Ret: none
********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
as_parm_name = Lower(Trim(as_parm_name))
if IsNull(as_parm_name) or as_parm_name = '' then return
								// If this parm already exists then update it with the new value:
iui_upper_bound = UpperBound(ir_real_values)
for iui_idx = 1 to iui_upper_bound
	if is_real_names[iui_idx] = as_parm_name then
		ir_real_values[iui_idx] = ar_val
		return
	end if
next
								// If this code reached then this parm doesn't exist yet; add it:
iui_upper_bound++
is_real_names[iui_upper_bound] = as_parm_name
ir_real_values[iui_upper_bound] = ar_val
end subroutine

public function real uf_get_r (string as_parm_name);/*******************************************************************************************
Dsc: returns value of parameter of type 'real'
--------------------------------------------------------------------------------------------
Arg: as_parm_name
--------------------------------------------------------------------------------------------
Ret: real
********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
as_parm_name = Lower(Trim(as_parm_name))

iui_upper_bound = UpperBound(ir_real_values)
for iui_idx = 1 to iui_upper_bound
	if is_real_names[iui_idx] = as_parm_name then
		return ir_real_values[iui_idx]
	end if
next
								// If this code reached then the parm doesn't exist:
real	lr_null
SetNull(lr_null)
return lr_null
end function

public subroutine uf_set_a (string as_parm_name, any aa_val);/*******************************************************************************************
Dsc: adds parameter of type 'any'
--------------------------------------------------------------------------------------------
Arg: as_parm_name, aa_val - parameter's value
--------------------------------------------------------------------------------------------
Ret: none
********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
as_parm_name = Lower(Trim(as_parm_name))
if IsNull(as_parm_name) or as_parm_name = "" then return
								// If this parm already exists then update it with the new value:
iui_upper_bound = UpperBound(ia_any_values)
for iui_idx = 1 to iui_upper_bound
	if is_any_names[iui_idx] = as_parm_name then
		ia_any_values[iui_idx] = aa_val
		return
	end if
next
								// If this code reached then this parm doesn't exist yet; add it:
iui_upper_bound++
is_any_names[iui_upper_bound] = as_parm_name
ia_any_values[iui_upper_bound] = aa_val
end subroutine

public function datastore uf_get_ds (string as_parm_name);/*******************************************************************************************
Dsc: returns value of parameter of type 'DataStore'
--------------------------------------------------------------------------------------------
Arg: as_parm_name
--------------------------------------------------------------------------------------------
Ret: DataStore
********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
DataStore	lds_null

as_parm_name = Lower(Trim(as_parm_name))

iui_upper_bound = UpperBound(ids_ds_values)
for iui_idx = 1 to iui_upper_bound
	if is_ds_names[iui_idx] = as_parm_name then
		return ids_ds_values[iui_idx]
	end if
next
								// If this code reached then the parm doesn't exist:
return lds_null
end function

public subroutine uf_set_ds (string as_parm_name, datastore ads_val);/*******************************************************************************************
Dsc: adds parameter of type 'DataStore'
--------------------------------------------------------------------------------------------
Arg: as_parm_name, ads_val - parameter's value
--------------------------------------------------------------------------------------------
Ret: none
********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
as_parm_name = Lower(Trim(as_parm_name))
if IsNull(as_parm_name) or as_parm_name = "" then return
								// If this parm already exists then update it with the new value:
iui_upper_bound = UpperBound(ids_ds_values)
for iui_idx = 1 to iui_upper_bound
	if is_ds_names[iui_idx] = as_parm_name then
		ids_ds_values[iui_idx] = ads_val
		return
	end if
next
								// If this code reached then this parm doesn't exist yet; add it:
iui_upper_bound++
is_ds_names[iui_upper_bound] = as_parm_name
ids_ds_values[iui_upper_bound] = ads_val
end subroutine

public subroutine uf_set_dw (string as_parm_name, datawindow adw_val);/*******************************************************************************************
Dsc: adds parameter of type 'DataWindow'
--------------------------------------------------------------------------------------------
Arg: as_parm_name, adw_val - parameter's value
--------------------------------------------------------------------------------------------
Ret: none
********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
as_parm_name = Lower(Trim(as_parm_name))
if IsNull(as_parm_name) or as_parm_name = "" then return
								// If this parm already exists then update it with the new value:
iui_upper_bound = UpperBound(idw_dw_values)
for iui_idx = 1 to iui_upper_bound
	if is_dw_names[iui_idx] = as_parm_name then
		idw_dw_values[iui_idx] = adw_val
		return
	end if
next
								// If this code reached then this parm doesn't exist yet; add it:
iui_upper_bound++
is_dw_names[iui_upper_bound] = as_parm_name
idw_dw_values[iui_upper_bound] = adw_val
end subroutine

public subroutine uf_set_w (string as_parm_name, window aw_val);/*******************************************************************************************
Dsc: adds parameter of type 'Window'
--------------------------------------------------------------------------------------------
Arg: as_parm_name, aw_val - parameter's value
--------------------------------------------------------------------------------------------
Ret: none
********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
as_parm_name = Lower(Trim(as_parm_name))
if IsNull(as_parm_name) or as_parm_name = '' then return
								// If this parm already exists then update it with the new value:
iui_upper_bound = UpperBound(iw_win_values)
for iui_idx = 1 to iui_upper_bound
	if is_win_names[iui_idx] = as_parm_name then
		iw_win_values[iui_idx] = aw_val
		return
	end if
next
								// If this code reached then this parm doesn't exist yet; add it:
iui_upper_bound++
is_win_names[iui_upper_bound] = as_parm_name
iw_win_values[iui_upper_bound] = aw_val
end subroutine

public function datawindow uf_get_dw (string as_parm_name);/*******************************************************************************************
Dsc: returns value of parameter of type 'DataWindow'
--------------------------------------------------------------------------------------------
Arg: as_parm_name
--------------------------------------------------------------------------------------------
Ret: DataWindow
********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
DataWindow	ldw_null

as_parm_name = Lower(Trim(as_parm_name))

iui_upper_bound = UpperBound(idw_dw_values)
for iui_idx = 1 to iui_upper_bound
	if is_dw_names[iui_idx] = as_parm_name then
		return idw_dw_values[iui_idx]
	end if
next
								// If this code reached then the parm doesn't exist:
return ldw_null
end function

public function double uf_get_db (string as_parm_name);/*******************************************************************************************
Dsc: returns value of parameter of type 'double'
--------------------------------------------------------------------------------------------
Arg: as_parm_name
--------------------------------------------------------------------------------------------
Ret: double
********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
double	ldb_null

as_parm_name = Lower(Trim(as_parm_name))

iui_upper_bound = UpperBound(idb_double_values)
for iui_idx = 1 to iui_upper_bound
	if is_double_names[iui_idx] = as_parm_name then
		return idb_double_values[iui_idx]
	end if
next
								// If this code reached then the parm doesn't exist:
SetNull(ldb_null)
return ldb_null
end function

public function date uf_get_d (string as_parm_name);/*******************************************************************************************
Dsc: returns value of parameter of type 'date'
--------------------------------------------------------------------------------------------
Arg: as_parm_name
--------------------------------------------------------------------------------------------
Ret: date
********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
date	ld_null

as_parm_name = Lower(Trim(as_parm_name))

iui_upper_bound = UpperBound(id_date_values)
for iui_idx = 1 to iui_upper_bound
	if is_date_names[iui_idx] = as_parm_name then
		return id_date_values[iui_idx]
	end if
next
								// If this code reached then the parm doesn't exist:
SetNull(ld_null)
return ld_null
end function

public function character uf_get_c (string as_parm_name);/*******************************************************************************************
Dsc: returns value of parameter of type 'char'
--------------------------------------------------------------------------------------------
Arg: as_parm_name
--------------------------------------------------------------------------------------------
Ret: char
********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
char	lc_null

as_parm_name = Lower(Trim(as_parm_name))

iui_upper_bound = UpperBound(ic_char_values)
for iui_idx = 1 to iui_upper_bound
	if is_char_names[iui_idx] = as_parm_name then
		return ic_char_values[iui_idx]
	end if
next
								// If this code reached then the parm doesn't exist:
SetNull(lc_null)
return lc_null
end function

public function boolean uf_get_b (string as_parm_name);/*******************************************************************************************
Dsc: returns value of parameter of type 'boolean'
--------------------------------------------------------------------------------------------
Arg: as_parm_name
--------------------------------------------------------------------------------------------
Ret: boolean
********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
boolean	lb_null

as_parm_name = Lower(Trim(as_parm_name))

iui_upper_bound = UpperBound(ib_boolean_values)
for iui_idx = 1 to iui_upper_bound
	if is_boolean_names[iui_idx] = as_parm_name then
		return ib_boolean_values[iui_idx]
	end if
next
								// If this code reached then the parm doesn't exist:
SetNull(lb_null)
return lb_null
end function

public function any uf_get_a (string as_parm_name);/*******************************************************************************************
Dsc: returns value of parameter of type 'any'
--------------------------------------------------------------------------------------------
Arg: as_parm_name
--------------------------------------------------------------------------------------------
Ret: any
********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
any	la_null

as_parm_name = Lower(Trim(as_parm_name))

iui_upper_bound = UpperBound(ia_any_values)
for iui_idx = 1 to iui_upper_bound
	if is_any_names[iui_idx] = as_parm_name then
		return ia_any_values[iui_idx]
	end if
next
								// If this code reached then the parm doesn't exist:
return la_null
end function

public function window uf_get_w (string as_parm_name);/*******************************************************************************************
Dsc: returns value of parameter of type 'Window'
--------------------------------------------------------------------------------------------
Arg: as_parm_name
--------------------------------------------------------------------------------------------
Ret: Window
********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
as_parm_name = Lower(Trim(as_parm_name))

iui_upper_bound = UpperBound(iw_win_values)
for iui_idx = 1 to iui_upper_bound
	if is_win_names[iui_idx] = as_parm_name then
		return iw_win_values[iui_idx]
	end if
next
								// If this code reached then the parm doesn't exist:
Window	lw_null

return lw_null
end function

public function nonvisualobject uf_get_nv (string as_parm_name);/*******************************************************************************************
Dsc: returns value of parameter of type 'NonVisualObject'
--------------------------------------------------------------------------------------------
Arg: as_parm_name
--------------------------------------------------------------------------------------------
Ret: NonVisualObject
********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
as_parm_name = Lower(Trim(as_parm_name))

iui_upper_bound = UpperBound(inv_nvo_values)
for iui_idx = 1 to iui_upper_bound
	if is_nvo_names[iui_idx] = as_parm_name then
		return inv_nvo_values[iui_idx]
	end if
next
								// If this code reached then the parm doesn't exist:
NonVisualObject	lnvuo_null

return lnvuo_null
end function

public subroutine uf_set_nv (string as_parm_name, nonvisualobject anv_val);/*******************************************************************************************
Dsc: adds parameter of type 'NonVisualObject'
--------------------------------------------------------------------------------------------
Arg: as_parm_name, anv_val - parameter's value
--------------------------------------------------------------------------------------------
Ret: none
********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
as_parm_name = Lower(Trim(as_parm_name))
if IsNull(as_parm_name) or as_parm_name = '' then return
								// If this parm already exists then update it with the new value:
iui_upper_bound = UpperBound(inv_nvo_values)
for iui_idx = 1 to iui_upper_bound
	if is_nvo_names[iui_idx] = as_parm_name then
		inv_nvo_values[iui_idx] = anv_val
		return
	end if
next
								// If this code reached then this parm doesn't exist yet; add it:
iui_upper_bound++
is_nvo_names[iui_upper_bound] = as_parm_name
inv_nvo_values[iui_upper_bound] = anv_val
end subroutine

public function graphicobject uf_get_go (string as_parm_name);/*******************************************************************************************
Dsc: returns value of parameter of type 'GraphicObject'
--------------------------------------------------------------------------------------------
Arg: as_parm_name
--------------------------------------------------------------------------------------------
Ret: GraphicObject
********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
GraphicObject	lgo_null

as_parm_name = Lower(Trim(as_parm_name))

iui_upper_bound = UpperBound(igo_go_values)
for iui_idx = 1 to iui_upper_bound
	if is_go_names[iui_idx] = as_parm_name then
		return igo_go_values[iui_idx]
	end if
next
								// If this code reached then the parm doesn't exist:
return lgo_null
end function

public subroutine uf_set_go (string as_parm_name, graphicobject ago_val);/*******************************************************************************************
Dsc: adds parameter of type 'DataWindow'
--------------------------------------------------------------------------------------------
Arg: as_parm_name, adw_val - parameter's value
--------------------------------------------------------------------------------------------
Ret: none
********************************************************************************************
Log: Date:		Name:					Development Description:
--------------------------------------------------------------------------------------------
	  10/17/2016	Alex Gerlants		Initial version
*******************************************************************************************/
as_parm_name = Lower(Trim(as_parm_name))
if IsNull(as_parm_name) or as_parm_name = "" then return
								// If this parm already exists then update it with the new value:
iui_upper_bound = UpperBound(igo_go_values)
for iui_idx = 1 to iui_upper_bound
	if is_go_names[iui_idx] = as_parm_name then
		igo_go_values[iui_idx] = ago_val
		return
	end if
next
								// If this code reached then this parm doesn't exist yet; add it:
iui_upper_bound++
is_go_names[iui_upper_bound] = as_parm_name
igo_go_values[iui_upper_bound] = ago_val
end subroutine

on nvuo_parm.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nvuo_parm.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

