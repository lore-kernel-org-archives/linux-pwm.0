From: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Subject: [PATCH 3/4] ARM: mvebu: Enable SENSORS_PWM_FAN in defconfig
Date: Thu, 16 Mar 2017 07:42:17 +0100
Message-ID: <20170316064218.9169-4-ralph.sennhauser@gmail.com>
References: <20170316064218.9169-1-ralph.sennhauser@gmail.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170316064218.9169-1-ralph.sennhauser@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Imre Kaloz <kaloz@openwrt.org>, Ralph Sennhauser <ralph.sennhauser@gmail.com>, Jason Cooper <jason@lakedaemon.net>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "moderated list:ARM/Marvell
        Kirkwood and Armada 370, 375, 38x,..." <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>

Now that the gpio driver also supports PWM operation, enable the PWM
framework and fan driver in mvebu_v7_defconfig.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
URL: https://patchwork.ozlabs.org/patch/427297/
[Ralph Sennhauser: add fan driver to defconfig]
Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
---
 arch/arm/configs/mvebu_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index f1a0e25..6955370 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -135,6 +135,8 @@ CONFIG_DMADEVICES=y
 CONFIG_MV_XOR=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_MEMORY=y
+CONFIG_PWM=y
+CONFIG_SENSORS_PWM_FAN=y
 CONFIG_EXT4_FS=y
 CONFIG_ISO9660_FS=y
 CONFIG_JOLIET=y
-- 
2.10.2

