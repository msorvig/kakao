#include "qcocoatextedit.h"
#include "qcocoautil.h"
#include "qcocoascrollview_p.h"
#import <AppKit/AppKit.h>
#include <QMacCocoaViewContainer>


class QCocoaTextEditPrivate : public QCocoaScrollviewPrivate
{
public:
    QCocoaTextEditPrivate(QWidget *parent);
    void initPrivateView();
    NSTextView *theTextView;
};

QCocoaTextEditPrivate::QCocoaTextEditPrivate(QWidget *parent = 0)
: QCocoaScrollviewPrivate(parent)
{

}

void QCocoaTextEditPrivate::initPrivateView()
{
    QCocoaScrollviewPrivate::initPrivateView();

    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    NSRect rect;
    theTextView = [[NSTextView alloc] initWithFrame:rect];
    [theTextView setMinSize:NSMakeSize(0.0, 0.0)];
    [theTextView setMaxSize:NSMakeSize(FLT_MAX, FLT_MAX)];
    [theTextView setVerticallyResizable:YES];
    [theTextView setHorizontallyResizable:NO];
    [theTextView setAutoresizingMask:NSViewWidthSizable];

    //[[theTextView textContainer]
     //setContainerSize:NSMakeSize(contentSize.width, FLT_MAX)];
    [[theTextView textContainer] setWidthTracksTextView:YES];

    setDocumentView(theTextView);
    [pool release];
}

QCocoaTextEdit::QCocoaTextEdit(QWidget *parent)
:QCocoaScrollview(parent)
{
     setViewPrivate(new QCocoaTextEditPrivate(this));
    
    QAction *copy = new QAction(this);
    copy->setShortcut(QKeySequence::Copy);
    addAction(copy);
}

NSTextView *QCocoaTextEdit::textView() const
{
    return reinterpret_cast<QCocoaTextEditPrivate *>(d)->theTextView;
}

void QCocoaTextEdit::setPlainText(const QString &text)
{
    [ reinterpret_cast<QCocoaTextEditPrivate *>(d)->theTextView setString  : QtCocoa::QCFString::toNSString(text) ];
}

QString QCocoaTextEdit::plainText()
{
    CFStringRef str = (CFStringRef)([reinterpret_cast<QCocoaTextEditPrivate *>(d)->theTextView string]);
    CFRetain(str);
    return QtCocoa::QCFString(str);
}
