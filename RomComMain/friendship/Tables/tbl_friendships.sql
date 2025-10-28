CREATE TABLE [friendship].[tbl_friendships]
(
    [FriendshipId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [UserId] INT NOT NULL,
    [FriendId] INT NOT NULL,
    [Status] NVARCHAR(20) NOT NULL DEFAULT 'Pending', -- 'Pending', 'Accepted', 'Rejected', 'Blocked'
    [RequestedDate] DATETIME NOT NULL DEFAULT GETUTCDATE(),
    [AcceptedDate] DATETIME NULL,
    [RejectedDate] DATETIME NULL,
    
    CONSTRAINT CK_Friendships_DifferentUsers CHECK ([UserId] <> [FriendId])
);
GO

CREATE INDEX IX_Friendships_UserId ON [friendship].[tbl_friendships]([UserId]);
GO

CREATE INDEX IX_Friendships_FriendId ON [friendship].[tbl_friendships]([FriendId]);
GO

CREATE INDEX IX_Friendships_Status ON [friendship].[tbl_friendships]([Status]);
GO

