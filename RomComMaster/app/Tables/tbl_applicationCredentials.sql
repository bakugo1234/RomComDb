CREATE TABLE [app].[tbl_applicationCredentials]
(
    [CredentialId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [ApplicationId] INT NOT NULL,
    [CredentialKey] NVARCHAR(100) NOT NULL,
    [CredentialValue] NVARCHAR(MAX) NOT NULL,
    [IsEncrypted] BIT NOT NULL DEFAULT 0,
    [CreatedDate] DATETIME NOT NULL DEFAULT GETUTCDATE(),
    [ModifiedDate] DATETIME NULL,
    
    CONSTRAINT FK_ApplicationCredentials_Applications FOREIGN KEY ([ApplicationId]) REFERENCES [app].[tbl_applications]([ApplicationId])
);
GO

CREATE INDEX IX_ApplicationCredentials_ApplicationId ON [app].[tbl_applicationCredentials]([ApplicationId]);
GO

