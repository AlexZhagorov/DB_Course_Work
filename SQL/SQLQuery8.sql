EXEC UpdateUserRole @userId = 1, @role = 'STF'
SELECT * FROM Logs
WHERE id = 3

DELETE FROM Logs