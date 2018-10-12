<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>LUNA API Authorisation Page</title>

    <!-- Bootstrap -->
    <link href="assets/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/font-awesome/css/font-awesome.min.css">


    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<?php
session_start();
ini_set('max_execution_time', 400);
parse_str($_SERVER['QUERY_STRING']);

# see http://php.net/manual/en/class.oauth.php

########## Change the following variables ################
$docbase = '/Users/srenton1/Projects/lddutilities/';
//Test vars
/*
$consumer_key = "uoeimagev4bP2";
$consumer_secret = "1PJxU6mTNQS4QhPcZh0nvuDOvy073G";
//PHP server test vars
//$consumer_key = "uoeimageqZy7x";
//$consumer_secret = "PLTTaXvb1AppVSMqGfQsVt1VPDvV44";


$server_address = "http://lac-luna-test2.is.ed.ac.uk:8181";
*/

//Live vars
$consumer_key = "uoeimageAPqoa";
$consumer_secret = "zcTbfbQEGc9qxCqux9HWlpL1hbWT6C";

//$server_address = "http://lac-luna-live4.is.ed.ac.uk:8181";
$server_address = "https://images.is.ed.ac.uk";
$working_dir = "http://localhost/lddutilities";

##########################################################

########## Callback URL #############

# A callback URL must be specified in LUNA for the registered application with the above
# consumer key. It should be in the form of documentroot/oauth.php?command=ready
# For example, if the address of this script is http://www.example.com/oauth.php, the 
# callback URL would be http://www.example.com/oauth.php?command=ready.

#####################################

