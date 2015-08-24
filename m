From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v2 0/2] pwm: Broadcom BCM7038 PWM controller (v2)
Date: Mon, 24 Aug 2015 11:27:55 -0700
Message-ID: <1440440877-10644-1-git-send-email-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com, thierry.reding@gmail.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Hi,

This patch series add PWM support for the Broadcom BCM7xxx
chips which feature one or more PWM controllers capable of
output periods from 148ns to ~622ms using a combination of
variable and fixed frequency settings.

The controller does not support setting a polarity.

This is based on Thierry's pwm/next branch.

Florian Fainelli (2):
  Documentation: dt: add Broadcom BCM7038 PWM controller binding
  pwm: Add Broadcom BCM7038 PWM controller support

 .../devicetree/bindings/pwm/brcm,bcm7038-pwm.txt   |  22 ++
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-brcmstb.c                          | 338 +++++++++++++++++++++
 4 files changed, 371 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.txt
 create mode 100644 drivers/pwm/pwm-brcmstb.c

-- 
2.1.0
