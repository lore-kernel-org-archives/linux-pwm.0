From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 0/3] pwm: pwm-samsung: fix suspend/resume support
Date: Mon, 24 Apr 2017 12:01:06 +0200
Message-ID: <1493028069-32003-1-git-send-email-b.zolnierkie@samsung.com>
References: <CGME20170424100128epcas5p20396f75d5626a320a9eb11d89ae87ac5@epcas5p2.samsung.com>
Return-path: <linux-hwmon-owner@vger.kernel.org>
Sender: linux-hwmon-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Kamil Debski <kamil@wypas.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, linux-pwm@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pwm@vger.kernel.org

Hi,

This patchset fixes suspend/resume support in pwm-samsung
driver (which has an effect of fixing suspend/resume support
for PWM client drivers such as pwm-fan one). Then it removes
no longer needed suspend/resume code from pwm-fan driver.

It was tested on Odroid-XU3 board (with few extra patches
adding SoC/board suspend/resume support which are not in
upstream yet).

The initial issue that has been observed on this configuration
was that after suspend/resume operation the fan was turned on
(while the thermal code had explicitly disabled the fan by
calling back into pwm-fan driver before the suspend/resume).

Fixing this in the pwm-fan driver itself is not feasible since
pwm_config()/pwm_disable() & co. API saves information about
current state and doesn't pass the relevant values to PWM core
if they are identical to the ones used previously (moreover PWM
core itself does the same before calling into the PWM hardware
driver).

Changes since v1
(https://www.spinics.net/lists/kernel/msg2480445.html):
- added Acked-by from Guenter to patch #3
- fixed patch #2 to use the right variable (chip -> our_chip)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (3):
  pwm: pwm-samsung: remove redundant checks from pwm_samsung_config()
  pwm: pwm-samsung: fix suspend/resume support
  hwmon: pwm-fan: remove no longer needed suspend/resume code

 drivers/hwmon/pwm-fan.c   | 32 ----------------------
 drivers/pwm/pwm-samsung.c | 70 +++++++++++++++++++++++------------------------
 2 files changed, 35 insertions(+), 67 deletions(-)

-- 
1.9.1

