package
{
	import org.flixel.*;
	import state.GameMapEditorState;
	[SWF(width="800", height="600", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]

	public class Main extends FlxGame
	{
		public function Main()
		{
			super(800, 600, GameMapEditorState, 1, 20, 20);
		}
	}
}
