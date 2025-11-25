$PBExportHeader$u_security.sru
$PBExportComments$modified pfc_n_cst_security object in pfcapsrv.pbl
forward
global type u_security from nonvisualobject
end type
end forward

type str_menu from structure
	menu		mnu
	boolean		override
end type

global type u_security from nonvisualobject
end type
global u_security u_security

type variables
Protected:
n_ds		ids_items
n_ds 		ids_info
n_ds 		ids_apps
n_ds		ids_groups
n_ds 		ids_updates
n_cst_string 	inv_string
long		il_numberofrows
string		is_liblist[]
string 		is_app
string 		is_userID
string 		is_defaultgroup
integer 		ii_libcnt
integer		ii_numgroups
string 		is_keyword = 'microhelp'
string 		is_separator = ';'
string 		is_disabledborder = '0'
boolean		ib_initsecurity = false
boolean 		ib_initscanning = false
n_tr		itr_trans
end variables

forward prototypes
public function string of_gettype (windowobject a_object, ref string as_desc)
protected function boolean of_FindEntry (string as_win, string as_object)
protected function string of_GetTag (string as_tag)
protected function boolean of_LoadSecurity (string as_win)
public function boolean of_SetSecurity (window aw_win)
protected function integer of_scandatawindow (string as_win_name, datawindow adw_scan, string as_object)
public function integer of_initscanprocess (n_tr a_trans, string as_app, string as_lib_list[])
public function integer of_initsecurity (n_tr a_trans, string as_app, string as_user_id, string as_default_group)
public function integer of_scanwindow (window aw_win)
protected function integer of_addobject (string as_app, string as_winname, string as_object, string as_objecttype, string as_desc)
protected function integer of_scancontrolarray (string as_win_name, windowobject ao_objects[], string as_object_name)
protected function integer of_setcontrolarray (string as_window, graphicobject ao_objects[], string as_object_name)
protected function integer of_setcontrolstatus (graphicobject a_item, string as_window, string as_object)
protected function integer of_setmenustatus (ref menu am_item, string as_window, boolean ab_override)
protected function integer of_setstate (string as_win, string as_itemname, ref boolean ab_enabled, ref boolean ab_visible)
end prototypes

public function string of_gettype (windowobject a_object, ref string as_desc);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetType
//
//	Access:  public
//
//	Arguments:
//	a_object : windowobject ; Object that we want to determine the type of
//
//	Returns:  String
//	Name of the object type
//
//	Description:  Provide ASCII format of typeof() function return
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996 Powersoft Corporation.  All Rights Reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Powersoft is prohibited.
//
//////////////////////////////////////////////////////////////////////////////


choose case typeof(a_object) 
	case commandbutton!
		commandbutton l_cb
		l_cb = a_object
		as_desc = l_cb.text
		if as_desc = '' then as_desc = of_GetTag(l_cb.tag)
		return 'CommandButton'
	case checkbox!
		checkbox l_cbx
		l_cbx = a_object
		as_desc = l_cbx.text
		if as_desc = '' then as_desc = of_GetTag(l_cbx.tag)
		return 'CheckBox'
	case radiobutton!
		radiobutton l_rb
		l_rb = a_object
		as_desc = l_rb.text
		if as_desc = '' then as_desc = of_GetTag(l_rb.tag)
		return 'RadioButton'
	case datawindow!
		datawindow l_dw
		l_dw = a_object
		as_desc = l_dw.title
		if as_desc = '' then as_desc = of_GetTag(l_dw.tag)
		return 'DataWindow'
	case userobject!
		userobject l_uo
		l_uo = a_object
		as_desc = l_uo.text
		if as_desc = '' then as_desc = of_GetTag(l_uo.tag)
		return 'UserObject'
	case tab!
		as_desc = of_GetTag(a_object.tag)
		return 'Tab'
	case listbox!
		as_desc = of_GetTag(a_object.tag)
		return 'ListBox'
	case dropdownlistbox!
		dropdownlistbox l_ddlb
		l_ddlb = a_object
		as_desc = l_ddlb.text
		if as_desc = '' then as_desc = of_GetTag(l_ddlb.tag)
		return 'DropDownListBox'
	case dropdownpicturelistbox!
		dropdownpicturelistbox l_ddplb
		l_ddplb = a_object
		as_desc = l_ddplb.text
		if as_desc = '' then as_desc = of_GetTag(l_ddplb.tag)
		return 'DropDownPictureListBox'
	case singlelineedit!
		singlelineedit l_sle
		l_sle = a_object
		as_desc = l_sle.text
		if as_desc = '' then as_desc = of_GetTag(l_sle.tag)
		return 'SingleLineEdit'
	case multilineedit!
		multilineedit l_mle
		l_mle = a_object
		as_desc = l_mle.text
		if as_desc = '' then as_desc = of_GetTag(l_mle.tag)
		return 'MultiLineEdit'
	case  editmask!
		editmask l_em
		l_em = a_object
		as_desc = l_em.text
		if as_desc = '' then as_desc = of_GetTag(l_em.tag)
		return 'EditMask'
	case picturelistbox!
		as_desc = of_GetTag(a_object.tag)
		return 'PictureListBox'
	case richtextedit!
		as_desc = of_GetTag(a_object.tag)
		return 'RichTextEdit'
	case statictext!
		statictext l_st
		l_st = a_object
		as_desc = l_st.text
		if as_desc = '' then as_desc = of_GetTag(l_st.tag)
		return 'StaticText'
	case groupbox!
		groupbox l_gb
		l_gb = a_object
		as_desc = l_gb.text
		if as_desc = '' then as_desc = of_GetTag(l_gb.tag)
		return 'GroupBox'
	case treeview!
		as_desc = of_GetTag(a_object.tag)
		return 'TreeView'
	case listview!
		as_desc = of_GetTag(a_object.tag)
		return 'ListView'
	case olecontrol!
		as_desc = of_GetTag(a_object.tag)
		if as_desc = '' then
			olecontrol l_ole
			l_ole = a_object
