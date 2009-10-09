#ifndef QCOCOASCROLLVIEW_H
#define QCOCOASCROLLVIEW_H

#include <QtGui>
#include "qcocoabaseview.h"

class QCocoaScrollviewPrivate;
class NSScrollView;
class QCocoaScrollview : public QCocoaBaseView
{
public:
    QCocoaScrollview(QWidget *parent);
    NSScrollView *scrollView();
};

#endif // QCOCOASCROLLVIEW_H
