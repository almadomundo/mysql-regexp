-- Get the longest right-substring from input string,
-- which matches passed regex

DELIMITER //
CREATE FUNCTION GET_RIGHT_DELIMITER(s VARCHAR(255), p VARCHAR(255))
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
   DECLARE result   VARCHAR(255) DEFAULT '';
   DECLARE current  VARCHAR(255) DEFAULT '';
   DECLARE position INT DEFAULT 0;
   WHILE CHAR_LENGTH(s) DO
      SET current  = s;
      SET position = 1;
      WHILE position<=CHAR_LENGTH(s) && current REGEXP p DO
         SET position = position + 1;
         SET current  = SUBSTR(current, 2);
      END WHILE;
      SET current = SUBSTR(s, position - 1);
      IF current REGEXP CONCAT('^(', p, ')$') THEN
         SET result = CONCAT(current, result);
         SET s      = SUBSTR(s, 1, position - 2);
      ELSE
         RETURN result;
      END IF;
   END WHILE;
   RETURN '';
END//
DELIMITER ;