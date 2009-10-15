#include "qcocoaitemview_p.h"
#include "qcocoautil.h"
#import <AppKit/AppKit.h>
#include <QtGui>


class QAbstractItemModelAccess : public QAbstractItemModel
{
public:
    using QAbstractItemModel::createIndex;
};


@interface ModelIndexPointerWrapper : NSObject
{
@public
    void *modelIndexPointer;
};
@end

@implementation ModelIndexPointerWrapper

@end
        
@implementation QAbstractItemModelWrapper


// NSTableViewDataSource

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    if (!model)
        return 0;

    QVariant modelData = model->data(model->index(row, columns.value(tableColumn)), Qt::DisplayRole);
    return QtCocoa::QCFString::toNSString(modelData.toString());
 }

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
 {
    if (!model)
        return 0;
    return model->rowCount();
 }

// NSOutlineViewDataSource

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item
{
    qDebug() << "childofItem" << index << item;
    if (!model)
        return 0;
    ModelIndexPointerWrapper * modelId = 0;
    if (item == nil) {
        modelId = [[ModelIndexPointerWrapper alloc] init];
        modelId->modelIndexPointer = (objc_object *)model->index(index,0,QModelIndex()).internalPointer();
    } else {
        ModelIndexPointerWrapper *indexWrapper = item;
        QModelIndex modelIndex = reinterpret_cast<QAbstractItemModelAccess *>(model)
                                 ->createIndex(0, 0, indexWrapper->modelIndexPointer);
        modelId = [[ModelIndexPointerWrapper alloc] init];
        modelId->modelIndexPointer = (objc_object *)model->index(index,0 , modelIndex).internalPointer();

    }

    qDebug() << "childofItem return" << modelId;

    return modelId;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
{
    qDebug() << "isItemExpandable" << item;

    if (!model)
        return NO;
    bool expands = NO;

    if (item == nil) {
        expands = model->hasChildren();
    } else {
        ModelIndexPointerWrapper *indexWrapper = item;
        QModelIndex modelIndex = reinterpret_cast<QAbstractItemModelAccess *>(model)
                                 ->createIndex(0, 0, indexWrapper->modelIndexPointer);
        expands = model->hasChildren(modelIndex);
    }

    qDebug() << "isItemExpandable return " << expands;
    return expands;
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item
{
    qDebug() << "numberOfChildrenOfItem" << item << model;
    if (!model)
        return 0;
    int kids = 0;

    if (item == nil) {
        kids = model->rowCount();
    } else {
        ModelIndexPointerWrapper *indexWrapper = item;
        QModelIndex modelIndex = reinterpret_cast<QAbstractItemModelAccess *>(model)
                                 ->createIndex(0, 0, indexWrapper->modelIndexPointer);
        kids = model->rowCount(modelIndex);
    }

    qDebug() << "return" << kids;
    return kids;
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item
{
    if (!model)
        return 0;
    qDebug() << "objectValueForTableColumn" << item << tableColumn;
    if (item == nil) {
        QVariant modelData = model->data(QModelIndex(), Qt::DisplayRole);
        return QtCocoa::QCFString::toNSString(modelData.toString());
    }

    ModelIndexPointerWrapper *indexWrapper = item;
    QModelIndex modelIndex = reinterpret_cast<QAbstractItemModelAccess *>(model)
                             ->createIndex(0, columns.value(tableColumn), indexWrapper->modelIndexPointer);
    QVariant modelData = model->data(modelIndex, Qt::DisplayRole);
    return QtCocoa::QCFString::toNSString(modelData.toString());

    return QtCocoa::QCFString::toNSString("test");
    return 0;
}

@end
