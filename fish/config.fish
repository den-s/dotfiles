set -x PATH $PATH /sbin/

alias ll='ls -lah'
alias v=nvim
alias rnios11pm='command arch -x86_64 npx react-native run-ios --simulator "iPhone 11 Pro Max"'
alias clean_node_modules='fish ~/dotfiles/fish/clean_node_modules.sh'
alias rniosdevice='command npx react-native run-ios --device'
alias rnios11='command npx react-native run-ios --simulator "iPhone 11"'
alias rnios12='command npx react-native run-ios --simulator "iPhone 12"'
alias rnios8='command npx react-native run-ios --simulator "iPhone 8"'

set -xg PYTHONPATH /opt/homebrew/lib/python3.9

set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --glob "!.git/*" --glob "!node_modules/*"'
set -x ANDROID_HOME $HOME/Library/Android/sdk
set -x LANG en_US.UTF-8
set -x LC_ALL $LANG
set -gx EDITOR nvim
# set -x JAVA_HOME /Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home
set -x JAVA_HOME /Library/Java/JavaVirtualMachines/zulu-13.jdk/Contents/Home

set -x LFLAGS /opt/homebrew/lib/
# set -x CFLAGS = -g -Wall -Wextra -pedantic -Werror -target x86_64-apple-darwin20.3.0

set PATH /opt/homebrew/bin $PATH

set PATH $PATH $ANDROID_HOME/emulator
set PATH $PATH $ANDROID_HOME/tools
set PATH $PATH $ANDROID_HOME/tools/bin
set PATH $PATH $ANDROID_HOME/platform-tools

set PATH $PATH $HOME/Software/ruby/bin

set PATH $PATH /opt/homebrew/opt/ruby/bin
set PATH $PATH /opt/homebrew/opt/node@14/bin
set PATH $PATH /opt/homebrew/lib/ruby/gems/3.0.0/bin
set PATH $PATH $JAVA_HOME
set PATH $PATH /opt/homebrew/Cellar/maven/3.8.5/libexec

# export NVM_DIR="$HOME/.nvm"
#   [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
#   [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

function ibrew --wraps brew --description 'brew for x86 packages'
    arch --x86_64 /usr/local/bin/brew $argv
end

function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.

    if not set -q __fish_git_prompt_show_informative_status
        set -g __fish_git_prompt_show_informative_status 1
    end
    if not set -q __fish_git_prompt_hide_untrackedfiles
        set -g __fish_git_prompt_hide_untrackedfiles 1
    end
    if not set -q __fish_git_prompt_color_branch
        set -g __fish_git_prompt_color_branch magenta --bold
    end
    if not set -q __fish_git_prompt_showupstream
        set -g __fish_git_prompt_showupstream informative
    end
    if not set -q __fish_git_prompt_char_upstream_ahead
        set -g __fish_git_prompt_char_upstream_ahead "↑"
    end
    if not set -q __fish_git_prompt_char_upstream_behind
        set -g __fish_git_prompt_char_upstream_behind "↓"
    end
    if not set -q __fish_git_prompt_char_upstream_prefix
        set -g __fish_git_prompt_char_upstream_prefix ""
    end
    if not set -q __fish_git_prompt_char_stagedstate
        set -g __fish_git_prompt_char_stagedstate "●"
    end
    if not set -q __fish_git_prompt_char_dirtystate
        set -g __fish_git_prompt_char_dirtystate "✚"
    end
    if not set -q __fish_git_prompt_char_untrackedfiles
        set -g __fish_git_prompt_char_untrackedfiles "…"
    end
    if not set -q __fish_git_prompt_char_invalidstate
        set -g __fish_git_prompt_char_invalidstate "✖"
    end
    if not set -q __fish_git_prompt_char_cleanstate
        set -g __fish_git_prompt_char_cleanstate "✔"
    end
    if not set -q __fish_git_prompt_color_dirtystate
        set -g __fish_git_prompt_color_dirtystate blue
    end
    if not set -q __fish_git_prompt_color_stagedstate
        set -g __fish_git_prompt_color_stagedstate yellow
    end
    if not set -q __fish_git_prompt_color_invalidstate
        set -g __fish_git_prompt_color_invalidstate red
    end
    if not set -q __fish_git_prompt_color_untrackedfiles
        set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
    end
    if not set -q __fish_git_prompt_color_cleanstate
        set -g __fish_git_prompt_color_cleanstate green --bold
    end

    set -g __fish_git_prompt_shorten_branch_len 20

    set -l color_cwd
    set -l suffix
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        else
            set color_cwd $fish_color_cwd
        end
        set suffix '#'
    else
        set color_cwd $fish_color_cwd
        set suffix '❯'
    end

    # PWD
    set_color $color_cwd
    echo -n (prompt_pwd)
    set_color normal

    printf '%s' (fish_vcs_prompt)

    set -l pipestatus_string (__fish_print_pipestatus "[" "] " "|" (set_color $fish_color_status) (set_color --bold $fish_color_status) $last_pipestatus)
    echo -n $pipestatus_string
    set_color normal

    echo -n "$suffix "
end

function fish_right_prompt -d "Write out the right prompt"
    set_color $fish_color_cwd
    set -l git_branch (git branch 2> /dev/null | sed -n '/\* /s///p')
    set -l local_date (date '+%d.%m.%y•%H:%M:%S')
    if test -n "$git_branch"
      # set delimiter ', '
      set delimiter ''
    else
      set delimiter ''
    end
    # printf '[%s%s%s]' $local_date $delimiter $git_branch
    printf '%s%s' $delimiter $git_branch
end
set -g fish_user_paths "/opt/homebrew/opt/ruby/bin" $fish_user_paths

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/den/Downloads/google-cloud-sdk/path.fish.inc' ]; . '/Users/den/Downloads/google-cloud-sdk/path.fish.inc'; end
