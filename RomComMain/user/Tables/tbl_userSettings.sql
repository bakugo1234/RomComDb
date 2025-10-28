CREATE TABLE [user].[tbl_userSettings]
(
    [UserSettingId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [UserId] INT NOT NULL UNIQUE,
    [EmailNotifications] BIT NOT NULL DEFAULT 1,
    [PushNotifications] BIT NOT NULL DEFAULT 1,
    [ShowOnlineStatus] BIT NOT NULL DEFAULT 1,
    [AllowMessages] NVARCHAR(20) NOT NULL DEFAULT 'Everyone', -- 'Everyone', 'Friends', 'None'
    [Language] NVARCHAR(10) NOT NULL DEFAULT 'en',
    [Theme] NVARCHAR(20) NOT NULL DEFAULT 'Light', -- 'Light', 'Dark'
    [CreatedDate] DATETIME NOT NULL DEFAULT GETUTCDATE(),
    [ModifiedDate] DATETIME NULL
);
GO

CREATE INDEX IX_UserSettings_UserId ON [user].[tbl_userSettings]([UserId]);
GO

