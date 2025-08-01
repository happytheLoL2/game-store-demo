CREATE TABLE Users (
  UserID INT PRIMARY KEY IDENTITY,
  Username NVARCHAR(50) UNIQUE NOT NULL,
  Email NVARCHAR(100) UNIQUE NOT NULL,
  Passwords NVARCHAR(255) NOT NULL
);

CREATE TABLE Games (
    GameID INT PRIMARY KEY IDENTITY,
    Title NVARCHAR(100) NOT NULL,
    Descriptions NVARCHAR(MAX),
	Genre NVARCHAR(100) NOT NULL,
	Platforms NVARCHAR(50) NOT NULL,
	ReleaseDate DATE,
    Price DECIMAL(6,2),
    GameDeveloper NVARCHAR(100),
    KeyType NVARCHAR(20),
    LanguageSupport NVARCHAR(100),
    LastUpdated DATETIME
);

CREATE TABLE Licenses (
    LicenseID INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(50) NOT NULL,
    DurationDays INT NOT NULL
);

CREATE TABLE UserGames (
    UserGameID INT PRIMARY KEY IDENTITY,
    UserID INT NOT NULL,
    GameID INT NOT NULL,
    ExpirationDate DATE NULL,

    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (GameID) REFERENCES Games(GameID)
);

CREATE TABLE Purchases (
    PurchaseID INT PRIMARY KEY IDENTITY,
    UserID INT NOT NULL,
    GameID INT NOT NULL,
    LicenseID INT NOT NULL,
    PurchaseDate DATETIME NOT NULL,

    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (GameID) REFERENCES Games(GameID),
    FOREIGN KEY (LicenseID) REFERENCES Licenses(LicenseID)
);

CREATE TRIGGER trg_AfterPurchaseInsert
ON Purchases
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO UserGames (UserID, GameID, ExpirationDate)
    SELECT 
        i.UserID,
        i.GameID,
        CASE 
            WHEN l.DurationDays = 0 THEN NULL 
            ELSE DATEADD(DAY, l.DurationDays, i.PurchaseDate)
        END
    FROM inserted i
    JOIN Licenses l ON i.LicenseID = l.LicenseID;
END;

INSERT INTO Users (Username, Email, Passwords) VALUES
('jatekos123', 'jatekos123@example.com', 'Jatekos123!@#'),
('proplayer', 'proplayer@example.com', 'Pro.Player2025@!'),
('ninjaWarrior_88', 'ninjaWarrior_88@example.com', 'Ninja88@Warrior'),
('speedRunnerX', 'speedRunnerX@example.com', 'SpeedRunX123!'),
('shadowHunterX', 'shadowHunterX@example.com', 'ShadowXHunter!#2025'),
('ultraPlayer27', 'ultraPlayer27@example.com', 'Ultra@Player27!'),
('stealthAssassinX', 'stealthAssassinX@example.com', 'StealthX@Assassin'),
('gameMaster2025', 'gameMaster2025@example.com', 'GameMaster2025$%'),
('epicWizardX', 'epicWizardX@example.com', 'EpicWizardX@2025'),
('cyberGamerXx', 'cyberGamerXx@example.com', 'CyberX@Gamer!2025'),
('fireDragonX', 'fireDragonX@example.com', 'FireDragon!X'),
('dragonSlayerX', 'dragonSlayerX@example.com', 'DragonSlayerX123!'),
('stormBreaker_77', 'stormBreaker_77@example.com', 'StormBreaker77$#'),
('legendQuest_90', 'legendQuest_90@example.com', 'Legend@Quest90!'),
('blitzWarriorX', 'blitzWarriorX@example.com', 'Blitz@WarriorX2025'),
('gamerKing_42', 'gamerKing_42@example.com', 'GamerKing42@!'),
('arcaneMaster_88', 'arcaneMaster_88@example.com', 'ArcaneMaster88X@!'),
('pixelMaster_77', 'pixelMaster_77@example.com', 'PixelMaster77!@#'),
('hyperFighterX', 'hyperFighterX@example.com', 'Hyper@FighterX2025'),
('phantomGamer_99', 'phantomGamer_99@example.com', 'PhantomGamer99!X');

