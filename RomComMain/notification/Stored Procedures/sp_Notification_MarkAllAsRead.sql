CREATE PROCEDURE [notification].[sp_Notification_MarkAllAsRead]
    @UserId INT,
    @ReadDate DATETIMEOFFSET
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Mark all notifications as read for the user
        UPDATE [notification].[tbl_notifications]
        SET [IsRead] = 1,
            [ReadDate] = @ReadDate
        WHERE [UserId] = @UserId
            AND [IsRead] = 0;
        
        RETURN 1; -- Success
    END TRY
    BEGIN CATCH
        RETURN 0; -- Error
    END CATCH
END
GO
