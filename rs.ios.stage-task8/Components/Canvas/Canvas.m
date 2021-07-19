//
//  Canvas.m
//  rs.ios.stage-task8
//
//  Created by Vladislav Slizhevsky on 7/18/21.
//

#import "Canvas.h"

@interface Canvas ()

@property (nonatomic) UIBezierPath *firstPath;
@property (nonatomic) UIBezierPath *secondPath;
@property (nonatomic) UIBezierPath *thirdPath;
@property (nonatomic, assign) NSInteger coordinatesIdx;
@property (nonatomic, strong) NSDictionary<NSString *, NSArray<NSMutableArray<NSNumber *> *> *> *templates;
@property (nonatomic, assign, readwrite) BOOL isDrawingDone;
@property (nonatomic, assign) BOOL isCoordinatesNormalized;

@end

@implementation Canvas

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isReadyToDraw = NO;
        _isDrawingDone = NO;
        _isCoordinatesNormalized = NO;
        _reset = NO;
        _coordinatesIdx = 1;
        _firstPath = [UIBezierPath new];
        _secondPath = [UIBezierPath new];
        _thirdPath = [UIBezierPath new];
        _colors = @[];
        _templates = @{
            @"Head": @[
                    [NSMutableArray arrayWithArray: @[
                        @[@55.5, @21],
                        @[@71, @81],
                        @[@83, @104],
                        @[@100.5, @123.5],
                        @[@127.5, @146],
                        @[@151, @151.5],
                        @[@187, @134],
                        @[@214, @104],
                        @[@222.5, @92],
                        @[@224.5, @42.5],
                        @[@212.5, @32.5],
                        @[@196, @35.5],
                        @[@185, @52.5],
                        @[@183, @75.5],
                        @[@187, @88]
                    ]],
                    [NSMutableArray arrayWithArray: @[
                        @[@178, @93],
                        @[@169.5, @91.5],
                        @[@160, @93.5],
                        @[@152, @94.5],
                        @[@142.5, @93.5],
                        @[@134, @92],
                        @[@127.5, @91.5],
                        @[@120, @93],
                        @[@115.5, @95],
                        @[@121.5, @97.5],
                        @[@126, @101],
                        @[@130.5, @106],
                        @[@136.5, @108.5],
                        @[@144, @109.5],
                        @[@151, @108.5],
                        @[@158.5, @109.5],
                        @[@164.5, @108.5],
                        @[@171, @104.5],
                        @[@178, @96.5],
                        @[@182.5, @90.5],
                        @[@174.5, @89.5],
                        @[@165.5, @88.5],
                        @[@156.5, @86.5],
                        @[@148, @86],
                        @[@138, @87.5],
                        @[@129, @89.5],
                        @[@119, @90.5],
                        @[@112, @90],
                        @[@121.5, @84],
                        @[@130.5, @77.5],
                        @[@136.5, @74],
                        @[@141.5, @75.5],
                        @[@147, @77.5],
                        @[@153.5, @76.5],
                        @[@160, @75.5],
                        @[@165.5, @73],
                        @[@168.5, @77.5],
                        @[@173.5, @82.5],
                        @[@181, @87]
                    ]],
                    [NSMutableArray arrayWithArray: @[
                        @[@182.5, @95.5],
                        @[@187, @101.5],
                        @[@189.5, @108],
                        @[@186, @117],
                        @[@179, @125.5],
                        @[@170, @132.5],
                        @[@160.5, @125.5],
                        @[@150, @121.5],
                        @[@140.5, @121.5],
                        @[@128.5, @125.5],
                        @[@120.5, @135],
                        @[@114, @147.5],
                        @[@102.5, @140.5],
                        @[@94.5, @130.5],
                        @[@86, @121.5],
                        @[@86, @135],
                        @[@86, @163.5],
                        @[@86, @180.5],
                        @[@79, @192],
                        @[@67.5, @200.5],
                        @[@56.5, @207.5],
                        @[@74, @214],
                        @[@87.5, @222.5],
                        @[@98, @236.5],
                        @[@112, @254],
                        @[@131, @272],
                        @[@150, @278.5],
                        @[@164, @278.5],
                        @[@179, @270.5],
                        @[@192.5, @254],
                        @[@202.5, @232.5],
                        @[@212, @216.5],
                        @[@226.5, @210],
                        @[@230, @210],
                        @[@223.5, @194.5],
                        @[@214, @166],
                        @[@212, @143],
                        @[@212, @119.5],
                        @[@205, @130.5],
                        @[@197, @138.5],
                        @[@189.5, @147.5],
                        @[@173, @163.5],
                        @[@163, @178],
                        @[@154.5, @199.5],
                        @[@151.5, @225.5],
                        @[@151.5, @254],
                        @[@151.5, @272]
                    ]]
                ]
        };
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    NSLog(@"Called");
    if (self.reset) {
        return [self resetPaths];
    }
    
    if (!self.isReadyToDraw || !self.templates[self.templateName]) {
        return;
    }

    NSArray *coordinates = self.templates[self.templateName];

    if (!self.isCoordinatesNormalized) {
        [self normalizeCoordinates:coordinates];
    }

    if (self.coordinatesIdx == [[coordinates firstObject] count]) {
        [self strokePaths];
        self.isDrawingDone = YES;
        return;
    }

    UIBezierPath *firstLinePath = [UIBezierPath new];
    UIBezierPath *secondLinePath = [UIBezierPath new];
    UIBezierPath *thirdLinePath = [UIBezierPath new];

    NSArray *firstCoords = [coordinates firstObject];
    NSArray *secondCoords = [coordinates objectAtIndex:1];
    NSArray *thirdCoords = [coordinates lastObject];

    [self setCoordinatesForLinePath:firstLinePath
                        coordinates:[firstCoords objectAtIndex:self.coordinatesIdx]
                        prevCoordinates:[firstCoords objectAtIndex:self.coordinatesIdx - 1]];
    [self setCoordinatesForLinePath:secondLinePath
                        coordinates:[secondCoords objectAtIndex:self.coordinatesIdx]
                        prevCoordinates:[secondCoords objectAtIndex:self.coordinatesIdx - 1]];
    [self setCoordinatesForLinePath:thirdLinePath
                        coordinates:[thirdCoords objectAtIndex:self.coordinatesIdx]
                        prevCoordinates:[thirdCoords objectAtIndex:self.coordinatesIdx - 1]];

    [self.firstPath appendPath:firstLinePath];
    [self.secondPath appendPath:secondLinePath];
    [self.thirdPath appendPath:thirdLinePath];

    [self strokePaths];

    self.coordinatesIdx++;
}

