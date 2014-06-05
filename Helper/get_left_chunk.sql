-- Get a chunk from the left of the string. 
-- Delimiter symbols must not be present there

DELIMITER //
CREATE FUNCTION GET_LEFT_CHUNK(s VARCHAR(255), p VARCHAR(255))
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
   DECLARE position INT DEFAULT 1;

   IF CHAR_LENGTH(GET_LEFT_DELIMITER(s, p)) THEN
      RETURN '';
   END IF;
   WHILE position<=CHAR_LENGTH(s) && !(SUBSTR(s, 1, position) REGEXP p) DO
      SET position = position + 1;
   END WHILE;
   SET position = position - CHAR_LENGTH(GET_RIGHT_DELIMITER(SUBSTR(s, 1, position), p));
   RETURN SUBSTR(s, 1, position);
END//
DELIMITER ;