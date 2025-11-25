Select b.shift_num, sum(b.ending_time - b.starting_time) * 24 * 3600
from dt_instance b
group by b.shift_num
Having (sum(b.ending_time - b.starting_time) * 24 * 3600 <= 1440) OR 
   (sum(b.ending_time - b.starting_time) * 24 * 3600 >= 23040 )  ;  