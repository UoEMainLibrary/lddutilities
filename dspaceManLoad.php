<?php
/**
 * Created by PhpStorm.
 * User: srenton1
 * Date: 12/02/2018
 * Time: 09:20
 */
session_start();
//var_dump($_SESSION);
include '../../games/config/vars.php';
// connect to db
$error = '';
echo $dbserver. $username. $password. $database;
$link = new mysqli($dbserver, $username, $password, $database);
//@mysqli_select_db($database) ;#or die( "Unable to select database".$database);

?>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

<head>
    <meta name="viewport" content="user-scalable=no" />
    <title>Special Collections UV Manifest Work</title>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

    <!-- Latest compiled and minified JavaScript -->
    <link href='http://fonts.googleapis.com/css?family="Comic Sans MS"' rel='stylesheet' type='text/css'>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <?php

    echo $_SESSION['stylesheet'];

    ?>
    <meta name="author" content="Library Digital Development" />
    <meta name="description" content=
    "Edinburgh University Library Crowd Sourcing" />
    <meta name="distribution" content="global" />
    <meta name="resource-type" content="document" />
    <meta http-equiv="Content-Type" content="text/html; charset=us-ascii" />
    <style>
        html {
            font-size: 20px;
        }
        * {
            font-family: Arial;
            background-color: #ffffff;
            border-color: #ffffff;
        }
        h2 {
            margin-left: 20px;
            margin-right: 20px;
        }
        h3 {
            margin-left: 20px;
            margin-right: 20px;
        }
        .menutext {
            color: white;
        }
        p{
            margin-left: 20px;
        }
        a{
            margin-left: 20px;
        }
        h1 {
            font-size: 100px;
            font-weight: bold;
            letter-spacing: normal;
            display: block;
        }
        span {
            letter-spacing: normal;

        }
        .uvlogo
        { margin-left:25px; display: inline-block; width: 50px; height: 50px;  background: url(../../images/uv.png) no-repeat 0px 0px;}
        a:hover {
            text-decoration: none;
        }
        .heading {
            margin-bottom: 30px;
            max-height: 700px;
        }
        .heading-first {
            margin-bottom: 50px;
        }
        body {
            background-color: #ffffff;
        }
        div.container-fluid div.all {
            font-family: Arial;
        }
        div.central {
            background-color: #ffffff;
        }
        h1, h2, textarea, input, h3, span{
            background-color:#ffffff;
        }
        textarea, input
        {border-width: 1px;
            border-color: #333329;
            margin-left : 25px;}

        td{
            padding:3px;
            vertical-align: middle;
        }
        .lightheading{
            width:220px;
            height:220px;
        }
        img{
            vertical-align:middle;
            text-align:center;
        }
        /* iPhone 6 in portrait  */
        @media only screen
        and (min-device-width : 375px)
        and (max-device-width : 667px)
        and (orientation : portrait) {
            html {
                padding-right: 1em;
                padding-left: 1em;
            }
            h2 {
                font-weight: bold;
                font-size: 2rem;
            }
            .menutext {
                font-size: 1.5rem;
            }
            input.btn {
                width: 30rem;
                height: 5rem;
                font-size: 3em;
            }
            input.form-control.form-inline {
                margin-bottom: 2rem;
                height: 4rem;
                font-size: 3em;
            }
            td.menu {
                box-sizing: border-box;
                padding-left: 2rem;
                padding-right: 2rem;
            }
            a {
                font-size: 1.3rem;
            }
            #footer a{
                color: ;
                font-size: 1.3rem;
                padding-bottom: 2rem;
            }
            #footer div.uoe-logo img{
                float: left;
                width: 5rem;
            }
            #footer div.luc-logo img{
                float: right;
                width: 4rem;
            }
        }

    </style>
</head>

<body>
<?php include_once("./../analyticstracking.php")?>


