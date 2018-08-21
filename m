From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v7 10/24] watchdog: jz4740: Avoid starting watchdog in set_timeout
Date: Tue, 21 Aug 2018 19:16:21 +0200
Message-ID: <20180821171635.22740-11-paul@crapouillou.net>
References: <20180821171635.22740-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180821171635.22740-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Jonathan Corbet <corbet@lwn.net>
Cc: od@zcrc.me, Mathieu Malaterre <malat@debian.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-pwm@vger.kernel.org

Previously the jz4740_wdt_set_timeout() function was starting the timer
unconditionally, even if it was stopped when that function was entered.

Now, the timer will be restarted only if it was already running before
this function is called.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---

Notes:
     v6: New patch
    
     v7: No change

 drivers/watchdog/jz4740_wdt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index 0f54306aee25..45d9495170e5 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -64,13 +64,15 @@ static int jz4740_wdt_set_timeout(struct watchdog_device *wdt_dev,
 {
 	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
 	u16 timeout_value = (u16)(drvdata->clk_rate * new_timeout);
+	u32 tcer;
 
+	regmap_read(drvdata->map, TCU_REG_WDT_TCER, &tcer);
 	regmap_write(drvdata->map, TCU_REG_WDT_TCER, 0);
 
 	regmap_write(drvdata->map, TCU_REG_WDT_TDR, timeout_value);
 	regmap_write(drvdata->map, TCU_REG_WDT_TCNT, 0);
 
-	regmap_write(drvdata->map, TCU_REG_WDT_TCER, TCU_WDT_TCER_TCEN);
+	regmap_write(drvdata->map, TCU_REG_WDT_TCER, tcer & TCU_WDT_TCER_TCEN);
 
 	wdt_dev->timeout = new_timeout;
 	return 0;
@@ -86,6 +88,7 @@ static int jz4740_wdt_start(struct watchdog_device *wdt_dev)
 		return ret;
 
 	jz4740_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
+	regmap_write(drvdata->map, TCU_REG_WDT_TCER, TCU_WDT_TCER_TCEN);
 
 	return 0;
 }
-- 
2.11.0
