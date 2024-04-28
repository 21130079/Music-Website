<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel</title>
    <link rel="stylesheet" href="adminPanel.css">

</head>
<style>
#container_admin_pane{
	width:90%;
	margin-top:40px;
	margin-left:5%;
	margin-bottom:40px;
	display: grid;
	 grid-template-areas:
    "header header header header"
    "profit profit profit genre"
    "profit profit profit topview"
    "profit profit profit topview";
	gap: 40px;
}	
	
#cards_infor_header{
	display: grid;
	grid-template-columns: 1fr 1fr 1fr 1fr;
	grid-area:header;
	column-gap: 40px;
}

.card_infor{
height:120px;
border-radius:10px;

color: white;
display: flex;
justify-content: space-around;
align-items: center;
	
}
#cards_infor_header > :nth-child(1) {
	border: 1px solid #67CFF6;
}
#cards_infor_header > :nth-child(2){
border: 1px solid #F3A2E4;
}
#cards_infor_header > :nth-child(3){
border: 1px solid #8FE2DA;
}
#cards_infor_header > :nth-child(4){
border: 1px solid #F0DAA0;
}
.bi-people-fill{
	color: #67CFF6;
}
.bi-vinyl{
color: #F3A2E4;
}
.bi-cash-stack{
color: #F0DAA0;
}

.bi-cash{
color: #8FE2DA;
}
#cards_infor_header .bi{
font-size: 20px;
}
#monthly_profit_chart{
	grid-area:profit;
	display: grid;
	justify-self: center;
}
#monthly_profit_chart button{
	display: flex;
	justify-self: right;
	align-items:center;
	justify-content:center;
	width: 150px;
	border-radius: 5px;
	
}
img{
border-radius: 5px;}
#genre{
	grid-area: genre;
}
#top_view_chart{
	grid-area: topview;
}
</style>
<jsp:include page="../components/admin_header.jsp"/>


<body>
	<jsp:useBean id="daoSong" class="database.DAOSong" scope="session"></jsp:useBean>
		<jsp:useBean id="daoHistoryPre" class="database.DAOHistoryPremium" scope="session"></jsp:useBean>
			<jsp:useBean id="daoAccount" class="database.DAOAccount" scope="session"></jsp:useBean>
    <div id="container_admin_pane">
	    	<div id="cards_infor_header">
	    		<div class="card_infor">
	    			<div>
	    			<h3>${daoAccount.countAccounts()}</h3>
	    			<p>Number Of Users<p/>
	    			</div>
	    			<i class="bi bi-people-fill"></i>
	    		</div>
	    		<div class="card_infor">
	    			<div>
	    			<h3>${daoSong.countSongs()}</h3>
	    			<p>Number Of Songs<p/>
	    			</div>
	    			<i class="bi bi-vinyl"></i>
	    		</div>
	    		<div class="card_infor">
	    			<div>
	    			<h3>${daoHistoryPre.incomeInThisMonth}</h3>
	    			<p>Income In This Month<p/>
	    			</div>
	    			<i class="bi bi-cash"></i>
	    		</div>
	    		<div class="card_infor">
	    			<div>
	    			<h3>${daoHistoryPre.avgRevenue}</h3>
	    			<p>Average Revenue<p/>
	    			</div>
	    			<i class="bi  bi-cash-stack"></i>
	    		</div>
	    	</div>
	    	<div id="monthly_profit_chart">
		    	<img src="/MusicWebsite/profitChartImage" alt="profitchart.png">
		    	<button>Export to excel</button>
	    	</div>
	    	<img id="genre_chart" src="/MusicWebsite/GenreChartImage" alt="genrechart.png">
	    	<img id="top_view_chart" src="/MusicWebsite/TopSongsChartImage" alt="topsongchart.png">
	    </div>
</body>
</html>
