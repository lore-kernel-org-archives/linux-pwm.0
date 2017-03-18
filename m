From: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Subject: [PATCH v2 3/4] ARM: mvebu: Enable SENSORS_PWM_FAN in defconfig
Date: Sat, 18 Mar 2017 16:43:03 +0100
Message-ID: <20170318154305.28348-4-ralph.sennhauser@gmail.com>
References: <20170318154305.28348-1-ralph.sennhauser@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170318154305.28348-1-ralph.sennhauser@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-gpio@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Alexandre Courbot <gnurou@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Gregory Clement <gregory.clement@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Ralph Sennhauser <ralph.sennhauser@gmail.com>, Imre Kaloz <kaloz@openwrt.org>, "moderated list:ARM/Marvell Kirkwood and Armada 370, 375, 38x,
 ..." <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
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
