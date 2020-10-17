set(BOOST_VERSION "1.74.0")
string(REPLACE "." "_" BOOST_VERSION_UNDERSCORE ${BOOST_VERSION})

set(BOOST_URL "https://dl.bintray.com/boostorg/release/${BOOST_VERSION}/source/boost_${BOOST_VERSION_UNDERSCORE}.tar.bz2")
set(BOOST_HASH "SHA256=83bfc1507731a0906e387fc28b7ef5417d591429e51e788417fe9ff025e116b1")

set(CATCH_URL "https://github.com/catchorg/Catch2.git")
set(CATCH_TAG "v3.0.0-preview3")

set(SPDLOG_URL "https://github.com/gabime/spdlog.git")
set(SPDLOG_TAG "v1.8.1")

set(UNIVALUE_URL "https://github.com/jgarzik/univalue.git")
set(UNIVALUE_TAG "v1.0.5")

set(LIBEVENT_URL "https://github.com/libevent/libevent.git")
set(LIBEVENT_TAG "release-2.1.12-stable")

set(LIBEVHTP_URL "https://github.com/criticalstack/libevhtp.git")
set(LIBEVHTP_TAG "1.2.18")

set(RDKAFKA_URL "https://github.com/edenhill/librdkafka.git")
set(RDKAFKA_TAG "v1.4.2")

set(CPPKAFKA_URL "https://github.com/mfontanini/cppkafka.git")
set(CPPKAFKA_TAG "origin/master")

set(FMT_URL "https://github.com/fmtlib/fmt.git")
set(FMT_TAG "7.0.3")

set(SNAPPY_URL "https://github.com/google/snappy.git")
set(SNAPPY_TAG "1.1.8")