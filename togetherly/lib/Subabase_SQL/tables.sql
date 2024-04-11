create table Chore_Completion (
  ID  SERIAL PRIMARY KEY,
  chore_id integer not null,
  person_id integer not null,
  date_submitted timestamp,
  due_date timestamp,
  is_approved boolean not null,
  CONSTRAINT chore_id
      FOREIGN KEY(chore_id)
        REFERENCES chore(id),
  constraint person_id
    foreign key(person_id)
      references person(id)
);

create table Assignment (
  choreid  int not null references chore(id),
  personid int not null references person(id),
  status varchar(255),
  PRIMARY KEY(choreid, personid)
);

create table Reward (
  ID  SERIAL PRIMARY KEY,
  familyId integer not null,
  title varchar(50) not null,
  description varchar(255),
  points integer not null,
  quantity integer,
   CONSTRAINT family_id
      FOREIGN KEY(familyId)
        REFERENCES family(id)
);

create table Person (
  ID  SERIAL PRIMARY KEY,
  family_id integer not null,
  name varchar(255) not null,
  is_Parent boolean not null,
  total_Points integer default 0,
  pin char(5) not null,
  profile_Pic varchar(15) not null check (profilePic in ('bear', 'cat', 'chicken', 'dog', 'fish', 'fox', 'giraffe', 'gorilla', 'koala', 'panda', 'rabbit', 'tiger')),
  CONSTRAINT family_id
      FOREIGN KEY(familyId)
        REFERENCES family(id)
);

create table Redeemed_Reward (
  ID  SERIAL PRIMARY KEY,
  reward_id int not null references reward(id),
  person_id int not null references person(id),
  quantity integer not null,
  timestamp timestamp,
  CONSTRAINT person_id
      FOREIGN KEY(person_id)
        REFERENCES Person(id),
  CONSTRAINT reward_id
      FOREIGN KEY(reward_id)
        REFERENCES Reward(id)
);

create table Family (
  -- id integer not null primary key,
  ID  SERIAL PRIMARY KEY,
  name varchar(50) not null
);

create table Chore (
  ID  SERIAL PRIMARY KEY,
  family_id serial not null,
  title varchar(255) not null,
  description varchar(255),
  dateDue timestamp,
  points integer not null check (points >= 0),
  shared boolean not null,
  CONSTRAINT family_id
      FOREIGN KEY(family_id)
        REFERENCES Family(id)
);