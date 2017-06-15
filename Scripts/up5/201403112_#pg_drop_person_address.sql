DROP table person_address CASCADE;

ALTER table person DROP column fact_address_ros;

ALTER table person DROP column real_address_ros;

ALTER table agent DROP column fact_address_ros;
