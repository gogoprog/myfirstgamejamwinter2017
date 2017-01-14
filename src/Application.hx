import gengine.*;
import gengine.math.*;
import gengine.components.*;
import gengine.graphics.*;

import ash.fsm.*;

import systems.*;
import components.*;
import js.jquery.*;
import js.UIPages;
import js.PagesSet;

class Application
{
    private static var engine:Engine;
    private static var esm:EngineStateMachine;
    public static var pages:PagesSet;

    public static function init()
    {
        Gengine.setWindowSize(new IntVector2(640, 480));
        Gengine.setWindowTitle("myfirstgamejamwinter2017");
        Gengine.setGuiFilename("gui/gui.html");
    }

    public static function start(_engine:Engine)
    {
        engine = _engine;

        Gengine.getRenderer().getDefaultZone().setFogColor(new Color(0.1,0.1,0.1,1));

        var cameraEntity = Factory.createCamera();
        engine.addEntity(cameraEntity);

        engine.addSystem(new AnimatedSystem(), 1);
        engine.addSystem(new StreetSystem(), 10);
        engine.addSystem(new CharacterSystem(), 10);
        engine.addSystem(new PlayerInputSystem(cameraEntity), 2);
        engine.addSystem(new MoveSystem(), 10);
        engine.addSystem(new HitSystem(), 11);
        engine.addSystem(new HurtSystem(), 11);
        engine.addSystem(new DeathSystem(), 11);
        engine.addSystem(new IdleSystem(), 11);

        Factory.init();

        var viewport:Viewport = new Viewport(Gengine.getContext());
        viewport.setScene(Gengine.getScene());
        viewport.setCamera(cameraEntity.get(Camera));
        Gengine.getRenderer().setViewport(0, viewport);

        for(i in 0...10)
        {
            var e = Factory.createCharacter();

            e.position = new Vector3(Std.random(10) * 64 - 320, 0, 0);

            e.get(Character).y = Std.random(10) * 10;
            e.get(StaticSprite2D).setColor(new Color(Math.random(), Math.random(), Math.random(), 1));

            engine.addEntity(e);

            e.get(Character).moveTarget = new Vector2(Std.random(10) * 64 - 320, Std.random(10) * 10);
        }

        var e = Factory.createPlayer();
        engine.addEntity(e);

        var e = Factory.createMap();
        engine.addEntity(e);
        e.scale = new Vector3(1, 1, 1);
        e.position = new Vector3(-400, -400, 0);
        e.get(TileMap2D).setTmxFile(Gengine.getResourceCache().getTmxFile2D("map.tmx", true));
    }

    public static function onGuiLoaded()
    {
        pages = UIPages.createSet(new JQuery("#body"));

        pages.showPage(".menu");

        //engine.getSystem(MenuSystem).init();
    }

    public static function changeState(stateName)
    {
        engine.updateComplete.addOnce(function() {
                esm.changeState(stateName);
            });
    }
}
