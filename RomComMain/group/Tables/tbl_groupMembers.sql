CREATE TABLE [group].[tbl_groupMembers]
(
    [GroupMemberId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [GroupId] INT NOT NULL,
    [UserId] INT NOT NULL,
    [Role] NVARCHAR(20) NOT NULL DEFAULT 'Member', -- 'Admin', 'Moderator', 'Member'
    [JoinedDate] DATETIME NOT NULL DEFAULT GETUTCDATE(),
    [IsActive] BIT NOT NULL DEFAULT 1,
    
    CONSTRAINT FK_GroupMembers_Groups FOREIGN KEY ([GroupId]) REFERENCES [group].[tbl_groups]([GroupId]),
    CONSTRAINT UQ_GroupMembers_Group_User UNIQUE ([GroupId], [UserId])
);
GO

CREATE INDEX IX_GroupMembers_GroupId ON [group].[tbl_groupMembers]([GroupId]);
GO

CREATE INDEX IX_GroupMembers_UserId ON [group].[tbl_groupMembers]([UserId]);
GO

CREATE INDEX IX_GroupMembers_Role ON [group].[tbl_groupMembers]([Role]);
GO

