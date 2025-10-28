CREATE TABLE [auth].[tbl_users]
(
    [UserId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [UserName] NVARCHAR(50) NOT NULL,
    [Email] NVARCHAR(255) NOT NULL,
    [PasswordHash] NVARCHAR(255) NOT NULL,
    [FirstName] NVARCHAR(100) NULL,
    [LastName] NVARCHAR(100) NULL,
    [ProfilePicture] NVARCHAR(500) NULL,
    [RoleId] INT NOT NULL,
    [IsActive] BIT NOT NULL DEFAULT 1,
    [LastLoginDate] DATETIME NULL,
    [CreatedDate] DATETIME NOT NULL DEFAULT GETUTCDATE(),
    [CreatedBy] INT NULL,
    [ModifiedDate] DATETIME NULL,
    [ModifiedBy] INT NULL,
    
    CONSTRAINT FK_Users_Roles FOREIGN KEY ([RoleId]) REFERENCES [auth].[tbl_roles]([RoleId]),
    CONSTRAINT UQ_Users_UserName UNIQUE ([UserName]),
    CONSTRAINT UQ_Users_Email UNIQUE ([Email])
);
GO

CREATE INDEX IX_Users_UserName ON [auth].[tbl_users]([UserName]);
GO

CREATE INDEX IX_Users_Email ON [auth].[tbl_users]([Email]);
GO

CREATE INDEX IX_Users_RoleId ON [auth].[tbl_users]([RoleId]);
GO

CREATE INDEX IX_Users_IsActive ON [auth].[tbl_users]([IsActive]);
GO

-- Insert default admin user (password: admin123)
-- Note: Replace with proper hashed password in production
--INSERT INTO [auth].[tbl_users] ([UserName], [Email], [PasswordHash], [FirstName], [LastName], [RoleId], [IsActive], [CreatedDate])
--VALUES ('admin', 'admin@romcom.com', 'TEMP_HASH_admin123', 'Admin', 'User', 1, 1, GETUTCDATE());
--GO

