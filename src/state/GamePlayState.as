package state 
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import fsm.PlayerFSM;
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
		
		private var playerIns:BasePlayerObject = null;
		//private var targetSprite:BasePlayerObject = null;
		private var cursorMouse:FlxSprite = null;
		private var _playerCollide:Boolean = false;
		private var inputMgr:InputControllerManager = null;
		private var uiControl:UIInputController = new UIInputController();
		private var gamePlayControl:GamePlayInputController = new GamePlayInputController();
		
		private var _playerFsm:PlayerFSM = null;
		private var _shootingGamePlay:GameShootingGamePlay = null;
		
		private var _playerGroup:FlxGroup 			= null;
		private var _bulletGroup:FlxGroup			= null;
		private var _explosionGroup:FlxGroup		= null;
		
		private var _dspSystem:GameDispatchSystem = null;
		private var _bulletCollideMonitor:BulletCollideMonitor = null;
		private var _explosionObjGenerator:ExplosionObjectGenerator = null;
		private var _soundSys:QukSoundSystem = null;
		private var _txtFlx:FlxText	= null;
		public function GamePlayState() 
		{
			_playerGroup 	= new FlxGroup();
			_bulletGroup	= new FlxGroup();
			_explosionGroup	= new FlxGroup();
			
			_dspSystem = new GameDispatchSystem( FlxG.stage );
			
			_dspSystem.RegisterEvent( PlayerInputActionEvent.PLAYER_INPUT_ACTION_EVENT, inputActionEvent );
			
			_explosionObjGenerator = new ExplosionObjectGenerator( _dspSystem, _explosionGroup );
			
			_soundSys = new QukSoundSystem( _dspSystem );
			
			var test:Number = Math.sin( (360 - 180) * Math.PI / 180 );
			
			test = Math.cos( 120 / 180 * Math.PI );
			
			test = Math.acos( 0 - 1 / 4 );
			
			var num:Number = new Number();
			setData( num, 0, 1, 0);
			
			var dd:Number = 0;
		}
		private function inputActionEvent( evtIn:PlayerInputActionEvent ):void
		{
			if ( evtIn.playerActionType == PlayerInputActionType.Player_ChangeDoor )
			{
				var evt:BattleGroundMapLayerChangedEvent = new BattleGroundMapLayerChangedEvent(BattleGroundMapLayerChangedEvent.BattleGroundMapLayerChanged );
				evt.mapLayer = playerIns.playerMapLayer;
				_dspSystem.DispatchEvent(evt);
			}
		}
		private function setData( startX:Number, startY:Number, endX:Number, endY:Number ):void
		{
			startX = 300;
			var width:Number = endX - startX;
			var height:Number = endY - startY;
			var squ:Number = width * width + height * height;
			
			var rLength:Number = Math.sqrt(squ);
			
			var radisSin:Number = height / rLength;
			var radisCos:Number = width / rLength;
			
			var radisTag:Number = radisCos / radisSin;
			var angTag:Number = Math.atan(radisTag) * 180 / Math.PI;
			var angSin:Number = Math.asin(radisSin) * 180 / Math.PI;
			var angCos:Number = Math.acos(radisCos) * 180 / Math.PI;
			
			var ddend:Number = 0;
			
			ddend = Math.sin( -75 * Math.PI / 180);
			ddend;
		}
		override public function create():void
		{
			super.create();
			playerIns = new BasePlayerObject();
			//targetSprite = new BasePlayerObject();
			
			this.add( _explosionGroup );
			this.add( _bulletGroup );
			_bulletCollideMonitor = new BulletCollideMonitor( _explosionGroup, _bulletGroup, _playerGroup, playerIns, this );
			
			
			cursorMouse = new FlxSprite( 0, 0 );
			cursorMouse.loadGraphic( ImgCursor, true, true, 15 );
			add( cursorMouse );
			
			setupPlayer( playerIns, 200, 100 );
			//setupPlayer( targetSprite,100,0 );
			mapEditor = new GameMapEditor( this, _playerGroup,_dspSystem );

			
			FlxG.camera.setBounds(0,0,1024,768,true);
			FlxG.camera.follow(playerIns,FlxCamera.STYLE_PLATFORMER);
			
			mapEditor.addActor( playerIns );
			//mapEditor.addActor( targetSprite );
			
			mapEditor.generateMapDataFromByteArray( "test" );
			_showWidth 	= TILE_WIDTH * _showScale ;
			_showHeight	= TILE_HEIGHT * _showScale;
						
			mapEditor.showWidth = _showWidth;
			mapEditor.showHeight = _showHeight;
			inputControlSet();
			
			_playerFsm = new PlayerFSM( FlxG.stage, playerIns );
			_playerFsm.addListener();
			 
			_shootingGamePlay = new GameShootingGamePlay( this, playerIns, FlxG.stage, _bulletGroup ,_dspSystem );
			
			_bulletCollideMonitor.setBuildingGroup( mapEditor.getBuildingGroup() );
			
			_txtFlx = new FlxText(500, 5, 200 );
			_txtFlx.text = "fsfsf";
			add( _txtFlx );
			
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
			gamePlayControl.setPlayer(playerIns);
			gamePlayControl.SetKeyAction(FlxG.keys.getKeyCode("A"), FlxG.keys.getKeyCode("D"), FlxG.keys.getKeyCode("EIGHT"), FlxG.keys.getKeyCode("EIGHT"), FlxG.keys.getKeyCode("EIGHT"));
		}
		override public function destroy():void
		{
			super.destroy();
		}
		
		public override function draw():void
		{
			super.draw();
			
			playerIns.drawDebug();
			
			_txtFlx.text = playerIns.elasticity.toString();
		}
	}

}