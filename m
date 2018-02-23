From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [RESEND PATCH 2/3] pwm: stm32: LPTimer: use 3 cells xlate
Date: Fri, 23 Feb 2018 14:36:04 +0100
Message-ID: <1519392965-28235-3-git-send-email-fabrice.gasnier@st.com>
References: <1519392965-28235-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1519392965-28235-1-git-send-email-fabrice.gasnier@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: thierry.reding@gmail.com, alexandre.torgue@st.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, benjamin.gaignard@linaro.org, linux-pwm@vger.kernel.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, robh+dt@kernel.org, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

From: Gerald Baeza <gerald.baeza@st.com>

STM32 Low-Power Timer supports generic 3 cells pwm to encode
PWM number, period and polarity.

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/pwm/pwm-stm32-lp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 1ac9e43..346b7bd 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -203,6 +203,8 @@ static int stm32_pwm_lp_probe(struct platform_device *pdev)
 	priv->chip.dev = &pdev->dev;
 	priv->chip.ops = &stm32_pwm_lp_ops;
 	priv->chip.npwm = 1;
+	priv->chip.of_xlate = of_pwm_xlate_with_flags;
+	priv->chip.of_pwm_n_cells = 3;
 
 	ret = pwmchip_add(&priv->chip);
 	if (ret < 0)
-- 
1.9.1
