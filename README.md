mysql-regexp
============

Regexp routines for mysql, implemented without UDF

_This functions have no guarantee and are NOT well-tested. Regex lookup is based on `REGEXP` operator for mysql, thus, all limitations (such as ci-collations) are applicable for them._

**Known issues**

- Impossible to use `^` or `$` in expressions. No multiline support.
- No support for negative/positive lookaheads/lookbehinds. 
- Anything else?
