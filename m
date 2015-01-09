From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: [PATCH v8 0/2] Imagination Technologies PWM support
Date: Fri, 9 Jan 2015 14:54:46 -0300
Message-ID: <1420826088-13113-1-git-send-email-ezequiel.garcia@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Bresticker <abrestic@chromium.org>, Thierry Reding <thierry.reding@gmail.com>, James Hartley <james.hartley@imgtec.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, vladimir_zapolskiy@mentor.com, Ezequiel Garcia <ezequiel.garcia@imgtec.com>
List-Id: linux-pwm@vger.kernel.org

A new round for the IMG PWM driver.

The IMG PWM controller is muxed with a PDM controller, through a shared
so-called periph register bit, which sets the output as PWM or PDM.
Because this register is not part of the pin controller block, but rather
PWM/PDM specific, and because the register is also used to set the PDM value,
it is simpler to use a regmap-based syscon to deal with it.

This time, I'm removing the PDM driver from the submission and submitting the PWM
alone. The PDM was written as a misc driver, but had some design issues, so for
now I'm proposing to merge the PWM only.

The series is based on v3.19-rc3. If at all possible I'd like to see this merged
for v3.20.

Comments welcome!

Naidu Tellapati (2):
  pwm: Imagination Technologies PWM DAC driver
  DT: pwm: Add binding document for IMG PWM DAC

 Documentation/devicetree/bindings/pwm/img-pwm.txt |  24 +++
 drivers/pwm/Kconfig                               |  13 ++
 drivers/pwm/Makefile                              |   1 +
 drivers/pwm/pwm-img.c                             | 250 ++++++++++++++++++++++
 4 files changed, 288 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/img-pwm.txt
 create mode 100644 drivers/pwm/pwm-img.c

-- 
2.2.1
