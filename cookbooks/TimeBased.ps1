param(
    [Parameter(Mandatory=$true)]
    [string[]]$StartTime,
    [Parameter(Mandatory=$true)]
    [string[]]$EndTime,
    [Parameter(Mandatory=$true)]
    [int[]]$ABProfile

)

##Example config
#
# $StartTime = "07:40","22:00","00:00"
# $EndTime = "22:00","23:59","07:40"
# $ABProfile = 5,1,1
#
##End Example config


$OCmgrLoc = "D:\Programs\powershell\GPU_OC_Manager\GPU_OC_Manager.ps1"



function inTime{
    param(
        [string]$StartTimeRange,
        [string]$EndTimeRange,
        [string]$NowTimeRange
    )
    $min = Get-Date $StartTimeRange
    $max = Get-Date $EndTimeRange
    $now = Get-Date $NowTimeRange

    if ($min.TimeOfDay -le $now.TimeOfDay -and $max.TimeOfDay -ge $now.TimeOfDay) {
        return $TRUE
    }else{
        return $FALSE
    }

}



#Transitive property of equality. Make sure all arrays are of equal length.
if(($StartTime.Count -eq $EndTime.Count) -and ($StartTime.Count -eq $ABProfile.Count)){
    $now = Get-Date -Format HH:mm
    $arrC = 0
    foreach($range in $StartTime){
        if(inTime -StartTimeRange $StartTime[$arrC] -EndTimeRange $EndTime[$arrC] -NowTimeRange $now){
            Write-Host "Using profile"$ABProfile[$arrC]
            &$OCmgrLoc -profile $ABProfile[$arrC]
        }
        $arrC++

     }



}


