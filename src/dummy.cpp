#include <iostream>
#include <uWebSockets/App.h>
#include <libusockets.h>

int main(int argc, const char *argv[]) {
    int port = 9001;
    uWS::App().get("/*", [](auto *res, auto *req) {
        res->end("Hello World!");
    }).listen(port, [](auto *listenSocket) {
        if (listenSocket) {
            std::cout << "Listening for connections...";
        }
    }).run();

    std::cout << "Shoot! We failed to listen and the App fell through, exiting now!";
}