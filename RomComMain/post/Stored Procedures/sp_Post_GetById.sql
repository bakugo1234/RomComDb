CREATE PROCEDURE [post].[sp_Post_GetById]
    @PostId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        PostId,
        UserId,
        Content,
        MediaType,
        LikesCount,
        CommentsCount,
        SharesCount,
        IsActive,
        CreatedDate,
        ModifiedDate
    FROM [post].[tbl_posts]
    WHERE PostId = @PostId 
        AND IsActive = 1;

    -- Get post media
    SELECT 
        PostMediaId,
        PostId,
        MediaUrl,
        MediaType,
        ThumbnailUrl,
        DisplayOrder
    FROM [post].[tbl_postMedia]
    WHERE PostId = @PostId
    ORDER BY DisplayOrder;
END
GO

