import com.Utils.Archive;
import com.GameInterface.ComputerPuzzleIF;
import com.judgy.cph.CPHMission_Base;
import com.judgy.cph.CPHMission_Foulfellow;

class com.judgy.cph.CPHMod {
	private var m_swfRoot:MovieClip; 
	
	private var m_missionHandlers:Array = new Array();
	
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
    }
	
	public function Load() {
		ComputerPuzzleIF.SignalTextUpdated.Connect(SlotTextUpdated, this);
	}
	
	public function OnUnload() {		
		ComputerPuzzleIF.SignalTextUpdated.Disconnect(SlotTextUpdated, this);
		
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
	
	private function SlotTextUpdated() {
		for (var i = 0; i < m_missionHandlers.length; i++) {
			var handler:CPHMission_Base = m_missionHandlers[i];
			if (handler.TryHandle(ComputerPuzzleIF.GetText()))
				return;
		}
	}
}