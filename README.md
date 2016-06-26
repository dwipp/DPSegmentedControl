# DPSegmentedControl

This is a custom Segmented Control with icon and text on every segment.
DPSegmentedControl is tested on iOS 9.2
This awesome library is wrote on swift 2.2


## Usage

#### Initialization segmented control with icon
``` swift
let segmentedControl = DPSegmentedControl.init(
            FrameWithIcon: CGRectMake(8, 50, screen.width - 16, 44),
            items: ["Happy", "Normal", "Sad"],
            icons: [UIImage(named: "happy_gray")!, UIImage(named: "flat_gray")!, UIImage(named: "sad_gray")!],
            selectedIcons: [UIImage(named: "happy_white")!, UIImage(named: "flat_white")!, UIImage(named: "sad_white")!],
            backgroundColor: UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1),
            thumbColor: UIColor.init(hex: "#54C3EF"),
            textColor: UIColor(hex: "#808080"),
            selectedTextColor: UIColor(hex: "#FFFFFF"),
            orientation: ComponentOrientation.LeftRight)
```

#### Initialization segmented control without icon
``` swift
let segmentedControl = DPSegmentedControl.init(
            FrameWithoutIcon: CGRectMake(8, 50, screen.width - 16, 44),
            items: ["Happy", "Normal", "Sad"],
            backgroundColor: UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1),
            thumbColor: UIColor.init(hex: "#54C3EF"),
            textColor: UIColor(hex: "#808080"),
            selectedTextColor: UIColor(hex: "#FFFFFF"))
```


``` swift
// To get the changed value event, set it manually on your view controller
segmentedControl.addTarget(self, action: #selector(self.action(_:)), forControlEvents: .ValueChanged)

// You need to add DPSegmnetedControl to container
self.view.addSubview(segmentedControl)

// You could set the selected index. Default is 0
segmentedControl.selectedIndex = 1
```

## Sample

![gif](http://i.giphy.com/iZvJT92KGkeiI.gif)

[This is the video sample](https://youtu.be/PaVUNysxyf4)

## Installation 

Manual installation. Just copy DPSegmentedControl folder to your project.
Will be available on cocoapods soon.

## License

DPSegmentedControl is released under the MIT license. See LICENSE for details.

