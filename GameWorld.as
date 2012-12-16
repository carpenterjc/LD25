package {
	import net.flashpunk.World;
	import flash.geom.Point;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Entity;
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
			var statusentity:Entity = new Entity();
			var statusstring:Text = new Text("100% - 0");
			statusentity.graphic = statusstring;
			var villan:Villan = new Villan(new Point(8,13), statusstring);
			add(villan);
			add(new Level());
			add(new Granny(new Point(5,6), new Point(0,1), villan));
			add(new Granny(new Point(15,9), new Point(0,1), villan));
			add(new Granny(new Point(5,2), new Point(1,0), villan));
			add(new Granny(new Point(4,7), new Point(0,1), villan));
			add(new Granny(new Point(1,2), new Point(0,1), villan));
			add(new Granny(new Point(3,17), new Point(1,0), villan));
			
			add(statusentity);
		}
	}
}
