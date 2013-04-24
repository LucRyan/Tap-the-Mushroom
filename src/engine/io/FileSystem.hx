package engine.io;
import nme.display.Loader;
import nme.filesystem.File;
/**
 * ...
 * @author Yang Wang
 */
class FileSystem
{
	var highScores : Hash <Int>;

	public function new() 
	{
		highScores = new Hash<Int>();
		highScores = 
	}
	
	public function write() {
	    var fname = "highscore.txt";

		// open file for writing
		var fout = neko.io.File.write(fname, false);

		// write something
		for ( i in 0 ... 3) {
			fout.writeString(highScores.get("Level" + Std.string(++i));
		}
		fout.close();
	}
	
	public function read() {
		// open and read file line by line
		var fin = neko.io.File.read(fname, false);
		try
		{
		  var lineNum = 0;
		  while( true )
		  {
			var str = fin.readLine();
			highScores.set("Level" + Std.string(++lineNum), Std.parseInt(str));
		  }
		}
		catch( ex:haxe.io.Eof ) 
		{}
		fin.close();
	}	
}