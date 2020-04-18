From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 13/19] pwm: bcm2835: Dynamically allocate base
Date: Sat, 18 Apr 2020 10:44:30 -0400
Message-ID: <20200418144436.10818-13-sashal@kernel.org>
References: <20200418144436.10818-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20200418144436.10818-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Thierry Reding <thierry.reding@gmail.com>, Sasha Levin <sashal@kernel.org>, linux-pwm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 2c25b07e5ec119cab609e41407a1fb3fa61442f5 ]

The newer 2711 and 7211 chips have two PWM controllers and failure to
dynamically allocate the PWM base would prevent the second PWM
controller instance being probed for succeeding with an -EEXIST error
from alloc_pwms().

Fixes: e5a06dc5ac1f ("pwm: Add BCM2835 PWM driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-bcm2835.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index b4c7f956b6fa6..388a9fa5c1d24 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -160,6 +160,7 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &bcm2835_pwm_ops;
+	pc->chip.base = -1;
 	pc->chip.npwm = 2;
 
 	platform_set_drvdata(pdev, pc);
-- 
2.20.1
