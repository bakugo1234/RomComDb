CREATE PROCEDURE [group].[sp_Group_GetById]
    @GroupId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        GroupId,
        GroupName,
        Description,
        GroupImage,
        CoverImage,
        CreatedBy,
        IsPrivate,
        MembersCount,
        PostsCount,
        IsActive,
        CreatedDate,
        ModifiedDate
    FROM [group].[tbl_groups]
    WHERE GroupId = @GroupId 
        AND IsActive = 1;
END
GO

