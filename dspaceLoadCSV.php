<!DOCTYPE html>

<HTML>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Convert CSV to DSpace import structure</title>

    <!-- Bootstrap -->
    <link href="assets/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/font-awesome/css/font-awesome.min.css">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>


<BODY>
<div class= "central">
    <div class = "heading">
        <h2>Generic DSpace import structure creation converting CSV</h2>
        <hr/>
    </div>

    <?php
        ini_set('max_execution_time', 1800);
        echo '<div class = "box">';

        $error = '';
        $docbase = '/Users/srenton1/Projects/lddutilities/';
        $infile = $docbase.'/files/input.csv';
        $infile_open = fopen($infile, "r") or die ("can't open in file");
        $mappingfile = $docbase.'/files/mappingCSV.txt';
        $file_handle_map_in = fopen($mappingfile, "r") or die ("can't open mapping file");
        $dublincorefile = 'dublin_core.xml';
        $contentsfile = 'contents';
        $logfile = $docbase.'/files/csv_output.txt';
        $file_handle_log_out = fopen($logfile, "a+")or die("<p>Sorry. I can't open the logfile.</p>");
        $photodirectory =  '/Users/srenton1/Projects/theses/';
        $delimiter = ",";
        $framer = '"';
        $header = null;
        $data = array();
        $headerarray = array();
        $failed_images = 0;
        $processed_images = 0;
        $c = 0;
        $k = 0;
        $dodgy = 0;
        while (!feof($file_handle_map_in)) {
            $line = fgets($file_handle_map_in);
            $map = explode(":", $line);
            $mapping[$k][0] = $map[0];
            $mapping[$k][1] = $map[1];
            $mapping[$k][2] = $map[2];
            $mapping[$k][3] = $map[3];
            $k++;
        }
        $line = '';
        $numcols = 0;
        $batchcount = 0;
        while ($line = fgetcsv($infile_open))
        {
            // count($line) is the number of columns
            $numcols = count($line);
        }
        fclose ($infile_open);
        $file = file_get_contents($infile);
        $data = array_map("str_getcsv", preg_split('/\r*\n+|\r+/', $file));
        $directory = $docbase.'/files/dspaceNew/';
        $nomatchfiles = 0;

        foreach ($data as $key=>$value)
        {
           if ($key == 0)
           {
               for ($i=0; $i < $numcols; $i++)
               {
                   $headerarray[$i] = $value[$i];
               }
           }
           else
           {

                $subfolder = str_pad($directory.$key,5,"0");
                if (!(file_exists($subfolder)))
                {
                    mkdir($subfolder);
                    chmod ($subfolder, 0777);
                    $file_handle_dc_out = fopen($subfolder.'/'.$dublincorefile, "w")or die("can't open dc outfile");
                    $file_handle_contents_out = fopen($subfolder.'/'.$contentsfile, "w")or die("can't open contents outfile");
                    fwrite($file_handle_dc_out,"<?xml version=\"1.0\" encoding=\"UTF-8\"?> \n");
                    fwrite($file_handle_dc_out,"<dublin_core>\n");
                }

                $j = 0;
                for ($j = 0; $j<$numcols; $j ++)
                {
                    $pos = strpos($headerarray[$j],'file');
                    if ($pos !== false)
                    {
                        $photono = $value[$j];
                        $matchedname = false;

                        fwrite($file_handle_log_out, "Bitstream: ".$photono."\n");

                        if (is_dir($photodirectory))
                        {
                            if ($dh = opendir($photodirectory))
                            {
                                while (($file = readdir($dh)) !== false)
                                {
                                   // echo $photono."versus".$file."<br>";
                                    if (strtoupper($file) == strtoupper($photono))
                                    {
                                        $matchedname = true;
                                        $filepath = $photodirectory.$file;
                                        $copypath = $subfolder.'/'.$file;
                                        if (!copy($filepath, $copypath))
                                        {
                                            echo "Failed to copy ".$filepath."<br>";
                                            fwrite($file_handle_log_out, "Failed: ".$photono."\n");
                                            $failed_images++;
                                        }
                                        else
                                        {
                                            echo 'Bitstream processed'. $filepath."<br>";
                                            fwrite($file_handle_contents_out, $file."\n");
                                            echo 'Check contents file for '.$file;
                                            fwrite($file_handle_log_out, "Processed: ".$photono."\n");
                                            $processed_images++;
                                        }

                                    }
                                }
                            }
                        }
                        if (!$matchedname)
                        {
                            if ($photono != '') {
                                echo $photono . " did not have a corresponding pdf<br>";
                                fwrite($file_handle_log_out, $photono . " did not have a corresponding pdf\n");
                                $nomatchfiles++;
                            }
                        }
                    } 
                    else
                    {
                    	$item = special_chars($value[$j]);

                        if( $mapping[$j][3] == "noqual")
                        {
                            
                            $qualifier = "";
                        }
                        else
                        {
                        	$qualifier = $mapping[$j][3];
                        }
                        fwrite($file_handle_log_out, "KEY: dc.".$mapping[$j][2].'.'.$qualifier." VALUE: ".$item."\n");
                        if ($headerarray[$j] == $mapping[$j][0]) {
                            $outline = '<' . $mapping[$j][1] . 'value element = "' . $mapping[$j][2] . '" qualifier = "' . $qualifier . '">' . $item . "</dcvalue>\n";
                            fwrite($file_handle_dc_out, $outline);
                        }  
                    } 
                }
                fwrite($file_handle_dc_out, '</dublin_core>');
               fwrite($file_handle_log_out, "<br>");
                fclose($file_handle_dc_out);
                fclose($file_handle_contents_out);
               if ($j < $numcols)
               {
                   $dodgy++;
               }
            }
        }
    echo '<h2>UNMATCHED FILENAMES: '.$nomatchfiles.'</h2>';
    fwrite($file_handle_log_out, 'UNMATCHED FILENAMES: '.$nomatchfiles."\n");
    echo '<h2>FAILED BITSTREAMS: '.$failed_images.'</h2>';
    fwrite($file_handle_log_out, "FAILED BITSTREAMS: ".$failed_images."\n");
    echo '<h2>PROCESSED BITSTREAMS: '.$processed_images.'</h2>';
    fwrite($file_handle_log_out, "PROCESSED BITSTREAMS: ".$processed_images."\n\n");
    echo '<h2>DODGY ROWS: '.$dodgy.'</h2>';
    fwrite($file_handle_log_out, "CSV ROWS: ".$j."\n\n");

    if ($dodgy == 0)
    {
        echo '<h2>CLEAN LOAD!</h2>';
    }
    else{
        echo '<h2>WE HAVE DODGY ROWS. RERUN.</h2>';
    }
    fclose($file_handle_in);

    function special_chars($item)
    {
            $item = html_entity_decode($item,ENT_QUOTES, 'UTF-8');
            $item = str_replace('|', '', $item);
            $item = str_replace('@I{', '', $item);
            $item = str_replace('@T{', '', $item);
            $item=str_replace('#','&#35;', $item);
            $item=str_replace('&','&#38;', $item);
            $item=str_replace('\'','&#39;', $item);
            $item=str_replace('’','&#39;', $item);
            $item=str_replace('`','&#39;', $item);
            $item=str_replace('‘','&#39;', $item);
            $item = str_replace('ƒ', '&#131;', $item);
            $item = str_replace('…', '&#133;', $item);
            $item = str_replace('†', '&#134;', $item);
            $item = str_replace('‡', '&#135;', $item);
            $item = str_replace('ˆ', '&#136;', $item);
            $item = str_replace('‰', '&#137;', $item);
            $item = str_replace('Š', '&#138;', $item);
            $item = str_replace('Œ', '&#140;', $item);
            $item = str_replace('Ž', '&#142;', $item);
            $item = str_replace('™', '&#153;', $item);
            $item = str_replace('š', '&#154;', $item);
            $item = str_replace('œ', '&#156;', $item);
            $item = str_replace('ž ', '&#158;', $item);
            $item = str_replace('Ÿ', '&#159;', $item);
            $item = str_replace('¡', '&#161;', $item);
            $item = str_replace('¢', '&#162;', $item);
            $item = str_replace('£', '&#163;', $item);
            $item = str_replace('¤', '&#164;', $item);
            $item = str_replace('¥', '&#165;', $item);
            $item = str_replace('¦', '&#166;', $item);
            $item = str_replace('§', '&#167;', $item);
            $item = str_replace('¨', '&#168;', $item);
            $item = str_replace('©', '&#169;', $item);
            $item = str_replace('ª', '&#170;', $item);
            $item = str_replace('«', '&#171;', $item);
            $item = str_replace('¬', '&#172;', $item);
            $item = str_replace('­', '&#173;', $item);
            $item = str_replace('®', '&#174;', $item);
            $item = str_replace('¯', '&#175;', $item);
            $item = str_replace('°', '&#176;', $item);
            $item = str_replace('±', '&#177;', $item);
            $item = str_replace('²', '&#178;', $item);
            $item = str_replace('³', '&#179;', $item);
            $item = str_replace('´', '&#180;', $item);
            $item = str_replace('µ', '&#181;', $item);
            $item = str_replace('¶', '&#182;', $item);
            $item = str_replace('·', '&#183;', $item);
            $item = str_replace('¸', '&#184;', $item);
            $item = str_replace('¹', '&#185;', $item);
            $item = str_replace('º', '&#186;', $item);
            $item = str_replace('»', '&#187;', $item);
            $item = str_replace('¼', '&#188;', $item);
            $item = str_replace('½', '&#189;', $item);
            $item = str_replace('¾', '&#190;', $item);
            $item = str_replace('¿', '&#191;', $item);
            $item = str_replace('À', '&#192;', $item);
            $item = str_replace('Á', '&#193;', $item);
            $item = str_replace('Â', '&#194;', $item);
            $item = str_replace('Ã', '&#195;', $item);
            $item = str_replace('Ä', '&#196;', $item);
            $item = str_replace('Å', '&#197;', $item);
            $item = str_replace('Æ', '&#198;', $item);
            $item = str_replace('Ç', '&#199;', $item);
            $item = str_replace('È', '&#200;', $item);
            $item = str_replace('É', '&#201;', $item);
            $item = str_replace('Ë', '&#203;', $item);
            $item = str_replace('Ì', '&#204;', $item);
            $item = str_replace('Í', '&#205;', $item);
            $item = str_replace('Î', '&#206;', $item);
            $item = str_replace('Ï', '&#207;', $item);
            $item = str_replace('Ð', '&#208;', $item);
            $item = str_replace('Ñ', '&#209;', $item);
            $item = str_replace('Ò', '&#210;', $item);
            $item = str_replace('Ó', '&#211;', $item);
            $item = str_replace('Ô', '&#212;', $item);
            $item = str_replace('Õ', '&#213;', $item);
            $item = str_replace('Ö', '&#214;', $item);
            $item = str_replace('×', '&#215;', $item);
            $item = str_replace('Ø', '&#216;', $item);
            $item = str_replace('Ù', '&#217;', $item);
            $item = str_replace('Ú', '&#218;', $item);
            $item = str_replace('Û', '&#219;', $item);
            $item = str_replace('Ü', '&#220;', $item);
            $item = str_replace('Ý', '&#221;', $item);
            $item = str_replace('Þ', '&#222;', $item);
            $item = str_replace('ß', '&#223;', $item);
            $item = str_replace('à', '&#224;', $item);
            $item = str_replace('á', '&#225;', $item);
            $item = str_replace('â', '&#226;', $item);
            $item = str_replace('ã', '&#227;', $item);
            $item = str_replace('ä', '&#228;', $item);
            $item = str_replace('å', '&#229;', $item);
            $item = str_replace('æ', '&#230;', $item);
            $item = str_replace('è', '&#232;', $item);
            $item = str_replace('é', '&#233;', $item);
            $item = str_replace('ê', '&#234;', $item);
            $item = str_replace('ë', '&#235;', $item);
            $item = str_replace('ì', '&#236;', $item);
            $item = str_replace('í', '&#237;', $item);
            $item = str_replace('î', '&#238;', $item);
            $item = str_replace('ï', '&#239;', $item);
            $item = str_replace('ð', '&#240;', $item);
            $item = str_replace('ñ', '&#241;', $item);
            $item = str_replace('ò', '&#242;', $item);
            $item = str_replace('ó', '&#243;', $item);
            $item = str_replace('ô', '&#244;', $item);
            $item = str_replace('õ', '&#245;', $item);
            $item = str_replace('ö', '&#246;', $item);
            $item = str_replace('÷', '&#247;', $item);
            $item = str_replace('ø', '&#248;', $item);
            $item = str_replace('ù', '&#249;', $item);
            $item = str_replace('ú', '&#250;', $item);
            $item = str_replace('û', '&#251;', $item);
            $item = str_replace('ü', '&#252;', $item);
            $item = str_replace('ý', '&#253;', $item);
            $item = str_replace('þ', '&#254;', $item);
            $item=str_replace('$','&#36;', $item);
            $item=str_replace('%','&#37;', $item);
            $item=str_replace('+','&#43;', $item);
            $item=str_replace('<','&#60;', $item);
            $item=str_replace('=','&#61;', $item);
            $item=str_replace('>','&#62;', $item);
            $item=str_replace('?','&#63;', $item);
            $item=str_replace('@','&#64;', $item);
            $item=str_replace('[','&#91;', $item);
            $item=str_replace('\\','&#92;', $item);
            $item=str_replace(']','&#93;', $item);
            $item=str_replace('^','&#94;', $item);
            $item=str_replace('_','&#95;', $item);
            $item=str_replace('`','&#96;', $item);
            $item=str_replace('{','&#123;', $item);
            $item=str_replace('|','&#124;', $item);
            $item=str_replace('}','&#125;', $item);
            $item=str_replace('~','&#126;', $item);
            $item=str_replace('₀','&#8320;', $item);
            $item=str_replace('₁','&#8321;', $item);
            $item=str_replace('₂','&#8322;', $item);
            $item=str_replace('₃','&#8323;', $item);
            $item=str_replace('₄','&#8324;', $item);
            $item=str_replace('₅','&#8325;', $item);
            $item=str_replace('₆','&#8326;', $item);
            $item=str_replace('₇','&#8327;', $item);
            $item=str_replace('₈','&#8328;', $item);
            $item=str_replace('₉','&#8329;', $item);
            $item=str_replace('⁴','&#8308;', $item);
            $item=str_replace('⁵','&#8309;', $item);
            $item=str_replace('⁶','&#8310;', $item);
            $item=str_replace('⁷','&#8311;', $item);
            $item=str_replace('⁸','&#8312;', $item);
            $item=str_replace('⁹','&#8313;', $item);
            $item = str_replace('♭', '&#9837;', $item);
            $item = str_replace('♯', '&#9839;', $item);
            $item = str_replace('♮', '&#9838;', $item);

            return $item;

    }
?>


