From: Rahul Tanwar <rahul.tanwar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 0/2] pwm: intel:  Add PWM driver for new SoC
Date: Fri, 22 May 2020 15:41:57 +0800
Message-ID: <cover.1590132733.git.rahul.tanwar@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, songjun.Wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, cheol.yong.kim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, qi-ming.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Rahul Tanwar <rahul.tanwar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Patch 1 adds dt binding document in YAML format.
Patch 2 add PWM driver for LGM SoC.


Rahul Tanwar (2):
  Add YAML schema for a new PWM driver
  Add PWM driver for LGM

 .../devicetree/bindings/pwm/pwm-intel-lgm.yaml     |  43 +++
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-intel-lgm.c                        | 356 +++++++++++++++++++++
 4 files changed, 409 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-intel-lgm.yaml
 create mode 100644 drivers/pwm/pwm-intel-lgm.c

-- 
2.11.0
