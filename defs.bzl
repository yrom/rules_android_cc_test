""" Rules for running cc_test on Android device """

def _cc_test(
        name,
        size = "small",
        srcs = [],
        includes = None,
        deps = [],
        linkopts = [],
        **kargs):
    native.cc_test(
        name = name,
        size = size,
        srcs = srcs,
        includes = includes,
        deps = deps,
        linkopts = linkopts + select({
            "@rules_android_cc_test//:android": [
                "-ldl",
                "-lm",
                "-landroid",
            ],
            "//conditions:default": [],
        }),
        linkstatic = select({
            "@rules_android_cc_test//:android": 1,
            "//conditions:default": 0,
        }),
        **kargs
    )

    native.sh_test(
        name = name + "_android",
        size = size,
        srcs = [
            "@rules_android_cc_test//:android_cc_test_wrapper.sh"
        ],
        args = [
            "$(location :{})".format(name),
            "--adb", "$(execpath @androidsdk//:adb)",
            "--",
        ],
        data = [
            ":"+name,
            "@androidsdk//:adb",
        ],
        tags = ["manual"],
    )

cc_test = _cc_test
