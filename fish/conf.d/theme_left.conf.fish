set -g pad " "

## Function to show a segment
function prompt_segment -d "Function to show a segment"
  # Get colors
  set -l bg $argv[1]
  set -l fg $argv[2]

  # Set 'em
  set_color -b $bg
  set_color $fg

  # Print text
  if [ -n "$argv[3]" ]
    echo -n -s $argv[3]
  end
end

## Function to show current status
function show_status -d "Function to show the current status"
  if [ $RETVAL -ne 0 ]
    prompt_segment red white " ▲ "
    set pad ""
    end
  if [ -n "$SSH_CLIENT" ]
      prompt_segment blue white " SSH: "
      set pad ""
    end
end

function show_virtualenv -d "Show active python virtual environments"
  if set -q VIRTUAL_ENV
    set -l venvname (basename "$VIRTUAL_ENV")
    prompt_segment normal white " ($venvname) "
  end
end

## Show user if not in default users
function show_user -d "Show user"
  if not contains $USER $default_user; or test -n "$SSH_CLIENT"
    set -l host (hostname -s)
    set -l who (whoami)
    prompt_segment normal yellow " $who"

    # Skip @ bit if hostname == username
    if [ "$USER" != "$HOST" ]
      prompt_segment normal white "@"
      prompt_segment normal green "$host "
      set pad ""
    end
  end
end

function _set_venv_project --on-variable VIRTUAL_ENV
    if test -e $VIRTUAL_ENV/.project
        set -g VIRTUAL_ENV_PROJECT (cat $VIRTUAL_ENV/.project)
    end
end

# Show directory
function show_pwd -d "Show the current directory"
  set -l pwd
  if [ (string match -r '^'"$VIRTUAL_ENV_PROJECT" $PWD) ]
    set pwd (string replace -r '^'"$VIRTUAL_ENV_PROJECT"'($|/)' '≫ $1' $PWD)
  else
    set pwd (prompt_pwd)
  end
  prompt_segment normal blue "$pad$pwd "
end

# Show prompt w/ privilege cue
function show_prompt -d "Shows prompt with cue for current priv"
  set -l uid (id -u $USER)
    if [ $uid -eq 0 ]
    prompt_segment red white " ! "
    set_color normal
    echo -n -s " "
  else
    prompt_segment normal white " \$ "
    end

  set_color normal
end

set suffix '❯'
## SHOW PROMPT
# function fish_prompt
#   set -g RETVAL $status
#   show_status
#   # show_virtualenv
#   # show_user
#   show_pwd
#   show_prompt
# end

# # name: clearance
# # ---------------
# # Based on idan. Display the following bits on the left:
# # - Virtualenv name (if applicable, see https://github.com/adambrenecki/virtualfish)
# # - Current directory name
# # - Git branch and dirty state (if inside a git repo)
#
# function _git_branch_name
#   echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
# end
#
# function _git_is_dirty
#   echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
# end
#
# function fish_prompt
#   set -l last_status $status
#
#   set -l cyan (set_color cyan)
#   set -l yellow (set_color yellow)
#   set -l red (set_color red)
#   set -l blue (set_color blue)
#   set -l green (set_color green)
#   set -l normal (set_color normal)
#
#   set -l cwd $blue(pwd | sed "s:^$HOME:~:")
#
#   # Output the prompt, left to right
#
#   # Add a newline before new prompts
#   echo -e ''
#
#   # Display [venvname] if in a virtualenv
#   if set -q VIRTUAL_ENV
#       echo -n -s (set_color -b cyan black) '[' (basename "$VIRTUAL_ENV") ']' $normal ' '
#   end
#
#   # Print pwd or full path
#   echo -n -s $cwd $normal
#
#   # Show git branch and status
#   if [ (_git_branch_name) ]
#     set -l git_branch (_git_branch_name)
#
#     if [ (_git_is_dirty) ]
#       set git_info '(' $yellow $git_branch "±" $normal ')'
#     else
#       set git_info '(' $green $git_branch $normal ')'
#     end
#     echo -n -s ' · ' $git_info $normal
#   end
#
#   set -l prompt_color $red
#   if test $last_status = 0
#     set prompt_color $normal
#   end
#
#   # Terminate with a nice prompt char
#   echo -e ''
#   echo -e -n -s $prompt_color '⟩ ' $normal
# end
