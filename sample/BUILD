load("@rules_android_cc_test//:defs.bzl", "cc_test")
cc_test(
    name = "gtest_samples",
    size = "small",
    srcs = [
        "@googletest//:googletest/samples/sample1_unittest.cc",
        "@googletest//:googletest/samples/sample2_unittest.cc",
        "@googletest//:googletest/samples/sample3_unittest.cc",
        "@googletest//:googletest/samples/sample4_unittest.cc",
        "@googletest//:googletest/samples/sample5_unittest.cc",
        "@googletest//:googletest/samples/sample6_unittest.cc",
        "@googletest//:googletest/samples/sample7_unittest.cc",
        "@googletest//:googletest/samples/sample8_unittest.cc",
    ],
    deps = [
        "@googletest//:gtest_sample_lib",
        "@googletest//:gtest_main",
    ],
    linkopts = [
        "-pthread",
    ]
)
