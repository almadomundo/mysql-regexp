-- Split input string `s` with regex `p`
-- and return parts, joined with delimiter `j`
-- If input string `s` contains delimiter `j`, error will occur
-- If flag `d` is not 0, regex-delimiters would be included into result

DELIMITER //
CREATE FUNCTION REGEXP_SPLIT(s VARCHAR(255), p VARCHAR(255),j VARCHAR(255), d TINYINT)
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
   DECLARE delim    VARCHAR(255) DEFAULT '';
   DECLARE chunk    VARCHAR(255) DEFAULT '';
   DECLARE result   VARCHAR(255) DEFAULT '';
   IF LOCATE(j, s) THEN
      SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Input string must not contain joining delimiter';
   END IF;
   mainLoop: WHILE(CHAR_LENGTH(s)) DO
      SET delim = GET_LEFT_DELIMITER(s, p);
      IF d && CHAR_LENGTH(delim) THEN
         SET result = CONCAT(result, j, delim);
      END IF;
      IF s = delim THEN
         LEAVE mainLoop;
      END IF;
      SET s     = SUBSTR(s, 1 + CHAR_LENGTH(delim));
      SET chunk = GET_LEFT_CHUNK(s, p);
      IF(!CHAR_LENGTH(chunk)) THEN
         LEAVE mainLoop;
      END IF;
      SET s     = SUBSTR(s, 1 + CHAR_LENGTH(chunk));
      SET result = CONCAT(result, j, chunk);
   END WHILE mainLoop;
   RETURN SUBSTR(result, 1 + CHAR_LENGTH(j));
END//
DELIMITER ;