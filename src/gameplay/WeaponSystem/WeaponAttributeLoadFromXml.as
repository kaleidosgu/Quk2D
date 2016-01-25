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
		[Embed(source = "../../../res/weapondata/weaponInit.xml",mimeType = "application/octet-stream")]
		protected var weaponInitXml:Class;
		private var xmlT:FlxXML = new FlxXML();
		private var xmlInitWeapon:FlxXML = new FlxXML();
		
		private var _dictWeaponAttr:Object = new Object();
		private var _dictWeaponInit:Object = new Object();
		public function WeaponAttributeLoadFromXml() 
		{
			loadDataFromXml( _dictWeaponAttr );
			_InitWeaponFromXml( _dictWeaponInit );
		}
		public function getWeaponAttr( weaponTyp:uint ):WeaponAttribute
		{
			return _dictWeaponAttr[weaponTyp];
		}
		private function _InitWeaponFromXml( objInitWeapon:Object ):void
		{
			var xmlData:XML = xmlInitWeapon.loadEmbedded(weaponInitXml);
			var initWeaponXmlLst:XMLList = xmlData.child("weaponDetail");
			for each ( var weaponDetail:XML in initWeaponXmlLst )
			{
				var weaponType:uint = UtilXmlConvertVariables.convertToUint( weaponDetail, "weaponType" );
				var bulletCounts:uint = UtilXmlConvertVariables.convertToUint( weaponDetail, "weaponInitValue" );
				objInitWeapon[weaponType] = bulletCounts;
			}
		}
		public function GetWeaponInitCounts( weaponType:uint ):uint
		{
			return _dictWeaponInit[weaponType];
		}
		private function loadDataFromXml( objWeaponAttri:Object ):void
		{
			var xmlData:XML = xmlT.loadEmbedded( embWeaponXml );
			var weaponStaticXmlLst:XMLList = xmlData.child("weaponDetail");
			
			for each ( var weaponDetail:XML in weaponStaticXmlLst )
			{
				var weaponAttr:WeaponAttribute = new WeaponAttribute();
				weaponAttr.weaponType 		= UtilXmlConvertVariables.convertToUint( weaponDetail, "weaponType" );
				weaponAttr.fireSpeed 		= UtilXmlConvertVariables.convertToNumber( weaponDetail, "fireSpeed" );
				weaponAttr.damageValue 		= UtilXmlConvertVariables.convertToUint( weaponDetail, "damageValue" );
				weaponAttr.countsPerFire 	= UtilXmlConvertVariables.convertToUint( weaponDetail, "countsPerFire" );
				weaponAttr.damageShift 		= UtilXmlConvertVariables.convertToNumber( weaponDetail, "damageShift" );
				weaponAttr.reboundCounts 	= UtilXmlConvertVariables.convertToUint( weaponDetail, "reboundCounts" );
				weaponAttr.damageFields 	= UtilXmlConvertVariables.convertToNumber( weaponDetail, "damageField" );
				weaponAttr.fireRange 		= UtilXmlConvertVariables.convertToNumber( weaponDetail, "fireRange" );
				weaponAttr.linearShape 		= UtilXmlConvertVariables.convertToBool( weaponDetail, "linearShape" );
				weaponAttr.changeCD 		= UtilXmlConvertVariables.convertToNumber( weaponDetail, "changeCD" );
				weaponAttr.fireCD 			= UtilXmlConvertVariables.convertToNumber( weaponDetail, "fireCD" );
				weaponAttr.destroySelfCounts= UtilXmlConvertVariables.convertToUint( weaponDetail, "destroySelfTime" );
				var newWeapon:WeaponAttribute = objWeaponAttri[weaponAttr.weaponType];
				if ( newWeapon == null )
				{
					objWeaponAttri[weaponAttr.weaponType] = weaponAttr;
				}
				else
				{
					trace( new Error().getStackTrace());
				}
			}
		}
		
	}

}