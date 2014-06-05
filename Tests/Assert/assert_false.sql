-- Assert that expression is false (or can be coerced to false)

DELIMITER //
CREATE FUNCTION ASSERT_FALSE(expr VARCHAR(255))
RETURNS INT
BEGIN
   IF expr THEN
      SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Assertion that expression is <FALSE> failed';
   END IF;
   RETURN 1;
END//
DELIMITER ;