update GOSSRVC_SERVICE_ATTR set countmode = 'one' where countmode is null or countmode='';
update GOSSRVC_SERVICE_ATTR set archive = 0 where archive is null;
update GOSSRVC_SERVICE_ATTR set param_mode = 'in' where param_mode is null or param_mode='';
update GOSSRVC_SERVICE_ATTR set REQUIRED = 1 where REQUIRED is null;