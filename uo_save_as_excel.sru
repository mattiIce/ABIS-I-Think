$PBExportHeader$uo_save_as_excel.sru
forward
global type uo_save_as_excel from nonvisualobject
end type
end forward

global type uo_save_as_excel from nonvisualobject
end type
global uo_save_as_excel uo_save_as_excel

type variables
String	is_customer, is_date_from_to
end variables

forward prototypes
public function any inttocolumn (integer ai_col)
public function any getdata (datawindow adw_dw, long al_row, string as_column)
public subroutine getcolumns (datawindow adw_dw, ref string as_columns[])
end prototypes

public function any inttocolumn (integer ai_col);//Alex Gerlants. 05/02/2016. Begin
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

public function any getdata (datawindow adw_dw, long al_row, string as_column);//Alex Gerlants. 05/02/2016. Begin
/*
Function:	getdata
Returns:		any
Arguments:	value	datawindow	adw_dw
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

public subroutine getcolumns (datawindow adw_dw, ref string as_columns[]);//Alex Gerlants. 05/02/2016. Begin
/*
Function:	getcolumns
				Get a list of all the columns in the DW
				Note this function could be replaced with
				a function that allows the developer to specify
				the column names to be exported.
Returns:		none
Arguments:	value	datawindow	adw_dw
				reference	string	as_columns[]
*/
Long ll_I, ll_Cols
String	ls_column_name

ll_Cols = Long( adw_DW.Describe( 'datawindow.column.count' ) )
FOR ll_I = ll_cols TO 1 STEP -1
	ls_column_name = adw_DW.Describe( '#' + String( ll_I ) + '.Name' )
	as_columns[ ll_I ] = ls_column_name
NEXT

//Alex Gerlants. 05/02/2016. End
end subroutine

on uo_save_as_excel.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_save_as_excel.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

