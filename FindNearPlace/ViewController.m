//
//  ViewController.m
//  FindNearPlace
//
//  Created by Sabertooth on 07/01/18.
//  Copyright © 2018 Sabertooth All rights reserved.
//

#import "ViewController.h"
#import "MapViewCtrl.h"
#import "DetailMapViewCtrl.h"
@implementation ViewController
@synthesize m_searchNearBy;
@synthesize m_nearByPlace;
@synthesize m_PlacesData;
@synthesize m_tableView;
@synthesize m_comBox;
@synthesize m_type;
@synthesize m_index;

- (void)viewDidLoad {
    m_mapDictionary = [[NSMutableDictionary alloc] init];
    m_PlacesData = [[NSMutableArray alloc] init];
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


-(void)InitComList{
    
    [m_mapDictionary setObject:@"atm" forKey:@"ATM"];
    [m_mapDictionary setObject:@"airport" forKey:@"AIRPORT"];
    [m_mapDictionary setObject:@"bank" forKey:@"BANK"];
    [m_mapDictionary setObject:@"bar" forKey:@"BAR"];
    [m_mapDictionary setObject:@"cafe" forKey:@"CAFE"];
    [m_mapDictionary setObject:@"doctor" forKey:@"DOCTOR"];
    [m_mapDictionary setObject:@"hardware_store" forKey:@"HARDWARE STORE"];
    [m_mapDictionary setObject:@"hospital" forKey:@"HOSPITAL"];
    [m_mapDictionary setObject:@"library" forKey:@"LIBRARY"];
    [m_mapDictionary setObject:@"lodging" forKey:@"LODGING"];
    [m_mapDictionary setObject:@"pharmacy" forKey:@"PHARMACY"];
    [m_mapDictionary setObject:@"police" forKey:@"POLICE STATION"];
    [m_mapDictionary setObject:@"school" forKey:@"SCHOOL"];
    [m_mapDictionary setObject:@"restaurant" forKey:@"RESTAURANT"];
    [m_mapDictionary setObject:@"movie_theater" forKey:@"MOVIE THEATER"];
    [m_mapDictionary setObject:@"stadium" forKey:@"STADIUM"];
    
    [m_comBox addItemsWithObjectValues:[m_mapDictionary allKeys]];
    [m_comBox setEditable:FALSE];
    m_comBox.highlighted = false;
    [m_comBox selectItemAtIndex:1];
    [m_comBox reloadData];
    m_type = [[m_comBox objectValues] objectAtIndex:1];
}


-(void)awakeFromNib{
    
     DetailMapViewCtrl *DetailMapCtrl = [[NSStoryboard storyboardWithName:@"Main" bundle:nil] instantiateControllerWithIdentifier:@"DetailMapCtrl"];
    [self addChildViewController:DetailMapCtrl];
    
    [m_tableView setDelegate:self];
    [m_tableView setDataSource:self];
    m_tableView.intercellSpacing = NSMakeSize(1, 5);
    [m_tableView setBackgroundColor:[NSColor lightGrayColor]];
    [self InitComList];
    
    [[m_tableView tableColumnWithIdentifier:@"ColumnID"] setTitle:m_type];
    [self SearchNearBy:nil];
    [m_tableView reloadData];
    
}


-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    NSUInteger count = [m_PlacesData count];
    return count;
}


- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    
    return 140;
}


- (NSIndexSet *)tableView:(NSTableView *)tableView selectionIndexesForProposedSelection:(NSIndexSet *)proposedSelectionIndexes{
    
    m_index = [proposedSelectionIndexes firstIndex];
    
    return proposedSelectionIndexes;
}



-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    NSDictionary *infoDict;
    NSView *result = [tableView makeViewWithIdentifier:@"MyView" owner:self];
    infoDict = [m_PlacesData objectAtIndex:row];
    
    NSTextField *location =[result viewWithTag:700];
    [location setStringValue:[infoDict objectForKey:@"location"]];
    
    NSImageView *opennow =[result viewWithTag:800];
    NSString *yesno = [infoDict objectForKey:@"open_now"];
    
    if ([yesno isEqualToString:@"0"])
        [opennow setImage:[NSImage imageNamed: NSImageNameStatusAvailable]];
    else
        [opennow setImage:[NSImage imageNamed: NSImageNameStatusUnavailable]];
    
    NSTextField *vicinity =[result viewWithTag:900];
    [vicinity setStringValue:[infoDict objectForKey:@"vicinity"]];
    
    NSTextField *name =[result viewWithTag:1000];
    [name setStringValue:[infoDict objectForKey:@"name"]];
    
    NSImageView *imageView =[result viewWithTag:1100];
    NSString *url = [infoDict objectForKey:@"icon"];
    NSImage *image = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
    if (image) {
        [imageView setImage:image];
    }
    
    NSTextField *distTime =[result viewWithTag:1400];
    NSString *distance = [infoDict objectForKey:@"distTime"];
    if (distance)
        [distTime setStringValue:distance];
    else
        [distTime setStringValue:@""];
    
    
    NSLevelIndicator *Indicator =[result viewWithTag:1500];
    long int intgervalue = [[infoDict objectForKey:@"rating"] integerValue];
    [Indicator setDoubleValue:intgervalue];
  
    return result;
}


-(void)prepareForSegue:(NSStoryboardSegue *)segue sender:(id)sender{
    NSViewController *ctrl =  segue.destinationController;
    if ([ctrl isKindOfClass:[MapViewCtrl class]]) {
        [(MapViewCtrl *)ctrl setInfoArray:m_PlacesData];
        [(MapViewCtrl *)ctrl setType:m_type];
    }
    else if([ctrl isKindOfClass:[DetailMapViewCtrl class]]){
        [(DetailMapViewCtrl *)ctrl setInfoArray:m_PlacesData];
        [(DetailMapViewCtrl *)ctrl setIndex:m_index];
    }
    else{
        
    }
}


