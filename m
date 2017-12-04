From: Yixun Lan <yixun.lan@amlogic.com>
Subject: [PATCH 2/3] pwm: meson: add clock source configuratin for Meson-AXG
Date: Mon, 4 Dec 2017 14:00:17 +0800
Message-ID: <20171204060018.8856-3-yixun.lan@amlogic.com>
References: <20171204060018.8856-1-yixun.lan@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171204060018.8856-1-yixun.lan@amlogic.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@baylibre.com>, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Mark Rutland <mark.rutland@arm.com>, Carlo Caione <carlo@caione.org>, Jian Hu <jian.hu@amlogic.com>, Yixun Lan <yixun.lan@amlogic.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

From: Jian Hu <jian.hu@amlogic.com>

For PWM controller in the Meson-AXG SoC, the EE domain and
AO domain have different clock source. This patch try to describe
them in the DT compatible data.

Signed-off-by: Jian Hu <jian.hu@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/pwm/pwm-meson.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 1f44b288af57..dcacc5c6ac1e 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -421,6 +421,24 @@ static const struct meson_pwm_data pwm_gxbb_ao_data = {
 	.num_parents = ARRAY_SIZE(pwm_gxbb_ao_parent_names),
 };
 
+static const char * const pwm_axg_ee_parent_names[] = {
+	"xtal", "fclk_div5", "fclk_div4", "fclk_div3"
+};
+
+static const struct meson_pwm_data pwm_axg_ee_data = {
+	.parent_names = pwm_axg_ee_parent_names,
+	.num_parents = ARRAY_SIZE(pwm_axg_ee_parent_names),
+};
+
+static const char * const pwm_axg_ao_parent_names[] = {
+	"aoclk81", "xtal", "fclk_div4", "fclk_div5"
+};
+
+static const struct meson_pwm_data pwm_axg_ao_data = {
+	.parent_names = pwm_axg_ao_parent_names,
+	.num_parents = ARRAY_SIZE(pwm_axg_ao_parent_names),
+};
+
 static const struct of_device_id meson_pwm_matches[] = {
 	{
 		.compatible = "amlogic,meson8b-pwm",
@@ -434,6 +452,14 @@ static const struct of_device_id meson_pwm_matches[] = {
 		.compatible = "amlogic,meson-gxbb-ao-pwm",
 		.data = &pwm_gxbb_ao_data
 	},
+	{
+		.compatible = "amlogic,meson-axg-ee-pwm",
+		.data = &pwm_axg_ee_data
+	},
+	{
+		.compatible = "amlogic,meson-axg-ao-pwm",
+		.data = &pwm_axg_ao_data
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, meson_pwm_matches);
-- 
2.15.0
