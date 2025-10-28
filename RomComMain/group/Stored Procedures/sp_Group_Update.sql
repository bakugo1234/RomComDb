CREATE PROCEDURE [group].[sp_Group_Update]
    @GroupId INT,
    @UserId INT,
    @GroupName NVARCHAR(100),
    @Description NVARCHAR(1000),
    @GroupImage NVARCHAR(500),
    @CoverImage NVARCHAR(500),
    @IsPrivate BIT,
    @ModifiedDate DATETIMEOFFSET
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Check if user is admin of the group
        IF NOT EXISTS (SELECT 1 FROM [group].[tbl_groups] WHERE [GroupId] = @GroupId AND [CreatedBy] = @UserId)
        BEGIN
            RETURN 0; -- Not authorized
        END
        
        -- Update group
        UPDATE [group].[tbl_groups]
        SET [GroupName] = @GroupName,
            [Description] = @Description,
            [GroupImage] = @GroupImage,
            [CoverImage] = @CoverImage,
            [IsPrivate] = @IsPrivate,
            [ModifiedDate] = @ModifiedDate
        WHERE [GroupId] = @GroupId;
        
        RETURN 1; -- Success
    END TRY
    BEGIN CATCH
        RETURN 0; -- Error
    END CATCH
END
GO
