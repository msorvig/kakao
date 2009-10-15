#include <qcocoabaseview.h>
#include <QMacCocoaViewContainer>
#include <QHash>
//#import <AppKit/AppKit.h>

#ifndef QCOCOAITEMVIEW_P_H
#define QCOCOAITEMVIEW_P_H

class NSTableColumn;
class NSMenuItem;
class QAbstractItemModel;
@interface QAbstractItemModelWrapper : NSObject <NSTableViewDataSource, NSOutlineViewDataSource>
{
@public
    QAbstractItemModel * model;
    QHash<NSTableColumn *, int> columns;
}
@end

#endif //QCOCOAITEMVIEW_P_H
