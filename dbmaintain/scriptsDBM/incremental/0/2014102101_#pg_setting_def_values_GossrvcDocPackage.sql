update gossrvc_doc_package set notify_by_sms = false where notify_by_sms is null;
update gossrvc_doc_package set notify_by_phone = false where notify_by_phone is null;