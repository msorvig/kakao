#include "qcocoatableview.h"
#include "qcocoautil.h"
#include "qcocoascrollview_p.h"
#include "qcocoaitemview_p.h"
#include "qcocoautil.h"
#import <AppKit/AppKit.h>
#include <QMacCocoaViewContainer>


class QCocoaTableViewPrivate : public QCocoaScrollviewPrivate
{
public:
    QCocoaTableViewPrivate(QWidget *parent);
    void initPrivateView();
    void addColumns();
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
    QtCocoa::QMacCocoaAutoReleasePool pool;

    modelWrapper = [[QAbstractItemModelWrapper alloc] init];
    modelWrapper->model = 0;

    NSRect rect;
    tableView = [[NSTableView alloc] initWithFrame:rect];
    [tableView setDataSource : modelWrapper];
    setDocumentView(tableView);
}

void QCocoaTableViewPrivate::addColumns()
{
    for (int i = 0; i < modelWrapper->model->columnCount(); ++i) {
        const QString caption = modelWrapper->model->headerData(i, Qt::Horizontal).toString();
        NSTableColumn *col = [[NSTableColumn alloc] initWithIdentifier : tableView];
        [[col headerCell] setStringValue : QtCocoa::QCFString::toNSString(caption)];
        modelWrapper->columns[col] = i;
        [tableView addTableColumn : col];
    }
}

void QCocoaTableView::setModel(QAbstractItemModel *model)
{
    QCocoaTableViewPrivate *d = reinterpret_cast<QCocoaTableViewPrivate *>(this->d);

    d->modelWrapper->model = model;
    [d->tableView reloadData];
    d->addColumns();

//    [s->view setNeedsDisplay:YES];
//    [s->tableView setNeedsDisplay:YES];
    qDebug() << [reinterpret_cast<QCocoaTableViewPrivate *>(d)->tableView numberOfRows]
             << [reinterpret_cast<QCocoaTableViewPrivate *>(d)->tableView numberOfColumns];
}

