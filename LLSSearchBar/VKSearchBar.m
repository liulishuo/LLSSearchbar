//
//  VKSearchView.m
//  RongExtensionKit
//
//  Created by liulishuo on 2018/4/25.
//

#import "VKSearchBar.h"

@interface VKSearchBar ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *placeholderView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightMarginConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMarginConstraint;

//左对齐约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *placeholderAlignmentLeftLeadingConstraint;

//居中对齐约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *placeholderLeftMarginConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *placeholderRightMarginConstraint;

@end

@implementation VKSearchBar
@synthesize active = _active;

#pragma mark - Lifecycle
+ (instancetype)initWithDelegate:(id<VKSearchBarDelegate>)delegate {
    NSBundle *bundle = [NSBundle mainBundle];
    VKSearchBar *searchBar = [bundle loadNibNamed:@"VKSearchBar" owner:nil options:nil].firstObject;
    searchBar.delegate = delegate;
    return searchBar;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _textFieldContainerView.layer.cornerRadius = _textFieldContainerView.bounds.size.height / 2;
    _textFieldContainerView.clipsToBounds = YES;
    
    _textField.delegate = self;
    [_textField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventAllEditingEvents];
    
    _cancelButtonContainerViewWidth = 86;
    _placeholderHorizontalMargin = 10;
    
    self.active = NO;
}

#pragma mark - Event Response
- (IBAction)clickToCancel:(id)sender {
    self.active = NO;
    [_textField resignFirstResponder];
    if ([_delegate respondsToSelector:@selector(vkSearchBarCancelButtonClicked:)]) {
        [_delegate vkSearchBarCancelButtonClicked:self];
    }
}

#pragma mark - Delegate
#pragma mark -- Textfield Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.active = YES;
    if ([_delegate respondsToSelector:@selector(vkSearchBarShouldBeginEditing:)]) {
        return [_delegate vkSearchBarShouldBeginEditing:self];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([_delegate respondsToSelector:@selector(vkSearchBarDidBeginEditing:)]) {
        [_delegate vkSearchBarDidBeginEditing:self];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ([_delegate respondsToSelector:@selector(vkSearchBarShouldEndEditing:)]) {
        return [_delegate vkSearchBarShouldEndEditing:self];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([_delegate respondsToSelector:@selector(vkSearchBarDidEndEditing:)]) {
        [_delegate vkSearchBarDidEndEditing:self];
    }
}

- (void)textChanged:(UITextField *)textField {
    if (textField.text.length == 0) {
        _placeholderView.hidden = NO;
    } else {
        _placeholderView.hidden = YES;
    }
    
    if ([_delegate respondsToSelector:@selector(vkSearchBar:textDidChange:)]) {
        [_delegate vkSearchBar:self textDidChange:textField.text];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([_delegate respondsToSelector:@selector(vkSearchBar:shouldChangeTextInRange:replacementText:)]) {
        return [_delegate vkSearchBar:self shouldChangeTextInRange:range replacementText:string];
    }
    return YES;
}

#pragma mark - Methods
- (void)hideCancelButtonContainerView {
    _rightMarginConstraint.constant = 20;
    _cancelButtonContainerView.hidden = YES;
}

- (void)showCancelButtonContainerlView {
    _rightMarginConstraint.constant = _cancelButtonContainerViewWidth;
    _cancelButtonContainerView.hidden = NO;
}

- (void)placeholderAlignmentLeft {
    _placeholderAlignmentLeftLeadingConstraint.active = YES;
    _placeholderAlignmentLeftLeadingConstraint.constant = _placeholderHorizontalMargin;
    
}

- (void)placeholderAlignmentCenter {
    _placeholderAlignmentLeftLeadingConstraint.active = NO;
}

#pragma mark - Setter and Getter

- (void)setActive:(BOOL)active {
    _active = active;
    if (_active) {
        [self showCancelButtonContainerlView];
        [self placeholderAlignmentLeft];
    } else {
        _textField.text = @"";
        [self hideCancelButtonContainerView];
        [self placeholderAlignmentCenter];
    }
}

- (BOOL)active {
    return _active;
}

- (NSString *)text {
    return  _textField.text;
}

- (void)setText:(NSString *)text {
    _textField.text = text;
}

- (NSString *)placeholder {
    return _placeholderLabel.text;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholderLabel.text = placeholder;
}

- (void)setMarginInsets:(UIEdgeInsets)marginInsets {
    _leftMarginConstraint.constant = marginInsets.left;
    _rightMarginConstraint.constant = marginInsets.right;
}

- (void)setPlaceholderHorizontalMargin:(CGFloat)placeholderHorizontalMargin {
    _placeholderHorizontalMargin = placeholderHorizontalMargin;
    _placeholderLeftMarginConstraint.constant = _placeholderHorizontalMargin;
    _placeholderRightMarginConstraint.constant = _placeholderHorizontalMargin;
}
@end
