#import <UIKit/UIKit.h>
#import "Poll.h"

@interface ViewController : UIViewController

@property (nonatomic,strong) Poll *p;
@property (nonatomic,strong) UILabel *name;
@property (nonatomic,strong) UILabel *deadline;
@property (nonatomic,strong) UILabel *lastUpdate;
@property (nonatomic,strong) UILabel *description;

@end