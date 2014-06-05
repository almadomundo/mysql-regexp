<?php
//emulate mysql REGEXP:
function regexp($string, $pattern)
{
    return preg_match('/'.$pattern.'/i', $string);
}

function getLeftDelimiter($string, $pattern)
{
    $position = strlen($string)+1;
    while($position && !regexp(substr($string, 0, $position), '^('.$pattern.')$'))
    {
        $position = $position - 1;
    }
    return substr($string, 0, $position);
}

function getRightDelimiter($string, $pattern)
{
    $position = 0;
    while($position<strlen($string) && !regexp(substr($string, $position), '^('.$pattern.')$'))
    {
        $position = $position + 1;
    }
    return substr($string, $position);
}

function getLeftChunk($string, $pattern)
{
    if(getLeftDelimiter($string, $pattern))
    {
        return '';
    }
    $position = 0;
    while($position<strlen($string) && !regexp(substr($string, 0, $position), $pattern))
    {
        $position = $position + 1;
    }
    $position = $position - strlen(getRightDelimiter(substr($string, 0, $position), $pattern));
    return (string)substr($string, 0, $position);
}

function regexpSplit($string, $pattern)
{
    
    $result = [];
    if(getLeftDelimiter($string, $pattern))
    {
        $result[] = '';
    }
    while($string)
    {
        $delim  = getLeftDelimiter($string, $pattern);
        $string = substr($string, strlen($delim));
        $chunk  = getLeftChunk($string, $pattern);
        $string = substr($string, strlen($chunk));
        $result[] = $chunk;
    }
    return $result;
}


var_dump(
        regexpSplit($_SERVER['argv'][1], $_SERVER['argv'][2]),
        preg_split('/'.$_SERVER['argv'][2].'/i', $_SERVER['argv'][1])
);