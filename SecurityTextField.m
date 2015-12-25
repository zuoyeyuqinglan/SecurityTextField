//
//  SecurityTextField.m
//  SecurityInputView
//
//  Created by Guan on 15/12/25.
//  Copyright © 2015年 Guan. All rights reserved.
//

#import "SecurityTextField.h"

@interface SecurityTextField()<UITextFieldDelegate>

@property (strong ,nonatomic)UITextField *mainInputField ;

@property (strong ,nonatomic)UIButton *begainner;

@property (assign ,nonatomic)NSInteger numOfPasswordChars;

@property (strong ,nonatomic)NSMutableArray *subTextFields;

@property (strong ,nonatomic) UIView *container;


@end

@implementation SecurityTextField

- (instancetype)initWithFrame:(CGRect)frame numOfPasswordChars:(NSInteger )numOfPasswordChars{
    
    if (self = [super initWithFrame:frame]) {
        
        _subTextFields = [[NSMutableArray alloc] init];
        
        _text = nil;
        
        _numOfPasswordChars = (numOfPasswordChars > 0 ) ? numOfPasswordChars : 6 ;
        
        [self prepareSubViews];
    }
    
    return self;
}


- (void)prepareSubViews{
    
    _mainInputField = [[UITextField alloc] initWithFrame:self.bounds];
    
    [_mainInputField addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventAllEditingEvents];
    
    [self addSubview:_mainInputField];
    
    _mainInputField.delegate = self;
    
    _mainInputField.keyboardType = UIKeyboardTypePhonePad ;
    
    _container = [[UIView alloc] initWithFrame:self.bounds];
    
    _container.layer.borderWidth = 1;
    _container.layer.borderColor = [UIColor blackColor].CGColor;
    
    [self addSubview:_container];
    
    _container.backgroundColor = [UIColor whiteColor];
    
    CGFloat subWideth = self.frame.size.width / _numOfPasswordChars ;
    
    CGFloat subX = 0 ;
    
    CGFloat subH = self.frame.size.height ;
    
    for (NSInteger i = 0 ; i < _numOfPasswordChars; i ++ ) {
        
        subX = subWideth * i ;
        
        UITextField *subField = [[UITextField alloc] initWithFrame:CGRectMake(subX, 0, subWideth, subH)];
        
        [_container addSubview:subField];
        
        subField.secureTextEntry = YES;
        
        subField.borderStyle = UITextBorderStyleNone ;
        
        subField.userInteractionEnabled = NO;
        
        subField.textAlignment = NSTextAlignmentCenter ;
        
        subField.layer.borderWidth = 0.5 ;
        
        subField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        [_subTextFields addObject:subField];
    }
    
    _begainner = [[UIButton alloc] initWithFrame:self.bounds];
    
    [_container addSubview:_begainner];
    
    [_begainner addTarget:self action:@selector(beginEditing:) forControlEvents:UIControlEventTouchUpInside];
    
    _begainner.backgroundColor = [UIColor clearColor];
    
    _container.alpha = 1.0 ;
    
}


- (void)beginEditing:(id)sender{
    
    [_mainInputField becomeFirstResponder];

}

- (void)resignFirstResponder{

   [_mainInputField resignFirstResponder];
}

- (void)becomeFirstResponder{

     [_mainInputField becomeFirstResponder];
}

- (void)clearText{

    _mainInputField.text = nil;
    
    _text = nil;
    
    for (UITextField *sub in _subTextFields) {
        
        sub.text = nil;
    }
}

- (void)editAction:(UITextField *)field{
    
    _text = _mainInputField.text  ;
    
    NSInteger currentCharsCount = _mainInputField.text.length ;
    
    NSInteger location = 0 ;
    NSInteger length = 1 ;
    
    NSRange range = NSMakeRange(location, length);
    
    NSString *currentChar = nil;
    
    for (NSInteger i = 0 ; i < _numOfPasswordChars; i ++ ) {
        
        UITextField *sub = _subTextFields[i];

        if (location <= currentCharsCount - 1 ) {
            
            range = NSMakeRange(location, length) ;
            
            currentChar = [field.text substringWithRange:range];
            
        }else currentChar = nil;
        
        sub.text = currentChar ;
        
        location ++ ;
        
        NSLog(@"%@----%@",field.text,sub.text);
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == _mainInputField) {
        
        if (range.location > _numOfPasswordChars - 1) {
            return NO;
        }
        
    }else{
        
        if (range.location > _numOfPasswordChars > 0) {
            return NO;
        }
    }
    return YES;
}





@end
