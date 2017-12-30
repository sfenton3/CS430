create table members(
	members_id int primary key,
	mname varchar(30) not null,
	address varchar(30)
);
create table groups(
	groups_id int primary key,
	gname varchar(30) not null
);
create table member_of(
	members_id int,
	groups_id int,
	primary key(members_id,groups_id),
	foreign key(members_id) references members(members_id),
	foreign key(groups_id) references groups(groups_id)
);
