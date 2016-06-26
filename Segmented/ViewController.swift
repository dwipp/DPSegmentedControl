//
//  ViewController.swift
//  Segmented
//
//  Created by Dwi Permana Putra on 5/30/16.
//  Copyright © 2016 Dwi Permana Putra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var segmentedControl: DPSegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screen = UIScreen.mainScreen().bounds
        
        segmentedControl = DPSegmentedControl.init(
            FrameWithIcon: CGRectMake(8, 50, screen.width - 16, 44),
            items: ["Happy", "Normal", "Sad"],
            icons: [UIImage(named: "happy_gray")!, UIImage(named: "flat_gray")!, UIImage(named: "sad_gray")!],
            selectedIcons: [UIImage(named: "happy_white")!, UIImage(named: "flat_white")!, UIImage(named: "sad_white")!],
            backgroundColor: UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1),
            thumbColor: UIColor.init(hex: "#54C3EF"),
            textColor: UIColor(hex: "#808080"),
            selectedTextColor: UIColor(hex: "#FFFFFF"),
            orientation: ComponentOrientation.LeftRight)
        
        segmentedControl?.selectedIndex = 1
        
        segmentedControl?.addTarget(self, action: #selector(self.action(_:)), forControlEvents: .ValueChanged)
        self.view.addSubview(segmentedControl!)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    func action(sender: DPSegmentedControl){
        print("sender: \(sender.selectedIndex)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension UIColor {
    convenience init(hex:String) {
        let hexString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let scanner            = NSScanner(string: hexString)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
}

