From: Lukasz Majewski <l.majewski@majess.pl>
Subject: [PATCH v3 00/11] pwm: imx: Provide atomic operation for IMX PWM driver
Date: Tue,  1 Nov 2016 08:10:19 +0100
Message-ID: <1477984230-18071-1-git-send-email-l.majewski@majess.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Stefan Agner <stefan@agner.ch>, Sascha Hauer <s.hauer@pengutronix.de>, Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, kernel@pengutronix.de, Lukasz Majewski <l.majewski@majess.pl>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
List-Id: linux-pwm@vger.kernel.org

This patch set brings atomic operation to i.MX's PWMv2 driver.

This work has been supported and suggested by Boris Brezillon [1] and 
Stefan Agner, by showing how simple the transition could be :-).

It has been divided into several steps:

- Remove ipg clock enable/disable code (as proposed by Sascha Hauer) - this
  is the most notable change for v3

- Provide different pwm ops for PWMv1 and PWMv2

- Separate PWMv1 commits from "generic" and non atomic PWM code

  NOTE: Since I do _not_ have board with PWMv1, I would like to ask somebody
        for testing

- Move some imx_config_v2 code to separate functions

- Provide PWM atomic implementation (the ->apply() driver) for PWMv2 in a
  single patch for better readability.

- Remove redundant PWM code (disable, enable, config callbacks)

- Update proper documentation entries

- Provide support for polarity inversion on top of atomic PWM rework

Test HW:
--------
This patch set has been tested on i.MX6q board with
v4.9-rc3 kernel SHA1: a909d3e636995ba7c349e2ca5dbb528154d4ac30


The PWM operation has been tested with pwm_bl backlight driver by changing
its brightness.

[1]: http://patchwork.ozlabs.org/patch/685402/


Lothar Wassmann (2):
  pwm: print error messages with pr_err() instead of pr_debug()
  pwm: core: make the PWM_POLARITY flag in DTB optional

Lukasz Majewski (8):
  pwm: imx: Add separate set of pwm ops for PWMv1 and PWMv2
  pwm: imx: Rewrite imx_pwm_*_v1 code to facilitate switch to atomic pwm
    operation
  pwm: imx: Move PWMv2 software reset code to a separate function
  pwm: imx: Move PWMv2 wait for fifo slot code to a separate function
  pwm: imx: Provide atomic PWM support for i.MX PWMv2
  pwm: imx: Remove redundant i.MX PWMv2 code
  pwm: imx: doc: Update imx-pwm.txt documentation entry
  pwm: imx: Add polarity inversion support to i.MX's PWMv2

Sascha Hauer (1):
  pwm: imx: remove ipg clock

 Documentation/devicetree/bindings/pwm/imx-pwm.txt |   6 +-
 drivers/pwm/core.c                                |  26 +--
 drivers/pwm/pwm-imx.c                             | 247 ++++++++++------------
 3 files changed, 134 insertions(+), 145 deletions(-)

-- 
2.1.4
