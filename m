From: <sean.wang@mediatek.com>
Subject: [PATCH] pwm: mediatek: remove redundant MODULE_ALIAS entries
Date: Mon, 26 Mar 2018 18:02:01 +0800
Message-ID: <0fbf589c69bc584c46c683ee7fa38d80e04624f6.1522055092.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, matthias.bgg@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>
List-Id: linux-pwm@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

MODULE_ALIAS exports information to allow the module to be auto-loaded at
boot for the drivers registered using legacy platform registration.

However, currently the driver is always used by DT-only platform,
MODULE_ALIAS is redundant and should be removed properly.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pwm/pwm-mediatek.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 98b0a93..328c1247 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -305,5 +305,4 @@ static struct platform_driver mtk_pwm_driver = {
 module_platform_driver(mtk_pwm_driver);
 
 MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
-MODULE_ALIAS("platform:mtk-pwm");
 MODULE_LICENSE("GPL");
-- 
2.7.4
