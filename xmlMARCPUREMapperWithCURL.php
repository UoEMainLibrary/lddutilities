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
<div = "header">
<br>
    <img src="images/lddutilities.jpg">
    <h1>MARCXML to PURE mapping process </h1>
    <p>Convert your INSPIRE-exported MARCXML to PURE XML here.</p>
    <p>Enter your collaboration (e.g. LHCb, Atlas).</p>
    <p>Upload your "internal ID" file with three colon-separated parms (INSPIRE ID:PURE ID:Name). Name format is (e.g.) Clarke, P.E.L.</p>
</div>
<div class = "box">

    <form action="xmlMARCPUREMapperWithCURL.php" method="post" enctype="multipart/form-data">
        <table>
            <!--<tr><td>Give distinct author:<input type="text" name="author" id="author"></td></tr>-->
            <tr><td>Enter collaboration:<input type="text" name="collab" id="collab"></td></tr>
            <tr><td>Enter journal year (* for all years):<input type="text" name="year" id="year"></td></tr>
            <!--<tr><td>Give additional parm:<input type="text" name="addit" id="addit"></td></tr>-->
            <tr><td>Upload internal ID file:<input type="file" name="internalIDfile" id="internalIDfile"></td></tr>
        </table>
        <br>
        <input type="submit" value="Upload Files" name="upload">
    </form>

