CREATE TABLE [post].[tbl_posts]
(
    [PostId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [UserId] INT NOT NULL,
    [Content] NVARCHAR(MAX) NULL,
    [MediaType] NVARCHAR(50) NULL, -- 'image', 'video', 'gif', 'none'
    [GroupId] INT NULL, -- For group posts
    [LikesCount] INT NOT NULL DEFAULT 0,
    [CommentsCount] INT NOT NULL DEFAULT 0,
    [SharesCount] INT NOT NULL DEFAULT 0,
    [IsActive] BIT NOT NULL DEFAULT 1,
    [CreatedDate] DATETIME NOT NULL DEFAULT GETUTCDATE(),
    [ModifiedDate] DATETIME NULL,
    
    CONSTRAINT FK_Posts_Groups FOREIGN KEY ([GroupId]) REFERENCES [group].[tbl_groups]([GroupId])
);
GO

CREATE INDEX IX_Posts_UserId ON [post].[tbl_posts]([UserId]);
GO

CREATE INDEX IX_Posts_GroupId ON [post].[tbl_posts]([GroupId]);
GO

CREATE INDEX IX_Posts_CreatedDate ON [post].[tbl_posts]([CreatedDate]);
GO

CREATE INDEX IX_Posts_IsActive ON [post].[tbl_posts]([IsActive]);
GO

