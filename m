From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/2] pwm: meson: two small bug-fixes
Date: Mon,  1 Apr 2019 20:18:15 +0200
Message-ID: <20190401181817.11999-1-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc: narmstrong@baylibre.com, jbrunet@baylibre.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de, bichao.zheng@amlogic.com, Martin Blumenstingl <martin.blumenstingl@googlemail.com>
List-Id: linux-pwm@vger.kernel.org

This series applies on top of my other fix "pwm: meson: fix scheduling
while atomic issue" from [0]

The first patch fixes an issue where the maximum possible pre-divider
(128) could not be used because there was an off-by-one error in the
code. I discovered this while testing with the longest supported period
(349514407ns) when running from XTAL. This is verified to work on my
Meson8b Odroid-C1 board using "pwm_b" on GPIOX_11.

The second patch was suggested by Uwe Kleine-König but was actually
implemented much earlier (back in mid 2018) by Bichao Zheng from
Amlogic. This patch fixes changing the duty cycle by relying on the
hardware to re-start the PWM output (instead of adding an artificial
"constant LOW" of about 20ms - as measured by Bichao Zheng when
stopping and re-starting the PWM output from within the driver). I
tested this fix on my Meson8b Odroid-C1 board which uses a PWM driven
CPU regulator (DVFS with all supported OPPs is still working fine for
me, although I couldn't observe any issues before this patch).

I also have some code-improvements queued which I'll send in the next
days, see [1]


[0] https://patchwork.kernel.org/cover/10880419/
[1] https://github.com/xdarklight/linux/commits/meson-pwm-for-5.2-v1


Bichao Zheng (1):
  pwm: meson: don't disable pwm when setting duty repeatedly

Martin Blumenstingl (1):
  pwm: meson: consider 128 a valid pre-divider

 drivers/pwm/pwm-meson.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

-- 
2.21.0
