From: wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH] pwm: add support for freq_hz and duty_percent
Date: Fri, 18 Mar 2016 17:43:14 +0800
Message-ID: <1458294195-24538-1-git-send-email-wan.ahmad.zainie.wan.mohamad@intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:30943 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754729AbcCRJnc (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Fri, 18 Mar 2016 05:43:32 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org

From: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>

Hi.

This patch adds freq_hz and duty_percent parameters to the PWM framework.
The value of period and duty_cycle is calculated by the additional helper
functions. Each driver in this framework still using period and duty_cycle
as the inputs for configuration.

This patch has been tested on Minnowboard MAX via sysfs.

Best regards,
Zainie

Wan Ahmad Zainie (1):
  pwm: add support for freq_hz and duty_percent

 Documentation/ABI/testing/sysfs-class-pwm | 14 +++++
 drivers/pwm/core.c                        | 95 ++++++++++++++++++++++++++++++-
 drivers/pwm/sysfs.c                       | 70 +++++++++++++++++++++++
 include/linux/pwm.h                       | 50 ++++++++++++++++
 4 files changed, 228 insertions(+), 1 deletion(-)

-- 
1.9.1
