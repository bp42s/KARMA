Scriptname karmaLib extends Quest
{ Holds KARMA functions to safely and properly modify the Player's KARMA values. by bp42s }


;; Your script should extend "karmaLib" to have access to these methods (if it is a quest script), or you should declare karmaLib as a QuestScript Property


;; ---### INSTRUCTIONS ###---
;;
;; PROPERTY COPY/PASTE:
;; karmaLib Property karmaLib Auto Const Mandatory
;;
;; After doing this, go to the PROPERTIES tab, and select the karmaLib property. Select "karmaLib" from the dropdown menu.
;; If you get an error doing this, try renaming it to:
;; karmaLib Property karmaLibProperty Auto Const Mandatory
;;
;; And then, try:
;; karmaLibProperty.modKarma(5)

;; EXAMPLE AFTER USING PROPERTY NORMALLY
;; karmaLib.modKarma(5)
;;
;; ---### END INSTRUCTIONS ###---



;; ---### IMPORTS ###---
import Game
import Math



;; ---### VARIABLES ###---
;;
Actor Player
CustomEvent KarmaUpdated



;; ---### PROPERTIES ###---
;;
;; ### NOTE: Some properties are included here so they can be accessed by subclasses, such as followersscript.
;;
Group Actors
	Actor Property PlayerRef Auto
EndGroup
;
Group ActorValues
	;; KARMA!
	ActorValue Property KARM_KarmaAV Auto
	;; PBT
	ActorValue Property KARM_PBT_KarmaVeryEvilAV Auto
	ActorValue Property KARM_PBT_KarmaEvilAV Auto
	ActorValue Property KARM_PBT_KarmaNeutralAV Auto
	ActorValue Property KARM_PBT_KarmaGoodAV Auto
	ActorValue Property KARM_PBT_KarmaVeryGoodAV Auto
	;;
	ActorValue Property KARM_NPC_KarmaAV Auto
EndGroup
;
Group AffinityKeywords
	Keyword Property CAT__CustomEvent_Generous_Topic Auto
	Keyword Property CAT__CustomEvent_Nice_Topic Auto
	Keyword Property CAT__CustomEvent_Peaceful_Topic Auto
	Keyword Property CAT__CustomEvent_PeacefulFailed_Topic Auto
	Keyword Property CAT__CustomEvent_Selfish_Topic Auto
	Keyword Property CAT__CustomEvent_Mean_Topic Auto
	Keyword Property CAT__CustomEvent_Violent_Topic Auto
	Keyword Property CAT__Event_DonateItem_Topic Auto
	Keyword Property CAT_Event_HealCompanion_Topic Auto
	Keyword Property CAT_Event_HealDogmeant_Topic Auto
	Keyword Property CAT_Event_DogmeatBleedout_Topic Auto
	Keyword Property CAT__Event_SpeechForMoreCaps_Topic Auto
	Keyword Property CA__CustomEvent_MinSettlementHelp Auto
	Keyword Property CA__CustomEvent_MinSettlementRefuseHelp Auto
EndGroup
;
Group Globals
	GlobalVariable Property KARM_KarmaValueGlobal Auto
	;; MCM
	GlobalVariable Property KARM_MCM_KarmaMultNegative Auto
	GlobalVariable Property KARM_MCM_KarmaMultPositive Auto
	GlobalVariable Property KARM_MCM_EnableKarmaSounds Auto
	GlobalVariable Property KARM_MCM_KarmaSFXVolume Auto
	GlobalVariable Property KARM_MCM_EnableKarmaNotifications Auto
	GlobalVariable Property KARM_MCM_EnableKarmaPerks Auto
	GlobalVariable Property KARM_MCM_EnableVaultBoyPopUps Auto
	;; PBT
	GlobalVariable Property KARM_PBT_TOGGLE_VERYEVIL Auto
	GlobalVariable Property KARM_PBT_TOGGLE_EVIL Auto
	GlobalVariable Property KARM_PBT_TOGGLE_NEUTRAL Auto
	GlobalVariable Property KARM_PBT_TOGGLE_GOOD Auto
	GlobalVariable Property KARM_PBT_TOGGLE_VERYGOOD Auto
	;; EVENT TOGGLES
	GlobalVariable Property KARM_MCM_EnableKarma_Addiction Auto
	GlobalVariable Property KARM_MCM_EnableKarma_AffinityEvents Auto
	GlobalVariable Property KARM_MCM_EnableKarma_Assault Auto
	GlobalVariable Property KARM_MCM_EnableKarma_Cannibalism Auto
	GlobalVariable Property KARM_MCM_EnableKarma_ClaimSettlement Auto
	GlobalVariable Property KARM_MCM_EnableKarma_ClearDungeon Auto
	GlobalVariable Property KARM_MCM_EnableKarma_ConsumeAlcohol Auto
	GlobalVariable Property KARM_MCM_EnableKarma_ConsumeChems Auto
	GlobalVariable Property KARM_MCM_EnableKarma_CreateSupplyLine Auto
	GlobalVariable Property KARM_MCM_EnableKarma_HackTerminal Auto
	GlobalVariable Property KARM_MCM_EnableKarma_HealCompanion Auto
	GlobalVariable Property KARM_MCM_EnableKarma_LockPick Auto
	GlobalVariable Property KARM_MCM_EnableKarma_Murder Auto
	GlobalVariable Property KARM_MCM_EnableKarma_PickPocket Auto
	GlobalVariable Property KARM_MCM_EnableKarma_QuestsBrotherhood Auto
	GlobalVariable Property KARM_MCM_EnableKarma_QuestsInstitute Auto
	GlobalVariable Property KARM_MCM_EnableKarma_QuestsRailroad Auto
	GlobalVariable Property KARM_MCM_EnableKarma_QuestsMinutemen Auto
	GlobalVariable Property KARM_MCM_EnableKarma_SpeechForMoreCaps Auto
	GlobalVariable Property KARM_MCM_EnableKarma_Theft Auto
	GlobalVariable Property KARM_MCM_EnableKarma_Trespass Auto
	;; UTILITY
	GlobalVariable Property KARM_PlayerAlignmentValue Auto
EndGroup
;
Group Keywords
	Keyword Property KARM_SMEvent_KarmaUpdated Auto
	Keyword Property KARM_ObjectTypeChemBad Auto
	Keyword Property KARM_ObjectTypeAlcohol Auto
EndGroup
;
Group Messages
	Message Property KARM_KarmaGainMESG Auto
	Message Property KARM_KarmaLossMESG Auto
EndGroup
;
Group Perks
	;; EFFECT PERKS
	Perk Property KARM_KarmaEffectPerk_VeryEvil Auto
	Perk Property KARM_KarmaEffectPerk_Evil Auto
	Perk Property KARM_KarmaEffectPerk_Neutral Auto
	Perk Property KARM_KarmaEffectPerk_Good Auto
	Perk Property KARM_KarmaEffectPerk_VeryGood Auto
	;; DISPLAY PERKS
	Perk Property KARM_KarmaDisplayPerk_VeryEvil Auto
	Perk Property KARM_KarmaDisplayPerk_Evil Auto
	Perk Property KARM_KarmaDisplayPerk_Neutral Auto
	Perk Property KARM_KarmaDisplayPerk_Good Auto
	Perk Property KARM_KarmaDisplayPerk_VeryGood Auto
EndGroup
;
Group Quests
	Quest Property Followers Auto
EndGroup
;
Group QuestScripts
	followersscript Property FollowersProperty const auto
EndGroup
;
Group Sounds
	;; KARMA SFX
	Sound Property KARM_KarmaGainSFX Auto
	Sound Property KARM_KarmaLossSFX Auto
	;; PERK SFX
	Sound Property UIPerkMenuLifeGiver Auto  ;; very good
	Sound Property UIPerkMenuSolarPowered Auto ;; good
	Sound Property UIPerkMenuIntimidation Auto  ;; neutral
	Sound Property UIPerkMenuBlitz Auto  ;; evil
	Sound Property UIGamePipboyGrognakFlee Auto  ;; very evil
EndGroup
;
Group Strings
	string Property veryGoodIcon = "Components\\VaultBoys\\Perks\\KARM_KarmaVeryGoodPerkIcon.swf" Auto Const
	string Property goodIcon = "Components\\VaultBoys\\Perks\\KARM_KarmaGoodPerkIcon.swf" Auto Const
	string Property neutralIcon = "Components\\VaultBoys\\Perks\\KARM_KarmaNeutralPerkIcon.swf" Auto Const
	string Property evilIcon = "Components\\VaultBoys\\Perks\\KARM_KarmaEvilPerkIcon.swf" Auto Const
	string Property veryEvilIcon = "Components\\VaultBoys\\Perks\\KARM_KarmaVeryEvilPerkIcon.swf" Auto Const
EndGroup


;; ---### FUNCTIONS ###---
;;
;; ---### PLAYER SETTER/GETTER FUNCTIONS ###---
;; 
;; ### Modifies the player's karma by amount, and updates relevant operations. Affected by karma multiplier.
Function modKarma(int amount)
	float currentKarma = getKarma()
	float amountMultiplied
	if(amount > 0)  ;; if positive
		amountMultiplied = Math.Floor(amount as float * KARM_MCM_KarmaMultPositive.GetValue())
		PlayerRef.SetValue(KARM_KarmaAV, currentKarma + amountMultiplied)
	elseif(amount < 0)  ;; if negative
		amountMultiplied = Math.Floor(amount as float * KARM_MCM_KarmaMultNegative.GetValue())
		PlayerRef.SetValue(KARM_KarmaAV, currentKarma + amountMultiplied)
	endif
	;;
	runOperations()
	playKarmaSFX(amount)
	showKarmaNotif(amount)
	Debug.TraceUser("KARMA", "karmaLib: modKarma was called, amount: " + amount)
EndFunction


;; ### Modifies the player's karma by amount and updates relevant operations. Unaffected by karma multiplier.
Function modKarmaDirect(int amount)
	float currentKarma = getKarma()
	PlayerRef.SetValue(KARM_KarmaAV, currentKarma + amount)
	;;
	runOperations()
	playKarmaSFX(amount)
	showKarmaNotif(amount)
	Debug.TraceUser("KARMA", "karmaLib: modKarmaDirect was called, amount: " + amount)
EndFunction


;; ### Modifies the player's karma by amount and updates relevant operations. Affected by karma multiplier. Does not play sounds or notifications.
Function modKarmaSilent(int amount)
	float currentKarma = getKarma()
	PlayerRef.SetValue(KARM_KarmaAV, currentKarma + amount)
	;;
	runOperations()
	Debug.TraceUser("KARMA", "karmaLib: modKarmaSilent was called, amount: " + amount)
EndFunction


;; ### Sets the player's karma to amount and updates relevant operations. Unaffected by karma multiplier.
Function setKarma(int amount)
	PlayerRef.SetValue(KARM_KarmaAV, amount)
	;;
	runOperations()
	playKarmaSFX(amount)
	showKarmaNotif(amount)
	Debug.TraceUser("KARMA", "karmaLib: setKarma was called, amount: " + amount)
EndFunction


;; ### Sets the player's karma to amount and updates relevant operations. Unaffected by karma multiplier. Does not play sounds or notifications.
Function setKarmaSilent(int amount)
	float currentKarma = getKarma()
	PlayerRef.SetValue(KARM_KarmaAV, amount)
	;;
	runOperations()
	Debug.TraceUser("KARMA", "karmaLib: setKarmaSilent was called, amount: " + amount)
EndFunction



;; ### Returns the player's current karma (-1000 -> 1000) as a float
Float Function getKarma()
	float currentKarma = PlayerRef.GetValue(KARM_KarmaAV)
	return currentKarma
	Debug.TraceUser("KARMA", "karmaLib: getKarma was called, amount: " + currentKarma)
EndFunction


;; ### Modifies the player's karma by a random number between the two values, rounded down to a whole number. Unaffected by karma multiplier.
Function modKarmaRandom(int minimum, int maximum)
	int amount = Math.Floor(Utility.RandomInt(minimum, maximum) as int)
	Debug.TraceUser("KARMA", "karmaLib: modKarmaRandom was called, min: " + minimum + ", max: " + maximum + ", amount: " + amount)
	modKarmaDirect(amount)
EndFunction


;; ### Sets the player's karma to a random number between the two values, rounded down to a whole number. Unaffected by karma multiplier.
Function setKarmaRandom(int minimum, int maximum)
	int amount = Math.Floor(Utility.RandomInt(minimum, maximum) as int)
	Debug.TraceUser("KARMA", "karmaLib: setKarmaRandom was called, min: " + minimum + ", max: " + maximum + ", amount: " + amount)
	setKarma(amount)
EndFunction



;; ---### PLAYER OPERATION FUNCTIONS ### ---

;; ### Wrapper function to run all needed operations from one line, excluding audio SFX
Function runOperations()
	fixInvalidKarma()
	updateAlignmentGlobal()
	updateKarmaTab()
	updateKarmaPerks()
	sendEventUpdate()
	Debug.TraceUser("KARMA", "karmaLib: runOperations was called")
EndFunction


;; ### Updates GlobalVariable "KARM_PlayerAlignmentValue" to be the proper value to correspond with the player's karma AV
;; (-2 = Very Evil) (-1 = Evil) (0 = Neutral) (1 = Good) (2 = Very Good)
Function updateAlignmentGlobal()
	float currentKarma = getKarma()
	
	if(currentKarma > 249)  ;; positive karma
		if(currentKarma >= 750)  ;; VERY GOOD KARMA
			KARM_PlayerAlignmentValue.SetValue(2)
		elseif(currentKarma >= 250 && currentKarma < 750) ;; GOOD KARMA
			KARM_PlayerAlignmentValue.SetValue(1)
		endif
		;
	elseif(currentKarma < -249) ;; negative karma
		if(currentKarma <= -250 && currentKarma > -750)  ;; EVIL KARMA
			KARM_PlayerAlignmentValue.SetValue(-1)
		elseif(currentKarma <= -750)  ;; VERY EVIL
			KARM_PlayerAlignmentValue.SetValue(-2)
		endif
		;
	else  ;; neutral karma
		KARM_PlayerAlignmentValue.SetValue(0)
	endif
	Debug.TraceUser("KARMA", "karmaLib: updateAlignmentGlobal was called. Value: " + KARM_PlayerAlignmentValue.GetValue())
EndFunction


;; ### Updates the karma alignment in the player's KARMA pipboy tab
Function updateKarmaTab()
	int alignment = KARM_PlayerAlignmentValue.GetValueInt()
	
	if(alignment == 2)  ;; very good
		KARM_PBT_TOGGLE_VERYEVIL.SetValue(0)
		KARM_PBT_TOGGLE_EVIL.SetValue(0)
		KARM_PBT_TOGGLE_NEUTRAL.SetValue(0)
		KARM_PBT_TOGGLE_GOOD.SetValue(0)
		KARM_PBT_TOGGLE_VERYGOOD.SetValue(1)
	elseif(alignment == 1)  ;; good
		KARM_PBT_TOGGLE_VERYEVIL.SetValue(0)
		KARM_PBT_TOGGLE_EVIL.SetValue(0)
		KARM_PBT_TOGGLE_NEUTRAL.SetValue(0)
		KARM_PBT_TOGGLE_GOOD.SetValue(1)
		KARM_PBT_TOGGLE_VERYGOOD.SetValue(0)
	elseif(alignment == 0)  ;; neutral
		KARM_PBT_TOGGLE_VERYEVIL.SetValue(0)
		KARM_PBT_TOGGLE_EVIL.SetValue(0)
		KARM_PBT_TOGGLE_NEUTRAL.SetValue(1)
		KARM_PBT_TOGGLE_GOOD.SetValue(0)
		KARM_PBT_TOGGLE_VERYGOOD.SetValue(0)
	elseif(alignment == -1)  ;; evil
		KARM_PBT_TOGGLE_VERYEVIL.SetValue(0)
		KARM_PBT_TOGGLE_EVIL.SetValue(1)
		KARM_PBT_TOGGLE_NEUTRAL.SetValue(0)
		KARM_PBT_TOGGLE_GOOD.SetValue(0)
		KARM_PBT_TOGGLE_VERYGOOD.SetValue(0)
	elseif(alignment == -2)  ;; very evil
		KARM_PBT_TOGGLE_VERYEVIL.SetValue(1)
		KARM_PBT_TOGGLE_EVIL.SetValue(0)
		KARM_PBT_TOGGLE_NEUTRAL.SetValue(0)
		KARM_PBT_TOGGLE_GOOD.SetValue(0)
		KARM_PBT_TOGGLE_VERYGOOD.SetValue(0)
	endif
	
	;;PBT:PBT.UpdateMenu() - cut to prevent possible errors if not installed
	Debug.TraceUser("KARMA", "karmaLib: updateKarmaTab was called")
EndFunction


;; ### Safety check to fix player's karma if it is <-1000 or if it is >1000
Function fixInvalidKarma()
	float currentKarma = getKarma()
	
	if(currentKarma > 1000)
		PlayerRef.SetValue(KARM_KarmaAV, 1000)
	elseif(currentKarma < -1000)
		PlayerRef.SetValue(KARM_KarmaAV, -1000)
	endif
	Debug.TraceUser("KARMA", "karmaLib: fixInvalidKarma was called, karma was: " + currentKarma)
EndFunction


;; ### Sends the custom event "KarmaUpdated" for scripts that are registered for the custom events
Function sendEventUpdate()
	SendCustomEvent("KarmaUpdated")
	KARM_SMEvent_KarmaUpdated.SendStoryEvent()
	Debug.TraceUser("KARMA", "karmaLib: sendEventUpdate was called, CustomEvent and StoryEvent were sent")
EndFunction


;; ### Plays karma SFX to the player. if soundToPlay is negative, play loss sound. if soundToPlay is positive, play gain sound.
Function playKarmaSFX(int soundToPlay)
	if(KARM_MCM_EnableKarmaSounds.GetValueInt() == 1)  ;; if this feature is enabled
		;; VARIABLES
		float volume = KARM_MCM_KarmaSFXVolume.GetValue()
	
		;; OPERATION
		if(soundToPlay < 0)  ;; KARMA LOSS SOUND
			int instanceIdLoss = KARM_KarmaLossSFX.play(PlayerRef)
			Sound.SetInstanceVolume(instanceIdLoss, volume)
			;
		elseif(soundToPlay > 0)  ;; KARMA GAIN SOUND
			int instanceIdGain = KARM_KarmaGainSFX.play(PlayerRef)
			Sound.SetInstanceVolume(instanceIdGain, volume)
			;
		elseif(soundToPlay == 0)  ;; ERROR HANDLING
			Debug.traceUser("KARMA", "playKarmaSFX had an invalid value passed. Value was: " + soundToPlay)
		endif
	endif
	Debug.TraceUser("KARMA", "karmaLib: playKarmaSFX was called, soundToPlay was: "  + soundToPlay)
EndFunction



;; ### Displays karma change notification to the player. if notifToShow is negative, show loss message. if notifToShow is positive, show gain message.
Function showKarmaNotif(int notifToShow)
	if(KARM_MCM_EnableKarmaNotifications.GetValueInt() == 1)
		if(notifToShow < 0)  ;; KARMA LOSS NOTIF
			KARM_KarmaLossMESG.Show()
		elseif(notifToShow > 0)  ;; KARMA GAIN NOTIF
			KARM_KarmaGainMESG.Show()
		elseif(notifToShow == 0)  ;; ERROR HANDLING
			Debug.traceUser("KARMA", "showKarmaNotif had an invalid value passed. Value was: " + notifToShow)
		endif
	endif
	Debug.TraceUser("KARMA", "karmaLib: showKarmaNotif was called, notifToShow was: " + notifToShow)
EndFunction


;; ### Removes all karma effect perks and re-adds the proper perk depending on alignment if enabled
Function updateKarmaPerks()
	PlayerRef.RemovePerk(KARM_KarmaEffectPerk_VeryEvil)
	PlayerRef.RemovePerk(KARM_KarmaEffectPerk_Evil)
	PlayerRef.RemovePerk(KARM_KarmaEffectPerk_Neutral)
	PlayerRef.RemovePerk(KARM_KarmaEffectPerk_Good)
	PlayerRef.RemovePerk(KARM_KarmaEffectPerk_VeryGood)
	PlayerRef.RemovePerk(KARM_KarmaDisplayPerk_VeryEvil)
	PlayerRef.RemovePerk(KARM_KarmaDisplayPerk_Evil)
	PlayerRef.RemovePerk(KARM_KarmaDisplayPerk_Neutral)
	PlayerRef.RemovePerk(KARM_KarmaDisplayPerk_Good)
	PlayerRef.RemovePerk(KARM_KarmaDisplayPerk_VeryGood)
	;;
	int alignment = KARM_PlayerAlignmentValue.GetValueInt()
	if(KARM_MCM_EnableKarmaPerks.GetValueInt() == 1)  ;; PERKS WITH EFFECTS
		if(alignment == -2)
			PlayerRef.AddPerk(KARM_KarmaEffectPerk_VeryEvil)
		elseif(alignment == -1)
			PlayerRef.AddPerk(KARM_KarmaEffectPerk_Evil)
		elseif(alignment == 0)
			PlayerRef.AddPerk(KARM_KarmaEffectPerk_Neutral)
		elseif(alignment == 1)
			PlayerRef.AddPerk(KARM_KarmaEffectPerk_Good)
		elseif(alignment == 2)
			PlayerRef.AddPerk(KARM_KarmaEffectPerk_VeryGood)
		endif
		;
	elseif(KARM_MCM_EnableKarmaPerks.GetValueInt() == 2)  ;; PERKS FOR DISPLAY
		if(alignment == -2)
			PlayerRef.AddPerk(KARM_KarmaDisplayPerk_VeryEvil)
		elseif(alignment == -1)
			PlayerRef.AddPerk(KARM_KarmaDisplayPerk_Evil)
		elseif(alignment == 0)
			PlayerRef.AddPerk(KARM_KarmaDisplayPerk_Neutral)
		elseif(alignment == 1)
			PlayerRef.AddPerk(KARM_KarmaDisplayPerk_Good)
		elseif(alignment == 2)
			PlayerRef.AddPerk(KARM_KarmaDisplayPerk_VeryGood)
		endif
		;
	endif
	Debug.TraceUser("KARMA", "karmaLib: updateKarmaPerks was called, EnableKarmaPerks was: " + KARM_MCM_EnableKarmaPerks.GetValue())
EndFunction


;; ### Updates player karma title in KARMA pipboy tab.
;; ### NOTE: This is intentionally inefficient because using (level % 5 == 0) would cause titles to be unaligned
;; ### with the player's level if they skipped a level
Function updateKarmaTitle()
	;; VARIABLES
	Player = Game.GetPlayer()
	int level = Player.GetLevel() as int
	
	;; PROCESSING
	;;
	;; title update
	if(level < 5)
		Player.SetValue(KARM_PBT_KarmaVeryGoodAV, 0)
		Player.SetValue(KARM_PBT_KarmaGoodAV, 0)
		Player.SetValue(KARM_PBT_KarmaNeutralAV, 1)
		Player.SetValue(KARM_PBT_KarmaEvilAV, 2)
		Player.SetValue(KARM_PBT_KarmaVeryEvilAV, 2)
	elseif(level == 5)
		Player.SetValue(KARM_PBT_KarmaVeryGoodAV, 3)
		Player.SetValue(KARM_PBT_KarmaGoodAV, 3)
		Player.SetValue(KARM_PBT_KarmaNeutralAV, 4)
		Player.SetValue(KARM_PBT_KarmaEvilAV, 5)
		Player.SetValue(KARM_PBT_KarmaVeryEvilAV, 5)
	elseif(level == 10)
		Player.SetValue(KARM_PBT_KarmaVeryGoodAV, 6)
		Player.SetValue(KARM_PBT_KarmaGoodAV, 6)
		Player.SetValue(KARM_PBT_KarmaNeutralAV, 7)
		Player.SetValue(KARM_PBT_KarmaEvilAV, 8)
		Player.SetValue(KARM_PBT_KarmaVeryEvilAV, 8)
	elseif(level == 15)
		Player.SetValue(KARM_PBT_KarmaVeryGoodAV, 9)
		Player.SetValue(KARM_PBT_KarmaGoodAV, 9)
		Player.SetValue(KARM_PBT_KarmaNeutralAV, 10)
		Player.SetValue(KARM_PBT_KarmaEvilAV, 11)
		Player.SetValue(KARM_PBT_KarmaVeryEvilAV, 11)
	elseif(level == 20)
		Player.SetValue(KARM_PBT_KarmaVeryGoodAV, 12)
		Player.SetValue(KARM_PBT_KarmaGoodAV, 12)
		Player.SetValue(KARM_PBT_KarmaNeutralAV, 13)
		Player.SetValue(KARM_PBT_KarmaEvilAV, 14)
		Player.SetValue(KARM_PBT_KarmaVeryEvilAV, 14)
	elseif(level == 25)
		Player.SetValue(KARM_PBT_KarmaVeryGoodAV, 15)
		Player.SetValue(KARM_PBT_KarmaGoodAV, 15)
		Player.SetValue(KARM_PBT_KarmaNeutralAV, 16)
		Player.SetValue(KARM_PBT_KarmaEvilAV, 17)
		Player.SetValue(KARM_PBT_KarmaVeryEvilAV, 17)
	elseif(level == 30)
		Player.SetValue(KARM_PBT_KarmaVeryGoodAV, 18)
		Player.SetValue(KARM_PBT_KarmaGoodAV, 18)
		Player.SetValue(KARM_PBT_KarmaNeutralAV, 19)
		Player.SetValue(KARM_PBT_KarmaEvilAV, 20)
		Player.SetValue(KARM_PBT_KarmaVeryEvilAV, 20)
	elseif(level >= 35)  ;; GOING ABOVE THIS STOPS TITLES FROM APPEARING FOR SOME REASON
		Player.SetValue(KARM_PBT_KarmaVeryGoodAV, 21)
		Player.SetValue(KARM_PBT_KarmaGoodAV, 21)
		Player.SetValue(KARM_PBT_KarmaNeutralAV, 22)
		Player.SetValue(KARM_PBT_KarmaEvilAV, 23)
		Player.SetValue(KARM_PBT_KarmaVeryEvilAV, 23)
	endif
	
	;; popup if enabled
	if(level % 5 == 0 && level <= 35)
		if(KARM_MCM_EnableVaultBoyPopUps.GetValueInt() == 1)
			;; show vault boy on hud
			int alignment = KARM_PlayerAlignmentValue.GetValueInt()
			if(alignment < 0)  ;; if negative
				if(alignment == -2)  ;; very evil
					Game.ShowPerkVaultBoyOnHUD(veryEvilIcon, UIGamePipboyGrognakFlee)
				elseif(alignment == -1)  ;; evil
					Game.ShowPerkVaultBoyOnHUD(evilIcon, UIPerkMenuBlitz)
				endif
				;
			elseif(alignment == 0)  ;; if neutral
				Game.ShowPerkVaultBoyOnHUD(neutralIcon, UIPerkMenuIntimidation)
				;
			elseif(alignment > 0)  ;; if positive
				if(alignment == 1)  ;; good
					Game.ShowPerkVaultBoyOnHUD(goodIcon, UIPerkMenuSolarPowered)
				elseif(alignment == 2)  ;; very good
					Game.ShowPerkVaultBoyOnHUD(veryGoodIcon, UIPerkMenuLifeGiver)
				endif
				;		
			endif
		endif
	endif
	Debug.TraceUser("KARMA", "karmaLib: updateKarmaTitle was called, level was: " + level + ", EnableVaultBoyPopUps was: " + KARM_MCM_EnableVaultBoyPopUps.GetValue())
	;;PBT:PBT.UpdateMenu() - cut to prevent possible errors if not installed
EndFunction