if( $command == "" )
{
    echo '<h1>LUNA API</h1>
    <p>Welcome to the LUNA API. Here you will be able to perform a number of functions involving getting and putting data to/from the LUNA repository.</p>';
  $_SESSION['consumer_key'] = $consumer_key;

  $_SESSION['consumer_secret'] = $consumer_secret;
  $_SESSION['server_address'] = $server_address;
  $_SESSION['collection_id'] = $collection_id;
  try {
    $oauth = new OAuth($consumer_key,$consumer_secret);
    $request_token_info = $oauth->getRequestToken($server_address . "/editor/e/oauth/request_token");
    if(!empty($request_token_info)) {
      $request_token = $request_token_info['oauth_token'];
      $request_token_secret = $request_token_info['oauth_token_secret'];
      echo "<p><i class=\"fa fa-key fa-lg\">&nbsp;</i>Request Token Received: <b>". $request_token. "</b></p>";
      echo "<p><i class=\"fa fa-key fa-lg\">&nbsp;</i>Request Token Secret Received: <b>".  $request_token_secret. "</b></p>";
    } else {
      print "Failed fetching request token, response was: " . $oauth->getLastResponse();
    }
    $_SESSION['request_token']=$request_token;
    $_SESSION['request_token_secret']=$request_token_secret;
  } catch(OAuthException $E) {
    echo "Response: ". $E->lastResponse . "\n";
      echo "Info:". $E->debugInfo."\n";
  }
  print "<p><i class=\"fa fa-link fa-lg\">&nbsp;</i>Let's ";

    printf("<a href=\"" . $server_address . "/editor/e/oauth/authorize?oauth_token=%s\">authorize</a>",$request_token);

  print "<br><br>";
}
elseif( $command == "ready" )
{
  $request_token = $_SESSION['request_token'];
  $request_token_secret = $_SESSION['request_token_secret'];

  $oauth = new OAuth($_SESSION['consumer_key'], $_SESSION['consumer_secret']);
  $oauth->setToken($request_token,$request_token_secret);
  //$oauth->setToken($_SESSION['consumer_key'], $_SESSION['consumer_secret']);
  $access_token_info = $oauth->getAccessToken($_SESSION['server_address'] . "/editor/e/oauth/access_token");

  printf("Access Token Received: %s<br><br>", $access_token_info['oauth_token']);
  printf("Access Token Secret Received: %s<br><br>", $access_token_info['oauth_token_secret']);

  $_SESSION['access_token'] = $access_token_info['oauth_token'];
  $_SESSION['access_token_secret'] = $access_token_info['oauth_token_secret'];

  print "<br><br>Go to the following link to fetch protected resources:<br><br>";
    printf("<a href=\"".$working_dir."/oauth.php?command=ping\">ping</a>><br><br>");
    printf("<a href=\"".$working_dir."/oauth.php?command=collection\">collection</a><br><br>");
    printf("<a href=\"".$working_dir."/oauth.php?command=tagger\">tagger</a><br><br>");
    printf("<a href=\"".$working_dir."/oauth.php?command=keyword\">get keywords</a><br><br>");
    printf("<a href=\"".$working_dir."/oauth.php?command=urlgetter\">get LUNA URL for Repro ID</a><br><br>");
    printf("<a href=\"".$working_dir."/oauth.php?command=urlgettervernonupdate\">generate Vernon IIIF update XML</a ><br ><br>");
    printf("<a href=\"".$working_dir."/oauth.php?command=vernoninsert\">insert record ids</a><br><br>");
    printf("<a href=\"".$working_dir."/oauth.php?command=xmlrecord\">XML record for Work Record ID</a><br><br>");


  print "<br><br>";
}
elseif( $command == "ping" )
{
  $access_token = $_SESSION['access_token'];
  $access_token_secret = $_SESSION['access_token_secret'];
  $oauth = new OAuth($_SESSION['consumer_key'], $_SESSION['consumer_secret']);
  $oauth->setToken($access_token,$access_token_secret);
  $response_info = $oauth->getLastResponseInfo();
  header("Content-Type: text/plain");
  try
  {
    $oauth->fetch($_SESSION['server_address'] . "/editor/e/oauth/ping");
  }
  catch(Exception $e) {
    echo $e->getCode();
    echo $e->getMessage();
    echo $e->lastResponse;
  }
  echo $oauth->getLastResponse();
}
elseif( $command == "collection" )
{
    $access_token = $_SESSION['access_token'];
    $access_token_secret = $_SESSION['access_token_secret'];
    $oauth = new OAuth($_SESSION['consumer_key'], $_SESSION['consumer_secret']);
    $oauth->setToken($access_token,$access_token_secret);


    $response_info = $oauth->getLastResponseInfo();
    header("Content-Type: ".$response_info["content_type"]);
    try
    {
        //$oauth->fetch($_SESSION['server_address'] . "/editor/e/api/collections/" . $_SESSION['collection_id']. "/records/?search_field=work_record_id&search_value=0018129");
        $oauth->fetch($_SESSION['server_address'] . "/editor/e/api/collections/UoEgal~6~6/records/127872");

    }
    catch(Exception $e) {
        echo $e->getCode();
        echo $e->getMessage();
        echo $e->lastResponse;
    }
    $result = $oauth->getLastResponse();

    $xml=simplexml_load_string($result);

    print_r($xml);

}
elseif ($command == "tagger")
{
    $input_file = $docbase."input/tagfile.txt";
    //echo $input_file;
    $file_handle_in = fopen($input_file, "r")or die("can't open infile");
    $i = 0;
    $errorcount = 0;
    while (!feof($file_handle_in))
    {
        $line = fgets($file_handle_in);
        $map = explode(";",$line);
        $mapping[$i][0]=$map[0];
        $mapping[$i][1]= $map[1];
        $mapping[$i][2]= $map[2];
        $collection_no = $mapping[$i][2];

        echo 'IN'.$collection_no;

        $collection = collection_get($collection_no);

        echo 'OUT'.$collection;

        $access_token = $_SESSION['access_token'];
        $access_token_secret = $_SESSION['access_token_secret'];
        $oauth = new OAuth($_SESSION['consumer_key'], $_SESSION['consumer_secret']);
        $oauth->setToken($access_token,$access_token_secret);

        $response_info = $oauth->getLastResponseInfo();

        try
        {
            $text = $mapping[$i][1];
            $data = "<tags><tag>".$text."</tag></tags>";

            echo "DATA".$data."<br>\n";
            $url = $_SESSION['server_address'] . "/editor/e/api/collections/" . $collection. "/entities?parent_field_name=work_record_id&parent_field_value=". $mapping[$i][0]."&search_field=work_record_id&search_value=". $mapping[$i][0];
            echo 'URL'.$url."<br>\n";
            $oauth->fetch($url,$data,OAUTH_HTTP_METHOD_POST,array('Content-Type' => 'text/plain'));

        }
        catch(Exception $e) {
            echo $e->getCode();
            echo $e->getMessage();
            echo $e->lastResponse."\n";
            $errorcount++;
        }
        $i++;
    }
    echo 'ERRORS TOTAL:'.$errorcount;
}

