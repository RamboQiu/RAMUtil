

#import "RAMCellData.h"

@implementation RAMCellData

- (CGFloat)headerHeight {
    if (_sectionHeaderHeight == 0) {
        return CGFLOAT_MIN;
    }
    return _sectionHeaderHeight;
}

- (CGFloat)footerHeight {
    if (_sectionFooterHeight == 0) {
        return CGFLOAT_MIN;
    }
    return _sectionFooterHeight;
}

- (NSString *)cellIdentifier {
    if (!_cellIdentifier) {
        _cellIdentifier = NSStringFromClass(self.class);
    }
    return _cellIdentifier;
}

- (id)didSelModel {
    if (_didSelModel) {
        return _didSelModel;
    } else {
        return _model;
    }
}
@end
