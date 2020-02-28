From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 0/5] pwm: omap-dmtimer: Allow for dynamic pwm period updates
Date: Fri, 28 Feb 2020 15:26:45 +0530
Message-ID: <20200228095651.32464-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55508 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgB1J5w (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Feb 2020 04:57:52 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>

This series fixes minor issues in config callback and allows for on the
fly updates for pwm period and duty cycle. This is mainly intended to
allow pwm omap dmtimer to be used for generating a 1PPS signal that can be
syncronized to PTP clock in CPTS module available in AM335x and AM57xx SoCs.

Series depends on the following series:
- https://patchwork.kernel.org/patch/11379875/
- https://patchwork.kernel.org/project/linux-omap/list/?series=248929 

Full dependencies can be seen here:
https://github.com/lokeshvutla/linux/tree/devel/pwm-1pps-generation-v2

Changes since v1:
- Updated commit description in PATCH 1
- Added a brief about PWM generation using OMAP DM timer.
- Updated the pwm stop callback to allow for completing the current pwm
  cycle.
- Added the limitaitons of hardware.
- Used hw status instead of relying on pwm framework for state update.

Lokesh Vutla (6):
  pwm: omap-dmtimer: Drop unused header file
  pwm: omap-dmtimer: Update description for pwm omap dm timer
  pwm: omap-dmtimer: Fix pwm enabling sequence
  pwm: omap-dmtimer: Fix pwm disabling sequence
  pwm: omap-dmtimer: Do not disable pwm before changing
    period/duty_cycle
  pwm: omap-dmtimer: Implement .apply callback

 drivers/pwm/pwm-omap-dmtimer.c                | 248 +++++++++++++-----
 include/clocksource/timer-ti-dm.h             |   3 +-
 .../linux/platform_data/pwm_omap_dmtimer.h    |  90 -------
 3 files changed, 178 insertions(+), 163 deletions(-)
 delete mode 100644 include/linux/platform_data/pwm_omap_dmtimer.h

-- 
2.23.0
