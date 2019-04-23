From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 2/3] pwm: meson: Add clock source configuration for Meson G12A
Date: Tue, 23 Apr 2019 15:36:45 +0200
Message-ID: <20190423133646.5705-3-narmstrong@baylibre.com>
References: <20190423133646.5705-1-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423133646.5705-1-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com
Cc: baylibre-upstreaming@groups.io, Neil Armstrong <narmstrong@baylibre.com>, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

For the PWM controller in the Meson G12A SoC, the EE domain and AO domain
have different clock sources. This patch tries to describe them in the
DT compatible data. The two AO PWM controller has different clock source,
but the first AO controller (A & B) can reuse the AXG parents name.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pwm/pwm-meson.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 2b03938039b6..bdf1b367e391 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -434,6 +434,24 @@ static const struct meson_pwm_data pwm_axg_ao_data = {
 	.num_parents = ARRAY_SIZE(pwm_axg_ao_parent_names),
 };
 
+static const char * const pwm_g12a_ao_cd_parent_names[] = {
+	"aoclk81", "xtal",
+};
+
+static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
+	.parent_names = pwm_g12a_ao_cd_parent_names,
+	.num_parents = ARRAY_SIZE(pwm_g12a_ao_cd_parent_names),
+};
+
+static const char * const pwm_g12a_ee_parent_names[] = {
+	"xtal", "hdmi_pll", "fclk_div4", "fclk_div3"
+};
+
+static const struct meson_pwm_data pwm_g12a_ee_data = {
+	.parent_names = pwm_g12a_ee_parent_names,
+	.num_parents = ARRAY_SIZE(pwm_g12a_ee_parent_names),
+};
+
 static const struct of_device_id meson_pwm_matches[] = {
 	{
 		.compatible = "amlogic,meson8b-pwm",
@@ -455,6 +473,18 @@ static const struct of_device_id meson_pwm_matches[] = {
 		.compatible = "amlogic,meson-axg-ao-pwm",
 		.data = &pwm_axg_ao_data
 	},
+	{
+		.compatible = "amlogic,meson-g12a-ee-pwm",
+		.data = &pwm_g12a_ee_data
+	},
+	{
+		.compatible = "amlogic,meson-g12a-ao-pwm-ab",
+		.data = &pwm_axg_ao_data
+	},
+	{
+		.compatible = "amlogic,meson-g12a-ao-pwm-cd",
+		.data = &pwm_g12a_ao_cd_data
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, meson_pwm_matches);
-- 
2.21.0
