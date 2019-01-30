import com.GameInterface.MathLib.Vector3;
import com.judgy.cph.CPHMission_Base;
import com.judgy.cph.CPHMissionTextFilter;
import com.Utils.LDBFormat;

class com.judgy.cph.CPHMission_KingsmouthCode extends CPHMission_Base
{
	
	public function DoLoad() {
		var ldbText:String;
		var ldbAnswer:String;
		
		//keypad 1
		addKeypadAnswer(51320, "6080762", 3030, new Vector3(325.00219726563, 145.02673339844, 473.90313720703), "120");
		
		//computer 1
			//screen 1
		ldbText = LDBFormat.LDBGetText(50002, 27828);
		ldbText = CPHMissionTextFilter.filterIntroText(ldbText);
		ldbText = CPHMissionTextFilter.filterHelpQuitText(ldbText);
		ldbText = ldbText.split("</font>")[1]; // !ERROR! has color font tags (which doesn't work BTW) 
		
		ldbAnswer = LDBFormat.LDBGetText(50001, 17360);
		ldbAnswer = CPHMissionTextFilter.filterHiddenAnswerText(ldbAnswer);
		
		addTextAnswer(ldbText, ldbAnswer, false);
		
			//screen 2
		ldbText = LDBFormat.LDBGetText(50002, 27829);
		ldbText = CPHMissionTextFilter.filterHelpQuitText(ldbText);
		
		addTextAnswer(ldbText, "1", false);
		
			//screen 3
		ldbText = LDBFormat.LDBGetText(50002, 27833);
		ldbText = CPHMissionTextFilter.filterResolveGoalText(ldbText);
		
		addTextAnswer(ldbText, CLOSE_TAG, false);
	}
	
	public function GetDVName() {
		return "KMCode";
	}
	
	public function IsValidPlayfield(playfield:Number) {
		return playfield == 3030;
	}
	
	public function GetQuestID() {
		return 2297;
	}
}