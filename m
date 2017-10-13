From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH] pwm: meson: use generic compatibles
Date: Fri, 13 Oct 2017 11:16:42 +0200
Message-ID: <20171013091642.31948-1-jbrunet@baylibre.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:55631 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751650AbdJMJQr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Oct 2017 05:16:47 -0400
Received: by mail-wm0-f53.google.com with SMTP id u138so20065231wmu.4
        for <linux-pwm@vger.kernel.org>; Fri, 13 Oct 2017 02:16:46 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org

The meson pwm driver seems to be compatible with more SoCs than
initially thought. Let's use the most generic compatibles he have in
DT instead of the gxbb specific ones

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/pwm/pwm-meson.txt |  6 +++---
 drivers/pwm/pwm-meson.c                             | 12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-meson.txt b/Documentation/devicetree/bindings/pwm/pwm-meson.txt
index 1ee81321c35e..439e05030553 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-meson.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-meson.txt
@@ -3,8 +3,8 @@ Amlogic Meson PWM Controller
 
 Required properties:
 - compatible: Shall contain "amlogic,meson8b-pwm"
-                         or "amlogic,meson-gxbb-pwm"
-                         or "amlogic,meson-gxbb-ao-pwm"
+                         or "amlogic,meson-gx-pwm"
+                         or "amlogic,meson-gx-ao-pwm"
 - #pwm-cells: Should be 3. See pwm.txt in this directory for a description of
   the cells format.
 
@@ -16,7 +16,7 @@ Optional properties:
 Example:
 
 	pwm_ab: pwm@8550 {
-		compatible = "amlogic,meson-gxbb-pwm";
+		compatible = "amlogic,meson-gx-pwm";
 		reg = <0x0 0x08550 0x0 0x10>;
 		#pwm-cells = <3>;
 		clocks = <&xtal>, <&xtal>;
diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index d589331d1884..ababcc5ca3f1 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -393,7 +393,7 @@ static const char * const pwm_gxbb_parent_names[] = {
 	"xtal", "hdmi_pll", "fclk_div4", "fclk_div3"
 };
 
-static const struct meson_pwm_data pwm_gxbb_data = {
+static const struct meson_pwm_data pwm_gx_data = {
 	.parent_names = pwm_gxbb_parent_names,
 	.num_parents = ARRAY_SIZE(pwm_gxbb_parent_names),
 };
@@ -406,7 +406,7 @@ static const char * const pwm_gxbb_ao_parent_names[] = {
 	"xtal", "clk81"
 };
 
-static const struct meson_pwm_data pwm_gxbb_ao_data = {
+static const struct meson_pwm_data pwm_gx_ao_data = {
 	.parent_names = pwm_gxbb_ao_parent_names,
 	.num_parents = ARRAY_SIZE(pwm_gxbb_ao_parent_names),
 };
@@ -417,12 +417,12 @@ static const struct of_device_id meson_pwm_matches[] = {
 		.data = &pwm_meson8b_data
 	},
 	{
-		.compatible = "amlogic,meson-gxbb-pwm",
-		.data = &pwm_gxbb_data
+		.compatible = "amlogic,meson-gx-pwm",
+		.data = &pwm_gx_data
 	},
 	{
-		.compatible = "amlogic,meson-gxbb-ao-pwm",
-		.data = &pwm_gxbb_ao_data
+		.compatible = "amlogic,meson-gx-ao-pwm",
+		.data = &pwm_gx_ao_data
 	},
 	{},
 };
-- 
2.13.6
