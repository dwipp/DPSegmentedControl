//
//  SegmentedControl.swift
//  Segmented
//
//  Created by Dwi Permana Putra on 5/30/16.
//  Copyright © 2016 Dwi Permana Putra. All rights reserved.
//

import UIKit

enum ComponentOrientation {
    case TopDown
    case LeftRight
}

class DPSegmentedControl:UIControl {
    
    private var componentOrientation: ComponentOrientation = ComponentOrientation.LeftRight
    
    private var labels = [UILabel]()
    private var icons = [UIImageView]()
    private var selectedLabel = UILabel()
    
    private var img_icon = UIImageView()
    private var selected_img_icon = UIImageView()
    
    private var withIcon:Bool = true
    
    private func setOrientation(orientation:ComponentOrientation){
        switch orientation {
        case .LeftRight:
            componentOrientation = ComponentOrientation.LeftRight
        case .TopDown :
            componentOrientation = ComponentOrientation.TopDown
        }
    }
    
    private var thumbColor: UIColor = UIColor.white {
        didSet{
            setThumbColor()
        }
    }
    
    private func setThumbColor(){
        thumbView.backgroundColor = thumbColor
    }
    
    private var textColor: UIColor = UIColor.white
    
    private func setTextColor(){
        for i in 0..<labels.count {
            labels[i].textColor = textColor
            labels[i].font = UIFont(name: "HelveticaNeue", size: 14.0)
        }
    }
    
    private var selectedTextColor: UIColor = UIColor.black {
        didSet{
            setSelectedTextColor()
        }
    }
    
    private func setSelectedTextColor(){
        selectedLabel.textColor = selectedTextColor
    }
    
    private var thumbView = UIView()
    
    
    private var items:[String] = []
    
    private var icon:[UIImage] = []
    private var selected_icon:[UIImage] = []
    
    var selectedIndex:Int = 0 {
        didSet{
            displayNewSelectedIndex()
        }
    }
    
    
    init(FrameWithoutIcon frame: CGRect, items:[String], backgroundColor:UIColor, thumbColor:UIColor, textColor:UIColor, selectedTextColor:UIColor) {
        super.init(frame: frame)
        self.items = items
        self.backgroundColor = backgroundColor
        self.thumbColor = thumbColor
        self.textColor = textColor
        self.selectedTextColor = selectedTextColor
        self.componentOrientation = ComponentOrientation.TopDown
        self.withIcon = false
        setupView()
    }
    
