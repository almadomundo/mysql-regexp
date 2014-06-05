-- Assert that expression is true (or can be coerced to true)

DELIMITER //
CREATE FUNCTION ASSERT_TRUE(expr VARCHAR(255))
RETURNS INT
BEGIN
   IF !expr THEN
      SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Assertion that expression is <TRUE> failed';
   END IF;
   RETURN 1;
END//
DELIMITER ;