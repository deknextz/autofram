# ==========================================
# สคริปต์ลบประวัติ PowerShell และ CMD History
# ==========================================

Write-Host "กำลังเคลียร์ประวัติ PowerShell Session..." -ForegroundColor Cyan
Clear-History

Write-Host "กำลังลบไฟล์ประวัติ PowerShell (PSReadLine)..." -ForegroundColor Cyan
$HistoryFile = (Get-PSReadLineOption).HistorySavePath
if ($HistoryFile -and (Test-Path $HistoryFile)) { 
    Remove-Item $HistoryFile -Force 
    Write-Host "- ลบไฟล์ประวัติสำเร็จ: $HistoryFile" -ForegroundColor Green
}

Write-Host "กำลังเคลียร์ประวัติ Run MRU ใน Registry..." -ForegroundColor Cyan
Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU' -Name * -ErrorAction SilentlyContinue

Write-Host "ลบประวัติทั้งหมดเรียบร้อยแล้ว!" -ForegroundColor Yellow