    init(FrameWithIcon frame: CGRect, items:[String], icons:[UIImage], selectedIcons:[UIImage], backgroundColor:UIColor, thumbColor:UIColor, textColor:UIColor, selectedTextColor:UIColor, orientation:ComponentOrientation) {
        super.init(frame: frame)
        self.items = items
        self.icon = icons
        self.selected_icon = selectedIcons
        self.backgroundColor = backgroundColor
        self.thumbColor = thumbColor
        self.textColor = textColor
        self.selectedTextColor = selectedTextColor
        self.componentOrientation = orientation
        setupView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    private func getIconFrameByOrientation(orientation:ComponentOrientation, index:Int, text:String) -> CGRect {
        let width = self.bounds.width/CGFloat(items.count)
        let height = self.bounds.height
        let iconX = getIconX(itemWidth: width, textWidth: evaluateStringWidth(textToEvaluate: text))
        let x = width*CGFloat(index-1)
        
        switch orientation {
        case .LeftRight:
            let evaluateIconX = x + iconX
            let iconRect = CGRect(x: evaluateIconX, y: 0, width: 16, height: height)
            return iconRect
        case .TopDown:
            let centre:CGFloat = x + ((width-16)/2)
            let iconRect = CGRect(x: centre, y: 7, width: 16, height: 16) //CGRect(centre, 7, 16, 16)
            return iconRect
        }
    }
    
    private func getTextFrameByOrintation(orientation:ComponentOrientation, text:String, index:Int) -> CGRect {
        let height = self.bounds.height
        let width = self.bounds.width/CGFloat(items.count)
        let textX = getTextX(itemWidth: width, textWidth: evaluateStringWidth(textToEvaluate: text))
        let xPosition = CGFloat(index) * width
        let evaluateTextX = xPosition + textX
        
        switch orientation {
        case .LeftRight:
            let textRect = CGRect(x: evaluateTextX, y: 0, width: width, height: height)
            return textRect
        case .TopDown:
            let centre = evaluateTextX - 13
            let textRect:CGRect?
            if withIcon {
                textRect = CGRect(x: centre, y: 18, width: width, height: 25)
            }else {
                textRect = CGRect(x: centre, y: 0, width: width, height: height)
            }
            return textRect!
        }
    }
    
    
    private func setupView(){
        layer.cornerRadius = 5
        setupLabels()
        insertSubview(thumbView, at: 0)
    }
    
    private func setupLabels(){
        
        
        for label in labels {
            label.removeFromSuperview()
        }
        labels.removeAll(keepingCapacity: true)
        
        for index in 1...items.count {
            
            
            let view = UIView.init(frame: CGRect.zero)
            
            let label = UILabel(frame: CGRect.zero)
            label.text = items[index-1]
            label.textColor = textColor
            view.addSubview(label)
            labels.append(label)
            
            let text = items[index-1]
            
            if withIcon {
                self.img_icon = UIImageView(frame: getIconFrameByOrientation(orientation: self.componentOrientation, index: index, text: text))
                self.img_icon.contentMode = .scaleAspectFit
                self.img_icon.image = icon[index-1]
                
                view.addSubview(self.img_icon)
                icons.append(self.img_icon)
            }
            
            self.addSubview(view)
            
        }
        setTextColor()
        
    }
    
    private func getIconX(itemWidth:CGFloat, textWidth:CGFloat) -> CGFloat{
        let iconWidth:CGFloat = 16.0
        let avg = (iconWidth + textWidth)
        let space:CGFloat = (itemWidth - avg)/2
        
        return space + 2
    }
    
    private func getTextX(itemWidth:CGFloat, textWidth:CGFloat) -> CGFloat {
        let iconWidth:CGFloat = 16.0
        let avg = (iconWidth + textWidth)
        let space:CGFloat = (itemWidth - avg)/2
        
        let x = space + iconWidth
        
        return x + 8
    }
    
    internal override func layoutSubviews() {
        super.layoutSubviews()
        
        var selectedFrame = self.bounds
        let newWidth = selectedFrame.width / CGFloat(items.count)
        selectedFrame.size.width = newWidth
        
        selectedFrame.origin.x = selectedFrame.origin.x + 4
        selectedFrame.origin.y = selectedFrame.origin.y + 4
        selectedFrame.size.width = selectedFrame.width - 8
        selectedFrame.size.height = selectedFrame.height - 8
        
        
        if selectedIndex > 0 {
            setTextColor()
            setSelectedTextColor()
            thumbView.frame = setDefaultSelectionPoint(index: selectedIndex)
        }else {
            thumbView.frame = selectedFrame
        }
        
        thumbView.backgroundColor = thumbColor
        thumbView.layer.cornerRadius = 5
        
        
        for index in 0...labels.count - 1 {
            let label = labels[index]
            
            let text = items[index]
            
            
            label.frame = getTextFrameByOrintation(orientation: self.componentOrientation, text: text, index: index)
            
        }
    }
    
    private func evaluateStringWidth (textToEvaluate: String) -> CGFloat{
        let lbl = UILabel(frame: CGRect.zero)
        lbl.text = textToEvaluate
        lbl.sizeToFit()
        
        return lbl.frame.width
    }
    
    internal override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        
        let labelWidth = self.bounds.width / CGFloat(items.count)
        
        var calculatedIndex : Int?
        for (index, item) in labels.enumerated() {
            
            let text = items[index]
            
            let iconX = getIconX(itemWidth: labelWidth, textWidth: evaluateStringWidth(textToEvaluate: text))
            
            let frame = CGRect(x: item.frame.origin.x - (iconX*2), y: 0, width: item.frame.width, height: self.bounds.height)
            
            if frame.contains(location){
                calculatedIndex = index
            }else{
                item.textColor = textColor
                if withIcon {
                    icons[index].image = icon[index]
                }
                
            }
        }
        
        if calculatedIndex != nil {
            selectedIndex = calculatedIndex!
            sendActions(for: .valueChanged)
        }
        return false
    }
    
    private func displayNewSelectedIndex(){
        selectedLabel = labels[selectedIndex]
        selectedLabel.textColor = selectedTextColor
        
        if withIcon {
            selected_img_icon = icons[selectedIndex]
            selected_img_icon.image = selected_icon[selectedIndex]
        }
        
        
        let text = items[selectedIndex]
        
        let labelWidth = self.bounds.width / CGFloat(items.count)
        let iconX = getTextX(itemWidth: labelWidth, textWidth: evaluateStringWidth(textToEvaluate: text))
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: {
            
            var labelFrame = self.selectedLabel.bounds
            
            print("selectedLabel: \(self.selectedLabel.frame.origin.x)")
            
            if self.componentOrientation == ComponentOrientation.TopDown {
                labelFrame.origin.x = self.selectedLabel.frame.origin.x - iconX + 4 + 13
            }else{
                labelFrame.origin.x = self.selectedLabel.frame.origin.x - iconX + 4
            }
            
            labelFrame.origin.y = 4
            labelFrame.size.width = self.selectedLabel.frame.width - 8
            labelFrame.size.height = self.bounds.height - 8
            
            
            self.thumbView.frame = self.setDefaultSelectionPoint(index: self.selectedIndex)
            
        }, completion: nil)
        
        
    }
    
    private func setDefaultSelectionPoint(index:Int) -> CGRect{
        let selectedLabel = labels[index]
        var selectedFrame = selectedLabel.bounds
        
        if withIcon {
            selected_img_icon = icons[selectedIndex]
            selected_img_icon.image = selected_icon[selectedIndex]
        }
        
        let text = items[selectedIndex]
        let labelWidth = self.bounds.width / CGFloat(items.count)
        let iconX = getTextX(itemWidth: labelWidth, textWidth: evaluateStringWidth(textToEvaluate: text))
        
        if self.componentOrientation == ComponentOrientation.TopDown {
            selectedFrame.origin.x = self.selectedLabel.frame.origin.x - iconX + 4 + 13
        }else{
            selectedFrame.origin.x = self.selectedLabel.frame.origin.x - iconX + 4
        }
        selectedFrame.origin.y = 4
        selectedFrame.size.width = self.selectedLabel.frame.width - 8
        selectedFrame.size.height = self.bounds.height - 8
        return selectedFrame
    }

}


