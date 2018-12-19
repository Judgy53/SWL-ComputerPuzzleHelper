import com.GameInterface.DistributedValue;
import com.GameInterface.ComputerPuzzleIF;
import com.GameInterface.Game.Dynel;
import com.GameInterface.MathLib.Vector3;
import com.GameInterface.Puzzle;
import com.Utils.ID32;

class com.judgy.cph.CPHMission_Base
{
	private var m_enabled:Boolean = true;
	private var DV_enabled:DistributedValue
	
	private var m_loaded:Boolean = false;
	
	private var textAnswersMap:Array = new Array(); //entry format : [TEXT, ANSWER, NEED_QUESTIONS_LOADED, ADDITIONAL_CHECK_FUNCTION]
	private var keypadAnswersMap:Array = new Array(); //entry format : [TYPE, ID, PLAYFIELD, POSITION, ANSWER]
	
	private var keypadWaitInterval:Number = -1;
	
	private static var CLOSE_TAG = "{CLOSE}";
	
	public function CPHMission_Base() {
		DV_enabled = DistributedValue.Create("CPH_" + GetDVName());
		DV_enabled.SignalChanged.Connect(SlotEnabledChanged, this);
	}
	
	public function Load(enabled:Boolean) {
		DV_enabled.SetValue(enabled);
		
		if(m_loaded == false) {
			DoLoad();
			m_loaded = true;
		}
	}
	
	private function DoLoad() {}
	
	public function Unload() {
		DV_enabled.SignalChanged.Disconnect(SlotEnabledChanged, this);
		
		clearInterval(keypadWaitInterval);
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
	
	public function IsValidPlayfield(playfield:Number) {
		return false;
	}
	
	public function GetQuestID() {
		return -1;
	}
	
	private function addTextAnswer(text:String, answer:String, needQuestionsLoaded:Boolean, additionalCheckFunction:Function) {
		textAnswersMap.push([text, answer, needQuestionsLoaded, additionalCheckFunction]);
	}
	
	private function addKeypadAnswer(type:Number, id:String, playfieldID:Number, position:Vector3, answer:String) {
		keypadAnswersMap.push([type, id, playfieldID, position, answer]);
	}
	
	public function TryHandleCP(text:String) {
		if (m_enabled)
			return HandleCP(text);
		else
			return false;
	}
	
	private function HandleCP(text:String) {
		for (var i = 0; i < textAnswersMap.length; i++) {
			var entry = textAnswersMap[i];
			if (text.indexOf(entry[0], 0) != -1) {
				if (entry[2] == true && ComputerPuzzleIF.GetQuestions().length > 0 || entry[2] == false) {
					if (entry[3] != undefined && entry[3]() == false)
						continue;
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
	
	public function TryHandleKeypad(dynelID:ID32) {
		if (m_enabled)
			return HandleKeypad(dynelID);
		else
			return false;
	}
	
	private function HandleKeypad(dynelID:ID32) {
		for (var i = 0; i < keypadAnswersMap.length; i++) {
			var entry:Array = keypadAnswersMap[i];
			var dyn:Dynel = Dynel.GetDynel(dynelID);
			//com.GameInterface.Chat.SetChatInput("pos : " + dyn.GetPosition().x + "," + dyn.GetPosition().y + "," + dyn.GetPosition().z);
			//com.GameInterface.Chat.SignalShowFIFOMessage.Emit("Type:" + dyn.GetID().GetType() + " stat112:" + dyn.GetStat(112) + " playfield:" + dyn.GetPlayfieldID() + " pos:" + dyn.GetPosition().x + "," + dyn.GetPosition().y + "," + dyn.GetPosition().z);
			if (entry[0] == dyn.GetID().GetType() && string(dyn.GetStat(112)) == entry[1] && entry[2] == dyn.GetPlayfieldID() && Math.abs(Vector3.Sub(entry[3], dyn.GetPosition()).Len()) < 0.25) {
				//cursor is on a quest dynel. Now we need to wait for the keypad interface to show up.
				if (keypadWaitInterval != -1) {
					clearInterval(keypadWaitInterval);
					keypadWaitInterval = -1;
				}
				keypadWaitInterval = setInterval(WaitKeypadAndAnswer, 100, entry[4]);
				return true;
			}
		}
		//new dynel doesn't match, clear interval if it exists
		if (keypadWaitInterval != -1) {
			clearInterval(keypadWaitInterval);
			keypadWaitInterval = -1;
		}
		return false;
	}
	
	private function WaitKeypadAndAnswer(answer:String) {
		if (!_root.keypad)
			return;
			
		Puzzle.SendMessageToServer(answer);
		clearInterval(keypadWaitInterval);
	}
}