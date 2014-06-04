mysql-regexp
============

Regexp routines for mysql, implemented without UDF

**Known issues**

- Troubles with single-letter delimiters. Because of greedy convention, left-substring delimiter for 'foo' with'[a-z]' will be treated as whole 'foo', not 'f' (so, incorrect)
- No support for negative/positive lookaheads/lookbehinds. 
- Anything else?
