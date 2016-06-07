<?php
/**
 * Created by JetBrains PhpStorm.
 * User: srenton1
 * Date: 25/03/2015
 * Time: 11:34
 * To change this template use File | Settings | File Templates.
 */


    include 'config/vars.php';
    $link = mysql_connect($dbserver, $username, $password);
    @mysql_select_db($database) or die( "Unable to select database".$database);

    $infile = 'input/convertcsv.json';

    $uun = 'tiltfactor';
    $game = 'D';

    $json_data = file_get_contents($infile);

//print_r($json_data);

    $data = json_decode($json_data, true);
//print_r($data);
$i = 0;

for ($row = 0; $row < 50000; $row++) {
    echo "<p><b>Row number $row</b></p>";
    echo "<ul>";
    //for ($col = 0; $col < 7; $col++) {
    $image_id = substr($data[$row]['ImageName'],0,7);
    $tagusecount = $data[$row]['TagUseCnt'];
    $tag=$data[$row]['Tag'];
    $tag = str_replace ( "'", "&#39;", $tag);
    $weightmin = $data[$row]['WeightMin'];
    $weightmax = $data[$row]['WeightMax'];
    $weightavg = $data[$row]['WeightAVG'];
    $weightsum = $data[$row]['WeightSum'];
    $status = "";
        echo "<li>".$image_id."</li>";
    echo "<li>".$tag."</li>";

    echo "</ul>";

    if (is_numeric($tag))
    {
        echo '<br>Rejecting '.$tag.'</br>';
        $status = 'R';
    }

    if (str_word_count($tag) > 3)
    {
        echo '<br>Rejecting '.$tag.'</br>';
        $status = 'R';
    }

    if ($tag ==  "PASSONTHISTURN" )
    {
        echo '<br>Rejecting '.$tag.'</br>';
        $status = 'R';
    }

    if ($status == "")
    {
        if ($tagusecount == "2" || $tagusecount == "3")
        {
            echo '<br>Moderating '.$tag.' with a count of '.$tagusecount.'</br>';
            $status = 'M';
        }

        if ($tagusecount > "3")
        {
            echo '<br>Approving '.$tag.' with a count of '.$tagusecount.'</br>';
            $status = 'A';
        }

        if ($tagusecount == "1")
        {
            echo '<br>Pending '.$tag.' with a count of '.$tagusecount.'</br>';
            $status = 'P';
        }
    }

    if ($image_id == "" )
    {
        $row = 50000;
    }
    else
    {
        $crowd_id = '';
        $select_sql = "select id from orders.CROWD where image_id = '$image_id' and value_text = '$tag';";
        $select_result = mysql_query($select_sql) or die("A MySQL error has occurred.<br />Your Query: " . $select_sql . "<br /> Error: (" . mysql_errno() . ") " . mysql_error());
        $count = mysql_num_rows($select_result);
        echo 'Count'.$count."<br>";

        if ($count == 0)
        {
            $insert_sql = "insert into orders.CROWD (image_id, value_text, uun, status, game ) values ('$image_id', '$tag', '$uun', '$status' , '$game');";
            $insert_result = mysql_query($insert_sql) or die("A MySQL error has occurred.<br />Your Query: " . $insert_sql . "<br /> Error: (" . mysql_errno() . ") " . mysql_error());
            echo 'Inserting:'.$image_id.' '.$tag."<br>";
        }
        else{
            echo 'Duplicate tag:'.$image_id.' '.$tag."<br>";
        }
    }
}


?>



