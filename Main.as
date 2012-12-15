package
{
	import net.flashpunk.Engine;
	public class Main extends Engine
	{
		public function Main()
		{
			super(640, 480, 60, false);
		}

		override public function init():void
		{
			trace("FlashPunk has started successfully!");
		}

	}
}