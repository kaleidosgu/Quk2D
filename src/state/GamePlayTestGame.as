package state 
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import fsm.PlayerFSM;
	import fsm.PlayerFsmTest;
	import gameEvent.BattleEvent.BattleGroundMapLayerChangedEvent;
	import gameEvent.PlayerInputActionEvent;
	import gameEvent.PlayerInputActionType;
	import gamemap.GameMapEditor;
	import gameplay.ExplosionObjectGenerator;
	import gameplay.GameShootingGamePlay;
	import gameplay.soundsys.QukSoundSystem;
	import gameplay.WeaponSystem.BulletCollideMonitor;
	import gameplay.WeaponSystem.Explosion.BaseExplosionObject;
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import player.BasePlayerObject;
	import util.EventDispatch.GameDispatchSystem;
	import util.InputController.GamePlayInputController;
	import util.InputController.InputControllerManager;
	import util.InputController.UIInputController;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class GamePlayTestGame extends FlxState 
	{
		[Embed(source = "../../res/images/spaceman.png")] private static var ImgSpaceman:Class;
		[Embed(source = "../../res/images/cursor.png")] private static var ImgCursor:Class;
		private var _showWidth:uint = 0;
		private var _showHeight:uint = 0;
		private var _showScale:uint = 2;
		private const TILE_WIDTH:uint = 8;
		private const TILE_HEIGHT:uint = 8;
		
		private var mapEditor:GameMapEditor = null;
		
		private var playerIns:BasePlayerObject = null;
		private var targetSprite:BasePlayerObject = null;
		private var cursorMouse:FlxSprite = null;
		private var inputMgr:InputControllerManager = null;
		private var uiControl:UIInputController = new UIInputController();
		private var gamePlayControl:GamePlayInputController = new GamePlayInputController();
		private var gamePlayControlSecond:GamePlayInputController = new GamePlayInputController();
		
		private var _playerFsm:PlayerFsmTest = null;
		private var _playerFsmSecond:PlayerFsmTest = null;
		
		private var _playerGroup:FlxGroup 			= null;
		private var _bulletGroup:FlxGroup			= null;
		private var _explosionGroup:FlxGroup		= null;
		
		private var _dspSystem:GameDispatchSystem = null;
		private var _txtPlayer1:FlxText	= null;
		private var _txtPlayer2:FlxText	= null;
		
		private var _txtMatchResult:FlxText	= null;
		
		private var _player1Group:FlxGroup = new FlxGroup();
		private var _player2Group:FlxGroup = new FlxGroup();
		
		private var _KeyMap:Object = new Object();
		private var _resultMap:Object = new Object();
		private var _winCountsPlayer1:uint = 0;
		private var _winCountsPlayer2:uint = 0;
		public function GamePlayTestGame() 
		{
			_playerGroup 	= new FlxGroup();
			_bulletGroup	= new FlxGroup();
			_explosionGroup	= new FlxGroup();
			
			_dspSystem = new GameDispatchSystem( FlxG.stage );
		}
		override public function create():void
		{
			super.create();
			playerIns = new BasePlayerObject();
			targetSprite = new BasePlayerObject();
			this.add(_player1Group);
			this.add(_player2Group);
			
			_player1Group.add(playerIns);
			_player2Group.add(targetSprite);
			
			this.add( _explosionGroup );
			this.add( _bulletGroup );			
			
			cursorMouse = new FlxSprite( 0, 0 );
			cursorMouse.loadGraphic( ImgCursor, true, true, 15 );
			add( cursorMouse );
			
			setupPlayer( playerIns, 40, 100 );
			setupPlayer( targetSprite, 700, 100 );
			
			setPlayerPos();
			mapEditor = new GameMapEditor( this, _playerGroup, _dspSystem );
			//mapEditor.addGroup( _player1Group );
			//mapEditor.addGroup( _player2Group );
			
			mapEditor.generateMapDataFromByteArray( "test" );
			_showWidth 	= TILE_WIDTH * _showScale ;
			_showHeight	= TILE_HEIGHT * _showScale;
						
			mapEditor.showWidth = _showWidth;
			mapEditor.showHeight = _showHeight;
			inputControlSet();
			
			_playerFsm = new PlayerFsmTest( FlxG.stage, playerIns );
			_playerFsm.addListener();
			
			_playerFsmSecond = new PlayerFsmTest( FlxG.stage, targetSprite );
			_playerFsmSecond.addListener();
			
			_txtPlayer1 = new FlxText(100, 5, 200 );
			_txtPlayer1.text = "1";
			_txtPlayer1.size = 100;
			add( _txtPlayer1 );
			
			_txtPlayer2 = new FlxText(650, 5, 200 );
			_txtPlayer2.text = "1";
			_txtPlayer2.size = 100;
			add( _txtPlayer2 );
			
			_txtMatchResult = new FlxText(350, 5, 200 );
			_txtMatchResult.text = "0:0";
			_txtMatchResult.size = 25;
			add( _txtMatchResult );
			
			
			_KeyMap[FlxG.keys.getKeyCode( "H" )] = "1";
			_KeyMap[FlxG.keys.getKeyCode( "J" )] = "2";
			_KeyMap[FlxG.keys.getKeyCode( "K" )] = "3";
			
			_KeyMap[FlxG.keys.getKeyCode( "NUMPADFOUR" )] = "1";
			_KeyMap[FlxG.keys.getKeyCode( "NUMPADFIVE" )] = "2";
			_KeyMap[FlxG.keys.getKeyCode( "NUMPADSIX" )] = "3";
			
			_resultMap["12"] = 1; //石头剪子
			_resultMap["13"] = 2; //石头布
			_resultMap["11"] = 0;
			_resultMap["31"] = 1; //布石头
			_resultMap["33"] = 0;
			_resultMap["32"] = 2; //布剪子
			_resultMap["22"] = 0;
			_resultMap["23"] = 1;
			_resultMap["21"] = 1;
			
			FlxG.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyDown);
		}
		protected function onKeyDown(FlashEvent:KeyboardEvent):void
		{
			if ( FlxG.keys.justReleased("H") || FlxG.keys.justReleased("J") || FlxG.keys.justReleased("K") )
			{
				castSkill(playerIns,FlashEvent.keyCode);
			}
			if ( FlxG.keys.justReleased("NUMPADFOUR") || FlxG.keys.justReleased("NUMPADFIVE") || FlxG.keys.justReleased("NUMPADSIX") )
			{
				castSkill(targetSprite,FlashEvent.keyCode);
			}
		}
		private function setupPlayer( playerSprite:BasePlayerObject, posX:Number, posY:Number ):void
		{
			playerSprite.x = posX;
			playerSprite.y = posY;
			playerSprite.loadGraphic(ImgSpaceman, true, true, 16);
			
			playerSprite.width = 14;
			playerSprite.height = 14;
			playerSprite.offset.x = 1;
			playerSprite.offset.y = 1;
			
			//playerSprite.acceleration.y = 300;
			playerSprite.maxVelocity.x = 80;
			//playerSprite.maxVelocity.y = 160;
			
			//animations
			playerSprite.addAnimation("idle", [0]);
			playerSprite.addAnimation("run", [1, 2, 3, 0], 12);
			playerSprite.addAnimation("jump", [4]);
		}
		override public function update():void
		{
			super.update();
			cursorMouse.x = FlxG.mouse.x;
			cursorMouse.y = FlxG.mouse.y;
			mapEditor.update();
			
			if ( FlxG.keys.justReleased( "B" ) )
			{
				setPlayerPos();
			}
			FlxG.collide( _player1Group, _player2Group, commonCollideFunction );	
		}
		private function castSkill( playerObj:BasePlayerObject, keyCode:int ):void
		{
			var obj:Object = _KeyMap[keyCode];
			if ( obj != null )
			{
				if ( playerObj == playerIns )
				{
					_txtPlayer1.text = _KeyMap[keyCode];
				}
				else if ( playerObj == targetSprite )
				{
					_txtPlayer2.text = _KeyMap[keyCode];
				}	
			}
		}
		protected function commonCollideFunction( flxObj1:FlxObject, flxObj2:FlxObject ):void
		{
			var str:String = _txtPlayer1.text + _txtPlayer2.text;
			var result:int = _resultMap[str];
			if ( result == 1 )
			{
				//1win
				_winCountsPlayer1++;
			}
			else if ( result == 2 )
			{
				//2v
				_winCountsPlayer2++;
			}
			else if ( result == 0 )
			{
				//draw
			}
			_txtMatchResult.text = "" + _winCountsPlayer1 + ":" + _winCountsPlayer2;
			setPlayerPos();
		}
		private function setPlayerPos():void
		{
			playerIns.x = 150;
			playerIns.y = 270;
			targetSprite.x = 600;
			targetSprite.y = 270;
		}
		private function inputControlSet():void
		{
			inputMgr = new InputControllerManager( FlxG.stage );
			uiControl.registeController( inputMgr );
			gamePlayControl.registeController( inputMgr );
			gamePlayControl.setPlayer(playerIns);
			gamePlayControlSecond.registeController(inputMgr);
			gamePlayControlSecond.setPlayer(targetSprite);
			
			gamePlayControl.SetKeyAction(FlxG.keys.getKeyCode("A"), FlxG.keys.getKeyCode("D"), FlxG.keys.getKeyCode("EIGHT"), FlxG.keys.getKeyCode("EIGHT"), FlxG.keys.getKeyCode("EIGHT"));
			gamePlayControlSecond.SetKeyAction(FlxG.keys.getKeyCode("LEFT"), FlxG.keys.getKeyCode("RIGHT"), FlxG.keys.getKeyCode("EIGHT"), FlxG.keys.getKeyCode("EIGHT"), FlxG.keys.getKeyCode("EIGHT"));
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