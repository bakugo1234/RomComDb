CREATE PROCEDURE [post].[sp_Post_Like]
    @PostId INT,
    @UserId INT,
    @CreatedDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if already liked
    IF EXISTS (SELECT 1 FROM [post].[tbl_postLikes] WHERE PostId = @PostId AND UserId = @UserId)
    BEGIN
        SELECT -1 AS Result; -- Already liked
        RETURN;
    END

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO [post].[tbl_postLikes] (PostId, UserId, CreatedDate)
        VALUES (@PostId, @UserId, @CreatedDate);

        -- Update likes count
        UPDATE [post].[tbl_posts]
        SET LikesCount = LikesCount + 1
        WHERE PostId = @PostId;

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

