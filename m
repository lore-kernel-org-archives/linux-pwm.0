From: Jonathan Richardson <jonathar@broadcom.com>
Subject: [PATCH v6 0/4] Fix bugs in kona pwm driver and pwm core
Date: Fri, 10 Apr 2015 11:58:49 -0700
Message-ID: <1428692333-14400-1-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Kryger <tim.kryger@gmail.com>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Arun Ramamurthy <arun.ramamurthy@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Scott Branden <sbranden@broadcom.com>, Jonathan Richardson <jonathar@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

This patchset fixes a number of bugs in the Broadcom Kona pwm driver. It also
fixes a bug in the pwm core where the enabled state was incorrect on failed
calls to enable. Also, a new function was added to the pwm core to add pwm chips
with inversed polarity for chips that have a different default polarity than the
core. The prevents incorrect polarity being reported.

These changes are required for the Kona pwm driver to work on Cygnus and the
same pwm IP is being used.

Changes from v5:
  - Address Dmitry's comment on code cleanup of pwm_enable() in pwm core.
  - Including all patches from different contributors in this patchset. Some
	were left out in v4.

Changes from v4:
  - Rebased to Tim Kryger's patch that adds support in pwm core to add driver
    with inversed polarity.
  - Removed patch 2 that resolved difference between hardware default polarity
    and pwm framework default polarity. The default polarity is set properly now
    when the pwm driver is registered with the pwm framework.

Arun Ramamurthy (1):
  drivers: pwm: bcm-kona: Dont set polarity in probe

Jonathan Richardson (2):
  pwm: kona: Fix incorrect config, disable, and polarity procedures
  pwm: core: Set enable state properly on failed call to enable

Tim Kryger (1):
  drivers: pwm: core: Add pwmchip_add_inversed

 drivers/pwm/core.c         |   52 +++++++++++++++++++++------
 drivers/pwm/pwm-bcm-kona.c |   84 +++++++++++++++++++++++++++++++++-----------
 include/linux/pwm.h        |    6 ++++
 3 files changed, 110 insertions(+), 32 deletions(-)

-- 
1.7.9.5
