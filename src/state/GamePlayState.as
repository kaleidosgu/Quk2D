package state 
{
	import flash.events.KeyboardEvent;
	import fsm.PlayerFSM;
	import gamemap.GameMapEditor;
	import gameplay.GameShootingGamePlay;
	import gameplay.WeaponSystem.BulletCollideMonitor;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import player.BasePlayerObject;
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
		
		private var player:BasePlayerObject = null;
		private var targetSprite:BasePlayerObject = null;
		private var cursorMouse:FlxSprite = null;
		private var _playerCollide:Boolean = false;
		private var inputMgr:InputControllerManager = null;
		private var uiControl:UIInputController = new UIInputController();
		private var gamePlayControl:GamePlayInputController = new GamePlayInputController();
		
		private var _playerFsm:PlayerFSM = null;
		private var _shootingGamePlay:GameShootingGamePlay = null;
		
		private var _playerGroup:FlxGroup 	= null;
		private var _bulletGroup:FlxGroup	= null;
		
		private var _bulletCollideMonitor:BulletCollideMonitor = null;
		public function GamePlayState() 
		{
			_playerGroup 	= new FlxGroup();
			_bulletGroup	= new FlxGroup();
		}
		
		override public function create():void
		{
			super.create();
			player = new BasePlayerObject();
			targetSprite = new BasePlayerObject();
			
			this.add( _bulletGroup );
			_bulletCollideMonitor = new BulletCollideMonitor(_bulletGroup, _playerGroup,player );
			
			setupPlayer( player, 30, 0 );
			setupPlayer( targetSprite,100,0 );
			mapEditor = new GameMapEditor( this,_playerGroup );
			
			mapEditor.addActor( player );
			mapEditor.addActor( targetSprite );
			
			mapEditor.generateMapDataFromByteArray( "test" );
			_showWidth 	= TILE_WIDTH * _showScale ;
			_showHeight	= TILE_HEIGHT * _showScale;
						
			mapEditor.showWidth = _showWidth;
			mapEditor.showHeight = _showHeight;
			inputControlSet();
			
			_playerFsm = new PlayerFSM( FlxG.stage, player );
			_playerFsm.addListener();
			
			_shootingGamePlay = new GameShootingGamePlay( this, player, FlxG.stage,_bulletGroup );
		}
		private function setupPlayer( playerSprite:BasePlayerObject, posX:Number, posY:Number ):void
		{
			playerSprite.x = posX;
			playerSprite.y = posY;
			playerSprite.loadGraphic(ImgSpaceman, true, true, 16);
			
			cursorMouse = new FlxSprite( 0, 0 );
			cursorMouse.loadGraphic( ImgCursor, true, true, 15 );
			add( cursorMouse );
			
			playerSprite.width = 14;
			playerSprite.height = 14;
			playerSprite.offset.x = 1;
			playerSprite.offset.y = 1;
			
			playerSprite.acceleration.y = 300;
			playerSprite.maxVelocity.x = 80;
			playerSprite.maxVelocity.y = 160;
			
			//animations
			playerSprite.addAnimation("idle", [0]);
			playerSprite.addAnimation("run", [1, 2, 3, 0], 12);
			playerSprite.addAnimation("jump", [4]);
			
			add(playerSprite);
		}
		override public function update():void
		{
			super.update();
			cursorMouse.x = FlxG.mouse.x;
			cursorMouse.y = FlxG.mouse.y;
			_shootingGamePlay.update();
			mapEditor.update();
			_bulletCollideMonitor.update();
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