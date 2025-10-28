CREATE TABLE [notification].[tbl_notifications]
(
    [NotificationId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [UserId] INT NOT NULL,
    [Type] NVARCHAR(50) NOT NULL, -- 'Like', 'Comment', 'Follow', 'Message', 'FriendRequest'
    [Title] NVARCHAR(200) NOT NULL,
    [Content] NVARCHAR(500) NULL,
    [RelatedId] INT NULL, -- ID of related entity (PostId, CommentId, UserId)
    [RelatedType] NVARCHAR(50) NULL, -- 'Post', 'Comment', 'User'
    [FromUserId] INT NULL, -- User who triggered the notification
    [IsRead] BIT NOT NULL DEFAULT 0,
    [ReadDate] DATETIME NULL,
    [CreatedDate] DATETIME NOT NULL DEFAULT GETUTCDATE()
);
GO

CREATE INDEX IX_Notifications_UserId ON [notification].[tbl_notifications]([UserId]);
GO

CREATE INDEX IX_Notifications_IsRead ON [notification].[tbl_notifications]([IsRead]);
GO

CREATE INDEX IX_Notifications_CreatedDate ON [notification].[tbl_notifications]([CreatedDate]);
GO

CREATE INDEX IX_Notifications_Type ON [notification].[tbl_notifications]([Type]);
GO

