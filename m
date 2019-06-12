From: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Subject: [PATCH v2 0/3] PWM framework: add support referencing PWMs from ACPI
Date: Wed, 12 Jun 2019 10:36:05 +0200
Message-ID: <cover.1560327219.git.nikolaus.voss@loewensteinmedical.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>, linux-acpi@vger.kernel.org, devel@acpica.org, linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, nv@vosn.de
List-Id: linux-pwm@vger.kernel.org

As described in Documentation/firmware-guide/acpi/gpio-properties.rst a
GPIO can be referenced from ACPI ASL _DSD with the "gpios"-property of the
form:

  Package () { "gpios", Package () { ref, index, pin, active_low }}

The second patch of this series adds support for specifing a PWM
reference in ASL of the form

  Package () { "pwms", Package () { ref, index, pwm-period [, pwm flags]}}

The first patch of this series is necessary to resolve the "ref" in ASL
if the table has been loaded by efivar_ssdt_load() or configfs.

The third patch of this series makes leds-pwm use the ACPI-enabled
PWM framework.

v2:
- fixes by Pavel Machek and Dan Murphy

Nikolaus Voss (3):
  ACPI: Resolve objects on host-directed table loads
  PWM framework: add support referencing PWMs from ACPI
  leds-pwm.c: support ACPI via firmware-node framework

 drivers/acpi/acpi_configfs.c   |   6 +-
 drivers/acpi/acpica/tbxfload.c |  11 ++++
 drivers/leds/leds-pwm.c        |  45 +++++++------
 drivers/pwm/core.c             | 113 +++++++++++++++++++++++++++++++++
 include/linux/pwm.h            |   9 +++
 5 files changed, 161 insertions(+), 23 deletions(-)

-- 
2.17.1
