#import "ViewController.h"
#import "ConnectionToServer.h"
#import "ApiUrls.h"

#define ARC4RANDOM_MAX  0x100000000

@interface ViewController ()
@end

@implementation ViewController

@synthesize TableView,Home,MieiSondaggi,Votati,Impostazioni,AddPoll,
            WarningInternet,CheckingInternet,TabBar;

/*  Funzione che viene eseguita prima che la schermata appaia   *
 *  (funzione di default per iOS)                               */
- (void)viewDidLoad
{
    /*  Prima che viene fatto il check sulla rete, la TableView *
     *  viene resa invisibile e gli altri elementi vengono      *
     *  settati come non abilitati, il bottone Home viene       *
     *  settato come abilitato                                  */
    [TabBar setSelectedItem:Home];
    [TableView setHidden:YES];
    [self setEnabledAllButton:NO];
    
    /* La scritta che notifica il server non raggiungibile      *
     * viene messa ad invisibile                                */
    [WarningInternet setHidden:YES];
    
    [super viewDidLoad];
}

/*  Funzione che viene eseguita quando tutti gli elementi       *
 *  della view vengono caricati                                 *
 *  (funzione di default per iOS)                               */
- (void)viewDidAppear:(BOOL)animated
{
    [self HomePolls];
}

/*  Funzione che prova a scaricare tutti i poll.                *
 *  Legata alla schermata Home.                                 *
 *  Viene eseguita al momento dell'apertura dell'app e al       *
 *  momento del refresh in seguito ad una notifica di app non   *
 *  connessa ad internet.                                       *
 *  DA IMPLEMENTARE IL CARICAMENTO DEI POLL                     */
-(void)HomePolls
{
    /*  Viene settata a visibile la activityIndicator e viene   *
     *  animata e nascoste la tableView e il warning di server  *
     *  non raggiungibile.                                      */
    if(![TableView isHidden])
       [TableView setHidden:YES];
    if(![WarningInternet isHidden])
       [WarningInternet setHidden:YES];
    
    [CheckingInternet setHidden:NO];
    [CheckingInternet startAnimating];
    
    //  DA SOSTITUIRE CON IL TENTATIVO DI CONNESSIONE AL SERVER
    sleep(3);
    double random = ((double)arc4random() / (ARC4RANDOM_MAX));
    
    //  L'activityIndicator viene stoppata e settata a invisibile
    [CheckingInternet stopAnimating];
    [CheckingInternet setHidden:YES];
    
    if (random>0.5)
    {
        NSLog(@"Connesso!");
        
        //  Setta tutti i pulsanti come abilitati
        [self setEnabledAllButton:YES];
        
        /*  La tableView viene settata a visibile e vengono     *
         *  caricati i poll                                     */
        [TableView setHidden:NO];
        
        //  CARICAMENTO POLL...
    }
    
    else //Internet assente
    {
        NSLog(@"Non connesso!");
        
        // Visualizza la label di mancata connessione ad internet
        [WarningInternet setHidden:NO];
        
        /* Abilita solo i pulsanti:                                             *
            - Impostazioni (poichè è possibile usarlo anche senza internet)     *
            - Pagina corrente (Home)                                            */
        [Home setEnabled:YES];
        [Impostazioni setEnabled:YES];
        
    }
}

/*  Funzione relativa all'azione di downScroll                  *
 *  Disabilita tutti i pulsanti e ritenta il collegamento ad    *
 *  internet con conseguente aggiornamento dei poll             */
- (IBAction)downScroll:(id)sender
{
    [self setEnabledAllButton:NO];
    [self HomePolls];
}

/*  Funzione che setta tutti i pulsanti: attivi o disattivi     */
- (void) setEnabledAllButton:(BOOL)enabled
{
    [Home setEnabled:enabled];
    [MieiSondaggi setEnabled:enabled];
    [Votati setEnabled:enabled];
    [Impostazioni setEnabled:enabled];
    [AddPoll setEnabled:enabled];
}

/*  (funzione di default per iOS)                               */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end