-(void)normalizeCoordinates: (NSArray *)coordinatesArray {
    __block NSInteger maxCount = [[coordinatesArray firstObject] count];
    [coordinatesArray enumerateObjectsUsingBlock:^(NSMutableArray *arr, NSUInteger idx, BOOL *stop) {
        maxCount = MAX([arr count], maxCount);
    }];
    
    [coordinatesArray enumerateObjectsUsingBlock:^(NSMutableArray *arr, NSUInteger idx, BOOL *stop) {
        while([arr count] != maxCount) {
            [arr addObject:[arr lastObject]];
        }
    }];
    
    self.isCoordinatesNormalized = YES;
}

-(void)setCoordinatesForLinePath:(UIBezierPath *)path coordinates:(NSArray *)coordinates prevCoordinates:(NSArray *)prevCoordinates {
    float xCoord = [[coordinates objectAtIndex:0] floatValue];
    float yCoord = [[coordinates objectAtIndex:1] floatValue];
    float xPrevCoord = [[prevCoordinates objectAtIndex:0] floatValue];
    float yPrevCoord = [[prevCoordinates objectAtIndex:1] floatValue];
    
    [path moveToPoint:CGPointMake(xPrevCoord, yPrevCoord)];
    
    float xDiff = xCoord - xPrevCoord;
    float yDiff = yCoord - yPrevCoord;
    
    if (xDiff > 0 && yDiff > 0) {
        while (xDiff > 0 && yDiff > 0) {
            if (xDiff > 0 && yDiff > 0) {
                xDiff -= 0.25;
                yDiff -= 0.25;
                
                [path addLineToPoint:CGPointMake(xCoord + 0.25, yCoord + 0.25)];
            }
        }
        
        if (yDiff > 0) {
            while(yDiff > 0) {
                yDiff -= 0.25;
                
                [path addLineToPoint:CGPointMake(xCoord, yCoord + 0.25)];
            }
        }
        
        if (xDiff > 0) {
            while(xDiff > 0) {
                xDiff -= 0.25;
                
                [path addLineToPoint:CGPointMake(xCoord + 0.25, yCoord)];
            }
        }
    } else if (xDiff < 0 && yDiff < 0) {
        while(xDiff < 0 && yDiff < 0) {
            xDiff += 0.25;
            yDiff += 0.25;
            
            [path addLineToPoint:CGPointMake(xCoord - 0.25, yCoord - 0.25)];
        }
        
        if (xDiff < 0) {
            while (xDiff < 0) {
                xDiff += 0.25;
                [path addLineToPoint:CGPointMake(xCoord - 0.25, yCoord)];
            }
        }
        
        if (yDiff < 0) {
            while (yDiff < 0) {
                yDiff += 0.25;
                [path addLineToPoint:CGPointMake(xCoord, yCoord - 0.25)];
            }
        }
    } else if (xDiff < 0 && yDiff > 0) {
        while (xDiff < 0 && yDiff > 0) {
            xDiff += 0.25;
            yDiff -= 0.25;
            
            [path addLineToPoint:CGPointMake(xCoord - 0.25, yCoord + 0.25)];
        }
        
        if (xDiff < 0) {
            while (xDiff < 0) {
                xDiff += 0.25;
                
                [path addLineToPoint:CGPointMake(xCoord - 0.25, yCoord)];
            }
        }
        
        if (yDiff > 0) {
            while (yDiff > 0) {
                yDiff -= 0.25;
                
                [path addLineToPoint:CGPointMake(xCoord, yCoord + 0.25)];
            }
        }
    } else if (xDiff > 0 && yDiff < 0) {
        while (xDiff > 0 && yDiff < 0) {
            xDiff -= 0.25;
            yDiff += 0.25;
            
            [path addLineToPoint:CGPointMake(xCoord + 0.25, yCoord - 0.25)];
        }
        
        if (xDiff > 0) {
            while (xDiff > 0) {
                xDiff -= 0.25;
                
                [path addLineToPoint:CGPointMake(xCoord + 0.25, yCoord)];
            }
        }
        
        if (yDiff < 0) {
            while (yDiff < 0) {
                yDiff += 0.25;
                
                [path addLineToPoint:CGPointMake(xCoord, yCoord - 0.25)];
            }
        }
    } else if (xDiff == 0 && yDiff > 0) {
        while (yDiff > 0) {
            yDiff -= 0.25;
            
            [path addLineToPoint:CGPointMake(xCoord, yCoord + 0.25)];
        }
    } else if (xDiff == 0 && yDiff < 0) {
        while (yDiff < 0) {
            yDiff += 0.25;
            
            [path addLineToPoint:CGPointMake(xCoord, yCoord - 0.25)];
        }
    } else if (xDiff > 0 && yDiff == 0) {
        while (xDiff > 0) {
            xDiff -= 0.25;
            
            [path addLineToPoint:CGPointMake(xCoord + 0.25, yCoord)];
        }
    } else if (xDiff < 0 && yDiff == 0) {
        while (xDiff < 0) {
            xDiff += 0.25;
            
            [path addLineToPoint:CGPointMake(xCoord - 0.25, yCoord)];
        }
    } else if (xDiff == 0 && yDiff == 0) {
        [path addLineToPoint:CGPointMake(xCoord, yCoord)];
    }

    NSLog(@"%.2f, %.2f", xDiff, yDiff);
}

