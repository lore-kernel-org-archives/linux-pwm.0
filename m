From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 0/4] Fix a bunch of W=1 warnings in PWM
Date: Mon, 29 Jun 2020 13:47:48 +0100
Message-ID: <20200629124752.1018358-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org

Attempting to clean-up W=1 kernel builds, which are currently
overwhelmingly riddled with niggly little warnings.

Lee Jones (4):
  pwm: bcm-iproc: Remove impossible comparison when validating duty
    cycle
  pwm: bcm-kona: Remove impossible comparison when validating duty cycle
  pwm: mediatek: Provide missing kerneldoc description for 'soc' arg
  pwm: omap-dmtimer: Repair pwm_omap_dmtimer_chip's broken kerneldoc
    header

 drivers/pwm/pwm-bcm-iproc.c    | 3 +--
 drivers/pwm/pwm-bcm-kona.c     | 2 +-
 drivers/pwm/pwm-mediatek.c     | 1 +
 drivers/pwm/pwm-omap-dmtimer.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.25.1
