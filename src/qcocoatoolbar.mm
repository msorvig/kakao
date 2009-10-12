#include "qcocoatoolbar.h"
#import <AppKit/AppKit.h>
#include <qdebug.h>

#include <private/qt_mac_p.h> // private

@interface ToolBarDelegate : NSObject <NSToolbarDelegate>
{

}

- (NSToolbarItem *) toolbar: (NSToolbar *)toolbar itemForItemIdentifier: (NSString *) itemIdent willBeInsertedIntoToolbar:(BOOL) willBeInserted;
- (NSArray *)toolbarDefaultItemIdentifiers:(NSToolbar*)toolbar;
- (NSArray *)toolbarAllowedItemIdentifiers:(NSToolbar*)toolbar;

@end

@implementation ToolBarDelegate

- (NSArray *)toolbarDefaultItemIdentifiers:(NSToolbar*)toolbar
{
    qDebug() << "toolbarDefaultItemIdentifiers";
    return [NSArray arrayWithObjects:
            NSToolbarFlexibleSpaceItemIdentifier,
            NSToolbarSpaceItemIdentifier,
            NSToolbarSeparatorItemIdentifier, nil];
}

- (NSArray *)toolbarAllowedItemIdentifiers:(NSToolbar*)toolbar
{
    qDebug() << "toolbarAllowedItemIdentifiers";
    return [NSArray arrayWithObjects:
            NSToolbarFlexibleSpaceItemIdentifier,
            NSToolbarSpaceItemIdentifier,
            NSToolbarSeparatorItemIdentifier, nil];
}

- (NSToolbarItem *) toolbar: (NSToolbar *)toolbar itemForItemIdentifier: (NSString *) itemIdent willBeInsertedIntoToolbar:(BOOL) willBeInserted
{

    qDebug() << "itemForItemIdentifier";
    NSToolbarItem *toolbarItem = nil;
    return toolbarItem;

    [toolbarItem setLabel:@"Save"];
    [toolbarItem setPaletteLabel:[toolbarItem label]];
    [toolbarItem setToolTip:@"Save Your Passwords"];
    toolbarItem = [[[NSToolbarItem alloc] initWithItemIdentifier: itemIdent] autorelease];
    return toolbarItem;
}

@end

class QCocoaToolBarPrivate
{
    public:
    NSToolbar *toolbar;
    ToolBarDelegate *delegate;
};



QCocoaToolBar::QCocoaToolBar()
{
    d = new QCocoaToolBarPrivate();

    d->toolbar = [[NSToolbar alloc] initWithIdentifier:@"MySampleToolbar"];
    d->delegate = [[ToolBarDelegate alloc] init];

    [d->toolbar setAllowsUserCustomization:YES];
    [d->toolbar setAutosavesConfiguration:YES];
    [d->toolbar setDisplayMode:NSToolbarDisplayModeLabelOnly];

    [d->toolbar setDelegate: d->delegate];

}

QCocoaToolBar::~QCocoaToolBar()
{
    [d->toolbar release];
}

QAction *QCocoaToolBar::addAction(const QString &text)
{

}

void QCocoaToolBar::showInWindow(QWidget *window)
{
    [qt_mac_window_for(window) setToolbar: d->toolbar];
    [d->toolbar setVisible : YES];
}
