package util 
{
	/**
	 * ...
	 * @author kaleidos
	 */
	public class UtilXmlConvertVariables 
	{
		
		public function UtilXmlConvertVariables() 
		{
			
		}
		
		public static function convertToUint( xmlInfo:XML, attributeName:String ):uint
		{
			var uintValue:uint = uint(UtilXmlConvertVariables.convertToString( xmlInfo, attributeName ) );
			return uintValue;
		}
		public static function convertToNumber( xmlInfo:XML, attributeName:String ):Number
		{
			var retValue:Number = Number(UtilXmlConvertVariables.convertToString( xmlInfo, attributeName ) );
			return retValue;
		}
		
		public static function convertToString( xmlInfo:XML, attributeName:String ):String
		{
			var attributeValue:XMLList = xmlInfo.attribute(attributeName);
			var strValue:String = attributeValue.toString();
			return strValue;
		}

		public static function convertToBool( xmlInfo:XML, attributeName:String ):Boolean
		{
			var retValue:Boolean = UtilXmlConvertVariables.convertToUint( xmlInfo, attributeName ) > 0 ;
			return retValue;
		}
	}

}