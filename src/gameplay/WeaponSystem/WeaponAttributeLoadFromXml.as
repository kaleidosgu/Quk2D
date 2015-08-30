package gameplay.WeaponSystem 
{
	import org.flixel.FlxXML;
	import util.UtilXmlConvertVariables;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class WeaponAttributeLoadFromXml 
	{
		[Embed(source = "../../../res/weapondata/weapon.xml",mimeType = "application/octet-stream")]
		protected var embWeaponXml:Class;
		private var xmlT:FlxXML = new FlxXML();
		//[Embed(source="../../../res/mapdata/mapinfo_static.xml",mimeType="application/octet-stream")]		protected var embXML:Class;
		
		public function WeaponAttributeLoadFromXml() 
		{
			
		}
		public function loadDataFromXml():void
		{
			var xmlData:XML = xmlT.loadEmbedded( embWeaponXml );
			var weaponStaticXmlLst:XMLList = xmlData.child("weaponDetail");
			
			for each ( var weaponDetail:XML in weaponStaticXmlLst )
			{
				var numData:Number = UtilXmlConvertVariables.convertToNumber( weaponDetail, "cdtime" );
				numData = 0;
			}
		}
		
	}

}