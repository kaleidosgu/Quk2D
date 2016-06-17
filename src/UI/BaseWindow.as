package UI 
{
	import org.flixel.FlxBasic;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BaseWindow extends FlxGroup 
	{
		
		private var _posX:Number = 0;
		private var _posY:Number = 0;
		private var _bakFlxGroup:FlxGroup = null;
		public function BaseWindow( posX:Number, posY:Number,flxGroup:FlxGroup ) 
		{
			super();
			_posX = posX;
			_posY = posY;
			_bakFlxGroup = flxGroup;
		}
		
		public function addItem(ObjectIn:FlxObject):void
		{
			super.add( ObjectIn );
			ObjectIn.x += _posX;
			ObjectIn.y += _posY;
		}
		
		public function CreateWindow():void
		{
			if ( _bakFlxGroup != null )
			{
				_bakFlxGroup.add( this );
			}
		}
	}

}