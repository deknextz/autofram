# 1. ตั้งค่าชื่อโปรแกรมและลิงก์ตรงของไฟล์ .exe บน GitHub ของคุณ
$appName = "AutoFram"
$exeName = "AutoFram.exe"
$downloadUrl = "https://github.com/deknextz/autofram/raw/main/AutoFram2.exe" # <--- ใส่ลิงก์ตรงของ .exe ที่นี่

# 2. เปลี่ยนให้ไปดาวน์โหลดไว้ในโฟลเดอร์ชั่วคราว (Temp) แทนการติดตั้ง
$tempDir = [System.IO.Path]::GetTempPath()
$exePath = Join-Path $tempDir $exeName

Write-Host "Downloading $exeName to temporary memory..." -ForegroundColor Cyan

# 3. ลบไฟล์เก่าใน Temp (ถ้ามีค้างอยู่)
if (Test-Path $exePath) {
    Remove-Item -Path $exePath -Force -ErrorAction SilentlyContinue
}

# 4. ดาวน์โหลดไฟล์ .exe ลงโฟลเดอร์ Temp
Invoke-WebRequest -Uri $downloadUrl -OutFile $exePath

$fileInfo = Get-Item $exePath
Write-Host "Downloaded successfully: $($fileInfo.Length) bytes" -ForegroundColor Green

Write-Host "Starting $appName..." -ForegroundColor Cyan
Write-Host "Running. Waiting until you close the program..." -ForegroundColor Green
Write-Host "(Do not close this PowerShell window)" -ForegroundColor Yellow

# 5. สั่งรันโปรแกรมจากโฟลเดอร์ Temp และรอจนกว่าผู้ใช้จะปิดโปรแกรม
Start-Process -FilePath $exePath -Wait

# 6. (ทางเลือก) ลบไฟล์ทิ้งทันทีหลังจากปิดโปรแกรม เพื่อไม่ให้เหลือซากบนเครื่อง
Remove-Item -Path $exePath -Force -ErrorAction SilentlyContinue
Write-Host "Program closed. Temporary files cleaned up." -ForegroundColor DarkGray