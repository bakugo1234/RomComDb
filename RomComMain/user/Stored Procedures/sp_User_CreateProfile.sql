CREATE PROCEDURE [user].[sp_User_CreateProfile]
    @UserId INT,
    @CreatedDate DATETIMEOFFSET
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Check if profile already exists
        IF EXISTS (SELECT 1 FROM [user].[tbl_userProfiles] WHERE [UserId] = @UserId)
        BEGIN
            RETURN 0; -- Profile already exists
        END
        
        -- Create user profile
        INSERT INTO [user].[tbl_userProfiles] 
        ([UserId], [CreatedDate])
        VALUES 
        (@UserId, @CreatedDate);
        
        RETURN 1; -- Success
    END TRY
    BEGIN CATCH
        RETURN 0; -- Error
    END CATCH
END
GO
