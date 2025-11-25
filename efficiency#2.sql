select shift_num, start_time, end_time, line_num, dt_total, ((end_time - start_time)*24*3600) 
from shift
where (((end_time - start_time)*24*3600) - dt_total)/((end_time - start_time)*24*3600) >= 0.8;