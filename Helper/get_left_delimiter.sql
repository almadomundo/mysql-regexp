-- Get the longest left-substring from input string,
-- which matches passed regex

DELIMITER //
CREATE FUNCTION GET_LEFT_DELIMITER(s VARCHAR(255), p VARCHAR(255))
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
   DECLARE current  VARCHAR(255) DEFAULT '';
   DECLARE position INT DEFAULT 0;

   SET current  = s;
   SET position = CHAR_LENGTH(s);
   WHILE position && current REGEXP p DO
      SET position = position - 1;
      SET current  = SUBSTR(current, 1, CHAR_LENGTH(current)-1);
   END WHILE;
   SET current  = SUBSTR(s, 1, position + 1);
   IF current REGEXP CONCAT('^(', p, ')$') THEN
      RETURN current;
   END IF;
   RETURN '';
END//
DELIMITER ;