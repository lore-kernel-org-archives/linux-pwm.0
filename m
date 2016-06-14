From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v3 02/14] pwm: Add two helpers to ease relative duty cycle
 manipulation
Date: Tue, 14 Jun 2016 11:13:10 +0200
Message-ID: <1465895602-31008-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1465895602-31008-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1465895602-31008-1-git-send-email-boris.brezillon@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Milo Kim <milo.kim@ti.com>, Heiko Stuebner <heiko@sntech.de>, Patrice Chotard <patrice.chotard@st.com>, Laxman Dewangan <ldewangan@nvidia.com>, kernel@stlinux.com, Boris Brezillon <boris.brezillon@free-electrons.com>, Brian Norris <briannorris@chromium.org>, Stephen Barber <smbarber@chromium.org>, linux-rockchip@lists.infradead.org, Caesar Wang <wxt@rock-chips.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Doug Anderson <dianders@google.com>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Maxime Coquelin <maxime.coquelin@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, linux-kernel@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Ajit Pal Singh <ajitpal.singh@st.com>
List-Id: linux-pwm@vger.kernel.org

The PWM framework expects PWM users to configure the duty cycle in
nanoseconds, but most users just want to express this duty cycle
relatively to the period value (i.e. duty_cycle = 33% of the period).
Add the pwm_{get,set}_relative_duty_cycle() helpers to ease this kind
of conversion.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
 include/linux/pwm.h | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index a100f6e..05e4ea4 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -181,6 +181,62 @@ static inline void pwm_init_state(const struct pwm_device *pwm,
 }
 
 /**
+ * pwm_get_relative_duty_cycle() - Get a relative duty_cycle value
+ * @state: PWM state to extract the duty_cycle from
+ * @scale: target scale of the relative duty cycle
+ *
+ * This functions converts the absolute duty_cycle stored in @state
+ * (expressed in nanosecond) into a value relative to the period.
+ * For example if you want to get the duty_cycle expressed in percent,
+ * call:
+ *
+ * pwm_get_state(pwm, &state);
+ * duty = pwm_get_relative_duty_cycle(&state, 100);
+ */
+static inline unsigned int
+pwm_get_relative_duty_cycle(const struct pwm_state *state, unsigned int scale)
+{
+	if (!state->period)
+		return 0;
+
+	return DIV_ROUND_CLOSEST_ULL((u64)state->duty_cycle * scale,
+				     state->period);
+}
+
+/**
+ * pwm_set_relative_duty_cycle() - Set a relative duty_cycle value
+ * @state: PWM state to fill
+ * @duty_cycle: relative duty_cycle value
+ * @scale: scale in which @duty_cycle is expressed
+ *
+ * This functions converts a relative duty_cycle into an absolute one
+ * (expressed in nanoseconds), and put the result in state->duty_cycle.
+ *
+ * For example if you want to configure a 50% duty_cycle, call:
+ *
+ * pwm_init_state(pwm, &state);
+ * pwm_set_relative_duty_cycle(&state, 50, 100);
+ * pwm_apply_state(pwm, &state);
+ *
+ * This functions returns -EINVAL if @duty_cycle and/or @scale are
+ * inconsistent (@scale == 0 or @duty_cycle > @scale).
+ */
+static inline int
+pwm_set_relative_duty_cycle(struct pwm_state *state, unsigned int duty_cycle,
+			    unsigned int scale)
+{
+	/* Make sure @scale is > 0 and @duty_cycle <= @scale */
+	if (!scale || duty_cycle > scale)
+		return -EINVAL;
+
+	state->duty_cycle = DIV_ROUND_CLOSEST_ULL((u64)duty_cycle *
+						  state->period,
+						  scale);
+
+	return 0;
+}
+
+/**
  * struct pwm_ops - PWM controller operations
  * @request: optional hook for requesting a PWM
  * @free: optional hook for freeing a PWM
-- 
2.7.4
