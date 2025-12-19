-- WARNING:  This file gets overwritten by the 'flexprompt configure' wizard!
--
-- If you want to make changes, consider copying the file to
-- 'flexprompt_config.lua' and editing that file instead.

flexprompt = flexprompt or {}
flexprompt.settings = flexprompt.settings or {}
flexprompt.settings.charset = "unicode"
flexprompt.settings.connection = "disconnected"
flexprompt.settings.flow = "concise"
flexprompt.settings.heads = "pointed"
flexprompt.settings.lean_separators = "space"
flexprompt.settings.left_frame = "none"
flexprompt.settings.left_prompt = "{battery}{histlabel}{cwd}{git}"
flexprompt.settings.lines = "two"
flexprompt.settings.nerdfonts_version = 2
flexprompt.settings.nerdfonts_width = 1
flexprompt.settings.powerline_font = true
flexprompt.settings.right_frame = "none"
flexprompt.settings.right_prompt = "{exit}{duration}{time:format=%H:%M:%S}"
flexprompt.settings.spacing = "sparse"
flexprompt.settings.style = "lean"
flexprompt.settings.symbols =
{
    prompt =
    {
        ">",
        winterminal = "❯",
    },
}
flexprompt.settings.use_8bit_color = true
flexprompt.settings.use_color_emoji = true
flexprompt.settings.use_icons = true
