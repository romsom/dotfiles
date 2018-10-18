#!/usr/bin/env python2

def pass_from_gopass(path):
    from subprocess import check_output
    return check_output(['gopass', 'Mail/' + path])
