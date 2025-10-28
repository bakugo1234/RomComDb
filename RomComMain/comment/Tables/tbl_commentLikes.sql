CREATE TABLE [comment].[tbl_commentLikes]
(
    [CommentLikeId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [CommentId] INT NOT NULL,
    [UserId] INT NOT NULL,
    [CreatedDate] DATETIME NOT NULL DEFAULT GETUTCDATE(),
    
    CONSTRAINT FK_CommentLikes_Comments FOREIGN KEY ([CommentId]) REFERENCES [comment].[tbl_comments]([CommentId]) ON DELETE CASCADE,
    CONSTRAINT UQ_CommentLikes_User_Comment UNIQUE ([CommentId], [UserId])
);
GO

CREATE INDEX IX_CommentLikes_CommentId ON [comment].[tbl_commentLikes]([CommentId]);
GO

CREATE INDEX IX_CommentLikes_UserId ON [comment].[tbl_commentLikes]([UserId]);
GO

