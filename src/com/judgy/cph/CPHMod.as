import com.judgy.cph.CPHMission_KingsmouthCode;
import mx.utils.Delegate;
import com.Utils.Archive;
import com.Utils.ID32;
import com.Utils.GlobalSignal;
import com.GameInterface.ComputerPuzzleIF;
import com.GameInterface.QuestsBase;
import com.GameInterface.WaypointInterface;
import com.GameInterface.Game.Character;
import com.judgy.cph.CPHMission_Base;
import com.judgy.cph.CPHMission_FogAndMirrors;
import com.judgy.cph.CPHMission_Foulfellow;
import com.judgy.cph.CPHMission_Wetware;

class com.judgy.cph.CPHMod {
	private var m_swfRoot:MovieClip; 
	
	private var m_missionHandlers:Array = new Array();
	private var m_playfield:Number;
	private var m_targetSlotEnabled:Boolean = false;
	
	public static function main(swfRoot:MovieClip) {
		var s_app = new CPHMod(swfRoot);
		
		swfRoot.onLoad = function() { s_app.Load(); };
		swfRoot.onUnload = function() { s_app.Unload(); };
		swfRoot.OnModuleActivated = function(config:Archive) { s_app.LoadConfig(config);};
		swfRoot.OnModuleDeactivated = function() { return s_app.SaveConfig(); };
	}
	
	public function CPHMod(swfRoot:MovieClip) {
		m_swfRoot = swfRoot;
		
		//Create mission handlers
		m_missionHandlers.push(new CPHMission_Foulfellow());
		m_missionHandlers.push(new CPHMission_Wetware());
		m_missionHandlers.push(new CPHMission_FogAndMirrors());
		m_missionHandlers.push(new CPHMission_KingsmouthCode());
    }
	
	public function Load() {
		WaypointInterface.SignalPlayfieldChanged.Connect(SlotPlayfieldChanged, this);
		SlotPlayfieldChanged();
		
		QuestsBase.SignalTaskAdded.Connect(SlotTaskAdded, this);
		QuestsBase.SignalMissionCompleted.Connect(SlotPlayfieldChanged, this);
		QuestsBase.SignalMissionRemoved.Connect(SlotPlayfieldChanged, this);
		
		var quests:Array = QuestsBase.GetAllActiveQuests();
		for (var i = 0; i < quests.length; i++)
			SlotTaskAdded(quests[i].m_ID);
		
		//Computers are rare enough that we can keep the signal connected at any time
		ComputerPuzzleIF.SignalTextUpdated.Connect(SlotTextUpdated, this);
	}
	
	public function OnUnload() {		
		WaypointInterface.SignalPlayfieldChanged.Disconnect(SlotPlayfieldChanged, this);
		ComputerPuzzleIF.SignalTextUpdated.Disconnect(SlotTextUpdated, this);
		DisableTargetSlot();
		
		QuestsBase.SignalTaskAdded.Connect(SlotTaskAdded, this);
		QuestsBase.SignalMissionCompleted.Connect(SlotPlayfieldChanged, this);
		QuestsBase.SignalMissionRemoved.Connect(SlotPlayfieldChanged, this);
		
		//unload mission handlers
		while (m_missionHandlers.length > 0)
			m_missionHandlers.shift().Unload();
	}
	
	public function LoadConfig(config:Archive) {
		for (var i = 0; i < m_missionHandlers.length; i++) {
			var handler:CPHMission_Base = m_missionHandlers[i];
			handler.Load(config.FindEntry(handler.GetDVName(), true));
		}
	}
	
	public function SaveConfig() {	
		var archive: Archive = new Archive();
		
		for (var i = 0; i < m_missionHandlers.length; i++) {
			var handler:CPHMission_Base = m_missionHandlers[i];
			archive.AddEntry(handler.GetDVName(), handler.IsEnabled());
		}
		
		return archive;
	}
	
	private function EnableTargetSlot() {
		if (m_targetSlotEnabled)
			return;
		
		//com.GameInterface.UtilsBase.PrintChatText("TargetSlot Enabled");
			
		GlobalSignal.SignalCrosshairTargetUpdated.Connect(SlotCrosshairTargetUpdated, this);
		m_targetSlotEnabled = true;
	}
	
	private function DisableTargetSlot() {
		if (!m_targetSlotEnabled)
			return;
		
		//com.GameInterface.UtilsBase.PrintChatText("TargetSlot Disabled");
		
		GlobalSignal.SignalCrosshairTargetUpdated.Disconnect(SlotCrosshairTargetUpdated, this);
		m_targetSlotEnabled = false;
	}
	
	private function SlotPlayfieldChanged() {
		DisableTargetSlot();
		
		DelayedPlayfieldChanged();
	}
	
	private function DelayedPlayfieldChanged() {
		m_playfield = Character.GetClientCharacter().GetPlayfieldID();
		if (m_playfield == 0) {
			setTimeout(Delegate.create(this, DelayedPlayfieldChanged), 500);
			return;
		}
		//com.GameInterface.UtilsBase.PrintChatText("Playfield Changed : " + m_playfield);
		for (var i = 0; i < m_missionHandlers.length; i++) {
			if (m_missionHandlers[i].IsValidPlayfield(m_playfield) && QuestsBase.IsMissionActive(m_missionHandlers[i].GetQuestID())) {
				EnableTargetSlot();
				return;
			}
		}
	}
	
	private function SlotTaskAdded(questID:Number) {
		//com.GameInterface.UtilsBase.PrintChatText("New Quest : " + questID + " [" + QuestsBase.GetQuest(questID).m_MissionName + "]");
		for (var i = 0; i < m_missionHandlers.length; i++) {
			if (questID == m_missionHandlers[i].GetQuestID() && m_missionHandlers[i].IsValidPlayfield(m_playfield)) {
				EnableTargetSlot();
				return;
			}
		}
	}
	
	private function SlotTextUpdated() {
		for (var i = 0; i < m_missionHandlers.length; i++) {
			if (QuestsBase.IsMissionActive(m_missionHandlers[i].GetQuestID()) && m_missionHandlers[i].TryHandleCP(ComputerPuzzleIF.GetText()))
				return;
		}
	}
	
	private function SlotCrosshairTargetUpdated(dynelID:ID32) {
		if (dynelID == undefined || dynelID.GetType() == 0)
			return;
			
		for (var i = 0; i < m_missionHandlers.length; i++) {
			if (QuestsBase.IsMissionActive(m_missionHandlers[i].GetQuestID()) && m_missionHandlers[i].IsValidPlayfield(m_playfield) && m_missionHandlers[i].TryHandleKeypad(dynelID))
				return;
		}
	}
}