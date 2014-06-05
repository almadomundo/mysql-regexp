-- Base procedure for testing framework

DELIMITER //
CREATE PROCEDURE TEST_BY_ASSERT_TABLE(f VARCHAR(255), t VARCHAR(255))
BEGIN
   DECLARE done  INT DEFAULT FALSE;
   DECLARE e     VARCHAR(255) DEFAULT '';
   DECLARE v     VARCHAR(255) DEFAULT '';
   DECLARE a     INT DEFAULT 0;
   DECLARE c     INT DEFAULT 0;
   DECLARE i     INT DEFAULT 0;
   DECLARE tests CURSOR FOR 
     SELECT `id`, `expression`, `value` FROM TEST_ASSERTIONS WHERE IF(f, function_name=f, 1) && IF(t, id=t, 1);
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
   
   SELECT 
      COUNT(1) INTO c 
   FROM 
      TEST_ASSERTIONS 
   WHERE 
      IF(CHAR_LENGTH(f), function_name=f, 1) && IF(CHAR_LENGTH(t), id=t, 1);
   IF !c THEN
      SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Tests for specified function name or test number were not found';
   END IF;
   
   OPEN tests;
   read_loop: LOOP
      FETCH tests INTO i, e, v;
      IF done THEN
         LEAVE read_loop;
      END IF;
      SET @s = CONCAT('SELECT ', e, ' INTO @e');
      PREPARE eval FROM @s;
      EXECUTE eval;
      SET a = ASSERT(@e, v, CONCAT('Test id < ', i, ' >: assertion that ( ', e, ' ) is "', v, '", failed'));
   END LOOP;
   CLOSE tests;
END//
DELIMITER ;