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
    <p>Convert your INSPIRE-exported MARCXML to PURE XML here. Upload the MARCXML first, and then upload your "internal ID" file with the INSPIRE ID on the left, PURE ID on the right. Separate with a colon.</p>
</div>
<div class = "box">

    <form action="xmlMARCPUREMapperToFile.php" method="post" enctype="multipart/form-data">
        <p>Select XML file to upload:</p>
        <input type="file" name="xmlfile" id="xmlfile">
        <p>Select internal IDs file to upload:</p>
        <input type="file" name="internalIDfile" id="internalIDfile">
        <br>
        <input type="submit" value="Upload Files" name="upload">
    </form>

</div>
<?php
ini_set('max_execution_time', 400);
if (isset($_POST['upload']))
{

    $target_dir = "/home/lib/lacddt/librarylabs/files/";
    $target_xml_file = $target_dir . basename($_FILES["xmlfile"]["name"]);
    $target_id_file = $target_dir . basename($_FILES["internalIDfile"]["name"]);
    echo '<p>*** XML file is called '.$target_xml_file.'</p>';
    echo '<p>*** ID file is called '.$target_id_file.'</p>';
    $uploadOkXML = 1;
    $uploadOkID = 1;
    $imageFileTypeXML = pathinfo($target_xml_file,PATHINFO_EXTENSION);
    $imageFileTypeID = pathinfo($target_id_file,PATHINFO_EXTENSION);
    unlink("files/PURELoad.xml");

    // Check if file already exists
    if (file_exists($target_xml_file)) {
        echo "Sorry, file already exists.";
        $uploadOkXML = 0;
    }
    if (file_exists($target_id_file)) {
        echo "Sorry, file already exists.";
        $uploadOkID = 0;
    }

    // Check file size
    if ($_FILES["xmlfile"]["size"] > 500000) {
        echo "Sorry, your file is too large.";
        $uploadOkXML = 0;
    }

    if ($_FILES["internalIDfile"]["size"] > 500000) {
        echo "Sorry, your file is too large.";
        $uploadOkID = 0;
    }

    // Allow certain file formats
    if($imageFileTypeXML != "xml"  ) {
        echo "Sorry, only XML files are allowed for data.";
        $uploadOkXML = 0;
    }

    if($imageFileTypeID != "txt"  ) {
        echo "Sorry, only TXT files are allowed at this stage.";
        $uploadOkID = 0;
    }
    // Check if $uploadOk is set to 0 by an error
    if ($uploadOkXML == 0) {
        echo "Sorry, your file was not uploaded.";
// if everything is ok, try to upload file
    } else {
        if (move_uploaded_file($_FILES["xmlfile"]["tmp_name"], $target_xml_file)) {
            echo "<p>*** The file ". basename( $_FILES["xmlfile"]["name"]). " has been uploaded.</p>";
        } else {
            echo "Sorry, there was an error uploading your XML file.";
        }
    }

    if ($uploadOkID == 0) {
        echo "Sorry, your file was not uploaded.";
// if everything is ok, try to upload file
    } else {
        if (move_uploaded_file($_FILES["internalIDfile"]["tmp_name"], $target_id_file)) {
            echo "<p>*** The file ". basename( $_FILES["internalIDfile"]["name"]). " has been uploaded.</p>";
        } else {
            echo "Sorry, there was an error uploading your ID file.";
        }
    }

    chmod ($target_xml_file, 0777);
    chmod ($target_id_file, 0777);

    if (file_exists($target_xml_file)) {
        $file_handle_in = fopen($target_xml_file, "r")or die("<p>Sorry. I can't open the extract file.</p>");
        $processed_file = $target_dir ."xml_clean.xml";
        $file_handle_out = fopen($processed_file, "w")or die("<p>Sorry. I can't open dc outfile.</p>");
        while (!feof($file_handle_in))
        {
            $line = fgets($file_handle_in);
            $line = str_replace("& \\lt", "&lt;", $line);
            $line = str_replace("& \\rt", "&rt;", $line);
            $line = str_replace("& ", "&amp;", $line);
            fwrite($file_handle_out,$line);
        }
        $xml = simplexml_load_file($processed_file);
    } else {
        exit('Failed to open target xml file');
    }

    if ($xml == FALSE)
    {
        echo "Failed loading XML\n";

        foreach (libxml_get_errors() as $error)
        {
            echo "\t", $error->message;
        }
    }

    $error = '';
    $writer = new XMLWriter();
    $writer->openURI("files/PURELoad.xml");
    $writer->startDocument('1.0', 'UTF-8');
    $writer->startElement('v1:publications');
    $writer->writeAttribute('xmlns:v1', 'v1.publication-import.base-uk.pure.atira.dk');
    $writer->writeAttribute('xmlns:commons', 'v3.commons.pure.atira.dk');

    $k = 0;
    $file_handle_id_in = fopen($target_id_file, "r") or die ("can't open mapping file");
    while (!feof($file_handle_id_in)) {
        $line = fgets($file_handle_id_in);
        $map = explode(":", $line);
        $pureIntAr[$k][0] = $map[0];
        $pureIntAr[$k][1] = $map[1];
        $k++;
    }

    $pureCount = count($pureIntAr);
    $n = 0;
    $z = 0;

    foreach ($xml->children() as $object)
    {
        foreach ($object->children() as $item)
        {
            $update = false;
            $subfolder = '';
            $avarray = array();
            $avnotearray = array();
            $avusearray = array();
            $avsortarray = array();
            $avcounter = 0;
            $avnotecounter = 0;
            $avusecount = 0;
            if ($item[$n]['tag'] == '024') {
                $doi_block = $item[$n]->subfield[1];
            }

            if ($item[$n]['tag'] == '035') {
                if ($item[$n]->subfield[0] == 'INSPIRETeX') {
                    $id = $item[$n]->subfield[1];
                    echo '<p>Transforming item ('.$z.'): '.$id.'</p>';
                }
            }
            if ($item[$n]['tag'] == '773') {
                $journal_block = $item[$n]->subfield[2];
                $volume_block = $item[$n]->subfield[3];
                $number_block = $item[$n]->subfield[1];
                $pages_block = $item[$n]->subfield[0];
            }

            if ($item[$n]['tag'] == '245') {
                if ($item[$n]->subfield['code']='a')
                {
                    $title_block = $item[$n]->subfield;
                }
            }

            if ($item[$n]['tag'] == '260') {
                $date = $item[$n]->subfield[0];
                $year_block = substr($date, 0, 4);
                $month_block = substr($date, 5, 2);
                $day_block = substr($date, 8, 2);
            }

            if ($item[$n]['tag'] == '520') {
                $abstract_block = $item[$n]->subfield[1];
            }

            if ($item[$n]['tag'] == '700') {
                if(strpos($item[$n]->subfield[0], 'INSPIRE') !== false)
                {
                    $author[$j][0] = $item[$n]->subfield[0];
                    $name = $item[$n]->subfield[1];
                    $org = $item[$n]->subfield[2];
                }
                else
                {
                    $name = $item[$n]->subfield[0];
                    $author[$j][0] = "";
                    $org = $item[$n]->subfield[1];
                }
                $commapos = strpos($name, ",");
                $family = substr($name, 0, $commapos);
                $given = substr($name, $commapos+2, 10);
                $given = str_replace(".", " ", $given);
                $given = str_replace("  ", " ", $given);
                $given = trim($given);
                $author [$j][1] = $family;
                $author [$j][2] = $given;
                $author [$j][3] = $given." ".$family;
                $author [$j][4] = $org;
                $j++;
            }

            $n++;
        }
        print_r($author);
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
        for ($x = 0; $x<=$j; $x++)
        {
            if (($author[$x][0] == ''))
            {
                $internal = false;
            }
            echo 'AUTHOR IN'.$author[$x][1];
            if ($author[$x][1] !== null) {
                $writer->startElement('v1:author');
                $writer->writeElement('v1:role', 'author');
                $writer->startElement('v1:person');
                $internal = false;
                for ($q = 0; $q <= $pureCount; $q++) {
                    if ($author[$x][0] !== '') {
                        if ($pureIntAr[$q][0] == $author[$x][0]) {
                            $writer->writeAttribute('id', trim($pureIntAr[$q][1]));
                            $internal = true;
                            $writer->writeAttribute('external', 'false');
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
                $writer->writeElement('commons:text',$author[$x][4]);
                $writer->endElement();
                $writer->endElement();
                $writer->endElement();
                $writer->endElement();
            }
        }
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
        $z++;
    }
    $writer->endDocument();

    unlink($target_xml_file);
    unlink($target_id_file);
    unlink($processed_file);

    echo '<h5>That seems to have done everything it is supposed to. Get your file by clicking the link below.</h5>';
    echo '<a href= "download.php"><h4>Download Output</h4></a>';

}

?>
</body>
</html>
