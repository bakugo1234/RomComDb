CREATE PROCEDURE [message].[sp_Message_Send]
    @SenderId INT,
    @ReceiverId INT,
    @Content NVARCHAR(MAX),
    @CreatedDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ThreadId INT;
    DECLARE @User1Id INT = CASE WHEN @SenderId < @ReceiverId THEN @SenderId ELSE @ReceiverId END;
    DECLARE @User2Id INT = CASE WHEN @SenderId < @ReceiverId THEN @ReceiverId ELSE @SenderId END;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Get or create thread
        SELECT @ThreadId = ThreadId
        FROM [message].[tbl_messageThreads]
        WHERE User1Id = @User1Id AND User2Id = @User2Id;

        IF @ThreadId IS NULL
        BEGIN
            INSERT INTO [message].[tbl_messageThreads] (User1Id, User2Id, LastMessageDate, CreatedDate)
            VALUES (@User1Id, @User2Id, @CreatedDate, @CreatedDate);

            SET @ThreadId = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            -- Update last message date
            UPDATE [message].[tbl_messageThreads]
            SET LastMessageDate = @CreatedDate
            WHERE ThreadId = @ThreadId;
        END

        -- Insert message
        INSERT INTO [message].[tbl_messages] (ThreadId, SenderId, Content, IsRead, CreatedDate)
        VALUES (@ThreadId, @SenderId, @Content, 0, @CreatedDate);

        DECLARE @NewMessageId INT = SCOPE_IDENTITY();

        COMMIT TRANSACTION;

        SELECT @NewMessageId AS Result;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        THROW;
    END CATCH
END
GO

