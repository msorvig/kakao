#include "qcocoatreeview.h"
#include "qcocoautil.h"
#include "qcocoascrollview_p.h"
#include "qcocoaitemview_p.h"
#import <AppKit/AppKit.h>
#include <QMacCocoaViewContainer>


class QCocoaTreeViewPrivate : public QCocoaScrollviewPrivate
{
public:
    QCocoaTreeViewPrivate(QWidget *parent);
    void initPrivateView();
    void addColumns();
    NSOutlineView *outlineView;
    QAbstractItemModelWrapper *modelWrapper;
};

QCocoaTreeViewPrivate::QCocoaTreeViewPrivate(QWidget *parent)
: QCocoaScrollviewPrivate(parent)
{
}

QCocoaTreeView::QCocoaTreeView(QWidget *parent)
:QCocoaScrollview(parent)
{
    setViewPrivate(new QCocoaTreeViewPrivate(this));
}

void QCocoaTreeViewPrivate::initPrivateView()
{
    QCocoaScrollviewPrivate::initPrivateView();
    // Many Cocoa objects create temporary autorelease objects,
    // so create a pool to catch them.
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    modelWrapper = [[QAbstractItemModelWrapper alloc] init];
    modelWrapper->model = 0;

    // the following 20 lines creates a scrollable text view.
    NSRect rect;

  //  outlineView = [[NSoutlineView alloc] initWithFrame:NSMakeRect(0, 0,
//                                                               contentSize.width, contentSize.height)];
    outlineView = [[NSOutlineView alloc] initWithFrame:rect];

//    outlineView = [[NSoutlineView alloc] init];
//    [outlineView setMinSize:NSMakeSize(0.0, contentSize.height)];
//    [outlineView setMaxSize:NSMakeSize(FLT_MAX, FLT_MAX)];
//    [outlineView setVerticallyResizable:YES];
//    [outlineView setHorizontallyResizable:NO];
//    [outlineView setAutoresizingMask:NSViewWidthSizable];

    setDocumentView(outlineView);

    // Clean up our pool as we no longer need it.
    [pool release];
}

void QCocoaTreeViewPrivate::addColumns()
{
    for (int i = 0; i < modelWrapper->model->columnCount(); ++i) {
        const QString caption = modelWrapper->model->headerData(i, Qt::Horizontal).toString();
        NSTableColumn *col = [[NSTableColumn alloc] initWithIdentifier : outlineView];
        [[col headerCell] setStringValue : QtCocoa::QCFString::toNSString(caption)];
        modelWrapper->columns[col] = i;
        [outlineView addTableColumn : col];
        if (i == 0)
            [outlineView setOutlineTableColumn : col];

    }
}

void QCocoaTreeView::setModel(QAbstractItemModel *model)
{
    QCocoaTreeViewPrivate *d = reinterpret_cast<QCocoaTreeViewPrivate *>(this->d);

    d->modelWrapper->model = model;
    d->addColumns();
    [d->outlineView setDataSource : d->modelWrapper];
}

