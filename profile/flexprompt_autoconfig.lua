-- WARNING:  This file gets overwritten by the 'flexprompt configure' wizard!
--
-- If you want to make changes, consider copying the file to
-- 'flexprompt_config.lua' and editing that file instead.

flexprompt = flexprompt or {}
flexprompt.settings = flexprompt.settings or {}
flexprompt.settings.symbols =
{
    prompt =
    {
        ">",
        winterminal = "❯",
    },
}
flexprompt.settings.spacing = "sparse"
flexprompt.settings.flow = "concise"
flexprompt.settings.right_frame = "none"
flexprompt.settings.connection = "disconnected"
flexprompt.settings.left_prompt = "{battery}{histlabel}{cwd}{git}"
flexprompt.settings.charset = "unicode"
flexprompt.settings.lean_separators = "dot"
flexprompt.settings.use_8bit_color = true
flexprompt.settings.powerline_font = true
flexprompt.settings.style = "lean"
flexprompt.settings.use_icons = true
flexprompt.settings.lines = "two"
flexprompt.settings.right_prompt = "{exit}{duration}{time:format=%H:%M:%S}"
flexprompt.settings.left_frame = "none"
flexprompt.settings.heads = "pointed"
