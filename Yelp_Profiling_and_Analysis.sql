-- Data Scientist Role Play: Profiling and Analyzing the Yelp Dataset Coursera Worksheet

-- Part 1: Yelp Dataset Profiling and Understanding
	
-- Code used to determine columns with null values in the Users table: 

	select *
	from User as u
	where (u.id is null)
	or (u.name is null)
	or (u.review_count is null)
	or (u.yelping_since is null)
	or (u.useful is null)
	or (u.funny is null)
	or (u.cool is null)
	or (u.fans is null)
	or (u.average_stars is null)
	or (u.compliment_hot is null)
	or (u.compliment_more is null)
	or (u.compliment_profile is null)
	or (u.compliment_cute is null)
	or (u.compliment_list is null)
	or (u.compliment_note is null)
	or (u.compliment_plain is null)
	or (u.compliment_cool is null)
	or (u.compliment_funny is null)
	or (u.compliment_writer is null)
	or (u.compliment_photos is null)
	
	


-- SQL code used to list the cities with the most reviews in descending order

	select city
	, sum(Review_count) as total_review_count
	from business
	group by city
	order by total_review_count desc
	
	
	
	
-- Code to find the top 3 users based on their total number of reviews:
	
	SELECT name
	, review_count
	FROM user
	ORDER BY review_count DESC
	LIMIT 3
	
	
	
	
-- SQL code used to determine if there are more reviews with the word "love" or with the word "hate" in them:
		
	SELECT 
	    (SELECT count(rev1.text) 
	     FROM review as rev1
	     WHERE rev1.text LIKE '%love%') AS love_review_count
	     ,
	     (SELECT count(rev2.text) 
	     FROM review as rev2
	     WHERE rev2.text LIKE '%hate%') AS hate_review_count

	


-- Code to find the top 10 users with the most fans:

	SELECT name
	, fans
	FROM user
	ORDER BY fans DESC
	LIMIT 10
	
	
	
	
	
	
	
	
	
	
-- Part 2: Inferences and Analysis	


-- Code used to find if two ratings of business depend on different distribution of opening hours

	SELECT name
	, bus.city
	, cat.category
	, bus.stars
	, hou.hours
	FROM business AS bus 
	INNER JOIN category AS cat ON bus.id = cat.business_id 
	INNER JOIN hours AS hou ON bus.id = hou.business_id

	WHERE (bus.city = 'Las Vegas')
	and (cat.category = 'Shopping')
	
	ORDER BY bus.stars 



-- Code to see if ratings are connected with the number of reviews of businesses

 	SELECT name
	, bus.city
	, cat.category
	, bus.stars
	, bus.review_count
	FROM business AS bus 
	INNER JOIN category AS cat ON bus.id = cat.business_id 

	WHERE (bus.city = 'Las Vegas')
	and (cat.category = 'Shopping')

	ORDER BY bus.stars 



-- Code to infer relation of the location with the ratings

	SELECT name
	, bus.city
	, cat.category
	, bus.stars
	, bus.address
	, bus.postal_code

	FROM business AS bus 
	INNER JOIN category AS cat ON bus.id = cat.business_id 

	WHERE (bus.city = 'Las Vegas')
	and (cat.category = 'Shopping')

	ORDER BY bus.stars 
		
		
         
         
-- SQL code used to find the difference between the ones that are still open and the ones that are closed

	SELECT 
	bus.is_open
	, avg(bus.stars)
	, avg(bus.review_count)

	FROM business AS bus
	GROUP BY bus.is_open
	
	
	
         
-- SQL code to explore if having more photos of a business affect the perception of users in terms of how many stars they give to the business:

	SELECT bus.name
	, bus.stars
	, count(pho.business_id) as total_photos

	FROM business AS bus 
	INNER JOIN photo AS pho ON bus.id = pho.business_id
	GROUP BY pho.business_id

	ORDER BY total_photos DESC
