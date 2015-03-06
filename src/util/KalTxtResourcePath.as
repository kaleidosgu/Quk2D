package util 
{
	/**
	 * ...
	 * @author kaleidos
	 */
	import util.KalResourceType;
	public class KalTxtResourcePath extends KalResourcePath 
	{
		
		public function KalTxtResourcePath( resFileName:String ) 
		{
			super(resFileName);
			_pathType = KalResourceType.KAL_TYPE_TXT;
		}
		
		protected override function _subPathString():String
		{
			return "mapdata\\";
		}
		protected override function _fileAffix():String
		{
			return ".xml";
		}
	}

}