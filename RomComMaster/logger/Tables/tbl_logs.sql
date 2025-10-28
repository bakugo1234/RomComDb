CREATE TABLE [logger].[tbl_logs]
(
    [LogId] BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [Level] NVARCHAR(20) NOT NULL, -- 'Info', 'Warning', 'Error', 'Debug'
    [Message] NVARCHAR(MAX) NOT NULL,
    [Exception] NVARCHAR(MAX) NULL,
    [StackTrace] NVARCHAR(MAX) NULL,
    [Source] NVARCHAR(100) NULL,
    [UserId] INT NULL,
    [IpAddress] NVARCHAR(45) NULL,
    [RequestPath] NVARCHAR(500) NULL,
    [CreatedDate] DATETIME NOT NULL DEFAULT GETUTCDATE(),
    
    CONSTRAINT FK_Logs_Users FOREIGN KEY ([UserId]) REFERENCES [auth].[tbl_users]([UserId])
);
GO

CREATE INDEX IX_Logs_Level ON [logger].[tbl_logs]([Level]);
GO

CREATE INDEX IX_Logs_CreatedDate ON [logger].[tbl_logs]([CreatedDate]);
GO

CREATE INDEX IX_Logs_UserId ON [logger].[tbl_logs]([UserId]);
GO

CREATE INDEX IX_Logs_Source ON [logger].[tbl_logs]([Source]);
GO

