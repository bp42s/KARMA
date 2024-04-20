Scriptname KARM:CentralEventQuest extends karmaLib


;; IMPORTS
;; n/a



;; VARIABLES
;; n/a



;; PROPERTIES
;
;; inherirted from superclass karmaLib



;; ---### INITIAL QUEST REGISTRATION ###---
Event OnQuestInit()
	Debug.OpenUserLog("KARMA")
	Debug.TraceUser("KARMA", "CentralEventQuest: Quest started")
	registerAffinity()
	registerTrackedStats()
EndEvent



;; ---### AFFINITY EVENTS ###---
;;
;; ---### EVENTS - AFFINITY
;;
Event FollowersScript.AffinityEvent(FollowersScript akSender, Var[] args)
	Keyword TopicKeyword = args[4] as Keyword
	if(KARM_MCM_EnableKarma_AffinityEvents.GetValueInt() == 1)
		;
		if(TopicKeyword == CAT__CustomEvent_Generous_Topic)
			modKarma(40)
			;
		elseif(TopicKeyword == CAT__CustomEvent_Nice_Topic)
			modKarma(15)
			;
		elseif(TopicKeyword == CAT__CustomEvent_Peaceful_Topic)
			modKarma(10)
			;
		elseif(TopicKeyword == CAT__CustomEvent_PeacefulFailed_Topic)
			modKarma(5)
			;
		elseif(TopicKeyword == CAT__CustomEvent_Selfish_Topic)
			modKarma(-15)
			;
		elseif(TopicKeyword == CAT__CustomEvent_Mean_Topic)
			modKarma(-20)
			;
		elseif(TopicKeyword == CAT__CustomEvent_Violent_Topic)
			modKarma(-30)
			;
		elseif(TopicKeyword == CAT__Event_DonateItem_Topic)
			modKarma(30)
			;
		elseif(TopicKeyword == CAT_Event_HealCompanion_Topic)
			if(KARM_MCM_EnableKarma_HealCompanion.GetValueInt() == 1)
				modKarma(10)
			endif
			;
		elseif(TopicKeyword == CAT_Event_HealDogmeant_Topic)
			if(KARM_MCM_EnableKarma_HealCompanion.GetValueInt() == 1)
				modKarma(10)
			endif
			;
		elseif(TopicKeyword == CAT_Event_DogmeatBleedout_Topic)
			modKarma(-50)
			;
		elseif(TopicKeyword == CAT__Event_SpeechForMoreCaps_Topic)
			if(KARM_MCM_EnableKarma_SpeechForMoreCaps.GetValueInt() == 1)
				modKarma(-15)
			endif
			;
		elseif(TopicKeyword == CA__CustomEvent_MinSettlementHelp)
			modKarma(40)
			;
		elseif(TopicKeyword == CA__CustomEvent_MinSettlementRefuseHelp)
			modKarma(-40)
			;
		endif
		;
	endif
	Debug.TraceUser("KARMA", "Central Event Quest: TopicKeyword: " + TopicKeyword)
EndEvent


;; ---### FUNCTIONS - AFFINITY
;;
;; ###
Function registerAffinity()
	RegisterForCustomEvent(FollowersProperty, "AffinityEvent")
	Debug.TraceUser("KARMA", "Central Event Quest: FollowersScript AffinityEvent registered")
EndFunction





