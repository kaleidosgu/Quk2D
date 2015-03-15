package util 
{
	/**
	 * ...
	 * @author kaleidos
	 */
	import flash.filesystem.File;
	import flash.filesystem.FileStream;
	import flash.filesystem.FileMode;
	import flash.utils.ByteArray;
	public class KalResourceDataRead 
	{
		
		private var _txtData:String = "";
		public function KalResourceDataRead( dataPath:String ) 
		{	
			var fileOpen:File = new File( dataPath );
			if ( fileOpen.exists )
			{
				var fileStream:FileStream = new FileStream();
				fileStream.open( fileOpen, FileMode.READ );
				_txtData = fileStream.readUTFBytes(fileStream.bytesAvailable);
				fileStream.close();
			}
		}
		public function getData():Object
		{
			return _txtData;
		}
		
		public function readFileIntoByteArray( dataPath:String, data:ByteArray ):void
		{
			var fileOpen:File = new File( dataPath );
			if ( fileOpen.exists )
			{
				var fileStream:FileStream = new FileStream();
				fileStream.open( fileOpen, FileMode.READ );
				fileStream.readBytes( data );
				fileStream.close();
			}
		}
		
	}

}