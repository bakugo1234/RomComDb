CREATE PROCEDURE [notification].[sp_Notification_MarkAsRead]
    @NotificationId INT,
    @UserId INT,
    @ReadDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE [notification].[tbl_notifications]
    SET IsRead = 1,
        ReadDate = @ReadDate
    WHERE NotificationId = @NotificationId
        AND UserId = @UserId
        AND IsRead = 0;

    SELECT @@ROWCOUNT AS Result;
END
GO

