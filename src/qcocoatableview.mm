#include "qcocoatableview.h"
#include "qcocoautil.h"
#include "qcocoascrollview_p.h"
#import <AppKit/AppKit.h>
#include <QMacCocoaViewContainer>


@interface QAbstractItemModelWrapper : NSObject <NSTableViewDataSource>
{
@public
    QAbstractItemModel * model;
}
@end

@implementation QAbstractItemModelWrapper

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    if (!model)
        return 0;
    
    QVariant modelData = model->data(model->index(row, 0), Qt::DisplayRole);
    return QtCocoa::QCFString::toNSString(modelData.toString());
 }
 
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
 {
    if (!model)
        return 0;
    return model->rowCount();
 }

@end

class QCocoaTableViewPrivate : public QCocoaScrollviewPrivate
{
public:
    QCocoaTableViewPrivate(QWidget *parent);
    void initPrivateView();
    NSTableView *tableView;
    QAbstractItemModelWrapper *modelWrapper;
};

QCocoaTableViewPrivate::QCocoaTableViewPrivate(QWidget *parent)
: QCocoaScrollviewPrivate(parent)
{
}


QCocoaTableView::QCocoaTableView(QWidget *parent)
:QCocoaScrollview(parent)
{
    setViewPrivate(new QCocoaTableViewPrivate(this));
}

void QCocoaTableViewPrivate::initPrivateView()
{
    QCocoaScrollviewPrivate::initPrivateView();
    // Many Cocoa objects create temporary autorelease objects,
    // so create a pool to catch them.
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    modelWrapper = [[QAbstractItemModelWrapper alloc] init];
    modelWrapper->model = 0;

    // the following 20 lines creates a scrollable text view.
    NSRect rect;

  //  tableView = [[NSTableView alloc] initWithFrame:NSMakeRect(0, 0,
//                                                               contentSize.width, contentSize.height)];
    tableView = [[NSTableView alloc] initWithFrame:rect];

    [tableView setDataSource : modelWrapper];

    NSTableColumn *col = [[NSTableColumn alloc] initWithIdentifier : tableView];
    [[col headerCell] setStringValue : QtCocoa::QCFString::toNSString("header1")];
    [tableView addTableColumn : col];

    NSTableColumn *col2 = [[NSTableColumn alloc] initWithIdentifier : tableView];
    [[col2 headerCell] setStringValue : QtCocoa::QCFString::toNSString("header2")];
    [tableView addTableColumn : col2];

//    tableView = [[NSTableView alloc] init];
//    [tableView setMinSize:NSMakeSize(0.0, contentSize.height)];
//    [tableView setMaxSize:NSMakeSize(FLT_MAX, FLT_MAX)];
//    [tableView setVerticallyResizable:YES];
//    [tableView setHorizontallyResizable:NO];
//    [tableView setAutoresizingMask:NSViewWidthSizable];

    setDocumentView(tableView);

    // Clean up our pool as we no longer need it.
    [pool release];
}

void QCocoaTableView::setModel(QAbstractItemModel *model)
{
    reinterpret_cast<QCocoaTableViewPrivate *>(d)->modelWrapper->model = model;
    [reinterpret_cast<QCocoaTableViewPrivate *>(d)->tableView reloadData];
    
//    [s->view setNeedsDisplay:YES];
//    [s->tableView setNeedsDisplay:YES];
    qDebug() << [reinterpret_cast<QCocoaTableViewPrivate *>(d)->tableView numberOfRows]
             << [reinterpret_cast<QCocoaTableViewPrivate *>(d)->tableView numberOfColumns];
}

