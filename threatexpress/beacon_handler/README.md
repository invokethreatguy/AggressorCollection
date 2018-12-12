# Beacon Handler Suite

## CobaltStrike Aggressor Script Framework 

```
###################################################################
 CobaltStrike Aggressor Script Framework © Joe Vest, Andrew Chiles 2018                                  
 Author:      Joe Vest, Andrew Chiles
 Description: Aggressor script. Sets global variables and loads other scripts
 Version:     CobaltStrike 3.11
###################################################################")
```

This collection of aggressor scripts are designed to help manage beacons.

## Details

__Primary Script__

 - init.cna : main script designed to hold global variables and call helper scripts

__Modules__

 - handler.cna : provides functionality for handling beacons
 - automigrate.cna : Auto or manual migration of beacon to new process

## Usage

- Modify the global variable in init.cna
- Load init.cna using the script manager

# Global Variables

The following are used through out this framework. They can be set in the script or at runtime using the script functions.

| Variable            | Default         | Description |
|---------------------|-----------------|------------|
| g_initialSleep      | 60              | Sleep set at inital beacon in seconds
| g_initialJitter     | 20              | Jitter set at inital beacon as percentage
| g_deadThreshold     | int(900 * 1000) | Time use to mark when a beacon is considered dead
| g_basePath          | modules/        | Base path for scripts
| g_adminMigrationBin | winlogon.exe    | Binary used for Admin level migration
| g_userMigrationBin  | explorer.exe    | Binary used for User level migration
| g_enableMigration   | false           | Enable or Disable Migration 

## Scripts Functions 

The following commands are availble in the script console. Modify to change behavior at runtime.

```
setg_InitialSleep 
setg_InitialJitter 
setg_deadThreshold 
setg_basePath 
setg_userMigrationBin 
setg_adminMigrationBin 
setg_enableMigration 
```