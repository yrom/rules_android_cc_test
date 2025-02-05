exports_files(glob(["*.bzl"]) + ["android_cc_test_wrapper.sh"])

config_setting(
    name = "android",
    constraint_values = [
       "@platforms//os:android",
    ],
)

platform(
    name = "android_arm64-v8a",
    constraint_values = [
        "@platforms//os:android",
        "@platforms//cpu:arm64",
    ],
)

platform(
    name = "android_x86_64",
    constraint_values = [
        "@platforms//os:android",
        "@platforms//cpu:x86_64",
    ],
)