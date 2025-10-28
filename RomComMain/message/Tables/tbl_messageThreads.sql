CREATE TABLE [message].[tbl_messageThreads]
(
    [ThreadId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [User1Id] INT NOT NULL,
    [User2Id] INT NOT NULL,
    [LastMessageDate] DATETIME NOT NULL DEFAULT GETUTCDATE(),
    [CreatedDate] DATETIME NOT NULL DEFAULT GETUTCDATE(),
    
    CONSTRAINT UQ_MessageThreads_Users UNIQUE ([User1Id], [User2Id]),
    CONSTRAINT CK_MessageThreads_DifferentUsers CHECK ([User1Id] < [User2Id])
);
GO

CREATE INDEX IX_MessageThreads_User1Id ON [message].[tbl_messageThreads]([User1Id]);
GO

CREATE INDEX IX_MessageThreads_User2Id ON [message].[tbl_messageThreads]([User2Id]);
GO

CREATE INDEX IX_MessageThreads_LastMessageDate ON [message].[tbl_messageThreads]([LastMessageDate]);
GO

