mysql-regexp
============

Regexp routines for mysql, implemented without UDF

_This functions have no guarantee and are NOT well-tested. Regex lookup is based on `REGEXP` operator for mysql, thus, all limitations (such as ci-collations) are applicable for them._

**Tests**

There is a `Tests` folder, which contains tests set for [`mysql-unit`](https://github.com/almadomundo/mysql-unit). Please, refer to it's [documentation](http://almadomundo.github.io/mysql-unit/) for more details.

**Known issues**

- Impossible to use `^` or `$` in expressions. No multiline support.
- No support for negative/positive lookaheads/lookbehinds. 
- Anything else?

**Complexity/Use cases**

As it is, full string with length `n` reconstruction will cause O(n<sup>2</sup>) complexity. Yeas, that means, you'll have n<sup>2</sup> `REGEXP` calls. So before using this, think twice. However, valid use-case may be to define some variable with this `REGEXP_*` functions, then use it in query.

<br/>
<sub>If your intention is to use this functionality and it can not be moved from DBMS to application, then probably you're a badass :-)</sub>