//			as_desc = l_ole.classshortname
		end if
		return 'OLE Control'
	case olecustomcontrol!
		as_desc = of_GetTag(a_object.tag)
		if as_desc = '' then
			olecustomcontrol l_ocx
			l_ocx = a_object
//			as_desc = l_ocx.classshortname
		end if
		return 'OCX'
	case picturebutton!
		picturebutton l_pb
		l_pb = a_object
		as_desc = l_pb.text
		if as_desc = '' then as_desc = of_GetTag(l_pb.tag)
		return 'PictureButton'
	case graph!
		graph l_graph
		l_graph = a_object
		as_desc = l_graph.title
		if as_desc = '' then as_desc = of_GetTag(l_graph.tag)
		return 'Graph'
	case vscrollbar!
		as_desc = of_GetTag(a_object.tag)
		return 'VScrollBar'
	case hscrollbar!
		as_desc = of_GetTag(a_object.tag)
		return 'HScrollBar'
	case picture!
		picture l_pic
		l_pic = a_object
		as_desc = l_pic.picturename
		if as_desc = '' then as_desc = of_GetTag(l_pic.tag)
		return 'Picture'
	case line!
		as_desc = of_GetTag(a_object.tag)
		return 'Line'
	case rectangle!
		as_desc = of_GetTag(a_object.tag)
		return 'Rectangle'
	case oval!
		as_desc = of_GetTag(a_object.tag)
		return 'Oval'
	case Roundrectangle!
		as_desc = of_GetTag(a_object.tag)
		return 'RoundRectangle'
	case else
		as_desc = 'Unknown : '+classname(a_object)
		return 'Unknown'
end choose


end function

protected function boolean of_FindEntry (string as_win, string as_object);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_FindEntry
//
//	Access:  protected
//
//	Arguments : as_win : string; window to be found
//					as_object : string; object to be found
//
//	Returns:  boolean (true if found otherwise false)
//
//	Description:  Used by the scanning process, if the entry is found then it is discarded 
//     from the datastore. We discard it so that it will not deleted or updated in the database
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996 Powersoft Corporation.  All Rights Reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Powersoft is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
long ll_row

ll_row = ids_updates.find("window = '"+as_win+"' and control = '"+as_object+"'",1,ids_updates.rowcount())
if ll_row = 0 then return false
ids_updates.rowsdiscard(ll_row,ll_row,primary!)
return true
end function

protected function string of_GetTag (string as_tag);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetTag
//
//	Access:  protected
//
//	Arguments : as_tag : string; Tag value
//
//	Returns:  string; 
//
//	Description:  parses the passed string. If the string is empty it returns an empty string
//		if the string contains a keyword that matches what is in ics_keyword 
//			(default is 'microhelp', default seperator is ';') then the value for the keyword is returned
//		if none of the aboove is true then the original string is returned
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996 Powersoft Corporation.  All Rights Reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Powersoft is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
string ls_value
if as_tag = '' then return ''
ls_value = inv_string.of_GetKeyValue(as_tag,is_keyword,is_separator)
if ls_value = '' then ls_value = as_tag

return ls_value
end function

protected function boolean of_LoadSecurity (string as_win);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_LoadSecurity
//
//	Access:  protected
//
//	Arguments : as_win : String; Name of window
//
//	Returns:  boolean; True if there is security on the window otherwise false
//
//	Description:  Reads in the security inrofmatino about the window fore the current user
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996 Powersoft Corporation.  All Rights Reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Powersoft is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer  li_rc,li_idx
string ls_winname
ls_winname = lower(as_win)

