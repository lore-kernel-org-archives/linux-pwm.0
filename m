From: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH v3 2/4] pwm: sunxi: Selectable prescaler table
 for support sun6i.
Date: Wed, 15 Feb 2017 23:06:05 +0300
Message-ID: <1487189167-32486-3-git-send-email-lis8215@gmail.com>
References: <1487189167-32486-1-git-send-email-lis8215@gmail.com>
Reply-To: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDJLROMN3MJRBNPJSLCQKGQEXRTKD7A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1487189167-32486-1-git-send-email-lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

This patch not introduce new features, just prepare code for adding
sun6i PWM driver in next commit.

A31 SoC have a different set of prescalers than sun4i
compatible ASoCs, but its position and count in the control
register are the same.

This patch make the table of prescalers customizable.

Signed-off-by: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/pwm/pwm-sun4i.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 7291000..b4706af 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -77,7 +77,7 @@
 }


-static const u32 prescaler_table[] = {
+static const u32 sun4i_prescaler_table[] = {
 	120,
 	180,
 	240,
@@ -107,6 +107,7 @@ struct sun4i_pwm_data {
 	bool has_prescaler_bypass;
 	bool has_rdy;
 	unsigned int npwm;
+	const u32 *prescaler_table;
 	const struct sunxi_pwmch_reg_info *chan_info;
 };

@@ -129,6 +130,7 @@ static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
 	struct regmap_field **chan_fields = sun4i_pwm->fields[pwm->hwpwm];
+	const u32 *prescaler_table = sun4i_pwm->data->prescaler_table;
 	u32 prd, dty, busy, clk_gate;
 	u64 clk_rate, div = 0;
 	unsigned int prescaler = 0;
@@ -328,6 +330,7 @@ static const struct sun4i_pwm_data sun4i_pwm_data_a10 = {
 	.has_prescaler_bypass = false,
 	.has_rdy = false,
 	.npwm = 2,
+	.prescaler_table = sun4i_prescaler_table,
 	.chan_info = sun4i_field_info,
 };

@@ -335,6 +338,7 @@ static const struct sun4i_pwm_data sun4i_pwm_data_a10s = {
 	.has_prescaler_bypass = true,
 	.has_rdy = true,
 	.npwm = 2,
+	.prescaler_table = sun4i_prescaler_table,
 	.chan_info = sun4i_field_info,
 };

@@ -342,6 +346,7 @@ static const struct sun4i_pwm_data sun4i_pwm_data_a13 = {
 	.has_prescaler_bypass = true,
 	.has_rdy = true,
 	.npwm = 1,
+	.prescaler_table = sun4i_prescaler_table,
 	.chan_info = sun4i_field_info,
 };

@@ -349,6 +354,7 @@ static const struct sun4i_pwm_data sun4i_pwm_data_a20 = {
 	.has_prescaler_bypass = true,
 	.has_rdy = true,
 	.npwm = 2,
+	.prescaler_table = sun4i_prescaler_table,
 	.chan_info = sun4i_field_info,
 };

@@ -356,6 +362,7 @@ static const struct sun4i_pwm_data sun4i_pwm_data_h3 = {
 	.has_prescaler_bypass = true,
 	.has_rdy = true,
 	.npwm = 1,
+	.prescaler_table = sun4i_prescaler_table,
 	.chan_info = sun4i_field_info,
 };

--
2.4.11
