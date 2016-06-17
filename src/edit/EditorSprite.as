package edit 
{
	import org.flixel.FlxButton;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class EditorSprite extends FlxGroup 
	{
		
		public function EditorSprite() 
		{
			super();
		}
		public function createIns():void
		{
			var btnIns:FlxButton = new FlxButton(0, 330, "test", onClick );
			btnIns.color = 0xff729954;
			btnIns.label.color = 0xffd8eba2;
			add(btnIns);
		}
		private function onClick():void
		{
			
		}
	}

}