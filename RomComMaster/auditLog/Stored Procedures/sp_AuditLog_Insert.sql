CREATE PROCEDURE [auditLog].[sp_AuditLog_Insert]
    @UserId INT = NULL,
    @Action NVARCHAR(100),
    @TableName NVARCHAR(100) = NULL,
    @RecordId INT = NULL,
    @OldValues NVARCHAR(MAX) = NULL,
    @NewValues NVARCHAR(MAX) = NULL,
    @AffectedChanges NVARCHAR(MAX) = NULL,
    @IpAddress NVARCHAR(45) = NULL,
    @CreatedDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [auditLog].[tbl_auditLogs] (
        UserId,
        [Action],
        TableName,
        RecordId,
        OldValues,
        NewValues,
        AffectedChanges,
        IpAddress,
        CreatedDate
    )
    VALUES (
        @UserId,
        @Action,
        @TableName,
        @RecordId,
        @OldValues,
        @NewValues,
        @AffectedChanges,
        @IpAddress,
        @CreatedDate
    );

    SELECT SCOPE_IDENTITY() AS Result;
END
GO

