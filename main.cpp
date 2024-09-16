#include <QGuiApplication>
#include <QQmlContext>
#include <QQmlApplicationEngine>
#include "../client/patient/patient.h"
#include "../client/doctor/doctor.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    // 创建一个 Patient 实例
    Patient patient;
    Doctor doctor;

    // 将 Patient 类实例注册到 QML 上下文中，  这都是全局变量
    engine.rootContext()->setContextProperty("patient", &patient);
    engine.rootContext()->setContextProperty("doctor", &doctor);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.load("../qt_test3/Main.qml");   // 这个必须改，我们最后的可执行程序在output
    //engine.load("qt_test3/pages/EditDoctorInfo.qml");
    //engine.load("qt_test3/pages/EditPatientInfo.qml");
    
    return app.exec();
}
