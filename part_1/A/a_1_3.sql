SELECT  vehicle_information.age_band_of_driver AS AGE, accident_information.urban_or_rural_area AS area, COUNT(vehicle_information) AS ACCIDENTS
FROM vehicle_information
INNER JOIN accident_information ON vehicle_information.accident_index = accident_information.accident_index 
WHERE vehicle_information.age_band_of_driver = '26 - 35' AND accident_information.urban_or_rural_area = 'Urban' 
AND accident_information.date < '2010-1-1'
GROUP BY vehicle_information.age_band_of_driver, accident_information.urban_or_rural_area 


-- Formatted:

SELECT 
    vehicles.age_band_of_driver AS AGE,
    accidents.urban_or_rural_area AS AREA,
    COUNT(vehicles) AS ACCIDENTS
FROM
    vehicle_information AS vehicles
INNER JOIN
    accident_information AS accidents
ON
    vehicles.accident_index = accidents.accident_index 
WHERE
    vehicles.age_band_of_driver = '26 - 35' AND accidents.urban_or_rural_area = 'Urban' 
AND
    accidents.date < '2010-1-1'
GROUP BY
    vehicles.age_band_of_driver, accidents.urban_or_rural_area;