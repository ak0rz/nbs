LIBRARY()

SRCS(
    fake_llvm_symbolizer.cpp
)

PEERDIR(
    contrib/libs/llvm12/lib/DebugInfo/Symbolize
)

CFLAGS(
    -Wno-unused-but-set-variable
)

END()
