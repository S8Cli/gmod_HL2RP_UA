--[[---------------------------------------------------------------------------
Door groups
---------------------------------------------------------------------------
The server owner can set certain doors as owned by a group of people, identified by their jobs.


HOW TO MAKE A DOOR GROUP:
AddDoorGroup("NAME OF THE GROUP HERE, you will see this when looking at a door", Team1, Team2, team3, team4, etc.)
---------------------------------------------------------------------------]]

AddDoorGroup("Біженці", TEAM_REFUGEE, TEAM_RENEGADE, TEAM_DESERTER, TEAM_REFMECH, TEAM_REFMEDIC, TEAM_GUNSELLER, TEAM_CONTRABANDIST, TEAM_SCAVENGER, TEAM_SURVIVOR, TEAM_VORT, TEAM_ADMIN)
AddDoorGroup("Громадяни", TEAM_CITIZEN, TEAM_BANDIT, TEAM_LOYAL1, TEAM_LOYAL2, TEAM_LOYAL3, TEAM_ADMIN)
AddDoorGroup("ГСП", TEAM_OVERSEER, TEAM_COOK, TEAM_WORKER, TEAM_FELDSHER, TEAM_SECRETARY, TEAM_DIRECTOR, TEAM_ADMIN, TEAM_SUPPLIER)
AddDoorGroup("Цивільна Оборона", TEAM_RCT, TEAM_P5, TEAM_P4, TEAM_P3, TEAM_P2, TEAM_P1, TEAM_SNIPER, TEAM_JAGGER, TEAM_OFC, TEAM_SEC, TEAM_DIS, TEAM_ADMINISTRATOR, TEAM_ADMIN, TEAM_GRID)
AddDoorGroup("Командування Цивільної Оборони", TEAM_OFC, TEAM_SEC, TEAM_DIS, TEAM_ADMINISTRATOR, TEAM_ADMIN)
