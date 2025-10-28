CREATE TABLE [post].[tbl_postMedia]
(
    [PostMediaId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [PostId] INT NOT NULL,
    [MediaUrl] NVARCHAR(500) NOT NULL,
    [MediaType] NVARCHAR(50) NOT NULL, -- 'image', 'video', 'gif'
    [ThumbnailUrl] NVARCHAR(500) NULL,
    [DisplayOrder] INT NOT NULL DEFAULT 0,
    [CreatedDate] DATETIME NOT NULL DEFAULT GETUTCDATE(),
    
    CONSTRAINT FK_PostMedia_Posts FOREIGN KEY ([PostId]) REFERENCES [post].[tbl_posts]([PostId]) ON DELETE CASCADE
);
GO

CREATE INDEX IX_PostMedia_PostId ON [post].[tbl_postMedia]([PostId]);
GO

