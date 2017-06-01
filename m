From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCHv2 1/2] gpio: mvebu: fix blink counter register selection
Date: Thu,  1 Jun 2017 14:18:25 +0200
Message-ID: <20170601121826.14685-2-richard.genoud@gmail.com>
References: <20170601121826.14685-1-richard.genoud@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170601121826.14685-1-richard.genoud@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Ralph Sennhauser <ralph.sennhauser@gmail.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Richard Genoud <richard.genoud@gmail.com>
List-Id: linux-pwm@vger.kernel.org

The blink counter A was always selected because 0 was forced in the
blink select counter register.
The variable 'set' was obviously there to be used as the register value,
selecting the B counter when id==1 and A counter when id==0.

Tested on clearfog-pro (Marvell 88F6828)

Fixes: 757642f9a584 ("gpio: mvebu: Add limited PWM support")
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Reviewed-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/gpio/gpio-mvebu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 19a92efabbef..cdef2c78cb3b 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -747,7 +747,7 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 		set = U32_MAX;
 	else
 		return -EINVAL;
-	writel_relaxed(0, mvebu_gpioreg_blink_counter_select(mvchip));
+	writel_relaxed(set, mvebu_gpioreg_blink_counter_select(mvchip));
 
 	mvpwm = devm_kzalloc(dev, sizeof(struct mvebu_pwm), GFP_KERNEL);
 	if (!mvpwm)
