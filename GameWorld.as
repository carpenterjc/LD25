package {
	import net.flashpunk.World;
	/**
	 * @author jamescarpenter
	 */
	public class GameWorld extends World
	{
		public function GameWorld()
		{
			
		}
		
		override public function begin():void
		{
			add(new Villan());
			add(new Level());
		}
	}
}
