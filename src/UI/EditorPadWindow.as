package UI 
{
	import org.flixel.FlxButton;
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class EditorPadWindow extends BaseWindow 
	{
		public function EditorPadWindow(posX:Number, posY:Number,flxGroup:FlxGroup) 
		{
			super(posX, posY,flxGroup);
		}
		override public function CreateWindow():void
		{
			var btnIns:FlxButton = new FlxButton(0, 0, "testbtn", null );
			btnIns.color = 0xff729954;
			btnIns.label.color = 0xffd8eba2;
			addItem(btnIns);
			
			super.CreateWindow();
		}
		
	}

}