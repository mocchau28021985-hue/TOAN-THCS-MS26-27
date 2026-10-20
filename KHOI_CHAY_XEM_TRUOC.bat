@echo off
chcp 65001 >nul
title XEM TRUOC HE THONG WEB TOAN THCS
echo =========================================================================
echo    ĐANG KHỞI CHẠY MÁY CHỦ XEM TRƯỚC HỆ THỐNG TRỰC TUYẾN
echo =========================================================================
echo.
echo Đang mở trình duyệt tại: http://localhost:8080/
echo (Bấm Ctrl + C để dừng máy chủ xem trước khi xong)
echo.
cd /d "%~dp0"
start http://localhost:8080/index.html
python -m http.server 8080
pause
