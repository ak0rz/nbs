UNITTEST_FOR(contrib/ydb/core/tx/columnshard)

FORK_SUBTESTS()

SPLIT_FACTOR(60)

IF (SANITIZER_TYPE == "thread" OR WITH_VALGRIND)
    TIMEOUT(3600)
    SIZE(LARGE)
    TAG(ya:fat)
    REQUIREMENTS(ram:16)
ELSE()
    TIMEOUT(600)
    SIZE(MEDIUM)
ENDIF()

PEERDIR(
    library/cpp/getopt
    library/cpp/regex/pcre
    library/cpp/svnversion
    contrib/ydb/core/testlib/default
    contrib/ydb/core/tx/columnshard/test_helper
    contrib/ydb/core/tx/columnshard/hooks/abstract
    contrib/ydb/core/tx/columnshard/hooks/testing
    contrib/ydb/core/tx/columnshard/common/tests
    contrib/ydb/core/tx/columnshard/test_helper
    contrib/ydb/services/metadata
    contrib/ydb/core/tx
    contrib/ydb/public/lib/yson_value
)

YQL_LAST_ABI_VERSION()

SRCS(
    columnshard_ut_common.cpp
    ut_columnshard_read_write.cpp
    ut_normalizer.cpp
    ut_backup.cpp
)

END()
