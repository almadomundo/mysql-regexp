-- Replace by regex `p` for string `r` in input string `s`
-- Crappy because of greedy. It's a nutshell. Will be re-written

DELIMITER //
CREATE FUNCTION REGEXP_REPLACE(s VARCHAR(255), p VARCHAR(255),r VARCHAR(255))
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
   DECLARE j      VARCHAR(255) DEFAULT '!@#$%^&*)(*&^%$#@!';
   RETURN REPLACE(REGEXP_SPLIT(s, p, j, 0), j, r);
END//
DELIMITER ;