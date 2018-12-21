
// USING LIMIT ===================================================================================

SELECT v.make, v.age_band_of_driver as age, a.first_road_class as road_class, count(v.make) as count
FROM vehicle_information AS v
INNER JOIN accident_information AS a ON v.accident_index = a.accident_index
WHERE v.age_band_of_driver = '26 - 35' AND a.first_road_class = 'A' AND a.year BETWEEN 2010 AND 2012
GROUP BY v.make, v.age_band_of_driver, a.first_road_class
ORDER BY count DESC, v.make
LIMIT 1;

// USING MAX ===================================================================================

SELECT v.make, v.age_band_of_driver , a.first_road_class, count(v.make) as count INTO accident_sum_per_make
      FROM vehicle_information AS v
      INNER JOIN accident_information AS a ON v.accident_index = a.accident_index
      WHERE v.age_band_of_driver = '26 - 35' AND a.first_road_class = 'A' AND a.year BETWEEN 2010 AND 2012
      GROUP BY v.make, v.age_band_of_driver, a.first_road_class
      ORDER BY count DESC, v.make;


-- Formatted:

SELECT
	v.make,
	v.age_band_of_driver,
	a.first_road_class,
	count(v.make) as count INTO accident_sum_per_make
FROM
	vehicle_information AS v
INNER JOIN
	accident_information AS a
ON
	v.accident_index = a.accident_index
WHERE
	v.age_band_of_driver = '26 - 35'
AND
	a.first_road_class = 'A'
AND
	a.year BETWEEN 2010 AND 2012
GROUP BY
	v.make,
	v.age_band_of_driver,
	a.first_road_class
ORDER BY
	count DESC,
	v.make;


SELECT  v.make, v.age_band_of_driver , a.first_road_class, count(v.make) as count
      FROM vehicle_information AS v
      INNER JOIN accident_information AS a ON v.accident_index = a.accident_index
      WHERE v.age_band_of_driver = '26 - 35' AND a.first_road_class = 'A' AND a.year BETWEEN 2010 AND 2012
      GROUP BY v.make, v.age_band_of_driver, a.first_road_class
			HAVING count(v.make) = ( SELECT max(accident_sum_per_make.count) as count FROM accident_sum_per_make);


//====================================================================================================//

SELECT  
	vehicle_information.make, 
	vehicle_information.age_band_of_driver AS AGE, 
	accident_information.first_road_class AS ROAD ,
	COUNT(vehicle_information) AS ACCIDENTS
FROM vehicle_information
	INNER JOIN accident_information ON vehicle_information.accident_index = accident_information.accident_index 
WHERE 
	vehicle_information.age_band_of_driver = '26 - 35' 
	AND 
	(accident_information.year >= 2010 and accident_information.year <= 2012)
	AND 
	accident_information.first_road_class = 'A'
GROUP BY 
	vehicle_information.age_band_of_driver, 
	accident_information.first_road_class , 
	vehicle_information.make
HAVING COUNT(vehicle_information) = 
		(SELECT
			MAX(ACCIDENTS)
		FROM (
			SELECT  
					vehicle_information.make, 
					vehicle_information.age_band_of_driver AS AGE, 
					accident_information.first_road_class AS ROAD ,
					COUNT(vehicle_information) AS ACCIDENTS
			FROM vehicle_information
					INNER JOIN accident_information ON vehicle_information.accident_index = accident_information.accident_index 
			WHERE 
					vehicle_information.age_band_of_driver = '26 - 35' 
					AND 
					(accident_information.year >= 2010 and accident_information.year <= 2012)
					AND 
					accident_information.first_road_class = 'A'
			GROUP BY 
					vehicle_information.age_band_of_driver, 
					accident_information.first_road_class , 
					vehicle_information.make
			ORDER BY ACCIDENTS DESC																		
			)AS make_count
		)
	