From: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Subject: [PATCH v2 4/4] mvebu: wrt1900ac: Use pwm-fan rather than gpio-fan
Date: Sat, 18 Mar 2017 16:43:04 +0100
Message-ID: <20170318154305.28348-5-ralph.sennhauser@gmail.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Alexandre Courbot <gnurou@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Gregory Clement <gregory.clement@free-electrons.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Ralph Sennhauser <ralph.sennhauser@gmail.com>, Imre Kaloz <kaloz@openwrt.org>, "moderated list:ARM/Marvell Kirkwood and Armada 370, 375, 38x,
 ..." <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pwm@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>

The mvebu gpio driver can also perform PWM on some pins. Us the pwm-fan
driver to control the fan of the WRT1900AC, giving us finer grained
control over its speed and hence noise.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
URL: https://patchwork.ozlabs.org/patch/427291/
Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
---
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
index 3744ba3..836b275e 100644
--- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
@@ -293,13 +293,11 @@
 		};
 	};
 
-	gpio_fan {
+	pwm_fan {
 		/* SUNON HA4010V4-0000-C99 */
-		compatible = "gpio-fan";
-		gpios = <&gpio0 24 0>;
 
-		gpio-fan,speed-map = <0    0
-				      4500 1>;
+		compatible = "pwm-fan";
+		pwms = <&gpio0 24 4000 0>;
 	};
 
 	dsa {
-- 
2.10.2
