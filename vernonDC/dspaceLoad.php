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
        <h2>GENERIC VERNON TO DSPACE LOAD</h2>
        <hr/>
    </div>
    <div>
        <form method="post" action="dspaceLoad.php">
            <table class="tab_standard">
                <tr>
                    <td>Collection Loading:<span class= "mandatory"><br>&nbsp;(required if new image)</span></td>

                    <td><input type= "text"  NAME="collection"/></td>
                    <td><input type= "text"  NAME="part"/></td>

                </tr>
                <tr>
                    <td><input type = "submit" name = "sendDetails" value = "send" />
                </tr>
                </table>
        </form>
    </div>
    <?php
    ini_set('max_execution_time', 400);
    if (isset($_POST['sendDetails']))
    {
        $collection = $_POST['collection'];
        $part = 'part'.$_POST['part'];
        echo '<div class = "box">';

        $error = '';

        $docbase = '/Users/srenton1/Projects/lddutilities/vernonDC/';
        $infile = $docbase.'/files/'.$collection.'fordspace'.$part.'.xml';

        $dublincorefile = 'dublin_core.xml';
        $contentsfile = 'contents';
        $logfile = $docbase.'/files/image_output.txt';
        $file_handle_in = fopen($infile, "r")or die("can't open infile");
        //$photodirectory =  $docbase.'/dspaceImages/'.$collection.'/';
        $photodirectory = '/Users/srenton1/Projects/IMAGES/';
        //$photodirectory = '/Volumes/Vernon/Wincoll/IMAGES/';

        $imagedirectory =  $docbase.'/dspaceImagesNonStandard/';

        $update_file =  $docbase.'/files/'.$collection.'mapfile.txt';
        echo $update_file.'<br>';

        $file_handle_log_out = fopen($logfile, "a+")or die("can't open this outfile");
        $directory = $docbase.'/files/'.$collection.'dspaceNew/';
        echo $directory.'<br>';
        mkdir($directory);
        $update_directory = $docbase.'/files/'.$collection.'dspaceExisting/';
        echo $update_directory.'<br>';
        mkdir($directory);
        $mappingfile = $docbase.'/files/mapping.txt';
        $file_handle_map_in = fopen($mappingfile, "r") or die ("can't open mapping file");
        $okimagesfile =$docbase.'/files/'.$collection.'okimages.txt';
        $folder_name = 0;
        $delimiter=',';
        $mapping = array();
        $header = null;
        $failed_images = 0;
        $processed_images = 0;
        $xml=simplexml_load_file($infile);

        $i=0;
        while (!feof($file_handle_map_in))
        {
            $line = fgets($file_handle_map_in);
            $map = explode(":",$line);
            $mapping[$i][0]=$map[0];
            $mapping[$i][1]= $map[1];
            $mapping[$i][2]= $map[2];
            $mapping[$i][3]= $map[3];
            $i++;
        }
        fclose($file_handle_map_in);

        foreach($xml->children() as $object)
        {
            $update = false;
            $subfolder = '';

            foreach($object-> children() as $item)
            {
                $tag = $item->getName();
                echo 'TAG'.$tag;
                if ($tag != 'accession_no' and $tag != 'av' and $tag != 'av_primary_image')
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
                }

                if ($tag == 'accession_no')
                {
                    $item = str_replace('/', '-', $item);
                    echo 'ACC NO'.$item;
                    if (substr($item,0,1) == 'L')
                    {
                        $strlen = strlen($item);
                        $item = substr($item, 2,($strlen - 2));
                    }
                }

                if ($tag == 'dc_prod_pri_date_earliest_being')
                {
                    $item = substr($item,7,4);
                }

                if ($tag == 'dc_prod_pri_date_latest_being')
                {
                    $item = substr($item,7,4);
                }


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
                           echo 'UPFILE'.$update_file.'<br>';
                           $file_handle_upd_in = fopen($update_file, "r")or die("can't open upfile");
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
                       echo 'SUBFOLDER'.$subfolder;


                       if (!(file_exists($subfolder)))
                       {
                           echo 'In here';
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
                           $photofolder = substr($item,$photofolderpos, 15)."/";

                           $okphoto = false;
                           $foundit = '';
                           $photono = substr($item, $imagenamepos,17);
                           echo 'PHOTONO'.$photono.'<br>';

                           $type = substr($photono,7, 1);

                           if (strpos($photono,'-') == false) {
                               $photono = substr($photono, 0, 12);
                               echo 'PHOTONONOW'.$photono.'<br>';
                           }

                           if (strpos($photono, '.web') != false)
                           {
                               $photono = $photono."m";
                               echo 'WEBM'.$photono.'<br>';
                           }

                           if ($collection == 'art')
                           {

                               $pfile = $photodirectory.$photofolder;
                               $photopath=$photofolder.$photono;
                               $file_handle_images_in = fopen($okimagesfile, "r") or die ("can't open ok image file");
                               while (!feof($file_handle_images_in))
                               {
                                   $foundit = false;
                                   $line = fgets($file_handle_images_in);
                                   $line = str_replace("\\","/",$line);
                                   $foundit = strpos($line,$photopath);
                                   if ($foundit !== false)
                                   {
                                       $okphoto = true;
                                       if (is_dir($pfile))
                                       {
                                           if ($dh = opendir($pfile))
                                           {
                                               while (($file = readdir($dh)) !== false)
                                               {

                                                   if ($file == $photono)
                                                   {
                                                       $filepath = $pfile.$photono;
                                                       $copypath = $subfolder.'/'.$file;
                                                       if (!copy($filepath, $copypath))
                                                       {
                                                           echo "failed to copy $filepath...\n";
                                                           $failed_images++;

                                                       }
                                                       else
                                                       {
                                                           echo 'Processed Image'.$filepath;
                                                           fwrite($file_handle_contents_out, $file."\n");
                                                           $processed_images++;
                                                       }
                                                   }
                                               }
                                           }
                                           closedir($dh);
                                       }
                                       else{
                                           echo 'I cannot get into '.$pfile;
                                       }
                                   }
                               }
                           }
                           else
                           {
                               $pfile = $photodirectory.$photofolder;

                               if (is_dir($pfile))
                               {
                                   if ($dh = opendir($pfile))
                                   {
                                       while (($file = readdir($dh)) !== false)
                                       {

                                           if ($file == $photono)
                                           {
                                               $filepath = $pfile.$photono;
                                               $copypath = $subfolder.'/'.$file;
                                               if (!copy($filepath, $copypath))
                                               {
                                                   echo "failed to copy $filepath...\n";
                                                   $failed_images++;

                                               }
                                               else
                                               {
                                                   echo 'Processed Image'.$filepath;
                                                   fwrite($file_handle_contents_out, $file."\n");
                                                   $processed_images++;
                                               }
                                           }
                                       }
                                   }
                                   closedir($dh);
                               }
                               else{
                                   echo 'I cannot get into '.$pfile;
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
                           fwrite($file_handle_dc_out, '</dublin_core>');
                           fclose($file_handle_dc_out);
                           fclose($file_handle_contents_out);
                           $folder_name++;
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
                               if ($tag == 'user_sym_51')
                               {
                                   if (strpos($item, 'ttp' ) != false)
                                   {
                                       $outline = '<'.$mdtype.'value element = "'.$mdfield.'" qualifier = "'.$mappingrow[3].'">'.$item."</dcvalue>\n";
                                   }
                               }
                               else
                               {
                                 echo 'setting outline qualified<br>';
                                 $outline = '<'.$mdtype.'value element = "'.$mdfield.'" qualifier = "'.$mappingrow[3].'">'.$item."</dcvalue>\n";
                               }
                           }
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
        fclose($file_handle_in);
        fclose($file_handle_log_out);
    }
?>


