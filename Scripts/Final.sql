use dbs2022f;

#enable = 1 desable = 0 for auto save 
set autocommit = 1;
set autocommit = 0; #allows use of rollback(undo)
commit;				#Commits work disbaleing rollback for all commited actions
rollback;			#Undo button for Un- committed changes
select @@autocommit;


select count(*) from log_all;

## Q1 
alter table log_clients 
add Primary Key (ID);
##Q1

##Q2

create unique index iArea
on log_areas (area);

create unique index iClient_ip
on log_clients (client_ip);

create unique index iPage
on log_pages (page);

create unique index iReferer
on log_referers (referer);

##Q2


##Q3

alter table log_pages
add index iFileType (filetype);

##Q3

##Q4

alter table log_hits
add primary key (hit_date, hit_time, hit_ms);

##Q4

##Q5 Scrach pad

alter table log_hits
drop foreign key fk_page_id;

alter table log_hits
drop foreign key fk_client_id;

alter table log_hits
drop foreign key fk_referer_id;

alter table log_hits
drop foreign key fk_area_id;

##Q5

alter table log_hits
add constraint fk_page_id
foreign key (page_id)
references log_pages(id) 
on delete cascade
on update cascade;

alter table log_hits
add constraint fk_client_id
foreign key (client_id)
references log_clients(id)
on delete cascade
on update cascade;

alter table log_hits
add constraint fk_referer_id
foreign key (referer_id)
references log_referers(id)
on delete cascade
on update cascade;

alter table log_hits
add constraint fk_area_id
foreign key (area_id)
references log_areas(id)
on delete cascade
on update cascade;

##Q5

##Q6 Scrach Pad
select distinct site_area from log_all where site_area is not null;
##Q6

insert into log_areas (area)
select distinct site_area 
from log_all 
where site_area is not null;

select count(*) as areaCount from log_areas;  ## areaCount = 13

##Q6

##Q7 Scrach Pad
select distinct referer from log_all where referer is not null;
##Q7

insert into log_referers (referer)
select distinct referer 
from log_all 
where referer is not null;

select count(*) as refererCount from log_referers;

##Q7


##Q8 Scratch Pad
select distinct uri_stem, file_type from log_all where uri_stem is not null;

##Q8

insert into log_pages (page,filetype)
select distinct uri_stem, file_type 
from log_all 
where uri_stem is not null;


select count(*) as pagesCount from log_pages;

##Q8
select count(ip_client) from log_all where ip_client is not null;
##Q9 Scratch Pad
select distinct INET_ATON(ip_client),ip_client from log_all;
##Q9

insert into log_clients (id,client_ip)
select distinct INET_ATON(ip_client),ip_client from log_all;

select count(*) from log_clients;

##Q9

##Q10 Scratch Pad

##Q10
insert into log_hits (hit_date, hit_time, hit_ms, method, uri_query, http_version, user_agent, 
bytes_sent, bytes_rcvd, time_ms, referer_id, client_id, page_id, area_id )
select log_all.hit_date, log_all.hit_time, log_all.hit_ms, log_all.method, log_all.uri_query, log_all.http_version,
log_all.user_agent, log_all.bytes_sent, log_all.bytes_rcvd, log_all.time_ms, log_referers.id, 
log_clients.id, log_pages.id, log_areas.id
from log_all 
left join log_referers on log_all.referer = log_referers.referer
left join log_clients on log_all.ip_client = log_clients.client_ip
left join log_pages on log_all.uri_stem = log_pages.page 
left join log_areas on log_all.site_area = log_areas.area;

select count(*) from log_hits;


##Q10



##Q11

create view log_scripts as
select * from log_pages 
where filetype = 'php' or filetype = 'cfm';

select count(*) from log_scripts ;



##Q11


##Q12

create view log_script_hits as
SELECT log_hits.hit_date, log_hits.hit_time, log_hits.hit_ms, log_hits.method,
    log_hits.page_id, log_hits.uri_query, log_hits.client_id,log_hits.http_version,
    log_hits.user_agent, log_hits.referer_id, log_hits.bytes_sent, log_hits.bytes_rcvd,
    log_hits.time_ms, log_hits.area_id
FROM log_hits
join log_scripts on  log_hits.page_id = log_scripts.id;

select count(*) from log_script_hits 
;

##Q12

##Q13

select page_id, page, hit_ms from log_pages
join log_script_hits on log_script_hits.page_id = log_pages.id
order by log_script_hits.hits_ms desc;



##Q13