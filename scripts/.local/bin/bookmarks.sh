#!/usr/bin/env sh

launcher="rofi -dmenu"

bookmarks="youtube :: youtube.com
leetcode :: leetcode.com/problemset
protonmail :: mail.proton.me/u/2/inbox
wallhaven :: wallhaven.cc
arch wiki :: wiki.archlinux.org
wifi login :: logout.ui.ac.ir
golestan :: golestan.ui.ac.ir
cullinan :: sfd.ui.ac.ir
blog :: makk.liara.run
linkedin :: linkedin.com
github :: github.com
chatgpt :: chatgpt.com
percentage calc :: kanoon.ir/Public/PercentageCalculator
cshub :: cshub.ir
gemini :: gemini.google.com
upload faradars :: up.faradars.org
metal tracker :: en.metal-tracker.com
bt4gprx :: bt4gprx.com
libgen :: libgen.is
zlib :: z-library.sk
e-resume :: e-resume.vercel.app/builder
"

chosen="$(printf "%s" "$bookmarks" | $launcher | awk '{ print $NF }')"

[ -n "$chosen" ] && firefox -new-tab "${chosen}"
