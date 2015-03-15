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
	public class KalResourceDataWrite 
	{
		
		public function KalResourceDataWrite() 
		{
			
		}
		
		public function writeDataToFile( filePath:String, data:String ):void
		{
			var fileOpen:File = new File( filePath );
			var fileStream:FileStream = new FileStream();
			fileStream.open( fileOpen, FileMode.WRITE );
			fileStream.writeUTFBytes(data);
			fileStream.close();
		}
		
		public function writeBytesToFile( filePath:String, data:ByteArray ):void
		{
			var fileOpen:File = new File( filePath );
			var fileStream:FileStream = new FileStream();
			fileStream.open( fileOpen, FileMode.WRITE );
			fileStream.writeBytes(data, 0, data.length );
			fileStream.close();
		}
		
	}

}