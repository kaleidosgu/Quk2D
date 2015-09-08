package player 
{
	import Base.BaseGameObject;
	import gamemap.GameObjectMainTyp;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BasePlayerObject extends BaseGameObject 
	{
		
		public function BasePlayerObject() 
		{
			
		}
		override public function getMainTyp():uint
		{
			return GameObjectMainTyp.GameObjectMainTyp_Player;
		}
		
	}

}