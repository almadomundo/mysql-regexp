-- Get the longest right-substring from input string,
-- which matches passed regex

DELIMITER //
CREATE FUNCTION GET_RIGHT_DELIMITER(s VARCHAR(255), p VARCHAR(255))
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
   DECLARE position INT DEFAULT 1;
   SET p = CONCAT('^(', p, ')$');

   WHILE position<=CHAR_LENGTH(s) && !(SUBSTR(s, position) REGEXP p) DO
      SET position = position + 1;
   END WHILE;
   RETURN SUBSTR(s, position);
END//
DELIMITER ;