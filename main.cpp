#include <QDeclarativeView>
#include <QApplication>
#include <QGLWidget>

int main(int argc, char **argv)
{
    QApplication a(argc, argv);
    QDeclarativeView view;
    view.setSource(QUrl::fromLocalFile("./main.qml"));
    view.setResizeMode(QDeclarativeView::SizeRootObjectToView);
//    view.setViewport(new QGLWidget);
    view.show();
    return a.exec();
}
