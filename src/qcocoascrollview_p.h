#include <qcocoascrollview.h>
#include <QMacCocoaViewContainer>

#ifndef QCOCOASCROLLVIEW_P_H
#define QCOCOASCROLLVIEW_P_H

class NSView;
class QCocoaScrollviewPrivate : public QMacCocoaViewContainer
{
public:
    QCocoaScrollviewPrivate(QWidget *parent);
    NSScrollView *scrollView;
    virtual void initPrivateView();
    void setDocumentView(NSView *view);
};

#endif //QCOCOASCROLLVIEW_P_H
