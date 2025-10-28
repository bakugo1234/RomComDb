CREATE PROCEDURE [friendship].[sp_Friendship_Unfollow]
    @UserId INT,
    @TargetUserId INT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Delete the friendship record
        DELETE FROM [friendship].[tbl_friendships]
        WHERE [UserId] = @UserId 
            AND [FriendId] = @TargetUserId
            AND [Status] = 'Accepted';
        
        -- Update follower counts
        UPDATE [user].[tbl_userProfiles]
        SET [FollowersCount] = [FollowersCount] - 1,
            [ModifiedDate] = GETUTCDATE()
        WHERE [UserId] = @TargetUserId;
        
        UPDATE [user].[tbl_userProfiles]
        SET [FollowingCount] = [FollowingCount] - 1,
            [ModifiedDate] = GETUTCDATE()
        WHERE [UserId] = @UserId;
        
        RETURN 1; -- Success
    END TRY
    BEGIN CATCH
        RETURN 0; -- Error
    END CATCH
END
GO
