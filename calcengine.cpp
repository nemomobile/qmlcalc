#include <QDebug>
#include "calcengine.h"

CalcEngine::CalcEngine(QObject *parent) :
    QObject(parent)
{
}

QString CalcEngine::doCalcOp(const QString& aOp,const  QString& aArg1,const  QString& aArg2)
{
    // In javascript side the Number type lead to loss of precision (e.g. 2.01-2 result incorrect).
    // Calculating this way seems to give more precise presentation.
    double dblRes = 0;
    if(aOp == "-")
    {
        dblRes = aArg1.toDouble() - aArg2.toDouble();
    }
    else if(aOp == "+")
    {
        dblRes = aArg1.toDouble() + aArg2.toDouble();
    }
    else if(aOp == "*")
    {
        dblRes = aArg1.toDouble() * aArg2.toDouble();
    }
    else if(aOp == "/")
    {
        dblRes = aArg1.toDouble() / aArg2.toDouble();
    }
    else
    {
    qWarning() << "CalcEngine::doCalcOp: unsupported operation!!: " << aOp;
    }

    QString strRes = QString("%1").arg(dblRes, 0, 'g',13); // 13 seems to give the best presentation...
    // qDebug() << "CalcEngine::doCalcOp() " << aArg1 << aOp << aArg2 << "="<< strRes;
    return strRes;
}
