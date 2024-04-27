<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel</title>
    <link rel="stylesheet" href="adminPanel.css">
</head>
<style>
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
}

.container {
    display: flex;
    height: 100%;
}

.sidebar {
    background-color: #333;
    color: #fff;
    min-width: 200px;
    height: 100%; /* Chiều cao của thanh điều hướng bằng chiều cao của toàn màn hình */
}

.main-content {
    flex: 1;
    padding: 20px;
    height: 100%; /* Chiều cao của khu vực nội dung chính bằng chiều cao của toàn màn hình */
    overflow-y: auto; /* Hiển thị thanh cuộn nếu nội dung vượt quá kích thước của khu vực nội dung */
}

header {
    padding: 20px 0;
}

header h1 {
    margin: 0;
    font-size: 24px;
}

section {
    padding: 20px 0;
}

</style>
<body>
    <div class="container">
        <nav class="sidebar">
            <ul>
                <li><a href="#">Dashboard</a></li>
                <li><a href="#">Users</a></li>
                <li><a href="#">Products</a></li>
                <li><a href="#">Orders</a></li>
                <li><a href="#">Settings</a></li>
            </ul>
        </nav>
        <div class="main-content">
            <header>
                <h1>Welcome to Admin Panel</h1>
            </header>
            <section>
                <p>This is the main content area where you can manage your website.</p>
            </section>
        </div>
    </div>
</body>
</html>
