//
//  NerdFeedVC.h
//  
//
//  Created by Md. Milan Mia on 10/8/15.
//
//

#import <UIKit/UIKit.h>

@interface NerdFeedVC : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    NSArray *jsonArray;
}
@property (strong, nonatomic) IBOutlet UITableView *myTable;
-(void)fetchFeed;
@end
