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
			
			_txtFlx = new FlxText(400, 5, 200 );
			add( _txtFlx );
		}
		private function createBtn():void
		{
			_wallBtn = new FlxButton(100, 0, "wall", onBtnWallClick );
			_wallBtn.color = 0xff729954;
			_wallBtn.label.color = 0xffd8eba2;
			add( _wallBtn );
			
			_gravityMachineBtn = new FlxButton( 200, 0, "Gravity", onGravityClick );
			_gravityMachineBtn.color = 0xff729954;
			_gravityMachineBtn.label.color = 0xffd8eba2;
			add( _gravityMachineBtn );
			
			_removeBtn = new FlxButton( 300, 0, "Remove", onRemoveBtnClick );
			_removeBtn.color = 0xff729954;
			_removeBtn.label.color = 0xffd8eba2;
			add( _removeBtn );
			
			_btnArray.push( _wallBtn );
			_btnArray.push( _gravityMachineBtn );
			_btnArray.push( _removeBtn );
			
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
				if ( _curMainType == 0 || _curSubTyp == 0 )
				{
					_txtFlx.text = "Please chose Element.";
				}
				if (isBtnClicked())
				{
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
			var bClick:Boolean = true;
			for each( var btn:FlxButton in _btnArray )
			{
				if (( btn.overlapsAt( FlxG.mouse.x, FlxG.mouse.y, btn ) ))
				{
					bClick = false;
					break;
				}
			}
			return bClick;
		}
	}

}