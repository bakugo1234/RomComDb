CREATE TABLE [app].[tbl_applications]
(
    [ApplicationId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [ApplicationName] NVARCHAR(100) NOT NULL,
    [ApplicationKey] NVARCHAR(100) NOT NULL,
    [Description] NVARCHAR(500) NULL,
    [IsActive] BIT NOT NULL DEFAULT 1,
    [CreatedDate] DATETIME NOT NULL DEFAULT GETUTCDATE(),
    [ModifiedDate] DATETIME NULL,
    
    CONSTRAINT UQ_Applications_Key UNIQUE ([ApplicationKey])
);
GO

CREATE INDEX IX_Applications_ApplicationKey ON [app].[tbl_applications]([ApplicationKey]);
GO

