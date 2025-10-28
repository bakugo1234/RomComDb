CREATE PROCEDURE [auditLog].[sp_AuditLog_GetByUser]
    @UserId INT,
    @StartDate DATETIME = NULL,
    @EndDate DATETIME = NULL,
    @PageNumber INT = 1,
    @PageSize INT = 50
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;

    SELECT 
        AuditLogId,
        UserId,
        [Action],
        TableName,
        RecordId,
        OldValues,
        NewValues,
        AffectedChanges,
        IpAddress,
        CreatedDate
    FROM [auditLog].[tbl_auditLogs]
    WHERE 
        UserId = @UserId
        AND (@StartDate IS NULL OR CreatedDate >= @StartDate)
        AND (@EndDate IS NULL OR CreatedDate <= @EndDate)
    ORDER BY CreatedDate DESC
    OFFSET @Offset ROWS
    FETCH NEXT @PageSize ROWS ONLY;

    -- Return total count
    SELECT COUNT(*) AS TotalCount
    FROM [auditLog].[tbl_auditLogs]
    WHERE 
        UserId = @UserId
        AND (@StartDate IS NULL OR CreatedDate >= @StartDate)
        AND (@EndDate IS NULL OR CreatedDate <= @EndDate);
END
GO

