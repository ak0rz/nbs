LIBRARY()

SRCS(
    yql_ut_common.cpp
    yql_ut_common.h
)

PEERDIR(
    contrib/ydb/library/yql/core
    contrib/ydb/library/yql/core/expr_nodes
    contrib/ydb/library/yql/dq/proto
    contrib/ydb/library/yql/dq/expr_nodes
)


YQL_LAST_ABI_VERSION()


END()