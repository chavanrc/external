set(BOOST_VERSION "1.73.0")
string(REPLACE "." "_" BOOST_VERSION_UNDERSCORE ${BOOST_VERSION})

#set(BOOST_URL "https://sourceforge.net/projects/boost/files/boost/${BOOST_VERSION}/boost_${BOOST_VERSION_UNDERSCORE}.tar.bz2/download")
#set(BOOST_HASH "SHA1=6d6ed02b29c860fd21b274fc4e1f820855e765e9")
set(BOOST_URL "https://dl.bintray.com/boostorg/release/${BOOST_VERSION}/source/boost_${BOOST_VERSION_UNDERSCORE}.tar.bz2")
set(BOOST_HASH "SHA256=4eb3b8d442b426dc35346235c8733b5ae35ba431690e38c6a8263dce9fcbb402")

set(UWEBSOCKETS_URL "https://github.com/uNetworking/uWebSockets.git")
set(UWEBSOCKETS_TAG "v18.6.0")

set(CATCH_URL "https://github.com/catchorg/Catch2.git")
set(CATCH_TAG "b1b5cb812277f367387844aab46eb2d3b15d03cd")

set(NLOHMANN_URL "https://github.com/nlohmann/json.git")
set(NLOHMANN_TAG "e7b3b40b5a95bc74b9a7f662830a27c49ffc01b4")

set(SPDLOG_URL "https://github.com/gabime/spdlog.git")
set(SPDLOG_TAG "22a169bc319ac06948e7ee0be6b9b0ac81386604")