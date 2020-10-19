import com.judgy.cph.CPHMission_Base;
import com.judgy.cph.CPHMissionTextFilter;
import com.Utils.LDBFormat;

class com.judgy.cph.CPHMission_Broadcast extends CPHMission_Base
{
	
	private function DoLoad() {
		var ldbText:String;
		var ldbAnswer:String;
		
		// computer 1
			// 1st screen
		ldbText = LDBFormat.LDBGetText(50002, 30373);
		ldbText = CPHMissionTextFilter.filterIntroText(ldbText);
		
		addTextAnswer(ldbText, "1", true);
		
			// 2nd screen
		ldbText = LDBFormat.LDBGetText(50002, 30377);
		
		addTextAnswer(ldbText, "6", true);
		
			// 3rd screen
		ldbText = LDBFormat.LDBGetText(50002, 30388);
		
		ldbAnswer = LDBFormat.LDBGetText(50001, 20004);
		ldbAnswer = CPHMissionTextFilter.filterHiddenAnswerText(ldbAnswer);
		
		addTextAnswer(ldbText, ldbAnswer, true);
		
			// 4th screen [DOESN'T WORK]
		ldbText = LDBFormat.LDBGetText(50002, 30397);
		ldbText = CPHMissionTextFilter.filterResolveGoalText(ldbText);
		
		addTextAnswer(ldbText, CLOSE_TAG, false);
	}
	
	public function GetDVName() {
		return "Broadcast";
	}
	
	public function IsValidPlayfield(playfield:Number) {
		return false;
	}
	
	public function GetQuestID() {
		return 3660;
	}
}