CREATE TABLE [comment].[tbl_comments]
(
    [CommentId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [PostId] INT NOT NULL,
    [UserId] INT NOT NULL,
    [Content] NVARCHAR(1000) NOT NULL,
    [ParentCommentId] INT NULL, -- For nested comments/replies
    [LikesCount] INT NOT NULL DEFAULT 0,
    [IsActive] BIT NOT NULL DEFAULT 1,
    [CreatedDate] DATETIME NOT NULL DEFAULT GETUTCDATE(),
    [ModifiedDate] DATETIME NULL,
    
    CONSTRAINT FK_Comments_Posts FOREIGN KEY ([PostId]) REFERENCES [post].[tbl_posts]([PostId]) ON DELETE CASCADE,
    CONSTRAINT FK_Comments_ParentComment FOREIGN KEY ([ParentCommentId]) REFERENCES [comment].[tbl_comments]([CommentId])
);
GO

CREATE INDEX IX_Comments_PostId ON [comment].[tbl_comments]([PostId]);
GO

CREATE INDEX IX_Comments_UserId ON [comment].[tbl_comments]([UserId]);
GO

CREATE INDEX IX_Comments_ParentCommentId ON [comment].[tbl_comments]([ParentCommentId]);
GO

CREATE INDEX IX_Comments_CreatedDate ON [comment].[tbl_comments]([CreatedDate]);
GO

