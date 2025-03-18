# Sử dụng Windows Server Core làm base image
FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Đặt múi giờ Asia/Ho_Chi_Minh
RUN powershell -Command "Set-TimeZone -Id 'SE Asia Standard Time'"

# Cài Chocolatey
RUN powershell -Command "Set-ExecutionPolicy Bypass -Scope CurrentUser -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"

# Cài Chrome qua Chocolatey
RUN powershell -Command "choco install googlechrome -y"

# Mở cổng RDP (3389)
RUN powershell -Command "Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name 'fDenyTSConnections' -Value 0; New-NetFirewallRule -DisplayName 'Allow RDP' -Direction Inbound -Protocol TCP -LocalPort 3389 -Action Allow"

# Chạy PowerShell làm CMD (cho container hoạt động)
CMD ["powershell.exe", "-NoExit"]
