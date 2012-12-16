package {
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import mx.core.ByteArrayAsset;
	import net.flashpunk.masks.Grid;
	/**
	 * @author jamescarpenter
	 */
	public class Level extends Entity {
		private var _tiles:Tilemap;
		private var _grid:Grid;

		[Embed(source = 'graphics/Background.png')] private const BACKGROUND:Class;

		private static const GRASS:uint = 0x0;
		private static const WALL:uint = 0x1;
		private static const WATER:uint = 0x2;
		private static const BRIDGE:uint = 0x3;
		private static const PATH:uint = 0x4;

		[Embed(source = "levels/level1.txt", mimeType = "application/octet-stream")]
		private var level1:Class;

		public function Level() {
	
			_tiles = new Tilemap(BACKGROUND, FP.screen.width/2,FP.screen.height/2,16,16);
			_grid = new Grid(FP.screen.width/2,FP.screen.height/2,16,16);

			graphic = _tiles;
			layer = 1;
			trace(FP.screen.width,FP.screen.height);

			var levelByteArray:ByteArrayAsset = ByteArrayAsset(new level1());
            var levelString:String = levelByteArray.readUTFBytes(levelByteArray.length);

			_tiles.loadFromString(levelString);

			_grid.loadFromString(makeGridFromLevel(levelString));
			
			mask = _grid;
			type = "level"
		}

		public function makeGridFromLevel(level:String): String
		{
			trace(level);
			var nobridge:String = level.replace(new RegExp("3", 'g'),"0");
			trace(nobridge);
			var nopath:String = nobridge.replace(new RegExp("4", 'g'),"0");
			trace(nopath);
			return nopath;
		}
	}
}
