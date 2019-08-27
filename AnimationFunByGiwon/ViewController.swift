//
//  ViewController.swift
//  AnimationFunByGiwon
//
//  Created by SeoGiwon on 26/08/2019.
//  Copyright © 2019 SeoGiwon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let myView = TabShapeView()
        self.view.addSubview(myView)
        myView.frame = CGRect.init(x: 100, y: 100, width: 200, height: 200)
        
    }


}

