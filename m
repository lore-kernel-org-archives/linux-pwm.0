From: Jonathan Richardson <jonathar@broadcom.com>
Subject: [PATCH v10 0/1] Fix bugs in kona pwm driver and pwm core
Date: Fri, 16 Oct 2015 17:40:57 -0700
Message-ID: <1445042458-30725-1-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:50274 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbbJQAkK (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 16 Oct 2015 20:40:10 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Tim Kryger <tim.kryger@gmail.com>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Arun Ramamurthy <arun.ramamurthy@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Scott Branden <sbranden@broadcom.com>, Jonathan Richardson <jonathar@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org

Fixes a bug in the pwm core where the enabled state was incorrect on failed
calls to enable.

Changes from v9:
  - pwm_set_polarity() enabled check is protected using the same mutex as
    pwm_enable() in pwm core. Implemented as suggested by Thierry.

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

Jonathan Richardson (1):
  pwm: core: Set enable state properly on failed call to enable

 drivers/pwm/core.c  | 33 ++++++++++++++++++++++++++-------
 include/linux/pwm.h |  2 ++
 2 files changed, 28 insertions(+), 7 deletions(-)

-- 
1.9.1
