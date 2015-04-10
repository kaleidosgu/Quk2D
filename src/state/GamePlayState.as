package state 
{
	import flash.events.KeyboardEvent;
	import fsm.PlayerFSM;
	import gamemap.GameMapEditor;
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
		private var _showWidth:uint = 0;
		private var _showHeight:uint = 0;
		private var _showScale:uint = 2;
		private const TILE_WIDTH:uint = 8;
		private const TILE_HEIGHT:uint = 8;
		
		private var mapEditor:GameMapEditor = null;
		
		private var _wallGroup:FlxGroup = new FlxGroup();
		private var player:FlxSprite = null;
		private var _playerCollide:Boolean = false;
		private var inputMgr:InputControllerManager = null;
		private var uiControl:UIInputController = new UIInputController();
		private var gamePlayControl:GamePlayInputController = new GamePlayInputController();
		
		private var _playerFsm:PlayerFSM = null;
		public function GamePlayState() 
		{
			
		}
		
		override public function create():void
		{
			super.create();
			mapEditor = new GameMapEditor( _wallGroup );
			this.add( _wallGroup );
			mapEditor.generateMapDataFromByteArray();
			_showWidth 	= TILE_WIDTH * _showScale ;
			_showHeight	= TILE_HEIGHT * _showScale;
						
			mapEditor.showWidth = _showWidth;
			mapEditor.showHeight = _showHeight;
			setupPlayer();
			inputControlSet();
			
			_playerFsm = new PlayerFSM( FlxG.stage, player );
			_playerFsm.addListener();
		}
		private function setupPlayer():void
		{
			player = new FlxSprite(30, 0);
			player.loadGraphic(ImgSpaceman, true, true, 16);
			
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
		override public function destroy():void
		{
			super.destroy();
		}
		
		public override function draw():void
		{
			super.draw();
		}
		override public function update():void
		{
			super.update();
			FlxG.collide( player, _wallGroup, playerNocollideTile );
		}
		private function playerNocollideTile( flxObj1:FlxObject, flxObj2:FlxObject ):void
		{
			player.drag.x = 300;
			_playerCollide = false;
		}
		private function inputControlSet():void
		{
			inputMgr = new InputControllerManager( FlxG.stage );
			uiControl.registeController( inputMgr );
			gamePlayControl.registeController( inputMgr );
		}
	}

}