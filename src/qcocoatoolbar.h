#ifndef QCOCOATOOLBAR_H
#define QCOCOATOOLBAR_H

#include <QObject>
#include <QString>
#include <QAction>

class QCocoaToolBarPrivate;
class QCocoaToolBar : public QObject
{
public:
    QCocoaToolBar();
    ~QCocoaToolBar();
    QAction *addAction(const QString &text);
    void showInWindow(QWidget *window);
protected:
    QCocoaToolBarPrivate *d;
};

#endif // QCOCOATOOLBAR_H
