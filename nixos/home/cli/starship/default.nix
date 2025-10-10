{
  pkgs,
  lib,
  config,
  ...
}:

{
  programs.starship = {
    enable = true;
    settings = {
      character = {
        success_symbol = "[❯](green)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](green)";
      };

      directory = {
        read_only = " 󰌾";
        style = "bold lavender";
      };

      git_branch = {
        symbol = " ";
        style = "bold flamingo";
      };

      os.symbols = {
        Alpaquita = " ";
        Alpine = " ";
        Amazon = " ";
        Android = " ";
        Arch = " ";
        Artix = " ";
        CentOS = " ";
        Debian = " ";
        DragonFly = " ";
        Emscripten = " ";
        EndeavourOS = " ";
        Fedora = " ";
        FreeBSD = " ";
        Garuda = "󰛓 ";
        Gentoo = " ";
        HardenedBSD = "󰞌 ";
        Illumos = "󰈸 ";
        Linux = " ";
        Mabox = " ";
        Macos = " ";
        Manjaro = " ";
        Mariner = " ";
        MidnightBSD = " ";
        Mint = " ";
        NetBSD = " ";
        NixOS = " ";
        OpenBSD = "󰈺 ";
        openSUSE = " ";
        OracleLinux = "󰌷 ";
        Pop = " ";
        Raspbian = " ";
        Redhat = " ";
        RedHatEnterprise = " ";
        Redox = "󰀘 ";
        Solus = "󰠳 ";
        SUSE = " ";
        Ubuntu = " ";
        Unknown = " ";
        Windows = "󰍲 ";
      };

      aws.symbol = "  ";
      buf.symbol = " ";
      c.symbol = " ";
      conda.symbol = " ";
      crystal.symbol = " ";
      dart.symbol = " ";
      docker_context.symbol = " ";
      elixir.symbol = " ";
      elm.symbol = " ";
      fennel.symbol = " ";
      fossil_branch.symbol = " ";
      golang.symbol = " ";
      guix_shell.symbol = " ";
      haskell.symbol = " ";
      haxe.symbol = " ";
      hg_branch.symbol = " ";
      hostname.ssh_symbol = " ";
      java.symbol = " ";
      julia.symbol = " ";
      kotlin.symbol = " ";
      lua.symbol = " ";
      memory_usage.symbol = "󰍛 ";
      meson.symbol = "󰔷 ";
      nim.symbol = "󰆥 ";
      nix_shell.symbol = " ";
      nodejs.symbol = " ";
      ocaml.symbol = " ";
      package.symbol = "󰏗 ";
      perl.symbol = " ";
      php.symbol = " ";
      pijul_channel.symbol = " ";
      python.symbol = " ";
      rlang.symbol = "󰟔 ";
      ruby.symbol = " ";
      rust.symbol = " ";
      scala.symbol = " ";
      swift.symbol = " ";
      zig.symbol = " ";
    }
    // lib.optionalAttrs config.programs.jujutsu.enable {
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$localip"
        "$shlvl"
        "$singularity"
        "$kubernetes"
        "$directory"
        "$vcsh"
        "$fossil_branch"
        "$fossil_metrics"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_metrics"
        "$git_status"
        "\${custom.jj}"
        "$all"
      ];

      custom.jj = {
        command = "prompt";
        format = "$output";
        ignore_timeout = true;
        shell = [
          "${lib.getExe pkgs.starship-jj}"
          "--ignore-working-copy"
          "starship"
        ];
        use_stdin = false;
        when = true;
      };
    };
  };

  xdg.configFile = lib.optionalAttrs config.programs.jujutsu.enable {
    "starship-jj/starship-jj.toml".source = (pkgs.formats.toml { }).generate "starship-jj-config" {
      module_separator = " ";

      module = [
        {
          type = "Symbol";
          symbol = " 󱗆 ";
          color = "Blue";
        }
        {
          type = "Bookmarks";
          separator = " ";
          color = "Red";
          behind_symbol = "⇡";
          surround_with_quotes = false;
        }
        {
          type = "Commit";
          max_length = 24;
          color = "Green";
          surround_with_quotes = false;
        }
        {
          type = "State";
        }
        {
          type = "Metrics";
        }
      ];
    };
  };
}
