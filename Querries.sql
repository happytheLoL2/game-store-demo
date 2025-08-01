--egyszerû lekérdezések
SELECT * FROM Games;
SELECT * FROM Licenses;
SELECT * FROM Purchases;
SELECT * FROM UserGames;
SELECT * FROM Users;

SELECT * FROM Games WHERE ReleaseDate > '2015-12-31';
SELECT * FROM Games WHERE Genre LIKE '%Akcio%';
SELECT * FROM Games ORDER BY ReleaseDate DESC;

SELECT * FROM Purchases WHERE GameID = '5';
SELECT * FROM Purchases WHERE UserID = '9';
SELECT COUNT(PurchaseID) AS All_Purchases FROM Purchases;

SELECT * FROM UserGames WHERE ExpirationDate IS  NOT NULL;
SELECT * FROM UserGames WHERE ExpirationDate IS  NULL;

SELECT * FROM Users WHERE Username LIKE '%gamer%';

--középhaladó lekérdezések
SELECT  Users.Username, SUM(Games.Price) AS TotalSpent FROM Purchases 
JOIN Users ON Users.UserID = Purchases.UserID
JOIN Games ON Purchases.GameID = Games.GameID
GROUP BY Users.Username
ORDER BY TotalSpent DESC;

SELECT Users.Username, Games.Title AS GameTitle, UserGames.ExpirationDate AS Expiration_Date FROM Users
JOIN UserGames ON Users.UserID = UserGames.UserID
JOIN Games ON UserGames.GameID = Games.GameID
WHERE Users.Username = 'proplayer';

SELECT Games.Title, COUNT(DISTINCT Purchases.UserID) AS UserNumber FROM Purchases 
JOIN Games  ON Purchases.GameID = Games.GameID
GROUP BY Games.Title
HAVING COUNT(DISTINCT Purchases.UserID) >= 2;

SELECT Users.Username , Games.Title, Games.Price FROM Purchases
JOIN Users ON Purchases.UserID=Users.UserID
JOIN Games ON Purchases.GameID=Games.GameID
ORDER BY Price DESC;

SELECT Games.Title, COUNT(DISTINCT Licenses.LicenseID) AS LicenseTypeCount FROM Games
JOIN Purchases ON Games.GameID=Purchases.GameID
JOIN Licenses ON Purchases.LicenseID=Licenses.LicenseID
GROUP BY Games.Title HAVING COUNT(DISTINCT Licenses.LicenseID)>=1;

SELECT Games.GameDeveloper , COUNT(*) AS TotalGames From Games GROUP BY GameDeveloper ORDER BY TotalGames DESC;

SELECT Games.Genre, Games.Title, Games.ReleaseDate FROM Games
JOIN ( SELECT Genre, MAX(ReleaseDate) AS MaxRealeaseDate FROM Games GROUP BY Games.Genre) 
latest ON Games.Genre=latest.Genre AND Games.ReleaseDate=latest.MaxRealeaseDate
ORDER BY ReleaseDate DESC;


--haladó lekérdezések
SELECT TOP 1 Users.Username, COUNT(DISTINCT Purchases.GameID) AS GameNummber FROM Purchases
JOIN Users ON Users.UserID=Purchases.UserID GROUP BY Users.Username ORDER BY GameNummber DESC;

SELECT Games.Title, COUNT(Purchases.PurchaseID) AS CustomerNumber FROM Purchases
JOIN Games ON Games.GameID=Purchases.GameID GROUP BY Games.Title ORDER BY CustomerNumber DESC;

SELECT  Users.Username, Games.Title , COUNT(UserGames.UserGameID) AS ActiveKeys FROM UserGames
JOIN Games ON Games.GameID=UserGames.GameID 
JOIN Users ON Users.UserID=UserGames.UserID
WHERE UserGames.ExpirationDate > GETDATE()
GROUP BY Users.Username, Games.Title ORDER BY ActiveKeys DESC;

SELECT Purchases.UserID, Users.Username, Purchases.GameID, Games.Title FROM Purchases
JOIN Licenses ON Licenses.LicenseID=Purchases.LicenseID
JOIN Users ON Users.UserID=Purchases.UserID
JOIN Games ON Games.GameID=Purchases.GameID
GROUP BY Purchases.UserID, Users.Username, Purchases.GameID, Games.Title
HAVING
  SUM(CASE WHEN Licenses.DurationDays = 0 THEN 1 ELSE 0 END) > 0
  AND
  SUM(CASE WHEN Licenses.DurationDays > 0 THEN 1 ELSE 0 END) > 0
ORDER BY Users.Username;

SELECT Games.Title, SUM(Games.Price) AS TotalPrice FROM Purchases
JOIN Games ON Games.GameID=Purchases.GameID GROUP BY Games.Title ORDER BY TotalPrice DESC;


SELECT Games.Title, Games.Price, Licenses.Name AS LicenseType, Licenses.DurationDays, CAST(Games.Price AS FLOAT) / Licenses.DurationDays AS PricePerDay FROM Games
JOIN Licenses ON Licenses.Name=Games.KeyType WHERE Licenses.DurationDays > 0 ORDER BY PricePerDay ASC;

SELECT 'PC' AS Platform, COUNT(*) AS PurchaseCount FROM Purchases
JOIN Games ON Games.GameID=Purchases.GameID
WHERE Games.Platforms LIKE '%PC%'
UNION ALL
SELECT 'PlayStation', COUNT(*) FROM Purchases
JOIN Games ON Games.GameID=Purchases.GameID
WHERE Games.Platforms LIKE '%PlayStation%'
UNION ALL 
SELECT 'Xbox', COUNT(*) 
FROM Purchases 
JOIN Games  ON Purchases.GameID = Games.GameID
WHERE Games.Platforms LIKE '%Xbox%'
ORDER BY PurchaseCount DESC;