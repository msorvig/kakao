#include <QtGui>
#include "qcocoascrollview.h"

class QCocoaTableView : public QCocoaScrollview
{
public:
    QCocoaTableView(QWidget *parent = 0);

    void setModel(QAbstractItemModel *model);
};
