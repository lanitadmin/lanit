update role_ref_aud r
set revtype=(select a.revtype from securable_aud_bak a where a.id=r.id and a.rev=r.rev)
where revtype is null;

update user_ref_aud r
set revtype=(select a.revtype from securable_aud_bak a where a.id=r.id and a.rev=r.rev)
where revtype is null;