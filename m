From: Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v4 00/11] pwm: imx: Provide atomic operation for IMX PWM driver
Date: Thu,  5 Jan 2017 00:36:43 +0100
Message-ID: <1483573014-13185-1-git-send-email-lukma@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Stefan Agner <stefan@agner.ch>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org
Cc: Lothar Wassmann <LW@karo-electronics.de>, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Lukasz Majewski <lukma@denx.de>
List-Id: linux-pwm@vger.kernel.org

This patch set brings atomic operation to i.MX's PWMv2 driver.

This work has been supported and suggested by Boris Brezillon [1] and 
Stefan Agner, by showing how simple the transition could be :-).

It has been divided into several steps:

- Remove ipg clock and enable per clock when required (as proposed by Boris 
  Brezillon) - this is the most notable change for v4

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
v4.9 vanila kernel SHA1: 69973b830859bc6529a7a0468ba0d80ee5117826
It applies to v4.10-rc2

The PWM operation has been tested with pwm_bl backlight driver by changing
its brightness.

[1]: http://patchwork.ozlabs.org/patch/685402/


Boris Brezillon (1):
  pwm: imx: remove ipg clock and enable per clock when required

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
 drivers/pwm/pwm-imx.c                             | 272 ++++++++++------------
 3 files changed, 146 insertions(+), 158 deletions(-)

-- 
2.1.4
