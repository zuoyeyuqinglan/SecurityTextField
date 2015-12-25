//
//  SecurityTextField.h
//  SecurityInputView
//
//  Created by Guan on 15/12/25.
//  Copyright © 2015年 Guan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecurityTextField : UIView


/**
 *  密码输入框
 *
 *  @param frame              frame
 *  @param numOfPasswordChars 密码位数
 *
 *  @return SecurityTextField
 */
- (instancetype)initWithFrame:(CGRect)frame numOfPasswordChars:(NSInteger )numOfPasswordChars;

@property (copy ,nonatomic ,readonly)NSString *text;

- (void)resignFirstResponder;

- (void)becomeFirstResponder;

/**
 *  清除text
 */
- (void)clearText;



@end
