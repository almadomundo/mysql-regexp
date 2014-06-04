-- Split @string by regex @regex and return as row set, using single query

SELECT 
  part 
FROM
  (SELECT 
    @part  := SUBSTRING_INDEX(@split, @delim, 1) AS part, 
    @split := SUBSTR(@split, 1+CHAR_LENGTH(@delim)+CHAR_LENGTH(@part)) AS s  
  FROM 
    (SELECT 0 AS i UNION SELECT 1) AS n0 CROSS JOIN 
    (SELECT 0 AS i UNION SELECT 1) AS n1 CROSS JOIN 
    (SELECT 0 AS i UNION SELECT 1) AS n2 CROSS JOIN 
    (SELECT 0 AS i UNION SELECT 1) AS n3 CROSS JOIN 
    (SELECT 0 AS i UNION SELECT 1) AS n4 CROSS JOIN 
    (SELECT 
      @string := ?, 
      @regex  := ?, 
      @delim  := ?, 
      @split  := REGEXP_SPLIT(@string, @regex, @delim, 0)
    ) AS init
  ) AS parts 
WHERE part!='';