<div class="all container-fluid">
    <h1>IIIF Manifest Builder BETA</h1>


    <?php

    ini_set('max_execution_time', 10000);

    $docbase = '/home/lib/lacddt/librarylabs/iiif/speccollprototype';
    $dublincorefile = 'dublin_core.xml';
    $contentsfile = 'contents';
    $collection = 'speccoll/';
    $logfile = $docbase.'/files/image_output.txt';
    $update_file =  $docbase.'/files/'.$collection.'mapfile.txt';
    echo "<p> Using update file: ".$update_file.'</p>';

    $file_handle_log_out = fopen($logfile, "a+")or die("<p>Sorry. I can't open the logfile.</p>");
    $directory = $docbase.'/files/'.$collection.'dspaceNew/';
    echo "<p> Using output directory (new items): ".$directory.'<br>';
    //mkdir($directory);
    $update_directory = $docbase.'/files/'.$collection.'dspaceExisting/';
    echo "<p> Using output directory (existing items): ". $update_directory.'<br>';
    //mkdir($update_directory);

    $shelfsql = "select distinct(shelfmark) from orders.IMAGE where not shelfmark like '%Corson%' and not shelfmark like 'EU%' and jpeg_path like 'http%';";
    $shelfresult = mysqli_query($link, $shelfsql);

    $rec_count = mysqli_num_rows($shelfresult);
    $i = 0;
    print_r('COUNT'.$rec_count);
    while ($row = $shelfresult->fetch_assoc())
    {
        $shelf[$i] = $row['shelfmark'];
        echo "Working on: ". $shelf[$i]. "\n";

        $options="";
        $manifest_file = '';
        $manifestarray = [];

        $manifestshelf = str_replace(" ","-",$shelf[$i]);
        $manifestshelf = str_replace("*","-",$manifestshelf);
        $manifestshelf = str_replace("/","-",$manifestshelf);
        $manifestshelf = str_replace(".","-",$manifestshelf);

        $foldername = $manifestshelf;
        $file_handle_upd_in = fopen($update_file, "r")or die("<p>Sorry. I can't open upfile.</p>");
        fwrite($file_handle_upd_in, 'Upload file '.$update_file."\n");
        $update = false;
        while (!feof($file_handle_upd_in))
        {
            $line = fgets($file_handle_upd_in);
            $found = strpos($line,$foldername);
            if ($found !== false)
            {
                $update = true;
            }
        }

        if ($update == true)
        {
            $subfolder = $update_directory.$foldername;
        }
        else
        {
            $subfolder = $directory.$foldername;
        }
        if (!(file_exists($subfolder))) {
            mkdir($subfolder);
            chmod($subfolder, 0777);
        }
        $file_handle_dc_out = fopen($subfolder.'/'.$dublincorefile, "w")or die("<p>Sorry. I can't open dc outfile.</p>");
        $file_handle_contents_out = fopen($subfolder.'/'.$contentsfile, "w")or die("<p>Sorry. I can't open contents outfile.</p>");
        fwrite($file_handle_dc_out,"<?xml version=\"1.0\" encoding=\"UTF-8\"?> \n");
        fwrite($file_handle_dc_out,"<dublin_core>\n");
        $outline = '<dcvalue element = "identifier" qualifier = "">'.$shelf[$i]."</dcvalue>\n";
        fwrite($file_handle_dc_out,$outline);
        $dotpos = '';
        $dotpos = strpos($foldername, "-");
        $dc_type = substr($shelf[$i], 0, $dotpos);
        $outline = '<dcvalue element = "type" qualifier = "">'.$dc_type."</dcvalue>\n";
        fwrite($file_handle_dc_out,$outline);

        $j = 0;

        $imagesql = "select jpeg_path from IMAGE where shelfmark ='" . $shelf[$i] . "';";
        $imageresult = mysqli_query($link, $imagesql);
        while ($row = $imageresult->fetch_assoc())
        {
            $outpath = $row['jpeg_path'];

            $manifest = str_replace('detail', 'iiif/m', $outpath).'/manifest';
            $manifestlist[$j] = $manifest;

            $json = file_get_contents($manifestlist[$j]);
            $jobj = json_decode($json, true);
            $error = json_last_error();

            if ($j == 0)
            {

                $attribution = $jobj['attribution'];
                $outline = '<dcvalue element = "relation" qualifier = "ispartof">'.$attribution."</dcvalue>\n";
                fwrite($file_handle_dc_out,$outline);
                $dc_image_uri = str_replace( "detail", "iiif", $jobj['related'])."/full/full/0/default.jpg";
                $outline = '<dcvalue element = "identifier" qualifier = "imageUri">'.$dc_image_uri."</dcvalue>\n";
                fwrite($file_handle_dc_out,$outline);
                $context = $jobj['@context'];
                $related = str_replace('iiif/m', 'detail', $manifestlist[$j]);
                $related = str_replace('/manifest', '', $related);
                $rand_no = bin2hex(openssl_random_pseudo_bytes(12));
                foreach ($jobj['sequences'][0]['canvases'][0]['metadata'] as $metadatapair) {
                    $label = $metadatapair['label'];
                    $value = $metadatapair['value'];
                    if ($label === "Title") {
                        $dc_title = $metadatapair['value'];
                        $dc_title = str_replace("<span>","",$dc_title);
                        $dc_title = str_replace("</span>","",$dc_title);
                        $dc_title = str_replace("&", "and", $dc_title);
                        $outline='<dcvalue element = "title" qualifier = "">'.$dc_title."</dcvalue>\n";
                        fwrite($file_handle_dc_out,$outline);
                    }
                    if ($label === "Creator") {
                        $dc_creator = $metadatapair['value'];
                        $dc_creator = str_replace("<span>","",$dc_creator);
                        $dc_creator = str_replace("</span>","",$dc_creator);
                        $dc_title = str_replace("&", "and", $dc_title);
                        $outline = '<dcvalue element = "contributor" qualifier = "author">'.$dc_creator."</dcvalue>\n";
                        fwrite($file_handle_dc_out,$outline);
                    }
                    if ($label === "Date") {
                        $dc_date = $metadatapair['value'];
                        $dc_date = str_replace("<span>","",$dc_date);
                        $dc_date = str_replace("</span>","",$dc_date);
                        $outline = '<dcvalue element = "date" qualifier = "created">'.$dc_date."</dcvalue>\n";
                        fwrite($file_handle_dc_out,$outline);
                    }
                }

            }

            $manifestarray[] = $jobj['sequences'][0]['canvases'][0];
            $j++;
        }

        $dc_format_extent = $j;
        $outline = '<dcvalue element = "format" qualifier = "extent">'.$dc_format_extent."</dcvalue>\n";
        fwrite($file_handle_dc_out,$outline);
        fwrite($file_handle_dc_out, '</dublin_core>');
        fclose($file_handle_dc_out);

        $manifest_file =array
        ('label' => 'User generated manifest',
            'attribution'=> $attribution,
            'logo' =>  "https://www.eemec.med.ed.ac.uk/img/logo-white.png" ,
            '@id'=> "https://librarylabs.ed.ac.uk/iiif/speccollprototype/manifests/user/" .$foldername. ".json",
            'related' => $related,
            'sequences' => array(array("@type"=>"sc:Sequence", "viewingHint"=>"individual", "canvases"=>$manifestarray)),
            "@type"=>"sc:Manifest",
           // 'seeAlso'=>$almaurl,
            "@context"=>$context
        );
        $json_out = json_encode($manifest_file);
        $out_file = $subfolder."/manifest.json";
        $file_handle_out = fopen($out_file, "w")or die("<p>Sorry. I can't open the manifest file.</p>");

        fwrite($file_handle_out, $json_out);

        $file_handle_contents_out = fopen($subfolder.'/'.$contentsfile, "w")or die("<p>Sorry. I can't open contents outfile.</p>");
        fwrite($file_handle_contents_out, "manifest.json");
        fclose($file_handle_contents_out);

        $i++;
    }

    ?>
</body>
</html>
