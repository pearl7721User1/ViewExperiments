//
//  CatImageViewController.swift
//  AnimationFunByGiwon
//
//  Created by SeoGiwon on 30/08/2019.
//  Copyright © 2019 SeoGiwon. All rights reserved.
//

import UIKit

class CatImageViewController: UIViewController {

    @IBOutlet weak var pullHandleView: PullHandleView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }


    static func newInstance() -> CatImageViewController {
        
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CatImageViewController") as? CatImageViewController else {
            fatalError()
        }
        
        return vc
    }
}
