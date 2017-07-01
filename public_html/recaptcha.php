    <!--This php code will be used to server-side validate the whether user has
    passed the recaptcha. This should eliminate bots and spam.
  This code uses the input form method "POST" (found in contact.html) to access
  the variables returned from the contact page-->
  <?php
          $email;$comment;$captcha;
          if(isset($_POST['your_name'])){
            $email=$_POST['your_name'];
          }if(isset($_POST['your_email'])){
            $email=$_POST['your_email'];
          }if(isset($_POST['g-recaptcha-response'])){
            $captcha=$_POST['g-recaptcha-response'];
          }
          if(!$captcha){
            echo '<h2>Please check the the captcha form.</h2>';
            exit;
          }
          $secretKey = "6LfMmR0UAAAAAH2t0vZ6SHplDUfVccbZcxS6E_Gf";
          $ip = $_SERVER['REMOTE_ADDR'];
          $response=file_get_contents("https://www.google.com/recaptcha/api/siteverify?secret=".$secretKey."&response=".$captcha."&remoteip=".$ip);
          $responseKeys = json_decode($response,true);
          if(intval($responseKeys["success"]) !== 1) {
            echo '<h2>You are spammer ! Get the @$%K out</h2>';
          } else {
            echo '<h2>Thanks for posting comment.</h2>';
          }
  ?>
