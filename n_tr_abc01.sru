$PBExportHeader$n_tr_abc01.sru
forward
global type n_tr_abc01 from n_tr
end type
end forward

global type n_tr_abc01 from n_tr
end type
global n_tr_abc01 n_tr_abc01

type prototypes
subroutine UPDATE_SCRAP_SKID_FROM_QUALITY(long COIL_NUM,long SHIFT_NUM) RPCFUNC ALIAS FOR "~"DBO~".~"UPDATE_SCRAP_SKID_FROM_QUALITY~""
subroutine UPDATE_SCRAP_FROM_WORKSHEET(long COIL_NUM) RPCFUNC ALIAS FOR "~"DBO~".~"UPDATE_SCRAP_FROM_WORKSHEET~""
subroutine UPDATE_SHIFT_COIL(long COIL_NUM, long SHIFT_NUM) RPCFUNC ALIAS FOR "~"DBO~".~"UPDATE_SHIFT_COIL~""
subroutine UPDATE_SHEET_SKID_WT(long SKID_NUM, long SHIFT_NEW_WT) RPCFUNC ALIAS FOR "~"DBO~".~"UPDATE_SHEET_SKID_WT~""
subroutine F_CHECK_SKID_ITEM_INFO(long SKID_NUM) RPCFUNC ALIAS FOR "~"DBO~".~"F_CHECK_SKID_ITEM_INFO~""

//Alex Gerlants. 09/07/2016
function long f_unix_file_exists(String as_directory, String as_file_name) RPCFUNC ALIAS FOR "dbo.f_unix_file_exists"


end prototypes

on n_tr_abc01.create
call super::create
end on

on n_tr_abc01.destroy
call super::destroy
end on