;; ---### TRACKED STATS EVENTS ###---
;;
;; ---### EVENTS - TRACKED STATS
;;
Event OnTrackedStatsEvent(string asStat, int aiStatValue)
	;;
	;; ### FACTION QUESTS
	if(asStat == "Brotherhood of Steel Quests Completed")
		if(KARM_MCM_EnableKarma_QuestsBrotherhood.GetValueInt() != 0)
			int brotherhoodValue = KARM_MCM_EnableKarma_QuestsBrotherhood.GetValueInt()
			if(brotherhoodValue == 1)  ;; GAIN
				modKarma(40)
			elseif(brotherhoodValue == 2)  ;; LOSS
				modKarma(-40)
			endif
		endif
		initBrotherhood()
		;;
	elseif(asStat == "Institute Quests Completed")
		if(KARM_MCM_EnableKarma_QuestsInstitute.GetValueInt() != 0)
			int instituteValue = KARM_MCM_EnableKarma_QuestsInstitute.GetValueInt()
			if(instituteValue == 1)  ;; GAIN
				modKarma(40)
			elseif(instituteValue == 2)  ;; LOSS
				modKarma(-40)
			endif
		endif
		initInstitute()
		;;
	elseif(asStat == "Minutemen Quests Completed")
		if(KARM_MCM_EnableKarma_QuestsMinutemen.GetValueInt() != 0)
			int minutemenValue = KARM_MCM_EnableKarma_QuestsMinutemen.GetValueInt()
			if(minutemenValue == 1)  ;; GAIN
				modKarma(40)
			elseif(minutemenValue == 2)  ;; LOSS
				modKarma(-40)
			endif
		endif
		initMinutemen()
		;;
	elseif(asStat == "Railroad Quests Completed")
		if(KARM_MCM_EnableKarma_QuestsRailroad.GetValueInt() != 0)
			int railroadValue = KARM_MCM_EnableKarma_QuestsRailroad.GetValueInt()
			if(railroadValue == 1)  ;; GAIN
				modKarma(40)
			elseif(railroadValue == 2)  ;; LOSS
				modKarma(-40)
			endif
		endif
		initRailroad()
		;;
		;;
		;;
	;; ### EVENT CHECKS
	elseif(asStat == "Times Addicted")
		if(KARM_MCM_EnableKarma_Addiction.GetValueInt() == 1)
			modKarma(-25)
		endif
		initAddiction()
		;;
	elseif(asStat == "Corpses Eaten")
		if(KARM_MCM_EnableKarma_Cannibalism.GetValueInt() == 1)
			modKarma(-75)
		endif
		initCannibalism()
		;;
	elseif(asStat == "Workshops Unlocked")
		if(KARM_MCM_EnableKarma_ClaimSettlement.GetValueInt() == 1)
			modKarma(35)
		endif
		initClaimSettlement()
		;;
	elseif(asStat == "Dungeons Cleared")
		if(KARM_MCM_EnableKarma_ClearDungeon.GetValueInt() == 1)
			modKarma(25)
		endif
		initDungeon()
		;;
	elseif(asStat == "Supply Lines Created")
		if(KARM_MCM_EnableKarma_CreateSupplyLine.GetValueInt() == 1)
			modKarma(15)
		endif
		initSupplyLine()
		;;
	endif
	Debug.TraceUser("KARMA", "Central Event Quest: asStat: " + asStat)
	;;
EndEvent



;; ---### FUNCTIONS - TRACKED STATS
;;
;; ### Initializes all registered tracked stats, in one function
Function registerTrackedStats()
	;; FACTION QUESTS
	initBrotherhood()
	initInstitute()
	initMinutemen()
	initRailroad()
	
	;; EVENTS
	initAddiction()
	initCannibalism()
	initClaimSettlement()
	initDungeon()
	initSupplyLine()
	Debug.TraceUser("KARMA", "Central Event Quest: registerTrackedStats() ran")
EndFunction


;; ### TRACKED STATS INIT FUNCTIONS
;; all of these functions register for the relevant tracked stats events
;;
;; ### FACTION QUESTS
Function InitBrotherhood() 
	Self.RegisterForTrackedStatsEvent("Brotherhood of Steel Quests Completed", Game.QueryStat("Brotherhood of Steel Quests Completed") + 1)
EndFunction

Function initInstitute()
	Self.RegisterForTrackedStatsEvent("Institute Quests Completed", Game.QueryStat("Institute Quests Completed") + 1)
EndFunction

Function InitMinutemen()
	Self.RegisterForTrackedStatsEvent("Minutemen Quests Completed", Game.QueryStat("Minutemen Quests Completed") + 1)
EndFunction

Function initRailroad()
	Self.RegisterForTrackedStatsEvent("Railroad Quests Completed", Game.QueryStat("Railroad Quests Completed") + 1)
EndFunction


;; ### EVENTS
Function initAddiction()
	Self.RegisterForTrackedStatsEvent("Times Addicted", Game.QueryStat("Times Addicted") + 1)
EndFunction

Function initCannibalism()
	Self.RegisterForTrackedStatsEvent("Corpses Eaten", Game.QueryStat("Corpses Eaten") + 1)
EndFunction

Function initClaimSettlement()
	Self.RegisterForTrackedStatsEvent("Workshops Unlocked", Game.QueryStat("Workshops Unlocked") + 1)
EndFunction

Function initDungeon()
	Self.RegisterForTrackedStatsEvent("Dungeons Cleared", Game.QueryStat("Dungeons Cleared") + 1)
EndFunction

Function initSupplyLine()
	Self.RegisterForTrackedStatsEvent("Supply Lines Created", Game.QueryStat("Supply Lines Created") + 1)
EndFunction