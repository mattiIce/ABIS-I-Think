CREATE OR REPLACE Function sheet_die
   ( ab_job_num IN long, item_num IN Integer )
   RETURN String
IS
String ls_rc;
String ls_sheet;

cursor c1 is
select sheet_type
from order_item
where order_abc_num = ab_job_num AND order_item_num = item_num;

Cursor c2 IS
SELECT CH_DIE
FROM chevron
where order_abc_num = ab_job_num AND order_item_num = item_num;

Cursor c3 IS
SELECT C_DIE1
FROM circle
where order_abc_num = ab_job_num AND order_item_num = item_num;

BEGIN

open c1;
fetch c1 into ls_sheet;

if c1%notfound then
	ls_rc = 'No specified';
else
	CASE ls_sheet
		WHEN "Circle"
			open c3;
			fetch c3 into ls_rc;
			Close c3;
		WHEN "Chevron"
			open c2;
			fetch c2 into ls_rc;
			Close c2;
	END CASE
end if;

close c1;

RETURN ls_rc;

EXCEPTION
WHEN OTHERS THEN
      raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;

