package engine.projectile;

/**
 * ...
 * @author Yang Wang
 */
class ProjectileEmManager
{

	var pjemt : ProjectileEmitter;
	var pjDataList : Hash<ProjectileData>;
	
	public function new() 
	{
		
	}
	
	public function addProjectile(pjData : ProjectileData) {
		pjDataList.set(pjData.pjName, pjData);
	}
	
	
}