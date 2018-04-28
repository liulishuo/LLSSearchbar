//
//  VKSearchView.h
//  RongExtensionKit
//
//  Created by liulishuo on 2018/4/25.
//

#import <UIKit/UIKit.h>

@class VKSearchBar;
@protocol VKSearchBarDelegate <NSObject>

@optional

- (BOOL)vkSearchBarShouldBeginEditing:(VKSearchBar *)searchBar;
- (void)vkSearchBarDidBeginEditing:(VKSearchBar *)searchBar;

- (BOOL)vkSearchBarShouldEndEditing:(VKSearchBar *)searchBar;
- (void)vkSearchBarDidEndEditing:(VKSearchBar *)searchBar;

- (void)vkSearchBar:(VKSearchBar *)searchBar textDidChange:(NSString *)searchText;
- (BOOL)vkSearchBar:(VKSearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;

- (void)vkSearchBarCancelButtonClicked:(VKSearchBar *)searchBar;

@end

@interface VKSearchBar : UIView

//输入框父视图
@property (weak, nonatomic) IBOutlet UIView *textFieldContainerView;
//输入框
@property (weak, nonatomic) IBOutlet UITextField *textField;

//取消按钮父视图
@property (weak, nonatomic) IBOutlet UIView *cancelButtonContainerView;
//取消按钮父视图宽度
@property (nonatomic, assign) CGFloat cancelButtonContainerViewWidth;
//取消按钮
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

//bar内间距 目前只支持左右
@property (nonatomic, assign) UIEdgeInsets marginInsets;

//默认 10 point
@property (nonatomic, assign) CGFloat placeholderHorizontalMargin;

//激活状态
@property (nonatomic, assign, readonly) BOOL active;

//搜索框文本
@property (nonatomic, strong) NSString *text;
//搜索框占位文本
@property (nonatomic, strong) NSString *placeholder;
//搜索框占位icon
@property (weak, nonatomic) IBOutlet UIImageView *searchIconView;
//搜索框占位文本label，方便修改占位文本字体字号
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;

@property (nonatomic, weak) id<VKSearchBarDelegate> delegate;

+ (instancetype)initWithDelegate:(id<VKSearchBarDelegate>)delegate;

@end
