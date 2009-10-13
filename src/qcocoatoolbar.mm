#include "qcocoatoolbar.h"
#include "qcocoautil.h"
#import <AppKit/AppKit.h>
#include <qdebug.h>

#include <private/qt_mac_p.h> // private

class QCocoaToolBarPrivate;
@interface ToolBarDelegate : NSObject <NSToolbarDelegate>
{
@public
    QCocoaToolBarPrivate *d;
}

- (NSToolbarItem *) toolbar: (NSToolbar *)toolbar itemForItemIdentifier: (NSString *) itemIdent willBeInsertedIntoToolbar:(BOOL) willBeInserted;
- (NSArray *)toolbarDefaultItemIdentifiers:(NSToolbar*)toolbar;
- (NSArray *)toolbarAllowedItemIdentifiers:(NSToolbar*)toolbar;
- (NSArray *)toolbarSelectableItemIdentifiers:(NSToolbar *)toolbar;

- (IBAction)itemClicked:(id)sender;
@end

class QCocoaToolBarPrivate
{
public:
    NSToolbar *toolbar;
    ToolBarDelegate *delegate;

    QHash<QString, QAction*> actions;
    QHash<QString, QAction*> standardActions;
};

@implementation ToolBarDelegate

- (NSArray *)toolbarDefaultItemIdentifiers:(NSToolbar*)toolbar
{
    Q_UNUSED(toolbar);
    QStringList identifiers = d->actions.keys() + d->standardActions.keys();
    return QtCocoa::toNSArray(identifiers);
}

- (NSArray *)toolbarAllowedItemIdentifiers:(NSToolbar*)toolbar
{
    Q_UNUSED(toolbar);
    QStringList identifiers = d->actions.keys() + d->standardActions.keys();
    return QtCocoa::toNSArray(identifiers);
}

- (NSArray *)toolbarSelectableItemIdentifiers: (NSToolbar *)toolbar
{
    QStringList selectableItems;
    QHashIterator<QString, QAction*> it(d->actions);
    while (it.hasNext()) {
        it.next();
        if (it.value()->isCheckable()) {
            selectableItems.append(it.key());
        }
    }
    return QtCocoa::toNSArray(selectableItems);
}

- (IBAction)itemClicked:(id)sender
{
    NSToolbarItem *item = reinterpret_cast<NSToolbarItem *>(sender);
    QString identifier = QtCocoa::QCFString([item itemIdentifier]).toQString();
    QAction *action = d->actions.value(identifier);
    qDebug() << "clicked" << sender << identifier << action;
    if (action)
        action->trigger();
}

- (NSToolbarItem *) toolbar: (NSToolbar *)toolbar itemForItemIdentifier: (NSString *) itemIdentifier willBeInsertedIntoToolbar:(BOOL) willBeInserted
{
    Q_UNUSED(toolbar);
    Q_UNUSED(willBeInserted);
    const QString identifier = QtCocoa::QCFString(itemIdentifier).toQString();
    
    QAction *action = d->actions.value(identifier);
    if (action == 0)
        return nil;

    NSToolbarItem *toolbarItem = [[[NSToolbarItem alloc] initWithItemIdentifier: itemIdentifier] autorelease];
    [toolbarItem setLabel: QtCocoa::QCFString::toNSString(QString(action->text()))];
    [toolbarItem setPaletteLabel:[toolbarItem label]];
    [toolbarItem setToolTip: QtCocoa::QCFString::toNSString(action->toolTip())];
    QPixmap icon = action->icon().pixmap(256, 256);
    if (icon.isNull() == false) {
        [toolbarItem setImage : QtCocoa::toNSImage(icon)];
    }

    [toolbarItem setTarget : self];
    [toolbarItem setAction : @selector(itemClicked:)];

    return toolbarItem;
}

@end


QCocoaToolBar::QCocoaToolBar()
{
    d = new QCocoaToolBarPrivate();

    d->toolbar = [[NSToolbar alloc] initWithIdentifier:@"MySampleToolbar1"];
    d->delegate = [[ToolBarDelegate alloc] init];
    d->delegate->d = d;

    [d->toolbar setAllowsUserCustomization:YES];
  //  [d->toolbar setAutosavesConfiguration:YES];
    [d->toolbar setDisplayMode:NSToolbarDisplayModeIconAndLabel];

    [d->toolbar setDelegate: d->delegate];

    addStandardItem(NSToolbarShowColorsItemIdentifier);
    addStandardItem(NSToolbarShowFontsItemIdentifier);
}

QCocoaToolBar::~QCocoaToolBar()
{
    [d->toolbar release];
}

QAction *QCocoaToolBar::addAction(const QString &text)
{
    QAction *action = new QAction(text, this);
    QString identifier = QString::number(size_t(action));
    d->actions.insert(identifier, action);
    return action;
}

QAction *QCocoaToolBar::addAction(const QIcon &icon, const QString &text)
{
    QAction *action = new QAction(icon, text, this);
    QString identifier = QString::number(size_t(action));
    d->actions.insert(identifier, action);
    return action;
}

QAction *QCocoaToolBar::addStandardItem(NSString *standardItem)
{
    QAction *action = new QAction(this);
    QString identifier = QtCocoa::QCFString(standardItem);
    d->standardActions.insert(identifier, action);
    return action;
}

void QCocoaToolBar::showInWindow(QWidget *window)
{
    [qt_mac_window_for(window) setToolbar: d->toolbar];
    [qt_mac_window_for(window) setShowsToolbarButton:YES];
}
