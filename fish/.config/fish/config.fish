if status is-interactive
    # Commands to run in interactive sessions can go here
    abbr -a -- k kubectl
    if test -z (pgrep ssh-agent)
        ssh-agent -c | sed 's/^echo/#echo/' >$SSH_ENV
        chmod 600 $SSH_ENV
        source $SSH_ENV >/dev/null
    else
        source $SSH_ENV >/dev/null
    end
end
starship init fish | source
