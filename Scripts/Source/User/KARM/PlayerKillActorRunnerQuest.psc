Scriptname KARM:PlayerKillActorRunnerQuest extends karmaLib


Event OnStoryKillActor(ObjectReference akVictim, ObjectReference akKiller, Location akLocation, int aiCrimeStatus, int aiRelationshipRank)
	int victimKarma = akVictim.getValue(KARM_NPC_KarmaAV) as int
	
	;; KILLING BAD GUYS GIVES YOU KARMA
	;; KILLING GOOD GUYS TAKES AWAY KARMA
	
	if(victimKarma == -2)  ;; very evil victim karma
		modKarmaRandom(15, 25)
		;
	elseif(victimKarma == -1)  ;; evil victim karma
		modKarmaRandom(15, 5)
		;
	elseif(victimKarma == 0)  ;; neutral victim karma
		;;modKarmaRandom()
		;
	elseif(victimKarma == 1)  ;; good victim karma
		modKarmaRandom(-5, -15)
		;
	elseif(victimKarma == 2)
		modKarmaRandom(-15, -25)  ;; very good victim karma
		;
	endif
	Debug.TraceUser("KARMA", "PlayerKillActorRunnerQuest: Event ran, akVictim: " + akVictim.getName() + ", victimKarma: " + victimKarma)
	;
	Self.Stop()
EndEvent