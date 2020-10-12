

$outstr = Get-WindowsCapability -Online | ? Name -like 'OpenSSH*' | out-string
$outstr = ($outstr -split " ")
$outstr = ($outstr -split "\n")
foreach ($item in $outstr) {
    if ($item -like "OpenSSH*") {
        Add-WindowsCapability -Online -Name $item
    }
}

Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'
Get-NetFirewallRule -Name *ssh*
New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22