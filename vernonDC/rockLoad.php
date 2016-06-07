<!DOCTYPE html>

<HTML>
<HEAD>
    <TITLE>DIU Photography Ordering System</TITLE>
    <link rel="stylesheet" type ="text/css" href="diustyles.css">
    <meta name="author" content="Library Online Editor">
    <meta name="description" content="Edinburgh University Library Online: Book purchase request forms for staff: Medicine and Veterinary">
    <meta name="distribution" content="global">
    <meta name="resource-type" content="document">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</HEAD>

<BODY>
<div class= "central">
<div class = "heading">
    <a href="index.html" title="Link to The DIU Web Area">
        <img src="./images/header4.jpg" alt="The University of Edinburgh Image Collections" width="754" height="65" border="0" />
    </a>
    <h2>GET ROCKS INTO DSPACE</h2>
    <hr/>
</div>
<div class = "box">

<?php
//ini_set('default_charset', 'utf-8');
#DIU Numbers
#Scott Renton, 02/08/2013
include 'vars.php';
$error = '';
header('Content-Encoding: UTF-8');
header('Content-type: text/csv; charset=UTF-8');
$infile = $_SERVER['DOCUMENT_ROOT'].'/euchmi/files/cockburn2.csv';
$dublincorefile = 'dublin_core.xml';
$contentsfile = 'contents';
$logfile = $_SERVER['DOCUMENT_ROOT'].'/euchmi/files/image_output.txt';
$file_handle_in = fopen($infile, "r")or die("can't open infile");
$photodirectory =  $_SERVER['DOCUMENT_ROOT'].'/euchmi/geologyImages/';
$file_handle_log_out = fopen($logfile, "a+")or die("can't open this outfile");
$directory = $_SERVER['DOCUMENT_ROOT'].'/euchmi/files/geology/';


$folder_name = 0;
$delimiter=',';

