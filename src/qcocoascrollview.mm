#include "qcocoascrollview_p.h"

QCocoaScrollview::QCocoaScrollview(QWidget *parent)
:QCocoaBaseView(parent)
{
    d = 0;
}

QCocoaScrollviewPrivate::QCocoaScrollviewPrivate(QWidget *parent)
:QCocoaBaseViewPrivate(parent)
{

}

void QCocoaScrollviewPrivate::initPrivateView()
{
    QCocoaBaseViewPrivate::initPrivateView();

    NSRect rect;
    NSScrollView * scrollView = [[NSScrollView alloc] initWithFrame: rect];

//    NSSize contentSize = [scrollView contentSize];

    [scrollView setBorderType:NSBezelBorder];
    [scrollView setAutohidesScrollers: YES];
    [scrollView setHasVerticalScroller:YES];
    [scrollView setHasHorizontalScroller:YES];
    [scrollView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    setCocoaView(scrollView);
    [scrollView release];
}

void QCocoaScrollviewPrivate::setDocumentView(NSView *contentView)
{
    [reinterpret_cast<NSScrollView *>(cocoaView()) setDocumentView:contentView];
}
