package util 
{
	/**
	 * ...
	 * @author kaleidos
	 */
	import flash.filesystem.File;
	public class KalResourcePath 
	{
		protected var _pathType:String;
		private var _resourcePath:String = "";
		public function KalResourcePath( resFileName:String ) 
		{
			_resourcePath = _generatePath( resFileName );
		}
		
		protected function _generateAppResPath():String
		{
			var appFile:File = File.applicationDirectory;
			var appFileNativePath:String = appFile.nativePath;
			var resPath:String = appFileNativePath.replace("bin", "res");
			resPath = resPath + "\\";
			return resPath;
		}
		private function _generatePath( fileName:String ):String
		{
			return _generateAppResPath() + _subPathString() + fileName + _fileAffix();
		}
		protected function _subPathString():String
		{
			return "";
		}
		protected function _fileAffix():String
		{
			return "";
		}
		
		public function get resourcePath():String 
		{
			return _resourcePath;
		}
	}

}