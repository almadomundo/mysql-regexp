DELETE FROM TEST_FUNCTION_ASSERTIONS WHERE function_name='REGEXP_REPLACE';

INSERT INTO TEST_FUNCTION_ASSERTIONS 
(`function_name`, `expression`, `value`, `is_error`, `error_code`)
VALUES
('REGEXP_REPLACE', 'REGEXP_REPLACE("foo", "o", "-")', 'f--', 0, NULL),
('REGEXP_REPLACE', 'REGEXP_REPLACE("foo1bar", "[a-z]+", "")', '1', 0, NULL),
('REGEXP_REPLACE', 'REGEXP_REPLACE("foobazbarfoo barbar feo", "foo|bar", "+")', '+baz++ ++ feo', 0, NULL),
('REGEXP_REPLACE', 'REGEXP_REPLACE("foo93baz bar18", "foo|[0-9]+", "-")', '--baz bar-', 0, NULL),
('REGEXP_REPLACE', 'REGEXP_REPLACE("foo933baz bar18", "foo|[0-8]", "-")', '-9--baz bar--', 0, NULL),
('REGEXP_REPLACE', 'REGEXP_REPLACE("foobarbaz", "[a-z]+", "")', '', 0, NULL),
('REGEXP_REPLACE', 'REGEXP_REPLACE("foobarbaz", "[a-z]+")', '?', 0, '1310')
;