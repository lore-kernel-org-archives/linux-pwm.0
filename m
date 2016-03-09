From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 2/6] arm64: defconfig : add PWM driver support
Date: Wed,  9 Mar 2016 17:55:58 +0100
Message-ID: <1457542562-7880-3-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1457542562-7880-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1457542562-7880-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org
Cc: linux-pwm@vger.kernel.org, magnus.damm@gmail.com, thierry.reding@gmail.com, Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-pwm@vger.kernel.org

From: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>

Signed-off-by: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b81cdf9..ad184d8 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -249,6 +249,8 @@ CONFIG_ARCH_TEGRA_210_SOC=y
 CONFIG_HISILICON_IRQ_MBIGEN=y
 CONFIG_EXTCON_USB_GPIO=y
 CONFIG_PHY_RCAR_GEN3_USB2=y
+CONFIG_PWM=y
+CONFIG_PWM_RCAR=y
 CONFIG_PHY_XGENE=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-- 
2.6.4
