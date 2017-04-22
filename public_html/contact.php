 <!-- 
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 -->
 <?php
if(isset($_POST["send"])) {
    $recipient = "info@cfbajans.com";
    $subject = "Feedback from my site";
    $sender = $_POST["sender"];
    $senderEmail = $_POST["senderEmail"];
    $message = $_POST["message"];
}
$mailBody = "Email: $senderEmail\n\n$message";

$success = mail($recipient, $subject, $mailBody, "From: $sender <$senderEmail>");
?>
<body>
<?php if (isset($success) && $success) { ?>
<h1> Thank you for your feedback!</h1>
Your message has been sent. 
<?php } else { ?>
<h1> Ooops! </h1>
Sorry! There seems to be a problem sending your message.
<?php }?>
</body>
