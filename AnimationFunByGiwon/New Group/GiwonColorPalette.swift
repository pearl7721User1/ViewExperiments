//
//  GiwonColorPalette.swift
//  AnimationFunByGiwon
//
//  Created by SeoGiwon on 03/09/2019.
//  Copyright © 2019 SeoGiwon. All rights reserved.
//

import UIKit

struct GiwonColorPalette {
    
    private var color: UIColor
    private let brightness: CGFloat = 0.2
    private var hueOffset: CGFloat = 0.1
    
    init(hue: CGFloat, sat: CGFloat) {
        self.color = UIColor(hue: hue, saturation: sat, brightness: brightness, alpha: 1.0)
    }
    
    func mainColor() -> UIColor {
        return self.color
    }
    
    private func color(hueOffset: CGFloat) -> UIColor {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.color.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        
        let newColor = UIColor(hue: fmod(h + hueOffset, 1), saturation: s, brightness: b, alpha: a)
        return newColor
    }
    
    private func color(brightness: CGFloat) -> UIColor {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.color.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        
        let newColor = UIColor(hue: fmod(h + hueOffset, 1), saturation: s, brightness: brightness, alpha: a)
        return newColor
    }
    
    func analogousColor1() -> UIColor {
        
        return color(hueOffset: hueOffset)
    }
    
    func analogousColor2() -> UIColor {
        
        return color(hueOffset: -hueOffset)
    }
    
    func lighterColor1() -> UIColor {
        
        return color(brightness: 0.5)
    }
    
    func lighterColor2() -> UIColor {
        return color(brightness: 0.8)
    }
    
    mutating func offsetHue() {
        self.color = color(hueOffset: hueOffset)
    }
}
