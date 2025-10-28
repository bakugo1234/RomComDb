CREATE PROCEDURE [user].[sp_User_UpdateProfile]
    @UserId INT,
    @Bio NVARCHAR(500) = NULL,
    @DateOfBirth DATE = NULL,
    @Gender NVARCHAR(20) = NULL,
    @Location NVARCHAR(200) = NULL,
    @Website NVARCHAR(500) = NULL,
    @CoverImage NVARCHAR(500) = NULL,
    @IsPrivate BIT = NULL,
    @ModifiedDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    -- Create profile if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM [user].[tbl_userProfiles] WHERE UserId = @UserId)
    BEGIN
        INSERT INTO [user].[tbl_userProfiles] (
            UserId, Bio, DateOfBirth, Gender, Location, Website, CoverImage, IsPrivate, CreatedDate
        )
        VALUES (
            @UserId, @Bio, @DateOfBirth, @Gender, @Location, @Website, @CoverImage, ISNULL(@IsPrivate, 0), @ModifiedDate
        );
    END
    ELSE
    BEGIN
        UPDATE [user].[tbl_userProfiles]
        SET 
            Bio = ISNULL(@Bio, Bio),
            DateOfBirth = ISNULL(@DateOfBirth, DateOfBirth),
            Gender = ISNULL(@Gender, Gender),
            Location = ISNULL(@Location, Location),
            Website = ISNULL(@Website, Website),
            CoverImage = ISNULL(@CoverImage, CoverImage),
            IsPrivate = ISNULL(@IsPrivate, IsPrivate),
            ModifiedDate = @ModifiedDate
        WHERE UserId = @UserId;
    END

    SELECT @@ROWCOUNT AS Result;
END
GO

