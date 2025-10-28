CREATE VIEW [feed].[vw_UserFeed]
AS
SELECT 
    p.PostId,
    p.UserId,
    p.Content,
    p.MediaType,
    p.LikesCount,
    p.CommentsCount,
    p.SharesCount,
    p.CreatedDate
FROM [post].[tbl_posts] p
WHERE p.IsActive = 1;
GO

