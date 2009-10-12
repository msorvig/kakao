#include <QtGui>
#include <CoreFoundation/CoreFoundation.h>

#ifndef QCOCOAUTIL_H
#define QCOCOAUTIL_H

class NSString;
namespace QtCocoa
{
    template <typename T>
    class QCFType
    {
    public:
        inline QCFType(const T &t = 0) : type(t) {}
        inline QCFType(const QCFType &helper) : type(helper.type) { if (type) CFRetain(type); }
        inline ~QCFType() { if (type) CFRelease(type); }
        inline operator T() { return type; }
        inline QCFType operator =(const QCFType &helper)
        {
            if (helper.type)
                CFRetain(helper.type);
            CFTypeRef type2 = type;
            type = helper.type;
            if (type2)
                CFRelease(type2);
            return *this;
        }
        inline T *operator&() { return &type; }
        static QCFType constructFromGet(const T &t)
        {
            CFRetain(t);
            return QCFType<T>(t);
        }
    protected:
        T type;
    };
    
    class QCFString : public QCFType<CFStringRef>
    {
    public:
        inline QCFString(const QString &str) : QCFType<CFStringRef>(0), string(str) {}
        inline QCFString(const CFStringRef cfstr = 0) : QCFType<CFStringRef>(cfstr) {}
        inline QCFString(const NSString *nsstring) : QCFType<CFStringRef>(CFStringRef(nsstring)) {}
        inline QCFString(const QCFType<CFStringRef> &other) : QCFType<CFStringRef>(other) {}
        operator QString() const;
        operator CFStringRef() const;
        static QString toQString(CFStringRef cfstr);
        static CFStringRef toCFStringRef(const QString &str);
        static NSString * toNSString(const QString &str);
    private:
        QString string;
    };
  
    class QMacCocoaAutoReleasePool
    {
    private:
        void *pool;
    public:
        QMacCocoaAutoReleasePool();
        ~QMacCocoaAutoReleasePool();

        inline void *handle() const { return pool; }
    };

}


#endif QCOCOAUTIL_H
