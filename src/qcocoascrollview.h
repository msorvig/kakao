#ifndef QCOCOASCROLLVIEW_H
#define QCOCOASCROLLVIEW_H

#include <QtGui>

class QCocoaScrollviewPrivate;
class NSScrollView;
class QCocoaScrollview : public QWidget
{
public:
    QCocoaScrollview(QWidget *parent);

    NSScrollView *scrollView();

    QSize minimumSizeHint() const;
    QSize sizeHint() const;
    void resizeEvent(QResizeEvent * event);

protected:
    void setScrollViewPrivate(QCocoaScrollviewPrivate *priv);
    QCocoaScrollviewPrivate *d;
};

#endif // QCOCOASCROLLVIEW_H
