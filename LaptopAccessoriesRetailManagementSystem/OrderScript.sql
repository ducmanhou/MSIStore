CREATE PROCEDURE uspAddOrder
    @UserId BIGINT
AS
BEGIN
    INSERT INTO [msistoredb].[order] (
        UserId
    )
    VALUES (
        @UserId
    )
END

EXEC uspAddOrder @UserId = 5;