function editNamePlaylist(id_Playlist) {
	var nameElement = document.querySelector(`.${id_Playlist}`);
	var confirmIcon = document.createElement('i');

	if (nameElement.querySelector('i').classList[1] == 'bi-pencil-square') {
		var inputElement = document.createElement('input');
		inputElement.setAttribute('type', 'text');
		inputElement.setAttribute('value', nameElement.querySelector('b').textContent);
		inputElement.name = "newName";
		inputElement.style.width = "200px";

		confirmIcon.classList.add('bi');
		confirmIcon.classList.add('bi-x-square');
		confirmIcon.style.fontSize = "23px";

		nameElement.querySelector('b').parentNode.replaceChild(inputElement, nameElement.querySelector('b'));
		nameElement.querySelector('i').parentNode.replaceChild(confirmIcon, nameElement.querySelector('i'));
	} else {
		var titleElement = document.createElement('b');
		titleElement.innerHTML = nameElement.querySelector('input').value;
		
		confirmIcon.classList.add('bi');
		confirmIcon.classList.add('bi-pencil-square');
		confirmIcon.style.fontSize = "23px";
		
		nameElement.querySelector('input').parentNode.replaceChild(titleElement, nameElement.querySelector('input'));
		nameElement.querySelector('i').parentNode.replaceChild(confirmIcon, nameElement.querySelector('i'));
	}
}