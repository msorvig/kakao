#ifndef QCOCOATOOLBAR_H
#define QCOCOATOOLBAR_H

#include <QObject>
#include <QString>
#include <QAction>

class QCocoaToolBarPrivate;
class NSString;
class QCocoaToolBar : public QObject
{
public:
    QCocoaToolBar();
    ~QCocoaToolBar();
    QAction *addAction(const QString &text);
    QAction *addAction(const QIcon &icon, const QString &text);
    QAction *addStandardItem(NSString *standardItem);
    void showInWindow(QWidget *window);
protected:
    QCocoaToolBarPrivate *d;
};

#endif // QCOCOATOOLBAR_H
