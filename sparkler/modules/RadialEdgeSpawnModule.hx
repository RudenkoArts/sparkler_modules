package sparkler.modules;


import sparkler.core.Particle;
import sparkler.core.ParticleData;
import sparkler.core.ParticleModule;
import sparkler.data.Vector;


class RadialEdgeSpawnModule  extends ParticleModule {


	public var radius:Float;
	public var radius_max:Float;

	var rnd_point:Vector;


	public function new(_options:RadialEdgeSpawnModuleModuleOptions) {

		super(_options);

		radius = _options.radius != null ? _options.radius : 64;
		radius_max = _options.radius_max != null ? _options.radius_max : 128;

		rnd_point = new Vector();

		_priority = -999;
		
	}

	override function onspawn(p:Particle) {

		var pd:ParticleData = emitter.show_particle(p);

		random_point_in_unit_circle();
		rnd_point.normalize();

		var r:Float = emitter.random_float(radius, radius_max);

		pd.x = emitter.system.pos.x + emitter.pos.x + rnd_point.x * r;
		pd.y = emitter.system.pos.y + emitter.pos.y + rnd_point.y * r;

	}

	override function onunspawn(p:Particle) {

		emitter.hide_particle(p);

	}

	inline function random_point_in_unit_circle() : Vector {

		var _r:Float = Math.sqrt( emitter.random() );
		var _t:Float = (-1 + (2 * emitter.random())) * 6.283185307179586; // two PI

		rnd_point.set_xy( (_r * Math.cos(_t)), (_r * Math.sin(_t)) );

		return rnd_point;

	}


// import/export

	override function from_json(d:Dynamic) {

		super.from_json(d);

		radius = d.radius;
		radius_max = d.radius_max;
		
		return this;
	    
	}

	override function to_json():Dynamic {

		var d = super.to_json();

		d.radius = radius;
		d.radius_max = radius_max;

		return d;
	    
	}


}


typedef RadialEdgeSpawnModuleModuleOptions = {

	>ParticleModuleOptions,

	@:optional var radius:Float;
	@:optional var radius_max:Float;

}


