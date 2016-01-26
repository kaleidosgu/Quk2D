package gameplay.WeaponSystem.BulletAmmo 
{
	import util.EventDispatch.GameDispatchSystem;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BulletFactory 
	{
		private var _arrayBulletInFree:Array = new Array();
		private var _dspSystem:GameDispatchSystem = null;
		public function BulletFactory( inDspSystem:GameDispatchSystem ) 
		{
			_dspSystem = inDspSystem;
		}
		public function SupplyBullet():BaseBulletObject
		{
			var bulletObject:BaseBulletObject = null;
			if ( _arrayBulletInFree.length > 0 )
			{
				var firstArray:Array = _arrayBulletInFree.splice( 0, 1 );
				bulletObject = firstArray[0];
			}
			else
			{
				bulletObject = new BaseBulletObject( _dspSystem, this );
			}
			return bulletObject;
		}
		public function RecycleBullet( bullet:BaseBulletObject ):void
		{
			_arrayBulletInFree.push( bullet );
		}
	}

}