//
//  PathAnimationTestingViewController.swift
//  AnimationFunByGiwon
//
//  Created by SeoGiwon on 10/10/2019.
//  Copyright © 2019 SeoGiwon. All rights reserved.
//

import UIKit

class PathAnimationTestingViewController: UIViewController {

    var theView = UIView()
    var maskLayer = CAShapeLayer()
    var oldPath: UIBezierPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        theView.frame = CGRect(x: 50, y: 250, width: 200, height: 200)
        theView.backgroundColor = UIColor.red
        self.view.addSubview(theView)
        
//        theView.layer.addSublayer(maskLayer)
        theView.layer.mask = maskLayer
        maskLayer.frame = theView.bounds
    }
    
    
    func bouncedBackPath(frame: CGRect) -> UIBezierPath {
    
        let path = UIBezierPath()
        
        let leftTopPoint = CGPoint(x: frame.minX, y: frame.minY)
        let rightTopPoint = CGPoint(x: frame.maxX, y: frame.minY)
        let rightBottomPoint = CGPoint(x: frame.maxX, y: frame.maxY)
        let leftBottomPoint = CGPoint(x: frame.minX, y: frame.maxY)
        
        path.move(to: leftTopPoint)
        
        // add line to right bottom
        path.addLine(to: rightTopPoint)
        
        // add line to left bottom
        path.addLine(to: rightBottomPoint)
        
        // add line to start point
        path.addLine(to: leftBottomPoint)
        path.close()
        
        //        lastPath = curvePath
        
        return path
    
    }

    @IBAction func itemButtonTapped(_ sender: UIBarButtonItem) {
        
        maskLayer.frame = theView.bounds
        let newPath = bouncedBackPath(frame: maskLayer.frame.insetBy(dx: 30, dy: 30))
        maskLayer.path = newPath.cgPath
        
        oldPath = newPath
    }

    @IBAction func button2Tapped(_ sender: UIBarButtonItem) {
        
        maskLayer.frame = theView.bounds
        let newPath = bouncedBackPath(frame: maskLayer.frame)
        
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.toValue = newPath
        pathAnimation.duration = 1.0        
        maskLayer.add(pathAnimation, forKey: "asdf")
        
        maskLayer.path = newPath.cgPath
        oldPath = newPath
    }
    
    func animation() {
        
    }
}
