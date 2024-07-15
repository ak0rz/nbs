PY3TEST()

INCLUDE(${ARCADIA_ROOT}/contrib/ydb/tests/tools/fq_runner/ydb_runner_with_datastreams.inc)

PEERDIR(
    contrib/ydb/core/fq/libs/http_api_client
    contrib/ydb/tests/tools/datastreams_helpers
    contrib/ydb/tests/tools/fq_runner
    library/python/retry
)

PY_SRCS(
    test_base.py
)

TEST_SRCS(
    test_http_api.py
)

SIZE(MEDIUM)

END()
