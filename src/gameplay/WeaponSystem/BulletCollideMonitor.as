package gameplay.WeaponSystem 
{
	import Base.BaseGameObject;
	import gamemap.GameObjectMainTyp;
	import gameplay.GameExplosionGenerator;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import player.BasePlayerObject;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BulletCollideMonitor 
	{
		
		private var _bulletGroup:FlxGroup 	= null;
		private var _playerGroup:FlxGroup	= null;
		private var _arrayBuildingGroup:Array = null;
		private var _mainPlayer:BasePlayerObject = null;
		private var _gameState:FlxState = null;
		public function BulletCollideMonitor( inBulletGroup:FlxGroup, inPlayerGroup:FlxGroup, inMainPlayer:BasePlayerObject, gameState:FlxState ) 
		{
			_bulletGroup 	= inBulletGroup;
			_playerGroup	= inPlayerGroup;
			_mainPlayer		= inMainPlayer;
			_gameState		= gameState;
		}
		
		public function update():void
		{
			FlxG.overlap( _playerGroup, _bulletGroup, playerCollideBullet );
			if ( _arrayBuildingGroup != null )
			{
				for each( var buildingGroup:FlxGroup in _arrayBuildingGroup )
				{
					FlxG.overlap( _bulletGroup, buildingGroup, BulletCollideBuilding );
				}
			}
		}
		protected function playerCollideBullet( playerObj:BaseGameObject, bulletObj:BaseGameObject ):void
		{
			if ( _mainPlayer != playerObj )
			{
				if ( playerObj.getMainTyp() == GameObjectMainTyp.GameObjectMainTyp_Player
				&& bulletObj.getMainTyp() == GameObjectMainTyp.GameObjectMainTyp_Bullet )
				{
					playerObj.collideByOtherObj( bulletObj );
					bulletObj.collideByOtherObj( playerObj );
					//GameExplosionGenerator.getIns().generateExplosion( playerObj.x, playerObj.y, _gameState );
				}
			}
		}
		protected function BulletCollideBuilding( bulletObj:BaseGameObject, buildingObj:BaseGameObject ):void
		{
			//替换成building
			//playerObj.collideByOtherObj( bulletObj );
			bulletObj.collideByOtherObj( buildingObj );
			GameExplosionGenerator.getIns().generateExplosion( bulletObj.x, bulletObj.y, _gameState );
		}
		public function setBuildingGroup( arrayGroup:Array ):void
		{
			_arrayBuildingGroup = arrayGroup;
		}
	}

}