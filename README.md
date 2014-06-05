mysql-regexp
============

Regexp routines for mysql, implemented without UDF

_This functions have no guarantee and are NOT well-tested. Regex lookup is based on `REGEXP` operator for mysql, thus, all limitations (such as ci-collations) are applicable for them._

**Tests**

There is a tests framework, which is located in `/Tests` folder. Structure:
- `/Tests/Assert` : functions to check certain state
- `/Tests/Data`   : data for tests. Creation of data table & certain function tests
- `/Tests/Invoke` : procedures that should be called to run tests.

Tests are stored in `TEST_ASSERTIONS` table. It's structure is as follows:

- `id`            : test id, primary key
- `function_name` : name of function, to which the test belongs
- `expression`    : expression that should be tested
- `value`         : result of evaluation of expression to pass test

To create table & fill it, just run `.sql` from `/Tests/Data`. You may wish to add your own tests - so go ahead (in fact, I'm counting on that).
To run test, you should call the corresponding procedure. Each function has it's testing procedure, prefixed with `TEST_`. For instance, to test `REGEXP_REPLACE` function, following command would be enough: `CALL TEST_REGEXP_REPLACE;`
If all tests passed, then result will be empty set and success message, like:
<pre>
mysql> call test_regexp_replace;
Query OK, 0 rows affected, 1 warning (0.03 sec)
</pre>

If something went wrong, MySQL will return error with the corresponding message. Sample:
<pre>
mysql> call test_regexp_replace;
ERROR 1644 (42000): Test id < 19 >: assertion that ( REGEXP_REPLACE("foobarbaz", "[a-z]+", "") ) is "f", failed
</pre>
Testing procedure will stop after first failure and will not continue.

**Known issues**

- Impossible to use `^` or `$` in expressions. No multiline support.
- No support for negative/positive lookaheads/lookbehinds. 
- Anything else?

**Complexity/Use cases**

As it is, full string with length `n` reconstruction will cause O(n<sup>2</sup>) complexity. Yeas, that means, you'll have n<sup>2</sup> `REGEXP` calls. So before using this, think twice. However, valid use-case may be to define some variable with this `REGEXP_*` functions, then use it in query.

<br/>
<sub>If your intention is to use this functionality and it can not be moved from DBMS to application, then probably you're a badass :-)</sub>