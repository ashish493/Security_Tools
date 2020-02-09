______   ____        ____     __  __  ______  __  __  ____    ____    ____       
# /\__  _\ /\  _`\     /\  _`\  /\ \/\ \/\  _  \/\ \/\ \/\  _`\ /\  _`\ /\  _`\     
# \/_/\ \/ \ \ \L\ \   \ \ \/\_\\ \ \_\ \ \ \L\ \ \ `\\ \ \ \L\_\ \ \L\_\ \ \L\ \   
#   \ \ \  \ \ ,__/    \ \ \/_/_\ \  _  \ \  __ \ \ , ` \ \ \L_L\ \  _\L\ \ ,  /   
#    \_\ \__\ \ \/      \ \ \L\ \\ \ \ \ \ \ \/\ \ \ \`\ \ \ \/, \ \ \L\ \ \ \\ \  
#    /\_____\\ \_\       \ \____/ \ \_\ \_\ \_\ \_\ \_\ \_\ \____/\ \____/\ \_\ \_\
#    \/_____/ \/_/        \/___/   \/_/\/_/\/_/\/_/\/_/\/_/\/___/  \/___/  \/_/\/ /
                                                                                  
                                                                                 
$IPAddress=$(Read-Host "Specify your IP address (ie 192.168.1.10)")   
$InterfaceIndex=$(Read-Host "Enter InterfaceIndex (ie 3) NOTE: Enter 'Show' for help")   
   
   
foreach ($InterfaceIndex in $InterfaceIndex){   
   
        if ($InterfaceIndex -eq "Show" -eq "show") {   
                                                                 
                 Get-NetIPAddress | Format-List -Property InterfaceAlias,InterfaceIndex    
                                   
                }   
                   
                if ($InterfaceIndex -eq "Show" -eq "show") {   
                    $InterfaceIndex=$(Read-Host "Enter InterfaceIndex")   
             }   
   
                if (-Not ($InterfaceIndex -eq "Show" -eq "show"))    
                {   
        }   
}   
                       
   
   
$SubnetMask=$(Read-Host "Enter the subnet mask in bits (ie 24 = 255.255.255.0)")   
$DefaultGateway=$(Read-Host "Enter your Default Gateway (ie 192.168.1.1)")   
$DNSAddresses=$(Read-Host "Set DNS Server Address/Addresses (ie 8.8.8.8)")   
   
New-NetIPAddress -IPAddress $IPAddress -InterfaceIndex $InterfaceIndex -PrefixLength $SubnetMask -DefaultGateway $DefaultGateway   
Set-DnsClientServerAddress -InterfaceIndex $InterfaceIndex -ServerAddresses $DNSAddresses   
   
$Servers = $DefaultGateway,$DNSAddresses    
$Ping=$(Read-Host "Do You want me to Ping your Default Gateway and DNS Servers? Yes/No")   
     
if ($Ping -eq "Yes" -eq "yes") {   
   
    foreach ($Server in $Servers) {   
   
               if (Test-Connection -ComputerName $Server -Count 2 -Quiet) {   
   
                    Write-Host "$Server is alive and Pinging " -ForegroundColor Green 
                       
                }                      
                        else {   
                                 Write-Warning "$Server seems dead not Pinging"          
                                }   
             }   
    }   
                    if ($Ping -eq "No" -eq "no") {   
                                   
                                Write-Host "Good bye!" 
                                 
                                        }   
                                   
                                elseif (-Not ($Ping -eq "Yes" -eq "yes"))    
             {  
              
 }  
 
Read-Host "Press any key to close..." 
 
  