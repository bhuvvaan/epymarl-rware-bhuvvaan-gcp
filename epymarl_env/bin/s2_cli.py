#!/home/bhuv/Documents/bhuv-diffusion/epymarl/epymarl_env/bin/python3
# EASY-INSTALL-ENTRY-SCRIPT: 's2protocol==5.0.13.92440.4','console_scripts','s2_cli.py'
__requires__ = 's2protocol==5.0.13.92440.4'
import re
import sys
from pkg_resources import load_entry_point

if __name__ == '__main__':
    sys.argv[0] = re.sub(r'(-script\.pyw?|\.exe)?$', '', sys.argv[0])
    sys.exit(
        load_entry_point('s2protocol==5.0.13.92440.4', 'console_scripts', 's2_cli.py')()
    )
