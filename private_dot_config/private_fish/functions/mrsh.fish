function mrsh
    if test (count $argv) -eq 0
        echo "Usage: mrsh <sub-command> [arguments]"
        echo "Sub-commands:"
        echo "  switch <exit-node-ip>: Change the exit node IP for Tailscale"
        return 1
    end

    set sub_command $argv[1]

    switch $sub_command
        case 'switch'
            if test (count $argv) -eq 2
                set exit_node_ip $argv[2]
                echo "Switching to exit node IP: $exit_node_ip"
                sudo tailscale up --exit-node=$exit_node_ip
            else
                echo "Usage: mrsh switch <exit-node-ip>"
            end

        # Add other sub-commands here using the same structure
        # case 'sub-command-name'
        #    ... (implementation)
        # end

        case 'stop-exit'
          echo "Leaving exit node"
          sudo tailscale up --exit-node=""

        case '*'
            echo "Unknown sub-command: $sub_command"
            echo "Usage: mrsh <sub-command> [arguments]"
    end
end

