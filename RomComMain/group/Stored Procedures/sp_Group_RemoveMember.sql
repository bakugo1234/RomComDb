CREATE PROCEDURE [group].[sp_Group_RemoveMember]
    @GroupId INT,
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Remove member from group
        DELETE FROM [group].[tbl_groupMembers]
        WHERE [GroupId] = @GroupId AND [UserId] = @UserId;
        
        -- Update member count
        UPDATE [group].[tbl_groups]
        SET [MembersCount] = [MembersCount] - 1,
            [ModifiedDate] = GETUTCDATE()
        WHERE [GroupId] = @GroupId;
        
        RETURN 1; -- Success
    END TRY
    BEGIN CATCH
        RETURN 0; -- Error
    END CATCH
END
GO
