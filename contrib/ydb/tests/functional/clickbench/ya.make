IF (NOT SANITIZER_TYPE)

PY3TEST()

TEST_SRCS(test.py)

TIMEOUT(600)
SIZE(MEDIUM)

ENV(YDB_USE_IN_MEMORY_PDISKS=true)
ENV(YDB_CLI_BINARY="contrib/ydb/apps/ydb/ydb")
REQUIREMENTS(
    ram:32
    cpu:4
)

DEPENDS(
    contrib/ydb/apps/ydb
)

PEERDIR(
    contrib/ydb/tests/oss/ydb_sdk_import
    contrib/ydb/public/sdk/python
    contrib/python/PyHamcrest
)

INCLUDE(${ARCADIA_ROOT}/contrib/ydb/public/tools/ydb_recipe/recipe.inc)

FORK_SUBTESTS()
FORK_TEST_FILES()
END()

ENDIF()
