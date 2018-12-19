import com.GameInterface.MathLib.Vector3;
import com.judgy.cph.CPHMission_Base;
import com.judgy.cph.CPHMissionTextFilter;
import com.Utils.LDBFormat;

class com.judgy.cph.CPHMission_Wetware extends CPHMission_Base
{
	
	private function DoLoad() {
		var ldbText:String;
		var ldbAnswer:String;
		
		// outside hospital
			// 1st computer
				// 1st screen
		ldbText = LDBFormat.LDBGetText(50002, 30759);
		ldbText = CPHMissionTextFilter.filterIntroText(ldbText);
		ldbText = CPHMissionTextFilter.filterHelpQuitText(ldbText);
		
		addTextAnswer(ldbText, "2", true);
		
				// 2nd screen
		ldbText = LDBFormat.LDBGetText(50002, 30765);
		ldbText = CPHMissionTextFilter.filterHelpQuitText(ldbText);
		ldbAnswer = LDBFormat.LDBGetText(50001, 20330);
		ldbAnswer = CPHMissionTextFilter.filterHiddenAnswerText(ldbAnswer);
		
		addTextAnswer(ldbText, ldbAnswer, false);
		
				// 3rd screen
		ldbText = LDBFormat.LDBGetText(50002, 30762);
		ldbText = CPHMissionTextFilter.filterHelpQuitText(ldbText);
		
		addTextAnswer(ldbText, "1", true);
		
		// inside hospital
			// 1st keypad
		addKeypadAnswer(51320, "9191046", 6770, new Vector3(252.39385986328,257.28140258789,228.46153259277), "1948555");
		
			// 1st computer
				// 1st screen
		ldbText = LDBFormat.LDBGetText(50002, 30768);
		ldbText = CPHMissionTextFilter.filterIntroText(ldbText);
		ldbText = CPHMissionTextFilter.filterHelpQuitText(ldbText);
		
		addTextAnswer(ldbText, "4", true);
		
				// 2nd screen
		ldbText = LDBFormat.LDBGetText(50002, 30776);
		ldbText = CPHMissionTextFilter.filterHelpQuitText(ldbText);
		
		ldbAnswer = LDBFormat.LDBGetText(50001, 20346);
		ldbAnswer = CPHMissionTextFilter.filterHiddenAnswerText(ldbAnswer);
		
		addTextAnswer(ldbText, ldbAnswer, false);
		
				// 3rd screen
		ldbText = LDBFormat.LDBGetText(50002, 30778);
		ldbText = CPHMissionTextFilter.filterHelpQuitText(ldbText);
		
		ldbAnswer = LDBFormat.LDBGetText(50001, 20356);
		ldbAnswer = CPHMissionTextFilter.filterHiddenAnswerText(ldbAnswer);
		
		addTextAnswer(ldbText, ldbAnswer, false);
		
				// 4th screen
		ldbText = LDBFormat.LDBGetText(50002, 30789);
		ldbText = CPHMissionTextFilter.filterHelpQuitText(ldbText);
		
		addTextAnswer(ldbText, "1", true);
		
				// 5th screen
		ldbText = LDBFormat.LDBGetText(50002, 30796);
		ldbText = CPHMissionTextFilter.filterHelpQuitText(ldbText);
		
		addTextAnswer(ldbText, "1", true);
		
				// 6th screen
		ldbText = LDBFormat.LDBGetText(50002, 30807);
		ldbText = CPHMissionTextFilter.filterResolveGoalText(ldbText);
		
		addTextAnswer(ldbText, CLOSE_TAG, true);
		
			//2nd keypad
		addKeypadAnswer(51320, "9191046", 6770, new Vector3(256.04440307617,274.77368164063,211.45109558105), "4905");
		
			//3rd keypad
		addKeypadAnswer(51320, "9191046", 6770, new Vector3(258.61752319336,234.97196960449,211.58360290527), "18351");
		
			//4th keypad (2 dynel triggers)
		addKeypadAnswer(51320, "9209882", 6770, new Vector3(266.3889465332,233.90547180176,254.48109436035), "6478");
		addKeypadAnswer(51320, "9196461", 6770, new Vector3(267.08578491211,233.8119354248,255.54452514648), "6478");
		
			// 2nd computer
				// 1st screen
		ldbText = LDBFormat.LDBGetText(50002, 30751);
		ldbText = CPHMissionTextFilter.filterIntroText(ldbText);
		ldbText = CPHMissionTextFilter.filterHelpQuitText(ldbText);
		
		addTextAnswer(ldbText, "1", true);
		
				// 2nd screen
		ldbText = LDBFormat.LDBGetText(50002, 30753);
		ldbText = CPHMissionTextFilter.filterHelpQuitText(ldbText);
		
		addTextAnswer(ldbText, "7", true);
		
				// 3rd screen
		ldbText = LDBFormat.LDBGetText(50002, 30767);
		ldbText = CPHMissionTextFilter.filterGameActionText(ldbText);
		
		addTextAnswer(ldbText, CLOSE_TAG, true);
	}
	
	public function GetDVName() {
		return "Wetware";
	}
	
	public function IsValidPlayfield(playfield:Number) {
		return playfield == 6770;
	}
	
	public function GetQuestID() {
		return 3820;
	}
}