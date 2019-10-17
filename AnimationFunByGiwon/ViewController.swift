//
//  ViewController.swift
//  AnimationFunByGiwon
//
//  Created by SeoGiwon on 26/08/2019.
//  Copyright © 2019 SeoGiwon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let myView = TargetView()
    var pointGenerator = MyControlPointGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(myView)
        myView.frame = CGRect.init(x: 100, y: 100, width: 200, height: 200)
        myView.backgroundColor = UIColor.blue
        
        
        let timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)

        timer.fire()
    }

    @objc func timerFunction() {
        
        myView.curveControlValue = pointGenerator.nextControlValue()
    }
    
}

class MyControlPointGenerator {
    
    private var isIncrementing = true
    private var currentControlValue: CGFloat = 0.5
    
    func nextControlValue() -> CGFloat {
        
        determineNextControlValue(&currentControlValue, isIncrementing: &isIncrementing)
        return currentControlValue
    }
    
    func determineNextControlValue(_ value:inout CGFloat, isIncrementing:inout Bool) {
        
        let min: CGFloat = 0.0
        let max: CGFloat = 1.0
        
        if isIncrementing {
            value = value + 0.01
            
            if value >= max {
                value = max
                isIncrementing = false
            }
            if value <= min {
                value = min
                isIncrementing = true
            }
        } else {
            
            value = value - 0.01
            
            if value >= max {
                value = max
                isIncrementing = false
            }
            if value <= min {
                value = min
                isIncrementing = true
            }
            
        }
        
    }
}
