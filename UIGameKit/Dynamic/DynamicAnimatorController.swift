//
//  DynamicAnimatorController.swift
//  UIGameKit
//
//  Created by Pedro Giuliano Farina on 26/06/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

public class DynamicAnimatorController : NSObject, UICollisionBehaviorDelegate{
    private let animator:UIDynamicAnimator
    private lazy var behavioManager:DynamicBehaviorManager = DynamicBehaviorManager(animator: animator, collisionDelegate: self)
    public var contactDelegate:ContactDelegate?
    
    init(view:UIView, delegate:ContactDelegate){
        animator = UIDynamicAnimator(referenceView: view)
        super.init()
    }
    
    public func addSubview(_ view:AffectedByDynamics){
        behavioManager.config(object: view)
        animator.referenceView?.addSubview(view)
    }
    
    public func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint){
        guard let it1 = item1 as? AffectedByDynamics, let it2 = item2 as? AffectedByDynamics else{
            fatalError("The dynamics items where not according to the protocol. Please if in doubt use the  DynamicObjectsFactory")
        }
        if (it1.categoryBitMask & it2.contactBitMask) > 0{
            contactDelegate?.contactOccur(contact: UIContact(behavior: behavior, item1: item1, item2: item2, at: p))
        }
        else if (it2.categoryBitMask & it1.contactBitMask) > 0{
            contactDelegate?.contactOccur(contact: UIContact(behavior: behavior, item1: item2, item2: item1, at: p))
        }
    }
}
