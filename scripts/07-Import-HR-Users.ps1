# INFRA-001 - Import HR Users into Active Directory
# OmniVerse Enterprise

Import-Module ActiveDirectory

$CsvPath = "C:\OmniVerse\OmniVerse-HR-Employees.csv"
$LogDirectory = "C:\OmniVerse\Logs"
New-Item -ItemType Directory -Path $LogDirectory -Force | Out-Null

$LogPath = "$LogDirectory\UserImport-Clean-$(Get-Date -Format 'yyyyMMdd-HHmmss').log"
$DefaultPassword = ConvertTo-SecureString "OmniVerse2026!" -AsPlainText -Force

$Created = 0
$Skipped = 0
$Errors  = 0

$Users = Import-Csv $CsvPath

foreach ($User in $Users) {
    try {
        $ExistingUser = Get-ADUser -Filter "EmployeeID -eq '$($User.EmployeeID)'" -ErrorAction SilentlyContinue

        if ($ExistingUser) {
            $Skipped++
            Add-Content $LogPath "SKIPPED: $($User.SamAccountName) already exists"
            continue
        }

        $DeptOU = "OU=Users,OU=$($User.Department),OU=Departments,OU=OmniVerse,DC=corp,DC=omniverse,DC=com"

        New-ADUser `
            -Name $User.ADName `
            -GivenName $User.FirstName `
            -Surname $User.LastName `
            -DisplayName $User.DisplayName `
            -SamAccountName $User.SamAccountName `
            -UserPrincipalName $User.UserPrincipalName `
            -EmployeeID $User.EmployeeID `
            -Department $User.Department `
            -Title $User.Title `
            -Office $User.Office `
            -Company $User.Company `
            -Path $DeptOU `
            -AccountPassword $DefaultPassword `
            -Enabled $true `
            -ChangePasswordAtLogon $true

        $Created++
        Add-Content $LogPath "CREATED: $($User.SamAccountName) - $($User.EmployeeID)"
    }
    catch {
        $Errors++
        Add-Content $LogPath "ERROR: $($User.SamAccountName) - $($User.EmployeeID) - $($_.Exception.Message)"
    }
}

Write-Host ""
Write-Host "=======================================" -ForegroundColor Cyan
Write-Host " OmniVerse Clean HR Import Complete" -ForegroundColor Green
Write-Host "=======================================" -ForegroundColor Cyan
Write-Host " Users Created : $Created" -ForegroundColor Green
Write-Host " Users Skipped : $Skipped" -ForegroundColor Yellow
Write-Host " Errors        : $Errors" -ForegroundColor Red
Write-Host " Log File      : $LogPath" -ForegroundColor Cyan
Write-Host "=======================================" -ForegroundColor Cyan

Get-ADUser -Filter "EmployeeID -like 'OV*'" |
    Measure-Object
