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
            @"Landscape": @[
                [NSMutableArray arrayWithArray:@[
                    @[@98.5, @150, @YES],
                    @[@100.5, @156.5],
                    @[@101.5, @167.5],
                    @[@99, @186],
                    @[@95.5, @203.5],
                    @[@96, @213],
                    @[@99, @221],
                    @[@103.5, @221, @YES],
                    @[@104.5, @209.5],
                    @[@105.5, @205.5],
                    @[@104.5, @193.5, @YES],
                    @[@103.5, @185.5],
                    @[@102.5, @178],
                    @[@111, @172.5, @YES],
                    @[@113, @180.5],
                    @[@114.5, @191],
                    @[@116, @181.5, @YES],
                    @[@116.5, @187.5],
                    @[@119, @196.5],
                    @[@121.5, @202.5],
                    @[@120, @191, @YES],
                    @[@120.5, @195.5],
                    @[@124, @201.5],
                    @[@133, @179, @YES],
                    @[@134, @186],
                    @[@135.5, @193],
                    @[@138, @198.5],
                    @[@141.5, @200, @YES],
                    @[@138.5, @194],
                    @[@137, @189],
                    @[@136.5, @184],
                    @[@134, @193, @YES],
                    @[@132, @187],
                    @[@131, @181],
                    @[@130.5, @173],
                    @[@131, @166],
                    @[@74, @155.5, @YES],
                    @[@71.5, @163],
                    @[@70.5, @170],
                    @[@70.5, @178],
                    @[@68.5, @172.5, @YES],
                    @[@69, @164.5],
                    @[@71.5, @155.5],
                    @[@75, @148],
                    @[@77.5, @137, @YES],
                    @[@73.5, @143],
                    @[@70.5, @149],
                    @[@33.5, @178, @YES],
                    @[@31.5, @186],
                    @[@28.5, @193.5],
                    @[@25.5, @199],
                    @[@36.5, @178, @YES],
                    @[@34.5, @185.5],
                    @[@31, @194.5],
                    @[@38, @170, @YES],
                    @[@37, @175.5],
                    @[@51.5, @156.5, @YES],
                    @[@49, @166],
                    @[@50.5, @169, @YES],
                    @[@49, @175.5],
                    @[@48.5, @183],
                    @[@47.5, @171.5, @YES],
                    @[@46.5, @181],
                    @[@57.5, @184, @YES],
                    @[@58, @190],
                    @[@59.5, @191, @YES],
                    @[@59.5, @205.5],
                    @[@75, @171.5, @YES],
                    @[@75.5, @182.5],
                    @[@76.5, @191],
                    @[@186.5, @138, @YES],
                    @[@187, @142.5],
                    @[@189.5, @149],
                    @[@190.04, @151.5],
                    @[@189.5, @163.5, @YES],
                    @[@191, @156],
                    @[@190.04, @151.5],
                    @[@191, @137.5, @YES],
                    @[@190.5, @143.5],
                    @[@190.04, @151.5],
                    @[@202.5, @130.5, @YES],
                    @[@200.5, @138],
                    @[@198.5, @145.5],
                    @[@221, @141, @YES],
                    @[@222.5, @150.5],
                    @[@228.5, @163.5],
                    @[@200.5, @185.5, @YES],
                    @[@205, @193],
                    @[@210, @198.5],
                    @[@198.5, @199, @YES],
                    @[@193, @195.5],
                    @[@248.5, @148, @YES],
                    @[@248.5, @151.5],
                    @[@253, @150.5, @YES],
                    @[@253, @155.5],
                    @[@255.5, @159.5],
                    @[@114.5, @133, @YES],
                    @[@116.5, @142.5],
                    @[@121.5, @145.5],
                    @[@124, @151.5],
                    @[@214, @113.5, @YES],
                    @[@216, @117],
                    @[@216, @121],
                    @[@210, @119.5, @YES],
                    @[@208.5, @129.5],
                    @[@218.5, @193, @YES],
                    @[@221, @194.5],
                    @[@226, @196.5],
                    @[@234.5, @203.5],
                    @[@154.5, @171.5, @YES],
                    @[@157, @178],
                    @[@163.5, @185.5],
                ]],
                [NSMutableArray arrayWithArray:@[
                    @[@30.5, @209.5, @YES],
                    @[@45, @209.5],
                    @[@59, @206],
                    @[@76.5, @196.5],
                    @[@93.5, @191.5],
                    @[@109.5, @198],
                    @[@122.25, @203.75],
                    @[@135, @209.5, @YES],
                    @[@122.25, @203.75],
                    @[@122.25, @203.75, @YES],
                    @[@135, @200],
                    @[@145, @201.5],
                    @[@154.5, @203.75],
                    @[@168, @206],
                    @[@190, @213.5],
                    @[@180.5, @216, @YES],
                    @[@193, @213.5],
                    @[@203.5, @208],
                    @[@217.5, @208],
                    @[@232, @208],
                    @[@252, @203.75],
                    @[@51.5, @237.5, @YES],
                    @[@65.5, @237.5],
                    @[@82.5, @234],
                    @[@99.5, @237.5],
                    @[@124, @240.5],
                    @[@168, @245],
                    @[@135, @254.5, @YES],
                    @[@158.5, @248.5],
                    @[@180.5, @237.5],
                    @[@193, @231],
                    @[@211.5, @231],
                    @[@233.5, @231],
                    @[@81, @261, @YES],
                    @[@93.5, @258.5],
                    @[@118, @261],
                    @[@146, @262],
                    @[@168, @262],
                    @[@190, @254.5],
                    @[@213, @252],
                ]],
                [NSMutableArray arrayWithArray:@[
                    @[@245, @125, @YES],
                    @[@251.5, @134.5],
                    @[@264, @147],
                    @[@263, @130.5],
                    @[@260.5, @115],
                    @[@255.5, @101.5],
                    @[@251.5, @93],
                    @[@247.5, @85.5],
                    @[@241.5, @77],
                    @[@236.5, @76.5],
                    @[@234, @76.5],
                    @[@230, @77],
                    @[@226, @78.5],
                    @[@222.5, @76.5],
                    @[@219.5, @75.5],
                    @[@215.5, @76.5],
                    @[@210.5, @76.5],
                    @[@206, @78.5],
                    @[@203, @77],
                    @[@199, @75.5],
                    @[@195, @75.5],
                    @[@188, @75.5],
                    @[@181.5, @75.5],
                    @[@178.5, @77],
                    @[@172, @75.5],
                    @[@166, @75.5],
                    @[@162, @74.5],
                    @[@156.5, @76.5],
                    @[@153, @74.5],
                    @[@146, @74.5],
                    @[@151.5, @73],
                    @[@155, @70],
                    @[@156.5, @68],
                    @[@159.5, @65.5],
                    @[@162, @62],
                    @[@166, @62],
                    @[@173.5, @62],
                    @[@179, @62],
                    @[@184, @59],
                    @[@186, @55],
                    @[@192.5, @54],
                    @[@196, @56.5],
                    @[@200, @55],
                    @[@204, @56.5],
                    @[@206, @52.5],
                    @[@210.5, @50.5],
                    @[@216.5, @50.5],
                    @[@206, @43],
                    @[@192.5, @35.5],
                    @[@175, @28.5],
                    @[@155, @24.5],
                    @[@139.5, @23.5],
                    @[@122.5, @24.5],
                    @[@106, @27],
                    @[@93, @32],
                    @[@81.5, @37],
                    @[@87, @40],
                    @[@91, @44],
                    @[@94, @49.5],
                    @[@94.5, @55],
                    @[@91, @63],
                    @[@85.5, @68],
                    @[@81.5, @70],
                    @[@77, @70],
                    @[@70, @67],
                    @[@65, @63],
                    @[@61.5, @56.5],
                    @[@61.5, @50.5],
                    @[@49, @61.5],
                    @[@40.5, @71.5],
                    @[@33, @83],
                    @[@27.5, @94],
                    @[@26, @100],
                    @[@29.5, @100],
                    @[@33, @99],
                    @[@39.5, @103],
                    @[@45.5, @103],
                    @[@51.5, @108],
                    @[@55, @107],
                    @[@60, @109.5],
                    @[@57.5, @110.5],
                    @[@51.5, @112],
                    @[@46.5, @111],
                    @[@44.5, @112],
                    @[@40.5, @112],
                    @[@37.5, @112],
                    @[@35.5, @114],
                    @[@33.5, @113],
                    @[@31.5, @113],
                    @[@26, @110.5],
                    @[@20.5, @113],
                    @[@18, @121.5],
                    @[@16, @147.5],
                    @[@20.5, @177.5],
                    @[@27.5, @170.5],
                    @[@33, @166.5],
                    @[@44.5, @154],
                    @[@55, @142.5],
                    @[@245, @125, @YES],
                    @[@234, @130.5],
                    @[@245, @125, @YES],
                    @[@243.17, @134.5],
                    @[@243.17, @146],
                    @[@234, @130.5, @YES],
                    @[@222.5, @107],
                    @[@214, @99.5],
                    @[@206, @109.5],
                    @[@195, @122],
                    @[@190.5, @119.5],
                    @[@173.5, @137.5],
                    @[@159.5, @158],
                    @[@234, @130.5, @YES],
                    @[@238, @137.5],
                    @[@243.17, @146],
                    @[@159.5, @158, @YES],
                    @[@151.5, @149],
                    @[@131, @129],
                    @[@123.5, @109.5],
                    @[@119, @109.5],
                    @[@112.5, @99.5],
                    @[@159.5, @158, @YES],
                    @[@159.5, @160.5],
                    @[@163, @164],
                    @[@170.25, @171.25],
                    @[@112.5, @99.5, @YES],
                    @[@101, @108],
                    @[@97.5, @115],
                    @[@86.5, @127.5],
                    @[@80.5, @125],
                    @[@112.5, @99.5, @YES],
                    @[@108.5, @107],
                    @[@107, @115],
                    @[@80.5, @125, @YES],
                    @[@65, @145],
                    @[@55, @142.5],
                    @[@80.5, @125, @YES],
                    @[@80.5, @137.5],
                    @[@82.5, @149],
                    @[@55, @142.5, @YES],
                    @[@58.5, @148.5],
                    @[@60, @155.5],
                    @[@60, @165],
                    @[@65, @174.5],
                    @[@177.5, @178.5, @YES],
                    @[@170.25, @171.25],
                    @[@254.5, @166, @YES],
                    @[@245, @149],
                    @[@243.17, @146],
                    @[@170.25, @171.25, @YES],
                    @[@184, @166.5],
                    @[@185.16, @168],
                    @[@192.5, @177.5, @YES],
                    @[@185.16, @168],
                    @[@185.16, @168, @YES],
                    @[@192.5, @165],
                    @[@199, @168],
                    @[@209, @174.5],
                    @[@219.5, @178.5],
                    @[@228, @185.5],
                    @[@234, @187],
                    @[@249.5, @199],
                    @[@104, @140, @YES],
                    @[@104, @131.5],
                    @[@105.5, @122],
                ]]
            ],
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
                        prevCoordinates:[firstCoords objectAtIndex:self.coordinatesIdx - 1]
                        justMoveTo:[[firstCoords objectAtIndex:self.coordinatesIdx] count] == 3];
    [self setCoordinatesForLinePath:secondLinePath
                        coordinates:[secondCoords objectAtIndex:self.coordinatesIdx]
                        prevCoordinates:[secondCoords objectAtIndex:self.coordinatesIdx - 1]
                        justMoveTo:[[secondCoords objectAtIndex:self.coordinatesIdx] count] == 3];
    [self setCoordinatesForLinePath:thirdLinePath
                        coordinates:[thirdCoords objectAtIndex:self.coordinatesIdx]
                        prevCoordinates:[thirdCoords objectAtIndex:self.coordinatesIdx - 1]
                        justMoveTo:[[thirdCoords objectAtIndex:self.coordinatesIdx] count] == 3];

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

