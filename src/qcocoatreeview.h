#include <QtGui>
#include "qcocoascrollview.h"

class QCocoaTreeView : public QCocoaScrollview
{
public:
    QCocoaTreeView(QWidget *parent = 0);

    void setModel(QAbstractItemModel *model);
};
