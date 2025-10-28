CREATE PROCEDURE [message].[sp_Message_GetByThread]
    @ThreadId INT,
    @UserId INT,
    @PageNumber INT = 1,
    @PageSize INT = 50
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;

    -- Verify user is part of the thread
    IF NOT EXISTS (
        SELECT 1 FROM [message].[tbl_messageThreads]
        WHERE ThreadId = @ThreadId AND (User1Id = @UserId OR User2Id = @UserId)
    )
    BEGIN
        SELECT NULL AS MessageId; -- Unauthorized
        RETURN;
    END

    SELECT 
        MessageId,
        ThreadId,
        SenderId,
        Content,
        IsRead,
        ReadDate,
        CreatedDate
    FROM [message].[tbl_messages]
    WHERE ThreadId = @ThreadId
        AND IsActive = 1
    ORDER BY CreatedDate DESC
    OFFSET @Offset ROWS
    FETCH NEXT @PageSize ROWS ONLY;

    -- Return total count
    SELECT COUNT(*) AS TotalCount
    FROM [message].[tbl_messages]
    WHERE ThreadId = @ThreadId
        AND IsActive = 1;
END
GO

