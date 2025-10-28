CREATE TABLE [auth].[tbl_roles]
(
    [RoleId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [RoleName] NVARCHAR(50) NOT NULL,
    [Description] NVARCHAR(255) NULL,
    [IsActive] BIT NOT NULL DEFAULT 1,
    [CreatedDate] DATETIME NOT NULL DEFAULT GETUTCDATE(),
    [ModifiedDate] DATETIME NULL,
    
    CONSTRAINT UQ_Roles_RoleName UNIQUE ([RoleName])
);
GO

-- Insert default roles
--INSERT INTO [auth].[tbl_roles] ([RoleName], [Description], [IsActive], [CreatedDate])
--VALUES 
  --  ('Administrator', 'Full system access', 1, GETUTCDATE()),
   -- ('User', 'Standard user access', 1, GETUTCDATE()),
   -- ('Moderator', 'Content moderation access', 1, GETUTCDATE());
--GO

