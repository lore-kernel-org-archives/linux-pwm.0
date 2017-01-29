From: Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v5 00/11] pwm: imx: Provide atomic operation for IMX PWM driver
Date: Sun, 29 Jan 2017 22:54:04 +0100
Message-ID: <1485726855-16236-1-git-send-email-lukma@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:59578 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbdA2VzG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Jan 2017 16:55:06 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Stefan Agner <stefan@agner.ch>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org
Cc: Lothar Wassmann <LW@karo-electronics.de>, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Lukasz Majewski <lukma@denx.de>

This patch set brings atomic operation to i.MX's PWMv2 driver.

This work has been supported and suggested by Boris Brezillon [1] and 
Stefan Agner, by showing how simple the transition could be :-) (in theory).

It has been divided into several steps:

- Remove ipg clock and enable per clock when required (as proposed by Boris 
  Brezillon)

- Provide different pwm ops for PWMv1 and PWMv2

- Separate PWMv1 commits from "generic" and non atomic PWM code

  NOTE: Since I do _not_ have board with PWMv1, I would like to ask somebody
        for testing

- Move some imx_config_v2 code to separate functions

- Provide PWM atomic implementation (the ->apply() driver) for PWMv2 in a
  single patch for better readability. This patch also includes some code
  to address potential issues on i.MX7 (lack of peripheral clock when accessing
  PWM registers).

- Remove redundant PWM code (disable, enable, config callbacks)

- Update proper documentation entries

- Provide support for polarity inversion on top of atomic PWM rework


Test HW:
--------
This patch set has been tested on i.MX6q board with
v4.10-rc5 kernel SHA1: 1b1bc42c1692e9b62756323c675a44cb1a1f9dbd

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
  pwm: imx: remove ipg clock and enable per clock when required

 Documentation/devicetree/bindings/pwm/imx-pwm.txt |   6 +-
 drivers/pwm/core.c                                |  26 ++-
 drivers/pwm/pwm-imx.c                             | 269 ++++++++++------------
 3 files changed, 145 insertions(+), 156 deletions(-)

-- 
2.1.4
