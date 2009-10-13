#include <QtGui>
#include "qcocoascrollview.h"

class NSTextView;
class QCocoaTextEdit : public QCocoaScrollview
{
public:
    QCocoaTextEdit(QWidget *parent = 0);

    NSTextView *textView() const;

    void setPlainText(const QString &text);
    QString plainText();

    void setHtml(const QString &html);
    QString html();
};
