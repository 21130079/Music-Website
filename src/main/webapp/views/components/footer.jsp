<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="shortcut icon" href="#" />
<title>Document</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<link rel="stylesheet" href="/MusicWebsite/assets/css/style.css">
<title>Insert title here</title>
</head>
<body>
	<div id="footer">
		<table>
			<tr>
				<td style="padding:10px,;width: 26%;">
					<table>
						<tr>
							<td width="20px"></td>
							<td class="inner-td img-song"><img src="/MusicWebsite/"
								width=75px height=75px alt="..."> </td>
								<td width="20px"></td>
							<td class="inner-td name-song"><b></b> <br>
								<a href="" class="singer name-singer"></a></td>
						</tr>
					</table>
				</td>
				<td>
					<table>

						<tr>
							<td style="padding-left: 178px;"><table>
									<tr>
										<td style="padding: 0px 20px">
											<button class="btn-footer shuffle" onclick="shuffleMode()">
												<i style="font-size: 30px" class="bi bi-shuffle"></i>
											</button>
										</td>
										<td style="padding: 0px 20px">
											<button class="btn-footer skip-before"
												onclick="skipBeforeMusic(this.id)">
												<i style="font-size: 30px" class="bi bi-skip-start-fill"></i>
											</button>
										</td>
										<td style="padding: 0px 20px">
											<button class="btn-footer pause-footer" 
												onclick="playMusic(this.id, this.name, this.title, this.value)">
												<i style="font-size: 50px"
													class="footer-play bi bi-play-circle"></i>
											</button>
										</td>
										<td style="padding: 0px 20px">
											<button class="btn-footer skip-after"
												onclick="skipAfterMusic(this.id)">
												<i style="font-size: 30px" class="bi bi-skip-end-fill"></i>
											</button>
										</td>
										<td style="padding: 0px 20px">
											<button class="btn-footer repeat" onclick="repeatMode()">
												<i style="font-size: 30px" class="bi bi-arrow-repeat"></i>
											</button>
										</td>
									</tr>
								</table></td>
						</tr>
						<tr>
							<td style="padding-left: 138px;"><input id="progress"
								style="width: 500px; height: 2px;" type="range" value="0"
								step="1" min="0" max="100" /></td>
						</tr>
					</table>
				</td>
				<td
					style="padding-left: 289px; display: inline-flex; padding-top: 53px;">
					<button onclick="muteVolume()"
						style="border: none; background-color: transparent;">
						<i style="font-size: 20px; display: flex; padding-right: 26px"
							class="bi volume bi-volume-up"></i>
					</button> 
					<input id="volume" style="width: 100px" type="range" value=50 onchange="volumeHandler(this.value)" />
				</td>
			</tr>
		</table>
	</div>
	<script type="text/javascript" src="/MusicWebsite/assets/js/main.js"></script>

</body>
</html>