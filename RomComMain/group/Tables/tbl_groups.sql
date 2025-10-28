CREATE TABLE [group].[tbl_groups]
(
    [GroupId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [GroupName] NVARCHAR(100) NOT NULL,
    [Description] NVARCHAR(1000) NULL,
    [GroupImage] NVARCHAR(500) NULL,
    [CoverImage] NVARCHAR(500) NULL,
    [CreatedBy] INT NOT NULL,
    [IsPrivate] BIT NOT NULL DEFAULT 0,
    [MembersCount] INT NOT NULL DEFAULT 0,
    [PostsCount] INT NOT NULL DEFAULT 0,
    [IsActive] BIT NOT NULL DEFAULT 1,
    [CreatedDate] DATETIME NOT NULL DEFAULT GETUTCDATE(),
    [ModifiedDate] DATETIME NULL
);
GO

CREATE INDEX IX_Groups_CreatedBy ON [group].[tbl_groups]([CreatedBy]);
GO

CREATE INDEX IX_Groups_IsPrivate ON [group].[tbl_groups]([IsPrivate]);
GO

CREATE INDEX IX_Groups_IsActive ON [group].[tbl_groups]([IsActive]);
GO

