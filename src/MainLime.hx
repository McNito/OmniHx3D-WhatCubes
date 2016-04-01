package;

import lime.app.Application;
import lime.Assets;
import lime.ui.KeyCode;
import lime.ui.KeyModifier;
import lime.graphics.RenderContext;
import lime.ui.Touch;
import lime.ui.Window;
import scenes.MainScene;

import com.omnihx3d.Engine;
import com.omnihx3d.Scene;


class MainLime extends Application {
	
	var scene:Scene;
	var engine:Engine;
	
	
	public function new() {
		super();
	}
		
	override public function onPreloadComplete():Void {
		engine = new Engine(window, false);	
		scene = new Scene(engine);
				
        new MainScene(scene);
		engine.width = this.window.width;
		engine.height = this.window.height;
	}
	
	override function onMouseDown(window:Window, x:Float, y:Float, button:Int) {
		for(f in Engine.mouseDown) {
			f(x, y, button);
		}
	}
	
	override function onMouseUp(window:Window, x:Float, y:Float, button:Int) {
		for(f in Engine.mouseUp) {
			f();
		}
	}
	
	override function onMouseMove(window:Window, x:Float, y:Float) {
		for(f in Engine.mouseMove) {
			f(x, y);
		}
	}
	
	override function onMouseWheel(window:Window, deltaX:Float, deltaY:Float) {
		for (f in Engine.mouseWheel) {
			f(deltaY / 2);
		}
	}
	
	override function onTouchStart(touch:Touch) {
		for (f in Engine.touchDown) {
			f(touch.x, touch.y, touch.id);
		}
	}
	
	override function onTouchEnd(touch:Touch) {
		for (f in Engine.touchUp) {
			f(touch.x, touch.y, touch.id);
		}
	}
	
	override function onTouchMove(touch:Touch) {
		for (f in Engine.touchMove) {
			f(touch.x, touch.y, touch.id);
		}
	}

	override function onKeyUp(window:Window, keycode:Int, modifier:KeyModifier) {
		for(f in Engine.keyUp) {
			f(keycode);
		}
	}
	
	override function onKeyDown(window:Window, keycode:Int, modifier:KeyModifier) {
		for(f in Engine.keyDown) {
			f(keycode);
		}
	}
	
	override public function onWindowResize(window:Window, width:Int, height:Int) {
		engine.width = this.window.width;
		engine.height = this.window.height;
	}
	
	override function update(deltaTime:Int) {
		if(engine != null) {
			engine._renderLoop();		
		}
	}
	
}
