
#import "RAMMacros.h"

CGFloat _RAMBottomOffset() {
    if (@available(iOS 11, *)) {
        return [UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom;
    }
    
    return 0;
}

CGFloat RAMScaledSize(CGFloat width)
{
    if (IS_IPAD) {
        return RAMHandlePixel(0.5* width * RAMScreenWidth / 375.0);
    }
    return RAMHandlePixel(width * RAMScreenWidth / 375.0);
}

CGFloat RAMScaledRatioSize(CGFloat width){
    return RAMHandlePixel(width * RAMScreenWidth / 375.0);
}

CGFloat RAMScaledHeight(CGFloat h) {
    return RAMHandlePixel(h * RAMScreenHeight / 667.0);
}

CGFloat RAMHandlePixel(CGFloat pixel)
{
    NSInteger scale = [UIScreen mainScreen].scale;
    CGFloat temp = pixel - (NSInteger)pixel;
    
    if (scale == 2) {
        
        if (temp <= 0.25) {
            temp = 0;
            
        }else if(temp > 0.25 && temp <= 0.75) {
            temp = 0.5;
            
        }else if(temp > 0.75 && temp < 1){
            temp = 1;
            
        }
        
    }else if(scale == 3){
        
        if (temp <= 0.166) {
            temp = 0;
            
        }else if(temp > 0.166 && temp <= 0.5) {
            temp = 1.0/3;
            
        }else if(temp > 0.5 && temp <= 0.833) {
            temp = 2.0/3;
            
        }else if(temp > 0.833 && temp < 1){
            temp = 1.0;
        }
        
    }else if(scale == 1){
        
        if (temp < 0.5) {
            temp = 0;
            
        }else{
            temp = 1;
        }
        
    }
    
    CGFloat returnValue = (NSInteger)pixel + temp;;
    return returnValue;
}
