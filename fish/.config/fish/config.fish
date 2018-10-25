function fish_prompt
    # c0 to c4 progress from dark to bright
    # ce is the error colour
    set -g c0 (set_color 769286)
    set -g c1 (set_color 0075cd)
    set -g c2 (set_color C7BA8D)
    set -g c3 (set_color e7e5c8)
    set -g c4 (set_color ffffff)
    set -g ce (set_color $fish_color_error)

    # Clear the line because fish seems to emit the prompt twice. The initial
    # display, then when you press enter.
    printf "\033[K"

    # Current time
    printf "$c0╓─"
    printf "$c0"
    printf (date "+[$c2%H$c0:$c2%M$c0:$c2%S$c0] ")

    # printf (pwd | sed "s,/,$c0/$c1,g" | sed "s,\(.*\)/[^m]*m,\1/$c3,")
    printf (prompt_pwd)
    printf "\n"
    printf "$c0╙─[$c3"
    printf "$USER"
    printf "$c0@"
    printf (prompt_hostname)
    printf "] $c3\$ "
end



function last_job_id -d "Get the id of one or more existing jobs"
    builtin jobs $argv | command awk -v FS=\t '
        /[0-9]+\t/{
            aJobs[++nJobs] = $1
        }
        END {
            for (i = 1; i <= nJobs; i++) {
                print(aJobs[i])
            }
            exit nJobs == 0
        }
    '
end



function humanize_duration -d "Humanize a time interval for display"
    command awk '
        function hmTime(time,   stamp) {
            split("h:m:s:ms", units, ":")
            for (i = 2; i >= -1; i--) {
                if (t = int( i < 0 ? time % 1000 : time / (60 ^ i * 1000) % 60 )) {
                    stamp = stamp t units[sqrt((i - 2) ^ 2) + 1] " "
                }
            }
            if (stamp ~ /^ *$/) {
                return "0ms"
            }
            return substr(stamp, 1, length(stamp) - 1)
        }
        { 
            print hmTime($0) 
        }
    '
end



function fish_right_prompt
    for color in $fish_color_error
        # If any of the colour variables aren't defined they're set to 'normal' colour

        if set -q color
            set color normal
        end
    end

    set -l status_copy $status
    set -l status_color 0fc

    if test "$status_copy" -ne 0
        set status_color $fish_color_error
    end

    if test -n "$CMD_DURATION" -a "$CMD_DURATION" -gt 10
        set -l duration_copy $CMD_DURATION
        set -l duration (echo $CMD_DURATION | humanize_duration)

        echo -sn (set_color $status_color) "$duration" (set_color normal)

    else if set -l last_job_id (last_job_id -l)
        echo -sn (set_color $status_color) "%$last_job_id" (set_color normal)
    else
        echo -sn (set_color 555) (date "+%H:%M") (set_color normal)
    end
end


function fish_user_key_bindings
    # Key bindings
    bind \e\[7~ end-of-line
    bind \e\[8~ beginning-of-line
end

# Disable "Welcom to fish..." greeting
set fish_greeting

source "$HOME/.config/fish/custom.fish"
