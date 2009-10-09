#include "qcocoascrollview_p.h"

QCocoaScrollview::QCocoaScrollview(QWidget *parent)
:QWidget(parent)
{
    d = 0;
}

void QCocoaScrollview::setScrollViewPrivate(QCocoaScrollviewPrivate *priv)
{
    d = priv;
    d->initPrivateView();
}

void QCocoaScrollview::resizeEvent(QResizeEvent * event)
{
    NSRect rect;
    rect.origin.x = 0;
    rect.origin.y = 0;
    rect.size.width = event->size().width();
    rect.size.height = event->size().height();

    qDebug() << "resize" << event->size();

    [d->cocoaView() setFrame : rect];
    [d->cocoaView() setNeedsDisplay:YES];
 }

QSize QCocoaScrollview::minimumSizeHint() const
{
    return QSize(50, 50);
}

QSize QCocoaScrollview::sizeHint() const
{
    return QSize(400, 400);
}

QCocoaScrollviewPrivate::QCocoaScrollviewPrivate(QWidget *parent)
:QMacCocoaViewContainer(0 /* view to wrap */, parent)
{

}

void QCocoaScrollviewPrivate::initPrivateView()
{
    NSRect rect;
    scrollView = [[NSScrollView alloc] initWithFrame: rect];

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
    [scrollView setDocumentView:contentView];
}

