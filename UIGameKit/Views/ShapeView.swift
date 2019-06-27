//
//  ShapeView.swift
//  UIGameKit
//
//  Created by Pedro Giuliano Farina on 26/06/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

@IBDesignable public class ShapeView : UIView{
    private var _radius:CGFloat = 0
    @IBInspectable public var radius:CGFloat
        {
        get{
            return _radius
        }
        set{
            _radius = min(newValue, min(bounds.width/2, bounds.height/2))
            if _radius == 0{
                backgroundColor = fillColor
            }
            else{
                backgroundColor = .clear
            }
        }
    }
    
    @IBInspectable public var fillColor:UIColor = .red
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        if radius != 0{
            let center = CGPoint(x:bounds.width/2, y:bounds.height/2)
            let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat.zero, endAngle: 2 * CGFloat.pi, clockwise: false)
            
            fillColor.setFill()
            path.fill()
        }
    }
}
