CREATE PROCEDURE [notification].[sp_Notification_GetByUser]
    @UserId INT,
    @PageNumber INT = 1,
    @PageSize INT = 50
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;

    SELECT 
        NotificationId,
        UserId,
        [Type],
        Title,
        Content,
        RelatedId,
        RelatedType,
        FromUserId,
        IsRead,
        ReadDate,
        CreatedDate
    FROM [notification].[tbl_notifications]
    WHERE UserId = @UserId
    ORDER BY CreatedDate DESC
    OFFSET @Offset ROWS
    FETCH NEXT @PageSize ROWS ONLY;

    -- Return total count and unread count
    SELECT 
        COUNT(*) AS TotalCount,
        SUM(CASE WHEN IsRead = 0 THEN 1 ELSE 0 END) AS UnreadCount
    FROM [notification].[tbl_notifications]
    WHERE UserId = @UserId;
END
GO

