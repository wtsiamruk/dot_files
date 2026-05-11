import os
from kitty.tab_bar import DrawData, ExtraData, TabBarData, draw_tab_with_powerline, TabAccessor

def draw_tab(
    draw_data: DrawData, screen, tab: TabBarData,
    before, max_title_length, index, is_last, extra_data: ExtraData
) -> int:
    
    # 1. Initialize accessor
    ta = TabAccessor(tab.tab_id)

    # 2. DEFENSIVE CHECK: getattr prevents the 'no attribute' crash on macOS GUI boot
    # We provide "zsh" as a fallback so the script doesn't die.
    active_exe = getattr(ta, 'active_exe', 'zsh')
    active_wd = getattr(ta, 'active_wd', '~')

    # 3. Clean up values (handling None if getattr returns it)
    exe = (active_exe or "shell").split('/')[-1].lower()

    home = os.path.expanduser("~")
    cwd = active_wd or home
    folder = "~" if cwd == home else (cwd.split('/')[-1] or "shell")

    # 4. Construct title
    display_title = f"{index} : {exe}@{folder}"

    # 5. Overwrite and Render
    tab = tab._replace(title=display_title)
    return draw_tab_with_powerline(
        draw_data, screen, tab, before, max_title_length, index, is_last, extra_data
    )
