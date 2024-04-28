
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/x-icon"
	href="/MusicWebsite/assets/img/Other/logoPage.png">
<meta charset="UTF-8">
<title>Admin</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="/MusicWebsite/assets/css/style.css">
</head>
<style>
h1 {
	display: flex;
	justify-content: center;
}

td input {
	width: 500px;
	height: 50px;
	font-size: 30px;
	border-radius: 8px;
}

.confirm-table tr td {
	padding-top: 10px;
	padding-bottom: 20px;
	padding-left: 40px;
	padding-right: 40px;
}

.confirm-table {
	width: 100%;
	border-collapse: separate;
	border-spacing: 30px;
	display: flex;
	justify-content: center;
}

.confirm-button {
	background-color: rgb(104, 104, 104);
	font-size: 20px;
	border: none;
	width: 100px;
	height: 50px;
	color: white;
	border-radius: 50px;
}
</style>
<jsp:include page="../components/admin_header.jsp"/>
<body>

	<br>
	<h1 style="color: white;">Edit Song</h1>
	<form action="/MusicWebsite/UpdateSongController" method="post"
		enctype="multipart/form-data">
		<input value="${song.id_Song}" type="hidden" name="idSong">
		<table class="confirm-table">
			<tr>
				<td colspan="3">
					<h3 style="color: white;">Name Song</h3> <input type="text"
					required="required" name="name-song" value="${song.name_Song}" />
				</td>
				<td colspan="3">
					<h3 style="color: white;">Name Singer</h3> <input type="text"
					required="required" name="name-singer"
					value="${song.singer.name_Singer}" />
				</td>
			</tr>
			<tr style="width: 100%">
				<td colspan="3">
					<h3 style="color: white;">Duration</h3> <input type="time"
					name="duration" value="${song.duration}" required="required" />
				</td>
				<td colspan="3">
					<h3 style="color: white;">Genre</h3> <input type="text"
					required="required" name="genre" value="${song.genre}" />
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<h3 style="color: white;">File Image</h3>
					<div>
						<div class="mb-4 d-flex justify-content-center">
							<img id="selectedImage" src="${song.url_Img}"
								alt="example placeholder" style="width: 300px;" />
						</div>
						<div class="d-flex justify-content-center">
							<div class="btn btn-primary btn-rounded">
								<label class="form-label text-white m-1" for="customFile1">Choose
									file</label> <input type="file" class="form-control d-none"
									name="image" value="${pathImg}" accept="image/*"
									id="customFile1"
									onchange="displaySelectedImage(event, 'selectedImage')" />
							</div>
						</div>
					</div>
				</td>
				<td colspan="3">
					<h3 style="color: white;">File Audio</h3>

					<div>

						<audio id="selectedAudio" controls>
							<source src="${song.url_Audio}" type="audio/ogg">
						</audio>


					</div>
					<div class="d-flex justify-content-center">
						<div class="btn btn-primary btn-rounded">
							<label class="form-label text-white m-1" for="customFile1">Choose
								file</label> <input type="file" name="audio" value="${song.url_Audio}"
								accept="audio/*"
								onchange="displaySelectedImage(event, 'selectedAudio')" />
						</div>
					</div>


				</td>
			</tr>
			<tr>
				<td colspan="6" style="padding-left: 530px">
					<button class="confirm-button" type="submit">Submit</button>
				</td>
			</tr>
		</table>
	</form>
	<script
		src="https://cdn.jsdelivr.net/npm/html-duration-picker@latest/dist/html-duration-picker.min.js"
		type="text/javascript"></script>
</body>
<script type="text/javascript">
	function displaySelectedImage(event, elementId) {
		const selectedImage = document.getElementById(elementId);
		const fileInput = event.target;

		if (fileInput.files && fileInput.files[0]) {
			const reader = new FileReader();

			reader.onload = function(e) {
				selectedImage.src = e.target.result;
			};

			reader.readAsDataURL(fileInput.files[0]);
		}
	}
</script>
<script src="/MusicWebsite/assets/js/login.js"></script>
<script src='https://www.google.com/recaptcha/api.js'></script>
</html>