CREATE TABLE [auth].[tbl_refreshTokens]
(
    [RefreshTokenId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [UserId] INT NOT NULL,
    [Token] NVARCHAR(500) NOT NULL,
    [ExpiresAt] DATETIME NOT NULL,
    [CreatedDate] DATETIME NOT NULL DEFAULT GETUTCDATE(),
    [IsRevoked] BIT NOT NULL DEFAULT 0,
    [RevokedDate] DATETIME NULL,
    
    CONSTRAINT FK_RefreshTokens_Users FOREIGN KEY ([UserId]) REFERENCES [auth].[tbl_users]([UserId]),
    CONSTRAINT UQ_RefreshTokens_Token UNIQUE ([Token])
);
GO

CREATE INDEX IX_RefreshTokens_Token ON [auth].[tbl_refreshTokens]([Token]);
GO

CREATE INDEX IX_RefreshTokens_UserId ON [auth].[tbl_refreshTokens]([UserId]);
GO

CREATE INDEX IX_RefreshTokens_ExpiresAt ON [auth].[tbl_refreshTokens]([ExpiresAt]);
GO

CREATE INDEX IX_RefreshTokens_IsRevoked ON [auth].[tbl_refreshTokens]([IsRevoked]);
GO

