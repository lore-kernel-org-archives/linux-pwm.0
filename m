From: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Subject: [PATCH v5 3/4] ARM: mvebu: Enable SENSORS_PWM_FAN in defconfig
Date: Sun,  9 Apr 2017 20:09:29 +0200
Message-ID: <20170409180931.4884-4-ralph.sennhauser@gmail.com>
References: <20170409180931.4884-1-ralph.sennhauser@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170409180931.4884-1-ralph.sennhauser@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Ralph Sennhauser <ralph.sennhauser@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>

Now that the GPIO driver also supports PWM operation, enable the PWM
framework and fan driver in mvebu_v7_defconfig.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
URL: https://patchwork.ozlabs.org/patch/427297/
[Ralph Sennhauser: add fan driver to defconfig]
Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Tested-by: Andrew Lunn <andrew@lunn.ch>
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
