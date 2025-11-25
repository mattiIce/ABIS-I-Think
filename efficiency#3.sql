select a.shift_num, a.start_time, a.end_time, b.line_desc, a.dt_total "Downtime(Sec)", (((a.end_time - a.start_time)*24*3600) - a.dt_total)/((a.end_time - a.start_time)*24*3600)*100 "Efficiency %" 
from shift a, line b
where (((((a.end_time - a.start_time)*24*3600) - a.dt_total)/((a.end_time - a.start_time)*24*3600) >= 0.8) OR
		((((a.end_time - a.start_time)*24*3600) - a.dt_total)/((a.end_time - a.start_time)*24*3600) <= 0.05)) AND
		(a.line_num = b.line_num)
order by a.start_time;