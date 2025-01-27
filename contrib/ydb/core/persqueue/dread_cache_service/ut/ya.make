UNITTEST_FOR(contrib/ydb/core/persqueue)

FORK_SUBTESTS()

IF (SANITIZER_TYPE == "thread" OR WITH_VALGRIND)
    SIZE(LARGE)
    TAG(ya:fat)
    TIMEOUT(300)
ELSE()
    SIZE(MEDIUM)
    TIMEOUT(60)
ENDIF()

PEERDIR(
    contrib/ydb/core/persqueue/ut/common
    contrib/ydb/core/testlib/default
    contrib/ydb/public/sdk/cpp/client/ydb_persqueue_core/ut/ut_utils
)

YQL_LAST_ABI_VERSION()

SRCS(
    caching_proxy_ut.cpp
)

# RESOURCE(
# )

END()
