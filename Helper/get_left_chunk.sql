-- Get a chunk from the left of the string. 
-- Delimiter symbols must not be present there

DELIMITER //
CREATE FUNCTION GET_LEFT_CHUNK(s VARCHAR(255), p VARCHAR(255))
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
   DECLARE result   VARCHAR(255) DEFAULT '';
   DECLARE current  VARCHAR(255) DEFAULT '';
   DECLARE delim    VARCHAR(255) DEFAULT '';
   DECLARE position INT DEFAULT 1;
   WHILE position<=CHAR_LENGTH(s) && !(current REGEXP p) DO
      SET position = position + 1;
      SET current  = SUBSTR(s, 1, position);
   END WHILE;
   SET delim = GET_RIGHT_DELIMITER(current, p);
   RETURN SUBSTR(current, 1, CHAR_LENGTH(current)-CHAR_LENGTH(delim));
END//
DELIMITER ;