From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [RESEND PATCH v2 1/8] pwm: stm32: fix, remove unused struct device
Date: Wed, 14 Feb 2018 11:04:32 +0100
Message-ID: <1518602679-3064-2-git-send-email-fabrice.gasnier@st.com>
References: <1518602679-3064-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1518602679-3064-1-git-send-email-fabrice.gasnier@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lee.jones@linaro.org, thierry.reding@gmail.com, alexandre.torgue@st.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, benjamin.gaignard@linaro.org, linux-pwm@vger.kernel.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, robh+dt@kernel.org, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, linux-arm-kernel@lists.infradead.org, benjamin.gaignard@st.com
List-Id: linux-pwm@vger.kernel.org

dev is never assigned nor used. remove it.

Fixes: 7edf7369205b ("pwm: Add driver for STM32 plaftorm")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 drivers/pwm/pwm-stm32.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 6139512..59524f9 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -21,7 +21,6 @@
 
 struct stm32_pwm {
 	struct pwm_chip chip;
-	struct device *dev;
 	struct clk *clk;
 	struct regmap *regmap;
 	u32 max_arr;
-- 
1.9.1
