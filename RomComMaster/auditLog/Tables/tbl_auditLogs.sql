CREATE TABLE [auditLog].[tbl_auditLogs]
(
    [AuditLogId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [UserId] INT NULL,
    [Action] NVARCHAR(100) NOT NULL,
    [TableName] NVARCHAR(100) NULL,
    [RecordId] INT NULL,
    [OldValues] NVARCHAR(MAX) NULL,
    [NewValues] NVARCHAR(MAX) NULL,
    [AffectedChanges] NVARCHAR(MAX) NULL,
    [IpAddress] NVARCHAR(45) NULL,
    [CreatedDate] DATETIME NOT NULL DEFAULT GETUTCDATE(),
    
    CONSTRAINT FK_AuditLogs_Users FOREIGN KEY ([UserId]) REFERENCES [auth].[tbl_users]([UserId])
);
GO

CREATE INDEX IX_AuditLogs_UserId ON [auditLog].[tbl_auditLogs]([UserId]);
GO

CREATE INDEX IX_AuditLogs_CreatedDate ON [auditLog].[tbl_auditLogs]([CreatedDate]);
GO

CREATE INDEX IX_AuditLogs_TableName ON [auditLog].[tbl_auditLogs]([TableName]);
GO

CREATE INDEX IX_AuditLogs_Action ON [auditLog].[tbl_auditLogs]([Action]);
GO

