<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Panel</title>
<link rel="stylesheet" href="adminPanel.css">

</head>
<style>
#container_admin_pane {
	width: 90%;
	margin-top: 40px;
	margin-left: 5%;
	margin-bottom: 40px;
	display: grid;
	grid-template-areas: "header header header header"
		"profit profit profit genre" "profit profit profit topview"
		"profit profit profit topview";
	gap: 40px;
}

#cards_infor_header {
	display: grid;
	grid-template-columns: 1fr 1fr 1fr 1fr;
	grid-area: header;
	column-gap: 40px;
}

.card_infor {
	height: 120px;
	border-radius: 10px;
	color: white;
	display: flex;
	justify-content: space-around;
	align-items: center;
}

#cards_infor_header>:nth-child(1) {
	border: 1px solid #67CFF6;
}

#cards_infor_header>:nth-child(2) {
	border: 1px solid #F3A2E4;
}

#cards_infor_header>:nth-child(3) {
	border: 1px solid #8FE2DA;
}

#cards_infor_header>:nth-child(4) {
	border: 1px solid #F0DAA0;
}

.bi-people-fill {
	color: #67CFF6;
}

.bi-vinyl {
	color: #F3A2E4;
}

.bi-cash-stack {
	color: #F0DAA0;
}

.bi-cash {
	color: #8FE2DA;
}

#cards_infor_header .bi {
	font-size: 20px;
}

#monthly_profit_chart {
	grid-area: profit;
	display: grid;
	justify-self: center;
}

#monthly_profit_chart button {
	display: flex;
	justify-self: right;
	align-items: center;
	justify-content: center;
	width: 150px;
	border-radius: 5px;
}

img {
	border-radius: 5px;
}

#genre {
	grid-area: genre;
}

#top_view_chart {
	grid-area: topview;
}

#year_css,#month_css,#precious_css {
	display: none;
}
#export_select{
	padding: 10px 20px 10px 20px;
}
#export_select *{
	margin-bottom: 10px 
}
</style>
<jsp:include page="../components/admin_header.jsp" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<body>
	<jsp:useBean id="daoSong" class="database.DAOSong" scope="session"></jsp:useBean>
	<jsp:useBean id="daoHistoryPre" class="database.DAOHistoryPremium"
		scope="session"></jsp:useBean>
	<jsp:useBean id="daoAccount" class="database.DAOAccount"
		scope="session"></jsp:useBean>
	<div id="container_admin_pane">
		<div id="cards_infor_header">
			<div class="card_infor">
				<div>
					<h3>${daoAccount.countAccounts()}</h3>
					<p>Number Of Users
					<p />
				</div>
				<i class="bi bi-people-fill"></i>
			</div>
			<div class="card_infor">
				<div>
					<h3>${daoSong.countSongs()}</h3>
					<p>Number Of Songs
					<p />
				</div>
				<i class="bi bi-vinyl"></i>
			</div>
			<div class="card_infor">
				<div>
					<h3>${daoHistoryPre.incomeInThisMonth}</h3>
					<p>Income In This Month
					<p />
				</div>
				<i class="bi bi-cash"></i>
			</div>
			<div class="card_infor">
				<div>
					<h3>${daoHistoryPre.avgRevenue}</h3>
					<p>Average Revenue
					<p />
				</div>
				<i class="bi  bi-cash-stack"></i>
			</div>
		</div>
		<div id="monthly_profit_chart">
			<img src="/MusicWebsite/profitChartImage" alt="profitchart.png">
			
		</div>
		
		<img id="genre_chart" src="/MusicWebsite/GenreChartImage"
			alt="genrechart.png"> <img id="top_view_chart"
			src="/MusicWebsite/TopSongsChartImage" alt="topsongchart.png">
		
		
			
			
	</div>
	<div style="background-color: white; color: black; width:50%;margin-left: 1000px"
				id="export_select">
				<input type="radio" id="export1" name="options" value="export1" onchange="chooseOption()">
				Export files by 
				 <select id="combo" name="combo" onchange="chooseOption()">
					<option value="day">Day</option>
					<option value="month">Month</option>
					<option value="year">Year</option>
					<option value="precious">Precious</option>

				</select> 
				<br> 
				<input type="radio" id="export2"name="options" value="export2" onchange="chooseOption()">
				 Best - selling product
					 <select id="combo2" name="combo2" onchange="chooseOption()">
					<option value="day">Day</option>
					<option value="month">Month</option>
					<option value="year">Year</option>
					<option value="precious">Precious</option>

				</select> <br>
				<div style="display: flex;">
					<div id="precious_css">
						<label style="margin-right: 10px">Precious:</label>
						<select id="precious"></select> 
					</div>
					<div id="month_css" style="margin-right: 10px">
						<label style="margin-right: 10px">Month:</label>
						<select id="month"></select> 
					</div>
					<div id="year_css">
						<label style="margin-right: 10px">Year: </label>
						<select id="year"></select>
					</div>
						 
				</div>
				
				 <input type="date"	class="form-control" id="day" name="day"
					style="width: 50%">

				<button id="exportBtn" onclick="exportFile()">Export to
					excel</button>
			</div>
