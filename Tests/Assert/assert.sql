-- Basic tests assertion

DELIMITER //
CREATE FUNCTION ASSERT(expr VARCHAR(255), val VARCHAR(255), msg VARCHAR(255))
RETURNS INT
BEGIN
   DECLARE m VARCHAR(255) DEFAULT '';
   IF expr!=val THEN
      SET m = CONCAT('Assertion, that: "',expr,'" is "',val,'", failed');
      IF(CHAR_LENGTH(msg)) THEN
         SET m = msg;
      END IF;
      SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = m;
   END IF;
   RETURN 1;
END//
DELIMITER ;
