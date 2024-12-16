SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE UpdateUserRole 
	@userId BIGINT,
	@role CHAR(3)
AS
BEGIN
	UPDATE Users
	SET role = @role
	WHERE id = @userId;

	INSERT INTO Logs([log]) VALUES (FORMAT(GETDATE(), 'yyyy-MM-dd HH:mm:ss') + N' - Role of user ' + STR(@userId) + N' was changed to ' + @role)
END
GO
