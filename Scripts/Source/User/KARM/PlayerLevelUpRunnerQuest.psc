Scriptname KARM:PlayerLevelUpRunnerQuest extends karmaLib



;; ---### PROPERTIES ###---
;;
Group Quests
	Quest Property KARM_CentralEventQuest Auto
EndGroup



;; ---### EVENTS ###---
;;
;; ### Restarts KARM_CentralEventQuest on player levelup so karma keeps working correctly during long play sessions
Event OnStoryIncreaseLevel(int aiNewLevel)
	Debug.TraceUser("KARMA", "PlayerLevelUpRunnerQuest: Quest started")
	restartCentralEventQuest()
	updateKarmaTitle()  ;; inherited from superclass karmaLib
	;
	Self.Stop()
EndEvent



;; ---### FUNCTIONS ###---
;;
;; ### Restarts central event quest on levelup, so events are re-registered and it works on long play sessions
Function restartCentralEventQuest()
	Utility.Wait(0.1)
	KARM_CentralEventQuest.Stop()
	Debug.TraceUser("KARMA", "PlayerLevelUpRunnerQuest: CentralEventQuest was stopped")
	Utility.Wait(0.1)
	KARM_CentralEventQuest.Start()
	Debug.TraceUser("KARMA", "PlayerLevelUpRunnerQuest: CentralEventQuest was started")
EndFunction