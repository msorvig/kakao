#include "qcocoatextedit.h"
#include "qcocoatableview.h"
#include "qcocoatreeview.h"
#include "qcocoatoolbar.h"
#include "qcocoautil.h"
#include "model.h"
#include <QtGui>


int main(int argc, char**argv)
{
    QApplication app(argc, argv);
    QtCocoa::QMacCocoaAutoReleasePool pool;
    
    QWidget window;

    QHBoxLayout layout;

    QCocoaTextEdit textEdit;

    QFile f("../../../example.html");
    f.open(QIODevice::ReadOnly);
    textEdit.setHtml(QString::fromUtf8(f.readAll()));

    layout.addWidget(&textEdit);

    QCocoaTableView tableView;
    layout.addWidget(&tableView);
    Model interviewDemoModel(100000, 100);
    tableView.setModel(&interviewDemoModel);

    QCocoaTreeView treeView;
    layout.addWidget(&treeView);
    QDirModel dirModel;
    treeView.setModel(&dirModel);

    window.setLayout(&layout);
    window.show();
    window.raise();

    QCocoaToolBar toolbar;

    QAction *action1 = toolbar.addAction("Button 1");
    action1->setToolTip("Press the Button 1");
    QPixmap red(256, 256);
    red.fill(QColor(Qt::red));
    action1->setIcon(red);

    QAction *action2 = toolbar.addAction("Button 2");
    QPixmap blue(256, 256);
    blue.fill(QColor(Qt::blue));
    action2->setIcon(blue);
    action2->setCheckable(true);

    QAction *action3 = toolbar.addAction("Button 3");
    QPixmap green(256, 256);
    green.fill(QColor(Qt::green));
    action3->setIcon(green);
    action3->setCheckable(true);

    toolbar.showInWindow(&window);

    //QCocoaScrollview test(&window, new QCocoaScrollviewPrivate(&test));
    
    return app.exec();
//    [pool release];
}
