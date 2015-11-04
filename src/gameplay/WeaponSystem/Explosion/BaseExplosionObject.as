package gameplay.WeaponSystem.Explosion 
{
	import Base.BaseGameObject;
	import gamemap.GameObjectMainTyp;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BaseExplosionObject extends BaseGameObject 
	{
		
		public function BaseExplosionObject() 
		{
		}
		
		override public function getMainTyp():uint
		{
			return GameObjectMainTyp.GameObjectMainTyp_Explosion;
		}
	}

}