class com.judgy.cph.CPHMissionTextFilter
{
	public static function filterIntroText(text:String) {
		var textSplit:Array = text.split("{delay "); //delay seems to always be 2, but don't assume it is
		if (textSplit.length > 0)
			return textSplit[1].substring(2);
		else
			return text;
	}
	
	public static function filterHelpQuitText(text:String) {
		var textSplit:Array = text.split("{appendhelpquit}");
		if (textSplit.length > 0)
			return textSplit[0];
		else
			return text;
	}
	
	public static function filterResolveGoalText(text:String) {
		var textSplit:Array = text.split("{resolvegoal");
		if (textSplit.length > 0)
			return textSplit[0];
		else
			return text;
	}
	
	public static function filterHiddenAnswerText(text:String) {
		var textSplit:Array = text.split("{hide}");
		if (textSplit.length > 0)
			return textSplit[0];
		else
			return text;
	}
}