##########################################################################
# This script the initial configuration of a server: name, ip, gateway,  #
# subnet mask, DNS and disable IPv6.                                     #
##########################################################################


# Variables
$netname = "Ethernet"

# Start Event Log
Start-Transcript ("C:\config_srv_Log {0:yyyyMMdd - HHmm}.txt" -f (Get-Date))

#Define Name of the Server
$nameserver = Read-Host "Enter the name of the server"
Rename-Computer -NewName $nameserver;

#Define Static IP and DNS.
$IP = Read-Host "Type IP address"
$GW = Read-Host "Type Gateway address"
$SM = Read-Host "Type Subnet Mask address (for example: 24)"
$DNS1 = Read-Host "Type Primary DNS address"
$DNS2 = Read-Host "Type Secondary DNS address"

#Rename on NIC Adapter
Rename-NetAdapter -Name "$netname" -NewName "LAN"

#Disable IPv6 on the NIC adapter
Disable-NetAdapterBinding -Name "LAN" -ComponentID ms_tcpip6

#Set static IP with DNS.
New-NetIPAddress -InterfaceAlias LAN -IPAddress $IP -DefaultGateway $GW -AddressFamily IPv4 -PrefixLength $SM;
Set-DnsClientServerAddress -InterfaceAlias LAN -ServerAddresses ("$DNS1","$DNS2");

#Stop Event Log
Stop-Transcript

#Restart the server.
Restart-Computer -Force;