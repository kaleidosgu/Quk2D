package state 
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxPoint;
	import org.flixel.FlxObject;
	import org.flixel.FlxG;
	import org.flixel.FlxXML;
	
	import util.KalTxtResourcePath;
	import util.KalResourceDataWrite;
	
	import gamemap.GameMapEditor;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class GameMapEditorState extends FlxState 
	{
		[Embed(source="../../res/actionBoard.xml",mimeType="application/octet-stream")]
		protected var embXML:Class;
		[Embed(source = "../../res/back.png")] private static var pointsChessPic:Class;
		private var highlightBox:FlxObject;
		private var _showWidth:uint = 0;
		private var _showHeight:uint = 0;
		private var _showScale:uint = 2;
		private const TILE_WIDTH:uint = 8;
		private const TILE_HEIGHT:uint = 8;
		
		private var mapEditor:GameMapEditor = new GameMapEditor();
		private var xmlT:FlxXML = new FlxXML();
		public function GameMapEditorState() 
		{
			
		}
		
		override public function create():void
		{
			super.create();


			mapEditor.generateMapDataFromXml();
			var xmlData:XML = xmlT.loadEmbedded(embXML);
			_showWidth 	= TILE_WIDTH * _showScale ;
			_showHeight	= TILE_HEIGHT * _showScale;
			var dd:uint = xmlData.length();
			var xmlLst:XMLList = xmlData.child("xml");
			dd = xmlLst.length();
			
			var myXML:XML =  
    <order> 
        <item id='1' quantity='2'> 
            <menuName>burger</menuName> 
            <price>3.95</price> 
        </item> 
        <item id='2' quantity='2'> 
            <menuName>fries</menuName> 
            <price>1.45</price> 
        </item> 
    </order>;
			
	
			var kagResPath:KalTxtResourcePath = new KalTxtResourcePath("default_write");
			var filePathString:String = kagResPath.resourcePath;
			
			var writeFile:KalResourceDataWrite = new KalResourceDataWrite();
			writeFile.writeDataToFile( filePathString, myXML.toString() );
			
			for each(var movie:XML in xmlData.prop ){
				var str:String = movie.@serverip.toString();
				str;
		　　 }
		
		var testString:String = myXML.toString();
			mapEditor.showWidth = _showWidth;
			mapEditor.showHeight = _showHeight;
			highlightBox = new FlxObject(0, 0, _showWidth, _showHeight);
		}
		override public function destroy():void
		{
			super.destroy();
		}
		
		public override function draw():void
		{
			super.draw();
			highlightBox.drawDebug();
		}
		private function getHightLightBoxPoint():FlxPoint
		{
			var flxPoint:FlxPoint = new FlxPoint();
			flxPoint.x = Math.floor(FlxG.mouse.x / _showWidth) * _showWidth;
			flxPoint.y = Math.floor(FlxG.mouse.y / _showHeight) * _showHeight;
			return flxPoint;
		}
		override public function update():void
		{
			var hightLightPoint:FlxPoint = getHightLightBoxPoint();
			highlightBox.x = hightLightPoint.x;
			highlightBox.y = hightLightPoint.y;
			
			if (FlxG.mouse.pressed())
			{
				mapEditor.updateMap( hightLightPoint.x, hightLightPoint.y,1 );
			}
			super.update();
		}
		private function updateMap( xPos:int, yPos:int ):void
		{
			
		}
	}

}