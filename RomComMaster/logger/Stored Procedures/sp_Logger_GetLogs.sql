CREATE PROCEDURE [logger].[sp_Logger_GetLogs]
    @Level NVARCHAR(20) = NULL,
    @UserId INT = NULL,
    @StartDate DATETIME = NULL,
    @EndDate DATETIME = NULL,
    @PageNumber INT = 1,
    @PageSize INT = 50
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;

    SELECT 
        LogId,
        [Level],
        [Message],
        [Exception],
        [StackTrace],
        [Source],
        UserId,
        IpAddress,
        RequestPath,
        CreatedDate
    FROM [logger].[tbl_logs]
    WHERE 
        (@Level IS NULL OR [Level] = @Level)
        AND (@UserId IS NULL OR UserId = @UserId)
        AND (@StartDate IS NULL OR CreatedDate >= @StartDate)
        AND (@EndDate IS NULL OR CreatedDate <= @EndDate)
    ORDER BY CreatedDate DESC
    OFFSET @Offset ROWS
    FETCH NEXT @PageSize ROWS ONLY;

    -- Return total count
    SELECT COUNT(*) AS TotalCount
    FROM [logger].[tbl_logs]
    WHERE 
        (@Level IS NULL OR [Level] = @Level)
        AND (@UserId IS NULL OR UserId = @UserId)
        AND (@StartDate IS NULL OR CreatedDate >= @StartDate)
        AND (@EndDate IS NULL OR CreatedDate <= @EndDate);
END
GO