</body>
<script type="text/javascript">
	//year
	var startYear = 2020;
	var endYear = 2030;
	
	//day
	var startMonth =1;
	var endMonth = 12;
	var yearSelect = document.getElementById("year");
	var monthSelect = document.getElementById("month");
	var preciousSelect = document.getElementById("precious");
	
	for (var year = startYear; year <= endYear; year++) {
		var option = document.createElement("option");
		option.text = year;
		option.value = year;
		yearSelect.add(option);
	}
	for(var month = startMonth; month<=endMonth; month++){
		var option = document.createElement("option");
		option.text = month;
		option.value = month;
		monthSelect.add(option);
	}
	for (var precious = 1; precious <= 4; precious++){
		var option = document.createElement("option");
		option.text = precious;
		option.value = precious;
		preciousSelect.add(option);
	}
	
	function chooseOption() {
		var selectedOption_0 = document.querySelector('input[name="options"]:checked');
		var selectedOption_0Value = selectedOption_0.value;

		var selectedOption = document.getElementById("combo").value;
		var selectedOption2 = document.getElementById("combo2").value;

		var yearSelect = document.getElementById("year_css");
		var monthSelect = document.getElementById("month_css")
		var daySelect = document.getElementById("day");
		var preciousSelect = document.getElementById("precious_css");
		
		if(selectedOption_0Value === "export1"){
			if (selectedOption === "year") {			
				yearSelect.style.display = "block";	
				monthSelect.style.display ="none";
				daySelect.style.display = "none";
				preciousSelect.style.display = "none";

			}else if(selectedOption === "day"){			
				yearSelect.style.display = "none";
				monthSelect.style.display ="none";
				daySelect.style.display = "block";
				preciousSelect.style.display = "none";

			}else if(selectedOption === "month"){
				monthSelect.style.display ="block";
				yearSelect.style.display = "block";			
				daySelect.style.display = "none";
				preciousSelect.style.display = "none";

			}else {
				preciousSelect.style.display = "block";
				monthSelect.style.display ="none";
				yearSelect.style.display = "block";			
				daySelect.style.display = "none";
			}
		}else {
			if (selectedOption2 === "year") {			
				yearSelect.style.display = "block";	
				monthSelect.style.display ="none";
				daySelect.style.display = "none";
				preciousSelect.style.display = "none";

			}else if(selectedOption2 === "day"){			
				yearSelect.style.display = "none";
				monthSelect.style.display ="none";
				daySelect.style.display = "block";
				preciousSelect.style.display = "none";

			}else if(selectedOption2 === "month"){
				monthSelect.style.display ="block";
				yearSelect.style.display = "block";			
				daySelect.style.display = "none";
				preciousSelect.style.display = "none";

			}else {
				preciousSelect.style.display = "block";
				monthSelect.style.display ="none";
				yearSelect.style.display = "block";			
				daySelect.style.display = "none";
			}
		}
	
	}
	
	function exportFile() {
		var selectedOption = document.querySelector('input[name="options"]:checked');
		
		var dropdownType = document.getElementById("combo");
		var bestTypeSelect = dropdownType.value;
		
		var dropdownMonth = document.getElementById("month");
		var monthValue = dropdownMonth.value;
		
		var dropdownYear = document.getElementById("year");
		var yearValue = dropdownYear.value;
		
		var dropdownPrecious = document.getElementById("precious");
		var preciousValue = dropdownPrecious.value;
		
		
		var dayValue = document.getElementById("day").value;	
		$.ajax({
			url : '/MusicWebsite/ExportFileController',
			type : 'GET',
			data : {
				exportTypeInput : selectedOption.value,
				bestType : bestTypeSelect,
				dayValue : dayValue,
				monthValue : monthValue,
				yearValue : yearValue,
				preciousValue : preciousValue
				
			},
			success : function(data) {
				var blob = new Blob([ data ]);
				var link = document.createElement('a');
				link.href = window.URL.createObjectURL(blob);
				link.download = 'statistical_file.csv';
				link.click();
			}
		});

	}
</script>
</html>
