From: lis8215@gmail.com
Subject: [PATCH v4 3/9] pwm: sunxi: Selectable prescaler table.
Date: Fri, 24 Feb 2017 08:41:10 +0300
Message-ID: <1487914876-8594-4-git-send-email-lis8215@gmail.com>
References: <1487914876-8594-1-git-send-email-lis8215@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36594 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751080AbdBXFlY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Feb 2017 00:41:24 -0500
Received: by mail-lf0-f68.google.com with SMTP id p197so742770lfp.3
        for <linux-pwm@vger.kernel.org>; Thu, 23 Feb 2017 21:41:23 -0800 (PST)
In-Reply-To: <1487914876-8594-1-git-send-email-lis8215@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-sunxi@googlegroups.com
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, maxime.ripard@free-electrons.com, wens@csie.org, linux-pwm@vger.kernel.org, Siarhei Volkau <lis8215@gmail.com>

From: Siarhei Volkau <lis8215@gmail.com>

A31 SoC have a different set of prescalers than sun4i
compatible ASoCs, but its position and count in the control
register are the same.

This patch make the table of prescalers customizable.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 drivers/pwm/pwm-sun4i.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 7af6bd8..418a625 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -60,7 +60,7 @@ enum {
 	NUM_FIELDS,
 };
 
-static const u32 prescaler_table[] = {
+static const u32 sun4i_prescaler_table[] = {
 	120,
 	180,
 	240,
@@ -83,6 +83,7 @@ struct sun4i_pwm_data {
 	bool has_prescaler_bypass;
 	bool has_rdy;
 	unsigned int npwm;
+	const u32 *prescaler_table;
 };
 
 struct sun4i_pwm_chip {
@@ -104,6 +105,7 @@ static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
 	struct regmap_field **chan_fields = sun4i_pwm->fields[pwm->hwpwm];
+	const u32 *prescaler_table = sun4i_pwm->data->prescaler_table;
 	u32 prd, dty, val, clk_gate;
 	u64 clk_rate, div = 0;
 	unsigned int prescaler = 0;
@@ -310,30 +312,35 @@ static const struct sun4i_pwm_data sun4i_pwm_data_a10 = {
 	.has_prescaler_bypass = false,
 	.has_rdy = false,
 	.npwm = 2,
+	.prescaler_table = sun4i_prescaler_table,
 };
 
 static const struct sun4i_pwm_data sun4i_pwm_data_a10s = {
 	.has_prescaler_bypass = true,
 	.has_rdy = true,
 	.npwm = 2,
+	.prescaler_table = sun4i_prescaler_table,
 };
 
 static const struct sun4i_pwm_data sun4i_pwm_data_a13 = {
 	.has_prescaler_bypass = true,
 	.has_rdy = true,
 	.npwm = 1,
+	.prescaler_table = sun4i_prescaler_table,
 };
 
 static const struct sun4i_pwm_data sun4i_pwm_data_a20 = {
 	.has_prescaler_bypass = true,
 	.has_rdy = true,
 	.npwm = 2,
+	.prescaler_table = sun4i_prescaler_table,
 };
 
 static const struct sun4i_pwm_data sun4i_pwm_data_h3 = {
 	.has_prescaler_bypass = true,
 	.has_rdy = true,
 	.npwm = 1,
+	.prescaler_table = sun4i_prescaler_table,
 };
 
 static const struct of_device_id sun4i_pwm_dt_ids[] = {
-- 
2.4.11
