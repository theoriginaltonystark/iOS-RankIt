#import "TableViewControllerResults.h"
#import "ViewControllerDettagli.h"
#import "Font.h"
#import "Candidate.h"
#import "Util.h"


@interface TableViewControllerResults ()


@end

@implementation TableViewControllerResults
@synthesize poll,classificaFinale,flussoFrom;





- (void)viewDidLoad {
    [super viewDidLoad];
    ConnectionToServer *conn = [[ConnectionToServer alloc]init];
    classificaFinale=[conn getOptimalResultsOfPoll:poll];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[poll candidates] count];
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"ResultCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    
    NSMutableArray * candidates=[poll candidates];
    
    NSString * risp=[classificaFinale objectAtIndex:indexPath.row];
    
    /* Cattura indice per estrarre il candidate relativo */
    int indexCand=-1;
    if ([risp isEqual:@"A"])        indexCand = 0;
    else if ([risp isEqual:@"B"])   indexCand = 1;
    else if ([risp isEqual:@"C"])   indexCand = 2;
    else if ([risp isEqual:@"D"])   indexCand = 3;
    else                            indexCand = 4;
    Candidate *c=candidates[indexCand];
    
    /* Visualizzazione del risultato nella cella */
    UIImageView *image = (UIImageView *)[cell viewWithTag:100];
    if (indexPath.row==0)           image = [image initWithImage:[UIImage imageNamed:@"GoldMedal"]];
    else if (indexPath.row==1)      image = [image initWithImage:[UIImage imageNamed:@"SilverMedal"]];
    else if (indexPath.row==2)      image = [image initWithImage:[UIImage imageNamed:@"BronzeMedal"]];
    else                            image = [image initWithImage:[UIImage imageNamed:@"GreyMedal"]];
    
    UILabel *NamePoll = (UILabel *)[cell viewWithTag:101];
    NamePoll.text = c.candName;
    NamePoll.font = [UIFont fontWithName:FONT_HOME size:16];
    
    return cell;

}

/* Funzioni che permettono di accedere alla descrizione di un determinato poll sia dalla schermata "Home" che dai risultati di ricerca */
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showVotedResultsDetails"]) {
        
        ViewControllerDettagli *destViewController = segue.destinationViewController;
        destViewController.p = poll;
        /* Flusso dati */
        destViewController.flussoFrom = flussoFrom;
        
    }
    
}




@end
