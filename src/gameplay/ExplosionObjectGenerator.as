package gameplay 
{
	import gameEvent.BattleEvent.BulletGenerateExplosionEvent;
	import gameplay.WeaponSystem.Explosion.BaseExplosionObject;
	import org.flixel.FlxGroup;
	import util.EventDispatch.GameDispatchSystem;
	/**
	 * ...
	 * @author ddda
	 */
	public class ExplosionObjectGenerator 
	{
		
		[Embed(source = "../../res/images/teleport.png")] private static var ImgExp:Class;
		
		private var _dspSystem:GameDispatchSystem =  null;
		private var _expGroup:FlxGroup = null;
		public function ExplosionObjectGenerator( _inDspSystem:GameDispatchSystem, explosionGroup:FlxGroup ) 
		{
			_dspSystem 	= _inDspSystem;
			_expGroup	= explosionGroup;
			registerEvent();
		}
		private function registerEvent():void
		{
			_dspSystem.RegisterEvent( BulletGenerateExplosionEvent.BULLET_GENERATE_EXPLOSION_EVENT, onGenerateExplosion );
		}
		
		private function onGenerateExplosion( evt:BulletGenerateExplosionEvent ):void
		{
			generateExplosion( evt );
		}
		
		private function generateExplosion( evt:BulletGenerateExplosionEvent ):void
		{
			var expObj:BaseExplosionObject = new BaseExplosionObject();
			expObj.x = evt.posX - expObj.width / 2 ;
			expObj.y = evt.posY - expObj.height / 2 ;
			expObj.setPrePoint( evt.preX, evt.preY );
			expObj.loadGraphic( ImgExp, true, true, 16 );
			expObj.setSelfGroup( _expGroup );
		}
		
	}

}