//
//  ViewController.m
//  FirstProject
//
//  Created by 李辉 on 16/2/16.
//  Copyright © 2016年 Sid Lee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    int currentValue;
    int targetValue;
    int score;
    int round;
}
@property (strong, nonatomic) IBOutlet UILabel *targetLabel;

- (IBAction)sliderMoved:(id)sender;
@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UILabel *scoreLab;
@property (strong, nonatomic) IBOutlet UILabel *roundLab;

@end

@implementation ViewController
@synthesize slider;
@synthesize targetLabel;
@synthesize scoreLab;
@synthesize roundLab;

-(void)updateLabels{
    self.targetLabel.text = [NSString stringWithFormat:@"%d",targetValue];
    self.scoreLab.text = [NSString stringWithFormat:@"%d",score];
    self.roundLab.text = [NSString stringWithFormat:@"%d",round];
}

-(void)startNewRound{
    targetValue = 1+(arc4random()%100);
    currentValue = 50;
    self.slider.value = currentValue;
    round ++;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self startNewRound];
    [self updateLabels];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sliderMoved:(id)sender {
    UISlider *slider = (UISlider*)sender;
    currentValue = (int)lround(slider.value);
}

- (IBAction)showAlert:(id)sender {
    int difference = abs(currentValue - targetValue);
    int point = 100 -difference;
    score +=point;
    
    NSString *message = [NSString stringWithFormat:@"now:%d,target:%d,difference:%d",currentValue,targetValue,difference];
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Title"
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Again"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    //Handel your yes please button action here
                                    [self startNewRound];
                                    [self updateLabels];
                                    
                                    
                                }];
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"Reset"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   //Handel no, thanks button
                                   score  = 0;
                                   round =0;
                                   [self startNewRound];
                                   [self updateLabels];
                                   
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}
- (IBAction)resetButton:(id)sender {
    score = 0;
    round = 0;
    [self startNewRound];
    [self updateLabels];
}


@end
