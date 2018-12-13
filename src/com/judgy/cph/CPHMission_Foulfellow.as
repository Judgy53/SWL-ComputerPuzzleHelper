import com.judgy.cph.CPHMission_Base;
import com.judgy.cph.CPHMissionTextFilter;
import com.Utils.LDBFormat;

class com.judgy.cph.CPHMission_Foulfellow extends CPHMission_Base
{
	
	public function Load(enabled:Boolean) {
		super.Load(enabled);
		
		var ldbText:String;
		var ldbAnswer:String;
		
		// computer 1
			// 1st screen
		ldbText = LDBFormat.LDBGetText(50002, 31045);
		ldbText = CPHMissionTextFilter.filterIntroText(ldbText);
		ldbText = CPHMissionTextFilter.filterHelpQuitText(ldbText);
		
		addTextAnswer(ldbText, "6", true);
		
			// 2nd screen
		ldbText = LDBFormat.LDBGetText(50002, 31065);
		
		ldbAnswer = LDBFormat.LDBGetText(50001, 20522);
		ldbAnswer = CPHMissionTextFilter.filterHiddenAnswerText(ldbAnswer);
		
		addTextAnswer(ldbText, ldbAnswer, true);
		
			// 3rd screen
		ldbText = LDBFormat.LDBGetText(50002, 31044);
		ldbText = CPHMissionTextFilter.filterResolveGoalText(ldbText);
		
		addTextAnswer(ldbText, CLOSE_TAG, true);
		
		
		// computer 2
			// 1st screen
		ldbText = LDBFormat.LDBGetText(50002, 30955);
		ldbText = CPHMissionTextFilter.filterIntroText(ldbText);
		ldbText = CPHMissionTextFilter.filterHelpQuitText(ldbText);
		
		ldbAnswer = LDBFormat.LDBGetText(50001, 20522);
		ldbAnswer = CPHMissionTextFilter.filterHiddenAnswerText(ldbAnswer);
		
		addTextAnswer(ldbText, ldbAnswer, false);
		
			// 2nd screen
		ldbText = LDBFormat.LDBGetText(50002, 30958);
		ldbText = CPHMissionTextFilter.filterResolveGoalText(ldbText);
		
		addTextAnswer(ldbText, CLOSE_TAG, false);
		
		// computer 3 
			// 1st screen
		ldbText = LDBFormat.LDBGetText(50002, 30974);
		ldbText = CPHMissionTextFilter.filterIntroText(ldbText);
		ldbText = CPHMissionTextFilter.filterHelpQuitText(ldbText);
		
		addTextAnswer(ldbText, "1", true);
		
			// 2nd screen
		ldbText = LDBFormat.LDBGetText(50002, 30987);
		ldbText = CPHMissionTextFilter.filterHelpQuitText(ldbText);
		
		addTextAnswer(ldbText, "1", true);
		
			// 3rd screen
		ldbText = LDBFormat.LDBGetText(50002, 30981);
		ldbText = CPHMissionTextFilter.filterResolveGoalText(ldbText);
		
		addTextAnswer(ldbText, CLOSE_TAG, true);
		
		// computer 4
			// 1st screen
		ldbText = LDBFormat.LDBGetText(50002, 30982);
		ldbText = CPHMissionTextFilter.filterIntroText(ldbText);
		ldbText = CPHMissionTextFilter.filterHelpQuitText(ldbText);
		
		ldbAnswer = LDBFormat.LDBGetText(50001, 20522);
		ldbAnswer = CPHMissionTextFilter.filterHiddenAnswerText(ldbAnswer);
		
		addTextAnswer(ldbText, ldbAnswer, false);
		
			// 2nd screen
		ldbText = LDBFormat.LDBGetText(50002, 30984);
		ldbText = CPHMissionTextFilter.filterResolveGoalText(ldbText);
		
		ldbAnswer = LDBFormat.LDBGetText(50001, 20523);
		ldbAnswer = CPHMissionTextFilter.filterHiddenAnswerText(ldbAnswer);
		
		addTextAnswer(ldbText, ldbAnswer, false);
		
			// 3rd screen
		ldbText = LDBFormat.LDBGetText(50002, 30985);
		ldbText = CPHMissionTextFilter.filterResolveGoalText(ldbText);
		
		addTextAnswer(ldbText, CLOSE_TAG, false);
	}
	
	public function GetDVName() {
		return "Foulfellow";
	}
}