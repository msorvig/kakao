DEPENDPATH += $$PWD
INCLUDEPATH += $$PWD/
HEADERS += $$PWD/qcocoatableview.h \
    $$PWD/qcocoatextedit.h \
    qcocoascrollview.h \
    qcocoascrollview_p.h \
    qcocoabaseview.h \
    qcocoabaseview_p.h \
    qcocoatoolbar.h \
    qcocoautil.h
SOURCES += $$PWD/qcocoatableview.mm \
    $$PWD/qcocoatextedit.mm \
    $$PWD/qcocoautil.mm \
    qcocoascrollview.mm \
    qcocoabaseview.mm \
    qcocoatoolbar.mm
LIBS += -framework \
    AppKit
