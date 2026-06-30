# INFRA-001 - Generate HR Employee Import Dataset
# OmniVerse Enterprise

$ExportPath = "C:\OmniVerse"
New-Item -ItemType Directory -Path $ExportPath -Force | Out-Null

$Departments = @("IT","HR","Finance","Security","Legal","Operations","Engineering","Sales","Marketing","Executive")

$Titles = @{
    "IT" = @("Systems Administrator","Help Desk Analyst","IAM Analyst","Infrastructure Engineer","Desktop Support Technician")
    "HR" = @("HR Specialist","Recruiter","Benefits Coordinator","HR Manager","Talent Acquisition Specialist")
    "Finance" = @("Accountant","Financial Analyst","Payroll Specialist","Finance Manager","Accounts Payable Analyst")
    "Security" = @("Security Analyst","SOC Analyst","Security Engineer","Compliance Analyst","Incident Response Analyst")
    "Legal" = @("Legal Assistant","Paralegal","Compliance Counsel","Legal Manager","Contracts Specialist")
    "Operations" = @("Operations Analyst","Operations Manager","Logistics Coordinator","Business Analyst","Program Coordinator")
    "Engineering" = @("Software Engineer","Cloud Engineer","DevOps Engineer","QA Engineer","Platform Engineer")
    "Sales" = @("Sales Representative","Account Executive","Sales Manager","Customer Success Specialist","Business Development Rep")
    "Marketing" = @("Marketing Specialist","Content Strategist","SEO Analyst","Marketing Manager","Brand Coordinator")
    "Executive" = @("Director","Vice President","Chief Information Officer","Chief Security Officer","Chief Financial Officer")
}

$FirstNames = @(
    "James","Michael","Robert","John","David","William","Richard","Joseph","Thomas","Christopher",
    "Sarah","Jessica","Ashley","Emily","Amanda","Brittany","Elizabeth","Megan","Lauren","Rachel",
    "Anthony","Kevin","Brian","Jason","Matthew","Daniel","Andrew","Justin","Ryan","Brandon",
    "Natalie","Victoria","Jasmine","Morgan","Taylor","Brianna","Kayla","Danielle","Alexis","Jordan"
)

$LastNames = @(
    "Smith","Johnson","Williams","Brown","Jones","Garcia","Miller","Davis","Rodriguez","Martinez",
    "Hernandez","Lopez","Gonzalez","Wilson","Anderson","Thomas","Taylor","Moore","Jackson","Martin",
    "Lee","Perez","Thompson","White","Harris","Sanchez","Clark","Ramirez","Lewis","Robinson",
    "Walker","Young","Allen","King","Wright","Scott","Torres","Nguyen","Hill","Flores"
)

$OfficeData = @(
    @{ Office="HQ"; City="Norfolk"; State="VA" },
    @{ Office="East"; City="Arlington"; State="VA" },
    @{ Office="Central"; City="Dallas"; State="TX" },
    @{ Office="West"; City="Phoenix"; State="AZ" }
)

$EmployeeTypes = @("Full-Time","Full-Time","Full-Time","Contractor","Intern")

$Employees = for ($i = 1; $i -le 2000; $i++) {
    $Dept = Get-Random $Departments
    $First = Get-Random $FirstNames
    $Last = Get-Random $LastNames
    $Office = Get-Random $OfficeData
    $EmployeeId = "OV{0:D5}" -f $i
    $Sam = ("ovuser{0:D5}" -f $i).ToLower()
    $UPN = "$Sam@corp.omniverse.com"
    $HireDate = (Get-Date).AddDays(-(Get-Random -Minimum 1 -Maximum 1460)).ToString("yyyy-MM-dd")

    [PSCustomObject]@{
        EmployeeID        = $EmployeeId
        FirstName         = $First
        LastName          = $Last
        DisplayName       = "$First $Last"
        ADName            = "$First $Last - $EmployeeId"
        SamAccountName    = $Sam
        UserPrincipalName = $UPN
        Department        = $Dept
        Title             = Get-Random $Titles[$Dept]
        Manager           = ""
        Office            = $Office.Office
        City              = $Office.City
        State             = $Office.State
        HireDate          = $HireDate
        EmployeeType      = Get-Random $EmployeeTypes
        Company           = "OmniVerse Enterprise"
    }
}

$CsvPath = "$ExportPath\OmniVerse-HR-Employees.csv"
$Employees | Export-Csv $CsvPath -NoTypeInformation

Write-Host "Generated clean HR export with 2,000 unique users." -ForegroundColor Green
Write-Host $CsvPath -ForegroundColor Cyan

Import-Csv $CsvPath |
    Select-Object EmployeeID,FirstName,LastName,Department,Title,Office |
    Select-Object -First 25
