DROP TABLE IF EXISTS ro_marriage_certificate;
DROP TABLE IF EXISTS ro_birth_certificate;
DROP TABLE IF EXISTS ro_passport;
DROP TABLE IF EXISTS ro_person;

CREATE TABLE ro_person
(
    person_id SERIAL,
    sex smallint default 2 NOT NULL ,
    first_name varchar(100) NOT NULL ,
    last_name varchar(100) NOT NULL ,
    patronymic varchar(100)  ,
    date_birth date ,
    PRIMARY KEY (person_id)
);

CREATE TABLE ro_passport
(
    passport_id SERIAL,
    person_id integer NOT NULL ,
    seria varchar (10) NOT NULL ,
    number varchar(10)  NOT NULL ,
    issue_date date NOT NULL ,
    issue_department varchar(100),
    PRIMARY KEY (passport_id),
    FOREIGN KEY (person_id) REFERENCES ro_person(person_id) ON DELETE RESTRICT
);

CREATE TABLE ro_birth_certificate
(
    birth_certificate_id SERIAL,
    number_certificate varchar (20) NOT NULL ,
    issue_date date NOT NULL ,
    person_id integer NOT NULL ,
    father_id integer ,
    mother_id integer ,
    PRIMARY KEY (birth_certificate_id),
    FOREIGN KEY (person_id) REFERENCES ro_person(person_id) ON DELETE RESTRICT,
    FOREIGN KEY (father_id) REFERENCES ro_person(person_id) ON DELETE RESTRICT,
    FOREIGN KEY (mother_id) REFERENCES ro_person(person_id) ON DELETE RESTRICT
);

CREATE TABLE ro_marriage_certificate
(
    marriage_certificate_id SERIAL,
    number_certificate varchar (20) NOT NULL ,
    issue_date date NOT NULL ,
    husband_id integer NOT NULL ,
    wife_id integer NOT NULL ,
    active boolean DEFAULT false,
    end_date date,
    PRIMARY KEY (marriage_certificate_id),
    FOREIGN KEY (husband_id) REFERENCES ro_person(person_id) ON DELETE RESTRICT,
    FOREIGN KEY (wife_id) REFERENCES ro_person(person_id) ON DELETE RESTRICT
);

INSERT INTO ro_person (sex, first_name, last_name, patronymic, date_birth)
VALUES (1, 'Елена', 'Васильевна', 'Сегреевна', '1998-03-24'),
       (2,'Олег','Васильев','Петрович', '1997-10-16'),
       (2, 'Николай', 'Васильев', 'Олегович', '2018-10-21');

INSERT INTO ro_passport (person_id, seria, number, issue_date, issue_department)
VALUES (1, '40000', '123456', '2018-04-10', 'Department passport');

INSERT INTO ro_birth_certificate (number_certificate, issue_date, person_id, father_id, mother_id)
VALUES ('123 Birth', '2018-11-01', 3, 2, 1);