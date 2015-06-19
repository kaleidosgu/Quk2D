package state 
{
	import flash.events.KeyboardEvent;
	import fsm.PlayerFSM;
	import gamemap.GameMapEditor;
	import gameplay.GameShootingGamePlay;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import util.InputController.GamePlayInputController;
	import util.InputController.InputControllerManager;
	import util.InputController.UIInputController;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class GamePlayState extends FlxState 
	{
		[Embed(source = "../../res/images/spaceman.png")] private static var ImgSpaceman:Class;
		[Embed(source = "../../res/images/cursor.png")] private static var ImgCursor:Class;
		private var _showWidth:uint = 0;
		private var _showHeight:uint = 0;
		private var _showScale:uint = 2;
		private const TILE_WIDTH:uint = 8;
		private const TILE_HEIGHT:uint = 8;
		
		private var mapEditor:GameMapEditor = null;
		
		private var player:FlxSprite = null;
		private var cursorMouse:FlxSprite = null;
		private var _playerCollide:Boolean = false;
		private var inputMgr:InputControllerManager = null;
		private var uiControl:UIInputController = new UIInputController();
		private var gamePlayControl:GamePlayInputController = new GamePlayInputController();
		
		private var _playerFsm:PlayerFSM = null;
		private var _shootingGamePlay:GameShootingGamePlay = null;
		public function GamePlayState() 
		{
			
		}
		
		override public function create():void
		{
			super.create();
			setupPlayer();
			mapEditor = new GameMapEditor( this );
			mapEditor.addCollideActor( player );
			mapEditor.generateMapDataFromByteArray( "test" );
			_showWidth 	= TILE_WIDTH * _showScale ;
			_showHeight	= TILE_HEIGHT * _showScale;
						
			mapEditor.showWidth = _showWidth;
			mapEditor.showHeight = _showHeight;
			inputControlSet();
			
			_playerFsm = new PlayerFSM( FlxG.stage, player );
			_playerFsm.addListener();
			
			_shootingGamePlay = new GameShootingGamePlay( this, player, FlxG.stage );
		}
		private function setupPlayer():void
		{
			player = new FlxSprite(30, 0);
			player.loadGraphic(ImgSpaceman, true, true, 16);
			
			cursorMouse = new FlxSprite( 0, 0 );
			cursorMouse.loadGraphic( ImgCursor, true, true, 15 );
			add( cursorMouse );
			
			player.width = 14;
			player.height = 14;
			player.offset.x = 1;
			player.offset.y = 1;
			
			player.acceleration.y = 300;
			player.maxVelocity.x = 80;
			player.maxVelocity.y = 160;
			
			//animations
			player.addAnimation("idle", [0]);
			player.addAnimation("run", [1, 2, 3, 0], 12);
			player.addAnimation("jump", [4]);
			
			add(player);
		}
		override public function update():void
		{
			super.update();
			cursorMouse.x = FlxG.mouse.x;
			cursorMouse.y = FlxG.mouse.y;
			_shootingGamePlay.update();
		}
		private function inputControlSet():void
		{
			inputMgr = new InputControllerManager( FlxG.stage );
			uiControl.registeController( inputMgr );
			gamePlayControl.registeController( inputMgr );
		}
		override public function destroy():void
		{
			super.destroy();
		}
		
		public override function draw():void
		{
			super.draw();
		}
	}

}