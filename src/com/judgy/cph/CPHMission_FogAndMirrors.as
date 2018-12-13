import com.GameInterface.MathLib.Vector3;
import com.judgy.cph.CPHMission_Base;
import com.GameInterface.ComputerPuzzleIF;
import com.judgy.cph.CPHMissionTextFilter;
import com.Utils.LDBFormat;

class com.judgy.cph.CPHMission_FogAndMirrors extends CPHMission_Base
{
	
	public function Load(enabled:Boolean) {
		super.Load(enabled);
		
		var ldbText:String;
		var ldbAnswer:String;
		
		// Phone
			// 1st screen
		ldbText = LDBFormat.LDBGetText(50002, 31119);
		ldbText = CPHMissionTextFilter.filterIntroText(ldbText);
		
		addTextAnswer(ldbText, "2", true);
		
			// 2nd screen
		ldbText = LDBFormat.LDBGetText(50002, 31132);
		
		addTextAnswer(ldbText, "1", true);
		
			// 3rd screen
		ldbText = LDBFormat.LDBGetText(50002, 31134);
		ldbText = CPHMissionTextFilter.filterResolveGoalText(ldbText);
		
		addTextAnswer(ldbText, CLOSE_TAG, true);
		
		//NY
			//keypad
		addKeypadAnswer(51320, "9458117", 1100, new Vector3(292.87994384766,51.152984619141,417.44100952148), "4512");
		
		//Meeting point
			//keypad 1
		addKeypadAnswer(51320, "9458136", 7290, new Vector3(351.82046508789,30.944526672363,198.65748596191), "8452");
		
			//keypad 2
		addKeypadAnswer(51320, "9458393", 7290, new Vector3(353.29699707031, 30.86248588562, 164.82064819336), "112770");
		
			// 1st computer
				// 1st screen
		ldbText = LDBFormat.LDBGetText(50002, 31137);
		ldbText = CPHMissionTextFilter.filterIntroText(ldbText);
		
		addTextAnswer(ldbText, "4", true, function() { return ComputerPuzzleIF.GetQuestions().length == 4 });
		
				// 2nd screen
		ldbText = LDBFormat.LDBGetText(50002, 31160);
		ldbAnswer = LDBFormat.LDBGetText(50001, 20711);
		ldbAnswer = CPHMissionTextFilter.filterHiddenAnswerText(ldbAnswer);
		
		addTextAnswer(ldbText, ldbAnswer, false);
		
				// 3rd screen
		ldbText = LDBFormat.LDBGetText(50002, 31162);
		ldbText = CPHMissionTextFilter.filterHelpQuitText(ldbText);
		
		addTextAnswer(ldbText, "1", true);
		
				// 4th screen
		ldbText = LDBFormat.LDBGetText(50002, 31161);
		ldbText = CPHMissionTextFilter.filterGameActionText(ldbText);
		
		addTextAnswer(ldbText, CLOSE_TAG, false);
		
			// 2nd computer
				// 1st screen
		ldbText = LDBFormat.LDBGetText(50002, 31137);
		ldbText = CPHMissionTextFilter.filterIntroText(ldbText);
		
		addTextAnswer(ldbText, "1", true, function() { return ComputerPuzzleIF.GetQuestions().length == 3 });
		
			// 2nd screen
		ldbText = LDBFormat.LDBGetText(50002, 31181);
		ldbText = CPHMissionTextFilter.filterHelpQuitText(ldbText);
		
		addTextAnswer(ldbText, "1", true);
		
			//3rd screen
		ldbText = LDBFormat.LDBGetText(50002, 31182);
		ldbText = CPHMissionTextFilter.filterHelpQuitText(ldbText);
		
		addTextAnswer(ldbText, "1", true);
		
			//4th screen
		ldbText = LDBFormat.LDBGetText(50002, 31186);
		ldbText = CPHMissionTextFilter.filterResolveGoalText(ldbText);
		
		addTextAnswer(ldbText, CLOSE_TAG, true);
	}
	
	public function GetDVName() {
		return "FogAndMirrors";
	}
	
}