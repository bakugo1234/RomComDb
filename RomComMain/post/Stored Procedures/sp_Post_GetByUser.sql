CREATE PROCEDURE [post].[sp_Post_GetByUser]
    @UserId INT,
    @PageNumber INT = 1,
    @PageSize INT = 20
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;

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
    WHERE UserId = @UserId 
        AND IsActive = 1
    ORDER BY CreatedDate DESC
    OFFSET @Offset ROWS
    FETCH NEXT @PageSize ROWS ONLY;

    -- Return total count
    SELECT COUNT(*) AS TotalCount
    FROM [post].[tbl_posts]
    WHERE UserId = @UserId 
        AND IsActive = 1;
END
GO

