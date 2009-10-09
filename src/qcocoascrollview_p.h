#include "qcocoascrollview.h"
#include "qcocoabaseview_p.h"


#ifndef QCOCOASCROLLVIEW_P_H
#define QCOCOASCROLLVIEW_P_H

class NSView;
class QCocoaScrollviewPrivate : public QCocoaBaseViewPrivate
{
public:
    QCocoaScrollviewPrivate(QWidget *parent);
    virtual void initPrivateView();
    void setDocumentView(NSView *view);
};

#endif //QCOCOASCROLLVIEW_P_H
