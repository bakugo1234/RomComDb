CREATE PROCEDURE [post].[sp_Post_Unlike]
    @PostId INT,
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        DELETE FROM [post].[tbl_postLikes]
        WHERE PostId = @PostId AND UserId = @UserId;

        DECLARE @RowsAffected INT = @@ROWCOUNT;

        IF @RowsAffected > 0
        BEGIN
            -- Update likes count
            UPDATE [post].[tbl_posts]
            SET LikesCount = LikesCount - 1
            WHERE PostId = @PostId
                AND LikesCount > 0;
        END

        COMMIT TRANSACTION;

        SELECT @RowsAffected AS Result;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        THROW;
    END CATCH
END
GO

