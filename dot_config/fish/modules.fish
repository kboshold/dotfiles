if command -sq atuin
    atuin init fish | source
    atuin gen-completions --shell fish | source
end

if command -sq zoxide
    zoxide init --cmd cd fish | source
end

if command -sq starship
    # Prompt settings
    function starship_transient_prompt_func
        starship module character
    end
        
    function starship_transient_rprompt_func
        starship prompt --right $argv
    end

    # Use custom prompt until https://github.com/starship/starship/issues/6180 is released
    cat ~/.config/fish/starship_init.fish | source
    # starship init fish | source

    enable_transience
end