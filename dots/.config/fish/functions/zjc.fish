function zjc
    if test (count $argv) -gt 0
        zellij attach -c $argv[1]
    else
        zellij attach -c unnamed_session
    end
end
