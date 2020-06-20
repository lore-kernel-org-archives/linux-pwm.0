From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
Subject: [RFC PATCH 00/10] Netronix embedded controller driver for Kobo and Tolino ebook readers
Date: Sun, 21 Jun 2020 00:39:04 +0200
Message-ID: <20200620223915.1311485-1-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Pengutronix Kernel Team <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, NXP Linux Team <linux-imx-3arQi8VN3Tc@public.gmane.org>, Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko.stuebner-SN7IsUiht6C/RdPyistoZJqQE7yCjDx5@public.gmane.org>, Stephan Gerhold <stephan-3XONVrnlUWDR7s880joybQ@public.gmane.org>, Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>, Mark Brown <broonie@kernel.>
List-Id: linux-pwm@vger.kernel.org

Hi,

This patchset adds basic support for the embedded controller found on
older ebook reader boards designed by/with the ODM Netronix Inc.[1] and
sold by Kobo or Tolino, for example the Kobo Aura and the Tolino Shine.
These drivers are based on the vendor kernel sources, but in order to
all information in a single place, I documented the register interface
of the EC on GitHub[4].

A few things still needs to be ironed out, hence the RFC tag:
 - The reboot/reset handler in patch 3/10 calls into I2C code, which may
   sleep, but reboot handlers are apparently not allowed to sleep.
 - I'm not sure I got the YAML DT bindings right. I have also included
   the plain text DT bindings for reference.


Jonathan

[1]: http://www.netronixinc.com/products.aspx?ID=3D1
[2]: https://github.com/neuschaefer/linux/wiki/Netronix-MSP430-embedded-co=
ntroller

Jonathan Neusch=C3=A4fer (10):
  DT bindings in plain text format
  dt-bindings: Add vendor prefix for Netronix, Inc.
  dt-bindings: mfd: Add binding for Netronix's embedded controller
  mfd: Add base driver for Netronix embedded controller
  dt-bindings: pwm: Add bindings for PWM function in Netronix EC
  pwm: ntxec: Add driver for PWM function in Netronix EC
  dt-bindings: rtc: Add bindings for Netronix embedded controller RTC
  rtc: New driver for RTC in Netronix embedded controller
  MAINTAINERS: Add entry for Netronix embedded controller
  ARM: dts: imx50-kobo-aura: Add Netronix embedded controller

 .../bindings/mfd/netronix,ntxec.txt           |  58 ++++++
 .../bindings/mfd/netronix,ntxec.yaml          |  77 +++++++
 .../bindings/pwm/netronix,ntxec-pwm.txt       |  27 +++
 .../bindings/pwm/netronix,ntxec-pwm.yaml      |  33 +++
 .../bindings/rtc/netronix,ntxec-rtc.txt       |  17 ++
 .../bindings/rtc/netronix,ntxec-rtc.yaml      |  27 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |  11 +
 arch/arm/boot/dts/imx50-kobo-aura.dts         |  27 ++-
 drivers/mfd/Kconfig                           |   7 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/ntxec.c                           | 188 ++++++++++++++++++
 drivers/pwm/Kconfig                           |   4 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-ntxec.c                       | 148 ++++++++++++++
 drivers/rtc/Kconfig                           |   4 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-ntxec.c                       | 115 +++++++++++
 include/linux/mfd/ntxec.h                     |  30 +++
 19 files changed, 777 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/netronix,ntxec.t=
xt
 create mode 100644 Documentation/devicetree/bindings/mfd/netronix,ntxec.y=
aml
 create mode 100644 Documentation/devicetree/bindings/pwm/netronix,ntxec-p=
wm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/netronix,ntxec-p=
wm.yaml
 create mode 100644 Documentation/devicetree/bindings/rtc/netronix,ntxec-r=
tc.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/netronix,ntxec-r=
tc.yaml
 create mode 100644 drivers/mfd/ntxec.c
 create mode 100644 drivers/pwm/pwm-ntxec.c
 create mode 100644 drivers/rtc/rtc-ntxec.c
 create mode 100644 include/linux/mfd/ntxec.h

=2D-
2.27.0
