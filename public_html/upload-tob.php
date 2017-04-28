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
$target_dir = "images/tob2017/";

if(isset($_POST["submit"])) {
    $num_files = count($_FILES['fileToUpload']['tmp_name']);
    echo $num_files;
    
    for($i=0; $i < $num_files; $i++){
       $tmp_fname = $_FILES["fileToUpload"]["tmp_name"][$i];
       $fname = $_FILES["fileToUpload"]["name"][$i];
       $target_file = $target_dir . basename($fname);
       $uploadOk = 1;
       $imageFileType = pathinfo($target_file,PATHINFO_EXTENSION);

       $check = getimagesize($tmp_fname);
       echo $tmp_fname;
       echo $_FILES["fileToUpload"]["tmp_name"][$i];
       // Check if image file is a actual image or fake image
       if($check !== false) {
        echo "File is an image - " . $check["mime"] . ".<br>";
            $uploadOk = 1;
        } else {
            echo "$tmp_fname is not an image.<br>";
            $uploadOk = 0;
        }
        // Check if file already exists
        if (file_exists($target_file)) {
            echo "Sorry, a filename on the server exists already with $fname. <br>";
            $uploadOk = 0;
        }
        // Check file size
        if ($_FILES["fileToUpload"]["size"][$i] > 500000) {
            echo "Sorry, $fname is too large.<br>";
            $uploadOk = 0;
        }
        // Allow certain img file formats
        if($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg" && $imageFileType != "gif" ) {
            echo "Sorry, check $fname. Only JPG, JPEG, PNG & GIF files are allowed.<br>";
            $uploadOk = 0;
        }

        // Check if $uploadOk is set to 0 by an error
        if ($uploadOk == 0) {
            echo "Sorry, $fname was not uploaded.<br>";
        // if everything is ok, try to upload file
        } else {
            if (move_uploaded_file($tmp_fname, $target_file)) {
                echo "The file ". basename( $fname). " has been uploaded.<br>";
            } else {
                echo "Sorry, there was an error uploading $fname.<br>";
            }
        }

    } //for each file
    
}


?>