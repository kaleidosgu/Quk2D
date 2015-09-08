package gameplay.WeaponSystem.BulletAmmo 
{
	import Base.BaseGameObject;
	import gamemap.GameObjectMainTyp;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BaseBulletObject extends BaseGameObject 
	{
		
		public function BaseBulletObject() 
		{
		}
		
		override public function getMainTyp():uint
		{
			return GameObjectMainTyp.GameObjectMainTyp_Bullet;
		}
		public function harmPlayer():void
		{
			
		}
		public function shiftPosPlayer():void
		{
			
		}
		public function destroySelf():void
		{
			
		}
	}

}