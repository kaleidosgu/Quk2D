package fileprocess 
{
	import util.KalResourceType;
	import util.KalTxtResourcePath;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class FileByteArrayResourcePath extends KalTxtResourcePath 
	{
		
		public function FileByteArrayResourcePath( path:String ) 
		{
			super(path);
			_pathType = KalResourceType.KAL_TYPE_MAP;
		}
		
		protected override function _subPathString():String
		{
			return "mapdata\\";
		}
		protected override function _fileAffix():String
		{
			return ".map";
		}
	}

}