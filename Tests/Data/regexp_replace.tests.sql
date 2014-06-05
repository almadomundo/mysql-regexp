-- Tests for REGEXP_REPLACE

DELETE FROM TEST_ASSERTIONS WHERE function_name='REGEXP_REPLACE';

INSERT INTO TEST_ASSERTIONS 
(`function_name`, `expression`, `value`)
VALUES
('REGEXP_REPLACE', 'REGEXP_REPLACE("foo", "o", "-")', 'f--'),
('REGEXP_REPLACE', 'REGEXP_REPLACE("foo1bar", "[a-z]+", "")', '1'),
('REGEXP_REPLACE', 'REGEXP_REPLACE("foobazbarfoo barbar feo", "foo|bar", "+")', '+baz++ ++ feo'),
('REGEXP_REPLACE', 'REGEXP_REPLACE("foo93baz bar18", "foo|[0-9]+", "-")', '--baz bar-'),
('REGEXP_REPLACE', 'REGEXP_REPLACE("foo933baz bar18", "foo|[0-8]", "-")', '-9--baz bar--'),
('REGEXP_REPLACE', 'REGEXP_REPLACE("foobarbaz", "[a-z]+", "")', '')
;