package
{
	import org.flixel.*;
	import state.GameMapEditorState;
	[SWF(width="1024", height="768", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]

	public class Main extends FlxGame
	{
		public function Main()
		{
			super(1024, 768, GameMapEditorState, 1, 20, 20);
		}
	}
}
