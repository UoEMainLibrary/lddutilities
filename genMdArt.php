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

    //STEP 1 Connect To Database
    include 'config/vars.php';
    $error = '';
    $link = mysql_connect($dbserver, $username, $password);
    @mysql_select_db($database) or die( "Unable to select database");



    $select_sql = "select r.id, r.image_id, r.type, r.value_text, c.name as collection from orders.CROWD r, orders.COLLECTION c, orders.IMAGE i where r.image_id = i.image_id and i.collection = c.id and r.status = 'A'  and r.game = 'A' order by r.image_id;";
    $select_result = mysql_query($select_sql) or die( "A MySQL error has occurred.<br />Your Query: " . $select_sql . "<br /> Error: (" . mysql_errno() . ") " . mysql_error());
    $select_count = mysql_numrows($select_result);

    echo $select_sql;
    $outfile = "output/art_tags.xml";
    $stopwords = "input/artstopwords.csv";

    $file_handle_out = fopen($outfile, "w")or die("can't open outfile");

    fwrite($file_handle_out,"<recordset>\n");


    $p = 0;
    $collarray =array();
    $prev_id = 0;

    while ($p < $select_count)
    {

       // $type = mysql_result($select_result, $p, 'type');
        $value_text = mysql_result($select_result, $p, 'value_text');
        $image_id = ltrim(mysql_result($select_result, $p, 'image_id'),0);
        $image_id = substr($image_id,0,5);
        $id = mysql_result($select_result, $p, 'id');
        $delimiter = ',';
        $stopword = 0;
        $lineno = 0;
        //$file_handle_stop = fopen($stopwords, "r")or die("can't open infile");

        if (($file_handle_stop = fopen($stopwords, 'r')) !== FALSE)
        {
            while (($line = fgetcsv($file_handle_stop, 0, $delimiter)) !== FALSE)
            {
                $num = count($line);
                //echo "<p> $num fields in line $lineno: <br /></p>\n";
                $lineno++;
                for ($c=0; $c < $num; $c++) {
                    //echo $line[$c] . $value_text. "<br />\n";

                    if (strtoupper($line[$c]) == strtoupper($value_text)) {
                        echo 'STOPWORD!' . $line[$c];
                        $stopword = 1;
                        $c = $num;
                    }
                }
                //echo 'LINE'.$line[$lineno].'<br>';
            }
            fclose($file_handle_stop);
        }


        if ($stopword == 1) {
            echo 'STOP'.$value_text;
            $sql = "UPDATE orders.CROWD set status = 'S'  where id= '" . $id . "';";
            $result = mysql_query($sql) or die("A MySQL error has occurred.<br />Your Query: " . $sql . "<br /> Error: (" . mysql_errno() . ") " . mysql_error());
        }
        else
        {
            $vernon_sys_sql = "select system_id from orders.ART_VERNON where image_id =" . $image_id . ";";
            $vernon_sys_result = mysql_query($vernon_sys_sql) or die("A MySQL error has occurred.<br />Your Query: " . $vernon_sys_sql . "<br /> Error: (" . mysql_errno() . ") " . mysql_error());
            $vernon_sys_count = mysql_numrows($vernon_sys_result);
            $v = 0;
            while ($v < $vernon_sys_count) {
                $vernon_sys_id = mysql_result($vernon_sys_result, $v, 'system_id');
                $v++;
            }
            fwrite($file_handle_out,"<record>\n");
            fwrite($file_handle_out, '<id>' . $vernon_sys_id . "</id>\n");
            fwrite($file_handle_out, '<tag>' . ucname($value_text) . "</tag>\n");
            fwrite($file_handle_out, "</record>\n");

            $sql = "UPDATE orders.CROWD set status = 'C'  where id= '" . $id . "';";
            $result = mysql_query($sql) or die("A MySQL error has occurred.<br />Your Query: " . $sql . "<br /> Error: (" . mysql_errno() . ") " . mysql_error());

            /* $value = $collection;

             if (!in_array($value, $collarray))
             {
                 $collarray[] = $value;
             }
            */

            $prev_id = $image_id;

        }
        $p++;

    }
/*
    if ($keyword != '')
    {
        $keywordstring = $prev_id.','.'Keyword'.',"'.$keyword."\"\n";
        $keywordstring = str_replace(', "' ,'"', $keywordstring);
        fwrite($file_handle_out, $keywordstring);
        $keyword = '';
    }

    echo '<div class = "die"><p>METADATA IN FILE</p></div>';
    //construct and send e-mail to let the user know they're approved

    foreach ($collarray as $item )
    {
        $concatenated_message .= $item."\n";
    }


    $whoto = "scott.renton@ed.ac.uk";
    $email = "scott.renton@ed.ac.uk";
    $subject = "You have new metadata for these collections";

    mail( $email, $subject,$concatenated_message, "From: $whoto" );

*/

    fwrite($file_handle_out,"</recordset>\n");
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
