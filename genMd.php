<!DOCTYPE html>
<html lang="en">
<head>
    <TITLE>DIU Photography Ordering System</TITLE>
    <link rel="stylesheet" type ="text/css" href="diustyles.css">
    <meta name="author" content="Library Online Editor">
    <meta name="description" content="Edinburgh University Library Online: Book purchase request forms for staff: Medicine and Veterinary">
    <meta name="distribution" content="global">
    <meta name="resource-type" content="document">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</HEAD>
<BODY>
<div class = "central">
    <div class = "heading">
        <a href="index.html" title="Link to The DIU Web Area">
            <img src="images/header4.jpg" alt="The University of Edinburgh Image Collections" width="754" height="65" border="0" />
        </a>
        <h2>METADATA UPDATED</h2>
        <hr/>
    </div>
    <?php

    include 'config/vars.php';
    $error = '';
    $link = mysql_connect($dbserver, $username, $password);
    @mysql_select_db($database) or die( "Unable to select database");


    $select_sql = "select r.id, r.image_id, r.value_text, i.collection, r.game from orders.CROWD r, orders.COLLECTION c, orders.IMAGE i where r.image_id = i.image_id and i.collection = c.id and r.status in ('A', 'C') and r.game  in ('D', 'A', 'R') order by r.image_id;";
    $select_result = mysql_query($select_sql) or die( "A MySQL error has occurred.<br />Your Query: " . $select_sql . "<br /> Error: (" . mysql_errno() . ") " . mysql_error());
    $select_count = mysql_numrows($select_result);
    $outfile = "input/tagfile.txt";
    $file_handle_out = fopen($outfile, "w")or die("can't open outfile");
    $p = 0;
    $collarray =array();
    $prev_id = 0;

    while ($p < $select_count)
    {
        $value_text = mysql_result($select_result, $p, 'value_text');
        $game = mysql_result($select_result, $p, 'game');
        $image_id = mysql_result($select_result, $p, 'image_id');
        $collection = mysql_result($select_result, $p, 'collection');
        $id = mysql_result($select_result, $p, 'id');


        $image_id =(substr($image_id, 0,7));
        $value_text = (ucname($value_text));
        fwrite($file_handle_out, $image_id.';'.$value_text. ';'.$collection.";\n");


        $sql = "UPDATE orders.CROWD set status = 'L'  where id= '".$id."';";
        $result=mysql_query($sql) or die( "A MySQL error has occurred.<br />Your Query: " . $sql . "<br /> Error: (" . mysql_errno() . ") " . mysql_error());

        $p++;

    }

    function ucname($string) {
        $string =ucwords(strtolower($string));

        foreach (array('-', '\'') as $delimiter) {
            if (strpos($string, $delimiter)!==false) {
                $string =implode($delimiter, array_map('ucfirst', explode($delimiter, $string)));
            }
        }
        return $string;
    }
    ?>


    <div class = "footer">
        <hr/>
        <p><a href="moderate.php">Back To Moderation Area</a></p>
        <p><a href="members.php">Back To Members' Area</a></p>
    </div>
</div>
</body>
</html>
