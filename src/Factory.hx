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
        addAnimation(new Animation("punch", 6, 0, 5, 15, 64, 64, 1024, 1024, false));
        addAnimation(new Animation("punches", 9, 0, 9, 15, 64, 64, 1024, 1024, false));
        addAnimation(new Animation("death", 4, 0, 6, 5, 64, 64, 1024, 1024, false));
        addAnimation(new Animation("hit", 4, 1, 3, 15, 64, 64, 1024, 1024, false));
    }

    static public function addAnimation(anim:Animation)
    {
        animations[anim.name] = anim;
    }

    static public function createCharacter():Entity
    {
        var e = new Entity();
        var sm = new EntityStateMachine(e);
        e.add(new StaticSprite2D());
        e.get(StaticSprite2D).setDrawRect(new Rect(new Vector2(-64, -64), new Vector2(64, 64)));
        e.get(StaticSprite2D).setUseDrawRect(true);
        e.get(StaticSprite2D).setUseTextureRect(true);
        e.get(StaticSprite2D).setSprite(catSprite);
        e.get(StaticSprite2D).setLayer(0);
        e.get(StaticSprite2D).setHotSpot(new Vector2(0, 32));
        e.get(StaticSprite2D).setUseHotSpot(true);
        e.get(StaticSprite2D).setLayer(2);

        e.add(new StreetElement());

        e.add(new Animated());
        e.get(Animated).push("idle");

        e.add(new Character());
        e.get(Character).sm = sm;

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

        sm.changeState("idling");

        return e;
    }

    static public function createPlayer():Entity
    {
        var e = createCharacter();

        e.add(new PlayerInput());

        return e;
    }

    static public function createCamera()
    {
        var cameraEntity = new Entity();
        cameraEntity.add(new Camera());
        cameraEntity.get(Camera).setOrthoSize(new Vector2(640, 480));
        cameraEntity.get(Camera).setOrthographic(true);

        return cameraEntity;
    }

    static public function createMap():Entity
    {
        var e = new Entity();
        e.add(new TileMap2D());

        //e.get(TileMap2D).setTmxFile(Gengine.getResourceCache().getTmxFile2D("map.tmx", true));

        return e;
    }
}