$rockdata = array();
$header = null;
while (($row = fgetcsv($file_handle_in, 1000, $delimiter)) !== FALSE)
{

   // $row = str_replace("\n", '', $row);


    if (!$header)
    {
        $header = $row;
    }
    else
    {
        $rockdata[] = array_combine($header, $row);

        $subfolder = $directory.$folder_name;
        mkdir($subfolder);
        chmod ($subfolder, 0777);
        //$row = str_replace( '"', "'",$row);
        //$row = str_replace('"', "'", $row);
        //$row = str_replace("‘", "'", $row);
        //$row = str_replace("’", "'", $row);
        //$row = str_replace('“','', $row);
        //$row = str_replace('”','', $row);
        $file_handle_dc_out = fopen($subfolder.'/'.$dublincorefile, "w")or die("can't open this outfile");
        $file_handle_contents_out = fopen($subfolder.'/'.$contentsfile, "w")or die("can't open this outfile");
        fwrite($file_handle_dc_out,"<?xml version=\"1.0\" encoding=\"UTF-8\"?> \n");
        fwrite($file_handle_dc_out,"<dublin_core>\n");

        $notestring = $rockdata[$folder_name]['Notes'];
        $notestring=htmlspecialchars($notestring, ENT_QUOTES, 'UTF-8');
        $locstring = $rockdata[$folder_name]['Location in Museum'];
        $locstring=htmlspecialchars($locstring, ENT_QUOTES, 'UTF-8');
        $titlestring = $rockdata[$folder_name]['Object Description'];
        $titlestring=htmlspecialchars($titlestring, ENT_QUOTES, 'UTF-8');
        $collstring = $rockdata[$folder_name]['Collector'];
        $collstring=htmlspecialchars($collstring, ENT_QUOTES, 'UTF-8');
        $sourcestring = $rockdata[$folder_name]['Locality'];
        $sourcestring=htmlspecialchars($sourcestring, ENT_QUOTES, 'UTF-8');
        //$string=htmlentities($string, ENT_QUOTES, 'UTF-8');
        fwrite($file_handle_dc_out, "<dcvalue element = \"type\" qualifier = \"\">".$rockdata[$folder_name]['Object Type']."</dcvalue>\n");
        fwrite($file_handle_dc_out, "<dcvalue element = \"identifier\" qualifier = \"other\">".$rockdata[$folder_name]['Accession Number']."</dcvalue>\n");
        fwrite($file_handle_dc_out, "<dcvalue element = \"title\" qualifier = \"\">".$titlestring."</dcvalue>\n");
        fwrite($file_handle_dc_out, "<dcvalue element = \"identifier\" qualifier = \"\">".$locstring."</dcvalue>\n");
        fwrite($file_handle_dc_out, "<dcvalue element = \"format\" qualifier = \"extent\">".$rockdata[$folder_name]['Quantity/ Number of parts']."</dcvalue>\n");
        fwrite($file_handle_dc_out, "<dcvalue element = \"contributor\" qualifier = \"\">".$collstring."</dcvalue>\n");
        fwrite($file_handle_dc_out, "<dcvalue element = \"relation\" qualifier = \"ispartof\">".$rockdata[$folder_name]['Collection']."</dcvalue>\n");
        fwrite($file_handle_dc_out, "<dcvalue element = \"subject\" qualifier = \"\">".$rockdata[$folder_name]['Dana Number']."</dcvalue>\n");
        fwrite($file_handle_dc_out, "<dcvalue element = \"source\"  qualifier = \"\">".$sourcestring."</dcvalue>\n");
        fwrite($file_handle_dc_out, "<dcvalue element = \"date\" qualifier = \"created\" >".$rockdata[$folder_name]['Acquisiton date']."</dcvalue>\n");
        fwrite($file_handle_dc_out, "<dcvalue element = \"rights\" qualifier = \"holder\">".$rockdata[$folder_name]['Ownership']."</dcvalue>\n");
        fwrite($file_handle_dc_out, "<dcvalue element = \"description\" qualifier = \"abstract\">".$notestring."</dcvalue>\n");
        fwrite($file_handle_dc_out, "<dcvalue element = \"relation\" qualifier = \"isreferencedby\">".$rockdata[$folder_name]['PhotoNumber']."</dcvalue>\n");

        $photono = $rockdata[$folder_name]['PhotoNumber'];
        $photolen = strlen($photono);

        if (substr($photono,0,4) == 'EUCM')
        {
            $stoppos = strpos($photono, ".");
            $photono = substr_replace($photono, substr($photono,0,$stoppos), "");
            echo $photono;
            $stoppos2 = strpos($photono, ".");
            $photono = substr($photono, 0, $stoppos2 -1);
            echo $photono;
        }


        switch ($photolen)
        {
            case 4:
                break;
            case 3:
                $photono = '0'.$photono;
                break;
            case 2:
                $photono = '00'.$photono;
                break;
            case 1:
                $photono = '000'.$photono;
                break;
        }



        if (is_dir($photodirectory))
        {
            if ($dh = opendir($photodirectory))
            {
                while (($file = readdir($dh)) !== false)
                {
                   if (strpos($file, $photono) > 0)
                   {
                       $filepath = $photodirectory.$file;
                       $copypath = $subfolder.'/'.$file;
                       if (!copy($filepath, $copypath))
                       {
                           echo "failed to copy $filepath...\n";

                       }
                       else
                       {
                           fwrite($file_handle_contents_out, $file."\n");

                       }
                   }
                }

                closedir($dh);

            }

        }

        fwrite($file_handle_dc_out, '</dublin_core>');
        fclose($file_handle_dc_out);
        fclose($file_handle_contents_out);
        $folder_name++;
    }


}

fclose($file_handle_in);
fclose($file_handle_log_out);

?>
<div class = "footer">
    <hr/>
    <p><a href="members.php">Back To Members' Area</a></p>
</div>
</div>
</body>
</html>


