#ifndef CLIENT_H
#define CLIENT_H

#include <QObject>
#include <QTcpSocket>
#include <QImage>
#include <QDataStream>
#include <QByteArray>
#include <QVariant>
#include <QUrl>
#include <QHostAddress>

class Client : public QObject
{
    Q_OBJECT
public:
    explicit Client(QObject *parent = nullptr);
    QImage *image;
signals:
    void disconnected();
    void connected();
public slots:
    void connectToServer(const QString& address, const QString& port);
    void sendImage(const QUrl& url);
    void disconnect();
private:
    QTcpSocket *tcpSocket;
};

#endif // CLIENT_H
