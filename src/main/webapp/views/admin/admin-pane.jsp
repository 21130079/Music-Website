<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Panel</title>
<!-- <link rel="stylesheet" href="adminPanel.css">

 --></head>
<style>
#container_admin_pane {
	width: 90%;
	margin-top: 40px;
	margin-left: 5%;
	margin-bottom: 40px;
	display: grid;
	grid-template-areas: "header header header header"
		"profit profit profit genre" 
		"profit profit profit topview"
		"feature feature feature topview";
	gap: 20px;
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


img {
	border-radius: 5px;
}

#profit,#genre,#view_chart{
background-color: white;
border-radius: 10px;
}
#genre_chart {
	grid-area: genre;
}

#top_view_chart {
	grid-area: topview;
}

#year_css,#month_css,#precious_css {
	display: none;
}
#export_select{
	margin-right: 5%;
	color: white;
	grid-area:feature;
	justify-self: right;
	display: grid;
	grid-template-areas: "exportOp exportOp date date"
		"bestseller bestseller date date" 
		"button button button button"
		;
		gap: 10px;
}
#export_option{
	grid-area:exportOp;
}
#bestseller{
	grid-area:bestseller;
}
#date{
	grid-area:date;
}
#exportBtn{
	grid-area:button;
}


</style>
<jsp:include page="../components/admin_header.jsp" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	      <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	       <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.0.0"></script>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<body>
	<jsp:useBean id="daoSong" class="database.DAOSong" scope="request"></jsp:useBean>
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
		<div style="width: 95%;" id="monthly_profit_chart">
				<canvas id=profit></canvas>
		</div>
		<div style=" display: flex;
    justify-content: center;
    width: 100%" id=genre_chart>
				<canvas width="100%" id=genre></canvas>
		</div>
		<div style="width: 100%;" id=top_view_chart>
				<canvas id=view_chart></canvas>
		</div>
		
		<div
				id="export_select">
				<div id="export_option">
				<input type="radio" id="export1" name="options" value="export1" onchange="chooseOption()">
				Export files by 
				 <select id="combo" name="combo" onchange="chooseOption()">
					<option value="day">Day</option>
					<option value="month">Month</option>
					<option value="year">Year</option>
					<option value="precious">Precious</option>

				</select>
				</div> 
				<div id="bestseller">
				<input type="radio" id="export2"name="options" value="export2" onchange="chooseOption()">
				 Best - selling product
					 <select id="combo2" name="combo2" onchange="chooseOption()">
					<option value="day">Day</option>
					<option value="month">Month</option>
					<option value="year">Year</option>
					<option value="precious">Precious</option>

				</select> 
				</div> 
				<div id="date">
						<div id="date-chooser"  style="display: flex;">
					<div id="precious_css">
						<label>Precious:</label>
						<select id="precious"></select> 
					</div>
					<div id="month_css">
						<label>Month:</label>
						<select id="month"></select> 
					</div>
					<div id="year_css">
						<label>Year: </label>
						<select id="year"></select>
					</div>
						 
				</div>
				
				 <input type="date"	class="form-control" id="day" name="day"
					>
					</div>

				<button id="exportBtn" onclick="exportFile()">Export to
					excel</button>
			</div>
			
			
	</div>
	
</body>
<script type="text/javascript">
$(document).ready(function() {
    $.ajax({
        url: '/MusicWebsite/ProfitChartServlet',
        method: 'GET',
        dataType: 'json',
        success: function(response) {
            var ctx = $('#profit');
            var myChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: response.labels,
                    datasets: [{
                        label: 'Profit',
                        data: response.data,
                        backgroundColor: 'rgba(33, 150, 243, 0.2)',
                        borderColor: 'rgba(33, 150, 243, 1)',
                        borderWidth: 1,
                        fill: true
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        },
        error: function(error) {
            console.log('Error:', error);
        }
    });
    // Biểu đồ tròn
    $.ajax({
        url: '/MusicWebsite/GenreChartServlet',
        method: 'GET',
        dataType: 'json',
        success: function(response) {
            var ctxPie = $('#genre');
            var labels = Object.keys(response);
            var data = Object.values(response);

            var pieChart = new Chart(ctxPie, {
                type: 'pie',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Music Genre Distribution',
                        data: data,
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.2)',
                            'rgba(54, 162, 235, 0.2)',
                            'rgba(255, 206, 86, 0.2)',
                            'rgba(75, 192, 192, 0.2)',
                            'rgba(153, 102, 255, 0.2)',
                            'rgba(255, 159, 64, 0.2)',
                            'rgba(199, 199, 199, 0.2)',
                            'rgba(83, 102, 255, 0.2)',
                            'rgba(255, 152, 0, 0.2)',
                            'rgba(76, 175, 80, 0.2)',
                            'rgba(183, 28, 28, 0.2)',
                            'rgba(255, 235, 59, 0.2)'
                        ],
                        borderColor: [
                            'rgba(255, 99, 132, 1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)',
                            'rgba(153, 102, 255, 1)',
                            'rgba(255, 159, 64, 1)',
                            'rgba(199, 199, 199, 1)',
                            'rgba(83, 102, 255, 1)',
                            'rgba(255, 152, 0, 1)',
                            'rgba(76, 175, 80, 1)',
                            'rgba(183, 28, 28, 1)',
                            'rgba(255, 235, 59, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    plugins: {
                        legend: {
                            labels: {
                                color: 'black' // Màu sắc của nhãn biểu đồ
                            }
                        } ,datalabels: {
                            formatter: (value, ctx) => {
                                let percentage = (value / data.reduce((sum, val) => sum + val, 0) * 100).toFixed(2) + '%';
                                return percentage;
                            },
                            color: 'black',
                            anchor: 'end',
                            align: 'start',
                            offset: -10,
                            font: {
                                weight: 'bold'
                            }
                        }
                    },
                layout: {
                    padding: 10 
                }
                },
                plugins: [ChartDataLabels] // Đăng ký plugin datalabels
            });
          
        
        },
        error: function(error) {
            console.log('Error:', error);
        }
    });
    $.ajax({
        url: '/MusicWebsite/TopSongsChartImage',
        method: 'GET',
        dataType: 'json',
        success: function(response) {
            var ctxBar = $('#view_chart');
            var labels = Object.keys(response);
            var data = Object.values(response);

            var barChart = new Chart(ctxBar, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Number of Plays',
                        data: data,
                        backgroundColor: 'rgba(255, 102, 102, 0.7)', // Màu nền của cột
                        borderColor: 'rgba(255, 102, 102, 1)', // Màu viền của cột
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    },
                    plugins: {
                        legend: {
                            labels: {
                                color: 'black' // Màu sắc của nhãn biểu đồ
                            }
                        },
                       
                    }
                },
               
            });
        },
        error: function(error) {
            console.log('Error:', error);
        }
    });
});

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
