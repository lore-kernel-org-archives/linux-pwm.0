From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 2/3] pwm: meson: add compatible for the gxbb ao pwms
Date: Thu,  8 Jun 2017 14:24:15 +0200
Message-ID: <20170608122416.1993-3-jbrunet@baylibre.com>
References: <20170608122416.1993-1-jbrunet@baylibre.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36121 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbdFHMYX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Jun 2017 08:24:23 -0400
Received: by mail-wm0-f47.google.com with SMTP id 7so136780461wmo.1
        for <linux-pwm@vger.kernel.org>; Thu, 08 Jun 2017 05:24:23 -0700 (PDT)
In-Reply-To: <20170608122416.1993-1-jbrunet@baylibre.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <carlo@caione.org>, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org

On the gxbb (and gxl) family, the PWMs of the AO domain require a
specific compatible because the possible input clocks are different
from the EE PWMs input clocks.

Since the number of possible input clocks is also different, the
'num_parents' field is added to all the meson pwm data.

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pwm/pwm-meson.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 045ef9fa6fe3..b911a944744a 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -103,6 +103,7 @@ struct meson_pwm_channel {
 
 struct meson_pwm_data {
 	const char * const *parent_names;
+	int num_parents;
 };
 
 struct meson_pwm {
@@ -381,6 +382,7 @@ static const char * const pwm_meson8b_parent_names[] = {
 
 static const struct meson_pwm_data pwm_meson8b_data = {
 	.parent_names = pwm_meson8b_parent_names,
+	.num_parents = ARRAY_SIZE(pwm_meson8b_parent_names),
 };
 
 static const char * const pwm_gxbb_parent_names[] = {
@@ -389,11 +391,35 @@ static const char * const pwm_gxbb_parent_names[] = {
 
 static const struct meson_pwm_data pwm_gxbb_data = {
 	.parent_names = pwm_gxbb_parent_names,
+	.num_parents = ARRAY_SIZE(pwm_gxbb_parent_names),
+};
+
+/*
+ * Only the 2 first inputs of the GXBB AO PWMs are valid
+ * The last 2 are grounded
+ */
+static const char * const pwm_gxbb_ao_parent_names[] = {
+	"xtal", "clk81"
+};
+
+static const struct meson_pwm_data pwm_gxbb_ao_data = {
+	.parent_names = pwm_gxbb_ao_parent_names,
+	.num_parents = ARRAY_SIZE(pwm_gxbb_ao_parent_names),
 };
 
 static const struct of_device_id meson_pwm_matches[] = {
-	{ .compatible = "amlogic,meson8b-pwm", .data = &pwm_meson8b_data },
-	{ .compatible = "amlogic,meson-gxbb-pwm", .data = &pwm_gxbb_data },
+	{
+		.compatible = "amlogic,meson8b-pwm",
+		.data = &pwm_meson8b_data
+	},
+	{
+		.compatible = "amlogic,meson-gxbb-pwm",
+		.data = &pwm_gxbb_data
+	},
+	{
+		.compatible = "amlogic,meson-gxbb-ao-pwm",
+		.data = &pwm_gxbb_ao_data
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, meson_pwm_matches);
@@ -417,7 +443,7 @@ static int meson_pwm_init_channels(struct meson_pwm *meson,
 		init.ops = &clk_mux_ops;
 		init.flags = CLK_IS_BASIC;
 		init.parent_names = meson->data->parent_names;
-		init.num_parents = 1 << MISC_CLK_SEL_WIDTH;
+		init.num_parents = meson->data->num_parents;
 
 		channel->mux.reg = meson->base + REG_MISC_AB;
 		channel->mux.shift = mux_reg_shifts[i];
-- 
2.9.4
