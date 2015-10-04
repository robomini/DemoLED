//
//  ViewController.m
//  DemoLED
//
//  Created by TienVV on 10/4/15.
//  Copyright (c) 2015 TienVV. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtNumberOfBallPerRow;
@property (weak, nonatomic) IBOutlet UIButton *btnDraw;
@end

@implementation ViewController
{
    float _screenWitdh;
    float _screenHeight;
    
    float _positionX;
    float _positionY;
    
    float _ballRadius;
    int _margin; // Margin of First ball or Last ball to screen
    float _space; // Space beetween two ball center
    int _numberOfBallPerRow;
    
    int _tagStart;
    int _tagEnd;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Get screen size of device
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    _screenWitdh = screenRect.size.width;
    _screenHeight = screenRect.size.height;
    
    // Initiate context variable
    UIImage* ballImage = [UIImage imageNamed:@"led_green"];
    _ballRadius = ballImage.size.width / 2;
    _margin = 40;
    
    _numberOfBallPerRow = [_txtNumberOfBallPerRow.text intValue];
    _space = (_screenWitdh - 2 * _margin) / (_numberOfBallPerRow - 1);
    
    NSLog(@"Number Ball Per Row: %d, Margin: %d, Space: %3.1f", _numberOfBallPerRow, _margin, _space);
    // Draw ball
    [self drawBall];
}

- (IBAction)onClickBtnDraw:(id)sender {
    // Remove all current ball
    [self removeAllBall];
    
    // Initiate context variable
    _numberOfBallPerRow = [_txtNumberOfBallPerRow.text intValue];
    _space = (_screenWitdh - 2 * _margin) / (_numberOfBallPerRow - 1);
    // Check number of ball.
    // Number of ball per row must be at least 3
    if (_numberOfBallPerRow < 3) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Number of ball per row must be at least 3." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        // Set default number of ball per row is 3
        _numberOfBallPerRow = 3;
        _space = (_screenWitdh - 2 * _margin) / (_numberOfBallPerRow - 1);
        _txtNumberOfBallPerRow.text = @"3";
    }
    
    // Draw all ball
    [self drawBall];
}

- (void) drawBall {
    // Initiate first position of first row
    _positionX = _margin;
    _positionY = _btnDraw.center.y + _btnDraw.bounds.size.height / 2 + _ballRadius + 20;
    // Initiate tag
    _tagStart = 100;
    _tagEnd = _tagStart - 1;
    NSLog(@"BallPerRow: %d, PosX: %3.1f, PosY: %3.1f", _numberOfBallPerRow, _positionX, _positionY);
    // Number of row is decided by screen height
    do {
        // Draw each row
        for (int i = 0; i < _numberOfBallPerRow; i++) {
            _positionX = _margin + i * _space;
            _tagEnd++;
            [self drawGreenBallAtX:_positionX andY:_positionY withTag:_tagEnd];
        }
        _positionY = _positionY + 2 * _ballRadius + 20;
    } while (_positionY < _screenHeight - _ballRadius);
}

- (void) drawGreenBallAtX: (CGFloat) x
                andY: (CGFloat) y
             withTag: (int) tag {
    UIImageView* imgBall = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"led_green"]];
    imgBall.center = CGPointMake(x, y);
    imgBall.tag = tag;
    
    [self.view addSubview:imgBall];
}

- (void) removeAllBall {
    for (int i = _tagStart; i <= _tagEnd; i++) {
        UIView* view = [self.view viewWithTag:i];
        // Remove view from super view
        [view removeFromSuperview];
    }
}

@end
