From: "Wesley W. Terpstra" <wesley@sifive.com>
Subject: [PATCH 0/3] SiFive SoC PWM driver
Date: Fri, 27 Apr 2018 15:59:55 -0700
Message-ID: <1524869998-2805-1-git-send-email-wesley@sifive.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>, David Lechner <david@lechnology.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, SZ Lin <sz.lin@moxa.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Wesley W. Terpstra" <wesley@sifive.com>
List-Id: linux-pwm@vger.kernel.org

SiFive SoCs can contain one or more PWM IP blocks.
This adds a driver for them. Tested on the HiFive Unleashed.

This patch series is broken into three parts:
  The driver itself, in drivers/pwm
  The device tree binding description, in Documentation/devicetree/bindings
  The SiFive vendor prefix, in Documentation/devicetree/bindings

Wesley W. Terpstra (3):
  dt-bindings: added new pwm-sifive driver documentation
  dt-bindings: Add "sifive" vendor prefix
  pwm-sifive: add a driver for SiFive SoC PWM

 .../devicetree/bindings/pwm/pwm-sifive.txt         |  28 +++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/pwm/Kconfig                                |  11 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-sifive.c                           | 259 +++++++++++++++++++++
 5 files changed, 300 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
 create mode 100644 drivers/pwm/pwm-sifive.c

-- 
2.7.4
