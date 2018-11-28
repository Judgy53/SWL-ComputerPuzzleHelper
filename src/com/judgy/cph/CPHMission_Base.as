import com.GameInterface.DistributedValue;
import com.GameInterface.ComputerPuzzleIF;

class com.judgy.cph.CPHMission_Base
{
	private var m_enabled:Boolean = true;
	private var DV_enabled:DistributedValue
	
	private var textAnswersMap:Array = new Array(); //entry format : [TEXT, ANSWER, NEED_QUESTIONS_LOADED]
	
	private static var CLOSE_TAG = "{CLOSE}";
	
	public function CPHMission_Base() {
		DV_enabled = DistributedValue.Create("CPH_" + GetDVName());
	}
	
	public function Load(enabled:Boolean) {
		m_enabled = enabled;
		DV_enabled.SetValue(enabled);
		
		DV_enabled.SignalChanged.Connect(SlotEnabledChanged, this);
	}
	
	public function Unload() {
		DV_enabled.SignalChanged.Disconnect(SlotEnabledChanged, this);
	}
	
	private function SlotEnabledChanged(dv:DistributedValue) {
		if (DV_enabled.GetValue())
			m_enabled = true;
		else
			m_enabled = false;
	}
	
	public function IsEnabled() {
		return m_enabled;
	}
		
	public function GetDVName() {
		return "Base";
	}
	
	private function insertAnswer(text:String, answer:String, needQuestionsLoaded:Boolean) {
		textAnswersMap.push([text, answer, needQuestionsLoaded]);
	}
	
	public function TryHandle(text:String) {
		if (m_enabled)
			return Handle(text);
		else
			return false;
	}
	
	private function Handle(text:String) {
		for (var i = 0; i < textAnswersMap.length; i++) {
			var entry = textAnswersMap[i];
			if (text.indexOf(entry[0], 0) != -1) {
				if (entry[2] == true && ComputerPuzzleIF.GetQuestions().length > 0 || entry[2] == false) {
					if (entry[1].indexOf(CLOSE_TAG) == 0) {
						ComputerPuzzleIF.SignalClose.Emit();
					}
					else
						ComputerPuzzleIF.AcceptPlayerInput(entry[1]);	
					return true;
				}
			}
		}
		return false;
	}
}