{ pkgs, ... }:

{
  imports = [ ../rofi ];

  home.packages = with pkgs; [
    keepmenu
    wtype
  ];

  xdg.configFile."keepmenu/config.ini".text = ''
    [dmenu]
    dmenu_command = rofi -dmenu -i -theme-str 'window {width: 1000px;}'
    # title_path = <True>, <False> or <int>. Length of database path to display.

    [dmenu_passphrase]
    # Uses the -password flag for Rofi. For dmenu, sets -nb and -nf to the same color.
    obscure = True
    obscure_color = #222222

    [database]
    database_1 = ~/keepass/Passwords.kdbx
    database_2 = ~/keepass-dilshod/myfile.kdbx
    # # Override autotype default from database_2
    # autotype_default_2 = {TOTP}{ENTER}
    # etc....
    # pw_cache_period_min = <minutes to cache database password>

    editor = nvim
    terminal = kitty
    type_library = wtype
    # hide_groups = Recycle Bin  <Note formatting for adding multiple groups>
    #               Group 2
    #               Group 3
  '';
}
