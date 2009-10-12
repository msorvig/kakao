#include "qcocoatextedit.h"
#include "qcocoatableview.h"
#include "qcocoascrollview_p.h"
#include "qcocoatoolbar.h"
#include "qcocoautil.h"
#include <QtGui>


int main(int argc, char**argv)
{
    QApplication app(argc, argv);
    QtCocoa::QMacCocoaAutoReleasePool pool;
    
    QWidget window;

    QHBoxLayout layout;

    QCocoaTextEdit textEdit;

    textEdit.setPlainText(QLatin1String("Here's to the lazy ones."));
    textEdit.plainText();
    qDebug() << textEdit.plainText();

    layout.addWidget(&textEdit);

    QCocoaTableView tableView;
    layout.addWidget(&tableView);
    QStringListModel stringListModel;
    stringListModel.setStringList(QStringList() << "ein" << "zwei" << "drei"<< "ein" << "zwei" << "drei"<< "ein" << "zwei" << "drei"<< "ein" << "zwei" << "drei");
    tableView.setModel(&stringListModel);

    QCocoaTableView treeView;
    layout.addWidget(&treeView);
    QDirModel dirModel;
    treeView.setModel(&dirModel);
    
    window.setLayout(&layout);
    window.show();
    window.raise();

    QCocoaToolBar toolbar;
    toolbar.addAction("Button 1");
    toolbar.addAction("Button 2");
    toolbar.showInWindow(&window);

    //QCocoaScrollview test(&window, new QCocoaScrollviewPrivate(&test));
    
    return app.exec();
//    [pool release];
}
