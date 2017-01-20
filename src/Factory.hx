import gengine.*;
import gengine.components.*;
import ash.systems.*;
import ash.fsm.*;
import components.*;
import gengine.math.*;
import haxe.ds.Vector;

class Factory
{
    static var catSprite:Dynamic;
    public static var animations:Map<String, Animation>;

    static public function init()
    {
        catSprite = Gengine.getResourceCache().getSprite2D("cat.png", true);

        animations = new Map();

        addAnimation(new Animation("idle", 0, 0, 3, 10, 64, 64, 1024, 1024, true));
        addAnimation(new Animation("walk", 1, 0, 7, 20, 64, 64, 1024, 1024, true));
        addAnimation(new Animation("fire", 6, 0, 5, 15, 64, 64, 1024, 1024, false));
        addAnimation(new Animation("punches", 9, 0, 9, 18, 64, 64, 1024, 1024, false));
        addAnimation(new Animation("death", 4, 0, 6, 5, 64, 64, 1024, 1024, false));
        addAnimation(new Animation("hit", 4, 1, 3, 15, 64, 64, 1024, 1024, false));
        addAnimation(new Animation("lowkick", 10, 0, 5, 16, 64, 64, 1024, 1024, false));
        addAnimation(new Animation("middlekick", 10, 6, 11, 16, 64, 64, 1024, 1024, false));
        addAnimation(new Animation("highkick", 11, 0, 5, 16, 64, 64, 1024, 1024, false));
        addAnimation(new Animation("downwardkick", 12, 0, 7, 16, 64, 64, 1024, 1024, false));
        addAnimation(new Animation("roundkick", 14, 0, 5, 16, 64, 64, 1024, 1024, false));
        addAnimation(new Animation("uppercut", 15, 0, 5, 16, 64, 64, 1024, 1024, false));
    }

    static public function addAnimation(anim:Animation)
    {
        animations[anim.name] = anim;
    }

    static public function createCircle():Entity
    {
        var e = new Entity();
        e.add(new StaticSprite2D());
        e.get(StaticSprite2D).setSprite(Gengine.getResourceCache().getSprite2D("circle.png", true));
        e.get(StaticSprite2D).setColor(new Color(0, 1, 0, 1));
        e.get(StaticSprite2D).setLayer(99);
        return e;
    }

    static public function createCharacter():Entity
    {
        var e = new Entity();
        var sm = new EntityStateMachine(e);
        e.add(new StaticSprite2D());
        e.get(StaticSprite2D).setDrawRect(new Rect(new Vector2(-96, -96), new Vector2(96, 96)));
        e.get(StaticSprite2D).setUseDrawRect(true);
        e.get(StaticSprite2D).setUseTextureRect(true);
        e.get(StaticSprite2D).setSprite(catSprite);
        e.get(StaticSprite2D).setLayer(0);
        e.get(StaticSprite2D).setHotSpot(new Vector2(0, 32));
        e.get(StaticSprite2D).setUseHotSpot(true);
        e.get(StaticSprite2D).setLayer(100);

        e.add(new StreetElement());

        e.add(new Animated());
        e.get(Animated).push("idle");

        e.add(new Character());
        e.get(Character).sm = sm;
        e.get(Character).baseColor = new Color(0.5,0.5,0.5,1);

        sm.createState("idling")
            .add(Idle).withInstance(new Idle());

        sm.createState("moving")
            .add(Move).withInstance(new Move());

        sm.createState("dying")
            .add(Death).withInstance(new Death());

        sm.createState("hitting")
            .add(Hit).withInstance(new Hit());

        sm.createState("hurting")
            .add(Hurt).withInstance(new Hurt());

        sm.createState("firing")
            .add(Fire).withInstance(new Fire());

        sm.changeState("idling");

        return e;
    }

    static public function createPlayer():Entity
    {
        var e = createCharacter();

        e.add(new PlayerInput());

        e.get(Character).baseColor = new Color(1, 1, 1, 1);

        return e;
    }

    static public function createCamera()
    {
        var cameraEntity = new Entity();
        cameraEntity.add(new Camera());
        cameraEntity.get(Camera).setOrthoSize(new Vector2(800, 600));
        cameraEntity.get(Camera).setOrthographic(true);

        return cameraEntity;
    }

    static public function createMap():Entity
    {
        var e = new Entity();
        e.add(new TileMap2D());
        e.add(new Level());

        //e.get(TileMap2D).setTmxFile(Gengine.getResourceCache().getTmxFile2D("map.tmx", true));

        return e;
    }
}
