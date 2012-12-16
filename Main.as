package
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	public class Main extends Engine
	{
		public function Main()
		{
			super(640, 480, 60, false);
			FP.world = new GameWorld;
			//FP.console.enable();
			FP.screen.scale = 2;
		}

		override public function init():void
		{
			trace("FlashPunk has started successfully!");
			//add(new Villan);
		}

	}
}