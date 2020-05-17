From: vineetha.g.jaya.kumaran-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Subject: [PATCH 0/3] Add PWM support for Intel Keem Bay SoC
Date: Sun, 17 May 2020 21:52:37 +0800
Message-ID: <1589723560-5734-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wan.ahmad.zainie.wan.mohamad-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, vineetha.g.jaya.kumaran-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

From: "Vineetha G. Jaya Kumaran" <vineetha.g.jaya.kumaran-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Hi,

This patch set enables support for PWM on the Intel Keem Bay SoC.
Keem Bay is an ARM based SoC, and the GPIO module allows
configuration of 6 PWM outputs. Patch 1 adds a new count attribute to
the sysfs, Patch 2 adds the PWM driver and Patch 3 is for the
required Device Tree bindings documentation.

This driver was tested on the Keem Bay evaluation module board.

Thank you.

Best regards,
Vineetha

Lai, Poey Seng (2):
  pwm: Add count attribute in sysfs for Intel Keem Bay
  pwm: Add PWM driver for Intel Keem Bay

Vineetha G. Jaya Kumaran (1):
  dt-bindings: pwm: keembay: Add bindings for Intel Keem Bay PWM

 Documentation/ABI/testing/sysfs-class-pwm          |   9 +
 .../devicetree/bindings/pwm/pwm-keembay.yaml       |  39 +++
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/core.c                                 |   3 +-
 drivers/pwm/pwm-keembay.c                          | 308 +++++++++++++++++++++
 drivers/pwm/sysfs.c                                |  37 +++
 include/linux/pwm.h                                |   2 +
 8 files changed, 407 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-keembay.yaml
 create mode 100644 drivers/pwm/pwm-keembay.c

-- 
1.9.1
