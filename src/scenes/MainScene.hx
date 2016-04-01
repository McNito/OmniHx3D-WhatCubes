package scenes;

import com.omnihx3d.Engine;
import com.omnihx3d.Scene;
import com.omnihx3d.cameras.FreeCamera;
import com.omnihx3d.lensflare.LensFlare;
import com.omnihx3d.lensflare.LensFlareSystem;
import com.omnihx3d.lights.PointLight;
import com.omnihx3d.materials.StandardMaterial;
import com.omnihx3d.materials.textures.CubeTexture;
import com.omnihx3d.materials.textures.Texture;
import com.omnihx3d.math.Color3;
import com.omnihx3d.math.Vector3;
import com.omnihx3d.mesh.Mesh;
import com.omnihx3d.tools.EventState;


class MainScene {

	public function new(scene:Scene) {
		var light0 = new PointLight("Omni0", new Vector3(174.72, 400, -226.08), scene);
        
        //var camera = new ArcRotateCamera("Camera", 0.4, 1.2, 20, new Vector3(-10, 0, 0), scene);
		var camera = new FreeCamera("Camera", new Vector3(10, 10, 10), scene);
        camera.attachControl(this, true);
        
		
		camera.keysUp.push(87);
		camera.keysDown.push(82);
		camera.keysLeft.push(65);
		camera.keysRight.push(68);
		camera.checkCollisions = true;
		
		var engine = scene.getEngine();
		engine.setPointerLock();
		var mouseMoveRelativeHandler = function(offsetX:Float, offsetY:Float) {
			var currentCamera = camera;
			currentCamera.cameraRotation.y += offsetX / currentCamera.angularSensibility;
			currentCamera.cameraRotation.x += offsetY / currentCamera.angularSensibility;
		};
		Engine.mouseMoveRelative.push(mouseMoveRelativeHandler);
		
        var material1 = new StandardMaterial("mat1", scene);
        material1.diffuseColor = new Color3(1, 1, 0);
		material1.reflectionTexture = new CubeTexture("assets/img/skybox/skybox", scene);
        
        for (i in 0...40) {
            var box = Mesh.CreateBox("Box", 1.0, scene);
            box.material = material1;
            box.position = new Vector3( -i * 5, 0, 0);
			box.checkCollisions = true;
        }
        
		
		
        // Fog
        //scene.fogMode = Scene.FOGMODE_EXP;
        //Scene.FOGMODE_NONE;
        //Scene.FOGMODE_EXP;
        //Scene.FOGMODE_EXP2;
        //Scene.FOGMODE_LINEAR;
        
        //scene.fogColor = new Color3(0.9, 0.9, 0.85);
        //scene.fogDensity = 0.01;
        
        //Only if LINEAR
        //scene.fogStart = 20.0;
        //scene.fogEnd = 60.0;
		
		// Creating light sphere
        var lightSphere0 = Mesh.CreateSphere("Sphere0", 16, 0.5, scene);
        
        lightSphere0.material = new StandardMaterial("white", scene);
        cast(lightSphere0.material, StandardMaterial).diffuseColor = new Color3(0, 0, 0);
        cast(lightSphere0.material, StandardMaterial).specularColor = new Color3(0, 0, 0);
        cast(lightSphere0.material, StandardMaterial).emissiveColor = new Color3(1, 1, 1);
        
        lightSphere0.position = light0.position;
        
        var lensFlareSystem = new LensFlareSystem("lensFlareSystem", light0, scene);
        var flare00 = new LensFlare(0.2, 0, new Color3(1, 1, 1), "assets/img/lens5.png", lensFlareSystem);
        var flare01 = new LensFlare(0.5, 0.2, new Color3(0.5, 0.5, 1), "assets/img/lens4.png", lensFlareSystem);
        var flare02 = new LensFlare(0.2, 1.0, new Color3(1, 1, 1), "assets/img/lens4.png", lensFlareSystem);
        var flare03 = new LensFlare(0.4, 0.4, new Color3(1, 0.5, 1), "assets/img/flare.png", lensFlareSystem);
        var flare04 = new LensFlare(0.1, 0.6, new Color3(1, 1, 1), "assets/img/lens5.png", lensFlareSystem);
        var flare05 = new LensFlare(0.3, 0.8, new Color3(1, 1, 1), "assets/img/lens4.png", lensFlareSystem);
        
		
        // Skybox
        var skybox = Mesh.CreateBox("skyBox", 800.0, scene);
        var skyboxMaterial = new StandardMaterial("skyBox", scene);
        skyboxMaterial.backFaceCulling = false;
        skyboxMaterial.reflectionTexture = new CubeTexture("assets/img/skybox/skybox", scene);
        skyboxMaterial.reflectionTexture.coordinatesMode = Texture.SKYBOX_MODE;
        skyboxMaterial.diffuseColor = new Color3(0, 0, 0);
        skyboxMaterial.specularColor = new Color3(0, 0, 0);
        skybox.material = skyboxMaterial;
        
        //var alpha = 0.0;
        scene.registerBeforeRender(function(currentScene:Scene, eventState:EventState) {
            //scene.fogDensity = Math.cos(alpha) / 10;
            //alpha += 0.02;
        });
        
        scene.getEngine().runRenderLoop(function () {
            scene.render();
        });
	}
	
}
