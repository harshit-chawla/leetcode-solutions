SELECT Weather.id FROM Weather
JOIN Weather w2 
ON Weather.recordDate = DATEADD(day, 1, w2.recordDate)
WHERE Weather.temperature > w2.temperature;