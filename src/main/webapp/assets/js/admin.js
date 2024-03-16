function autoAddFile(path) {
	var fileURL = path;
	fetch(fileURL)
		.then(response => response.blob())
		.then(blob => {
			var fileName = 'file.txt'; // Tên tệp

			// Tạo biến kiểu File từ Blob
			var file = new File([blob], fileName, { type: 'text/plain' });
			console.log(file); // Kiểm tra biến file đã tạo

			// Đoạn mã ở đây: Xử lý tệp đã lấy
		})
		.catch(error => {
			console.error('Lỗi khi lấy tệp:', error);
		});
	
	console.log(file);
}
