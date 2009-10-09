DEPENDPATH += $$PWD
INCLUDEPATH += $$PWD/
HEADERS += $$PWD/qcocoatableview.h \
    $$PWD/qcocoatextedit.h \
    qcocoascrollview.h \
    qcocoascrollview_p.h
SOURCES += $$PWD/qcocoatableview.mm \
    $$PWD/qcocoatextedit.mm \
    $$PWD/qcocoautil.mm \
    qcocoascrollview.mm
LIBS += -framework \
    AppKit