li_rc = ids_items.SetFilter("window='" + ls_winname + "'")
IF li_rc = -1 THEN
	// signal error
END IF

li_rc = ids_items.Filter()
IF li_rc = -1 THEN
	// signal error
END IF

il_numberofrows = ids_items.RowCount()
IF il_numberofrows = -1 THEN
	// signal error
END IF

IF (il_numberofrows = 0) THEN  // first time for this window
	il_numberofrows = ids_items.Retrieve(is_app,ls_winname,is_userID )
	IF il_numberofrows = -1 THEN
		// Signal error
	END IF
	for li_idx = 1 to ii_numgroups // read in the setting for all the groups the the user belongs to
		li_rc= ids_items.Retrieve(is_app,ls_winname,ids_groups.object.group_name[li_idx] )
		IF li_rc = -1 THEN
			// Signal error
		else
			il_numberofrows += li_rc
		END IF
	next
END IF

return (il_numberofrows = 0)
end function

public function boolean of_SetSecurity (window aw_win);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetSecurity
//
//	Access:  public
//
//	Arguments : aw_win : window ; window to have security set for
//
//	Returns:  Boolean; (True if security was set otherwise false)
//
//	Description:  Sets the security for the passed window. For this function to work properly
// 		the of_init function MUST have been called first.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996 Powersoft Corporation.  All Rights Reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Powersoft is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

string ls_winname
boolean lb_nothing_to_set,lb_override
integer      li_idx, num_menus, li_count
menu 		l_menu
str_menu  l_menu_list[]

if not ib_initsecurity then return false

ls_winname = lower(classname(aw_win))

lb_nothing_to_set  = of_LoadSecurity(ls_winname)

IF lb_nothing_to_set THEN return false
	
il_numberofrows = ids_items.RowCount()

// check for menu items
IF len(aw_win.menuname) > 0 THEN
	num_menus = 1
	l_menu_list[num_menus].mnu = aw_win.menuid
	l_menu_list[num_menus].override = false
	DO WHILE num_menus > 0
		l_menu = l_menu_list[num_menus].mnu
		of_SetMenuStatus(l_menu,ls_winname,l_menu_list[num_menus].override)
//		If a menu item is disabled or invisible then make sure that its' child items are disabled as well
//		This is done to make sure that any toolbar items that are on child menu items are not visible
		lb_override =  not l_menu.visible or not l_menu.enabled
		num_menus = num_menus - 1
		li_count = upperbound(l_menu.item) 
		FOR li_idx = 1 to li_count
			num_menus = num_menus + 1
			l_menu_list[num_menus].mnu = l_menu.item[li_idx]		
			l_menu_list[num_menus].override = lb_override
		NEXT
	LOOP
END IF

of_SetControlArray(ls_winname,aw_win.control,'')
return true


end function

protected function integer of_scandatawindow (string as_win_name, datawindow adw_scan, string as_object);//////////////////////////////////////////////////////////////////////////////
//
//	Function: of_ScanDatawindow
//
//	Access:  protected
//
//	Arguments : as_win_name : string; name of window
//					adw_scan : datawindow ; DW to be scanned
//					as_object : string; Object that owns the datawindow control; if the 
//						object and the wondow are the same then this parameter is blank
//
//	Returns:  integer : (-1: unable to open datawindow object; -2 error on object create
//						otherwise the number of columns that were found
//
//	Description:  Scans the datawindow object and captures the information about each column
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996 Powersoft Corporation.  All Rights Reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Powersoft is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
string ls_dw_name,ls_query,ls_token,ls_ans,ls_err_buf,ls_name,ls_syntax
int li_cnt,li_posi,li_col_cnt = 0

ls_dw_name = as_object + lower(classname(adw_scan))

ids_info.dataobject = adw_scan.dataobject
ls_query = ids_info.describe("datawindow.objects")
ls_query = lower(ls_query)
do while len(ls_query) > 0  // strip apart the tab seperated string
	li_posi = pos(ls_query,"~t")
	if li_posi = 0 then // no more tabs so take what's left of the string
		li_posi = len(ls_query)
	else
		li_posi = li_posi - 1
	end if
	ls_token = left(ls_query,li_posi) // grab off the token
	ls_query = mid(ls_query,li_posi+2) // skip past the tab 
	if len(ls_token) > 0 then 
		ls_ans =ids_info.describe(ls_token+".type ")
		ls_ans = lower(ls_ans)
		if pos(ls_ans,"column") > 0 then // is it a column?
			ls_name = ls_dw_name + "."+ls_token
			if not isnull(ls_name) and len(trim(ls_name)) > 0 then 
				ls_ans =ids_info.describe(ls_token+".dbname ") + ' : ' + ids_info.describe(ls_token+".coltype") // get the descriptive info
				if not of_FindEntry(as_win_name,ls_name) then of_addobject(is_app,as_win_name,ls_name,'Column',ls_ans )  
				li_col_cnt++
			end if
		end if
	end if
