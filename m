From: Michael Walle <michael@walle.cc>
Subject: [PATCH 02/18] mfd: mfd-core: Don't overwrite the dma_mask of the child device
Date: Tue, 17 Mar 2020 21:50:01 +0100
Message-ID: <20200317205017.28280-3-michael@walle.cc>
References: <20200317205017.28280-1-michael@walle.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-hwmon-owner@vger.kernel.org>
In-Reply-To: <20200317205017.28280-1-michael@walle.cc>
Sender: linux-hwmon-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, Michael Walle <michael@walle.cc>, Robin Murphy <robin.murphy@arm.com>
List-Id: linux-pwm@vger.kernel.org

Commit cdfee5623290 ("driver core: initialize a default DMA mask for
platform device") initialize the DMA of a platform device. But if the
parent doesn't have a dma_mask set, for example if it's an I2C device,
the dma_mask of the child platform device will be set to zero again.
Which leads to many "DMA mask not set" warnings, if the MFD cell has the
of_compatible property set.

[    1.877937] sl28cpld-pwm sl28cpld-pwm: DMA mask not set
[    1.883282] sl28cpld-pwm sl28cpld-pwm.0: DMA mask not set
[    1.888795] sl28cpld-gpio sl28cpld-gpio: DMA mask not set

Thus don't overwrite the dma_mask of the children. Instead set the
dma_mask of the platform device.

Signed-off-by: Michael Walle <michael@walle.cc>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/mfd/mfd-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index f5a73af60dd4..e735565969b3 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -138,7 +138,7 @@ static int mfd_add_device(struct device *parent, int id,
 
 	pdev->dev.parent = parent;
 	pdev->dev.type = &mfd_dev_type;
-	pdev->dev.dma_mask = parent->dma_mask;
+	pdev->platform_dma_mask = parent->dma_mask ? *parent->dma_mask : 0;
 	pdev->dev.dma_parms = parent->dma_parms;
 	pdev->dev.coherent_dma_mask = parent->coherent_dma_mask;
 
-- 
2.20.1
