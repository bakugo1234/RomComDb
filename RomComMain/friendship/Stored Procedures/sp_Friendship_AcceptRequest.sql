CREATE PROCEDURE [friendship].[sp_Friendship_AcceptRequest]
    @FriendshipId INT,
    @UserId INT,
    @AcceptedDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Accept only if the current user is the FriendId (receiver)
        UPDATE [friendship].[tbl_friendships]
        SET [Status] = 'Accepted',
            AcceptedDate = @AcceptedDate
        WHERE FriendshipId = @FriendshipId
            AND FriendId = @UserId
            AND [Status] = 'Pending';

        IF @@ROWCOUNT > 0
        BEGIN
            -- Update followers/following counts
            DECLARE @RequesterId INT;
            SELECT @RequesterId = UserId 
            FROM [friendship].[tbl_friendships]
            WHERE FriendshipId = @FriendshipId;

            UPDATE [user].[tbl_userProfiles]
            SET FollowingCount = FollowingCount + 1
            WHERE UserId = @RequesterId;

            UPDATE [user].[tbl_userProfiles]
            SET FollowersCount = FollowersCount + 1
            WHERE UserId = @UserId;

            COMMIT TRANSACTION;
            SELECT 1 AS Result;
        END
        ELSE
        BEGIN
            ROLLBACK TRANSACTION;
            SELECT 0 AS Result;
        END
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        THROW;
    END CATCH
END
GO

