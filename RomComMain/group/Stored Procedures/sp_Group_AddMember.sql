CREATE PROCEDURE [group].[sp_Group_AddMember]
    @GroupId INT,
    @UserId INT,
    @Role NVARCHAR(20) = 'Member',
    @JoinedDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if already a member
    IF EXISTS (
        SELECT 1 FROM [group].[tbl_groupMembers]
        WHERE GroupId = @GroupId AND UserId = @UserId AND IsActive = 1
    )
    BEGIN
        SELECT -1 AS Result; -- Already a member
        RETURN;
    END

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO [group].[tbl_groupMembers] (GroupId, UserId, [Role], JoinedDate, IsActive)
        VALUES (@GroupId, @UserId, @Role, @JoinedDate, 1);

        -- Update group's members count
        UPDATE [group].[tbl_groups]
        SET MembersCount = MembersCount + 1
        WHERE GroupId = @GroupId;

        COMMIT TRANSACTION;

        SELECT 1 AS Result;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        THROW;
    END CATCH
END
GO

