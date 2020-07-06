From: Michael Walle <michael@walle.cc>
Subject: [PATCH v5 04/13] mfd: simple-mfd-i2c: add sl28cpld support
Date: Mon,  6 Jul 2020 19:53:44 +0200
Message-ID: <20200706175353.16404-5-michael@walle.cc>
References: <20200706175353.16404-1-michael@walle.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from ssl.serverraum.org ([176.9.125.105]:51295 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729589AbgGFR5e (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Jul 2020 13:57:34 -0400
In-Reply-To: <20200706175353.16404-1-michael@walle.cc>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Michael Walle <michael@walle.cc>

Add the core support for the board management controller found on the
SMARC-sAL28 board.

At the moment, this controller is used on the Kontron SMARC-sAL28 board.

Signed-off-by: Michael Walle <michael@walle.cc>
---
Changes since v4:
 - new patch

 drivers/mfd/simple-mfd-i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
index 1fdca89964b1..c3556c88aa13 100644
--- a/drivers/mfd/simple-mfd-i2c.c
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -37,6 +37,7 @@ static int simple_mfd_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct of_device_id simple_mfd_i2c_of_match[] = {
+	{ .compatible = "kontron,sl28cpld-r1" },
 	{}
 };
 
-- 
2.20.1
