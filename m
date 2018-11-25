From: Hao Zhang <hao5781286@gmail.com>
Subject: [PATCH v3 5/6] DEV: CLK: sunxi ccu: export clk_apb1 for sun8i-r40
 soc pwm.
Date: Mon, 26 Nov 2018 00:22:03 +0800
Message-ID: <20181125162203.GA5392@arx-s1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org, mturquette@baylibre.com, sboyd@kernel.org, thierry.reding@gmail.com
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-sunxi@googlegroups.com, hao5781286@gmail.com
List-Id: linux-pwm@vger.kernel.org

The clock source for sun8i R40 is from apb1, so export it for
dt parses.

Signed-off-by: Hao Zhang <hao5781286@gmail.com>
---
 drivers/clk/sunxi-ng/ccu-sun8i-r40.h      | 4 +++-
 include/dt-bindings/clock/sun8i-r40-ccu.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r40.h b/drivers/clk/sunxi-ng/ccu-sun8i-r40.h
index db2a124..181ab26 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r40.h
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r40.h
@@ -51,7 +51,9 @@
 
 #define CLK_AXI			25
 #define CLK_AHB1		26
-#define CLK_APB1		27
+
+/* The APB1 clock is exported */
+
 #define CLK_APB2		28
 
 /* All the bus gates are exported */
diff --git a/include/dt-bindings/clock/sun8i-r40-ccu.h b/include/dt-bindings/clock/sun8i-r40-ccu.h
index f9e15a2..a2b8f06 100644
--- a/include/dt-bindings/clock/sun8i-r40-ccu.h
+++ b/include/dt-bindings/clock/sun8i-r40-ccu.h
@@ -49,6 +49,8 @@
 
 #define CLK_CPU			24
 
+#define CLK_APB1                27
+
 #define CLK_BUS_MIPI_DSI	29
 #define CLK_BUS_CE		30
 #define CLK_BUS_DMA		31
-- 
2.7.4
