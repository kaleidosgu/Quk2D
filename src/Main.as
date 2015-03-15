package
{
	import fileprocess.FileByteArrayResourcePath;
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.CompressionAlgorithm;
	import gamemap.GameMapElementInfo;
	import gamemap.GameMapInfo;
	import org.flixel.*;
	import state.GameMapEditorState;
	import util.KalResourceDataRead;
	import util.KalResourceDataWrite;
	import util.KalTxtResourcePath;
	[SWF(width="800", height="600", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]

	public class Main extends FlxGame
	{
		public function Main()
		{
			registerClassAlias("gamemap.GameMapInfo", GameMapInfo);
			//registerClassAlias("gamemap.GameMapElementInfo", GameMapElementInfo);
			var kagResPath:FileByteArrayResourcePath = new FileByteArrayResourcePath("test");
			var filePathString:String = kagResPath.resourcePath;
			var readFile:KalResourceDataRead = new KalResourceDataRead( filePathString );
			var dd:ByteArray = new ByteArray();
			
			readFile.readFileIntoByteArray( filePathString, dd );
			dd.position = 0;
			dd.uncompress(CompressionAlgorithm.DEFLATE);
			dd.position = 0;
			var gamemapInfo:Array = dd.readObject();
			var gameIn:GameMapElementInfo = gamemapInfo[0];
			super(800, 600, GameMapEditorState, 1, 20, 20);
			/*
			var newMapInf:GameMapElementInfo = new GameMapElementInfo();
			newMapInf.posX = 100;
			newMapInf.posY = 200;
			
			var bytarr:ByteArray = newMapInf.getByteArray();
			
			var kagResPath:FileByteArrayResourcePath = new FileByteArrayResourcePath("test");
			var filePathString:String = kagResPath.resourcePath;
			
			var writeFile:KalResourceDataWrite = new KalResourceDataWrite();
			writeFile.writeBytesToFile( filePathString, bytarr );
			
			var readFile:KalResourceDataRead = new KalResourceDataRead( filePathString );
			var dd:ByteArray = new ByteArray();
			
			readFile.readFileIntoByteArray( filePathString, dd );
			dd.position = 0;
			dd.uncompress(CompressionAlgorithm.DEFLATE);
			dd.position = 0;
			var mapInfo:GameMapElementInfo = dd.readObject();
			var aa = 0;
			*/
		}
	}
}
