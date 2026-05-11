import os
from kitty.tab_bar import DrawData, ExtraData, TabBarData, draw_tab_with_powerline, TabAccessor

def draw_tab(
    draw_data: DrawData, screen, tab: TabBarData,
    before, max_title_length, index, is_last, extra_data: ExtraData
) -> int:
    
    # 1. Use the Accessor to get live process/directory info
    # This avoids the 'object has no attribute' error
    ta = TabAccessor(tab.tab_id)

    # 2. Get the process name (handling empty cases)
    exe_path = ta.active_exe or "zsh"
    exe = exe_path.split('/')[-1].lower()

    # Logic for nvim
    process_display = exe

    # 3. Get the folder name
    cwd = ta.active_wd or ""
    home = os.path.expanduser("~")

    folder = "~" if cwd == home else (cwd.split('/')[-1] or "zsh")

    # 4. Final Format: index : process@folder
    display_title = f"{index} : {process_display}@{folder}"

    # 5. Overwrite and Render
    tab = tab._replace(title=display_title)
    return draw_tab_with_powerline(
        draw_data, screen, tab, before, max_title_length, index, is_last, extra_data
    )

