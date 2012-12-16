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
			var villan:Villan = new Villan(new Point(8,13));
			add(villan);
			add(new Level());
			add(new Granny(new Point(5,6), new Point(0,1), villan));
			add(new Granny(new Point(15,9), new Point(0,1), villan));
			add(new Granny(new Point(5,2), new Point(1,0), villan));
		}
	}
}
