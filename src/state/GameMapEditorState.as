package state 
{
	import gamemap.GameMapBuildingTyp;
	import gamemap.GameObjectMainTyp;
	import org.flixel.FlxButton;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxPoint;
	import org.flixel.FlxObject;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	import org.flixel.FlxXML;
	
	import util.KalTxtResourcePath;
	import util.KalResourceDataWrite;
	
	import gamemap.GameMapEditor;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class GameMapEditorState extends FlxState 
	{
		[Embed(source = '../../res/images/world.png')]
		private static var myblock:Class;
		[Embed(source="../../res/actionBoard.xml",mimeType="application/octet-stream")]
		protected var embXML:Class;
		private var highlightBox:FlxObject;
		private var _showWidth:uint = 0;
		private var _showHeight:uint = 0;
		private var _showScale:uint = 2;
		private const TILE_WIDTH:uint = 8;
		private const TILE_HEIGHT:uint = 8;
		
		private var mapEditor:GameMapEditor = null;
		
		private var _curMainType:uint = 0;
		private var _curSubTyp:uint = 0;
		
		private var _wallGroup:FlxGroup = new FlxGroup();
		
		public var _wallBtn:FlxButton = null;
		public var _gravityMachineBtn:FlxButton = null;
		public var _removeBtn:FlxButton = null;
		private var _btnArray:Array = new Array();
		private var _txtFlx:FlxText	= null;
		private var _buttonObjectArray:Array = new Array();
		private var _buttonNameTag:String = "btnNameTag";
		private var _buttonFunctionTag:String = "btnFunctionTag";
		public function GameMapEditorState() 
		{
			
		}
		
		override public function create():void
		{
			super.create();
			mapEditor = new GameMapEditor( this );
			this.add( _wallGroup );
			mapEditor.generateMapDataFromByteArray( "test" );
			_showWidth 	= TILE_WIDTH * _showScale ;
			_showHeight	= TILE_HEIGHT * _showScale;
			
			FlxG.visualDebug = true;
			
			mapEditor.showWidth = _showWidth;
			mapEditor.showHeight = _showHeight;
			highlightBox = new FlxObject(0, 0, _showWidth, _showHeight);
			
			createBtn();
			
			_txtFlx = new FlxText(500, 5, 200 );
			add( _txtFlx );
		}
		private function addButtonObj( nameString:String, callBackFunction:Function ):void
		{
			var objBtn:Object = new Object();
			objBtn[_buttonNameTag] = nameString;
			objBtn[_buttonFunctionTag] = callBackFunction;
			_buttonObjectArray.push( objBtn );
		}
		private function createBtn():void
		{
			addButtonObj( "wall", onBtnWallClick );
			addButtonObj( "Gravity", onGravityClick );
			addButtonObj( "Teleport", onTeleportClick );
			addButtonObj( "Elevator", onElevatorClick );
			addButtonObj( "Remove", onRemoveBtnClick );
			
			var posStart:Number = 100;
			var posDiff:Number = 100;
			for each( var btnObj:Object in _buttonObjectArray )
			{
				var btnIns:FlxButton = new FlxButton(posStart, 0, btnObj[_buttonNameTag], btnObj[_buttonFunctionTag] );
				btnIns.color = 0xff729954;
				btnIns.label.color = 0xffd8eba2;
				add( btnIns );
				_btnArray.push( btnIns );
				posStart += posDiff;
			}
		}
		private function onRemoveBtnClick():void
		{
			_curMainType = 0;
			_curSubTyp = 0;
		}
		private function onBtnWallClick():void
		{
			_curMainType = GameObjectMainTyp.GameObjectMainTyp_Building;
			_curSubTyp = GameMapBuildingTyp.GameMapBuildingTyp_Wall;
		}
		private function onGravityClick():void {
			_curMainType = GameObjectMainTyp.GameObjectMainTyp_Building;
			_curSubTyp = GameMapBuildingTyp.GameMapBuildingTyp_GravityMachine;
		}
		private function onTeleportClick():void {
			_curMainType = GameObjectMainTyp.GameObjectMainTyp_Building;
			_curSubTyp = GameMapBuildingTyp.GameMapBuildingTyp_Teleport;
		}
		private function onElevatorClick():void {
			_curMainType = GameObjectMainTyp.GameObjectMainTyp_Building;
			_curSubTyp = GameMapBuildingTyp.GameMapBuildingTyp_Elevator;
		}
		override public function destroy():void
		{
			super.destroy();
		}
		
		public override function draw():void
		{
			super.draw();
			highlightBox.drawDebug();
		}
		private function getHightLightBoxPoint( posX:Number, posY:Number ):FlxPoint
		{
			var flxPoint:FlxPoint = new FlxPoint( posX, posY );
			flxPoint.x = Math.floor(posX / _showWidth) * _showWidth;
			flxPoint.y = Math.floor(posY / _showHeight) * _showHeight;
			return flxPoint;
		}
		override public function update():void
		{
			var hightLightPoint:FlxPoint = getHightLightBoxPoint(FlxG.mouse.x, FlxG.mouse.y);
			highlightBox.x = FlxG.mouse.x;
			highlightBox.y = FlxG.mouse.y;
			
			if (FlxG.mouse.pressed())
			{
				if (isBtnClicked())
				{
				}
				else
				{
					if ( _curMainType == 0 || _curSubTyp == 0 )
					{
						_txtFlx.text = "Please chose Element.";
					}
					mapEditor.updateMap( hightLightPoint.x, hightLightPoint.y,_curMainType, _curSubTyp );
				}
			}
			if ( FlxG.keys.justReleased( "J" ) )
			{
				mapEditor.saveMapIntoFile();
			}
			super.update();
		}
		
		private function isBtnClicked():Boolean 
		{
			var bClick:Boolean = false;
			for each( var btn:FlxButton in _btnArray )
			{
				if (( btn.overlapsAt( FlxG.mouse.x, FlxG.mouse.y, btn ) ))
				{
					bClick = true;
					break;
				}
			}
			return bClick;
		}
	}

}