-(IBAction)ResetLocation:(id)sender {
    
     LocationInfoCtrl *LocCtrl = (LocationInfoCtrl *)[[NSStoryboard storyboardWithName:@"Main" bundle:nil]instantiateControllerWithIdentifier:@"LocationInfo"];
    [self presentViewControllerAsModalWindow:LocCtrl];
}


-(NSString *)getUserLocationLatLng {
   
    NSString *locationName;
    
    return locationName;
}


-(NSString *)GetDistanceDutation:(NSString *)DestinationAddress{

    NSData *data;
    NSError *error;
    NSString *content;
    NSMutableString *nsReturn;
    NSString *url = nil;
    NSString *urlString = nil;
    NSString *distance = nil;
    NSString *duration = nil;
    
    NSString *CurrentAddress;
    CurrentAddress = [[NSUserDefaults standardUserDefaults] objectForKey:@"AddressLocation"];
 
    if (!CurrentAddress||[CurrentAddress isEqualToString:@""]) {
        return nil;
    }
    
    url = @"https://maps.googleapis.com/maps/api/distancematrix/json?origins=%@&destinations=%@&key=AIzaSyCAjzh1MKW2MVtl493LQiooASqqYGjL4Yw";
    
    urlString = [NSMutableString stringWithFormat:url, CurrentAddress, DestinationAddress];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    content = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:&error];
    
    if (!content || [content isEqualToString:@""]) {
        return nil;
    }
    
    data = [content dataUsingEncoding:NSUTF8StringEncoding];
    if (!data) {
        return nil;
    }
    
    id Dictdata = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) {
        NSLog(@"Error parsing JSON: %@", error);
    }
    
    if ([Dictdata isKindOfClass:[NSDictionary class]]) {
        NSArray *array;
        array = [Dictdata objectForKey:@"rows"];
        array = [[array objectAtIndex:0] objectForKey:@"elements"];
        distance = [[[array objectAtIndex:0] objectForKey:@"distance"] objectForKey:@"text"];
        duration = [[[array objectAtIndex:0] objectForKey:@"duration"] objectForKey:@"text"];
    }
    
    nsReturn = [NSMutableString stringWithFormat:@"%@, %@ away ...", distance, duration];

    return nsReturn;
}


-(IBAction)SearchNearBy:(id)sender
{
    
    int count = 0;
    NSError *error;
    NSArray *nsArrayData;
    NSString *url = nil;
    NSString *urlString = nil;
    NSString *type = nil;
    
    NSString *LocCoordinate;
    LocCoordinate = [[NSUserDefaults standardUserDefaults] objectForKey:@"LocCoordinate"];
    
    [m_PlacesData removeAllObjects];
    NSUInteger Index = [m_comBox indexOfSelectedItem];
    m_type = [[m_comBox objectValues] objectAtIndex:Index];
    type = [m_mapDictionary objectForKey:m_type];
    [[m_tableView tableColumnWithIdentifier:@"ColumnID"] setTitle:m_type];

    url = @"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%@&radius=5000&type=%@&key=AIzaSyDiLakEIP9fZWeuKDWE1-rGa6dZkA8Og8I";
    urlString = [NSMutableString stringWithFormat:url, LocCoordinate, type];
    
    NSString *content = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:&error];
    
    if (!content || [content isEqualToString:@""]) {
        return;
    }
    
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    if (!data) {
        return;
    }
    
    id Dictdata = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) {
        NSLog(@"Error parsing JSON: %@", error);
    }
    
  
    if ([Dictdata isKindOfClass:[NSDictionary class]]) {
        nsArrayData = [Dictdata objectForKey:@"results"];
    }
    
    if ([nsArrayData count] <= 0) {
        return;
    }
    
    for (count = 0 ; count< [nsArrayData count]; count++) {
        
        NSMutableDictionary *addChild = [[NSMutableDictionary alloc] init];
        NSDictionary *temp = [nsArrayData objectAtIndex:count];
        id imageURL = [temp objectForKey:@"icon"];
        [addChild setObject:imageURL forKey:@"icon"];
    
        id rating = [temp objectForKey:@"rating"];
        if (!rating)
            [addChild setObject:@"0" forKey:@"rating"];
        else
            [addChild setObject:[rating stringValue] forKey:@"rating"];
        
        
        id placeid = [temp objectForKey:@"place_id"];
        if (!placeid)
            [addChild setObject:@"" forKey:@"place_id"];
        else
            [addChild setObject:placeid forKey:@"place_id"];
      
        id vicinity = [temp objectForKey:@"vicinity"];
        
        [addChild setObject:vicinity forKey:@"vicinity"];
        id name = [temp objectForKey:@"name"];
        [addChild setObject:name forKey:@"name"];
        id curOpen = [[[temp objectForKey:@"opening_hours"] objectForKey:@"open_now"] stringValue];
        
        if (!curOpen) {
            [addChild setObject:@"0" forKey:@"open_now"];
        }
        else {
            [addChild setObject:curOpen forKey:@"open_now"];
        }
        
        id strLat = [[[temp objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lat"];
        id strLon =  [[[temp objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lng"];
        NSString *strlocation = [NSMutableString stringWithFormat:@"%@,%@",strLat , strLon];
        [addChild setObject:strlocation forKey:@"location"];
        
        NSString *DisDur = [self GetDistanceDutation:vicinity];
        if (DisDur)
            [addChild setObject:DisDur forKey:@"distTime"];

        [m_PlacesData addObject:addChild];
    }
    
    [m_tableView reloadData];
}

@end