loop


return li_col_cnt
end function

public function integer of_initscanprocess (n_tr a_trans, string as_app, string as_lib_list[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_InitScanProcess
//
//	Access:  public
//
//	Arguments : a_trans : n_tr ; used to connect to the database
//					as_app : string; application id
//					as_lib_list[] : string; applications library search path
//
//	Returns:  Integer; 1 for success.
//							-1 = transaction not connected
//
//	Description:  Initialize the database connection, application and library 
//               search path. Used when scanning applications
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996 Powersoft Corporation.  All Rights Reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Powersoft is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
if a_trans.dbhandle() = 0 then return -1
ids_updates.dataobject = 'd_security_templateupdate'
ids_apps.dataobject = 'd_security_applookup'
ids_updates.settransobject(a_trans)
ids_apps.settransobject(a_trans)
ids_items.settransobject(a_trans)
is_app = lower(as_app)
is_liblist = as_lib_list
ii_libcnt = upperbound(as_lib_list)
if ids_apps.retrieve(is_app) = 0 then // if the application does not exist in the database, add it
	ids_apps.importstring(is_app+'~t'+is_app)
end if
ib_initscanning = true
itr_trans = a_trans
return 1

end function

public function integer of_initsecurity (n_tr a_trans, string as_app, string as_user_id, string as_default_group);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_InitSecurity
//
//	Access:  public
//
//	Arguments : a_trans : n_tr ; used to connect to the database
//					as_app : string; application id
//					as_user_id : string; user id
//
//	Returns:  Integer. 1 = OK
//							-1 = Transaction not connected
//							-2 = Application not in dataabse
//							-3 = User not in database
//							-4 = User is not a member of any groups and default group does not exist
//							-5 = Default group not supplied
//
//
//	Description:  Initialize the database connection, application and user id's. Used when setting security.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996 Powersoft Corporation.  All Rights Reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Powersoft is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
integer li_rc

if a_trans.dbhandle() = 0 then return -1 // transaction not connected

as_default_group = lower(as_default_group)
as_app = lower(as_app)
as_user_id = lower(as_user_id)

ids_groups.dataobject = 'd_security_applookup'
ids_groups.settransobject(a_trans)
li_rc = ids_groups.retrieve(as_app) // Is this a valid application?
if li_rc = 0 then return -2

ids_groups.dataobject = 'd_security_userlookup'
ids_groups.settransobject(a_trans)
li_rc= ids_groups.retrieve(as_user_id) // Is this a valid user ?
if li_rc = 0 then return -3

ids_groups.dataobject = 'd_security_grouplookup'
ids_groups.settransobject(a_trans)
ii_numgroups = ids_groups.retrieve(as_user_id) // how many groups does this user belong to ?
if ii_numgroups = 0  then 
	if len(as_default_group) > 0 then
		ids_groups.dataobject = 'd_security_groupverify'
		ids_groups.settransobject(a_trans)
		ii_numgroups = ids_groups.retrieve(is_defaultgroup) // Is default group valid ?
		if ii_numgroups = 0 then return -4
	else
		return -5
	end if
end if 

ids_items.dataobject = 'd_security_controllist'
ids_items.settransobject(a_trans)
ids_items.of_setappend(true)

ib_initsecurity = true
is_defaultgroup = as_default_group
is_app = as_app
is_userID = as_user_id

return 1


end function

public function integer of_scanwindow (window aw_win);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_ScanWindow
//
//	Access:  public
//
//	Arguments 
//				aw_win : window to be scanned
//
//	Returns:  Integer 
//				 1 = Success
//				-1 = error of some sort
//				-2 = database error
//
//	Description:  Scans the passed window and captures the relevant information about 
//                      all of the controls and datawindow columns on the window
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996 Powersoft Corporation.  All Rights Reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Powersoft is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
string ls_win_name,ls_name
int li_cnt,li_menu_cnt,li_menu_idx,li_rc
menu lm_win_menu
menu lm_menu_list[]
window aw_window
aw_window = aw_win

lm_win_menu = aw_window.menuID
ls_win_name = lower(classname(aw_window))
li_rc = ids_updates.retrieve(is_app,ls_win_name)
// check for menu items
if len(aw_window.menuname) > 0 then
	li_menu_idx = 1
	if aw_window.menuid.text = '' then aw_window.menuid.text = 'Top Level Menu Object'
	lm_menu_list[li_menu_idx] = aw_window.menuid
	do while li_menu_idx > 0
		lm_win_menu = lm_menu_list[li_menu_idx]
		ls_name = lower(classname(lm_win_menu))
		if (not isnull(ls_name)) and (len(trim(ls_name)) > 0) then 
			if not of_FindEntry(ls_win_name,ls_name) then of_addobject(is_app,ls_win_name,ls_name,'MenuItem',lm_win_menu.text )  
		end if
		li_menu_idx --
		li_menu_cnt = upperbound(lm_win_menu.item)
		for li_cnt = 1 to li_menu_cnt
			li_menu_idx ++
			lm_menu_list[li_menu_idx] = lm_win_menu.item[li_cnt]		
		next
	loop
end if
// check for controls and datawindows
this.of_ScanControlArray(ls_win_name,aw_win.control,'')

ids_updates.setfilter("not isrownew()")
ids_updates.filter()

long ll_row_cnt,ll_row

ll_row_cnt = ids_updates.rowcount()
if ll_row_cnt > 0 then ids_updates.rowsmove(1,ll_row_cnt,primary!,ids_updates,1,delete!)
		
ids_updates.setfilter("")
ids_updates.filter()

li_rc = ids_apps.update(true,false)
if li_rc >= 0 then li_rc = ids_updates.update(true,false)
if li_rc < 1 then
	rollback using itr_trans;
	if itr_trans.sqlcode <> 0 then return -2
	return -1
else
	commit using itr_trans;
	if itr_trans.sqlcode <> 0 then return -2
	ids_apps.resetupdate()
	ids_updates.resetupdate()
	return 1
end if
	
end function

protected function integer of_addobject (string as_app, string as_winname, string as_object, string as_objecttype, string as_desc);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_addobject
//
//	Access:  protected
//
//	Arguments : as_app : application
//					as_winname : window name
//					as_object : object name
//					as_objecttype : object type
//					as_desc : description of object
//
//	Returns:  integer; Return code from import string
//	
//
//	Description:  Add an objects information to the template Datastore
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996 Powersoft Corporation.  All Rights Reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Powersoft is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
return ids_updates.importstring(as_app+'~t'+as_winname+'~t'+as_object+'~t'+as_objecttype+'~t'+as_desc )  
end function

protected function integer of_scancontrolarray (string as_win_name, windowobject ao_objects[], string as_object_name);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_ScanControlArray
//
//	Access:  protected
//
//	Arguments : as_win_name : string ; window name
//					ao_objects[] : array of window objects; control array to scan
//					as_object_name : name of object that owns the control array. If the 
//						control array is owned by the window then this parameter is blank
//
//	Returns:  Integer
//					1 = success
//
//	Description:  Scans the passed control array. It matchs up the controls with their 
//		corresponding entries in the database and sets them accordingly
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996 Powersoft Corporation.  All Rights Reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Powersoft is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

int li_idx,li_obj_cnt,li_tab_cnt,li_tab_idx
string ls_name,ls_tab_name,ls_object_type,ls_desc
datawindow ldw_scan
userobject lu_uo
tab l_tab


// check for controls and datawindows
li_obj_cnt = upperbound(ao_objects)
for li_idx = 1 to li_obj_cnt
	choose case typeof(ao_objects[li_idx]) 
		case datawindow!
			ls_name = as_object_name+lower(classname(ao_objects[li_idx]))
			ls_object_type = of_GetType(ao_objects[li_idx],ls_desc)
			if not of_FindEntry(as_win_name,ls_name) then of_addobject(is_app,as_win_name,ls_name,'DataWindow',ls_desc )  

			ldw_scan = ao_objects[li_idx]
			of_ScanDatawindow(as_win_name,ldw_scan,as_object_name)
		case userobject!
			ls_name = as_object_name+lower(classname(ao_objects[li_idx]))
			ls_object_type = of_GetType(ao_objects[li_idx],ls_desc)
			if not of_FindEntry(as_win_name,ls_name) then of_addobject(is_app,as_win_name,ls_name,'UserObject',ls_desc )  

			lu_uo = ao_objects[li_idx]
			if as_object_name <> '' then 
				ls_name = as_object_name + '.'+ lower(classname(lu_uo))+ '.'
			else
				ls_name = lower(classname(lu_uo))+ '.'
			end if
			of_ScanControlArray(as_win_name,lu_uo.control,ls_name)
		case tab!
			ls_name = as_object_name+lower(classname(ao_objects[li_idx]))
			ls_object_type = of_GetType(ao_objects[li_idx],ls_desc)
			if not of_FindEntry(as_win_name,ls_name) then of_addobject(is_app,as_win_name,ls_name,'Tab',ls_desc )  
			
			ls_tab_name = ls_name
			l_tab = ao_objects[li_idx]
			li_tab_cnt = upperbound(l_tab.control)
			for li_tab_idx = 1 to li_tab_cnt
				lu_uo = l_tab.control[li_tab_idx]
				ls_name = ls_tab_name + '.'+ lower(classname(lu_uo))
				ls_object_type = of_GetType(lu_uo,ls_desc)

				if not of_FindEntry(as_win_name,ls_name) then of_addobject(is_app,as_win_name,ls_name,'TabPage',ls_desc )  
				ls_name = ls_name + '.'
				of_ScanControlArray(as_win_name,lu_uo.control,ls_name)
			next
		case mdiclient!
			// do nothing as the mdiclient is not something that we would want to set security on anyway
		case else 
			ls_name = as_object_name+lower(classname(ao_objects[li_idx]))
			if not isnull(ls_name) and len(trim(ls_name)) > 0 then 
				ls_object_type = of_GetType(ao_objects[li_idx],ls_desc)
				if not of_FindEntry(as_win_name,ls_name) then of_addobject(is_app,as_win_name,ls_name,ls_object_type,ls_desc )  
			end if
	end choose
next
return 1
end function

protected function integer of_setcontrolarray (string as_window, graphicobject ao_objects[], string as_object_name);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetControlArray
//
//	Access:  protected
//
//	Arguments : as_window : string; Name of window
//					ao_objects[] : graphicobject; control array
//					as_object_name : string; name of object that owns the control array.
//											blank if the window if the owner of the array
//
//	Returns:  Integer
//				1 = success
//
//	Description:  Scans the passed control array and set the security as needed on the
//					controls. If the control is a tab or User object then it is exploded into it's controls.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996 Powersoft Corporation.  All Rights Reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Powersoft is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer li_count,li_idx,li_tab_cnt,li_tab_idx
string ls_name,ls_tab_name,ls_page_name
userobject lu_uo
tab l_tab
// check for controls
li_count =  upperbound(ao_objects[])
FOR li_idx = 1 TO li_count
	choose case typeof(ao_objects[li_idx])
		case userobject!
			of_SetControlStatus(ao_objects[li_idx],as_window,as_object_name) // set just the user object
			lu_uo = ao_objects[li_idx]
			if as_object_name = '' then
				ls_name = lower(classname(lu_uo))
			else
				ls_name = as_object_name + '.' + lower(classname(lu_uo))
			end if		
			of_SetControlArray(as_window,lu_uo.control,ls_name)

		case tab!
			of_SetControlStatus(ao_objects[li_idx],as_window,as_object_name) // set just the tab
			l_tab = ao_objects[li_idx]
			if as_object_name = '' then 
				ls_tab_name = lower(classname(l_tab)) 
			else
				ls_tab_name = as_object_name + '.'+ lower(classname(l_tab)) 
			end if				
			li_tab_cnt = upperbound(l_tab.control)
			for li_tab_idx = 1 to li_tab_cnt
				lu_uo = l_tab.control[li_tab_idx]
				of_SetControlStatus(lu_uo,as_window,ls_tab_name) // set just the uo
				ls_page_name = ls_tab_name +  '.' + lower(classname(lu_uo))
				of_SetControlArray(as_window,lu_uo.control,ls_page_name) // now set the controls on the uo
			next
		case mdiclient!
			// do nothing as the mdiclient is not something that we would want to set security on anyway
		case else
			of_SetControlStatus(ao_objects[li_idx],as_window,as_object_name)
	END CHOOSE
NEXT
return 1

end function

protected function integer of_setcontrolstatus (graphicobject a_item, string as_window, string as_object);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetControlStatus
//
//	Access:  protected
//
//	Arguments : a_item : graphicobject; control to be set
//					as_window : name of window that the control is on
//
//	Returns:  Integer
//				1 = success
//
//	Description:  Figure out the kind of control that was passed and then set it's status as needed
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996 Powersoft Corporation.  All Rights Reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Powersoft is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

string ls_itemname,  ls_result, ls_mod_string
integer li_rc,li_idx,li_posi
string	ls_current_status, ls_column
string ls_control,ls_orig_filter
boolean lb_dummy

menu				l_menu
commandbutton	l_cb
checkbox l_cbx
radiobutton l_rb
datawindow		l_dw
userobject l_uo 
tab l_tab 
listbox l_lb
dropdownlistbox l_ddlb
dropdownpicturelistbox l_ddplb
singlelineedit l_sle
multilineedit l_mle
editmask l_em
picturelistbox l_plb 
richtextedit l_rte 
Statictext l_st 
groupbox l_gb 
treeview l_tv 
listview l_lv 
olecustomcontrol l_ocx 
picturebutton	l_pb 
graph l_graph
vscrollbar l_vsb 
hscrollbar l_hsb 
picture l_pic 

if as_object = '' then
	ls_itemname = lower(classname(a_item))
else
	ls_itemname = as_object + '.' + lower(classname(a_item))
end if

CHOOSE CASE typeof(a_item) 
	CASE menu!
		l_menu = a_item
		of_SetState(as_window,ls_itemname,l_menu.enabled,l_menu.visible)
		if not l_menu.visible then // OK, lets see if it has a toolbar and make it invisible as well
			l_menu.toolbaritemvisible = false
		end if
	CASE commandbutton!
		l_cb = a_item
		of_SetState(as_window,ls_itemname,l_cb.enabled,l_cb.visible)
	CASE checkbox!
		l_cbx = a_item
		of_SetState(as_window,ls_itemname,l_cbx.enabled,l_cbx.visible)
	CASE radiobutton!
		l_rb = a_item
		of_SetState(as_window,ls_itemname,l_rb.enabled,l_rb.visible)
	CASE datawindow!
		l_dw = a_item
		of_SetState(as_window,ls_itemname,l_dw.enabled,l_dw.visible)
		ls_control = trim(ls_itemname)
		ls_orig_filter = ids_items.Describe("DataWindow.Table.Filter")
		li_rc = ids_items.SetFilter("window=~""+as_window+"~" AND pos(control, ~""+ls_control+"~") > 0")
		IF li_rc = -1 THEN
			// Signal an error
		END IF
		li_rc = ids_items.Filter()
		IF li_rc = -1 THEN
			// Signal an error
		END IF
		il_numberofrows = ids_items.RowCount() 
		IF il_numberofrows > 0 THEN 
			FOR li_idx = 1 TO il_numberofrows
				ls_current_status  = ids_items.GetItemString (li_idx, "status")
				ls_column = ids_items.GetItemString (li_idx, "control")
				IF ls_current_status <> "E" THEN
					li_posi = pos(ls_column,".")
					do  // has to be done at least once to seperate the datawindow control name from the column name
						ls_column = mid(ls_column, li_posi + 1)
						li_posi = pos(ls_column,".")
					loop until li_posi = 0 // but there might be additional names in the string so keep going until there are not more '.' in the string
//					mod_string = mod_string + col + ".border=~""+ics_disabled_border+"~" " + col + ".tabsequence=0 "
					ls_mod_string = ls_column + ".border=~""+is_disabledborder+"~" " + ls_column + ".tabsequence=0 "
					IF ls_current_status = "I" THEN ls_mod_string = ls_mod_string + ls_column + ".visible=~"0~" "
					ls_result = l_dw.Modify(ls_mod_string)
					IF ls_result <> "" THEN
						//Signal dwModify error
					END IF
				END IF
			NEXT
		ELSEIF il_numberofrows < 0 THEN
		// Signal an error
		END IF
		li_rc = ids_items.SetFilter(ls_orig_filter)
		IF li_rc = -1 THEN
			// Signal an error
		END IF
		li_rc = ids_items.Filter()
		IF li_rc = -1 THEN
			// Signal an error
		END IF
		il_numberofrows = ids_items.RowCount() 
	CASE userobject!
		l_uo = a_item
		of_SetState(as_window,ls_itemname,l_uo.enabled,l_uo.visible)
	CASE tab!
		l_tab = a_item
		of_SetState(as_window,ls_itemname,l_tab.enabled,l_tab.visible)
	CASE listbox!
		l_lb = a_item
		of_SetState(as_window,ls_itemname,l_lb.enabled,l_lb.visible)
	CASE dropdownlistbox!
		l_ddlb = a_item
		of_SetState(as_window,ls_itemname,l_ddlb.enabled,l_ddlb.visible)
	CASE dropdownpicturelistbox!
		l_ddplb = a_item
		of_SetState(as_window,ls_itemname,l_ddplb.enabled,l_ddplb.visible)
	CASE singlelineedit!
		l_sle = a_item
		of_SetState(as_window,ls_itemname,l_sle.enabled,l_sle.visible)
	CASE multilineedit!
		l_mle = a_item
		of_SetState(as_window,ls_itemname,l_mle.enabled,l_mle.visible)
	CASE editmask!
		l_em = a_item
		of_SetState(as_window,ls_itemname,l_em.enabled,l_em.visible)
	CASE picturelistbox! 
		l_plb = a_item
		of_SetState(as_window,ls_itemname,l_plb.enabled,l_plb.visible)
	CASE richtextedit!
		l_rte = a_item
		of_SetState(as_window,ls_itemname,l_rte.enabled,l_rte.visible)
	CASE statictext!
		l_st = a_item
		of_SetState(as_window,ls_itemname,l_st.enabled,l_st.visible)
	CASE groupbox!
		l_gb = a_item
		of_SetState(as_window,ls_itemname,l_gb.enabled,l_gb.visible)
	CASE treeview!
		l_tv = a_item
		of_SetState(as_window,ls_itemname,l_tv.enabled,l_tv.visible)
	CASE listview!
		l_lv = a_item
		of_SetState(as_window,ls_itemname,l_lv.enabled,l_lv.visible)
	CASE olecustomcontrol!
		l_ocx = a_item
		of_SetState(as_window,ls_itemname,l_ocx.enabled,l_ocx.visible)
	CASE picturebutton! 
		l_pb = a_item
		of_SetState(as_window,ls_itemname,l_pb.enabled,l_pb.visible)
	CASE graph!
		l_graph = a_item
		of_SetState(as_window,ls_itemname,l_graph.enabled,l_graph.visible)
	CASE vscrollbar! // scroll bars can only be visible or invisible not enabled
		l_vsb = a_item
		of_SetState(as_window,ls_itemname,lb_dummy,l_vsb.visible)
	CASE hscrollbar!
		l_hsb = a_item
		of_SetState(as_window,ls_itemname,lb_dummy,l_hsb.visible)
	CASE picture!
		l_pic = a_item
		of_SetState(as_window,ls_itemname,l_pic.enabled,l_pic.visible)
	Case else // Big time error here.
		Messagebox('of_setcontrolstatus','Unknown control '+ls_itemname+'. Please contact your system administrator.',stopsign!)
		halt close

END CHOOSE
return 1

end function

protected function integer of_setmenustatus (ref menu am_item, string as_window, boolean ab_override);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetMenuStatus
//
//	Access:  protected
//
//	Arguments : a_item : menu; menu_item to be set
//					as_window : name of window that the menu is on
//					ab_override :  menu item is to be disabled and it's toolbar item 
//					(if any) is to be made invisible. This is because it's parent menu 
//					item has been set to either invisible or disabled
//
//	Returns:  Integer
//					1 = Success
//
//	Description:  Set the passed menu item,set it's status as needed and pass 
//					  back how it was set if the override flag is set then do not 
//					  even lookup the settings, but use the passed settings.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996 Powersoft Corporation.  All Rights Reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Powersoft is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

string ls_itemname

ls_itemname = lower(classname(am_item))
if ab_override then // override means that the menu item is to be disabled and it's toolbar item (if any) is to be made invisible
	if am_item.enabled then am_item.enabled = false
	if am_item.toolbaritemvisible then am_item.toolbaritemvisible = false
else
	of_SetState(as_window,ls_itemname,am_item.enabled,am_item.visible)
	if not am_item.visible then // OK, lets see if it has a toolbar and make it invisible as well
		am_item.toolbaritemvisible = false
	end if
end if

return 1

end function

protected function integer of_setstate (string as_win, string as_itemname, ref boolean ab_enabled, ref boolean ab_visible);//////////////////////////////////////////////////////////////////////////////
//
//	Function: of_SetState
//
//	Access:  protected
//
//	Arguments : as_win : string; window name
//					as_itemname : string control name
//					ab_enabled : boolean; enabled attribute of the control
//					ab_visible : boolean; visible attribute of the control
//
//	Returns:  Integer
//				0 = Control not found
//				1 = Success
//
//	Description:  Gets the status of the passed window control pair and then sets the
//					passed attributes appropriately. If the attribute is already set to what
//					we want it to be then DO NOT set it again.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996 Powersoft Corporation.  All Rights Reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Powersoft is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
string ls_status
long ll_rownbr

ll_rownbr = ids_items.Find("window=~""+as_win+"~" AND control=~""+as_itemname+"~"",1,il_numberofrows)

IF ll_rownbr = 0 THEN return 0

ls_status = ids_items.GetItemString(ll_rownbr, "status")

IF len(ls_status) = 1 THEN
//   do not reset the enabled attribute if it is already what we want
	IF ab_enabled AND ((ls_status = "D") OR (ls_status = "I")) THEN
		ab_enabled = false
	ELSEIF NOT ab_enabled AND (ls_status = "E") THEN
		ab_enabled = true
	END IF
//  IF invisible and not already invisible then make invisible
//  otherwise if enabled and invisible then make visible
	IF ls_status = "I" AND ab_visible THEN 
		ab_visible = false
	ELSEIF ls_status = "E" AND NOT ab_visible THEN 
		ab_visible = true
	END IF
end if

return 1
end function

on u_security.create
TriggerEvent( this, "constructor" )
end on

on u_security.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;/////////////////////////////////////////////////////////////////////////////
//
//	Object Name:  pfc_n_cst_security
//
//	Description:  Security service
//
//////////////////////////////////////////////////////////////////////////////
//
//	Event:  Constructor
//
//	Arguments: None
//
//	Returns:  None
//
//	Description:  Create all needed  datastore objects
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996 Powersoft Corporation.  All Rights Reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Powersoft is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
ids_items = create n_ds

ids_updates = create n_ds

ids_apps = create n_ds

ids_groups = create n_ds

ids_info = create n_ds

end event

event destructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  Destructor
//
//	(Arguments: None
//
//	(Returns:  None
//
//	Description:  Destroy all created datastore objects
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996 Powersoft Corporation.  All Rights Reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Powersoft is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
destroy ids_updates
destroy ids_info
destroy ids_apps
destroy ids_groups
destroy ids_items
end event

