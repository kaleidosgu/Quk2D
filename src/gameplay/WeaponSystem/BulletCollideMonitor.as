package gameplay.WeaponSystem 
{
	import Base.BaseGameObject;
	import gamemap.GameObjectMainTyp;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BulletCollideMonitor 
	{
		
		private var _bulletGroup:FlxGroup 	= null;
		private var _playerGroup:FlxGroup	= null;
		public function BulletCollideMonitor( inBulletGroup:FlxGroup, inPlayerGroup:FlxGroup ) 
		{
			_bulletGroup 	= inBulletGroup;
			_playerGroup	= inPlayerGroup;
		}
		
		public function update():void
		{
			FlxG.collide( _playerGroup, _bulletGroup, playerCollideBullet );	
		}
		protected function playerCollideBullet( playerObj:FlxSprite, bulletObj:FlxSprite ):void
		{
			if ( playerObj is BaseGameObject )
			{
				var dd:int = 0;
			}
			/*
			if ( playerObj.getMainTyp() == GameObjectMainTyp.GameObjectMainTyp_Player
			&& bulletObj.getMainTyp() == GameObjectMainTyp.GameObjectMainTyp_Bullet )
			{
				playerObj.collideByOtherObj( bulletObj );
				bulletObj.collideByOtherObj( playerObj );
			}
			*/
		}
		
	}

}