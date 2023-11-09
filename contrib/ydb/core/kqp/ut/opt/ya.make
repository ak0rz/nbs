UNITTEST_FOR(contrib/ydb/core/kqp)

FORK_SUBTESTS()
SPLIT_FACTOR(50)

IF (WITH_VALGRIND)
    TIMEOUT(3600)
    SIZE(LARGE)
    TAG(ya:fat)
ELSE()
    TIMEOUT(600)
    SIZE(MEDIUM)
ENDIF()

SRCS(
    kqp_agg_ut.cpp
    kqp_extract_predicate_unpack_ut.cpp
    kqp_kv_ut.cpp
    kqp_merge_ut.cpp
    kqp_ne_ut.cpp
    kqp_not_null_ut.cpp
    kqp_ranges_ut.cpp
    kqp_sort_ut.cpp
    kqp_sqlin_ut.cpp
)

PEERDIR(
    contrib/ydb/core/kqp
    contrib/ydb/core/kqp/ut/common
    contrib/ydb/library/yql/sql/pg
    contrib/ydb/library/yql/parser/pg_wrapper
    contrib/ydb/library/yql/udfs/common/re2
)

ADDINCL(
    contrib/ydb/library/yql/parser/pg_wrapper/postgresql/src/include
)

NO_COMPILER_WARNINGS()

YQL_LAST_ABI_VERSION()

END()