INSERT INTO Games (Title, Descriptions, Genre, Platforms, ReleaseDate, Price, GameDeveloper, KeyType, LanguageSupport, LastUpdated) VALUES
('Future Wars', 'Sci-fi lövöldözõs játék', 'Akció', 'PC, PlayStation', '1989-01-01', 49.99, 'Delphine Software International', 'Örökös', 'Angol, Magyar, Nemet', '2024-04-05'),
('Future Wars', 'Sci-fi lövöldözõs játék', 'Akció', 'PC, PlayStation', '1989-01-01', 24.99, 'Delphine Software International', '14 napos', 'Angol, Magyar, Nemet', '2024-04-05'),
('PixelQuest', 'Retro platformer', 'Platformer', 'PC, Switch', '2024-11-01', 19.99, 'RetroGames', 'Örökös', 'Angol', '2024-04-05'),
('Tom Clancy''s Rainbow Six Siege', 'Taktikai shooter, Stratégiai játék', 'Akció, Csapatalapu', 'PC, PlayStation, Xbox', '2015-12-01', 19.99, 'Ubisoft', 'Örökös', 'Angol, Magyar, Nemet', '2024-04-05'),
('Tom Clancy''s Rainbow Six Siege', 'Taktikai shooter, Stratégiai játék', 'Akció, Csapatalapu', 'PC, PlayStation, Xbox', '2015-12-01', 9.99, 'Ubisoft', '30 napos', 'Angol, Magyar, Nemet', '2024-04-05'),
('Tom Clancy''s Rainbow Six Siege', 'Taktikai shooter, Stratégiai játék', 'Akció, Csapatalapu', 'PC, PlayStation, Xbox', '2015-12-01', 4.99, 'Ubisoft', '7 napos', 'Angol, Magyar, Nemet', '2024-04-05'),
('Battlefield™ V', 'második világháborús lövöldözõs játék', 'Akcio', 'PC', '2018-11-09', 49.99, 'DICE', 'Örökös', 'Angol, Nemet', '2024-04-05'),
('Battlefield™ V', 'második világháborús lövöldözõs játék', 'Akcio', 'PC', '2018-11-09', 24.99, 'DICE', '30 napos', 'Angol, Nemet', '2024-04-05'),
('Battlefield™ V', 'második világháborús lövöldözõs játék', 'Akcio', 'PC', '2018-11-09', 4.99, 'DICE', '7 napos', 'Angol, Nemet', '2024-04-05'),
('Dying Light', 'Zombis, Tulelo horror, Nyilt vilag', 'Horror', 'PC', '2015-01-26', 19.99, 'Techland', 'Örökös', 'Angol, Nemet', '2024-04-05'),
('Dying Light', 'Zombis, Tulelo horror, Nyilt vilag', 'Horror', 'PC', '2015-01-26', 9.99, 'Techland', '30 napos', 'Angol, Nemet', '2024-04-05'),
('Dying Light', 'Zombis, Tulelo horror, Nyilt vilag', 'Horror', 'PC', '2015-01-26', 3.99, 'Techland', '7 napos', 'Angol, Nemet', '2024-04-05'),
('Firewatch', 'Kaland, TortenetGazdag, Rejtely', 'Kaland', 'PC, PlayStation, Xbox', '2016-02-09', 15.99, 'Campo Santo', 'Örökös', 'Angol, Nemet', '2024-04-05'),
('Cyberpunk 2077', 'RPG, Nyilt vilag', 'Akcio-RPG, Kaland', 'PC, PlayStation', '2020-12-10', 59.99, 'CD PROJEKT RED', 'Örökös', 'Angol, Magyar, Nemet', '2024-04-05'),
('Cyberpunk 2077', 'RPG, Nyilt vilag', 'Akcio-RPG, Kaland', 'PC, PlayStation', '2020-12-10', 29.99, 'CD PROJEKT RED', '30 napos', 'Angol, Magyar, Nemet', '2024-04-05'),
('The Last of Us™ Part I', 'Tortenet Gazdag, Posztapokaliptikus, Zombis', 'Horror, Akcio', 'PC, PlayStation', '2023-03-28', 59.99, 'Naughty Dog', 'Örökös', 'Angol', '2024-04-05'),
('The Last of Us™ Part I', 'Tortenet Gazdag, Posztapokaliptikus, Zombis', 'Horror, Akcio', 'PC, PlayStation', '2023-03-28', 29.99, 'Naughty Dog', '30 napos', 'Angol', '2024-04-05'),
('Grand Theft Auto', 'Akcio, Nyilt Vilag, Tortenet, Lovoldozos', 'Akcio', 'PC, PlayStation, Xbox', '2013-10-17', 29.99, 'Rockstar Games', 'Örökös', 'Angol, Nemet', '2024-04-05'),
('Grand Theft Auto', 'Akcio, Nyilt Vilag, Tortenet, Lovoldozos', 'Akcio', 'PC, PlayStation, Xbox', '2013-10-17', 14.99, 'Rockstar Games', '30 napos', 'Angol, Nemet', '2024-04-05'),
('Grand Theft Auto', 'Akcio, Nyilt Vilag, Tortenet, Lovoldozos', 'Akcio', 'PC, PlayStation, Xbox', '2013-10-17', 4.99, 'Rockstar Games', '7 napos', 'Angol, Nemet', '2024-04-05');


