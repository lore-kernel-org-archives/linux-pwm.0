From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v10 13/18] drivers/pwm: pwm-fsl-ftm: use common header for FlexTimer #defines
Date: Tue,  2 Apr 2019 15:30:48 +0900
Message-ID: <a6b1f0642988c568a545de390ef95ceb9c9f0bf0.1554184734.git.vilhelm.gray@gmail.com>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1554184734.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jic23@kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, fabrice.gasnier@st.com, benjamin.gaignard@st.com, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, akpm@linux-foundation.org, david@lechnology.com, robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, leoyang.li@nxp.com, daniel.lezcano@linaro.org, tglx@linutronix.de, thierry.reding@gmail.com, esben@haabendal.dk, linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patrick.havelange@essensium.com, William Breathitt Gray <vilhelm.gray@gmail.com>
List-Id: linux-pwm@vger.kernel.org

From: Patrick Havelange <patrick.havelange@essensium.com>

This also fixes the wrong value for the previously defined
FTM_MODE_INIT macro (it was not used).

Reviewed-by: Esben Haabendal <esben@haabendal.dk>
Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/pwm/pwm-fsl-ftm.c | 44 +--------------------------------------
 1 file changed, 1 insertion(+), 43 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 883378d055c6..f21ea1b97116 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -22,51 +22,9 @@
 #include <linux/pwm.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/fsl/ftm.h>
 
-#define FTM_SC		0x00
-#define FTM_SC_CLK_MASK_SHIFT	3
-#define FTM_SC_CLK_MASK	(3 << FTM_SC_CLK_MASK_SHIFT)
 #define FTM_SC_CLK(c)	(((c) + 1) << FTM_SC_CLK_MASK_SHIFT)
-#define FTM_SC_PS_MASK	0x7
-
-#define FTM_CNT		0x04
-#define FTM_MOD		0x08
-
-#define FTM_CSC_BASE	0x0C
-#define FTM_CSC_MSB	BIT(5)
-#define FTM_CSC_MSA	BIT(4)
-#define FTM_CSC_ELSB	BIT(3)
-#define FTM_CSC_ELSA	BIT(2)
-#define FTM_CSC(_channel)	(FTM_CSC_BASE + ((_channel) * 8))
-
-#define FTM_CV_BASE	0x10
-#define FTM_CV(_channel)	(FTM_CV_BASE + ((_channel) * 8))
-
-#define FTM_CNTIN	0x4C
-#define FTM_STATUS	0x50
-
-#define FTM_MODE	0x54
-#define FTM_MODE_FTMEN	BIT(0)
-#define FTM_MODE_INIT	BIT(2)
-#define FTM_MODE_PWMSYNC	BIT(3)
-
-#define FTM_SYNC	0x58
-#define FTM_OUTINIT	0x5C
-#define FTM_OUTMASK	0x60
-#define FTM_COMBINE	0x64
-#define FTM_DEADTIME	0x68
-#define FTM_EXTTRIG	0x6C
-#define FTM_POL		0x70
-#define FTM_FMS		0x74
-#define FTM_FILTER	0x78
-#define FTM_FLTCTRL	0x7C
-#define FTM_QDCTRL	0x80
-#define FTM_CONF	0x84
-#define FTM_FLTPOL	0x88
-#define FTM_SYNCONF	0x8C
-#define FTM_INVCTRL	0x90
-#define FTM_SWOCTRL	0x94
-#define FTM_PWMLOAD	0x98
 
 enum fsl_pwm_clk {
 	FSL_PWM_CLK_SYS,
-- 
2.21.0
