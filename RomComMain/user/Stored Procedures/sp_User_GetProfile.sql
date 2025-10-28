CREATE PROCEDURE [user].[sp_User_GetProfile]
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        UserProfileId,
        UserId,
        Bio,
        DateOfBirth,
        Gender,
        Location,
        Website,
        CoverImage,
        IsPrivate,
        FollowersCount,
        FollowingCount,
        PostsCount,
        CreatedDate,
        ModifiedDate
    FROM [user].[tbl_userProfiles]
    WHERE UserId = @UserId;
END
GO

