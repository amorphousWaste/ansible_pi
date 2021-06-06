"""Get os version data for Raspbian / Raspberry Pi OS."""

import argparse
import os


def get_args():
    """Get the args from argparse.

    Returns:
        args (dict): Arguments from argparse.
    """
    parser = argparse.ArgumentParser()

    parser.add_argument(
        '-v',
        '--values',
        nargs='*',
        help=(
            'Values to get from the os data. Supported values are: '
            'PRETTY_NAME, NAME, VERSION_ID, VERSION, VERSION_CODENAME, ID, '
            'ID_LIKE, HOME_URL, SUPPORT_URL, BUG_REPORT_URL. '
            'Default is PRETTY_NAME.'
        ),
    )

    args = parser.parse_args()

    return vars(args)


def get_os_info(values=None):
    """Get operating system info.

    This is designed to work with Raspbian / Raspberry Pi OS

    Args:
        values (list): List of values to print.
            Supported values are:
                'PRETTY_NAME',
                'NAME',
                'VERSION_ID',
                'VERSION',
                'VERSION_CODENAME',
                'ID',
                'ID_LIKE',
                'HOME_URL',
                'SUPPORT_URL',
                'BUG_REPORT_URL'
            Default is 'PRETTY_NAME'.
    """
    if not values:
        values = ['PRETTY_NAME']

    os_info_file = '/etc/os-release'
    if not os.path.exists(os_info_file):
        return

    with open(os_info_file, 'r') as in_file:
        raw_os_data = in_file.read()

    os_data = {}
    for datum in raw_os_data.split('\n'):
        if not datum:
            continue
        k, v = datum.split('=')
        os_data[k] = v.strip('"')

    for value in values:
        print(os_data.get(value))


if __name__ == '__main__':
    args = get_args()
    get_os_info(args['values'])
