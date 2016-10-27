From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/2] backlight: pwm_bl: Fix the initial power state selection
Date: Thu, 27 Oct 2016 13:01:55 +0300
Message-ID: <20161027100157.2231-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, lee.jones@linaro.org
Cc: tomi.valkeinen@ti.com, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

Hi,

Changes since v1:
- Handling of the enable GPIO is reworked:
 - Only change direction to output when the pin was input and in this case set
   the GPIO line physical low
 - With this change we can ensure that the enable GPIO is output so we do not
   need to check the direction of it later on.

Cover letter:

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

Regards,
Peter
---
Peter Ujfalusi (2):
  backlight: pwm_bl: Move the checks for initial power state to a
    separate function
  backlight: pwm_bl: Check the pwm state for initial backlight power
    state

 drivers/video/backlight/pwm_bl.c | 58 +++++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 19 deletions(-)

--
2.10.1
