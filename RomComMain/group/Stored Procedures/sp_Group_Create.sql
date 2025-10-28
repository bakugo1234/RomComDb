CREATE PROCEDURE [group].[sp_Group_Create]
    @GroupName NVARCHAR(100),
    @Description NVARCHAR(1000) = NULL,
    @GroupImage NVARCHAR(500) = NULL,
    @CoverImage NVARCHAR(500) = NULL,
    @CreatedBy INT,
    @IsPrivate BIT = 0,
    @CreatedDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO [group].[tbl_groups] (
            GroupName,
            Description,
            GroupImage,
            CoverImage,
            CreatedBy,
            IsPrivate,
            MembersCount,
            IsActive,
            CreatedDate
        )
        VALUES (
            @GroupName,
            @Description,
            @GroupImage,
            @CoverImage,
            @CreatedBy,
            @IsPrivate,
            1, -- Creator is first member
            1,
            @CreatedDate
        );

        DECLARE @NewGroupId INT = SCOPE_IDENTITY();

        -- Add creator as admin member
        INSERT INTO [group].[tbl_groupMembers] (GroupId, UserId, [Role], JoinedDate, IsActive)
        VALUES (@NewGroupId, @CreatedBy, 'Admin', @CreatedDate, 1);

        COMMIT TRANSACTION;

        SELECT @NewGroupId AS Result;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        THROW;
    END CATCH
END
GO

