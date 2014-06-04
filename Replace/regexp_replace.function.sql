-- Replace by regex `p` for string `r` in input string `s`
-- May fail, if `s` contains exactly '!@#$%^&*)(*&^%$#@!'
-- But then don't blame me

DELIMITER //
CREATE FUNCTION REGEXP_REPLACE(s VARCHAR(255), p VARCHAR(255),r VARCHAR(255))
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
   DECLARE j VARCHAR(255) DEFAULT '!@#$%^&*)(*&^%$#@!';
   RETURN REPLACE(REGEXP_SPLIT(s, p, j, 0), j, '');
END//
DELIMITER ;