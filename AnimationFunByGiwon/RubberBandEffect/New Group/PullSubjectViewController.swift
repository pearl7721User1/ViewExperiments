//
//  CatImageViewController.swift
//  AnimationFunByGiwon
//
//  Created by SeoGiwon on 30/08/2019.
//  Copyright © 2019 SeoGiwon. All rights reserved.
//

import UIKit

class PullSubjectViewController: UIViewController {

    @IBOutlet weak var pullHandleView: PullHandleView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }


    static func newInstance() -> PullSubjectViewController {
        
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PullSubjectViewController") as? PullSubjectViewController else {
            fatalError()
        }
        
        return vc
    }
}
