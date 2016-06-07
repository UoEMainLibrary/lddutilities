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
        <h2>WORD TO DSPACE LOAD FOR MARJORY KENNEDY FRASER RECORDINGS</h2>
        <hr/>
    </div>
    <?php

        ini_set('track_errors',1);
        echo '<div class = "box">';

        ini_set('default_charset', 'utf-8');
        #DIU Numbers
        #Scott Renton, 02/08/2013
        include 'vars.php';
        $error = '';

        $docbase = '/Users/srenton1/Projects/vernonDC';
        $infile = $docbase.'/files/mjf.txt';
        //$infile = $docbase.'/euchmi/files/test.xml';
        $dublincorefile = 'dublin_core.xml';
        $contentsfile = 'contents';
        $logfile = $docbase.'/files/flat_output.txt';
        echo $logfile;
        //$file_handle_in = fopen($infile, "r")or die("can't open infile");
        $photodirectory =  $docbase.'/frasermp3/';
       // $imagedirectory =  $docbase.'/euchmi/dspaceImagesNonStandard/';
        //$update_file =  $docbase.'/euchmi/files/'.$collection.'mapfile.txt';
        echo $update_file.'<br>';

        $file_handle_log_out = fopen($logfile, "a+")or die("can't open this outfile");
        $directory = $docbase.'/files/mkfdspaceNew/';
        echo $directory.'<br>';
        mkdir($directory);
        //$update_directory = $docbase.'/files/'.$collection.'dspaceExisting/';
        //echo $update_directory.'<br>';
        //mkdir($directory);
        $mappingfile = $docbase.'/files/mp3map.txt';


        //$okimagesfile =$docbase.'/euchmi/files/'.$collection.'okimages.txt';
        //echo $okimagesfile.'<br>';

        $folder_name = 0;
        $delimiter=',';

        $mapping = array();
        $header = null;

        $failed_images = 0;
        $processed_images = 0;

        $i = 0;
        $file_handle_in = fopen($infile, "r") or die ("can't open input file");
        while (!feof($file_handle_in))
        {

            $line = fgets($file_handle_in);
            echo 'LINE before '.$line.'<br>';
            $line = html_entity_decode($line,ENT_QUOTES, 'UTF-8');
            $line = str_replace('|', '', $line);
            $line = str_replace('@I{', '', $line);
            $line = str_replace('@T{', '', $line);
            $line=str_replace('#','&#35;', $line);
            $line=str_replace('&','&#38;', $line);
            $line=str_replace('\'','&#39;', $line);
            $line=str_replace('’','&#39;', $line);
            $line=str_replace('`','&#39;', $line);
            $line=str_replace('‘','&#39;', $line);
            $line = str_replace('ƒ', '&#131;', $line);
            $line = str_replace('…', '&#133;', $line);
            $line = str_replace('†', '&#134;', $line);
            $line = str_replace('‡', '&#135;', $line);
            $line = str_replace('ˆ', '&#136;', $line);
            $line = str_replace('‰', '&#137;', $line);
            $line = str_replace('Š', '&#138;', $line);
            $line = str_replace('Œ', '&#140;', $line);
            $line = str_replace('Ž', '&#142;', $line);
            $line = str_replace('™', '&#153;', $line);
            $line = str_replace('š', '&#154;', $line);
            $line = str_replace('œ', '&#156;', $line);
            $line = str_replace('ž ', '&#158;', $line);
            $line = str_replace('Ÿ', '&#159;', $line);
            $line = str_replace('¡', '&#161;', $line);
            $line = str_replace('¢', '&#162;', $line);
            $line = str_replace('£', '&#163;', $line);
            $line = str_replace('¤', '&#164;', $line);
            $line = str_replace('¥', '&#165;', $line);
            $line = str_replace('¦', '&#166;', $line);
            $line = str_replace('§', '&#167;', $line);
            $line = str_replace('¨', '&#168;', $line);
            $line = str_replace('©', '&#169;', $line);
            $line = str_replace('ª', '&#170;', $line);
            $line = str_replace('«', '&#171;', $line);
            $line = str_replace('¬', '&#172;', $line);
            $line = str_replace('­', '&#173;', $line);
            $line = str_replace('®', '&#174;', $line);
            $line = str_replace('¯', '&#175;', $line);
            $line = str_replace('°', '&#176;', $line);
            $line = str_replace('±', '&#177;', $line);
            $line = str_replace('²', '&#178;', $line);
            $line = str_replace('³', '&#179;', $line);
            $line = str_replace('´', '&#180;', $line);
            $line = str_replace('µ', '&#181;', $line);
            $line = str_replace('¶', '&#182;', $line);
            $line = str_replace('·', '&#183;', $line);
            $line = str_replace('¸', '&#184;', $line);
            $line = str_replace('¹', '&#185;', $line);
            $line = str_replace('º', '&#186;', $line);
            $line = str_replace('»', '&#187;', $line);
            $line = str_replace('¼', '&#188;', $line);
            $line = str_replace('½', '&#189;', $line);
            $line = str_replace('¾', '&#190;', $line);
            $line = str_replace('¿', '&#191;', $line);
            $line = str_replace('À', '&#192;', $line);
            $line = str_replace('Á', '&#193;', $line);
            $line = str_replace('Â', '&#194;', $line);
            $line = str_replace('Ã', '&#195;', $line);
            $line = str_replace('Ä', '&#196;', $line);
            $line = str_replace('Å', '&#197;', $line);
            $line = str_replace('Æ', '&#198;', $line);
            $line = str_replace('Ç', '&#199;', $line);
            $line = str_replace('È', '&#200;', $line);
            $line = str_replace('É', '&#201;', $line);
            $line = str_replace('Ë', '&#203;', $line);
            $line = str_replace('Ì', '&#204;', $line);
            $line = str_replace('Í', '&#205;', $line);
            $line = str_replace('Î', '&#206;', $line);
            $line = str_replace('Ï', '&#207;', $line);
            $line = str_replace('Ð', '&#208;', $line);
            $line = str_replace('Ñ', '&#209;', $line);
            $line = str_replace('Ò', '&#210;', $line);
            $line = str_replace('Ó', '&#211;', $line);
            $line = str_replace('Ô', '&#212;', $line);
            $line = str_replace('Õ', '&#213;', $line);
            $line = str_replace('Ö', '&#214;', $line);
            $line = str_replace('×', '&#215;', $line);
            $line = str_replace('Ø', '&#216;', $line);
            $line = str_replace('Ù', '&#217;', $line);
            $line = str_replace('Ú', '&#218;', $line);
            $line = str_replace('Û', '&#219;', $line);
            $line = str_replace('Ü', '&#220;', $line);
            $line = str_replace('Ý', '&#221;', $line);
            $line = str_replace('Þ', '&#222;', $line);
            $line = str_replace('ß', '&#223;', $line);
            $line = str_replace('à', '&#224;', $line);
            $line = str_replace('á', '&#225;', $line);
            $line = str_replace('â', '&#226;', $line);
            $line = str_replace('ã', '&#227;', $line);
            $line = str_replace('ä', '&#228;', $line);
            $line = str_replace('å', '&#229;', $line);
            $line = str_replace('æ', '&#230;', $line);
            $line = str_replace('è', '&#232;', $line);
            $line = str_replace('é', '&#233;', $line);
            $line = str_replace('ê', '&#234;', $line);
            $line = str_replace('ë', '&#235;', $line);
            $line = str_replace('ì', '&#236;', $line);
            $line = str_replace('í', '&#237;', $line);
            $line = str_replace('î', '&#238;', $line);
            $line = str_replace('ï', '&#239;', $line);
            $line = str_replace('ð', '&#240;', $line);
            $line = str_replace('ñ', '&#241;', $line);
            $line = str_replace('ò', '&#242;', $line);
            $line = str_replace('ó', '&#243;', $line);
            $line = str_replace('ô', '&#244;', $line);
            $line = str_replace('õ', '&#245;', $line);
            $line = str_replace('ö', '&#246;', $line);
            $line = str_replace('÷', '&#247;', $line);
            $line = str_replace('ø', '&#248;', $line);
            $line = str_replace('ù', '&#249;', $line);
            $line = str_replace('ú', '&#250;', $line);
            $line = str_replace('û', '&#251;', $line);
            $line = str_replace('ü', '&#252;', $line);
            $line = str_replace('ý', '&#253;', $line);
            $line = str_replace('þ', '&#254;', $line);
            $line=str_replace('$','&#36;', $line);
            $line=str_replace('%','&#37;', $line);
            $line=str_replace('+','&#43;', $line);
            $line=str_replace('<','&#60;', $line);
            $line=str_replace('=','&#61;', $line);
            $line=str_replace('>','&#62;', $line);
            $line=str_replace('?','&#63;', $line);
            $line=str_replace('@','&#64;', $line);
            $line=str_replace('[','&#91;', $line);
            $line=str_replace('\\','&#92;', $line);
            $line=str_replace(']','&#93;', $line);
            $line=str_replace('^','&#94;', $line);
            $line=str_replace('_','&#95;', $line);
            $line=str_replace('`','&#96;', $line);
            $line=str_replace('{','&#123;', $line);
            $line=str_replace('|','&#124;', $line);
            $line=str_replace('}','&#125;', $line);
            $line=str_replace('~','&#126;', $line);
            $line=str_replace('₀','&#8320;', $line);
            $line=str_replace('₁','&#8321;', $line);
            $line=str_replace('₂','&#8322;', $line);
            $line=str_replace('₃','&#8323;', $line);
            $line=str_replace('₄','&#8324;', $line);
            $line=str_replace('₅','&#8325;', $line);
            $line=str_replace('₆','&#8326;', $line);
            $line=str_replace('₇','&#8327;', $line);
            $line=str_replace('₈','&#8328;', $line);
            $line=str_replace('₉','&#8329;', $line);
            $line=str_replace('⁴','&#8308;', $line);
            $line=str_replace('⁵','&#8309;', $line);
            $line=str_replace('⁶','&#8310;', $line);
            $line=str_replace('⁷','&#8311;', $line);
            $line=str_replace('⁸','&#8312;', $line);
            $line=str_replace('⁹','&#8313;', $line);
            $line = str_replace('♭', '&#9837;', $line);
            $line = str_replace('♯', '&#9839;', $line);
            $line = str_replace('♮', '&#9838;', $line);

            echo 'LINE after'.$line.'<br>';

            if (is_numeric(substr($line,0,1)) )
            {
                if (strpos($line, "\tKennedy-Fraser Recordings ") !== false)
                {
                    if ($started == true)
                    {
                        if ($comment !== null)
                        {
                            str_replace ($comment,"\t", "");
                            $outline = "<dcvalue element = \"description\" qualifier = \"abstract\">".$comment."</dcvalue>\n";
                            fwrite($file_handle_dc_out,$outline);
                        }

                        if ($description !== null)
                        {
                            str_replace ($description,"\t", "");
                            $outline = "<dcvalue element = \"description\" qualifier = \"\">".$description."</dcvalue>\n";
                            fwrite($file_handle_dc_out,$outline);
                        }
                        fwrite($file_handle_dc_out, '</dublin_core>');
                        fclose($file_handle_dc_out);
                        fclose($file_handle_contents_out);
                    }

                    $line_array = explode("\t",$line);
                    foreach ($line_array as $line_bit)
                    {
                        echo 'LINE BIT'.$line_bit;
                    }
                    $i = 0;
                    $commentline = 999;
                    $started = true;
                    $collection = 'Kennedy-Fraser Recordings';
                    $first_space =strpos($line, $collection);
                    $item_no = substr($line, 0, $first_space - 1);
                    $folder_name = $item_no;
                    $subfolder = $directory.$folder_name;
                    echo $subfolder.'<br>';
                    mkdir($subfolder);
                    chmod ($subfolder, 0777);
                    $file_handle_dc_out = fopen($subfolder.'/'.$dublincorefile, "w")or die("can't open dc outfile");
                    $file_handle_contents_out = fopen($subfolder.'/'.$contentsfile, "w")or die("can't open contents outfile");
                    fwrite($file_handle_dc_out,"<?xml version=\"1.0\" encoding=\"UTF-8\"?> \n");
                    fwrite($file_handle_dc_out,"<dublin_core>\n");
                    $outline = "<dcvalue element = \"identifier\" qualifier = \"\">".$item_no."</dcvalue>\n";
                    fwrite($file_handle_dc_out,$outline);
                    $outline = "<dcvalue element = \"relation\" qualifier = \"ispartof\">".$collection."</dcvalue>\n";
                    fwrite($file_handle_dc_out,$outline);
                    $collection_pos = strpos($line, $collection);
                    $rest_line = substr($line, $collection_pos + 26);
                    $box_pos = strpos($rest_line, "Box");
                    $sub_coll = substr($rest_line, 0, $box_pos);
                    $box_line = substr($rest_line, $box_pos);
                    $box_number_pos = strpos($box_line," ");
                    $box_number_line = substr($box_line, $box_number_pos + 1);
                    $box_post_space = strpos($box_number_line,"\t");


                    if ($box_post_space == true)
                    {
                        $box_number_array = explode("\t",$box_number_line, 2);
                        $box_number = 'Box '.$box_number_array[0];
                        $description = substr($box_number_line,$box_post_space + 1);


                    }
                    else
                    {
                        $box_number = 'Box '.$box_number_line;
                        $description = '';
                    }

                    $outline = "<dcvalue element = \"relation\" qualifier = \"subpartof\">".$sub_coll."</dcvalue>\n";
                    fwrite($file_handle_dc_out,$outline);
                    $outline = "<dcvalue element = \"relation\" qualifier = \"boxpartof\">".$box_number."</dcvalue>\n";
                    fwrite($file_handle_dc_out,$outline);
                }
            }
            else if($started)
            {

                        if (strpos($line, "DATE: ") !== false)
                        {
                            $str_pos = strpos($line, "DATE: ") + strlen("DATE: ");
                            $bit = rtrim(substr($line,$str_pos));
                            echo 'DATE'.$bit.'<br>';
                            $outline = "<dcvalue element = \"coverage\" qualifier = \"temporal\">".$bit."</dcvalue>\n";
                            fwrite($file_handle_dc_out,$outline);
                        }
                        elseif (strpos($line, "CYLINDER CAT NO: ") !== false)
                        {
                            $str_pos = strpos($line, "CYLINDER CAT NO: ") + strlen("CYLINDER CAT NO: ");
                            $bit = rtrim(substr($line,$str_pos));
                            $compbit = str_replace(' ', '', $bit);
                            echo 'COMP BIT'.$compbit;
                            echo 'CYLINDER NO'.$bit.'<br>';
                            $outline = "<dcvalue element = \"title\" qualifier = \"\">".$bit."</dcvalue>\n";
                            fwrite($file_handle_dc_out,$outline);

                            $file_handle_map_in = fopen($mappingfile, "r") or die ("can't open mapping file");
                            while (!feof($file_handle_map_in))
                            {
                                $mapline = fgets($file_handle_map_in);
                                $compmapline = str_replace(' ', '',$mapline);
                                $pos = strpos($compmapline, $compbit.'|');
                                if ($pos  !== false)
                                {
                                    echo "found one".$compmapline;
                                    $mapline_array = explode("|",$compmapline);
                                    foreach ($mapline_array as $mapline_bit)
                                    {
                                        echo 'MAPLINE BIT'.$mapline_bit;
                                        $mp3 = rtrim($mapline_array[1]);
                                        echo 'MP3'.$mp3.'<br>';
                                    }

                                }

                            }

                            if (is_dir($photodirectory))
                            {
                                echo 'DIR'.$photodirectory;
                                if ($dh = opendir($photodirectory))
                                {
                                    echo 'in here';
                                    while (($file = readdir($dh)) !== false)
                                    {
                                        if ($file == $mp3)
                                        {
                                            $filepath = $photodirectory.$file;

                                            $copypath = $subfolder.'/'.$file;
                                            echo 'FILENOW'.$filepath;
                                            echo 'COPY PATH'.$copypath;
                                            if (file_exists($filepath)) {
                                                if (is_readable($filepath)) {
                                                    if (is_writeable(dirname($subfolder))) {
                                                        copy($filepath, $subfolder);
                                                    } else {
                                                        die('You dont have permission to write into '.dirname($subfolder));
                                                    }
                                                } else {
                                                    die('You dont have permission to read '.$filepath);
                                                }
                                            } else {
                                                die('File '.$filepath.' does not exist');
                                            }

                                            echo 'PATHS'.$file.$filepath.$copypath;
                                            if (!copy($filepath, $copypath))
                                            {
                                                echo "failed to copy $filepath...\n";
                                                print ("unable to copy: $php_errormsg");
                                                $failed_images++;
                                            }
                                            else
                                            {
                                                echo 'Are we in here? Why not?';
                                                fwrite($file_handle_contents_out, $file."\n");
                                                $processed_images++;
                                            }

                                        }
                                    }
                                }
                                closedir($dh);
                            }

                        }
                        elseif (strpos($line, "MANDREL SPEED: ") !== false)
                        {
                            $str_pos = strpos($line, "MANDREL SPEED: ") + strlen("MANDREL SPEED: ");
                            $bit = rtrim(substr($line,$str_pos));
                            echo 'MANDREL'.$bit.'<br>';
                            $outline = "<dcvalue element = \"format\" qualifier = \"extent\">".$bit."</dcvalue>\n";
                            fwrite($file_handle_dc_out,$outline);
                        }
                        elseif (strpos($line, "EQUALISATION: ") !== false)
                        {
                            $str_pos = strpos($line, "EQUALISATION: ") + strlen("EQUALISATION: ");
                            $bit = rtrim(substr($line,$str_pos));
                            str_replace ($bit,"\t", "");
                            echo 'EQUALISATION'.$bit.'<br>';
                            $outline = "<dcvalue element = \"format\" qualifier = \"extenteq\">".$bit."</dcvalue>\n";
                            fwrite($file_handle_dc_out,$outline);
                        }
                        elseif (strpos($line, "RADIUS COMPENSATION: ") !== false)
                        {
                            $str_pos = strpos($line, "RADIUS COMPENSATION: ") + strlen("RADIUS COMPENSATION: ");
                            $bit = rtrim(substr($line,$str_pos));
                            str_replace ($bit,"\t", "");
                            str_replace ($bit,"\n", "");
                            echo 'RADIUS COMPENSATION'.$bit.'<br>';
                            $outline = "<dcvalue element = \"format\" qualifier = \"extentradius\">".$bit."</dcvalue>\n";
                            fwrite($file_handle_dc_out,$outline);
                        }
                        elseif (strpos($line, "HPF SETTING (MICROSEC):\t") !== false)
                        {
                            $str_pos = strpos($line, "HPF SETTING (MICROSEC):\t") + strlen("HPF SETTING (MICROSEC):\t");
                            $bit = rtrim(substr($line,$str_pos));
                            str_replace ($bit,"\t", "");
                            str_replace ($bit," ", "");
                            echo 'HPF SETTING'.$bit.'<br>';
                            $outline = "<dcvalue element = \"format\" qualifier = \"\">".$bit."</dcvalue>\n";
                            fwrite($file_handle_dc_out,$outline);
                        }
                        elseif (strpos($line, "STYLUS: ") !== false)
                        {
                            $str_pos = strpos($line, "STYLUS: ") + strlen("STYLUS: ");
                            $bit = rtrim(substr($line,$str_pos));
                            echo 'STYLUS'.$bit.'<br>';
                            $outline = "<dcvalue element = \"format\" qualifier = \"extentstylus\">".$bit."</dcvalue>\n";
                            fwrite($file_handle_dc_out,$outline);
                        }
                        elseif (strpos($line, "COMMENTS:") !== false)
                        {
                            $str_pos = strpos($line, "COMMENTS:") + strlen("COMMENTS:");
                            $bit = ltrim(rtrim(substr($line,$str_pos)));
                            echo 'COMMENTS'.$bit.'<br>';
                            $commentline = $i;
                            echo 'COMMENT LINE NO'.$commentline.'<br>';
                            $comment = $bit;
                        }
                        else
                        {
                            if ($i > $commentline)
                            {
                                echo 'more ocmment'.$i.'<br>';
                                echo 'commentline'.$commentline.'<br>';
                                $comment .= ltrim($line);
                                echo 'COMMENT'.$comment.'<br>';
                            }
                            else
                            {
                                $description .= ltrim($line);
                                echo 'DESCRIPTION'.$description.'<br>';

                            }
                        }





            }
                $i++;



                /*
                foreach ($mapping as $mappingrow)
                {
                   $maptag = $mappingrow[0];
                   str_replace( "\n","", $maptag);
                   if ($tag == $maptag)
                   {
                       $mdtype = $mappingrow[1];
                       $mdfield = $mappingrow[2];
                       if ($mappingrow[3] != null)
                       {
                           $mdqualifier =$mappingrow[3];
                       }
                       else
                       {
                           $mdqualifier =null;
                       }

                       if ($tag == 'accession_no')
                       {
                           $foldername = $item;
                           $file_handle_upd_in = fopen($update_file, "r")or die("can't open infile");
                           while (!feof($file_handle_upd_in))
                           {
                               $line = fgets($file_handle_upd_in);
                               $found = strpos($line,$item);
                               if ($found !== false)
                               {
                                   $update = true;
                               }
                           }
                       }

                     echo 'FOLDER'.$foldername;
                       if ($update == true)
                       {
                            $subfolder = $update_directory.$foldername;
                       }
                       else
                       {
                           $subfolder = $directory.$foldername;
                       }


                       if (!(file_exists($subfolder)))
                       {
                           mkdir($subfolder);
                           chmod ($subfolder, 0777);
                           $file_handle_dc_out = fopen($subfolder.'/'.$dublincorefile, "w")or die("can't open dc outfile");
                           $file_handle_contents_out = fopen($subfolder.'/'.$contentsfile, "w")or die("can't open contents outfile");
                           fwrite($file_handle_dc_out,"<?xml version=\"1.0\" encoding=\"UTF-8\"?> \n");
                           fwrite($file_handle_dc_out,"<dublin_core>\n");
                       }

                       if ($tag == 'av')
                       {
                           echo 'AV'.$item;

                           $imagenamepos = strpos($item,'\00');
                           $imagenamepos++;
                           $photofolderpos = strpos($item, '; 00');
                           $photofolderpos = $photofolderpos+ 2;
                           $photofolder = substr($item,$photofolderpos, 16);

                           $okphoto = false;
                           $foundit = '';

                           $photono = substr($item, $imagenamepos,17);
                           $type = substr($photono,7, 1);


                           if (strpos($photono,'-') == false)
                           {
                               $photono = substr($photono, 0,12);
                           }

                           if (strpos($photono, '.web') != false)
                           {
                               $photono = $photono."m";
                               echo 'WEBM'.$photono.'<br>';
                           }


                           if ($collection == 'art')
                           {
                               $photopath=$photofolder.$photono;
                               echo 'PHOTOPATH'.$photopath.'<br>';
                               $file_handle_images_in = fopen($okimagesfile, "r") or die ("can't open ok image file");
                               while (!feof($file_handle_images_in))
                               {
                                   $foundit = false;
                                   $line = fgets($file_handle_images_in);
                                   $foundit = strpos($line,$photopath);
                                   echo 'FOOND'.$foundit.'<br>';
                                   if ($foundit !== false)
                                   {

                                       $okphoto = true;
                                       if (is_dir($photodirectory))
                                       {
                                           if ($dh = opendir($photodirectory))
                                           {
                                               while (($file = readdir($dh)) !== false)
                                               {

                                                   if ($file == $photono)
                                                   {
                                                       $filepath = $photodirectory.$file;

                                                       $copypath = $subfolder.'/'.$file;
                                                       echo 'PATHS'.$file.$filepath.$copypath;
                                                       if (!copy($filepath, $copypath))
                                                       {
                                                           echo "failed to copy $filepath...\n";
                                                           $failed_images++;
                                                       }
                                                       else
                                                       {
                                                           echo 'Are we in here? Why not?';
                                                           fwrite($file_handle_contents_out, $file."\n");
                                                          $processed_images++;
                                                       }

                                                   }
                                               }
                                           }
                                           closedir($dh);
                                       }
                                   }

                                }
                           }
                           else
                           {
                               if (is_dir($photodirectory))
                               {
                                   if ($dh = opendir($photodirectory))
                                   {
                                       while (($file = readdir($dh)) !== false)
                                       {

                                           if ($file == $photono)
                                           {
                                               $filepath = $photodirectory.$file;

                                               $copypath = $subfolder.'/'.$file;
                                               echo 'PATHS'.$file.$filepath.$copypath;
                                               if (!copy($filepath, $copypath))
                                               {
                                                   echo "failed to copy $filepath...\n";
                                                   $failed_images++;

                                               }
                                               else
                                               {
                                                   echo 'Are we in here? Why not?';
                                                   fwrite($file_handle_contents_out, $file."\n");
                                                   $processed_images++;
                                               }

                                           }
                                       }
                                   }
                                   closedir($dh);
                                  }
                           }
                           }


                       if ($tag == 'image')
                       {
                           $photolen = strlen($item);
                           echo 'IMAGE COMING IN'.$item.$photolen.'<br>';

                           if (substr($item,0,4) == 'EUCM')
                           {
                               $stoppos = strpos($item, ".");
                               $item = substr_replace($item, substr($item,0,$stoppos), "");
                               echo $item.'<br>';
                               $stoppos2 = strpos($item, ".");
                               $item = substr($item, 0, $stoppos2 -1);
                               echo $item.'<br>';
                           }


                           switch ($photolen)
                           {
                               case 4:
                                   break;
                               case 3:
                                   $item = '0'.$item;
                                   break;
                               case 2:
                                   $item = '00'.$item;
                                   break;
                               case 1:
                                   $item = '000'.$item;
                                   break;
                           }

                           echo 'FILEBEFORE'.$item.'<br>';

                           if (is_dir($imagedirectory))
                           {
                               if ($dh = opendir($imagedirectory))
                               {
                                   while (($file = readdir($dh)) !== false)
                                   {
                                       //echo 'COMP'.$file.$item.'<br>';
                                       if (strpos($file, $item) !== false)
                                       {
                                           echo 'FILE'.$file.'<br>';
                                           $filepath = $imagedirectory.$file;
                                           $copypath = $subfolder.'/'.$file;
                                           echo $filepath.$copypath.'<br>';
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


                       }

                       if ($tag != 'av' and $tag != 'image')
                       {

                           $outline = '';

                           if ($mappingrow[3] == 'noqual')
                           {
                               if ($tag !== 'object_type')
                               {
                                   echo 'setting non-typetag'.$tag.$collection.'<br>';
                                    $outline = '<'.$mdtype.'value element = "'.$mdfield.'" qualifier = "">'.$item."</dcvalue>\n";

                               }
                               else if ( $collection !== 'mimed')
                               {
                                   echo 'setting non-mimedcoll'.$tag.$collection.'<br>';
                                   $outline = '<'.$mdtype.'value element = "'.$mdfield.'" qualifier = "">'.$item."</dcvalue>\n";

                               }
                           }
                           else
                           {
                               echo 'setting outline qualified<br>';
                               $outline = '<'.$mdtype.'value element = "'.$mdfield.'" qualifier = "'.$mappingrow[3].'">'.$item."</dcvalue>\n";
                           }
                           echo 'OUT'.$outline.'<br>';

                           fwrite($file_handle_dc_out,$outline);
                       }


                   }


                }


            }

            fwrite($file_handle_dc_out, '</dublin_core>');
            fclose($file_handle_dc_out);
            fclose($file_handle_contents_out);
            $folder_name++;
        }
        echo 'FAILED IMAGES'.$failed_images;
        echo 'PROCESSED IMAGES'.$processed_images;
                */
        }

        fwrite($file_handle_dc_out, '</dublin_core>');
        fclose($file_handle_dc_out);
        fclose($file_handle_contents_out);
        fclose($file_handle_in);
        fclose($file_handle_log_out);
    
?>


