var topicMusics = document.querySelectorAll('.scroll');
var isPlaying = false;
var idPlaying = null;
var progress = document.querySelector('#progress');
var isMute = false;
var iTagVolume = document.querySelector('.volume');
var volume = document.querySelector('#volume');
var currentValue = 50;
var auTagPlaying = null;
var btnSkipBefore = document.querySelector('.skip-before');
var btnSkipAfter = document.querySelector('.skip-after');
var btnShuffle = document.querySelector('.shuffle');
var btnRepeat = document.querySelector('.repeat');
var isRepeat = false;
var isShuffle = false;
var played = [];

if (played.length <= 1) {
	btnSkipBefore.disabled = true;
}

window.onscroll = () => {
	topicMusics.forEach(sec => {
		let id = sec.getAttribute('id');
	});
}

function playMusic(id, nameSong, nameSinger, srcImg) {

	var btn = document.getElementById(id);
	var footer = document.getElementById("footer");
	var iTag = btn.querySelector('.bi' + id);
	var auTag = btn.querySelector('.au' + id);
	var btnPauseFooter = document.querySelector('.pause-footer');
	var iTagPauseFooter = btnPauseFooter.querySelector('.footer-play');
	var btnFooters = document.querySelectorAll('.btn-footer');
	var progress = document.querySelector('#progress');
	var nameSongFooter = footer.querySelector('.name-song');
	var imgSongFooter = footer.querySelector('.img-song');

	imgSongFooter.querySelector('img').src = srcImg;
	nameSongFooter.querySelector('b').innerHTML = nameSong;
	nameSongFooter.querySelector('a').innerHTML = nameSinger;

	footer.style.display = "block";

	if (idPlaying != id) {
		played.push(id);
		if (played.length > 1) {
			btnSkipBefore.disabled = false;
		}
	}

	if (id == null || !isPlaying) {
		iTag.classList.remove('bi-play-circle');
		iTag.classList.add('bi-pause-circle');
		iTagPauseFooter.classList.remove('bi-play-circle');
		iTagPauseFooter.classList.add('bi-pause-circle');
		btnPauseFooter.id = id;
		btnPauseFooter.name = nameSong;
		btnPauseFooter.title = nameSinger;
		btnPauseFooter.value = srcImg;
		auTag.play();
		this.auTagPlaying = auTag;
		this.auTagPlaying.volume = currentValue / 100;
		isPlaying = true;
		idPlaying = id;
	} else {
		if (idPlaying == id) {
			iTag.classList.remove('bi-pause-circle');
			iTag.classList.add('bi-play-circle');
			iTagPauseFooter.classList.remove('bi-pause-circle');
			iTagPauseFooter.classList.add('bi-play-circle');
			btnPauseFooter.id = id;
			btnPauseFooter.name = nameSong;
			btnPauseFooter.title = nameSinger;
			btnPauseFooter.value = srcImg;
			auTag.pause();
			isPlaying = false;
		} else {
			var btnPlaying = document.getElementById(idPlaying);
			var auTagPlaying = btnPlaying.querySelector('.au' + idPlaying);
			var iTagPlaying = btnPlaying.querySelector('.bi' + idPlaying);

			iTagPlaying.classList.remove('bi-pause-circle');
			iTagPlaying.classList.add('bi-play-circle');
			auTagPlaying.pause();

			iTag.classList.remove('bi-play-circle');
			iTag.classList.add('bi-pause-circle');
			iTagPauseFooter.classList.remove('bi-play-circle');
			iTagPauseFooter.classList.add('bi-pause-circle');
			btnPauseFooter.id = id;
			btnPauseFooter.name = nameSong;
			btnPauseFooter.title = nameSinger;
			btnPauseFooter.value = srcImg;
			auTag.play();
			this.auTagPlaying = auTag;
			this.auTagPlaying.volume = currentValue / 100;
			isPlaying = true;
			idPlaying = id;
			auTag.currentTime = 0;
		}
	}

	auTag.onended = function() {
		if (isRepeat) {
			auTag.play();
		} else {
			btnSkipAfter.click();
		}
	}

	btnFooters.forEach(function(btn) {
		btn.id = id;
	});

	auTag.ontimeupdate = function() {
		if (auTag.duration) {
			const currentProgress = Math.floor(auTag.currentTime / auTag.duration * 100);
			progress.value = currentProgress;
		}
	}

	progress.onchange = function() {
		const seekTime = progress.value / 100 * auTag.duration;
		auTag.currentTime = seekTime;
	}
}

