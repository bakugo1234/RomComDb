CREATE PROCEDURE [auth].[sp_Auth_GetUserById]
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        u.UserId as id,
        u.UserName as userName,
        u.Email as email,
        u.RoleId as roleId,
        r.RoleName as roleName,
        u.FirstName as firstName,
        u.LastName as lastName,
        u.ProfilePicture as profilePicture,
        u.LastLoginDate as lastLoginDate
    FROM [auth].[tbl_users] u
    LEFT JOIN [auth].[tbl_roles] r ON u.RoleId = r.RoleId
    WHERE u.UserId = @UserId 
        AND u.IsActive = 1;
END
GO

