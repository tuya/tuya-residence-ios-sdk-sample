//
//  HomeTableViewController.m
//  TuyaSmartResidenceSDKSample-iOS-ObjC
//
//  Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com/)

#import "HomeTableViewController.h"
#import "QueryViewController.h"


@interface HomeTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *currentSiteLabel;
@property (nonatomic, assign) BOOL reminder;
@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    TuyaResidenceSiteModel *siteModel = [Helper getCurrentSiteModel];
    if (!siteModel) {
        [self fetchData];
    }
    
    self.currentSiteLabel.text = siteModel.name;
}

- (void)fetchData {

    [TuyaResidenceSite fetchSiteListWithSuccess:^(NSArray<TuyaResidenceSiteModel *> * _Nonnull homes) {

        [SVProgressHUD dismiss];
        
        TuyaResidenceSiteModel *firstModel = [homes firstObject];
        
        if (firstModel) {
            
            [Helper setCurrentSiteModelWithSiteId:[NSString stringWithFormat:@"%lld", firstModel.siteId]];
            self.currentSiteLabel.text = firstModel.name;
            
            [self.tableView reloadData];
        } else if (!self.reminder) {
            [SVProgressHUD showInfoWithStatus:@"Please create a site first"];
            self.reminder = YES;
            
            UIStoryboard *siteSB = [UIStoryboard storyboardWithName:@"Site" bundle:nil];
            UIViewController *vc = [siteSB instantiateViewControllerWithIdentifier:@"CreateSiteViewController"];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }];
}


- (IBAction)logoutClick:(UIButton *)sender {
    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:nil message:@"You're going to log out this account" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"Logout" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [[TuyaSmartUser sharedInstance] loginOut:^{
            UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UINavigationController *nav = [mainSB instantiateInitialViewController];
            [UIApplication sharedApplication].keyWindow.rootViewController = nav;
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alertViewController addAction:logoutAction];
    [alertViewController addAction:cancelAction];
    [self presentViewController:alertViewController animated:YES completion:nil];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *desViewController = segue.destinationViewController;
    
    if ([desViewController isKindOfClass:[QueryViewController class]] && [sender isKindOfClass:[UITableViewCell class]]) {
        __block UITextField *uidTextField;
        __block UITextField *emailTextField;
        __block UITextField *authGroupIdTextField;
        __block UITextField *deviceIdTextField;
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"Change Nickname" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"enter accessUid";
            uidTextField = textField;
            
        }];
        
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"enter username";
            emailTextField = textField;
            
        }];
        
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"enter authGroupId";
            authGroupIdTextField = textField;
        }];
        
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"enter deviceId";
            deviceIdTextField = textField;
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
    
        UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

            QueryViewController *vc = (QueryViewController *)desViewController;
            
            UITableViewCell *cell = (UITableViewCell *)sender;
            NSInteger tag = cell.tag;
            NSString *title = cell.textLabel.text;
            
            vc.apiCode = tag;
            
            vc.accessUserId = uidTextField.text;
            vc.username = emailTextField.text;
            vc.authGroupId = authGroupIdTextField.text;
            vc.deviceId = deviceIdTextField.text;
            
            vc.title = title;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:saveAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}


@end
