CREATE PROCEDURE [logger].[sp_Logger_InsertLog]
    @Level NVARCHAR(20),
    @Message NVARCHAR(MAX),
    @Exception NVARCHAR(MAX) = NULL,
    @StackTrace NVARCHAR(MAX) = NULL,
    @Source NVARCHAR(100) = NULL,
    @UserId INT = NULL,
    @IpAddress NVARCHAR(45) = NULL,
    @RequestPath NVARCHAR(500) = NULL,
    @CreatedDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [logger].[tbl_logs] (
        [Level],
        [Message],
        [Exception],
        [StackTrace],
        [Source],
        [UserId],
        [IpAddress],
        [RequestPath],
        [CreatedDate]
    )
    VALUES (
        @Level,
        @Message,
        @Exception,
        @StackTrace,
        @Source,
        @UserId,
        @IpAddress,
        @RequestPath,
        @CreatedDate
    );

    SELECT SCOPE_IDENTITY() AS Result;
END
GO

