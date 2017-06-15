delete from DOC_TYPE_TEMPALTE_MAP;

delete from DOC_TO_DOC_TEMPLATE;
delete from securable where aobject='entity.DocToDocTemplate';

delete from OGV_TO_DOC_TEMPLATE;
delete from securable where aobject='entity.OgvToDocTemplate';

delete from REQUEST_TEMPLATE;
delete from securable where aobject='entity.RequestTemplate';

delete from PRINT_DOC_TYPE_TEMPLATE;
delete from securable where aobject='entity.PrintDocTypeTemplate';

delete from SERVICE_INTEGRATION;
delete from securable where aobject='entity.ServiceIntegration';

delete from GOSSRVC_OGV_TEMPLATE;
delete from securable where aobject='entity.GossrvcOgvTemplate';

delete from GOSSRVC_SERVICE_TEMPLATE;
delete from securable where aobject='entity.GossrvcServiceTemplate';

--удаление настроек адаптеров
delete from SOAP_OPTIONS_VAR;
delete from SOAP_OPTIONS_TEMPLATE;
delete from SOAP_OPTIONS;
delete from securable where aobject='entity.entity.SoapOptions';

commit;
