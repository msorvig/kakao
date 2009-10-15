DEPENDPATH += $$PWD
INCLUDEPATH += $$PWD/
HEADERS += $$PWD/qcocoatableview.h \
    $$PWD/qcocoatextedit.h \
    qcocoascrollview.h \
    qcocoascrollview_p.h \
    qcocoabaseview.h \
    qcocoabaseview_p.h \
    qcocoatoolbar.h \
    qcocoautil.h \
    qcocoatreeview.h \
    qcocoaitemview_p.h
SOURCES += $$PWD/qcocoatableview.mm \
    $$PWD/qcocoatextedit.mm \
    $$PWD/qcocoautil.mm \
    qcocoascrollview.mm \
    qcocoabaseview.mm \
    qcocoatoolbar.mm \
    qcocoatreeview.mm \
    qcocoaitemview.mm
LIBS += -framework \
    AppKit
