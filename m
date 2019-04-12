From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/3] pwm: meson: Add clock source configuration for Meson G12A
Date: Fri, 12 Apr 2019 11:23:36 +0200
Message-ID: <20190412092337.6941-3-narmstrong@baylibre.com>
References: <20190412092337.6941-1-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190412092337.6941-1-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com
Cc: baylibre-upstreaming@groups.io, Neil Armstrong <narmstrong@baylibre.com>, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

For PWM controller in the Meson G12A SoC, the EE domain and AO domain
have different clock sources. This patch tries to describe them in the
DT compatible data.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pwm/pwm-meson.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 2b03938039b6..46287cc8a0eb 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -434,6 +434,15 @@ static const struct meson_pwm_data pwm_axg_ao_data = {
 	.num_parents = ARRAY_SIZE(pwm_axg_ao_parent_names),
 };
 
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
@@ -455,6 +464,14 @@ static const struct of_device_id meson_pwm_matches[] = {
 		.compatible = "amlogic,meson-axg-ao-pwm",
 		.data = &pwm_axg_ao_data
 	},
+	{
+		.compatible = "amlogic,meson-g12a-ee-pwm",
+		.data = &pwm_g12a_ee_data
+	},
+	{
+		.compatible = "amlogic,meson-g12a-ao-pwm",
+		.data = &pwm_axg_ao_data
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, meson_pwm_matches);
-- 
2.21.0