INSERT INTO Licenses (Name, DurationDays) VALUES
('Örökös', 0),
('7 napos', 7),
('30 napos', 30);

INSERT INTO Purchases (UserID,GameID , LicenseID, PurchaseDate)
VALUES
(1, 2, 2, GETDATE()),
(2, 1, 1, GETDATE()),
(3,4, 1, GETDATE()),
(4, 7, 1, GETDATE()),
(5, 20, 2, GETDATE()),
(6, 15, 1, GETDATE()),
(7, 9, 3, GETDATE()),
(8, 5, 1, GETDATE()),
(9, 14, 1, GETDATE()),
(10, 19, 3, GETDATE()),
(11, 3, 1, GETDATE()),
(12, 6, 3, GETDATE()),
(13, 8, 3, GETDATE()),
(14, 18, 1, GETDATE()),
(15, 11, 3, GETDATE()),
(16, 12, 2, GETDATE()),
(17, 17, 3, GETDATE()),
(18, 8, 3, GETDATE()),
(19, 5, 3, GETDATE()),
(20, 13, 1, GETDATE()),
(4, 15, 3, GETDATE()),
(9,16, 1, GETDATE()),
(7, 9, 2, GETDATE()),
(2, 18, 1, GETDATE()),
(5, 2,2, GETDATE()),
(3, 20, 2, GETDATE()),
(14,14, 1, GETDATE()),
(11, 12, 2, GETDATE()),
(20, 5, 1, GETDATE()),
(18, 6, 3, GETDATE());


INSERT INTO UserGames (UserID, GameID)
VALUES
(1, 2),
(2, 1),
(3, 4),
(4, 7),
(5, 20),
(6, 15),
(7, 9),
(8, 5),
(9, 14),
(10, 19),
(11, 3),
(12, 6),
(13, 8),
(14, 18),
(15, 11),
(16, 12),
(17, 17),
(18, 8),
(19, 5),
(20, 13),
(4, 15),
(9, 16),
(7, 9),
(2, 18),
(5, 2),
(3, 20),
(14, 14),
(11, 12),
(20, 5),
(18, 6);

select * from Purchases;
select * from UserGames;
select * from Games;

INSERT INTO Purchases (UserID,GameID , LicenseID, PurchaseDate)
VALUES
(4, 8, 3, GETDATE()),
(7, 20, 2, GETDATE()),
(16, 10, 1, GETDATE());

INSERT INTO UserGames (UserID, GameID)
VALUES
(4, 7),
(7,20),
(16,10);

INSERT INTO Purchases (UserID,GameID , LicenseID, PurchaseDate)
VALUES
(17, 4, 1, GETDATE()),
(3, 9, 2, GETDATE()),
(12, 19, 3, GETDATE());

INSERT INTO UserGames (UserID, GameID)
VALUES
(17, 4),
(3,9),
(12,19);


INSERT INTO Purchases (UserID,GameID , LicenseID, PurchaseDate)
VALUES
(10, 15, 3, GETDATE()),
(18, 5, 3, GETDATE()),
(7, 11, 3, GETDATE());

INSERT INTO UserGames (UserID, GameID)
VALUES
(10, 15),
(18,5),
(7,11);