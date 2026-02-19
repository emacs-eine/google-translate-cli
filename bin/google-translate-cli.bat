@echo off
emacs -batch -Q -l %~dp0google-translate-cli -- %*
