From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] pwm: meson: fix the G12A AO clock parents order
Date: Thu, 20 Jun 2019 16:46:55 +0200
Message-ID: <20190620144655.2142-1-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com
Cc: Neil Armstrong <narmstrong@baylibre.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, martin.blumenstingl@googlemail.com
List-Id: linux-pwm@vger.kernel.org

The Amlogic G12A and G12B Documentation is wrong, the AO xtal and clk81
clock source order is reversed, and validated when adding DVFS support by
using the PWM AO D output to control the CPU supply voltage.

The vendor tree also uses the reversed xtal and clk81 order at [1].

[1] https://github.com/hardkernel/linux/blob/odroidn2-4.9.y/drivers/amlogic/pwm/pwm_meson.c#L462

Fixes: f41efceb46e6 ("pwm: meson: Add clock source configuration for Meson G12A")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pwm/pwm-meson.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 5e65b042c240..e15d045947bb 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -453,8 +453,17 @@ static const struct meson_pwm_data pwm_axg_ao_data = {
 	.num_parents = ARRAY_SIZE(pwm_axg_ao_parent_names),
 };
 
+static const char * const pwm_g12a_ao_ab_parent_names[] = {
+	"xtal", "aoclk81", "fclk_div4", "fclk_div5"
+};
+
+static const struct meson_pwm_data pwm_g12a_ao_ab_data = {
+	.parent_names = pwm_g12a_ao_ab_parent_names,
+	.num_parents = ARRAY_SIZE(pwm_g12a_ao_ab_parent_names),
+};
+
 static const char * const pwm_g12a_ao_cd_parent_names[] = {
-	"aoclk81", "xtal",
+	"xtal", "aoclk81",
 };
 
 static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
@@ -498,7 +507,7 @@ static const struct of_device_id meson_pwm_matches[] = {
 	},
 	{
 		.compatible = "amlogic,meson-g12a-ao-pwm-ab",
-		.data = &pwm_axg_ao_data
+		.data = &pwm_g12a_ao_ab_data
 	},
 	{
 		.compatible = "amlogic,meson-g12a-ao-pwm-cd",
-- 
2.21.0
