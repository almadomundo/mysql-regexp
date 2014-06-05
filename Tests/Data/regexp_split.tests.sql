-- Tests for REGEXP_SPLIT

DELETE FROM TEST_ASSERTIONS WHERE function_name='REGEXP_SPLIT';

INSERT INTO TEST_ASSERTIONS 
(`function_name`, `expression`, `value`)
VALUES
('REGEXP_SPLIT', 'REGEXP_SPLIT("foo", "o", ",", 0)', 'f,,'),
('REGEXP_SPLIT', 'REGEXP_SPLIT("foo1bar", "[a-z]+", ",", 0)', ',1,')
;