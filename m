From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 0/4] backlight: Expose brightness curve type through sysfs
Date: Thu, 13 Jun 2019 12:43:22 -0700
Message-ID: <20190613194326.180889-1-mka@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Pavel Machek <pavel@ucw.cz>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pwm@vger.kernel.org

Backlight brightness curves can have different shapes. The two main
types are linear and non-linear curves. The human eye doesn't
perceive linearly increasing/decreasing brightness as linear (see
also 88ba95bedb79 "backlight: pwm_bl: Compute brightness of LED
linearly to human eye"), hence many backlights use non-linear (often
logarithmic) brightness curves. The type of curve is currently opaque
to userspace, so userspace often relies on more or less reliable
heuristics (like the number of brightness levels) to decide whether
to treat a backlight device as linear or non-linear.

Export the type of the brightness curve via a new sysfs attribute.

Matthias Kaehlcke (4):
  MAINTAINERS: Add entry for stable backlight sysfs ABI documentation
  backlight: Expose brightness curve type through sysfs
  backlight: pwm_bl: Set scale type for CIE 1931 curves
  backlight: pwm_bl: Set scale type for brightness curves specified in
    the DT

 .../ABI/testing/sysfs-class-backlight         | 32 +++++++++++++++++++
 MAINTAINERS                                   |  2 ++
 drivers/video/backlight/backlight.c           | 22 +++++++++++++
 drivers/video/backlight/pwm_bl.c              | 30 ++++++++++++++++-
 include/linux/backlight.h                     | 10 ++++++
 5 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-backlight

-- 
2.22.0.rc2.383.gf4fbbf30c2-goog
