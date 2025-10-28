CREATE TABLE [user].[tbl_userProfiles]
(
    [UserProfileId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [UserId] INT NOT NULL UNIQUE, -- References RomComMaster.auth.tbl_users
    [Bio] NVARCHAR(500) NULL,
    [DateOfBirth] DATE NULL,
    [Gender] NVARCHAR(20) NULL,
    [Location] NVARCHAR(200) NULL,
    [Website] NVARCHAR(500) NULL,
    [CoverImage] NVARCHAR(500) NULL,
    [IsPrivate] BIT NOT NULL DEFAULT 0,
    [FollowersCount] INT NOT NULL DEFAULT 0,
    [FollowingCount] INT NOT NULL DEFAULT 0,
    [PostsCount] INT NOT NULL DEFAULT 0,
    [CreatedDate] DATETIME NOT NULL DEFAULT GETUTCDATE(),
    [ModifiedDate] DATETIME NULL
);
GO

CREATE INDEX IX_UserProfiles_UserId ON [user].[tbl_userProfiles]([UserId]);
GO

