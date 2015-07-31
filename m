From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 02/23] Documentation: dt: atmel-at91: add slow clock to tcb
Date: Fri, 31 Jul 2015 11:39:38 +0200
Message-ID: <1438335599-3301-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

From: Boris Brezillon <boris.brezillon@free-electrons.com>

The timer counters need the slow clock. It is required as they
will not function without it.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org
 Documentation/devicetree/bindings/arm/atmel-at91.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
index 209710cdf3aa..dc2d0f06d058 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
@@ -62,7 +62,7 @@ TC/TCLIB Timer required properties:
   Note that you can specify several interrupt cells if the TC
   block has one interrupt per channel.
 - clock-names: tuple listing input clock names.
-	Required elements: "t0_clk"
+	Required elements: "t0_clk", "slow_clk"
 	Optional elements: "t1_clk", "t2_clk"
 - clocks: phandles to input clocks.
 
-- 
2.1.4
