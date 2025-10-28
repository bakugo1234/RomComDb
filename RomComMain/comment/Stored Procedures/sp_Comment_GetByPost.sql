CREATE PROCEDURE [comment].[sp_Comment_GetByPost]
    @PostId INT,
    @PageNumber INT = 1,
    @PageSize INT = 50
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;

    SELECT 
        CommentId,
        PostId,
        UserId,
        Content,
        ParentCommentId,
        LikesCount,
        IsActive,
        CreatedDate,
        ModifiedDate
    FROM [comment].[tbl_comments]
    WHERE PostId = @PostId 
        AND IsActive = 1
    ORDER BY CreatedDate ASC
    OFFSET @Offset ROWS
    FETCH NEXT @PageSize ROWS ONLY;

    -- Return total count
    SELECT COUNT(*) AS TotalCount
    FROM [comment].[tbl_comments]
    WHERE PostId = @PostId 
        AND IsActive = 1;
END
GO

