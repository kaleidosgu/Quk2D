package UI 
{
	import org.flixel.FlxButton;
	import org.flixel.FlxGroup;
	import org.flixel.FlxText;
	import third.flixel.FlxInputText;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class EditorPadWindow extends BaseWindow 
	{
		private var _inputVX:FlxInputText = null;
		public function EditorPadWindow(posX:Number, posY:Number,flxGroup:FlxGroup) 
		{
			super(posX, posY,flxGroup);
		}
		override public function CreateWindow():void
		{
			var txtName:FlxText = new FlxText(0, 0, 50, "Name: ");
			addItem(txtName);
			
			var txtVelocityX:FlxText = new FlxText(0, 20, 70, "VelocityX: ");
			addItem(txtVelocityX);
			
			var txtVelocityY:FlxText = new FlxText(0, 40, 70, "VelocityY: ");
			addItem(txtVelocityY);
		
			_inputVX = new FlxInputText(0, 160, 50, 30, "", 0xffffff, null) 
			addItem(_inputVX);
			
			super.CreateWindow();
		}
		
	}

}