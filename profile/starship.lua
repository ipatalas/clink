local clink_dir = os.getenv('CLINK_DIR')

os.setenv('STARSHIP_CONFIG', clink_dir .. '\\profile\\starship.toml')
load(io.popen('starship init cmd'):read("*a"))()