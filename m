From: Lukasz Majewski <l.majewski@majess.pl>
Subject: [PATCH v2 00/10] pwm: imx: Provide atomic operation for IMX PWM driver
Date: Thu, 27 Oct 2016 08:29:36 +0200
Message-ID: <1477549785-4972-1-git-send-email-l.majewski@majess.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Stefan Agner <stefan@agner.ch>, Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, kernel@pengutronix.de, Lukasz Majewski <l.majewski@majess.pl>
List-Id: linux-pwm@vger.kernel.org

This patch set brings atomic operation to i.MX's PWMv2 driver.

This work has been supported and suggested by Boris Brezillon [1] and 
Stefan Agner, by showing how simple the transition could be :-).

It has been divided into several steps:

- Provide different pwm ops for PWMv1 and PWM v2

- Separate PWMv1 commits from "generic" and non atomic PWM code.

  NOTE: Since I do not have board with PWMv1, I would like to ask somebody
        for testing

- Move some imx_config_v2 code to separate functions

- Provide PWM atomic implementation (the ->apply() driver) for PWMv2 in a
  single patch for better readability.
	
- Remove redundant PWM code (disable, enable, config callbacks)

- Update proper documentation entries

- Provide support for polarity inversion on top of atomic PWM rework

Test HW:
--------
This patch set has been tested on i.MX6q board with vanilla 4.7, 4.8 and
v4.9-rc2 kernel SHA1: 07d9a380680d1c0eb51ef87ff2eab5c994949e69


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

 Documentation/devicetree/bindings/pwm/imx-pwm.txt |   6 +-
 drivers/pwm/core.c                                |  26 ++-
 drivers/pwm/pwm-imx.c                             | 255 ++++++++++++----------
 3 files changed, 152 insertions(+), 135 deletions(-)

-- 
2.1.4
