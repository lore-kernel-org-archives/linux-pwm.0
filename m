From: Lukasz Majewski <l.majewski@majess.pl>
Subject: [PATCH 0/6] pwm: imx: Provide atomic operation for IMX PWM driver
Date: Sun, 23 Oct 2016 23:45:40 +0200
Message-ID: <1477259146-19167-1-git-send-email-l.majewski@majess.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Stefan Agner <stefan@agner.ch>, Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, kernel@pengutronix.de, Lukasz Majewski <l.majewski@majess.pl>
List-Id: linux-pwm@vger.kernel.org

This patch set brings atomic operation to i.MX's PWMv2 driver.

This work has been supported and suggested by Boris Brezillon [1] and 
Stefan Agner, by showing how simple the transition could be :-).

It has been divided into several steps:
- Separate PWMv1 commits from "generic" and non atomic PWM code.

  NOTE: Since I do not have board with PWMv1, I would like to ask somebody
  	for testing

- Move some imx_config_v2 code to separate functions

- Provide PWM atomic implementation (the ->apply() driver) in a single patch
  for better readability.

- Remove redundant PWM code (disable, enable, config callbacks)

- Clean up the driver infrastructure

- Provide "polarity_supported" flag to indicate support for polarity 
  inversion

This work should be applied on top of following commits:

http://patchwork.ozlabs.org/patch/679706/
http://patchwork.ozlabs.org/patch/679707/
http://patchwork.ozlabs.org/patch/679680/


Test HW:
--------
This patch set has been tested on i.MX6q board with vanilla 4.7 kernel.
It applies clearly on 4.9-rcX SHA1: 0c2b6dc4fd4fa13796b319aae969a009f03222c6


The PWM operation has been tested with pwm_bl backlight driver by changing
its brightness.

[1]: http://patchwork.ozlabs.org/patch/685402/


Lukasz Majewski (6):
  pwm: imx: Rewrite imx_pwm_*_v1 code to facilitate switch to atomic pwm
    operation
  pwm: imx: Move PWMv2 software reset code to a separate function
  pwm: imx: Move PWMv2 wait for fifo slot code to a separate function
  pwm: imx: Provide atomic PWM support for IMXv2 PWM
  pwm: imx: Remove redundant IMX PWMv2 code
  pwm: imx: Introduce "polarity_supported" flag to PWMv2 driver

 drivers/pwm/pwm-imx.c | 262 ++++++++++++++++++++++----------------------------
 1 file changed, 114 insertions(+), 148 deletions(-)

-- 
2.1.4