-(void)setCoordinatesForLinePath:(UIBezierPath *)path coordinates:(NSArray *)coordinates prevCoordinates:(NSArray *)prevCoordinates justMoveTo:(BOOL)justMoveTo {
    float xCoord = [[coordinates objectAtIndex:0] floatValue];
    float yCoord = [[coordinates objectAtIndex:1] floatValue];
    float xPrevCoord = [[prevCoordinates objectAtIndex:0] floatValue];
    float yPrevCoord = [[prevCoordinates objectAtIndex:1] floatValue];
    
    [path moveToPoint:CGPointMake(xPrevCoord, yPrevCoord)];
    
    if (justMoveTo) {
        return;
    }
    [path addLineToPoint:CGPointMake(xCoord, yCoord)];
//    float xDiff = xCoord - xPrevCoord;
//    float yDiff = yCoord - yPrevCoord;
//
//    float increment = 0.05;
//
//    if (xDiff > 0 && yDiff > 0) {
//        while (xDiff > 0 && yDiff > 0) {
//            if (xDiff > 0 && yDiff > 0) {
//                xDiff -= increment;
//                yDiff -= increment;
//
//                [path addLineToPoint:CGPointMake(xCoord + increment, yCoord + increment)];
//            }
//        }
//
//        if (yDiff > 0) {
//            while(yDiff > 0) {
//                yDiff -= increment;
//
//                [path addLineToPoint:CGPointMake(xCoord, yCoord + increment)];
//            }
//        }
//
//        if (xDiff > 0) {
//            while(xDiff > 0) {
//                xDiff -= increment;
//
//                [path addLineToPoint:CGPointMake(xCoord + increment, yCoord)];
//            }
//        }
//    } else if (xDiff < 0 && yDiff < 0) {
//        while(xDiff < 0 && yDiff < 0) {
//            xDiff += increment;
//            yDiff += increment;
//
//            [path addLineToPoint:CGPointMake(xCoord - increment, yCoord - increment)];
//        }
//
//        if (xDiff < 0) {
//            while (xDiff < 0) {
//                xDiff += increment;
//                [path addLineToPoint:CGPointMake(xCoord - increment, yCoord)];
//            }
//        }
//
//        if (yDiff < 0) {
//            while (yDiff < 0) {
//                yDiff += increment;
//                [path addLineToPoint:CGPointMake(xCoord, yCoord - increment)];
//            }
//        }
//    } else if (xDiff < 0 && yDiff > 0) {
//        while (xDiff < 0 && yDiff > 0) {
//            xDiff += increment;
//            yDiff -= increment;
//
//            [path addLineToPoint:CGPointMake(xCoord - increment, yCoord + increment)];
//        }
//
//        if (xDiff < 0) {
//            while (xDiff < 0) {
//                xDiff += increment;
//
//                [path addLineToPoint:CGPointMake(xCoord - increment, yCoord)];
//            }
//        }
//
//        if (yDiff > 0) {
//            while (yDiff > 0) {
//                yDiff -= increment;
//
//                [path addLineToPoint:CGPointMake(xCoord, yCoord + increment)];
//            }
//        }
//    } else if (xDiff > 0 && yDiff < 0) {
//        while (xDiff > 0 && yDiff < 0) {
//            xDiff -= increment;
//            yDiff += increment;
//
//            [path addLineToPoint:CGPointMake(xCoord + increment, yCoord - increment)];
//        }
//
//        if (xDiff > 0) {
//            while (xDiff > 0) {
//                xDiff -= increment;
//
//                [path addLineToPoint:CGPointMake(xCoord + increment, yCoord)];
//            }
//        }
//
//        if (yDiff < 0) {
//            while (yDiff < 0) {
//                yDiff += increment;
//
//                [path addLineToPoint:CGPointMake(xCoord, yCoord - increment)];
//            }
//        }
//    } else if (xDiff == 0 && yDiff > 0) {
//        while (yDiff > 0) {
//            yDiff -= increment;
//
//            [path addLineToPoint:CGPointMake(xCoord, yCoord + increment)];
//        }
//    } else if (xDiff == 0 && yDiff < 0) {
//        while (yDiff < 0) {
//            yDiff += increment;
//
//            [path addLineToPoint:CGPointMake(xCoord, yCoord - increment)];
//        }
//    } else if (xDiff > 0 && yDiff == 0) {
//        while (xDiff > 0) {
//            xDiff -= increment;
//
//            [path addLineToPoint:CGPointMake(xCoord + increment, yCoord)];
//        }
//    } else if (xDiff < 0 && yDiff == 0) {
//        while (xDiff < 0) {
//            xDiff += increment;
//
//            [path addLineToPoint:CGPointMake(xCoord - increment, yCoord)];
//        }
//    } else {
//        [path addLineToPoint:CGPointMake(xCoord, yCoord)];
//    }
    
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

@end
