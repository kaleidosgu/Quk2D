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
		private var _btnArray:Array = new Array();
		public function GameMapEditorState() 
		{
			
		}
		
		override public function create():void
		{
			super.create();
			
			_curMainType = GameObjectMainTyp.GameObjectMainTyp_Building;
			_curSubTyp = GameMapBuildingTyp.GameMapBuildingTyp_Wall;

			mapEditor = new GameMapEditor( _wallGroup );
			this.add( _wallGroup );
			mapEditor.generateMapDataFromByteArray();
			_showWidth 	= TILE_WIDTH * _showScale ;
			_showHeight	= TILE_HEIGHT * _showScale;
			
			FlxG.visualDebug = true;
			
			/*
			var testSprite:FlxSprite = new FlxSprite( 0, 0, myblock );
			testSprite.ignoreDrawDebug = false;
			//testSprite.x = 15;
			//testSprite.y = 15;
			testSprite.loadGraphic( myblock, true, true, 8, 8 );
			testSprite.frame = 3 * 16;
			testSprite.scale.x = _showScale;
			testSprite.scale.y = _showScale;
			testSprite.offset.x -= 8 * ( _showScale - 1 ) / 2; 
			testSprite.offset.y -= 8 * ( _showScale - 1 ) / 2;
			testSprite.x = 0;
			testSprite.y = 0;
			
			this.add( testSprite );
			*/
		
			mapEditor.showWidth = _showWidth;
			mapEditor.showHeight = _showHeight;
			highlightBox = new FlxObject(0, 0, _showWidth, _showHeight);
			
			createBtn();
		}
		private function createBtn():void
		{
			_wallBtn = new FlxButton(100, 500, "wall", onBtnWallClick );
			_wallBtn.color = 0xff729954;
			_wallBtn.label.color = 0xffd8eba2;
			add( _wallBtn );
			
			_btnArray.push( _wallBtn );
		}
		private function onBtnWallClick( ):void
		{
			var dd:int = 0;
			//playButton.exists = false;
			//FlxG.play(SndHit2);
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
		private function getHightLightBoxPoint():FlxPoint
		{
			var flxPoint:FlxPoint = new FlxPoint();
			flxPoint.x = Math.floor(FlxG.mouse.x / _showWidth) * _showWidth;
			flxPoint.y = Math.floor(FlxG.mouse.y / _showHeight) * _showHeight;
			return flxPoint;
		}
		override public function update():void
		{
			var hightLightPoint:FlxPoint = getHightLightBoxPoint();
			highlightBox.x = hightLightPoint.x;
			highlightBox.y = hightLightPoint.y;
			
			if (FlxG.mouse.pressed())
			{
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
			var bClick:Boolean = false;
			for each( var btn:FlxButton in _btnArray )
			{
				if (!( btn.overlapsAt( FlxG.mouse.x, FlxG.mouse.y, _wallBtn ) ))
				{
					bClick = true;
					break;
				}
			}
			return bClick;
		}
	}

}