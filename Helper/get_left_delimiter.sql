-- Get the longest left-substring from input string,
-- which matches passed regex

DELIMITER //
CREATE FUNCTION GET_LEFT_DELIMITER(s VARCHAR(255), p VARCHAR(255))
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
   DECLARE position INT DEFAULT 0;
   SET position = CHAR_LENGTH(s);
   SET p        = CONCAT('^(', p, ')$');

   WHILE position && !(SUBSTR(s, 1, position) REGEXP p) DO
      SET position = position - 1;
   END WHILE;
   RETURN SUBSTR(s, 1, position);
END//
DELIMITER ;