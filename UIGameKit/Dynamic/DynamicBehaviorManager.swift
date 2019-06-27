//
//  DynamicBehaviorManager.swift
//  UIGameKit
//
//  Created by Pedro Giuliano Farina on 27/06/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

public class DynamicBehaviorManager{
    private let animator:UIDynamicAnimator
    private let gravityBehavior:UIGravityBehavior
    private var collisionBehaviors:[UICollisionBehavior] = []
    public var collisionDelegate:UICollisionBehaviorDelegate?{
        didSet{
            for b in  collisionBehaviors{
                b.collisionDelegate = self.collisionDelegate
            }
        }
    }
    
    init(animator:UIDynamicAnimator, collisionDelegate:UICollisionBehaviorDelegate?){
        self.animator = animator
        self.collisionDelegate = collisionDelegate
        
        self.gravityBehavior = UIGravityBehavior(items: [])
        self.animator.addBehavior(gravityBehavior)
    }
    
    convenience init(animator:UIDynamicAnimator){
        self.init(animator:animator, collisionDelegate:nil)
    }
    
    public func config(object:AffectedByDynamics){
        if object.affectedByGravity{
            self.gravityBehavior.addItem(object)
        }
        let binaryReverse:String = String(String(object.collisionBitMask,  radix:2).reversed())
        checkCount(count: binaryReverse.count)
        
        var i:Int = 0
        for c in binaryReverse{
            if c == "1"{
                collisionBehaviors[i].addItem(object)
            }
            i+=1
        }
    }
    
    private func checkCount(count:Int){
        for _ in collisionBehaviors.count...count{
            let behavior:UICollisionBehavior = UICollisionBehavior(items: [])
            behavior.collisionDelegate =  collisionDelegate
            collisionBehaviors.append(behavior)
            animator.addBehavior(behavior)
        }
    }
    
}
