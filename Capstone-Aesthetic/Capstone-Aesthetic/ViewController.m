//
//  ViewController.m
//  Capstone-Aesthetic
//
//  Created by Eric Rhodes on 9/12/18.
//  Copyright © 2018 Eric Rhodes. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableArray* array1;
    NSString* currentPicture;
    int currentPictureIndex;
    
    int minIndex;
    int maxIndex;
    
    
    NSMutableArray* newArray;
    int minIndexSecondSet;
    int maxIndexSecondSet;
    
    int currentSecondPictureIndex;
    NSString* currentSecondPicture;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [_spinner setHidden:true];
    
    maxIndex = 9;
    minIndex = 0;
    
    array1 = [NSMutableArray arrayWithObjects:@"city 2.jpg",@"city 3.jpg",@"city1.jpg",@"greenhouse.jpg",@"greenhouse 2.jpg",@"greenhouse 3.jpg",@"retro 1.jpg",@"retro 2.jpg",@"skull.jpg",@"skull2.jpg",nil];
    
    currentPictureIndex = 0;
    currentPicture = array1[currentPictureIndex];
    UIImage* image = [UIImage imageNamed:currentPicture];

    [_imageView setImage:image];
    
    NSLog(@"%@",currentPicture);
    
    for (NSString *s in array1) {
        NSLog(@"%@",s);
        
    }
}

- (IBAction)nextPictureButtonPressed:(id)sender {
    //currentPictureIndex ++;
    if((currentPictureIndex + 1) > maxIndex)
    {
        //Dont do anything
        
    }else{
        currentPictureIndex++;
        currentPicture = array1[currentPictureIndex];
        UIImage* image = [UIImage imageNamed:currentPicture];
        [_imageView setImage:image];
        
    }
}

- (IBAction)prevPictureButtonPressed:(id)sender {
    if((currentPictureIndex - 1) < minIndex)
    {
        //Dont do anything
        
    }else{
        currentPictureIndex--;
        currentPicture = array1[currentPictureIndex];
        UIImage* image = [UIImage imageNamed:currentPicture];
        [_imageView setImage:image];
        
    }
}


- (IBAction)submitButtonPressed:(id)sender {
    //send request
    [self sendPost:currentPictureIndex];
    [_spinner setHidden:false];
    [_spinner startAnimating];
}


//Send post
-(void)sendPost: (int)currentIndex
{
    NSString* picture_withExtension = array1[currentIndex];
    NSArray* arr = [picture_withExtension componentsSeparatedByString:@"."];
    NSString* picture_withSpace = arr[0];
    NSString* picture = [picture_withSpace stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

    NSLog(@"Picture: %@", picture);
    
    
    //Can change the post data next
    NSString *post = [NSString stringWithFormat:@""];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //[request setURL:[NSURL URLWithString:@"https://erhodes.oucreate.com/Cows/test.php"]];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://erhodes.oucreate.com/Capstone/aesthetic.php?main=%@",picture]]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    //[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(conn) {
        NSLog(@"Connection Successful");
    } else {
        NSLog(@"Connection could not be made");
    }
    
}

// This method is used to receive the data which we get using post method.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data
{
    
    //NSLog(@"%@");
    //Converts the data
    NSString *someString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];

    NSLog(@"%@",someString);
    [_similarities setText:someString];
    
    
    
    //Second
    
    //maxIndex = 9;
    //minIndex = 0;
    
    newArray = [someString componentsSeparatedByString:@","];
    
    int count = 0;
    for (NSString* s in newArray) {
        NSLog(@"%@",s);
        count++;
    }
    
    
    NSLog(@"Size %i", count);
    
    minIndexSecondSet = 0;
    maxIndexSecondSet = count-1;
    
    currentSecondPictureIndex = 0;
    currentSecondPicture = newArray[currentSecondPictureIndex];
    UIImage* image = [UIImage imageNamed:currentSecondPicture];
    
    [_secondImageView setImage:image];
    
    
    
    
}

//
- (IBAction)rightButtonPressed:(id)sender {
    if((currentSecondPictureIndex + 1) > maxIndexSecondSet)
    {
        //Dont do anything
        
    }else{
        currentSecondPictureIndex++;
        currentSecondPicture = newArray[currentSecondPictureIndex];
        UIImage* image = [UIImage imageNamed:currentSecondPicture];
        [_secondImageView setImage:image];
        
    }
    
}

- (IBAction)leftButtonPressed:(id)sender {
    if((currentSecondPictureIndex - 1) < minIndexSecondSet)
    {
        //Dont do anything
        
    }else{
        currentSecondPictureIndex--;
        currentSecondPicture = newArray[currentSecondPictureIndex];
        UIImage* image = [UIImage imageNamed:currentSecondPicture];
        [_secondImageView setImage:image];
        
    }
    
}






// This method receives the error report in case of connection is not made to server.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    
}

// This method is used to process the data after connection has made successfully.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [_spinner setHidden:true];
    [_spinner stopAnimating];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}


@end
