
PY3_PROGRAM(tz_gen)

SRCDIR(contrib/ydb/library/yql/public/udf/tz)

PY_SRCS(
    TOP_LEVEL
    update.py
)

PY_MAIN(update)

END()

