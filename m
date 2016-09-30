From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] backlight: pwm_bl: Fix the initial power state selection
Date: Fri, 30 Sep 2016 10:02:57 +0300
Message-ID: <20160930070259.5710-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41380 "EHLO comal.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750842AbcI3HDO (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 30 Sep 2016 03:03:14 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, jingoohan1@gmail.com, lee.jones@linaro.org
Cc: tomi.valkeinen@ti.com, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, p.zabel@pengutronix.de

Hi,

3698d7e7d221 backlight: pwm_bl: Avoid backlight flicker when probed from DT

added support for avoiding backlight flickering, which in essence was designed
to not enable the baclkight when the driver loads, but let the user of the
backlight to enable it later on.

There are boards (like am437x-gp-evm) where we do not have valid GPIO to enable
the backlight (TPS61081DRC's EN pin is connected to V3_3D) and the regulator
is always on (VBAT in case of the gp-evm). In this board the logic to check the
GPIO state and the regulator is failing and the backlight will be enabled as
soon as the pwm_bl driver is loaded.

By extending the check to look at the PWM state this issue can be avoided and
the backlight will be enabled only when it's user is asking it to be enabled.

Note:
I don't know the history of 3698d7e7d221, but I would have opted to add a DT
bool property (default-off) indicating that the given backlight device must stay
off when the driver is probing, other driver will enable it later.
This way all pwm driver could use the same property (gpio-backlight would need
to be converted) and the backward compatibility would have been retained.

Regards,
Peter
---
Peter Ujfalusi (2):
  backlight: pwm_bl: Move the checks for initial power state to a
    separate function
  backlight: pwm_bl: Check the pwm state for initial backlight power
    state

 drivers/video/backlight/pwm_bl.c | 59 ++++++++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 20 deletions(-)

--
2.10.0
