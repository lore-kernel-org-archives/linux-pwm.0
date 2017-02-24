From: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH v4 6/9] pwm: sunxi: Increase max number of pwm channels.
Date: Fri, 24 Feb 2017 08:41:13 +0300
Message-ID: <1487914876-8594-7-git-send-email-lis8215@gmail.com>
References: <1487914876-8594-1-git-send-email-lis8215@gmail.com>
Reply-To: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDJLROMN3MJRBB4PX7CQKGQEDBN4ANQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1487914876-8594-1-git-send-email-lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

From: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

sun6i have 4 pwm channels onboard. This patch increase
maximal possible count of channels.

Signed-off-by: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/pwm/pwm-sun4i.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 9463148..a179a53 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -46,7 +46,7 @@
 
 #define BIT_CH(bit, chan)	((bit) << ((chan) * PWMCH_OFFSET))
 
-#define SUN4I_MAX_PWM_CHANNELS	2
+#define SUNXI_MAX_PWM_CHANNELS	4
 
 /* regmap fields */
 enum {
@@ -91,14 +91,14 @@ struct sun4i_pwm_data {
 	bool has_rdy;
 	unsigned int npwm;
 	const u32 *prescaler_table;
-	const struct sunxi_pwmch_data *chan_data[SUN4I_MAX_PWM_CHANNELS];
+	const struct sunxi_pwmch_data *chan_data[SUNXI_MAX_PWM_CHANNELS];
 };
 
 struct sun4i_pwm_chip {
 	struct pwm_chip chip;
 	struct clk *clk;
 	struct regmap *regmap;
-	struct regmap_field *fields[SUN4I_MAX_PWM_CHANNELS][NUM_FIELDS];
+	struct regmap_field *fields[SUNXI_MAX_PWM_CHANNELS][NUM_FIELDS];
 	spinlock_t ctrl_lock;
 	const struct sun4i_pwm_data *data;
 };
@@ -426,7 +426,7 @@ static int sunxi_alloc_reg_fields(struct device *dev,
 	int i, err;
 	const struct sunxi_pwmch_data *data = pwm->data->chan_data[chan];
 
-	if (!data || chan >= SUN4I_MAX_PWM_CHANNELS)
+	if (!data || chan >= SUNXI_MAX_PWM_CHANNELS)
 		return -EINVAL;
 	for (i = 0; i < NUM_FIELDS; i++) {
 		pwm->fields[chan][i] =
-- 
2.4.11
