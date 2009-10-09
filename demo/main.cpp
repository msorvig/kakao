#include "qcocoatextedit.h"
#include "qcocoatableview.h"
#include "qcocoascrollview_p.h"
#include <QtGui>


int main(int argc, char**argv)
{
    QApplication app(argc, argv);
//    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
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

    //QCocoaScrollview test(&window, new QCocoaScrollviewPrivate(&test));
    
    return app.exec();
//    [pool release];
}
