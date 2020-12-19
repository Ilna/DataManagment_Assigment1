
-- QUERY A
-- An SQL query that counts all the comic books in your database.
SELECT COUNT(*) FROM books;

-- QUERY B
-- An  SQL  query  that returns  the  average  review  score  for  the  comic  book with  title “Feynman”. 
SELECT ROUND(AVG(score),2) FROM REVIEWS WHERE book_id IN(SELECT id FROM BOOKS WHERE title = 'Feynman')


-- QUERY C 
-- An SQL query that returns the ISBNs and titles for all books authored by “Alan Moore” (in any role)
SELECT BOOKS.title, BOOKS.isbn  
FROM AUTHORS JOIN BOOKSWITHAUTHORSANDROLES ON AUTHORS.id = BOOKSWITHAUTHORSANDROLES.author_id 
JOIN BOOKS ON  BOOKS.id = BOOKSWITHAUTHORSANDROLES.book_id 
WHERE author_name = 'Alan Moore'

-- QUERY D
-- An SQL transaction that modifies a user’s order by removing aprevious order with a new one of the same user
BEGIN TRANSACTION;
SAVEPOINT myapp_temporary_savepoint;

DELETE FROM ORDERS 
WHERE ID = ANY(ARRAY(
SELECT ORDERS.ID
FROM ORDERS JOIN USERS ON user_name= USERS.name
WHERE email = 'elenflo@gmail.com' AND order_completion_timestamp IS NULL 
ORDER BY order_placement_timestamp desc LIMIT 1
));

INSERT INTO ORDERS(user_name, address_id, order_placement_timestamp, order_completion_timestamp) VALUES
	((SELECT name FROM USERS WHERE email = 'elenflo@gmail.com'), (SELECT id FROM ADDRESSES WHERE user_name = 'elenflo' AND address = '21463 Barr Walks Nguyenmouth, MN 15102' ), '2020-12-13', NULL);

COMMIT;

