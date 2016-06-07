<html>
<head></head>
<body>
<?php
/**
 * Created by PhpStorm.
 * User: srenton1
 * Date: 05/11/15
 * Time: 11:11
 */

$videodir =  base_url().'videos/';
$mp4_filename = "0032275v.mp4";
$mp4_uri = $videodir.$mp4_filename;
$webm_filename = "0032275v.webm";
$webm_uri = $videodir.$webm_filename;
$mp3_filename = "0035715s.mp3";
$mp3_uri = $videodir.$mp3_filename;
$b_seq = 0;
$ga_code = "UA-TEST";

$record_title = "TEST";
$videoFile = false;
$videoLink = null;
$audioLink = null;
 echo 'directory'.getcwd() ;

    echo $_SERVER['HTTP_USER_AGENT'];
    // if it's chrome, use webm if it exists
    if (strpos($_SERVER['HTTP_USER_AGENT'], 'Chrome') == false) {
        echo $mp4_filename;
        $videoLink .= '<div class="flowplayer" data-analytics="' . $ga_code . '" title="' . $record_title . ": " . $mp4_filename . '">';
        $videoLink .= '<video id="video-' . $b_seq . '" title="' . $record_title . ": " . $mp4_filename . '" ';
        $videoLink .= 'controls preload="true" width="848">';
        $videoLink .= '<source src="' . $mp4_uri . '" type="video/mp4" />Video loading...';
        $videoLink .= '</video>';
        $videoLink .= '</div>';

        $videoFile = true;

    }
    else
    {
        echo $webm_filename;
        $videoLink .= '<div class="flowplayer" data-analytics="' . $ga_code . '" title="' . $record_title . ": " . $webm_filename . '">';
        $videoLink .= '<video id="video-' . $b_seq . '" title="' . $record_title . ": " . $webm_filename . '" ';
        $videoLink .= 'controls preload="none" width="848">';
        $videoLink .= '<source src="' . $webm_uri . '" type="video/webm" />Video loading...';
        $videoLink .= '</video>';
        $videoLink .= '</div>';

        $videoFile = true;

    }

    $audioLink .= '<audio id="audio-' . $b_seq;
    $audioLink .= '" title="' . $record_title . ": " . $mp3_filename . '" ';
    $audioLink .= 'controls preload="true" width="600">';
    $audioLink .= '<source src="' . $mp3_uri . '" type="audio/mpeg" />Audio loading...';
    $audioLink .= '</audio>';
    $audioFile = true;


if ($videoFile == true)
{
    echo $videoLink;
}

if ($audioFile == true)
{
    echo $audioLink;
}


?>
</body>
</html>