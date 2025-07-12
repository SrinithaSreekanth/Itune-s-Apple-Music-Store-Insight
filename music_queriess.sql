Q1. Who is the senior most employee based on job title?
SELECT * 
FROM "Employee"
ORDER BY title DESC
LIMIT 1;

Q2. Which countries have the most Invoices?
SELECT billing_country, COUNT(*) AS total_invoices
FROM "Invoice"
GROUP BY billing_country 
ORDER BY total_invoices DESC
LIMIT 5;

Q3. What are top 3 values of total invoice?
SELECT total 
FROM "Invoice"
ORDER BY total DESC
LIMIT 3;

Q4. City with the highest sum of invoice totals
SELECT billing_city, SUM(total) AS city_total
FROM "Invoice"
GROUP BY billing_city
ORDER BY city_total DESC
LIMIT 1;

Q5. Who is the best customer (spent the most)?
SELECT c.customer_id, c.first_name, c.last_name, SUM(i.total) AS total_spent
FROM "Customer" c
JOIN "Invoice" i ON c.customer_id = i.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 1;

Q6. Email, name, & Genre of all Rock Music listeners (starting with A)
SELECT DISTINCT c.email, c.first_name, c.last_name, g.name AS genre
FROM "Customer" c
JOIN "Invoice" i ON c.customer_id = i.customer_id
JOIN "Invoice Line" il ON i.invoice_id = il.invoice_id
JOIN "Track" t ON il.track_id = t.track_id
JOIN "Genre" g ON t.genre_id = g.genre_id
WHERE g.name = 'Rock'
AND c.email ILIKE 'a%'
ORDER BY c.email;

Q7. Top 10 rock artists by number of tracks
SELECT ar.name AS artist_name, COUNT(t.track_id) AS track_count
FROM "Track" t
JOIN "Genre" g ON t.genre_id = g.genre_id
JOIN "Album" al ON t.album_id = al.album_id
JOIN "Artist" ar ON al.artist_id = ar.artist_id
WHERE g.name = 'Rock'
GROUP BY ar.artist_id, ar.name
ORDER BY track_count DESC
LIMIT 10;

Q8. Tracks longer than average song length
SELECT name, milliseconds
FROM "Track"
WHERE milliseconds > (
    SELECT AVG(milliseconds)
    FROM "Track"
)
ORDER BY milliseconds DESC;

Q12. Most popular artists by number of purchases
SELECT ar.name AS artist_name, COUNT(il.invoice_line_id) AS purchase_count
FROM "Invoice Line" il
JOIN "Track" t ON il.track_id = t.track_id
JOIN "Album" al ON t.album_id = al.album_id
JOIN "Artist" ar ON al.artist_id = ar.artist_id
GROUP BY ar.name
ORDER BY purchase_count DESC;

Q13. Most popular song
SELECT t.name AS song, COUNT(*) AS purchases
FROM "Invoice Line" il
JOIN "Track" t ON il.track_id = t.track_id
GROUP BY t.name
ORDER BY purchases DESC
LIMIT 1;
 
 Q14. Average prices of different types of music
SELECT g.name AS genre, ROUND(AVG(il.unit_price), 2) AS avg_price
FROM "Invoice Line" il
JOIN "Track" t ON il.track_id = t.track_id
JOIN "Genre" g ON t.genre_id = g.genre_id
GROUP BY g.name
ORDER BY avg_price DESC;