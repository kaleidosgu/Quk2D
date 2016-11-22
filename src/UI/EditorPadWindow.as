package UI 
{
	import UI.Data.EditorPadData;
	import gamemap.GameMapBuildingTyp;
	import gamemap.GameObjectMainTyp;
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
		private var _inputVY:FlxInputText = null;
		private var _inputLayer:FlxInputText = null;
		private var _inputDoorDstLayer:FlxInputText = null;
		
		private var _staticTxtName:FlxText = null;
		private var _staticVelocityX:FlxText = null;
		private var _staticVelocityY:FlxText = null;
		private var _staticMapLayer:FlxText = null;
		private var _staticDoorDstLayer:FlxText = null;
		
		private var _padData:EditorPadData = null;
		public function EditorPadWindow(posX:Number, posY:Number,flxGroup:FlxGroup) 
		{
			super(posX, posY, flxGroup);
			
			_padData = new EditorPadData();
		}
		override public function CreateWindow():void
		{
			_staticTxtName = new FlxText(0, 0, 50, "Name: ");
			addItem(_staticTxtName);
			
			_staticVelocityX = new FlxText(0, 20, 70, "VelocityX: ");
			addItem(_staticVelocityX);
			
			_staticVelocityY = new FlxText(0, 40, 70, "VelocityY: ");
			addItem(_staticVelocityY);
			
			_staticMapLayer = new FlxText(0, 60, 70, "MapLayer: ");
			addItem(_staticMapLayer);
			
			_staticDoorDstLayer = new FlxText(0, 80, 70, "DoorDstLayer: ");
			addItem(_staticDoorDstLayer);
		
			_inputVX = new FlxInputText(75, 20, 50, 14, "", 0xffffff, null);
			addItem(_inputVX);
			
			_inputVY = new FlxInputText(75, 40, 50, 14, "", 0xffffff, null);
			addItem(_inputVY);
			
			_inputLayer = new FlxInputText(75, 60, 50, 14, "", 0xffffff, null);
			addItem(_inputLayer);
			
			_inputDoorDstLayer = new FlxInputText(75, 80, 50, 14, "", 0xffffff, null);
			addItem( _inputDoorDstLayer );
			
			initFunction();
			
			super.CreateWindow();
		}
		
		private function initFunction():void
		{
			_staticDoorDstLayer.visible = false;
			_inputDoorDstLayer.visible = false;
		}
		public function GetMapLayerText():String
		{
			return _inputLayer.getText();
		}
		public function changePadLayout( mainTyp:uint, subTyp:uint ):void
		{
			if ( mainTyp == GameObjectMainTyp.GameObjectMainTyp_Building && subTyp == GameMapBuildingTyp.GameMapBuildingTyp_Door )
			{
				_staticDoorDstLayer.visible = true;
				_inputDoorDstLayer.visible = true;
			}
			else
			{
				_staticTxtName.visible = true;
				_staticVelocityX.visible = true;
				_staticVelocityY.visible = true;
				_staticMapLayer.visible = true;
				
				_inputVX.visible = true;
				_inputVY.visible = true;
				_inputLayer.visible = true;
				
				_staticDoorDstLayer.visible = false;
				_inputDoorDstLayer.visible = false;
			}
		}
		
		public function GetPadData():EditorPadData
		{
			_padData.currentLayer = int(GetMapLayerText());
			_padData.doorDstLayer = int(_inputDoorDstLayer.getText());
			return _padData;
		}
	}

}