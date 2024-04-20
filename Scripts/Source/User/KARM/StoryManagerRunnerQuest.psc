Scriptname KARM:StoryManagerRunnerQuest extends karmaLib
{ Started by various story manager events, modifies karma when the player commits certain actions based on criteria }


;; ---### EVENTS ###---
;;
;; ### ASSAULT ACTOR
Event OnStoryAssaultActor(ObjectReference akVictim, ObjectReference akAttacker, Location akLocation, int aiCrime)
	modKarma(-35)
	Debug.TraceUser("KARMA", "StoryManagerRunnerQuest: OnStoryAssaultActor ran, victim: " + akVictim.getName())
	;
	Self.Stop()
EndEvent



;; ### CHANGE LOCATION
Event OnStoryChangeLocation(ObjectReference akActor, Location akOldLocation, Location akNewLocation)
	;; ## if player is trespassing
	if(KARM_MCM_EnableKarma_Trespass.GetValueInt() == 1)
		modKarma(-20)
	endif
	Debug.TraceUser("KARMA", "StoryManagerRunnerQuest: OnStoryChangeLocation ran. Player is trespassing: " + Game.GetPlayer().isTrespassing())
	;
	Self.Stop()
EndEvent



;; ### HACK COMPUTER
Event OnStoryHackTerminal(ObjectReference akComputer, bool abSucceeded)
	;; ## if success && terminal is not owned by player
	if(KARM_MCM_EnableKarma_HackTerminal.GetValueInt() == 1)
		modKarma(-20)
	endif
	Debug.TraceUser("KARMA", "StoryManagerRunnerQuest: OnStoryHackTerminal ran. Success: " + abSucceeded)
	;
	Self.Stop()
EndEvent



;; ### PICK LOCK
Event OnStoryPickLock(ObjectReference akActor, ObjectReference akLock)
	modKarma(-15)
	Debug.TraceUser("KARMA", "StoryManagerRunnerQuest: OnStoryPickLock ran")
	;
	Self.Stop()
EndEvent



;; ### PLAYER ADD ITEM
Event OnStoryAddToPlayer(ObjectReference akOwner, ObjectReference akContainer, Location akLocation, Form akItemBase, int aiAcquireType) 
	;; ## if item not owned by player
	if(aiAcquireType == 1)  && (aiAcquireType != 3)  ;; stealing
		if(KARM_MCM_EnableKarma_Theft.GetValueInt() == 1)
			modKarma(-15)
		endif
		;
	elseif(aiAcquireType == 3)  ;; pickpocketing
		if(KARM_MCM_EnableKarma_PickPocket.GetValueInt() == 1)
			modKarma(-20)
		endif
	endif
	Debug.TraceUser("KARMA", "StoryManagerRunnerQuest: OnStoryAddToPlayer ran. Item: " + akItemBase.getName() + ", AcquireType: " + aiAcquireType)
	;
	Self.Stop()
EndEvent



;; ### PLAYER REMOVE ITEM
Event OnStoryRemoveFromPlayer(ObjectReference akOwner, ObjectReference akItem, Location akLocation, Form akItembase, int aiRemoveType)
	if(aiRemoveType == 2)  ;; consumed
		if(akItemBase.hasKeyword(KARM_ObjectTypeAlcohol) == true)
			if(KARM_MCM_EnableKarma_ConsumeAlcohol.GetValueInt() == 1)
				modKarma(-5)
			endif
			;
		elseif(akItemBase.hasKeyword(KARM_ObjectTypeChemBad) == true)
			if(KARM_MCM_EnableKarma_ConsumeChems.GetValueInt() == 1)
				modKarma(-5)
			endif
		endif
	endif
	Debug.TraceUser("KARMA", "StoryManagerRunnerQuest: OnStoryRemoveFromPlayer ran. Item: " + akItemBase.getName() + ", RemoveType: " + aiRemoveType)
	;
	Self.Stop()
EndEvent



;; ### SCRIPT EVENT
Event OnStoryScript(Keyword akKeyword, Location akLocation, ObjectReference akRef1, ObjectReference akRef2, int aiValue1, int aiValue2)
	
	Debug.TraceUser("KARMA", "StoryManagerRunnerQuest: OnStoryScript ran. Keyword: " + akKeyword)
	;
	Self.Stop()
EndEvent