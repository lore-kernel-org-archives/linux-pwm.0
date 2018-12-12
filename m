From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v8 14/26] pwm: jz4740: Remove unused devicetree compatible strings
Date: Wed, 12 Dec 2018 23:09:09 +0100
Message-ID: <20181212220922.18759-15-paul@crapouillou.net>
References: <20181212220922.18759-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212220922.18759-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Mathieu Malaterre <malat@debian.org>, Ezequiel Garcia <ezequiel@collabora.co.uk>, PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, od@zcrc.me, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-pwm@vger.kernel.org

Right now none of the Ingenic-based boards probe this driver from
devicetree. This driver defined three compatible strings for the exact
same behaviour. Before these strings are used, we can remove two of
them.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
---

Notes:
     v5: New patch
    
     v6: No change
    
     v7: No change

     v8: No change

 drivers/pwm/pwm-jz4740.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 7b12e5628f4f..cb8d8cec353f 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -258,8 +258,6 @@ static int jz4740_pwm_remove(struct platform_device *pdev)
 #ifdef CONFIG_OF
 static const struct of_device_id jz4740_pwm_dt_ids[] = {
 	{ .compatible = "ingenic,jz4740-pwm", },
-	{ .compatible = "ingenic,jz4770-pwm", },
-	{ .compatible = "ingenic,jz4780-pwm", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, jz4740_pwm_dt_ids);
-- 
2.11.0
