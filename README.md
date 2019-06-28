# UIGameKit
An UIKit framework designed to assist in the making of games using UIDynamics

# Explaining the framework:

UIGameKit is designed to work with any UI elements, manage the collisions, gravity, pushs, snaps and delegate the contact as long as you follow the protocols.
Firstly let's understand the main principles.

When we talk about physics system in UIKit, we talk about UIDynamics. The Dynamics is composed of an animator, bound to a reference view in which to animate the behaviors on.

## DynamicAnimatorController
In this framework we have a `DynamicAnimatorController` who's responsible of our animator and it's collisions, delegating contacts and configuration of every object that we put in scene.

The controller counts on a `DynamicBehaviorManager` to assure which object should collide with one another, pushing and snaping objects in scene.

## Objects
Every UI object interacting with this framework must conform to `AffectedByDynamics` protocol.
To easily make objects, some presets are arealdy a part of this framework, and are easily created by a static helper `DynamicObjectFactory` that deals with the configuration of the most commom objects, and with basic configuration of any `AffectedByDynamics` objects that you might come to implement.

Each `AffectedByDynamics` **must** have it's properties set on `init()` or it **won't work**.

## Code example

```
class ViewController: UIViewController, ContactDelegate {
    private lazy var animatorController:DynamicAnimatorController = DynamicAnimatorController(view: self.view, delegate: self)
    var square:DynamicShapeView!
    var circle:DynamicShapeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        square = DynamicObjectsFactory.createSquare(height: 50, width: 50, fillColor: .red, controller: animatorController)
        circle = DynamicObjectsFactory.createCircle(radius: 25, fillColor: .red, controller: animatorController)
    }
    
    func contactOccur(contact: UIContact) {
        //Changing the color of an object when contacts with other
        if let obj = contact.item1 as? DynamicShapeView{
            let colors:[UIColor] = [.blue, .yellow, .purple]
            var cor:UIColor = obj.fillColor
            while cor == obj.fillColor{
                cor = colors[Int.random(in: 0...2)]
            }
            obj.fillColor = cor
        }
    }
    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        //Pushing an object when a tap occurs
        animatorController.pushObject(object: square, pushDirection: CGVector(dx: 5, dy: 5))
    }
}
```

# Known limitations

The framework does not support round objects. It seems that UIKit makes only rectangular objects, so even the `DynamicShapeNode` is just a square with a circle drawn on the middle of it.
**All objects must** set its `AffectedByDynamics` properties on its own constructor(init).
If an object does not collide with other, it can't make contact as well.
