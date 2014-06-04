-- Split input string `s` with regex `p`
-- and return parts as a row set
-- If flag `d` is not 0, regex-delimiters would be included into result
-- This is not concurred-queris safe,
-- but concurred-connections-safe

DELIMITER //
CREATE PROCEDURE REGEXP_SPLIT(s VARCHAR(255), p VARCHAR(255), d TINYINT)
BEGIN
   DECLARE delim    VARCHAR(255) DEFAULT '';
   DECLARE chunk    VARCHAR(255) DEFAULT '';
   DROP TABLE If EXISTS REGEXP_SPLIT_TMP_ROWSET;
   CREATE TEMPORARY TABLE REGEXP_SPLIT_TMP_ROWSET (part VARCHAR(255));
   mainLoop: WHILE(CHAR_LENGTH(s)) DO
      SET delim = GET_LEFT_DELIMITER(s, p);
      IF d && CHAR_LENGTH(delim) THEN
         INSERT INTO REGEXP_SPLIT_TMP_ROWSET (part) VALUES (delim);
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
      INSERT INTO REGEXP_SPLIT_TMP_ROWSET (part) VALUES (chunk);
   END WHILE mainLoop;
   SELECT part FROM REGEXP_SPLIT_TMP_ROWSET;
   DROP TABLE IF EXISTS REGEXP_SPLIT_TMP_ROWSET;
END//
DELIMITER ;