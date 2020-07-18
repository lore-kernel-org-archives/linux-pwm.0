From: vineetha.g.jaya.kumaran@intel.com
Subject: [PATCH v2 0/2] Add PWM support for Intel Keem Bay SoC
Date: Sat, 18 Jul 2020 22:47:06 +0800
Message-ID: <1595083628-20734-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:3940 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbgGROtu (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 18 Jul 2020 10:49:50 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, robh+dt@kernel.org
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, wan.ahmad.zainie.wan.mohamad@intel.com, andriy.shevchenko@intel.com

From: "Vineetha G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>

Hi,

This patch set enables support for PWM on the Intel Keem Bay SoC.
Keem Bay is an ARM based SoC, and the GPIO module allows
configuration of 6 PWM outputs. Patch 1 adds the PWM driver and
Patch 2 is for the required Device Tree bindings documentation.

This driver was tested on the Keem Bay evaluation module board.

Thank you.

Best regards,
Vineetha

Changes since v1:
-Updated licensing info, "clocks" property and example in DT bindings
-Updated name of DT bindings document to match compatible string
-Removed 1 patch for addition of new sysfs attribute "count"
-Added support for COMPILE_TEST in Kconfig
-Updated naming of defines and regmap attribute
-Updated calculation of waveform high time and low time
-Added range checking for waveform high/low time
-Implemented .get_state
-Removed register writes for lead-in and count values (left to default)
-Updated register access to single-access
-Folded keembay_pwm_enable/disable_channel, keembay_pwm_config_period/duty_cycle,
 and keembay_pwm_config into keembay_pwm_apply
-Updated error messages/error codes
-Removed pwm_disable from keembay_pwm_remove
-Removed clk_prepare/clk_enable/clk_disable from driver

Lai, Poey Seng (1):
  pwm: Add PWM driver for Intel Keem Bay

Vineetha G. Jaya Kumaran (1):
  dt-bindings: pwm: keembay: Add bindings for Intel Keem Bay PWM

 .../devicetree/bindings/pwm/intel,keembay-pwm.yaml |  45 ++++
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-keembay.c                          | 239 +++++++++++++++++++++
 4 files changed, 294 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml
 create mode 100644 drivers/pwm/pwm-keembay.c

-- 
1.9.1
