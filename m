From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH 0/2] pwm-backlight: switch to gpiod interface (part 1)
Date: Thu, 27 Feb 2014 14:53:32 +0900
Message-ID: <1393480414-19473-1-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
List-Id: linux-pwm@vger.kernel.org

These two patches initiate the switch of the pwm-backlight driver to
the gpiod GPIO interface, as it considerably simplifies the code.

For compatibility with current users of the driver, it is still possible
to pass the enable GPIO number as platform data. Two platforms are still
relying on this feature (pxa/palmtc and shmobile/armadillo800eva) which
will be removed as soon as its last users are switched to GPIO mapping
tables.

Alexandre Courbot (2):
  ARM: SAMSUNG: remove gpio flags in dev-backlight
  pwm-backlight: switch to gpiod interface

 arch/arm/plat-samsung/dev-backlight.c |  2 -
 drivers/video/backlight/pwm_bl.c      | 72 +++++++++++++++--------------------
 include/linux/pwm_backlight.h         |  5 +--
 3 files changed, 32 insertions(+), 47 deletions(-)

-- 
1.9.0

