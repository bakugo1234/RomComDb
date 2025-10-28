CREATE PROCEDURE [post].[sp_Post_Create]
    @UserId INT,
    @Content NVARCHAR(MAX) = NULL,
    @MediaType NVARCHAR(50) = NULL,
    @MediaUrl NVARCHAR(500) = NULL,
    @GroupId INT = NULL,
    @CreatedDate DATETIMEOFFSET
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO [post].[tbl_posts] (
            UserId,
            Content,
            MediaType,
            GroupId,
            IsActive,
            CreatedDate
        )
        VALUES (
            @UserId,
            @Content,
            @MediaType,
            @GroupId,
            1,
            @CreatedDate
        );

        DECLARE @NewPostId INT = SCOPE_IDENTITY();

        -- Insert media if provided
        IF @MediaUrl IS NOT NULL AND @MediaType IS NOT NULL
        BEGIN
            INSERT INTO [post].[tbl_postMedia] (
                PostId,
                MediaUrl,
                MediaType,
                CreatedDate
            )
            VALUES (
                @NewPostId,
                @MediaUrl,
                @MediaType,
                @CreatedDate
            );
        END

        -- Update user's posts count
        UPDATE [user].[tbl_userProfiles]
        SET PostsCount = PostsCount + 1,
            ModifiedDate = @CreatedDate
        WHERE UserId = @UserId;

        -- Update group posts count if it's a group post
        IF @GroupId IS NOT NULL
        BEGIN
            UPDATE [group].[tbl_groups]
            SET PostsCount = PostsCount + 1,
                ModifiedDate = @CreatedDate
            WHERE GroupId = @GroupId;
        END

        COMMIT TRANSACTION;

        SELECT @NewPostId AS Result;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        THROW;
    END CATCH
END
GO

