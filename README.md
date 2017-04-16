# IOS Material Animation

[![IOS](https://img.shields.io/badge/platform-IOS-lightgrey.svg)]()

**Material Animation** is a library for building IOS UIView animation. Inspired by [Google Material Design](https://material.io/)

## Features
- Change background color with shape animation
- Easy to custom and easy to use

## Installation
- Download the latest release version or add the repository as a git submodule to your git-tracked project.
- Open your project in Xcode, then drag and drop all the folder directories in BSXMaterialAnimation folder onto your project (use the "Product Navigator view"). Make sure to select Copy items when asked if you extracted the code archive outside of your project.

## Usage
Import in your file
```
#import "UIView+BSXMaterialAnimation.h"
```

Setup UIView
```
[self.uiview setupForBSXAnimation];
```

Run animation with UIView
```
[self.uiview runBSXAnimateWithCGPoint:CGPointMake(0, 0)
                      backgroundColor:[self randomColor]
                             isExpand:true
                             duration:self.duration
                       timingFunction:nil
                           completion:nil];
```

## Detail
**Material Animation** will change UIView backgroundColor with parameter `backgroundColor` after animation in `Expand` mode

**Parameter**
- **CGPoint**  Animation center point
- **backgroundColor** Animation color
- **isExpand** Whether the animation is expand or shrink
- **duration** The total duration of the animation
- **timingFunction** You can custom your own timingFunction, nil meaning default which is `kCAMediaTimingFunctionEaseIn`
- **completion** A block object to be executed when the animation end
