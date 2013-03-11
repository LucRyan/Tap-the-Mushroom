package engine.utils;

/**
 * ...
 * @author Yang Wang
 */

class SafeRemover 
{	
	public function new() 
	{
		
	}
	
	public static function safeDestroy (obj:Dynamic, ?destroy:Bool=true) :Bool {
        
        if (obj == null) return false;
        
        var objs :Array<Dynamic> = Std.is (obj, Array) ? obj : [obj];
        
        for (o in objs) {
            if (o == null) continue;
            if (destroy)    try { o.destroy(); }
                            catch (e:Dynamic) { trace("[Error on object: "+o+", {"+e+"}"); }
            
            var parent = null; try { parent = o.parent; } catch (e:Dynamic) { trace(e); }
            if (parent != null) parent.removeChild ( o );
        }
        return true;
    }
    
    public static function safeRemove (obj:Dynamic) :Bool {
        return safeDestroy (obj, false);
    }
	
}