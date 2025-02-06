function bazel-directories
    set -l BAZEL bazel-6.5.0
    set -l output_base ($BAZEL info output_base)
    set -l infokeys \
        command_log execution_root output_path \
        bazel-{bin,genfiles,testlogs}

    $BAZEL info workspace output_base |
        string replace $HOME ~ | string replace base: "base: $(set_color blue)⚙ ="

    set_color normal
    echo

    begin
        echo info-key: path
        echo --------: ----
        $BAZEL info $infokeys
    end |
        string replace $output_base/ "$(set_color blue)⚙/$(set_color normal)" |
        column -ts:
end
