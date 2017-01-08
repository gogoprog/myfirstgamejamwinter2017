import gengine.*;
import gengine.math.*;
import gengine.components.*;
import gengine.graphics.*;

import ash.fsm.*;

import systems.*;
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
        Gengine.setWindowSize(new IntVector2(1024, 768));
        Gengine.setWindowTitle("myfirstgamejamwinter2017");
        Gengine.setGuiFilename("gui/gui.html");
    }

    public static function start(_engine:Engine)
    {
        engine = _engine;

        Gengine.getRenderer().getDefaultZone().setFogColor(new Color(0.8,0.9,0.8,1));

        engine.addSystem(new AnimatedSystem(), 1);
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
