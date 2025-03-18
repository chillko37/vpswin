# File: setup-windows-vps.ps1
# Script chạy trên Windows Server thực sự (không dùng Wine)

# 1. Bật Remote Desktop (RDP)
Write-Host "Enabling Remote Desktop..."
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# 2. Mở cổng 3389 trong Firewall
Write-Host "Opening RDP port (3389)..."
New-NetFirewallRule -DisplayName "Allow RDP" -Direction Inbound -Protocol TCP -LocalPort 3389 -Action Allow -Enabled True

# 3. Cài Chocolatey
Write-Host "Installing Chocolatey..."
Set-ExecutionPolicy Bypass -Scope CurrentUser -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# 4. Cài phần mềm cơ bản
Write-Host "Installing Google Chrome and 7-Zip..."
choco install googlechrome -y
choco install 7zip -y

# 5. Đặt múi giờ Asia/Ho_Chi_Minh
Write-Host "Setting timezone to Asia/Ho_Chi_Minh..."
Set-TimeZone -Id "SE Asia Standard Time"

# 6. Tạo user mới (tùy chọn)
Write-Host "Creating new user 'vpsuser'..."
net user vpsuser Password123! /add
net localgroup "Administrators" vpsuser /add

# 7. Khởi động lại
Write-Host "Setup complete! Restarting VPS..."
Start-Sleep -Seconds 5
Restart-Computer -Force
