//
//  ViewController.m
//  GOT
//
//  Created by Marek on 03.09.2015.
//  Copyright (c) 2015 Marek Helak. All rights reserved.
//
 
#define getGlobalQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define urlToWikiaGOTCharactersJson @"http://gameofthrones.wikia.com/api/v1/Articles/Top?expand=1&category=Characters&limit=75"

#import "ViewController.h"

@implementation ViewController
 
-(void)viewDidLoad {
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self requestJson];
    [super viewDidLoad];
}
 
-(void)requestJson {
 
    dispatch_async(getGlobalQueue, ^{
        
        //Thread flags
        int connectionTries = 0;
        BOOL isDownloaded = NO;
        
        //Until data will be no downloaded: try iteration 5 times every 1 second
        while (connectionTries++ < 5) {
         
            NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlToWikiaGOTCharactersJson]];
            NSError* error;
            
            if (data) {
                NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
                if (!error){
                
                    characterArray = [[NSMutableArray alloc] init];
                    NSInteger itemsNumber = [json[@"items"] count];
 
                    //Add characters from downloaded json
                    for (int i = 0; i < itemsNumber; i++) {
                        
                        NSString *name = json[@"items"][i][@"title"];
                        NSString *abstract = json[@"items"][i][@"abstract"];
                        CharacterModel *newCharacter = [[CharacterModel alloc] initWithName:name abstract:abstract];
                        [characterArray addObject:newCharacter];
                    }
                    isDownloaded = YES;
                    break;
                    
                } else {
                 [NSThread sleepForTimeInterval:1.0];
                }
            } else {
                [NSThread sleepForTimeInterval:1.0];
            }
        }
 
        if (isDownloaded) {
            [self performSelectorOnMainThread:@selector(updateTableView)withObject:nil waitUntilDone:YES];
        } else {
            [self performSelectorOnMainThread:@selector(showAlert)withObject:nil waitUntilDone:YES];
        }
    });
}

-(void)updateTableView {
    [self.tableView reloadData];
    [self.activityIndicator stopAnimating];
}

-(void)showAlert {
    
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"Connection error"
                                message:@"Retrivitng data failed. Fix your Internet connecton then click \"OK\""
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* requestJson = [UIAlertAction actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction *action) {
                                [self requestJson];
                                }];
    
    [alert addAction:requestJson];
    [self presentViewController:alert animated:true completion:nil];
    
}

#pragma mark - delegates: UITableViewDataSource, UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [characterArray count];
}
 
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell Identifier"];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:@"Cell Identifier"];
    }
 
    if (![characterArray count] == 0) {
        CharacterModel *character = characterArray[indexPath.row];
        cell.textLabel.text = character.name;
        cell.detailTextLabel.text = character.abstract;
    }
 
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView.backgroundColor = [UIColor clearColor];
 
    return cell;
}
 
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
     return 1;
}
 
-(void)didReceiveMemoryWarning {
    // Dispose of any resources that can be recreated.
    [super didReceiveMemoryWarning];
}
 
@end
