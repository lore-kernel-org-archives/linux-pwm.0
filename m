From: Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH v2 3/7] drivers/clocksource: timer-fsl-ftm: use common header for FlexTimer #defines
Date: Wed,  6 Mar 2019 12:12:04 +0100
Message-ID: <20190306111208.7454-4-patrick.havelange@essensium.com>
References: <20190306111208.7454-1-patrick.havelange@essensium.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190306111208.7454-1-patrick.havelange@essensium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: William Breathitt Gray <vilhelm.gray@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Esben Haabendal <esben@haabendal.dk>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Jonathan Cameron <jic23@kernel.org>
Cc: Patrick Havelange <patrick.havelange@essensium.com>
List-Id: linux-pwm@vger.kernel.org

Common #defines have been moved to "linux/fsl/ftm.h". Thus making use of
this file.
Also FTM_SC_CLK_SHIFT has been renamed to FTM_SC_CLK_MASK_SHIFT.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Reviewed-by: Esben Haabendal <esben@haabendal.dk>
---
Changes v2
     - None
---
 drivers/clocksource/timer-fsl-ftm.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/clocksource/timer-fsl-ftm.c b/drivers/clocksource/timer-fsl-ftm.c
index 846d18daf893..e1c34b2f53a5 100644
--- a/drivers/clocksource/timer-fsl-ftm.c
+++ b/drivers/clocksource/timer-fsl-ftm.c
@@ -19,20 +19,9 @@
 #include <linux/of_irq.h>
 #include <linux/sched_clock.h>
 #include <linux/slab.h>
+#include <linux/fsl/ftm.h>
 
-#define FTM_SC		0x00
-#define FTM_SC_CLK_SHIFT	3
-#define FTM_SC_CLK_MASK	(0x3 << FTM_SC_CLK_SHIFT)
-#define FTM_SC_CLK(c)	((c) << FTM_SC_CLK_SHIFT)
-#define FTM_SC_PS_MASK	0x7
-#define FTM_SC_TOIE	BIT(6)
-#define FTM_SC_TOF	BIT(7)
-
-#define FTM_CNT		0x04
-#define FTM_MOD		0x08
-#define FTM_CNTIN	0x4C
-
-#define FTM_PS_MAX	7
+#define FTM_SC_CLK(c)	((c) << FTM_SC_CLK_MASK_SHIFT)
 
 struct ftm_clock_device {
 	void __iomem *clksrc_base;
-- 
2.19.1
