let-env config = {
  show_banner: false
  cursor_shape: {
    vi_normal: block
    vi_insert: line
  }
  edit_mode: vi
  render_right_prompt_on_last_line: true
  rm: {
    always_trash: true
  }
  keybindings: [ ]
}

let-env PROMPT_INDICATOR_VI_INSERT = "I "
let-env PROMPT_INDICATOR_VI_NORMAL = "N "

source ~/.cache/starship/init.nu
