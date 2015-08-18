From: Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: [PATCH v4 3/5] ARM: berlin: add a PWM node on the BG2Q
Date: Tue, 18 Aug 2015 13:38:06 +0200
Message-ID: <1439897888-10921-4-git-send-email-antoine.tenart@free-electrons.com>
References: <1439897888-10921-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1439897888-10921-1-git-send-email-antoine.tenart@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: sebastian.hesselbarth@gmail.com, thierry.reding@gmail.com
Cc: zmxu@marvell.com, jszhang@marvell.com, linux-pwm@vger.kernel.org, Antoine Tenart <antoine.tenart@free-electrons.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

This patch adds a PWM node in the Berlin BG2Q device tree, using the
newly added Berlin PWM driver.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 63a48490e2f9..5bfa71a87617 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -477,6 +477,13 @@
 			status = "disabled";
 		};
 
+		pwm: pwm@f20000 {
+			compatible = "marvell,berlin-pwm";
+			reg = <0xf20000 0x40>;
+			clocks = <&chip_clk CLKID_CFG>;
+			#pwm-cells = <3>;
+		};
+
 		apb@fc0000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
-- 
2.5.0
