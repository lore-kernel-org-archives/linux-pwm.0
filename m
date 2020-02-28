From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 0/5] clocksource: timer-ti-dm: Prepare for dynamic pwm period updates
Date: Fri, 28 Feb 2020 15:23:41 +0530
Message-ID: <20200228095346.32177-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34120 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgB1Jy6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Feb 2020 04:54:58 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>

This series fixes dm_timer_ops used for enabling the pwm and enables
cpu_pm notifier for context save and restore. This acts as a preparatory
series for enabling dynamic period updates for pwm omap dm timer driver.

Changes since v1:
- Updated License header to use SPDX identifier
- Implemented cpu_pm notfier
- Added support for getting pwm current status
- Extended set_pwm functionality.

Lokesh Vutla (5):
  clocksource: timer-ti-dm: Convert to SPDX identifier
  clocksource: timer-ti-dm: Implement cpu_pm notifier for context save
    and restore
  clocksource: timer-ti-dm: Do not update counter on updating the period
  clocksource: timer-ti-dm: Add support to get pwm current status
  clocksource: timer-ti-dm: Enable autoreload in set_pwm

 drivers/clocksource/timer-ti-dm.c          | 136 ++++++++++-----------
 drivers/pwm/pwm-omap-dmtimer.c             |   8 +-
 include/clocksource/timer-ti-dm.h          |   3 +-
 include/linux/platform_data/dmtimer-omap.h |   6 +-
 4 files changed, 75 insertions(+), 78 deletions(-)

-- 
2.23.0
