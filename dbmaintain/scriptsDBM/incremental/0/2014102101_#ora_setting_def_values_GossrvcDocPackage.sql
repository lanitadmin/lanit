update gossrvc_doc_package set notify_by_sms = 0 where notify_by_sms is null;
update gossrvc_doc_package set notify_by_phone = 0 where notify_by_phone is null;