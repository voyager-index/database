DROP TABLE IF EXISTS export;
CREATE TABLE export AS
SELECT c.name AS city, co.name AS country, TRUNC(c.lon, 2) AS lon, TRUNC(c.lat,2) AS lat, c.id,
p.total AS population, i.speed AS mbps,
cl.NearCoast AS beach, a.Exists AS airport,
e.elevation AS elevation, ap.Index as pollution,

-- temperature
t.Jan AS tempJan, t.Feb AS tempFeb, t.Mar AS tempMar, t.April AS tempApr, t.May AS tempMay, t.June AS tempJun, t.July AS tempJul, t.Aug AS tempAug, t.Sept AS tempSep, t.Oct AS tempOct, t.Nov AS tempNov, t.Dec AS tempDec,

-- precipitation
pr.Jan AS precipJan, pr.Feb AS precipFeb, pr.Mar AS precipMar, pr.April AS precipApr, pr.May AS precipMay, pr.June AS precipJun, pr.July AS precipJul, pr.Aug AS precipAug, pr.Sept AS precipSep, pr.Oct AS precipOct, pr.Nov AS precipNov, pr.Dec AS precipDec,

-- uv
uv.Jan AS uvJan, uv.Feb AS uvFeb, uv.Mar AS uvMar, uv.April AS uvApr, uv.May AS uvMay, uv.June AS uvJun, uv.July AS uvJul, uv.Aug AS uvAug, uv.Sept AS uvSep, uv.Oct AS uvOct, uv.Nov AS uvNov, uv.Dec AS uvDec,

-- socioeconomic
ppp.ppp AS purchasingpower,
pi.percent AS povertyIndex

FROM City c
INNER JOIN Air_pollution ap ON ap.CityId = c.id
INNER JOIN Airports a ON a.CityId = c.id
INNER JOIN Coastlines cl ON  cl.CityId = c.id
INNER JOIN Country co ON co.id = c.country
INNER JOIN Elevation e ON e.CityId = c.id
INNER JOIN Internet_Speed i ON i.Country = co.id
INNER JOIN Population p ON p.CityId = c.id
INNER JOIN Poverty_Index pi ON pi.Country = co.id
INNER JOIN Precipitation pr ON pr.CityId = c.id
INNER JOIN Puchasing_Power_Parity ppp ON ppp.Country = co.id
INNER JOIN Temp t ON t.CityId = c.id
INNER JOIN UV_Index uv ON uv.CityId = c.id

ORDER BY p.total DESC;

\copy (SELECT * FROM export) To 'voyager-index.csv' With CSV DELIMITER ',' HEADER;
