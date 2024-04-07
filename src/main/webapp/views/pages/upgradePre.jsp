<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Premium</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
   

    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
</head>
	  
    <style>
        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
           
        }
        #container {
            height: 100%;
            width: 100%;
           display: grid;
           justify-content: center;
           align-items: center;
            background-color: #171717;
        }
        .wrapper_button{
            justify-self: left;
  			margin-left: -20%;
        }
        .wrapper_button button {
            margin: 20px 0px;
            width: 120px ;
           
        }
        h2{
            font-size: 40px;
            width: 90%
        }
        #main_content {
            display: grid;
           grid-template-columns: 330px 330px 330px;
			  column-gap: 3%;
			  width: 100%;
            height: 500px;
            
            justify-self: center;
            color: white;
        }
        .option{
            border-radius: 10px;
            display: grid;
            
            justify-content: center;
            background-color: #242424;
            max-width: 450px;
        }
        .option_wrapper{
            display: grid;
			  justify-content: center;
			  width: 100%;
			  grid-template-rows: auto auto 18%;
        }
        .option_header{
            margin-top: 15px;
            height: 50%;
            display: grid;
            grid-template-rows: 30px 60px 80px auto;
        }
        .option_header hr{
            height: 1px;
        }
        #mini h2{
            color:#CFF56A;
        }
        #mini button {
            background-color: #CFF56A;
        } 
        #individual h2{
            color: #FFD2D7;
        }
        #individual button {
            background-color: #FFD2D7;
        }
        #student h2 {
            color: #C4B1D4;
        }
        #student button {
            background-color: #C4B1D4;
        }

       .inner_button{
            width: 100%;
            height: 50px;
            color:black;
            border-radius: 20px !important;
            cursor: pointer !important;
        }
        ul{
        padding-left: 0px !important;
      	 margin-left: 15px;
  		
        }
       .option_content li{
            justify-self: left;
           	margin: 10px auto;
      
        }
        .option_header p a{
            color :#A7A7A7 !important;
        }
       
    </style>
  
<body>  
<jsp:include page="/views/components/header.jsp"></jsp:include>
		<div id="container">
            <div class="wrapper_button">
            <c:url var ="url" value="/index.jsp"></c:url>
               <a href="${url}">
               <button class="inner_button">
                    <i class="fa-solid fa-arrow-left"></i>
                    Back
                </button>
                </a>
            </div>
        <div id ="main_content">
            <div  id="mini" class="option">
                <div class="option_wrapper">
                    <div class="option_header">
                        <div><i class="fa-solid fa-music"></i>
                            Premium</div>
                        <h2>Mini</h2>
                        <p>2.000₫ cho 1 ngày</p>
                        <br>
                        <hr>
                    </div>
                    <ul class="option_content">
                        <li>1 tài khoản Premium</li>
                        <li>Cho phép thêm tối đa 5 Playlist</li>
                        <li>Thanh toán một lần</li>
                    </ul>
                    <a href="/MusicWebsite/upgradeSelectorController?type=mini"><button class="inner_button">
                        Mua Premium Mini
                    </button></a>
                </div>
            </div>

            <div id="individual" class="option">
                <div class="option_wrapper">
                    <div class="option_header">
                        <div><i class="fa-solid fa-music"></i>
                            Premium</div>
                        <h2>Individual</h2>
                        <p>55.000₫ cho 2 tháng
                        </p>
                        <hr>
                    </div>
                    <ul class="option_content">
                        <li>Không giới hạn số bài hát Favorite </li>
                         <li>Không giới hạn số bài hát Favorite</li>
	                    <li>Không giới hạn số lượng Playlist</li>
	                    <li>Thanh toán một lần</li>
	                    <li>Dowload Nhạc miễn phí</li>
                    </ul>
                   <a href="/MusicWebsite/upgradeSelectorController?type=individual"> <button class="inner_button">
                        Mua Premium Individual
                    </button></a>
                </div>
            </div>

            <div id="student" class="option">
                <div class="option_wrapper">
                <div class="option_header">
                    <div><i class="fa-solid fa-music"></i>
                        Premium</div>
                    <h2>Student</h2>
                    <p>45.000₫ cho 2 tháng
                    </p>

                    <hr>
                  </div>
                  <ul class="option_content">
                  	<li>Giảm giá cho sinh viên đủ điều kiện</li>
                    <li>Không giới hạn số bài hát Favorite</li>
                    <li>Không giới hạn số lượng Playlist</li>
                    <li>Thanh toán một lần</li>
                  </ul>
                 <a href="/MusicWebsite/upgradeSelectorController?type=student"> <button class="inner_button">
                    Mua Premium Student
                  </button></a>
                </div>
            </div>
        </div>
        </div>
</body>
</html>