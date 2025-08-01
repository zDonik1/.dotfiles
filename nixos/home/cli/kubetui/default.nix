{ pkgs, ... }:

{
  home.packages = with pkgs; [ kubetui ];

  xdg.configFile."kubetui/config.yaml".text = ''
    # version: "1"

    # fg_color: "default" | name | hex | integer
    # bg_color: "default" | name | hex | integer
    # modifier: "none" | "bold" | "dim" | "italic" | "underlined" | "slow_blink" | "rapid_blink" | "reversed" | "hidden" | "crossed_out"
    # border.type: "plain" | "rounded" | "double" | "thick"

    theme:
      base:
        bg_color: "default"
      tab:
        divider:
          char: "|"
        base:
          fg_color: "#f4dbd6"
          modifier: reversed
        active:
          fg_color: "#f5a97f"
          modifier: reversed
        mouse_over:
          fg_color: green
          modifier: reversed
      header:
        cluster:
          fg_color: magenta
        namespaces:
          fg_color: yellow
      component:
        base:
          fg_color: blue
        title:
          active:
            fg_color: green
          inactive:
            fg_color: "#cad3f5"
        border:
          type: "rounded"
          active:
            fg_color: blue
          inactive:
            fg_color: "#cad3f5"
          mouse_over:
            fg_color: red

        ## Text component
        text:
          ## Search form
          search:
            form:
              # base:
              #   fg_color: yellow
              prefix:
                fg_color: yellow
              query:
                fg_color: yellow
              suffix:
                fg_color: yellow

            ## Highlight the matched string in the search
            highlight:
              ## Highlight the string that is focused in the string that matches the search
              focus:
                fg_color: yellow
                modifier: reversed

              ## Highlight the string that matches the search
              matches:
                modifier: reversed

          ## Highlight when selecting a range with the mouse
          selection:
            fg_color: green
            modifier: reversed

        ## Table component
        table:
          ## Filter form
          filter:
            # base:
            #   fg_color: magenta
            # border:
            #   type: "double"
            #   active:
            #     fg_color: green
            #   inactive:
            #     fg_color: blue
            prefix:
              fg_color: dark_gray
            query:
              fg_color: yellow
          header:
            fg_color: lightblue
            modifier: bold

        ## Select list component
        list:
          ## Filter form
          filter:
            # base:
            #   fg_color: magenta
            # border:
            #   type: "double"
            #   active:
            #     fg_color: green
            #   inactive:
            #     fg_color: blue
            query:
              fg_color: yellow

          ## Highlight the selected item
          selected_item:
            fg_color: green
            modifier: reversed

          ## Item index and total count
          status:
            fg_color: yellow

        ## Input form
        input:
          fg_color: white

        ## Dialog component
        dialog:
          ## Override the theme.base
          # base:
          #   bg_color: "#000000"

          size:
            ## 0.0 ~ 100.0
            width: 85
            ## 0.0 ~ 100.0
            height: 85

      ## Pod view
      pod:
        ## Highlights according to the status of the pod
        highlights:
          - status: Running # Regex
            fg_color: default
          - status: (Completed|Evicted)
            fg_color: green
          - status: (BackOff|Err|Unknown)
            fg_color: red

      ## Event view
      event:
        highlights:
          - type: Normal # Regex
            summary:
              fg_color: blue
            message:
              fg_color: dark_gray
          - type: Warning
            summary:
              fg_color: yellow
            message:
              fg_color: dark_gray

      ## API view
      api:
        table:
          resource:
            fg_color: magenta
          header:
            fg_color: magenta
          rows:
            fg_color: cyan
        dialog:
          preferred_version_or_latest:
            fg_color: white
          other_version:
            fg_color: black

      ## Yaml view
      yaml:
        dialog:
          preferred_version_or_latest:
            fg_color: yellow
          other_version:
            fg_color: green

      ## Help dialog
      help:
        title:
          fg_color: yellow
        key:
          fg_color: lightcyan
        desc:
          fg_color: gray
  '';
}
