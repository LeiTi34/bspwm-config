# Defined in - @ line 1
function bspgit --wraps='vcsh bspwm-config' --description 'alias bspgit vcsh bspwm-config'
  vcsh bspwm-config $argv;
end
