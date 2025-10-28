CREATE PROCEDURE [app].[sp_App_GetCredentials]
    @ApplicationKey NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        c.CredentialId,
        c.ApplicationId,
        c.CredentialKey,
        c.CredentialValue,
        c.IsEncrypted
    FROM [app].[tbl_applicationCredentials] c
    INNER JOIN [app].[tbl_applications] a ON c.ApplicationId = a.ApplicationId
    WHERE a.ApplicationKey = @ApplicationKey
        AND a.IsActive = 1;
END
GO

