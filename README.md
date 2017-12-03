# GPU_OC_Manager
Swap Afterburner profiles based on events

Expand the switch statement to add additional event.

Example setup:
1. Open TaskScheduler
2. Tick "Run with highest privileges"
3. Triggers/Trigger
  a) Specific user
  b) Begin the task on workstation lock
4. Actions/Action
  a) Start a program
    I)  Program/script: powershell
    II) -Command "& D:\Programs\powershell\GPU_OC_Manager\GPU_OC_Manager.ps1 -event lock"
    
    
    
