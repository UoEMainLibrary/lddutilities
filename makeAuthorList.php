<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>LDD Utilities Menu</title>

    <!-- Bootstrap -->
    <link href="assets/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/pure.css">
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<div = "header"><h1>MAKE AUTHOR LIST</h1>
</div>
<br>
<?php
/**
 * Created by PhpStorm.
 * User: srenton1
 * Date: 30/06/2016
 * Time: 08:40
 */

$docbase = '/Users/srenton1/Projects/lddutilities/';
$infile = $docbase.'/files/authorList.xml';

$authorfile =  $docbase.'/files/authorListOutput.txt';
$orgfile =  $docbase.'/files/orgListOutput.txt';


$file_handle_in = fopen($infile, "r")or die("<p>Sorry. I can't open the extract file.</p>");

$file_handle_author = fopen($authorfile, "w")or die("<p>Sorry. I can't open author outfile.</p>");
fwrite($file_handle_author, pack("CCC",0xef,0xbb,0xbf));
$file_handle_org = fopen($orgfile, "w")or die("<p>Sorry. I can't open org outfile.</p>");
fwrite($file_handle_org, pack("CCC",0xef,0xbb,0xbf));

$xml=simplexml_load_file($infile);

foreach($xml->children() as $object)
{
    $authorname = '';
    $inspireid = '';
    $org = '';
   foreach($object->subfield as $subfield)
   {
       if ($subfield['code'] == 'a') {
           $authorname = $subfield;
       }

       if ($subfield['code'] == 'i') {
           $inspireid = $subfield;
       }



       if ($subfield['code'] == 'u') {
           $org = $subfield;
       }


   }
    fwrite($file_handle_author,$authorname.':'.$inspireid."\n");
    fwrite($file_handle_org,$org."\n");
}
fclose($file_handle_in);
fclose($file_handle_author);
fclose($file_handle_org);
?>
</body>
</html>
