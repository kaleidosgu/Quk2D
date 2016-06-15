package gamemap.GameItem 
{
	import Base.BaseGameObject;
	import gamemap.GameMapBuildingXmlTag;
	import gamemap.GameObjectMainTyp;
	import util.UtilXmlConvertVariables;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BaseItemObject extends BaseGameObject 
	{
		
		public function BaseItemObject() 
		{
			
		}
		override public function getMainTyp():uint
		{
			return GameObjectMainTyp.GameObjectMainTyp_Item;
		}
		
	}

}