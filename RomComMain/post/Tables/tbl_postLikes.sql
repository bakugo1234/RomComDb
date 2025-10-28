CREATE TABLE [post].[tbl_postLikes]
(
    [PostLikeId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [PostId] INT NOT NULL,
    [UserId] INT NOT NULL,
    [CreatedDate] DATETIME NOT NULL DEFAULT GETUTCDATE(),
    
    CONSTRAINT FK_PostLikes_Posts FOREIGN KEY ([PostId]) REFERENCES [post].[tbl_posts]([PostId]) ON DELETE CASCADE,
    CONSTRAINT UQ_PostLikes_User_Post UNIQUE ([PostId], [UserId])
);
GO

CREATE INDEX IX_PostLikes_PostId ON [post].[tbl_postLikes]([PostId]);
GO

CREATE INDEX IX_PostLikes_UserId ON [post].[tbl_postLikes]([UserId]);
GO