function skipBeforeMusic() {
	var nextId = played.pop();
	var nextId = played.pop();

	var item = document.querySelector('#' + nextId);
	var songAndSinger = item.querySelector('.song-singer');
	var song = songAndSinger.querySelector('b');
	var singer = songAndSinger.querySelector('a');
	var srcImg = item.querySelector('img');

	playMusic(nextId.toString(), song.innerHTML, singer.innerHTML, srcImg.src);

	if (played.length <= 1) {
		btnSkipBefore.disabled = true;
	}
}

function skipAfterMusic() {
	var nextId = "";
	var getId = btnSkipAfter.id.slice(2, btnSkipAfter.id.length)
	var currentId = parseInt(getId);
	var itemLength = document.querySelectorAll('.all-music-item').length;
	
	if (isShuffle) {
		var randomId = Math.floor(Math.random() * itemLength);
		while (randomId == currentId) {
			randomId = Math.floor(Math.random() * itemLength);
		}
		
		if (randomId < 10) {
			nextId = "0" + randomId.toString();
		} else {
			nextId = randomId.toString();
		}
		
		nextId = "SO" + nextId;
	} else {
		var increaseId = currentId + 1;
		if (increaseId > itemLength) {
			increaseId = 1;
		}

		if (increaseId < 10) {
			nextId = "0" + increaseId.toString();
		} else {
			nextId = increaseId.toString();
		}

		nextId = "SO" + nextId;
	}

	console.log(nextId);

	var item = document.querySelector('#' + nextId);
	var songAndSinger = item.querySelector('.song-singer');
	var song = songAndSinger.querySelector('b');
	var singer = songAndSinger.querySelector('a');
	var srcImg = item.querySelector('img');

	playMusic(nextId.toString(), song.innerHTML, singer.innerHTML, srcImg.src);
}

function muteVolume() {
	if (isMute) {
		iTagVolume.classList.remove('bi-volume-mute');
		iTagVolume.classList.add('bi-volume-up');
		volume.value = currentValue;
		auTagPlaying.volume = currentValue / 100;
		isMute = false;
	} else {
		iTagVolume.classList.remove('bi-volume-up');
		iTagVolume.classList.add('bi-volume-mute');
		currentValue = volume.value;
		volume.value = 0;
		auTagPlaying.volume = 0;
		isMute = true;
	}
}

function volumeHandler() {
	currentValue = volume.value;
	if ((isMute && volume.value != 0) || (!isMute && volume.value == 0)) {
		muteVolume();
	}
	auTagPlaying.volume = currentValue / 100;
}

function repeatMode() {
	if (isRepeat) {
		isRepeat = false;
		btnRepeat.querySelector('.bi-arrow-repeat').style = "font-size: 30px; color: white;";
	} else {
		isRepeat = true;
		btnRepeat.querySelector('.bi-arrow-repeat').style = "font-size: 30px; color: red;";
	}
}

function shuffleMode() {
	if (isShuffle) {
		isShuffle = false;
		btnShuffle.querySelector('.bi-shuffle').style = "font-size: 30px; color: white;";
	} else {
		isShuffle = true;
		btnShuffle.querySelector('.bi-shuffle').style = "font-size: 30px; color: red;";
	}
}



























