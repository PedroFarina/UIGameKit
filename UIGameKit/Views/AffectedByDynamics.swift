//
//  AffectedByDynamics.swift
//  UIGameKit
//
//  Created by Pedro Giuliano Farina on 26/06/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//
public protocol AffectedByDynamics{
    var affectedByGravity:Bool { get set }
    var categoryBitMask:UInt32 { get set }
    var collisionBitMask:UInt32 { get set }
    var contactBitMask:UInt32 { get set }
}
