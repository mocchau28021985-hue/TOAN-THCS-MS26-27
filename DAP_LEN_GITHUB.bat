@echo off
chcp 65001 >nul
title DONG BO HE THONG WEB TOAN THCS LEN GITHUB PAGES
echo =========================================================================
echo       HỆ THỐNG ĐỒNG BỘ ĐỀ THI TOÁN THCS LÊN GITHUB PAGES
echo       (Quản lý 4 Kì Thi: Giữa kì I - Cuối kì I - Giữa kì II - Cuối kì II)
echo =========================================================================
echo.

set "CONFIG_FILE=%~dp0github_repo_config.txt"

if exist "%CONFIG_FILE%" (
    set /p REPO_URL=<"%CONFIG_FILE%"
)

if "%REPO_URL%"=="" (
    echo [LẦN ĐẦU CÀI ĐẶT] Thầy/Cô dán đường link GitHub Repo vào bên dưới:
    echo (Ví dụ mẫu: https://github.com/thay-thuy/toan-thcs.git)
    echo.
    set /p REPO_URL=">> Nhập link GitHub Repo của Thầy/Cô: "
    echo %REPO_URL%> "%CONFIG_FILE%"
) else (
    echo [CẤU HÌNH ĐÃ LƯU] Đang đồng bộ tới Repo: %REPO_URL%
    echo (Muốn đổi sang Repo khác, Thầy/Cô chỉ cần xóa file: github_repo_config.txt)
    echo.
)

if "%REPO_URL%"=="" (
    echo [LỖI] Chưa nhập link GitHub Repository! Vui lòng mở lại và dán link.
    pause
    exit /b
)

cd /d "%~dp0"

echo [1/4] Kiểm tra kho lưu trữ Git cục bộ...
if not exist ".git" (
    git init
    git branch -M main
)
git config user.name "GiaoVienToanTHCS" >nul 2>&1
git config user.email "giaovien@toanthcs.edu.vn" >nul 2>&1

echo [2/4] Đang quét và đóng gói toàn bộ đề thi mới...
git add -A

echo [3/4] Đang tạo bản lưu trữ hệ thống...
for /f "tokens=1-4 delims=/ " %%a in ('date /t') do set CDATE=%%a-%%b-%%c
for /f "tokens=1-2 delims=: " %%a in ('time /t') do set CTIME=%%a:%%b
git commit -m "Cap nhat de thi va he thong ngay %CDATE% luc %CTIME%"

echo [4/4] Đang truyền tải dữ liệu lên GitHub...
git remote remove origin >nul 2>&1
git remote add origin %REPO_URL%
git push -u origin main --force

if %errorlevel% equ 0 (
    echo.
    echo =========================================================================
    echo [THÀNH CÔNG RỰC RỠ] TOÀN BỘ HỆ THỐNG ĐÃ ĐƯỢC ĐẨY LÊN GITHUB!
    echo.
    echo Sau 30 giây đến 1 phút, trang Web sẽ tự động cập nhật trực tuyến tại:
    echo 👉 https://<ten-user>.github.io/<ten-repo>/
    echo.
    echo Mọi đề thi mới (Cuối kì 1, Giữa kì 2, Cuối kì 2) sau này Thầy/Cô chỉ cần
    echo bấm đúp vào file này là Web tự động cập nhật ngay lập tức!
    echo =========================================================================
) else (
    echo.
    echo =========================================================================
    echo [CHÚ Ý] Lỗi kết nối hoặc cần xác thực đăng nhập GitHub!
    echo Nếu là lần đầu tiên tải lên, trình duyệt sẽ hiện cửa sổ yêu cầu
    echo bấm "Sign in with your browser" để cấp quyền.
    echo =========================================================================
)

echo.
pause
