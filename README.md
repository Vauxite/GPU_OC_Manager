# GPU_OC_Manager
Swap Afterburner profiles


Example setup:

1. Open TaskScheduler
2. Tick "Run with highest privileges"
3. Triggers/Trigger
    1. Specific user
    2. Begin the task on workstation lock
4. Actions/Action
    1. Start a program
        1. Program/script: powershell
        2. -Command "& D:\Programs\powershell\GPU_OC_Manager\GPU_OC_Manager.ps1 -profile <id>"
    
    
    
