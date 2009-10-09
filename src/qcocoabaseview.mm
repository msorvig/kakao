#include "qcocoabaseview.h"
#include "qcocoascrollview_p.h"

QCocoaBaseView::QCocoaBaseView(QWidget *parent)
:QWidget(parent)
{
    d = 0;
}

NSView *QCocoaBaseView::cocoaView()
{
    if (d == 0)
        return 0;
    return reinterpret_cast<NSView *>(d->cocoaView());
}

void QCocoaBaseView::setViewPrivate(QCocoaBaseViewPrivate *priv)
{
    d = priv;
    d->initPrivateView();
}

void QCocoaBaseView::resizeEvent(QResizeEvent * event)
{
    NSRect rect;
    rect.origin.x = 0;
    rect.origin.y = 0;
    rect.size.width = event->size().width();
    rect.size.height = event->size().height();

    qDebug() << "resize" << event->size();

    [cocoaView() setFrame : rect];
    [cocoaView() setNeedsDisplay:YES];
 }

QSize QCocoaBaseView::minimumSizeHint() const
{
    return QSize(50, 50);
}

QSize QCocoaBaseView::sizeHint() const
{
    return QSize(400, 400);
}

QCocoaBaseViewPrivate::QCocoaBaseViewPrivate(QWidget *parent)
:QMacCocoaViewContainer(0 /* view to wrap */, parent)
{

}

void QCocoaBaseViewPrivate::initPrivateView()
{

}
