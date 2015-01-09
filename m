From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 6/7] arm: mvebu: Enable PWM in defconfig
Date: Sat, 10 Jan 2015 00:34:52 +0100
Message-ID: <1420846493-31647-7-git-send-email-andrew@lunn.ch>
References: <1420846493-31647-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1420846493-31647-1-git-send-email-andrew@lunn.ch>
Sender: linux-gpio-owner@vger.kernel.org
To: linus.walleij@linaro.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, kaloz@openwrt.org, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
List-Id: linux-pwm@vger.kernel.org

Now that the gpio driver also supports PWM operation, enable
the PWM framework in mvebu_v7_defconfig.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/configs/mvebu_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index 627accea72fb..c80a5cbf6128 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -116,6 +116,7 @@ CONFIG_DMADEVICES=y
 CONFIG_MV_XOR=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_MEMORY=y
+CONFIG_PWM=y
 CONFIG_EXT4_FS=y
 CONFIG_ISO9660_FS=y
 CONFIG_JOLIET=y
-- 
2.1.3

