CREATE TABLE [message].[tbl_messages]
(
    [MessageId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [ThreadId] INT NOT NULL,
    [SenderId] INT NOT NULL,
    [Content] NVARCHAR(MAX) NOT NULL,
    [IsRead] BIT NOT NULL DEFAULT 0,
    [ReadDate] DATETIME NULL,
    [IsActive] BIT NOT NULL DEFAULT 1,
    [CreatedDate] DATETIME NOT NULL DEFAULT GETUTCDATE(),
    
    CONSTRAINT FK_Messages_Threads FOREIGN KEY ([ThreadId]) REFERENCES [message].[tbl_messageThreads]([ThreadId])
);
GO

CREATE INDEX IX_Messages_ThreadId ON [message].[tbl_messages]([ThreadId]);
GO

CREATE INDEX IX_Messages_SenderId ON [message].[tbl_messages]([SenderId]);
GO

CREATE INDEX IX_Messages_CreatedDate ON [message].[tbl_messages]([CreatedDate]);
GO

CREATE INDEX IX_Messages_IsRead ON [message].[tbl_messages]([IsRead]);
GO