-(void)strokePaths {
    UIColor *firstColor = [self.colors firstObject];
    UIColor *secondColor = [self.colors objectAtIndex:1];
    UIColor *thirdColor = [self.colors lastObject];

    [firstColor setStroke];
    [self.firstPath stroke];
    [secondColor setStroke];
    [self.secondPath stroke];
    [thirdColor setStroke];
    [self.thirdPath stroke];
}

-(void)resetPaths {
    [self.firstPath removeAllPoints];
    [self.secondPath removeAllPoints];
    [self.thirdPath removeAllPoints];
    
    self.coordinatesIdx = 1;
    self.reset = NO;
    self.isCoordinatesNormalized = NO;
    self.isDrawingDone = NO;
}

- (UIImage *)takeSnapshot {
    UIGraphicsBeginImageContext(CGSizeMake(self.bounds.size.width, self.bounds.size.height));
    [self drawViewHierarchyInRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

-(void)drawHeadWithColors:(NSArray<UIColor *> *)colors {
//    [firstPath moveToPoint:CGPointMake(55.5, 21)];
//    [firstPath addLineToPoint:CGPointMake(71, 81)];
//    [firstPath addLineToPoint:CGPointMake(83, 104)];
//    [firstPath addLineToPoint:CGPointMake(100.5, 123.5)];
//    [firstPath addLineToPoint:CGPointMake(127.5, 146)];
//    [firstPath addLineToPoint:CGPointMake(151, 151.5)];
//    [firstPath addLineToPoint:CGPointMake(187, 134)];
//    [firstPath addLineToPoint:CGPointMake(214, 104)];
//    [firstPath addLineToPoint:CGPointMake(222.5, 92)];
//    [firstPath addLineToPoint:CGPointMake(224.5, 42.5)];
//    [firstPath addLineToPoint:CGPointMake(212.5, 32.5)];
//    [firstPath addLineToPoint:CGPointMake(196, 35.5)];
//    [firstPath addLineToPoint:CGPointMake(185, 52.5)];
//    [firstPath addLineToPoint:CGPointMake(183, 75.5)];
//    [firstPath addLineToPoint:CGPointMake(187, 88)];
    
    
//    [secondPath moveToPoint:CGPointMake(178, 93)];
//    [secondPath addLineToPoint:CGPointMake(169.5, 91.5)];
//    [secondPath addLineToPoint:CGPointMake(160, 93.5)];
//    [secondPath addLineToPoint:CGPointMake(152, 94.5)];
//    [secondPath addLineToPoint:CGPointMake(142.5, 93.5)];
//    [secondPath addLineToPoint:CGPointMake(134, 92)];
//    [secondPath addLineToPoint:CGPointMake(127.5, 91.5)];
//    [secondPath addLineToPoint:CGPointMake(120, 93)];
//    [secondPath addLineToPoint:CGPointMake(115.5, 95)];
//    [secondPath addLineToPoint:CGPointMake(121.5, 97.5)];
//    [secondPath addLineToPoint:CGPointMake(126, 101)];
//    [secondPath addLineToPoint:CGPointMake(130.5, 106)];
//    [secondPath addLineToPoint:CGPointMake(136.5, 108.5)];
//    [secondPath addLineToPoint:CGPointMake(144, 109.5)];
//    [secondPath addLineToPoint:CGPointMake(151, 108.5)];
//    [secondPath addLineToPoint:CGPointMake(158.5, 109.5)];
//    [secondPath addLineToPoint:CGPointMake(164.5, 108.5)];
//    [secondPath addLineToPoint:CGPointMake(171, 104.5)];
//    [secondPath addLineToPoint:CGPointMake(178, 96.5)];
//    [secondPath addLineToPoint:CGPointMake(182.5, 90.5)];
//    [secondPath addLineToPoint:CGPointMake(174.5, 89.5)];
//    [secondPath addLineToPoint:CGPointMake(165.5, 88.5)];
//    [secondPath addLineToPoint:CGPointMake(156.5, 86.5)];
//    [secondPath addLineToPoint:CGPointMake(148, 86)];
//    [secondPath addLineToPoint:CGPointMake(138, 87.5)];
//    [secondPath addLineToPoint:CGPointMake(129, 89.5)];
//    [secondPath addLineToPoint:CGPointMake(119, 90.5)];
//    [secondPath addLineToPoint:CGPointMake(112, 90)];
//    [secondPath addLineToPoint:CGPointMake(121.5, 84)];
//    [secondPath addLineToPoint:CGPointMake(130.5, 77.5)];
//    [secondPath addLineToPoint:CGPointMake(136.5, 74)];
//    [secondPath addLineToPoint:CGPointMake(141.5, 75.5)];
//    [secondPath addLineToPoint:CGPointMake(147, 77.5)];
//    [secondPath addLineToPoint:CGPointMake(153.5, 76.5)];
//    [secondPath addLineToPoint:CGPointMake(160, 75.5)];
//    [secondPath addLineToPoint:CGPointMake(165.5, 73)];
//    [secondPath addLineToPoint:CGPointMake(168.5, 77.5)];
//    [secondPath addLineToPoint:CGPointMake(173.5, 82.5)];
//    [secondPath addLineToPoint:CGPointMake(181, 87)];
//    [secondColor setStroke];
//    [secondPath stroke];
//
//
//
//    [thirdPath moveToPoint:CGPointMake(182.5, 95.5)];
//    [thirdPath addLineToPoint:CGPointMake(187, 101.5)];
//    [thirdPath addLineToPoint:CGPointMake(189.5, 108)];
//    [thirdPath addLineToPoint:CGPointMake(186, 117)];
//    [thirdPath addLineToPoint:CGPointMake(179, 125.5)];
//    [thirdPath addLineToPoint:CGPointMake(170, 132.5)];
//    [thirdPath addLineToPoint:CGPointMake(160.5, 125.5)];
//    [thirdPath addLineToPoint:CGPointMake(150, 121.5)];
//    [thirdPath addLineToPoint:CGPointMake(140.5, 121.5)];
//    [thirdPath addLineToPoint:CGPointMake(128.5, 125.5)];
//    [thirdPath addLineToPoint:CGPointMake(120.5, 135)];
//    [thirdPath addLineToPoint:CGPointMake(114, 147.5)];
//    [thirdPath addLineToPoint:CGPointMake(102.5, 140.5)];
//    [thirdPath addLineToPoint:CGPointMake(94.5, 130.5)];
//    [thirdPath addLineToPoint:CGPointMake(86, 121.5)];
//    [thirdPath addLineToPoint:CGPointMake(86, 135)];
//    [thirdPath addLineToPoint:CGPointMake(86, 163.5)];
//    [thirdPath addLineToPoint:CGPointMake(86, 180.5)];
//    [thirdPath addLineToPoint:CGPointMake(79, 192)];
//    [thirdPath addLineToPoint:CGPointMake(67.5, 200.5)];
//    [thirdPath addLineToPoint:CGPointMake(56.5, 207.5)];
//    [thirdPath addLineToPoint:CGPointMake(74, 214)];
//    [thirdPath addLineToPoint:CGPointMake(87.5, 222.5)];
//    [thirdPath addLineToPoint:CGPointMake(98, 236.5)];
//    [thirdPath addLineToPoint:CGPointMake(112, 254)];
//    [thirdPath addLineToPoint:CGPointMake(131, 272)];
//    [thirdPath addLineToPoint:CGPointMake(150, 278.5)];
//    [thirdPath addLineToPoint:CGPointMake(164, 278.5)];
//    [thirdPath addLineToPoint:CGPointMake(179, 270.5)];
//    [thirdPath addLineToPoint:CGPointMake(192.5, 254)];
//    [thirdPath addLineToPoint:CGPointMake(202.5, 232.5)];
//    [thirdPath addLineToPoint:CGPointMake(212, 216.5)];
//    [thirdPath addLineToPoint:CGPointMake(226.5, 210)];
//    [thirdPath addLineToPoint:CGPointMake(230, 210)];
//    [thirdPath addLineToPoint:CGPointMake(223.5, 194.5)];
//    [thirdPath addLineToPoint:CGPointMake(214, 166)];
//    [thirdPath addLineToPoint:CGPointMake(212, 143)];
//    [thirdPath addLineToPoint:CGPointMake(212, 119.5)];
//    [thirdPath addLineToPoint:CGPointMake(205, 130.5)];
//    [thirdPath addLineToPoint:CGPointMake(197, 138.5)];
//    [thirdPath addLineToPoint:CGPointMake(189.5, 147.5)];
//    [thirdPath addLineToPoint:CGPointMake(173, 163.5)];
//    [thirdPath addLineToPoint:CGPointMake(163, 178)];
//    [thirdPath addLineToPoint:CGPointMake(154.5, 199.5)];
//    [thirdPath addLineToPoint:CGPointMake(151.5, 225.5)];
//    [thirdPath addLineToPoint:CGPointMake(151.5, 254)];
//    [thirdPath addLineToPoint:CGPointMake(151.5, 272)];
//    [thirdColor setStroke];
//    [thirdPath stroke];
};

@end
