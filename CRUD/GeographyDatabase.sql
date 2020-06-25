SELECT PeakName FROM Peaks
ORDER BY PeakName

SELECT TOP 30 CountryName, [Population] FROM Countries
WHERE ContinentCode = 'EU'
ORDER BY [Population] DESC,CountryName ASC

SELECT CountryName, CountryCode, 
CASE CurrencyCode 
WHEN 'EUR' THEN 'Euro'
ELSE 'Not Euro' END
FROM Countries
ORDER BY CountryName