#ifndef CALCENGINE_H
#define CALCENGINE_H
#include <QObject>
class CalcEngine : public QObject
{
    Q_OBJECT
public:
    explicit CalcEngine(QObject* parent = 0);
    Q_INVOKABLE QString doCalcOp(const QString &aOp, const QString &aArg1, const QString &aArg2);
signals:
    
public slots:
};
#endif
