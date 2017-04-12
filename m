From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Fixes for v4.11-rc7
Date: Wed, 12 Apr 2017 19:55:05 +0200
Message-ID: <20170412175505.13472-1-thierry.reding@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36454 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752095AbdDLRzI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Apr 2017 13:55:08 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-4.11-rc7

for you to fetch changes up to a900152b5c29aea8134cc7a4c5db25552b3cd8f7:

  pwm: rockchip: State of PWM clock should synchronize with PWM enabled state (2017-04-06 15:08:52 +0200)

This comes about a week later than I wanted, but I got side-tracked with
other things, unfortunately.

Thanks,
Thierry

----------------------------------------------------------------
pwm: Fixes for v4.11-rc7

This contain a fix for the atomic update support recently added to the
Rockchip driver where the clock reference count would become unbalanced
and result in the clock feeding the PWM to always be disabled.

Another fix to the Intel LPSS driver that adds an update bit quirk
required for a specific configuration.

----------------------------------------------------------------
Andy Shevchenko (1):
      pwm: lpss: Split Tangier configuration

David Wu (1):
      pwm: rockchip: State of PWM clock should synchronize with PWM enabled state

Hans de Goede (1):
      pwm: lpss: Set enable-bit before waiting for update-bit to go low

 drivers/pwm/pwm-lpss-pci.c      | 10 +++++++++-
 drivers/pwm/pwm-lpss-platform.c |  1 +
 drivers/pwm/pwm-lpss.c          | 19 +++++++++++++------
 drivers/pwm/pwm-lpss.h          |  1 +
 drivers/pwm/pwm-rockchip.c      | 40 +++++++++++++++++++++++++++++++++-------
 5 files changed, 57 insertions(+), 14 deletions(-)
