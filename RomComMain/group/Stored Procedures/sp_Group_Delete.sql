CREATE PROCEDURE [group].[sp_Group_Delete]
    @GroupId INT,
    @UserId INT,
    @DeletedDate DATETIMEOFFSET
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Check if user is admin of the group
        IF NOT EXISTS (SELECT 1 FROM [group].[tbl_groups] WHERE [GroupId] = @GroupId AND [CreatedBy] = @UserId)
        BEGIN
            RETURN 0; -- Not authorized
        END
        
        -- Soft delete group
        UPDATE [group].[tbl_groups]
        SET [IsActive] = 0,
            [ModifiedDate] = @DeletedDate
        WHERE [GroupId] = @GroupId;
        
        RETURN 1; -- Success
    END TRY
    BEGIN CATCH
        RETURN 0; -- Error
    END CATCH
END
GO
