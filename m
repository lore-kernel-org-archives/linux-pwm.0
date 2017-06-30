From: Zhi Mao <zhi.mao@mediatek.com>
Subject: [PATCH v3 1/6] pwm: kconfig: modify mediatek information
Date: Fri, 30 Jun 2017 14:05:16 +0800
Message-ID: <1498802721-32455-2-git-send-email-zhi.mao@mediatek.com>
References: <1498802721-32455-1-git-send-email-zhi.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498802721-32455-1-git-send-email-zhi.mao@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: john@phrozen.org, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org
Cc: srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, zhi.mao@mediatek.com, yingjoe.chen@mediatek.com, yt.shen@mediatek.com, sean.wang@mediatek.com, zhenbao.liu@mediatek.com
List-Id: linux-pwm@vger.kernel.org

modify mediatek information

Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
---
 drivers/pwm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 313c107..45cdf2a 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -300,7 +300,7 @@ config PWM_MEDIATEK
 	  Generic PWM framework driver for Mediatek ARM SoC.
 
 	  To compile this driver as a module, choose M here: the module
-	  will be called pwm-mxs.
+	  will be called pwm-mediatek.
 
 config PWM_MXS
 	tristate "Freescale MXS PWM support"
-- 
1.7.9.5
