var songElements = document.querySelectorAll('.listSong-item-nav');
var skipBeforeBtn = document.querySelector('.skip-before');
var skipAfterBtn = document.querySelector('.skip-after');
var volume = document.querySelector('#volume');
var idPlaying = songElements[0].id;
var auTagPlaying = null;
var iTagPlaying = null;
var isRepeat = false;
var isPlaying = false;
var isShuffle = false;
var isMute = false;
var played = [];
var currentValue = 50;

if (played.length <= 1) {
	skipBeforeBtn.disabled = true;
}

function playMusic(id) {
	var iTagMain = document.querySelector('.footer-play');
	var progress = document.querySelector('#progress');
	var mainButton = document.querySelector('.pause-footer');

	if (idPlaying != id) {
		played.push(id);
		if (played.length > 1) {
			skipBeforeBtn.disabled = false;
		}
	}

	for (let i = 0; i < songElements.length; i++) {
		if (!isPlaying && id == songElements[i].id) {
			iTagMain.classList.add('bi-pause-circle');
			iTagMain.classList.remove('bi-play-circle');

			iTagPlaying = songElements[i].querySelector(`.bi${id}`);
			iTagPlaying.classList.remove('bi-play-circle');
			iTagPlaying.classList.add('bi-pause-circle');

			document.querySelector('.img-play').src = songElements[i].querySelector('img').src;
			document.querySelectorAll('.decrip-Music-play')[0].innerHTML = songElements[i].querySelector('.name-song').innerHTML;
			document.querySelectorAll('.decrip-Music-play')[1].innerHTML = songElements[i].querySelector('.name-singer').innerHTML;

			auTagPlaying = songElements[i].querySelector('audio');
			auTagPlaying.play();

			idPlaying = id;
			mainButton.id = idPlaying;
			isPlaying = true;
			break;
		} else if (isPlaying && id == idPlaying) {
			iTagMain.classList.add('bi-play-circle');
			iTagMain.classList.remove('bi-pause-circle');

			iTagPlaying.classList.remove('bi-pause-circle');
			iTagPlaying.classList.add('bi-play-circle');

			auTagPlaying.pause();

			isPlaying = false;
			break;
		} else if (isPlaying && id != idPlaying) {
			iTagMain.classList.add('bi-pause-circle');
			iTagMain.classList.remove('bi-play-circle');

			iTagPlaying.classList.add('bi-play-circle');
			iTagPlaying.classList.remove('bi-pause-circle');
			auTagPlaying.pause();
			for (let j = 0; j < songElements.length; j++) {
				if (id == songElements[j].id) {
					iTagPlaying = songElements[j].querySelector(`.bi${id}`)
					iTagPlaying.classList.add('bi-pause-circle');
					iTagPlaying.classList.remove('bi-play-circle');

					document.querySelector('.img-play').src = songElements[j].querySelector('img').src;
					document.querySelectorAll('.decrip-Music-play')[0].innerHTML = songElements[j].querySelector('.name-song').innerHTML;
					document.querySelectorAll('.decrip-Music-play')[1].innerHTML = songElements[j].querySelector('.name-singer').innerHTML;


					auTagPlaying = songElements[j].querySelector('audio');
					auTagPlaying.play();
					auTagPlaying.currentTime = 0;

					idPlaying = id;
					mainButton.id = idPlaying;
					isPlaying = true;
					break;
				}
			}
			break;
		}
	}
	
	auTagPlaying.ontimeupdate = function () {
		if (auTagPlaying.duration) {
			const currentProgress = Math.floor(auTagPlaying.currentTime / auTagPlaying.duration * 100);
			progress.value = currentProgress;
		}
	}
	
	progress.onchange = function () {
		const seekTime = progress.value / 100 * auTagPlaying.duration;
		auTagPlaying.currentTime = seekTime;
	}
	
	auTagPlaying.onended = function () {
		if (isRepeat) {
			auTagPlaying.play();
		} else {
			skipAfterBtn.click();
		}
	}
}

function playMainMusic(id) {
	for (let i = 0; i < songElements.length; i++) {
		if (songElements[i].id == id) {
			idPlaying = id;
			auTagPlaying = songElements[i].querySelector('audio');
			iTagPlaying = songElements[i].querySelector(`.bi${idPlaying}`);
			break;			
		}
	}
	played.push(idPlaying);
	playMusic(idPlaying);
}

function skipAfter() {
	if (isShuffle) {
		var randomId = Math.floor(Math.random() * 11);
		
		while (songElements[randomId].id == idPlaying) {
			randomId = Math.floor(Math.random() * 11);
		}
		
		playMusic(songElements[randomId].id);
	} else {
		for (let i = 0; i < songElements.length; i++) {
			if (songElements[i].id == idPlaying) {
				if (i == songElements.length - 1) {
					playMusic(songElements[0].id);
					break;
				} else {
					playMusic(songElements[i + 1].id);
					break;
				}
				
			}
		}
	}
}

function skipBefore() {
	var nextId = played.pop();
	nextId = played.pop();

	if (played.length <= 1) {
		skipBeforeBtn.disabled = true;
	}

	playMusic(nextId);
}

function repeatMode() {
	if (isRepeat) {
		isRepeat = false;
		document.querySelector('.bi-arrow-repeat').style = "font-size: 30px; color: white;";
	} else {
		isRepeat = true;
		document.querySelector('.bi-arrow-repeat').style = "font-size: 30px; color: red;";
	}
}

function shuffleMode() {
	if (isShuffle) {
		isShuffle = false;
		document.querySelector('.bi-shuffle').style = "font-size: 30px; color: white;";
	} else {
		isShuffle = true;
		document.querySelector('.bi-shuffle').style = "font-size: 30px; color: red;";
	}
}

function muteVolume() {
	var iTagVolume = document.querySelector('.volume');
	
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
