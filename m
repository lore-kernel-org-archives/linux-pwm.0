From: lis8215@gmail.com
Subject: [PATCH v2 2/4] ARM: pwm: sun4i: selectable prescaler table for support sun6i.
Date: Tue,  7 Feb 2017 20:50:44 +0300
Message-ID: <1486489846-662-3-git-send-email-lis8215@gmail.com>
References: <1486489846-662-1-git-send-email-lis8215@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33423 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754680AbdBGRvP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Feb 2017 12:51:15 -0500
In-Reply-To: <1486489846-662-1-git-send-email-lis8215@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-sunxi@googlegroups.com
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, maxime.ripard@free-electrons.com, wens@csie.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Siarhei Volkau <lis8215@gmail.com>

From: Siarhei Volkau <lis8215@gmail.com>

This patch not introduce new features, just prepare code for
adding sun6i PWM driver in next commit.

A31 SoC have a different set of prescalers than others ASoCs, but
its position and count in the control register are the same.

This patch make the table of prescalers customizable.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 drivers/pwm/pwm-sun4i.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 04ad3b4..39912fc 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -49,7 +49,7 @@
 
 struct sun4i_pwm_chip;
 
-static const u32 prescaler_table[] = {
+static const u32 sun4i_prescaler_table[] = {
 	120,
 	180,
 	240,
@@ -81,6 +81,7 @@ struct sun4i_pwm_data {
 	bool has_rdy;
 	unsigned int npwm;
 	const struct sunxi_reg_ops *ops;
+	const u32 *prescaler_table;
 };
 
 struct sun4i_pwm_chip {
@@ -144,6 +145,7 @@ static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
 	const struct sunxi_reg_ops *reg_ops = sun4i_pwm->data->ops;
+	const u32 *prescaler_table = sun4i_pwm->data->prescaler_table;
 	u32 prd, dty, val, clk_gate;
 	u64 clk_rate, div = 0;
 	unsigned int prescaler = 0;
@@ -317,6 +319,7 @@ static const struct sun4i_pwm_data sun4i_pwm_data_a10 = {
 	.has_rdy = false,
 	.npwm = 2,
 	.ops = &sun4i_reg_ops,
+	.prescaler_table = sun4i_prescaler_table,
 };
 
 static const struct sun4i_pwm_data sun4i_pwm_data_a10s = {
@@ -324,6 +327,7 @@ static const struct sun4i_pwm_data sun4i_pwm_data_a10s = {
 	.has_rdy = true,
 	.npwm = 2,
 	.ops = &sun4i_reg_ops,
+	.prescaler_table = sun4i_prescaler_table,
 };
 
 static const struct sun4i_pwm_data sun4i_pwm_data_a13 = {
@@ -331,6 +335,7 @@ static const struct sun4i_pwm_data sun4i_pwm_data_a13 = {
 	.has_rdy = true,
 	.npwm = 1,
 	.ops = &sun4i_reg_ops,
+	.prescaler_table = sun4i_prescaler_table,
 };
 
 static const struct sun4i_pwm_data sun4i_pwm_data_a20 = {
@@ -338,6 +343,7 @@ static const struct sun4i_pwm_data sun4i_pwm_data_a20 = {
 	.has_rdy = true,
 	.npwm = 2,
 	.ops = &sun4i_reg_ops,
+	.prescaler_table = sun4i_prescaler_table,
 };
 
 static const struct sun4i_pwm_data sun4i_pwm_data_h3 = {
@@ -345,6 +351,7 @@ static const struct sun4i_pwm_data sun4i_pwm_data_h3 = {
 	.has_rdy = true,
 	.npwm = 1,
 	.ops = &sun4i_reg_ops,
+	.prescaler_table = sun4i_prescaler_table,
 };
 
 static const struct of_device_id sun4i_pwm_dt_ids[] = {
-- 
2.4.11
