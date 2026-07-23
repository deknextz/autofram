# 1. ตั้งค่าตัวแปร (เปลี่ยนชื่อไฟล์และลิงก์ให้เป็นของคุณ)
$appName = "Autofram"
$exeName = "Autofram.exe"
$downloadUrl = "https://github.com/deknextz/autofram/raw/main/AutoFram.exe" # <--- ใส่ลิงก์ตรงของ .exe ที่นี่
$installDir = "$env:LOCALAPPDATA\$appName"
$exePath = "$installDir\$exeName"

# 2. สร้างโฟลเดอร์สำหรับเก็บโปรแกรมหากยังไม่มี
if (!(Test-Path $installDir)) { 
    New-Item -ItemType Directory -Path $installDir | Out-Null 
}

Write-Host "Downloading $exeName..." -ForegroundColor Cyan

# 3. ลบไฟล์เก่าออก (ถ้ามี)
if (Test-Path $exePath) {
    Write-Host "  removed: $exePath" -ForegroundColor DarkGray
    Remove-Item -Path $exePath -Force
}

Write-Host "  try 1/2: $downloadUrl" -ForegroundColor DarkGray

# 4. ทำการดาวน์โหลดไฟล์ .exe
Invoke-WebRequest -Uri $downloadUrl -OutFile $exePath

# 5. ตรวจสอบขนาดไฟล์และแสดงข้อความเมื่อดาวน์โหลดเสร็จ
$fileInfo = Get-Item $exePath
Write-Host "Downloaded: $exePath ($($fileInfo.Length) bytes)" -ForegroundColor Green

Write-Host "Starting $appName..." -ForegroundColor Cyan
Write-Host "Running. Waiting until you close the program..." -ForegroundColor Green
Write-Host "(Do not close this PowerShell window)" -ForegroundColor Yellow

# 6. สั่งรันโปรแกรม และให้ PowerShell รอจนกว่าโปรแกรมจะถูกปิด (-Wait)
Start-Process -FilePath $exePath -Wait