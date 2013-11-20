//
//  RTViewController.m
//  Race to the Top
//
//  Created by Dominik Butz on 18.11.13.
//  Copyright (c) 2013 Code Coalition. All rights reserved.
//

#import "RTViewController.h"
#import "RTPathView.h"
#import "RTMountainPath.h"

#define RTMAP_STARTING_SCORE 15000
#define RTMAP_SCORE_DECREMENT_AMOUNT 100
#define RT_TIMER_INTERVAL 0.1
#define RT_WALL_PENALTY 500

@interface RTViewController ()

//create private property (hooked up from storyboard!), other class objects don't need to access it, therefore in .m-file!
@property (strong, nonatomic) IBOutlet RTPathView *pathView;
@property (strong, nonatomic) NSTimer *timer;


@end

@implementation RTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    //create a gesture recognizer object - note similarity with addTarget-method called on a UIbutton object! selector: method needs colon (:) because parameter needs to be passed in! Method implemented below.
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapDetected:)];
    tapRecognizer.numberOfTapsRequired = 2;
    // the tapRecognizer object needs to be added to the pathView
    [self.pathView addGestureRecognizer:tapRecognizer];
    
    //however, we don't want to detect taps but the user's finger movement on the screen (that is on the pathView:
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panDetected:)];
    [self.pathView addGestureRecognizer:panRecognizer];
    
    
    
   
    
    
}

-(void)tapDetected:(UIGestureRecognizer*)tapRecognizer{
    
    NSLog(@"Tapped!");
    CGPoint tapLocation = [tapRecognizer locationInView:self.pathView];
    NSLog(@"tap location is at %f %f", tapLocation.x, tapLocation.y);
    
}

-(void)panDetected: (UIPanGestureRecognizer*)panRecognizer {
    
    //locationinview method  returns the current location of the finger as CGpoint
    CGPoint fingerLocation = [panRecognizer locationInView:self.pathView];
    // need to detect if finger was put on the screen and if it was put (roughly) into the small area at the start of the path
    if (panRecognizer.state == UIGestureRecognizerStateBegan && fingerLocation.y > 710 && fingerLocation.x >130 && fingerLocation.x < 215) {
        
        //need a timer to track the time the user has the finger on the screen(see property in header of this .m-file). Timer only starts firing when the finger is put onto the bottom of the screen

        self.timer = [NSTimer scheduledTimerWithTimeInterval:RT_TIMER_INTERVAL target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
        // label only displays starting score when the user puts his finger on the bottom screen:
         self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", RTMAP_STARTING_SCORE];
    }
    
    else if (panRecognizer.state == UIGestureRecognizerStateChanged){
        
        for (UIBezierPath *path in [RTMountainPath mountainPathsForRect:self.pathView.bounds]) {
            
            //call class method TapTargetForPath passing in each path from the array, save returned BezierPath in new variable
            UIBezierPath *tapTarget = [RTMountainPath tapTargetForPath:path];
            // call containsPoint method on the tapTarget (check if finger is on the path or not)
            if ([tapTarget containsPoint:fingerLocation]) {
                // if path is touched, score is decremented by defined amount:
                [self decrementScoreByAmount:RT_WALL_PENALTY];
                
            }
            
        }
        
    }
    
    else if (panRecognizer.state == UIGestureRecognizerStateEnded && fingerLocation.y <= 165){
        
        [self.timer invalidate];
        self.timer = nil;
        
        
    }
    
    else {
        // else meaning: user lifted finger to early or didn't start at the bottom
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Make sure to start at the bottom and hold your finger down and finish at the top!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        // also need to invalidate timer and deallocated it:
        [self.timer invalidate];
        self.timer = nil;
        
    }
    
    //take paths saved in the class method mountainPathsForRect by passing in the bounds of the pathView (whole ipad screen)
   
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)timerFired{
    //every time the timer fires call decrementScore-method below and pass in the decrement amount defined in the header:
    [self decrementScoreByAmount:RTMAP_SCORE_DECREMENT_AMOUNT];
}

-(void)decrementScoreByAmount:(int)amount{
    
    //componentsSeparatedByString method returns an array of strings from one string - call last object on the method to return the last string object.
    NSString *scoreAsText = [[self.scoreLabel.text componentsSeparatedByString:@" "]lastObject];
    
    //convert the extracted score to int:
    int score = [scoreAsText integerValue];
    
    //decrement score by amount passed into this method:
    score = score - amount;
    
    //update label with decremented score:
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", score];
    
}

@end
