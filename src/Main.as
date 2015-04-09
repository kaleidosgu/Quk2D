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
	import state.GamePlayState;
	import util.KalResourceDataRead;
	import util.KalResourceDataWrite;
	import util.KalTxtResourcePath;
	[SWF(width="800", height="600", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]

	public class Main extends FlxGame
	{
		public function Main()
		{
			//super(800, 600, GameMapEditorState, 1, 20, 20);
			super(800, 600, GamePlayState, 1, 60, 60);
		}
	}
}
