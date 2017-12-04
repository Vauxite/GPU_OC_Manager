param(
    [Parameter(Mandatory=$true)]
    [int]$profile
)

#Setup executable paths
$NiceHashPath = "C:\Program Files\NiceHash Miner 2\NiceHash Miner 2.exe"
$AfterBurnerPath = "C:\Program Files (x86)\MSI Afterburner\MSIAfterburner.exe"


#Setup Event-Logger
$SourceName = "GPU_OC_Manager"
$LogName = "Application"
$EventlogExist = [System.Diagnostics.EventLog]::SourceExists($SourceName)
if(!$EventlogExist){
    New-EventLog -Source $SourceName -LogName $LogName
}



function startAB{
param( [int]$Profile)
    Start-Process -FilePath $AfterBurnerPath -ArgumentList "/s -Profile$Profile"
}

function startNH{
    $exist = Get-Process "NiceHash Miner 2" -ErrorAction SilentlyContinue
    if(!$exist){    
        Start-Process -FilePath $NiceHashPath
    }
}

function writeEventLog{
param( [string]$msg, [int]$TypeID, [int]$EventID)
    switch ($TypeID){
        0 {
            $Etype = "Information"
        }
        1 {
            $Etype = "Warning"
        }        
        2 {
            $Etype = "Error"
        }
        default {
            $Etype = "Unkown"
        }
    }
    Write-EventLog -LogName $LogName -Source $SourceName -EventId $EventID -EntryType $Etype -Message $msg


}

function killAfterburner{ 
    $MSI_AB = Get-Process "MSIAfterburner" -ErrorAction SilentlyContinue 
    if ($MSI_AB) {
      $MSI_AB.CloseMainWindow()

      Sleep 5
      if (!$MSI_AB.HasExited) {
        $MSI_AB | Stop-Process
      }
      if ($MSI_AB.HasExited) {
        return $true
      }else{
        return $false
      }
    }else{
        return $true
    }
}

$killed = killAfterburner
if($killed){
    startAB($profile)
    writeEventlog("Applied afterburner profile $profile")
}