elseif ( $command == "keyword") {

    ini_set('max_execution_time', 400);

    $input_file = $docbase . "input/collectionlist.txt";
    $out_file = $docbase . "output/keywordlist.txt";
//echo $input_file;
    $file_handle_in = fopen($input_file, "r") or die("can't open infile");
    $file_handle_out = fopen($out_file, "w") or die("can't open outfile");
    $i = 0;

    while (!feof($file_handle_in)) {
        $line =trim(fgets($file_handle_in));

        $access_token = $_SESSION['access_token'];
        $access_token_secret = $_SESSION['access_token_secret'];
        $oauth = new OAuth($_SESSION['consumer_key'], $_SESSION['consumer_secret']);
        $oauth->setToken($access_token, $access_token_secret);
        $response_info = $oauth->getLastResponseInfo();
        $url = $_SESSION['server_address'] . "/editor/e/api/collections/" . $line ."?os=0&pgs=5000"  ;
        try {
            $oauth->fetch($url, null, OAUTH_HTTP_METHOD_GET, array('Content-Type' => 'text/xml'));
        } catch (Exception $e) {
            echo $e->getCode();
            echo $e->getMessage();
            echo $e->lastResponse;
            $errorcount++;
        }
        $result = $oauth->getLastResponse();
        $xml = simplexml_load_string($result);

        if ($xml === false) {
            die('Error parsing XML');
        }
        $i = 0;

        foreach ($xml->item as $item) {

            $recordId = $item->recordId;
            //echo 'Record' . $recordId. "</br>";
            $recurl = $_SESSION['server_address'] . "/editor/e/api/collections/" . $line . "/records/" . $recordId ;
            echo $recurl."<br>";
            $oauth->fetch($recurl, null, OAUTH_HTTP_METHOD_GET, array('Content-Type' => 'text/xml'));
            $recresult = $oauth->getLastResponse();
            $recxml = simplexml_load_string($recresult);
            if ($recxml === false) {
                die('Error parsing XML');
            }

            foreach ($recxml->record as $recitem) {
                $i++;
                $keyword = $recitem->keywords->keyword;

                $work_record_id = $recitem->work_record_id;
                echo 'Item'.$work_record_id.' '.$line.' '.$keyword.' Coll Count '.$i. "<br>";
                if (!$keyword == null) {
                    fwrite($file_handle_out, $line . ':' . $work_record_id . ':' . $keyword . "\n");
                }


            }

        }


    }
}
elseif ( $command == "urlgetter") {
    ini_set('max_execution_time', 400);

    $input_file = $docbase . "input/urlrequests.txt";
    $out_file = $docbase . "output/urlout.txt";
    $file_handle_in = fopen($input_file, "r") or die("can't open infile");
    $file_handle_out = fopen($out_file, "w") or die("can't open outfile");
    $i = 0;

    while (!feof($file_handle_in)) {
        $line =trim(fgets($file_handle_in));
        $map = explode(";",$line);
        $mapping[$i][0]=$map[0];
        $mapping[$i][1]= $map[1];

        $collection_no = $mapping[$i][1];
        $collection = collection_get($collection_no);
        $repro_id = $mapping[$i][0];

        $access_token = $_SESSION['access_token'];
        $access_token_secret = $_SESSION['access_token_secret'];
        $oauth = new OAuth($_SESSION['consumer_key'], $_SESSION['consumer_secret']);
        $oauth->setToken($access_token, $access_token_secret);
        $response_info = $oauth->getLastResponseInfo();
        header("Content-Type: ".$response_info["content_type"]);
        //For Art/MIMEd, use repro_id_number
        //$url =$_SESSION['server_address'] . "/editor/e/api/collections/" . $collection. "/records/?search_field=repro_id_number&search_value=".$repro_id;
        //For DIU, use repro_record_id
        $url =$_SESSION['server_address'] . "/editor/e/api/collections/" . $collection. "/records/?search_field=repro_link_id&search_value=".$repro_id;
        //echo $url.";";
        try {
            $oauth->fetch($url, null, OAUTH_HTTP_METHOD_GET, array('Content-Type' => 'text/xml'));
        } catch (Exception $e) {
            echo $e->getCode();
            echo $e->getMessage();
            echo $e->lastResponse;
            $errorcount++;
        }
        $result = $oauth->getLastResponse();


        $xml = simplexml_load_string($result);



        if ($xml === false) {
            die('Error parsing XML');
        }
        $i = 0;

        foreach ($xml->item as $item) {


            $recordId = $item->recordId;
            $mediaId = $item->mediaId;

            $outurl = "http://images.is.ed.ac.uk/luna/servlet/detail/".$collection."~".$recordId."~".$mediaId;
            echo $repro_id.':'.$outurl."<br>";
            if (!$outurl == null) {
                fwrite($file_handle_out, $repro_id . ':' . $outurl . "\n");
            }
        }

    }
}
elseif ( $command == "urlgettervernonupdate") {
    ini_set('max_execution_time', 400);

    $input_file = $docbase . "input/urlrequestwithsystemid.txt";
    $out_file = $docbase . "output/vernon_md.xml";
    $file_handle_in = fopen($input_file, "r") or die("can't open infilek".$input_file);
    $file_handle_out = fopen($out_file, "w") or die("can't open outfile");
    $i = 0;

    fwrite($file_handle_out, "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
    fwrite($file_handle_out, "<recordset>\n");

    while (!feof($file_handle_in)) {
        $line =trim(fgets($file_handle_in));
        $map = explode(";",$line);

        $mapping[$i][0]=$map[0];
        $mapping[$i][1]= $map[1];
        $mapping[$i][2]= $map[2];


        $collection_no = $mapping[$i][2];
        $collection = collection_get($collection_no);
        $repro_id = $mapping[$i][1];
        $system_id = $mapping[$i][0];

        $access_token = $_SESSION['access_token'];
        $access_token_secret = $_SESSION['access_token_secret'];
        $oauth = new OAuth($_SESSION['consumer_key'], $_SESSION['consumer_secret']);
        $oauth->setToken($access_token, $access_token_secret);
        $response_info = $oauth->getLastResponseInfo();
        header("Content-Type: ".$response_info["content_type"]);
        //For Art/MIMEd, use repro_id_number
        //$url =$_SESSION['server_address'] . "/editor/e/api/collections/" . $collection. "/records/?search_field=repro_id_number&search_value=".$repro_id;
        //For DIU, use repro_record_id
        $url =$_SESSION['server_address'] . "/editor/e/api/collections/" . $collection. "/records/?search_field=repro_link_id&search_value=".$repro_id;
        //echo $url.";";
        try {
            $oauth->fetch($url, null, OAUTH_HTTP_METHOD_GET, array('Content-Type' => 'text/xml'));
        } catch (Exception $e) {
            echo $e->getCode();
            echo $e->getMessage();
            echo $e->lastResponse;
            $errorcount++;
        }
        $result = $oauth->getLastResponse();


        $xml = simplexml_load_string($result);



        if ($xml === false) {
            die('Error parsing XML');
        }
        $i = 0;
        fwrite($file_handle_out, "<record>\n");
        foreach ($xml->item as $item) {


            $recordId = $item->recordId;
            $mediaId = $item->mediaId;

            $outurl = "https://images.is.ed.ac.uk/luna/servlet/detail/".$collection."~".$recordId."~".$mediaId;
            $iiifurl = str_replace("detail", "iiif",$outurl);
            $iiifurl = str_replace("https", "http",$iiifurl);
            $iiifurl = $iiifurl."/full/full/0/default.jpg";
            $stringbit = substr($repro_id, 0,4);
            $folderfull = $stringbit."000-".$stringbit."999\\";
            if ($collection_no == '20'){
                $flavour = 'art';
            }
            else{
                $flavour = 'mimed';
            }
            if (substr($repro_id, 7,1) == 'd')
            {
                $format = ".jpg";
                $dir = "Derivatives";
            }
            else{
                $format = ".tif";
                $dir = "Crops";
            }
            $thumbnail_ref = $folderfull.$repro_id.".jpg";
            $master_image = "\\\\sg.datastore.ed.ac.uk\\sg\\lib\\groups\\lac-store\\".$flavour."\\".$dir."\\".$folderfull.$repro_id.$format;
            echo $repro_id.':'.$outurl."<br>";
            if (!$outurl == null) {
                fwrite($file_handle_out, "<id>".$system_id."</id>\n");
                fwrite($file_handle_out, "<im_ref>".$iiifurl."</im_ref>\n");
                fwrite($file_handle_out, "<thumbnail_ref>".$thumbnail_ref."</thumbnail_ref>\n");
                fwrite($file_handle_out, "<master_image>".$master_image."</master_image>\n");
                fwrite($file_handle_out, "<luna_url>".$outurl."</luna_url>\n");

            }
        }
        fwrite($file_handle_out, "</record>\n");

    }
    fwrite($file_handle_out, "</recordset>");
}
elseif ( $command == "vernoninsert"){
    $input_file = $docbase."input/testids.txt";
    //echo $input_file;
    $file_handle_in = fopen($input_file, "r")or die("can't open infile");
    $i = 0;
    $errorcount = 0;
    while (!feof($file_handle_in))
    {
        $line = fgets($file_handle_in);
        $map = explode(";",$line);
        $mapping[$i][0]=$map[0];
        $mapping[$i][1]= $map[1];
        $mapping[$i][2]= $map[2];
        $mapping[$i][3]= $map[3];
        $collection_no = $mapping[$i][2];

        echo 'IN'.$collection_no;

        $collection = collection_get($collection_no);

        echo 'OUT'.$collection;

        $access_token = $_SESSION['access_token'];
        $access_token_secret = $_SESSION['access_token_secret'];
        $oauth = new OAuth($_SESSION['consumer_key'], $_SESSION['consumer_secret']);
        $oauth->setToken($access_token,$access_token_secret);

        $response_info = $oauth->getLastResponseInfo();

        try
        {
            $vernonid = $mapping[$i][1];
            if ($mapping[$i][3] == 0)
            {
                $data = "<id_number><cms_id>".$vernonid."</cms_id></id_number>";
                //$data = "<cms_id>".$vernonid."</cms_id>";
                $url = $_SESSION['server_address'] . "/editor/e/api/collections/" . $collection. "/entities?parent_field_name=work_record_id&parent_field_value=". $mapping[$i][0].
                    "&search_field=work_record_id&search_value=". $mapping[$i][0]. "&search_entity_field=work_id_number&search_entity_value=". $mapping[$i][0];
            }
            else
            {
                $data = "<repro_record><repro_cms_id>".$vernonid."</repro_cms_id></repro_record>";
                $url = $_SESSION['server_address'] . "/editor/e/api/collections/" . $collection. "/entities?parent_field_name=repro_link_id&parent_field_value=". $mapping[$i][0]."&search_field=repro_link_id&search_value=". $mapping[$i][0];

            }

            echo "DATA".$data."<br>\n";
             echo 'URL'.$url."<br>\n";
            $oauth->fetch($url,$data,OAUTH_HTTP_METHOD_PUT,array('Content-Type' => 'text/plain'));

        }
        catch(Exception $e) {
            echo $e->getCode();
            echo $e->getMessage();
            echo $e->lastResponse."\n";
            $errorcount++;
        }
        $i++;
    }
    echo 'ERRORS TOTAL:'.$errorcount;
}
elseif ( $command == "xmlrecord") {
    ini_set('max_execution_time', 400);
echo'
    <div>
        <form method="post" action="oauth.php?command=xmlrecord">
            <table class="tab_standard">
                <tr>
                    <td>Give us a Work Record ID:</td>

                    <td><input type= "text"  NAME="work_record_id"/></td>
                </tr>
                                <tr>
                    <td>Give us its collection:</td>

                    <td><input type= "text"  NAME="collection_no"/></td>
                </tr>
                <tr>
                    <td><input type = "submit" name = "sendDetails" value = "send" />
                </tr>
                </table>
        </form>
    </div>';

    if (isset($_POST['sendDetails'])) {
        $out_file = $docbase . "output/xml.xml";

        $file_handle_out = fopen($out_file, "w") or die("can't open outfile");

        $i = 0;
        $work_record_id = $_POST['work_record_id'];
        $collection_no = $_POST['collection_no'];
        $collection = collection_get($collection_no);
        $access_token = $_SESSION['access_token'];
        $access_token_secret = $_SESSION['access_token_secret'];
        $oauth = new OAuth($_SESSION['consumer_key'], $_SESSION['consumer_secret']);
        $oauth->setToken($access_token, $access_token_secret);
        $response_info = $oauth->getLastResponseInfo();
        header("Content-Type: " . $response_info["content_type"]);
        //For Art/MIMEd, use repro_id_number
        //$url =$_SESSION['server_address'] . "/editor/e/api/collections/" . $collection. "/records/?search_field=repro_id_number&search_value=".$repro_id;
        //For DIU, use repro_record_id
        $url = $_SESSION['server_address'] . "/editor/e/api/collections/" . $collection . "/records/?search_field=work_record_id&search_value=" . $work_record_id;
        echo $url.";";
        try {
            $oauth->fetch($url, null, OAUTH_HTTP_METHOD_GET, array('Content-Type' => 'text/xml'));
        } catch (Exception $e) {
            echo $e->getCode();
            echo $e->getMessage();
            echo $e->lastResponse;
            $errorcount++;
        }
        $result = $oauth->getLastResponse();
        $xml = simplexml_load_string($result);

        if ($xml === false) {
            die('Error parsing XML');
        }
        else {
            print_r($xml);
        }
        $i = 0;

        foreach ($xml->item as $item) {

            $recordId = $item->recordId;

            $url = $_SESSION['server_address'] . "/editor/e/api/collections/" . $collection . "/records/".$recordId;
            echo $url."<br>";
            try {
                $oauth->fetch($url, null, OAUTH_HTTP_METHOD_GET, array('Content-Type' => 'text/xml'));
            } catch (Exception $e) {
                echo $e->getCode();
                echo $e->getMessage();
                echo $e->lastResponse;
                $errorcount++;
            }
            $result = $oauth->getLastResponse();
            $xml = simplexml_load_string($result);

            if ($xml === false) {
                die('Error parsing XML');
            }
            else {
                fwrite($file_handle_out, $result);
            }
        }
    }

}
function collection_get($collection_no)
{
    switch ($collection_no)
    {
        case '1':
            $collection = 'UoEcar~3~3';
            break;
        case '2':
            $collection = 'UoEgal~5~5';
            break;
        case '3':
            $collection = 'UoEsha~4~4';
            break;
        case '4':
            $collection = 'UoEwmm~1~1';
            break;
        case '5':
            $collection = 'UoEwmm~2~2';
            break;
        case '6':
            $collection = 'UoEgal~4~4';
            break;
        case '7':
            $collection = 'UoEsha~1~1';
            break;
        case '8':
            $collection = 'UoEgal~2~2';
            break;
        case '9':
            $collection = 'UoEcar~2~2';
            break;
        case '10':
            $collection = 'UoEsha~2~2';
            break;
        case '11':
            $collection = 'UoEwal~1~1';
            break;
        case '12':
            $collection = 'UoEcar~1~1';
            break;
        case '13':
            $collection = 'UoEcar~4~4';
            break;
        case '14':
            $collection = 'UoEsha~3~3';
            break;
        case '15':
            $collection = 'UoEgal~3~3';
            break;
        case '16':
            $collection = 'UoEwmm~3~3';
            break;
        case '17':
            $collection = 'UoEgal~6~6';
            break;
        case '18':
            $collection = 'UoEcar~3~3';
            break;
        case '19':
            $collection = 'UoEsha~5~5';
            break;
        case '20':
            $collection = 'UoEart~1~1';
            break;
        case '21':
            $collection = 'UoEart~2~2';
            break;
    }
    return $collection;
}

?>

</body>
</html>