Update ab_job set number_of_men_used =10 Where	number_of_men_used is NULL;
Update ab_job set line_num = 0 where line_num is NULL;
Update ab_job set material_yield = 0.0 where material_yield is NULL;
Update shipment set	vehicle_status	= 2 where vehicle_status is NULL;
Update shipment set	shipment_status = 2 where shipment_status is NULL;
Update shipment set	shipment_enduser_id	= 0 where shipment_enduser_id is NULL;
Update shipment set	carrier_id	= 0 where carrier_id is NULL;
Update shipment set	des_sh_cust_id	 = 0 where des_sh_cust_id is NULL;
Update shipment set	customer_id	= 0 where customer_id is NULL;
Update customer_order set	cust_order_line_note	= 0 where cust_order_line_note is NULL;
Update customer_order set	orig_customer_id	= 0 where orig_customer_id is NULL;
Update customer_order set	enduser_id	= 0 where enduser_id is NULL;
Update customer_order set	order_contact_id	= 1003 where order_contact_id is NULL;
Update customer_order set	sheet_handling_type	 = 0 where sheet_handling_type is NULL;

	



