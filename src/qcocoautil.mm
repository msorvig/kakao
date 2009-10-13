#include "qcocoautil.h"
#import <AppKit/AppKit.h>

namespace QtCocoa
{
    
QString QCFString::toQString(CFStringRef str)
{
    if(!str)
        return QString();
    CFIndex length = CFStringGetLength(str);
    const UniChar *chars = CFStringGetCharactersPtr(str);
    if (chars)
        return QString(reinterpret_cast<const QChar *>(chars), length);
    
    QVarLengthArray<UniChar> buffer(length);
    CFStringGetCharacters(str, CFRangeMake(0, length), buffer.data());
    return QString(reinterpret_cast<const QChar *>(buffer.constData()), length);
}

QString QCFString::toQString()
{
    return QString(*this);
}

QCFString::operator QString() const
{
    if (string.isEmpty() && type)
        const_cast<QCFString*>(this)->string = toQString(type);
    return string;
}

CFStringRef QCFString::toCFStringRef(const QString &string)
{
    return CFStringCreateWithCharacters(0, reinterpret_cast<const UniChar *>(string.unicode()),
                                        string.length());
}

NSString * QCFString::toNSString(const QString &str)
{
    return (NSString *)toCFStringRef(str);
}

QCFString::operator CFStringRef() const
{
    if (!type)
        const_cast<QCFString*>(this)->type = toCFStringRef(string);
    return type;
}

NSArray *toNSArray(const QList<QString> &stringList)
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    foreach (const QString &qstring, stringList) {
        [array addObject : QCFString::toNSString(qstring)];
    }
    return array;
}

NSImage *toNSImage(const QPixmap &pixmap)
{
    NSBitmapImageRep *bitmapRep = [[NSBitmapImageRep alloc] initWithCGImage:pixmap.toMacCGImageRef()];
    NSImage *image = [[NSImage alloc] init];
    [image addRepresentation:bitmapRep];
    [bitmapRep release];
    return image;
}

QMacCocoaAutoReleasePool::QMacCocoaAutoReleasePool()
{
    NSApplicationLoad();
    pool = (void*)[[NSAutoreleasePool alloc] init];
}

QMacCocoaAutoReleasePool::~QMacCocoaAutoReleasePool()
{
    [(NSAutoreleasePool*)pool release];
}



}
