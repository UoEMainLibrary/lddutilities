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
        <img src="images/lddutilities.jpg">
        <h1> Bibtex to PURE mapping process </h1>
        <p>Convert your INSPIRE-exported MARCXML to PURE XML here. Upload the MARCXML first, and then upload your "internal ID" file with the INSPIRE ID on the left, PURE ID on the right. Separate with a colon.</p>
        <div class = "box">
            <form action="bibtexPureMapperFiles.php" method="post" enctype="multipart/form-data">
                <p>Select Bibtex file to upload:</p>
                <input type="file" name="bibfile" id="bibfile">
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
        $target_bib_file = $target_dir . basename($_FILES["bibfile"]["name"]);
        $target_id_file = $target_dir . basename($_FILES["internalIDfile"]["name"]);
        echo '<p>*** Bibtex file is called '.$target_bib_file.'</p>';
        echo '<p>*** ID file is called '.$target_id_file.'</p>';
        $uploadOkBib = 1;
        $uploadOkID = 1;
        $imageFileTypeBib = pathinfo($target_bib_file,PATHINFO_EXTENSION);
        $imageFileTypeID = pathinfo($target_id_file,PATHINFO_EXTENSION);
        unlink("files/PURELoad.xml");

        // Check if file already exists
        if (file_exists($target_bib_file)) {
            echo "Sorry, file already exists.";
            $uploadOkBib = 0;
        }
        if (file_exists($target_id_file)) {
            echo "Sorry, file already exists.";
            $uploadOkID = 0;
        }

        // Check file size
        if ($_FILES["bibfile"]["size"] > 500000) {
            echo "Sorry, your file is too large.";
            $uploadOkBib = 0;
        }

        if ($_FILES["internalIDfile"]["size"] > 500000) {
            echo "Sorry, your file is too large.";
            $uploadOkID = 0;
        }

        // Allow certain file formats
        if($imageFileTypeBib != "txt"  ) {
            echo "Sorry, only XML files are allowed for data.";
            $uploadOkBib = 0;
        }

        if($imageFileTypeID != "txt"  ) {
            echo "Sorry, only TXT files are allowed at this stage.";
            $uploadOkID = 0;
        }
        // Check if $uploadOk is set to 0 by an error
        if ($uploadOkBib == 0) {
            echo "Sorry, your file was not uploaded.";
// if everything is ok, try to upload file
        } else {
            if (move_uploaded_file($_FILES["bibfile"]["tmp_name"], $target_bib_file)) {
                echo "<p>*** The file ". basename( $_FILES["bibfile"]["name"]). " has been uploaded.</p>";
            } else {
                echo "Sorry, there was an error uploading your Bibtex file.";
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

        chmod ($target_bib_file, 0777);
        chmod ($target_id_file, 0777);

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


        $l =0;
        $file_handle_bib_in = fopen($target_bib_file, "r") or die ("can't open mapping file");
        while (!feof($file_handle_bib_in)) {
            $line = fgets($file_handle_bib_in);
            $textAr[$l] = $line;
            $l++;
        }
        $l++;
        $textAr[$l] .="\nEND\n";

        $count = count($textAr);

        $pureCount = count($pureIntAr);

        echo 'LINE COUNT'.$count. '<br>';
        //i counts the lines in the input text area
        $i = 0;

        $j = 0;
        //x counts the distinct articles
        $x = 0;
        while ($i < $count) {

            $idpoint = strpos($textAr[$i], "@article");
            if ($idpoint !== false) {
                $x++;
                echo '<p>Processing article: ' . $textAr[$i] . '('.$x.')</p>';
                $id = substr($textAr[$i], $idpoint + 9, strlen($textAr[$i]) - 11);
                $writer->setIndent(4);

                $writer->startElement("v1:contributionToJournal");
                $writer->writeAttribute('id', $id);
                $writer->writeAttribute('subType', 'article');
                $writer->writeElement('v1:peerReviewed', 'true');
                $writer->writeElement('v1:publicationCategory', 'research');

                $newline = 1;
                $bibarray = array();

                //n counts the lines in the output array
                $n = 0;
                while ($newline !== 0) {
                    $i++;
                    $line = $textAr[$i];
                    $newline = (strpos($line, "@article"));
                    $validline = (strpos($line, " = "));
                    if ($validline > 0) {
                        $map = explode(" = ", $line);
                        $bibarray[$n][0] = $map[0];
                        $map[1] = trim($map[1]);
                        $slacline = strpos($map[0], 'SLACcit');
                        if (!$slacline === false) {
                            $endline = 1;
                        } else {
                            $endline = strpos($map[1], "\",");
                        }
                        while ($endline === false) {
                            $i++;
                            $subsline = $textAr[$i];
                            $map[1] .= " " . trim($subsline);
                            $endline = strpos($subsline, "\",");
                        }
                        $bibarray[$n][1] = $map[1];

                        $n++;
                    }
                    if ($line == 'END' || $line == '}') {
                        $newline = 0;
                    }
                }

                foreach ($bibarray as $member) {
                    //process relevant data
                    $key = $member[0];
                    $value = $member[1];
                    //print_r($member);
                    //echo '<br>';

                    if (trim($key) == 'pages') {
                        $pages_block = padding_remove($value);
                    }
                    if (trim($key) == 'number') {
                        $number_block = padding_remove($value);
                    }
                    if (trim($key) == 'title') {
                        $title_block = padding_remove($value);
                    }
                    if (trim($key) == 'journal') {
                        $journal_block = padding_remove($value);
                    }
                    if (trim($key) == 'volume') {
                        $volume_block = padding_remove($value);
                    }
                    if (trim($key) == 'doi') {
                        $doi_block = padding_remove($value);
                        $elsevier = strpos($value, '10.1016');
                        $response = doi_work($value, $elsevier);
                    }
                    if (trim($key) == 'year') {
                        $year_block = padding_remove($value);
                    }
                }
                $writer->setIndent(4);
                $writer->startElement('v1:publicationStatuses');
                $writer->startElement('v1:publicationStatus');
                $writer->writeElement('v1:statusType', 'published');
                $writer->startElement('v1:date');
                $writer->writeElement('commons:year', $year_block);
                $writer->writeElement('commons:month', '01');
                $writer->writeElement('commons:day', '01');
                $writer->endElement();
                $writer->endElement();
                $writer->endElement();
                $writer->writeElement('v1:language', 'en_GB');
                $writer->startElement('v1:title');
                $writer->writeElement('commons:text', $title_block);
                $writer->writeAttribute('lang', 'en');
                $writer->writeAttribute('country', 'GB');
                $writer->endElement();


                //write data to XML file in correct order
                $writer->setIndent(4);

                //Process authors based on CURL response from DOI
                $writer->startElement('v1:persons');
                $response_json = get_json_array($response);

                //Elsevier identifiers need to be processed differently to others
                if ($elsevier !== false) {
                    foreach ($response_json as $output) {
                        foreach ($output['coredata'] as $dataname => $dataval) {
                            if ($dataname == 'dc:creator') {
                                $author_array = $dataval;
                                $author_count = count($author_array);
                                $last = $author_count;

                                foreach ($author_array as $keyname => $value) {
                                    foreach ($value as $key => $val) {
                                        if ($key == '$') {
                                            $name = explode(", ", $val);
                                            $family = $name[0];
                                            $given = trim($name[1]);
                                            $given = str_replace(".", " ", $given);
                                            $given = str_replace("  ", " ", $given);
                                            $given = trim($given);
                                            $full = $given .' '. $family;
                                            $writer->startElement('v1:author');
                                            $writer->writeElement('v1:role', 'author');
                                            $writer->startElement('v1:person');
                                            $internal = false;
                                            for ($q = 0; $q <= $pureCount; $q++) {
                                                $pureMember = $pureIntAr[$q][0];
                                                $pureId = $pureIntAr[$q][1];
                                                if ($pureMember == $full) {
                                                    $writer->writeAttribute('id', trim($pureId));
                                                    $internal = true;
                                                    $writer->writeAttribute('external', 'false');
                                                }
                                            }
                                            if (!$internal) {
                                                $writer->writeAttribute('external', 'true');
                                            }
                                            $writer->writeElement('v1:fullName', $full);
                                            $writer->writeElement('v1:firstName', $given);
                                            $writer->writeElement('v1:lastName', $family);
                                            $writer->endElement();
                                            $writer->endElement();
                                        }
                                    }
                                }
                            }
                        }
                    }
                } else {
                    $author_array = $response_json["author"];
                    $author_count = count($author_array);
                    $last = $author_count;
                    for ($m = 0; $m < $last; $m++) {
                        $family = $author_array[$m]['family'];
                        $given = trim($author_array[$m]['given']);
                        $given = str_replace(".", " ", $given);
                        $given = str_replace("  ", " ", $given);
                        $given = trim($given);
                        $full = $given .' '. $family;
                        $writer->startElement('v1:author');
                        $writer->writeElement('v1:role', 'author');
                        $writer->startElement('v1:person');
                        $internal = false;
                        for ($q = 0; $q <= $pureCount; $q++) {
                            $pureMember = $pureIntAr[$q][0];
                            $pureId = $pureIntAr[$q][1];
                            if ($pureMember == $full) {
                                $writer->writeAttribute('id', trim($pureId));
                                $internal = true;
                                $writer->writeAttribute('external', 'false');
                            }

                        }
                        if (!$internal) {
                            $writer->writeAttribute('external', 'true');
                        }
                        $writer->writeElement('v1:fullName', $full);
                        $writer->writeElement('v1:firstName', $given);
                        $writer->writeElement('v1:lastName', $family);
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
                $writer->writeElement('v1:doi',$doi_block);
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
                $j++;
            }
            else
            {
                $i++;
            }
        }

        $writer->endDocument();

        unlink($target_bib_file);
        unlink($target_id_file);

        echo '<h5>That seems to have done everything it is supposed to. Get your file by clicking the link below.</h5>';
        echo '<a href= "download.php"><h4>Download Output</h4></a>';
    }

    function padding_remove($value)
    {
        //remove enclosing inverted commas, curly brackets and commas
        $value = str_replace('"{', '', $value);
        $value = str_replace('}",', '', $value);
        $value = str_replace('",', '', $value);
        $value = str_replace('"', '', $value);
        return $value;
    }

    function doi_work($value, $elsevier)
    {
        $value = padding_remove($value);
        // create a new cURL resource

        if ($elsevier !== false)
        {
            $url = "http://api.elsevier.com/content/article/DOI:".$value;
            $curl = curl_init();
            $header[0] = "Accept: application/json";
            curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
			curl_setopt($curl, CURLOPT_HEADER, false);
			curl_setopt($curl, CURLOPT_URL, $url);
            curl_setopt($curl, CURLOPT_HTTPHEADER, $header);
        }
        else {
            $url = 'http://dx.doi.org/' . $value;
            $curl = curl_init();
            $header[0] = "Accept: application/rdf+xml;q=0.5,";
            $header[0] .= "application/vnd.citationstyles.csl+json;q=1.0";
            curl_setopt($curl, CURLOPT_URL, $url);
            curl_setopt($curl, CURLOPT_USERAGENT, 'Googlebot/2.1 (+http://www.google.com/bot.html)');
            curl_setopt($curl, CURLOPT_HTTPHEADER, $header);
            curl_setopt($curl, CURLOPT_REFERER, 'http://www.google.com');
            curl_setopt($curl, CURLOPT_AUTOREFERER, true);
            curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($curl, CURLOPT_FOLLOWLOCATION, true);
            curl_setopt($curl, CURLOPT_TIMEOUT, 10);
        }
        $response = curl_exec($curl);
        curl_close($curl);
        //echo '<br>';
        return $response;
    }

    function get_json_array($json)
    {
        return json_decode($json, true);
    }

    ?>
    </body>
</html>
