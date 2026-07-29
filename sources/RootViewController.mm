//
//  RootViewController.mm
//  TrollSpeed - Redesigned GVN247 VIP Ocean Theme
//

#import <notify.h>
#import <QuartzCore/QuartzCore.h>

#import "HUDHelper.h"
#import "MainApplication.h"
#import "RootViewController.h"
#import "UIApplication+Private.h"

static const CGFloat _gAuthorLabelBottomConstraintConstantCompact = -20.f;
static const CGFloat _gAuthorLabelBottomConstraintConstantRegular = -60.f;

@implementation RootViewController {
    UIButton *mainButton;
    UILabel *authorLabel;
    UILabel *titleLabel;
    UIView *cardView;
    CAGradientLayer *gradientLayer;
    NSLayoutConstraint *authorLabelBottomConstraint;
    BOOL isRemoteHUDActive;
}

- (BOOL)isHUDEnabled
{
    return IsHUDEnabled();
}

- (void)setHUDEnabled:(BOOL)enabled
{
    SetHUDEnabled(enabled);
}

- (void)loadView {
    CGRect bounds = UIScreen.mainScreen.bounds;

    self.view = [[UIView alloc] initWithFrame:bounds];
    self.view.backgroundColor = [UIColor blackColor];

    self.backgroundView = [[UIView alloc] initWithFrame:bounds];
    self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.backgroundView];

    // Deep Midnight Jellyfish Ocean Gradient
    gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = bounds;
    gradientLayer.colors = @[
        (id)[UIColor colorWithRed:2/255.0 green:8/255.0 blue:18/255.0 alpha:1.0].CGColor,
        (id)[UIColor colorWithRed:6/255.0 green:24/255.0 blue:44/255.0 alpha:1.0].CGColor,
        (id)[UIColor colorWithRed:2/255.0 green:10/255.0 blue:24/255.0 alpha:1.0].CGColor
    ];
    gradientLayer.startPoint = CGPointMake(0.5, 0.0);
    gradientLayer.endPoint = CGPointMake(0.5, 1.0);
    [self.backgroundView.layer addSublayer:gradientLayer];

    // Glassmorphism VIP Card Container
    cardView = [[UIView alloc] init];
    cardView.backgroundColor = [UIColor colorWithRed:6/255.0 green:22/255.0 blue:40/255.0 alpha:0.75];
    cardView.layer.cornerRadius = 24.0;
    cardView.layer.borderWidth = 1.5;
    cardView.layer.borderColor = [UIColor colorWithRed:0/255.0 green:229/255.0 blue:255/255.0 alpha:0.5].CGColor;
    
    // Bioluminescent Cyan Glow Shadow
    cardView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:200/255.0 blue:255/255.0 alpha:0.5].CGColor;
    cardView.layer.shadowOffset = CGSizeZero;
    cardView.layer.shadowOpacity = 0.8;
    cardView.layer.shadowRadius = 18.0;
    
    [self.backgroundView addSubview:cardView];

    // VIP Header Title
    titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"GVN247 VIP ESP";
    titleLabel.textColor = [UIColor colorWithRed:0/255.0 green:229/255.0 blue:255/255.0 alpha:1.0];
    titleLabel.font = [UIFont boldSystemFontOfSize:24.0];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [cardView addSubview:titleLabel];

    // Main HUD Action Button
    mainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    mainButton.layer.cornerRadius = 16.0;
    mainButton.layer.borderWidth = 1.5;
    mainButton.layer.masksToBounds = YES;
    [mainButton.titleLabel setFont:[UIFont boldSystemFontOfSize:22.0]];
    [mainButton addTarget:self action:@selector(tapMainButton:) forControlEvents:UIControlEventTouchUpInside];
    [cardView addSubview:mainButton];

    // Layout Constraints
    cardView.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    mainButton.translatesAutoresizingMaskIntoConstraints = NO;

    UILayoutGuide *safeArea = self.backgroundView.safeAreaLayoutGuide;

    [NSLayoutConstraint activateConstraints:@[
        [cardView.centerXAnchor constraintEqualToAnchor:safeArea.centerXAnchor],
        [cardView.centerYAnchor constraintEqualToAnchor:safeArea.centerYAnchor],
        [cardView.widthAnchor constraintEqualToConstant:320.0],
        [cardView.heightAnchor constraintEqualToConstant:220.0],

        [titleLabel.topAnchor constraintEqualToAnchor:cardView.topAnchor constant:28.0],
        [titleLabel.leadingAnchor constraintEqualToAnchor:cardView.leadingAnchor constant:16.0],
        [titleLabel.trailingAnchor constraintEqualToAnchor:cardView.trailingAnchor constant:-16.0],

        [mainButton.centerXAnchor constraintEqualToAnchor:cardView.centerXAnchor],
        [mainButton.topAnchor constraintEqualToAnchor:titleLabel.bottomAnchor constant:32.0],
        [mainButton.widthAnchor constraintEqualToConstant:250.0],
        [mainButton.heightAnchor constraintEqualToConstant:58.0],
    ]];

    // Author / Telegram Label
    authorLabel = [[UILabel alloc] init];
    [authorLabel setNumberOfLines:0];
    [authorLabel setTextAlignment:NSTextAlignmentCenter];
    [authorLabel setTextColor:[UIColor colorWithRed:176/255.0 green:236/255.0 blue:255/255.0 alpha:1.0]];
    [authorLabel setFont:[UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium]];
    [authorLabel sizeToFit];
    [self.backgroundView addSubview:authorLabel];

    authorLabelBottomConstraint = [authorLabel.bottomAnchor constraintEqualToAnchor:safeArea.bottomAnchor constant:_gAuthorLabelBottomConstraintConstantRegular];
    [authorLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[
        authorLabelBottomConstraint,
        [authorLabel.centerXAnchor constraintEqualToAnchor:safeArea.centerXAnchor],
    ]];

    UITapGestureRecognizer *authorTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAuthorLabel:)];
    [authorLabel setUserInteractionEnabled:YES];
    [authorLabel addGestureRecognizer:authorTapGesture];

    [self verticalSizeClassUpdated];
    [self reloadMainButtonState];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    gradientLayer.frame = self.backgroundView.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)reloadMainButtonState
{
    isRemoteHUDActive = [self isHUDEnabled];

    static NSAttributedString *hintAttributedString = nil;
    static NSAttributedString *creditsAttributedString = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *defaultAttributes = @{
            NSForegroundColorAttributeName: [UIColor colorWithRed:176/255.0 green:236/255.0 blue:255/255.0 alpha:1.0],
            NSFontAttributeName: [UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium],
        };

        NSMutableParagraphStyle *creditsParaStyle = [[NSMutableParagraphStyle alloc] init];
        creditsParaStyle.lineHeightMultiple = 1.2;
        creditsParaStyle.alignment = NSTextAlignmentCenter;

        NSDictionary *creditsAttributes = @{
            NSForegroundColorAttributeName: [UIColor colorWithRed:0/255.0 green:229/255.0 blue:255/255.0 alpha:1.0],
            NSFontAttributeName: [UIFont systemFontOfSize:15.0 weight:UIFontWeightBold],
            NSParagraphStyleAttributeName: creditsParaStyle,
        };

        NSString *hintText = NSLocalizedString(@"You can quit this app now.\nThe HUD will persist on your screen.", nil);
        hintAttributedString = [[NSAttributedString alloc] initWithString:hintText attributes:defaultAttributes];

        NSString *creditsText = NSLocalizedString(@"Telegram: @gvn247", nil);
        NSMutableAttributedString *creditsAttributedText = [[NSMutableAttributedString alloc] initWithString:creditsText attributes:creditsAttributes];

        creditsAttributedString = creditsAttributedText;
    });

    if (isRemoteHUDActive) {
        [mainButton setTitle:NSLocalizedString(@"Exit HUD", nil) forState:UIControlStateNormal];
        [mainButton setTitleColor:[UIColor colorWithRed:255/255.0 green:100/255.0 blue:120/255.0 alpha:1.0] forState:UIControlStateNormal];
        mainButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:50/255.0 blue:70/255.0 alpha:0.25];
        mainButton.layer.borderColor = [UIColor colorWithRed:255/255.0 green:75/255.0 blue:90/255.0 alpha:0.8].CGColor;
    } else {
        [mainButton setTitle:NSLocalizedString(@"Open HUD", nil) forState:UIControlStateNormal];
        [mainButton setTitleColor:[UIColor colorWithRed:0/255.0 green:229/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
        mainButton.backgroundColor = [UIColor colorWithRed:0/255.0 green:180/255.0 blue:220/255.0 alpha:0.25];
        mainButton.layer.borderColor = [UIColor colorWithRed:0/255.0 green:229/255.0 blue:255/255.0 alpha:0.9].CGColor;
    }

    [authorLabel setAttributedText:(isRemoteHUDActive ? hintAttributedString : creditsAttributedString)];
}

- (void)tapAuthorLabel:(UITapGestureRecognizer *)sender
{
    if (isRemoteHUDActive) {
        return;
    }
    NSString *repoURLString = @"https://t.me/gvn247";
    NSURL *repoURL = [NSURL URLWithString:repoURLString];
    [[UIApplication sharedApplication] openURL:repoURL options:@{} completionHandler:nil];
}

- (void)tapMainButton:(UIButton *)sender
{
    BOOL isNowEnabled = [self isHUDEnabled];
    [self setHUDEnabled:!isNowEnabled];
    isNowEnabled = !isNowEnabled;

    if (isNowEnabled)
    {
        [self.backgroundView setUserInteractionEnabled:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self reloadMainButtonState];
                [self.backgroundView setUserInteractionEnabled:YES];
            });
        });
    }
    else
    {
        [self.backgroundView setUserInteractionEnabled:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self reloadMainButtonState];
            [self.backgroundView setUserInteractionEnabled:YES];
        });
    }
}

- (void)verticalSizeClassUpdated
{
    UIUserInterfaceSizeClass verticalClass = self.traitCollection.verticalSizeClass;
    if (verticalClass == UIUserInterfaceSizeClassCompact) {
        [authorLabelBottomConstraint setConstant:_gAuthorLabelBottomConstraintConstantCompact];
    } else {
        [authorLabelBottomConstraint setConstant:_gAuthorLabelBottomConstraintConstantRegular];
    }
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    [self verticalSizeClassUpdated];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

@end
