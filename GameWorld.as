package {
	import net.flashpunk.World;
	import flash.geom.Point;
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
			add(new Villan(new Point(8,14)));
			add(new Level());
			add(new Granny(new Point(5,6), new Point(0,1)));
			add(new Granny(new Point(5,2), new Point(1,0)));
		}
	}
}
