#ifndef SERVER_H
#define SERVER_H

#include <QObject>
#include <QTcpServer>
#include <QTcpSocket>
#include <QDataStream>
#include <QImage>

#include <serverimageprovider.h>

class Server: public QObject
{
    Q_OBJECT
public:
    explicit Server(QObject *parent = nullptr);
    QImage image;
    ServerImageProvider *imageProvider;
    ~Server();

signals:
    void imageUpdated();
    void waiting();
    void connected();
    void stopped();
public slots:
    void startListening(const QString& address, const QString& port);
    void stopListening();

private slots:
    void connectionReceived();
    void readImage();


private:
    QTcpServer *tcpServer = nullptr;
    QTcpSocket *tcpSocket;
    qint64 imageSize = 0;
    qint32 imageFormat = 0;
    qint32 imageWidth = 0;
    qint32 imageHeight = 0;
};

#endif // SERVER_H
