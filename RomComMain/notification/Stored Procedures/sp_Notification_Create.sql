CREATE PROCEDURE [notification].[sp_Notification_Create]
    @UserId INT,
    @Type NVARCHAR(50),
    @Title NVARCHAR(200),
    @Content NVARCHAR(500) = NULL,
    @RelatedId INT = NULL,
    @RelatedType NVARCHAR(50) = NULL,
    @FromUserId INT = NULL,
    @CreatedDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [notification].[tbl_notifications] (
        UserId,
        [Type],
        Title,
        Content,
        RelatedId,
        RelatedType,
        FromUserId,
        IsRead,
        CreatedDate
    )
    VALUES (
        @UserId,
        @Type,
        @Title,
        @Content,
        @RelatedId,
        @RelatedType,
        @FromUserId,
        0,
        @CreatedDate
    );

    SELECT SCOPE_IDENTITY() AS Result;
END
GO

