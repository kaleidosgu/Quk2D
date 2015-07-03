package gamemap.GameItem 
{
	import gamemap.GameMapItemTyp;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class ItemHealth extends BaseItemObject 
	{
		[Embed(source = '../../../res/images/health100.png')]
		private static var healthItem:Class;		
		public function ItemHealth() 
		{
			
		}
		override public function resClass():Class
		{
			return healthItem;
		}
		override public function getSubTyp():uint
		{
			return GameMapItemTyp.GameMapItemTyp_Health;
		}
	}

}