</div>
<?php
ini_set('max_execution_time', 400);
if (isset($_POST['upload']))
{

    $target_dir = "/home/lib/lacddt/librarylabs/files/";

    //$author = $_POST['author'];
    //$author=str_replace(' ','+',$author);
    $collab = $_POST['collab'];
    //$addit = $_POST['addit'];
    $year = $_POST['year'];

    if ($year == "*")
    {
        $parms = "cn+".$collab.'+and+collection:published';
    }
    else
    {
        $parms = "cn+".$collab."+and+jy+".$year.'+and+collection:published';
    }
    //$url = 'https://inspirehep.net/search?p=cn+'.$collab.'+and+collection:+'.$addit.'+and+a+'.$author.'&of=xm&em=B&sf=year&so=d&rg=250';
    $url = 'https://inspirehep.net/search?p='.$parms.'&of=xm&em=B&sf=year&so=d&rg=500';
    echo '<h5>Your INSPIRE-HEP search URL is: '.$url.'</h5>';
    $directory = $target_dir.'PUREOutput'.time().'/';
    mkdir($directory);

    $curl = curl_init();
    $fp = fopen($directory."curl.xml", "w");
    curl_setopt($curl, CURLOPT_URL, $url);
    curl_setopt($curl, CURLOPT_FILE, $fp);
    curl_setopt($curl, CURLOPT_HEADER, 0);
    curl_setopt($curl,  CURLOPT_RETURNTRANSFER, TRUE);
    $response = curl_exec($curl);
    $httpCode = curl_getinfo($curl, CURLINFO_HTTP_CODE);
    if ( $httpCode == 404 ) {
        touch($output_dir."cache/404_err.txt");
    }
    else
    {
        fwrite($fp, $response);
    }

    curl_close($curl);
    fclose($fp);

    $target_id_file = $target_dir . basename($_FILES["internalIDfile"]["name"]);
    echo '<h5>ID file is called '.$target_id_file.'</h5>';
    $uploadOkXML = 1;
    $uploadOkID = 1;
    $imageFileTypeXML = pathinfo($target_xml_file,PATHINFO_EXTENSION);
    $imageFileTypeID = pathinfo($target_id_file,PATHINFO_EXTENSION);

/*
    if (is_dir($directory)) {
        if ($dh = opendir($directory)) {
            while (($file = readdir($dh)) !== false) {
                if(strpos($file, "URE") > 0) {
                    unlink($file);
                }
            }
        }
    }
*/
    if (file_exists($target_id_file)) {
        echo "Sorry, file already exists.";
        $uploadOkID = 0;
    }

    if ($_FILES["internalIDfile"]["size"] > 500000) {
        echo "Sorry, your file is too large.";
        $uploadOkID = 0;
    }

    if($imageFileTypeID != "txt"  ) {
        echo "Sorry, only TXT files are allowed at this stage.";
        $uploadOkID = 0;
    }

    if ($uploadOkID == 0) {
        echo "Sorry, your file was not uploaded.";
// if everything is ok, try to upload file
    } else {
        if (move_uploaded_file($_FILES["internalIDfile"]["tmp_name"], $target_id_file)) {
            echo "<h5> The file ". basename( $_FILES["internalIDfile"]["name"]). " has been uploaded.</h5>";
        } else {
            echo "Sorry, there was an error uploading your ID file.";
        }
    }
    chmod ($target_id_file, 0777);
    chmod ($directory, 0777);

    $xml_file = $directory."curl.xml";

    $xml = simplexml_load_file($xml_file);

    if ($xml == FALSE)
    {
        echo "Failed loading XML\n";

        foreach (libxml_get_errors() as $error)
        {
            echo "\t", $error->message;
        }
    }

    $error = '';
    //k counts through the array from the input mapping file
    $k = 0;
    $file_handle_id_in = fopen($target_id_file, "r") or die ("can't open mapping file");
    echo '<h5>Authors To Match</h5>';
    while (!feof($file_handle_id_in)) {
        $line = fgets($file_handle_id_in);
        $map = explode(":", $line);
        $pureIntAr[$k][0] = $map[0];
        $pureIntAr[$k][1] = $map[1];
        $pureIntAr[$k][2] = $map[2];
        echo '<p>'.$k.' '.$pureIntAr[$k][0].' '.$pureIntAr[$k][1].' '.$pureIntAr[$k][2]."</p>";
        $k++;
    }

    $writer = new XMLWriter();
    $writer->openURI($directory."PURELoad0.xml");
    $writer->startDocument('1.0', 'UTF-8');
    $writer->startElement('v1:publications');
    $writer->writeAttribute('xmlns:v1', 'v1.publication-import.base-uk.pure.atira.dk');
    $writer->writeAttribute('xmlns:commons', 'v3.commons.pure.atira.dk');

    //pureCount actually the same as k
    $pureCount = count($pureIntAr);
    //n counts the lines in the document
    $n = 0;
    //z counts the papers (without stopping at twenty)
    $z = 1;
    //filecounter counts the xml files for output
    $filecounter = 0;
    //papercounter counts the papers up to twenty
    $papercounter = 0;
    $author=array();
    $initarray =array();
    $newfile = false;
    $idarray = array();
    echo '<table>';
    echo '<tr><td>Paper</td><td>Id</td><td>DOI</td><td>Title</td><td>Total authors</td><td>Matched authors</td><td>Journal Year</td></tr>';

    foreach ($xml->children() as $object)
    {
        if ($newfile == true)
        {
            $writer = new XMLWriter();
            $writer->openURI($directory."PURELoad".$filecounter.".xml");
            $writer->startDocument('1.0', 'UTF-8');
            $writer->startElement('v1:publications');
            $writer->writeAttribute('xmlns:v1', 'v1.publication-import.base-uk.pure.atira.dk');
            $writer->writeAttribute('xmlns:commons', 'v3.commons.pure.atira.dk');
        }
        //j counts every the authors within a paper
        $j = 0;
        $author = '';
        $id = '';
        $doi_block ='';
        $journal_block ='';
        $volume_block ='';
        $number_block  ='';
        $pages_block ='';
        $title_block ='';
        $abstract_block = '';
        $month_block ='';
        $day_block ='';
        $year_block ='';
        $idarray = '';
        $initarray = '';
        //idcount counts through the different ids within a paper
        $idcount = 0;
        $org = '';
        $name = '';
        $authorid = '';
        //matchedcount counts the number of matched internal authors within a paper
        $matchedcount = 0;


        foreach ($object->children() as $item)
        {
            $update = false;
            $subfolder = '';
            $inspirecode = false;
            $valid = false;
            $inspireid = false;

            if ($item[$n]['tag'] == '024') {
                foreach($item[$n]->subfield as $subfield) {
                    if ($subfield['code'] == 'a') {
                        $doi_block = $subfield;
                    }
                }
            }
            if ($item[$n]['tag'] == '035') {
                foreach($item[$n]->subfield as $subfield) {
                    if ($subfield['code'] == '9') {
                        $idarray[$idcount][0] = $subfield;
                    }
                    if ($subfield['code'] == 'a') {
                        $idarray[$idcount][1] = $subfield;
                    }
                }
                $idcount ++;
            }
            if ($item[$n]['tag'] == '773') {
                foreach($item[$n]->subfield as $subfield) {
                    if ($subfield['code'] == 'p') {
                        $journal_block = $subfield;
                    }
                    if ($subfield['code'] == 'v') {
                        $volume_block = $subfield;
                    }
                    if ($subfield['code'] == 'n') {
                        $number_block = $subfield;
                    }
                    if ($subfield['code'] == 'c') {
                        $pages_block = $subfield;
                    }
                }
            }
            if ($item[$n]['tag'] == '245') {
                foreach($item[$n]->subfield as $subfield) {
                    if ($subfield['code'] == 'a') {
                        $title_block = $subfield;
                    }
                }
            }
            if ($item[$n]['tag'] == '260') {
                foreach($item[$n]->subfield as $subfield) {
                    if ($subfield['code'] == 'c') {
                        $date = $subfield;
                        $year_block = substr($date, 0, 4);
                        $month_block = substr($date, 5, 2);
                        if ($month_block == null) {
                            $month_block = '01';
                        }
                        $day_block = substr($date, 8, 2);
                        if ($day_block == null) {
                            $day_block = '01';
                        }
                    }
                }
            }
            if ($item[$n]['tag'] == '520') {
                foreach($item[$n]->subfield as $subfield) {
                    if ($subfield['code'] == 'a') {
                        $abstract_block = $subfield;
                    }
                }
            }
            if ($item[$n]['tag'] == '700') {
                foreach($item[$n]->subfield as $subfield)
                {
                    if ($subfield['code'] == 'a')
                    {
                        $name = $subfield;
                    }
                    if ($subfield['code'] == 'i')
                    {
                        $authorid = $subfield;
                        $inspirecode = true;
                    }
                    if ($subfield['code'] == 'u')
                    {
                        $org = $subfield;
                    }
                }

                if (!$inspirecode == true)
                {
                    $author[$j][0] = '';
                }
                else{
                    $author[$j][0] = $authorid;
                }
                $commapos = strpos($name, ",");
                $family = substr($name, 0, $commapos);
                $given = substr($name, $commapos+2, 10);
                $given = str_replace(".", " ", $given);
                $given = str_replace("  ", " ", $given);
                $given = trim($given);
                $inits = substr($given,0,1).substr($family,0,1);
                $author [$j][1] = $family;
                $author[$j][2] = $given;
                $author[$j][3] = $given." ".$family;
                $author[$j][4] = $org;
                $author[$j][5] = $name;
                $author[$j][6] = $inits;
                $j++;
            }


            $n++;
        }
        $matchedcount = 0;

        if ($j > 0) {
            for ($x = 0; $x <= $j; $x++) {
                for ($q = 0; $q <= $pureCount; $q++) {
                    if ($pureIntAr[$q][2] !== null) {
                        if ($author[$x][0] == '') {
                            //echo $author[$x][5] . 'vs' . $pureIntAr[$q][2] . '<br>';
                            if ($pureIntAr[$q][2] == $author[$x][5]) {
                                $matchedcount++;
                                //echo 'MATCH' . $matchedcount . ' ' . $author[$x][5] . '<br>';
                            }
                        } else {
                            //echo $author[$x][0] . 'vs' . $pureIntAr[$q][0] . '<br>';
                            if ($pureIntAr[$q][0] == $author[$x][0]) {
                                $matchedcount++;
                                // echo 'MATCH' . $matchedcount . ' ' . $author[$x][0] . '<br>';
                            }
                        }
                    }
                }
            }
        }

        for ($g = 0; $g<=$idcount; $g++)
        {
            if ($idarray[$g][0] == 'INSPIRETeX')
            {
                $id = $idarray[$g][1];
                $inspireid = true;
                //echo '<p>Transforming item (' . $z . '): <b>' . $id . '</b></p>';
            }
        }

        if (!$inspireid) {
            for ($g = 0; $g <= $idcount; $g++) {
                if ($idarray[$g][0] == 'SPIRESTeX') {
                    $id = $idarray[$g][1];
                    $inspireid = true;
                    //echo '<p>Transforming item (' . $z . '): <b>' . $id . '</b></p>';
                }
            }
        }

        if (!$inspireid)
        {
            for ($g = 0; $g<=$idcount; $g++)
            {
                if ($idarray[$g][0] == 'arXiv')
                {
                    $id = $idarray[$g][1];
                    //echo '<p>Transforming item (' . $z . '): <b>' . $id . '</b></p>';
                }
            }
        }

        //echo 'MATCH TOTAL'.$matchedcount.'<br>';
        if($matchedcount > 0) {
            //echo 'I found a match so I am writing a record<br>';
            $writer->startElement("v1:contributionToJournal");
            $writer->writeAttribute('id', $id);
            $writer->writeAttribute('subType', 'article');
            $writer->writeElement('v1:peerReviewed', 'true');
            $writer->writeElement('v1:publicationCategory', 'research');
            $writer->setIndent(4);
            $writer->startElement('v1:publicationStatuses');
            $writer->startElement('v1:publicationStatus');
            $writer->writeElement('v1:statusType', 'published');
            $writer->startElement('v1:date');
            $writer->writeElement('commons:year', $year_block);
            $writer->writeElement('commons:month', $month_block);
            $writer->writeElement('commons:day', $day_block);
            $writer->endElement();
            $writer->endElement();
            $writer->endElement();
            $writer->writeElement('v1:language', 'en_GB');
            $writer->startElement('v1:title');
            $writer->writeElement('commons:text', $title_block);
            $writer->writeAttribute('lang', 'en');
            $writer->writeAttribute('country', 'GB');
            $writer->endElement();
            $writer->startElement('v1:abstract');
            $writer->writeElement('commons:text', $abstract_block);
            $writer->writeAttribute('lang', 'en');
            $writer->writeAttribute('country', 'GB');
            $writer->endElement();
            $writer->setIndent(4);
            $writer->startElement('v1:persons');
            $matchedcount = 0;

            for ($x = 0; $x <= $j; $x++) {
                if (($author[$x][0] == '')) {
                    $internal = false;
                }
                if ($author[$x][1] !== null) {
                    $writer->startElement('v1:author');
                    $writer->writeElement('v1:role', 'author');
                    $writer->startElement('v1:person');
                    $internal = false;

                    for ($q = 0; $q <= $pureCount; $q++) {
                        if ($author[$x][0] == '') {
                            if ($pureIntAr[$q][2] == $author[$x][5]) {
                                $writer->writeAttribute('id', trim($pureIntAr[$q][1]));
                                $internal = true;
                                $writer->writeAttribute('external', 'false');
                                $initarray[$matchedcount] = $author[$x][6].'/';
                                $matchedcount++;
                            }
                        } else {
                            if ($pureIntAr[$q][0] == $author[$x][0]) {
                                $writer->writeAttribute('id', trim($pureIntAr[$q][1]));
                                $internal = true;
                                $writer->writeAttribute('external', 'false');
                                $initarray[$matchedcount] = $author[$x][6].'/';
                                $matchedcount++;
                            }
                        }
                    }

                    if (!$internal) {
                        $writer->writeAttribute('external', 'true');
                    }
                    $writer->writeElement('v1:fullName', $author[$x][3]);
                    $writer->writeElement('v1:firstName', $author[$x][2]);
                    $writer->writeElement('v1:lastName', $author[$x][1]);
                    $writer->endElement();
                    $writer->startElement('v1:organisations');
                    $writer->startElement('v1:organisation');
                    $writer->startElement('v1:name');
                    $writer->writeElement('commons:text', $author[$x][4]);
                    $writer->endElement();
                    $writer->endElement();
                    $writer->endElement();
                    $writer->endElement();
                }
            }

            $urlbit = 'http://dx.doi.org/';

            $writer->endElement();
            $writer->startElement('v1:owner');
            $writer->writeAttribute('id', 'S44');
            $writer->endElement();
            $writer->startElement('v1:electronicVersions');
            $writer->startElement('v1:electronicVersionDOI');
            $writer->writeElement('v1:doi', $doi_block);
            $writer->endElement();
            $writer->endElement();
            $writer->writeElement('v1:pages', $pages_block);
            $writer->writeElement('v1:articleNumber', $id);
            $writer->writeElement('v1:journalNumber', $number_block);
            $writer->writeElement('v1:journalVolume', $volume_block);
            $writer->startElement('v1:journal');
            $writer->writeElement('v1:title', $journal_block);
            $writer->endElement();
            $writer->endElement();
            $papercounter++;
            $newfile = false;

            if($papercounter == 19)
            {
                $filecounter++;
                $papercounter = 0;
                $newfile = true;
            }

            if ($newfile == true) {
                $writer->endDocument();
            }

        }

        echo '<tr><td>' . $z . '</td><td>' . $id . '</td><td><a href="' . $urlbit . $doi_block . ' target = "_blank">' . $urlbit . $doi_block . '</a></td><td>' . substr($title_block, 0, 30) . '...</td><td>' . $j . '</td><td>' . $matchedcount . ' (';


        for ($ic = 0; $ic <= $matchedcount; $ic++)
        {
            echo $initarray[$ic];
        }
        echo ')</td><td>'.$year.'</td></tr>';


        $z++;

    }
    echo '</table>';
    $writer->endDocument();

    unlink($target_xml_file);
    unlink($target_id_file);
    unlink($processed_file);

    $zipname = $directory.'PURELoad.zip';
    //echo $zipname."<br>";
    $zip = new ZipArchive();
    $opened = $zip->open($zipname, ZipArchive::CREATE);

    if ($opened !== true) {
            switch($opened){
                case ZipArchive::ER_EXISTS:
                    $ErrMsg = "File already exists.";
                    break;

                case ZipArchive::ER_INCONS:
                    $ErrMsg = "Zip archive inconsistent.";
                    break;

                case ZipArchive::ER_MEMORY:
                    $ErrMsg = "Malloc failure.";
                    break;

                case ZipArchive::ER_NOENT:
                    $ErrMsg = "No such file.";
                    break;

                case ZipArchive::ER_NOZIP:
                    $ErrMsg = "Not a zip archive.";
                    break;

                case ZipArchive::ER_OPEN:
                    $ErrMsg = "Can't open file.";
                    break;

                case ZipArchive::ER_READ:
                    $ErrMsg = "Read error.";
                    break;

                case ZipArchive::ER_SEEK:
                    $ErrMsg = "Seek error.";
                    break;

                default:
                    $ErrMsg = "Unknown (Code $rOpen)";
                    break;
            }
            die( 'ZipArchive Error: ' . $ErrMsg);
        }

    else {

        if (is_dir($directory)) {
            if ($dh = opendir($directory)) {
                while (($file = readdir($dh)) !== false) {
                    if ((strpos($file, "URE") > 0) and (strpos($file, ".xml")> 0)) {
                        //echo "<p>".$file . " going into " . $zipname . "</p><br>";
                        $zip->addFile($directory.$file, basename($file));
                    }
                }
            }
        }

    }

    $zip->close();

    echo '<h5>That seems to have done everything it is supposed to. Get your file by clicking the link below.</h5>';
    echo '<a href= "download.php?directory='.$directory.'"><h4>Download Output</h4></a>';
}

?>
</body>
</html>
