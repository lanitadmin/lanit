update document_details_child
set doc_number = number;

update document_details
set doc_number = number;

alter table document_details drop column number;

alter table document_details_child drop column number;