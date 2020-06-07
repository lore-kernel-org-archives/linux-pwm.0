From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?=
        <noltari@gmail.com>
Subject: [PATCH 0/2] hwmon: Add SFR NeufBox 6 hwmon support
Date: Sun,  7 Jun 2020 20:25:22 +0200
Message-ID: <20200607182524.3221837-1-noltari@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgFGSZ3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 7 Jun 2020 14:25:29 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: jdelvare@suse.com, linux@roeck-us.net, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>

SFR NeufBox 6 is equipped with an I2C connected chip to monitor voltage,
temperature and other stats. It also has PWM LEDs that can be manually
controlled or set to specific hardware monitoring modes.

Álvaro Fernández Rojas (2):
  dt-bindings: hwmon: Add SFR NB6 sensor binding
  hwmon: Add SFR NB6 sensor driver

 .../bindings/hwmon/sfr,neufbox6.yaml          |  96 ++++
 drivers/hwmon/Kconfig                         |  11 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/nb6-hwmon.c                     | 466 ++++++++++++++++++
 4 files changed, 574 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/sfr,neufbox6.yaml
 create mode 100644 drivers/hwmon/nb6-hwmon.c

-- 
2.26.2
