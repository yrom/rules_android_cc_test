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

    android_executable(
        name = name + "_android",
        target = name,
        testonly = 1,
    )

def _android_executable(ctx):
    runfiles = ctx.runfiles(
        files = ctx.files.target + [
            ctx.executable._adb,
        ],
    )
    script = ctx.actions.declare_file(ctx.label.name + ".sh")
    ctx.actions.expand_template(
        output = script,
        is_executable = True,
        template = ctx.file._template,
        substitutions = {
            "{adb}": str(ctx.executable._adb.path),
            "{name}": str(ctx.attr.target.label.name),
        },
    )
    return [
        DefaultInfo(runfiles = runfiles, executable = script),
    ]

android_executable = rule(
    attrs = {
        "target": attr.label(),
        "_template": attr.label(allow_single_file = True, default = "android_cc_test.sh.tpl"),
        "_adb": attr.label(
            default = Label("@androidsdk//:adb"),
            allow_single_file = True,
            executable = True,
            cfg = "exec",
        ),
    },
    executable = True,
    implementation = _android_executable,
)

cc_test = _cc_test
