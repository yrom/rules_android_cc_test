load("@rules_android_cc_test//:defs.bzl", "cc_test")
cc_test(
    name = "gtest_samples",
    size = "small",
    srcs = [
        "@com_google_googletest//:googletest/samples/sample1_unittest.cc",
        "@com_google_googletest//:googletest/samples/sample2_unittest.cc",
        "@com_google_googletest//:googletest/samples/sample3_unittest.cc",
        "@com_google_googletest//:googletest/samples/sample4_unittest.cc",
        "@com_google_googletest//:googletest/samples/sample5_unittest.cc",
        "@com_google_googletest//:googletest/samples/sample6_unittest.cc",
        "@com_google_googletest//:googletest/samples/sample7_unittest.cc",
        "@com_google_googletest//:googletest/samples/sample8_unittest.cc",
    ],
    deps = [
        "@com_google_googletest//:gtest_sample_lib",
        "@com_google_googletest//:gtest_main",
    ],
    linkopts = [
        "-pthread",
    ]
)
