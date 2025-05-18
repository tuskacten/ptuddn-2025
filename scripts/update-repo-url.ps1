param(
    [Parameter(Mandatory=$true)]
    [string]$NewRepoUrl
)

# Đường dẫn gốc của dự án
$projectPath = "d:\eshop-gcp"
$oldRepoUrl = "https://github.com/J0hn-B/eshop-gcp.git"

# Tìm tất cả các file YAML
$files = Get-ChildItem -Path $projectPath -Recurse -Include "*.yaml","*.yml"

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    
    # Nếu file có chứa URL repository cũ
    if ($content -match $oldRepoUrl) {
        Write-Host "Đang cập nhật file: $($file.FullName)"
        
        # Thay thế URL cũ bằng URL mới
        $newContent = $content -replace [regex]::Escape($oldRepoUrl), $NewRepoUrl
        
        # Ghi nội dung mới vào file
        Set-Content -Path $file.FullName -Value $newContent
    }
}

Write-Host "Cập nhật hoàn tất. Tất cả các URL đã được thay thế."
