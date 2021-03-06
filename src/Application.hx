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
        Gengine.setWindowSize(new IntVector2(800, 600));
        Gengine.setWindowTitle("myfirstgamejamwinter2017");
        Gengine.setGuiFilename("gui/gui.html");
    }

    public static function start(_engine:Engine)
    {
        var state:EngineState;
        engine = _engine;

        Gengine.getRenderer().getDefaultZone().setFogColor(new Color(0.1,0.1,0.1,1));

        Factory.init();

        var cameraEntity = Factory.createCamera();
        engine.addEntity(cameraEntity);

        engine.addSystem(new AnimatedSystem(), 1);
        engine.addSystem(new StreetSystem(), 10);
        engine.addSystem(new CharacterSystem(), 10);
        engine.addSystem(new MoveSystem(), 10);
        engine.addSystem(new HitSystem(), 11);
        engine.addSystem(new HurtSystem(), 11);
        engine.addSystem(new DeathSystem(), 11);
        engine.addSystem(new IdleSystem(), 11);
        engine.addSystem(new FireSystem(), 11);
        engine.addSystem(new BotSystem(), 11);
        engine.addSystem(new LevelSystem(cameraEntity), 11);
        engine.addSystem(new AudioSystem(cameraEntity), 100);

        var viewport:Viewport = new Viewport(Gengine.getContext());
        viewport.setScene(Gengine.getScene());
        viewport.setCamera(cameraEntity.get(Camera));
        Gengine.getRenderer().setViewport(0, viewport);

        esm = new EngineStateMachine(engine);
        state = new EngineState();
        state.addInstance(new MenuSystem(cameraEntity));
        esm.addState("menu", state);

        state = new EngineState();
        state.addInstance(new PlayerInputSystem(cameraEntity));
        state.addInstance(new GameSystem(cameraEntity));
        esm.addState("ingame", state);

        for(i in 0...10)
        {
            var e = Factory.createEnemy();

            e.position = new Vector3(Std.random(10) * 64 - 320, Std.random(10) * - 25, 0);

            e.get(StreetElement).y = Std.random(10) * - 25;

            engine.addEntity(e);

            e.get(Character).moveTarget = new Vector2(Std.random(10) * 6400, Std.random(10) * - 25);
            e.get(Character).moveSpeed = Std.random(100) + 50;
        }

        var e = Factory.createPlayer();
        engine.addEntity(e);

        changeState("menu");
    }

    public static function onGuiLoaded()
    {
        pages = UIPages.createSet(new JQuery("#body"));

        pages.showPage(".menu");

        new JQuery(".menu").click(
            function(e)
            {
                changeState("ingame");
                pages.showPage(".hud");
            }
            );
    }

    public static function changeState(stateName)
    {
        engine.updateComplete.addOnce(function() {
                esm.changeState(stateName);
            });
    }
}
