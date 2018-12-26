From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 91/97] gpio: mvebu: only fail on missing clk if pwm is actually to be used
Date: Wed, 26 Dec 2018 17:35:51 -0500
Message-ID: <20181226223557.149329-91-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Sasha Levin <sashal@kernel.org>, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit c8da642d41a6811c21177c9994aa7dc35be67d46 ]

The gpio IP on Armada 370 at offset 0x18180 has neither a clk nor pwm
registers. So there is no need for a clk as the pwm isn't used anyhow.
So only check for the clk in the presence of the pwm registers. This fixes
a failure to probe the gpio driver for the above mentioned gpio device.

Fixes: 757642f9a584 ("gpio: mvebu: Add limited PWM support")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-mvebu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 6e02148c208b..adc768f908f1 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -773,9 +773,6 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 				     "marvell,armada-370-gpio"))
 		return 0;
 
-	if (IS_ERR(mvchip->clk))
-		return PTR_ERR(mvchip->clk);
-
 	/*
 	 * There are only two sets of PWM configuration registers for
 	 * all the GPIO lines on those SoCs which this driver reserves
@@ -786,6 +783,9 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 	if (!res)
 		return 0;
 
+	if (IS_ERR(mvchip->clk))
+		return PTR_ERR(mvchip->clk);
+
 	/*
 	 * Use set A for lines of GPIO chip with id 0, B for GPIO chip
 	 * with id 1. Don't allow further GPIO chips to be used for PWM.
-- 
2.19.1
