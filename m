From: Jonathan Richardson <jonathar@broadcom.com>
Subject: [PATCH v9 0/2] Fix bugs in kona pwm driver and pwm core
Date: Mon, 15 Jun 2015 14:21:00 -0700
Message-ID: <1434403262-24198-1-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:4635 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbbFOVRd (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 15 Jun 2015 17:17:33 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Tim Kryger <tim.kryger@gmail.com>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Arun Ramamurthy <arun.ramamurthy@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Scott Branden <sbranden@broadcom.com>, Jonathan Richardson <jonathar@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org

This patchset fixes a bug in the Broadcom Kona pwm driver. A new procedure for
changing the pwm settings has been introduced. Also fixed a bug in the pwm core
where the enabled state was incorrect on failed calls to enable.

These changes are required for the Kona PWM driver to work on Cygnus. The same
PWM IP is being used.

Changes from v8:
  - Accepted patches not included. Patch to introduce debug statements to config
	in kona pwm driver not included - will be addressed later.
  - Added mutex to pwm core enable function to prevent potential concurrency
	issue, as suggested by Thierry.
  - Fixed commit message for kona pwm changes. Also changed wording in comments
	from enable to trigger.

Changes from v7:
  - Polarity changes take effect immediately instead of being deferred until
    enable is called.

Changes from v6:
  - Move new debugging info for duty cycle and period in config function into
    its own commit.
  - Add kona_pwmc_prepare_for_settings() function to remove duplicated code.

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

Jonathan Richardson (2):
  pwm: kona: Modify settings application sequence
  pwm: core: Set enable state properly on failed call to enable

 drivers/pwm/core.c         |   19 +++++++++++++++---
 drivers/pwm/pwm-bcm-kona.c |   47 +++++++++++++++++++++++++++++++++++---------
 include/linux/pwm.h        |    2 ++
 3 files changed, 56 insertions(+), 12 deletions(-)

-- 
1.7.9.5
