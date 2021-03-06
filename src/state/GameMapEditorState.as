package state 
{
	import edit.EditorSprite;
	import gameEvent.BattleEvent.BattleGroundMapLayerChangedEvent;
	import gamemap.GameMapBuildingTyp;
	import gamemap.GameMapItemTyp;
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
	import UI.EditorPadWindow;
	import util.EventDispatch.GameDispatchSystem;
	
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
		private var _mapLayer:uint = 0;
		
		private var _wallGroup:FlxGroup = new FlxGroup();
		
		private var _btnArray:Array = new Array();
		private var _txtFlx:FlxText	= null;
		private var _buttonObjectArray:Array = new Array();
		private var _buttonNameTag:String = "btnNameTag";
		private var _buttonFunctionTag:String = "btnFunctionTag";
		
		private var _choose:Boolean = true;
		
		private var editor:EditorPadWindow = null;
		private var _dspSystem:GameDispatchSystem = null;
		public function GameMapEditorState() 
		{
			_dspSystem = new GameDispatchSystem( FlxG.stage );
			
		}
		
		override public function create():void
		{
			super.create();
			mapEditor = new GameMapEditor( this,null,_dspSystem );
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
			_txtFlx.text = "fsfsf";
			add( _txtFlx );
			
			editor = new EditorPadWindow(0,300,this);
			editor.CreateWindow();
		}
		private function onClick():void
		{
			
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
			addButtonObj( "Health", onHealthBtnClick );
			addButtonObj( "Door", onDoorBtnClick );
			addButtonObj( "Choose", onChooseBtnClick );
			addButtonObj( "ChangeLayer", onChangeLayer );
			
			var posXStart:Number = 100;
			var posYStart:Number = 0;
			var posXDiff:Number = 100;
			var btnIndex:uint = 0;
			var posYDiff:Number = 30;
			var cntBtnColumn:uint = 5;
			for each( var btnObj:Object in _buttonObjectArray )
			{
				if ( btnIndex / cntBtnColumn > 0 && ( btnIndex % cntBtnColumn == 0 ) )
				{
					posXStart = 100;
					posYStart += posYDiff;
				}
				var btnIns:FlxButton = new FlxButton(posXStart, posYStart, btnObj[_buttonNameTag], btnObj[_buttonFunctionTag] );
				btnIns.color = 0xff729954;
				btnIns.label.color = 0xffd8eba2;
				add( btnIns );
				_btnArray.push( btnIns );
				posXStart += posXDiff;
				btnIndex++;
			}
		}
		private function onRemoveBtnClick():void
		{
			_curMainType = 0;
			_curSubTyp = 0;
			_choose = false;
			editor.changePadLayout(_curMainType, _curSubTyp);
		}
		private function onHealthBtnClick():void
		{
			_curMainType = GameObjectMainTyp.GameObjectMainTyp_Item;
			_curSubTyp = GameMapItemTyp.GameMapItemTyp_Health;
			_choose = false;
			editor.changePadLayout(_curMainType, _curSubTyp);
		}
		private function onDoorBtnClick():void
		{
			_curMainType = GameObjectMainTyp.GameObjectMainTyp_Building;
			_curSubTyp = GameMapBuildingTyp.GameMapBuildingTyp_Door;
			_choose = false;
			editor.changePadLayout(_curMainType, _curSubTyp);
		}
		private function onChooseBtnClick():void
		{
			_choose = true;
		}
		
		private function onChangeLayer():void
		{
			_mapLayer = int(editor.GetMapLayerText());
			var evt:BattleGroundMapLayerChangedEvent = new BattleGroundMapLayerChangedEvent(BattleGroundMapLayerChangedEvent.BattleGroundMapLayerChanged );
			evt.mapLayer = _mapLayer;
			_dspSystem.DispatchEvent(evt);
			
		}
		private function onBtnWallClick():void
		{
			_curMainType = GameObjectMainTyp.GameObjectMainTyp_Building;
			_curSubTyp = GameMapBuildingTyp.GameMapBuildingTyp_Wall;
			_choose = false;
			editor.changePadLayout(_curMainType, _curSubTyp);
		}
		private function onGravityClick():void {
			_curMainType = GameObjectMainTyp.GameObjectMainTyp_Building;
			_curSubTyp = GameMapBuildingTyp.GameMapBuildingTyp_GravityMachine;
			_choose = false;
			editor.changePadLayout(_curMainType, _curSubTyp);
		}
		private function onTeleportClick():void {
			_curMainType = GameObjectMainTyp.GameObjectMainTyp_Building;
			_curSubTyp = GameMapBuildingTyp.GameMapBuildingTyp_Teleport;
			_choose = false;
			editor.changePadLayout(_curMainType, _curSubTyp);
		}
		private function onElevatorClick():void {
			_curMainType = GameObjectMainTyp.GameObjectMainTyp_Building;
			_curSubTyp = GameMapBuildingTyp.GameMapBuildingTyp_Elevator;
			_choose = false;
			editor.changePadLayout(_curMainType, _curSubTyp);
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
					if ( _choose == false )
					{
						if ( _curMainType == 0 || _curSubTyp == 0 )
						{
							mapEditor.removeMapElement( hightLightPoint.x, hightLightPoint.y,_mapLayer );
						}
						else
						{
							mapEditor.updateMap( hightLightPoint.x, hightLightPoint.y,_curMainType, _curSubTyp,_mapLayer,editor.GetPadData() );	
						}	
					}
					else
					{
						mapEditor.choseItem( hightLightPoint.x, hightLightPoint.y );
					}
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