From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 6/6] pwm: jz4740: Use __init_or_module and __exit for .probe and .remove
Date: Fri,  7 Jun 2019 17:44:10 +0200
Message-ID: <20190607154410.10633-7-paul@crapouillou.net>
References: <20190607154410.10633-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190607154410.10633-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-pwm@vger.kernel.org

This allows the probe function to be dropped after the kernel finished
its initialization, in the case where the driver was not compiled as a
module.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: New patch

 drivers/pwm/pwm-jz4740.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index f901e8a0d33d..1b5077825721 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -145,7 +145,7 @@ static const struct pwm_ops jz4740_pwm_ops = {
 	.owner = THIS_MODULE,
 };
 
-static int jz4740_pwm_probe(struct platform_device *pdev)
+static int __init_or_module jz4740_pwm_probe(struct platform_device *pdev)
 {
 	struct jz4740_pwm_chip *jz4740;
 
@@ -169,7 +169,7 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 	return pwmchip_add(&jz4740->chip);
 }
 
-static int jz4740_pwm_remove(struct platform_device *pdev)
+static int __exit jz4740_pwm_remove(struct platform_device *pdev)
 {
 	struct jz4740_pwm_chip *jz4740 = platform_get_drvdata(pdev);
 
-- 
2.21.0.593.g511ec345e18
