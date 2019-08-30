//
//  MyButton.swift
//  ButtonTouchUpInside
//
//  Created by SeoGiwon on 27/09/2018.
//  Copyright © 2018 SeoGiwon. All rights reserved.
//

import UIKit

@IBDesignable
class GiwonButton: UIButton {
    
    private let bglayer = CALayer()
    private let bgImgLayer = CALayer()
    
    @IBInspectable var headButtonImage: UIImage? {
        didSet {
            bgImgLayer.contents = headButtonImage?.cgImage
        }
    }
    @IBInspectable var tailButtonImage: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        
        self.layer.addSublayer(bgImgLayer)
        self.layer.insertSublayer(bglayer, below: bgImgLayer)
        bglayer.backgroundColor = UIColor(white: 0.7, alpha: 1.0).cgColor
        bglayer.opacity = 0
        
        self.addTarget(self, action: #selector(touchDown), for: .touchDown)
        self.addTarget(self, action: #selector(touchDownRepeat), for: .touchUpInside)
        self.addTarget(self, action: #selector(touchDragInside), for: .touchDragInside)
        self.addTarget(self, action: #selector(touchDragEnter), for: .touchDragEnter)
        self.addTarget(self, action: #selector(touchDragOutside), for: .touchDragOutside)
        self.addTarget(self, action: #selector(touchDragExit), for: .touchDragExit)
        
        self.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        self.addTarget(self, action: #selector(touchUpOutside), for: .touchUpOutside)
        self.addTarget(self, action: #selector(touchCancel), for: .touchCancel)

    }

    @objc func touchDown() {
        print("touchDown")
        self.transitionAnimation(isTouchingDown: true)
    }
    @objc func touchDownRepeat() {
        print("touchDownRepeat")
//        self.transitionAnimation(isTouchingDown: true)
    }
    @objc func touchDragInside() {
        print("touchDragInside")
        self.transitionAnimation(isTouchingDown: true)
    }
    @objc func touchDragEnter() {
        print("touchDragEnter")
        //        self.transitionAnimation(isTouchingDown: false)
    }
    @objc func touchDragOutside() {
        print("touchDragOutside")
        self.transitionAnimation(isTouchingDown: false)
    }
    @objc func touchDragExit() {
        print("touchDragExit")
//        self.transitionAnimation(isTouchingDown: false)
    }
    @objc func touchUpInside() {
        print("touchUpInside")
        self.transitionAnimation(isTouchingDown: false)
    }
    @objc func touchUpOutside() {
        print("touchUpOutside")
//        self.transitionAnimation(isTouchingDown: true)
    }
    @objc func touchCancel() {
        print("touchCancel")
        self.transitionAnimation(isTouchingDown: false)
    }
    
    /*
    @objc func buttonPressed() {
        self.transitionAnimation(isTouchingDown: true)
    }
    
    @objc func buttonUnPressed() {
        self.transitionAnimation(isTouchingDown: false)
    }
    */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var bounds = self.bounds
        bounds.size.width = self.bounds.width * 1.5
        bounds.size.height = self.bounds.height * 1.5
        bounds.origin.x = -self.bounds.width * 0.5 / 2.0
        bounds.origin.y = -self.bounds.height * 0.5 / 2.0
        
        bglayer.frame = bounds //self.bounds
        bglayer.cornerRadius = bounds.size.width / 2 //self.bounds.size.width / 2
        bgImgLayer.frame = self.bounds
    }
    
    override var intrinsicContentSize: CGSize {
        if let headButtonImage = headButtonImage {
            return headButtonImage.size
        } else {
            return CGSize(width: 40, height: 40)
        }
    }

    private func transitionAnimation(isTouchingDown: Bool) {
        
        bglayer.opacity = isTouchingDown ? 0.5 : 0
        bgImgLayer.transform = isTouchingDown ? CATransform3DScale(CATransform3DIdentity, 0.8, 0.8, 0.8) : CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 1.0)
        
    }
    
    func showIcon(isHead: Bool) {
        bgImgLayer.contents = isHead ? headButtonImage?.cgImage : tailButtonImage?.cgImage
    }
}
