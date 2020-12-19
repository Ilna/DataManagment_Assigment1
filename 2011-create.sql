CREATE TABLE PUBLISHERS(
	name varchar(100) PRIMARY KEY,
	country_of_headquarters varchar(10),
	contact_phone bigint NOT NULL,
	address varchar(100) DEFAULT NULL
);

CREATE TABLE AUTHORS
(
    id integer PRIMARY KEY,
    author_name varchar(150) DEFAULT 'UNKNOWN',
    gender varchar(40) NOT NULL
);

CREATE TABLE BOOKS
(
    isbn varchar(10) PRIMARY KEY,
    title varchar(300) NOT NULL,
	author_id integer NOT NULL,
    publisher varchar(100) DEFAULT 'UNKNOWN',
    publication_year varchar(10) DEFAULT NULL,
    short_description varchar(7000) DEFAULT NULL,
	id varchar(10) UNIQUE,
    price numeric(5,2) NOT NULL,
	CONSTRAINT fk_author FOREIGN KEY(author_id) REFERENCES authors(id)
);

CREATE TABLE BOOKSWITHAUTHORSANDROLES(
	author_id integer,
	book_isbn varchar(10) NOT NULL,
	author_role varchar(50) DEFAULT NULL,
	author_nationality varchar(20) DEFAULT 'UNKNOWN',
	book_id varchar(10) NOT NULL,
	CONSTRAINT fk_book FOREIGN KEY(book_id) REFERENCES books(id),
	CONSTRAINT fk_author FOREIGN KEY(author_id) REFERENCES authors(id)
);

CREATE TABLE REVIEWS(
	review_id varchar(32) PRIMARY KEY,
	book_id varchar(10) NOT NULL,
	score integer NOT NULL,
	review_text varchar(20000) DEFAULT NULL,
	creation_timestamp timestamp(6) NOT NULL,
	nickname varchar(40) NOT NULL
);

CREATE TABLE USERS(
	name varchar(30) PRIMARY KEY,
	password varchar(100) NOT NULL,
	email varchar(150) UNIQUE,
	real_name varchar(100) NOT NULL
);

CREATE TABLE ADDRESSES(
	id serial PRIMARY KEY,
	user_name varchar(30) NOT NULL,
	address varchar(150) UNIQUE,
	CONSTRAINT fk_user FOREIGN KEY(user_name) REFERENCES users(name)
);

CREATE TABLE ORDERS(
	id serial PRIMARY KEY,
	user_name varchar(30),
	address_id integer NOT NULL,
	order_placement_timestamp date NOT NULL,
	order_completion_timestamp date Check(order_placement_timestamp < order_completion_timestamp) DEFAULT NULL,
	CONSTRAINT fk_user FOREIGN KEY(user_name) REFERENCES users(name),
	CONSTRAINT fk_address FOREIGN KEY(address_id) REFERENCES addresses(id)
);