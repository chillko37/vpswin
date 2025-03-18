# File: setup-windows-vps.ps1
# Script để cấu hình VPS Windows Server (chạy với quyền Administrator)

# 1. Mở cổng RDP (3389) trong Firewall
Write-Host "Opening RDP port (3389) in Windows Firewall..."
New-NetFirewallRule -DisplayName "Allow RDP" -Direction Inbound -Protocol TCP -LocalPort 3389 -Action Allow

# 2. Đảm bảo RDP được bật
Write-Host "Enabling Remote Desktop..."
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0

# 3. Tạm tắt Firewall để kiểm tra (khuyến cáo bật lại sau khi test xong)
Write-Host "Disabling Firewall temporarily for testing..."
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

# 4. Cài Chocolatey (package manager cho Windows)
Write-Host "Installing Chocolatey..."
Set-ExecutionPolicy Bypass -Scope CurrentUser -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# 5. Cài các phần mềm cơ bản qua Chocolatey
Write-Host "Installing Google Chrome..."
choco install googlechrome -y

# 6. Đặt múi giờ thành Asia/Ho_Chi_Minh
Write-Host "Setting timezone to Asia/Ho_Chi_Minh..."
Set-TimeZone -Id "SE Asia Standard Time"

# 7. Thông báo hoàn tất và khởi động lại
Write-Host "Setup completed! Restarting VPS to apply changes..."
Start-Sleep -Seconds 5
Restart-Computer -Force
