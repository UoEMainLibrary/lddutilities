<?php
session_start();
ini_set('max_execution_time', 400);
parse_str($_SERVER['QUERY_STRING']);

# see http://php.net/manual/en/class.oauth.php

########## Change the following variables ################
$docbase = '/Users/srenton1/Projects/lddutilities/';
//Test vars
//$consumer_key = "uoeimagev4bP2";
//$consumer_secret = "1PJxU6mTNQS4QhPcZh0nvuDOvy073G";
//PHP server test vars
//$consumer_key = "uoeimageqZy7x";
//$consumer_secret = "PLTTaXvb1AppVSMqGfQsVt1VPDvV44";


//$server_address = "http://lac-luna-test2.is.ed.ac.uk:8181";

//Live vars
$consumer_key = "uoeimageAPqoa";
$consumer_secret = "zcTbfbQEGc9qxCqux9HWlpL1hbWT6C";

$server_address = "http://lac-luna-live4.is.ed.ac.uk:8181";

$working_dir = "http://localhost/lddutilities/vernonDC";

##########################################################

########## Callback URL #############

# A callback URL must be specified in LUNA for the registered application with the above
# consumer key. It should be in the form of document_root/oauth.php?command=ready
# For example, if the address of this script is http://www.example.com/oauth.php, the 
# callback URL would be http://www.example.com/oauth.php?command=ready.

#####################################

if( $command == "" )
{
    echo 'HELLO!';
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
      printf("Request Token Received: %s<br><br>", $request_token);
      printf("Request Token Secret Received: %s<br><br>", $request_token_secret);
    } else {
      print "Failed fetching request token, response was: " . $oauth->getLastResponse();
    }
    $_SESSION['request_token']=$request_token;
    $_SESSION['request_token_secret']=$request_token_secret;
  } catch(OAuthException $E) {
    echo "Response: ". $E->lastResponse . "\n";
      echo "Info:". $E->debugInfo."\n";
  }
  print "<br><br>Go to the following link in your browser:<br><br>";

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

    //print_r($result);

    //$json = json_decode($oauth->getLastResponse());

    //print_r($json);

    $xml=simplexml_load_string($result);

    print_r($xml);

    /*if ($xml === false) {
        die('Error parsing XML');
    }

   foreach ($xml->record as $item)
   {
        echo 'HOLDING'.$item->id_number->holding_institution;
   }
*/


    //print_r($xml);
    /* $url = $_SESSION['server_address'] . "/editor/e/api/collections/" . $_SESSION['collection_id'];
 $method = 'POST';
 $OA_header = $oauth->getRequestHeader($method, $url);

 echo $OA_header;
 $headers = array("Authorization: $OA_header");

 $ch = curl_init();
 curl_setopt($ch, CURLOPT_URL, $url);
 curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
 curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);

 $response = curl_exec($ch);

 echo $response;

*/
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
        }


        $access_token = $_SESSION['access_token'];
        $access_token_secret = $_SESSION['access_token_secret'];
        $oauth = new OAuth($_SESSION['consumer_key'], $_SESSION['consumer_secret']);
        $oauth->setToken($access_token,$access_token_secret);

        $response_info = $oauth->getLastResponseInfo();
        //header("Content-Type: ".$response_info["content_type"]);
        //header("Content-Type: text/plain");

        try
        {
           // $data = '<entity name ="keywords"><field name = "keyword"><value>'.$mapping[$i][2].'</value></field></entity>';
        $text = $mapping[$i][1];
       // $data='<keywords>'.
             //   '<keyword>'.
               //     $text.
                  //  '</keywords>'.
                  //  '</keyword>';

            $data = "<tags><tag>".$text."</tag></tags>";


                    //</record></recordList>';
           /* $oauth->fetch($_SESSION['server_address'] . "/editor/e/api/collections/" . $collection. "/records/?search_field=work_record_id&search_value=". $mapping[$i][0]);
            $result = $oauth->getLastResponse();
            $xml=simplexml_load_string($result);

            print_r($xml);

            if ($xml === false) {
                die('Error parsing XML');
            }

            foreach ($xml->item as $item) {
                echo 'MEDIAID' . $item->mediaId;
            }
            $oauth->fetch($_SESSION['server_address'] . "/editor/e/api/collections/" . $collection. "/records/127872");
            $result = $oauth->getLastResponse();
            $xml=simplexml_load_string($result);
            print_r($xml);
            */
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
        //header("Content-Type: ".$response_info["content_type"]);
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

?>

