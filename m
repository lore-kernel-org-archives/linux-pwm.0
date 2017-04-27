From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH v2 1/8] pinctrl: sh-pfc: r8a7796: Add PWM pins, groups and functions
Date: Thu, 27 Apr 2017 16:37:36 +0200
Message-ID: <1493303863-23719-2-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1493303863-23719-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1493303863-23719-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: geert@glider.be, horms@verge.net.au
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com, Takeshi Kihara <takeshi.kihara.df@renesas.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-pwm@vger.kernel.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch adds PWM{0,1,2,3,4,5,6} pins, groups and functions to
R8A7796 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c | 153 +++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
index b0362ae..668c688 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
@@ -2955,6 +2955,105 @@ static const unsigned int msiof3_rxd_e_mux[] = {
 	MSIOF3_RXD_E_MARK,
 };
 
+/* - PWM0 --------------------------------------------------------------------*/
+static const unsigned int pwm0_pins[] = {
+	/* PWM */
+	RCAR_GP_PIN(2, 6),
+};
+static const unsigned int pwm0_mux[] = {
+	PWM0_MARK,
+};
+/* - PWM1 --------------------------------------------------------------------*/
+static const unsigned int pwm1_a_pins[] = {
+	/* PWM */
+	RCAR_GP_PIN(2, 7),
+};
+static const unsigned int pwm1_a_mux[] = {
+	PWM1_A_MARK,
+};
+static const unsigned int pwm1_b_pins[] = {
+	/* PWM */
+	RCAR_GP_PIN(1, 8),
+};
+static const unsigned int pwm1_b_mux[] = {
+	PWM1_B_MARK,
+};
+/* - PWM2 --------------------------------------------------------------------*/
+static const unsigned int pwm2_a_pins[] = {
+	/* PWM */
+	RCAR_GP_PIN(2, 8),
+};
+static const unsigned int pwm2_a_mux[] = {
+	PWM2_A_MARK,
+};
+static const unsigned int pwm2_b_pins[] = {
+	/* PWM */
+	RCAR_GP_PIN(1, 11),
+};
+static const unsigned int pwm2_b_mux[] = {
+	PWM2_B_MARK,
+};
+/* - PWM3 --------------------------------------------------------------------*/
+static const unsigned int pwm3_a_pins[] = {
+	/* PWM */
+	RCAR_GP_PIN(1, 0),
+};
+static const unsigned int pwm3_a_mux[] = {
+	PWM3_A_MARK,
+};
+static const unsigned int pwm3_b_pins[] = {
+	/* PWM */
+	RCAR_GP_PIN(2, 2),
+};
+static const unsigned int pwm3_b_mux[] = {
+	PWM3_B_MARK,
+};
+/* - PWM4 --------------------------------------------------------------------*/
+static const unsigned int pwm4_a_pins[] = {
+	/* PWM */
+	RCAR_GP_PIN(1, 1),
+};
+static const unsigned int pwm4_a_mux[] = {
+	PWM4_A_MARK,
+};
+static const unsigned int pwm4_b_pins[] = {
+	/* PWM */
+	RCAR_GP_PIN(2, 3),
+};
+static const unsigned int pwm4_b_mux[] = {
+	PWM4_B_MARK,
+};
+/* - PWM5 --------------------------------------------------------------------*/
+static const unsigned int pwm5_a_pins[] = {
+	/* PWM */
+	RCAR_GP_PIN(1, 2),
+};
+static const unsigned int pwm5_a_mux[] = {
+	PWM5_A_MARK,
+};
+static const unsigned int pwm5_b_pins[] = {
+	/* PWM */
+	RCAR_GP_PIN(2, 4),
+};
+static const unsigned int pwm5_b_mux[] = {
+	PWM5_B_MARK,
+};
+/* - PWM6 --------------------------------------------------------------------*/
+static const unsigned int pwm6_a_pins[] = {
+	/* PWM */
+	RCAR_GP_PIN(1, 3),
+};
+static const unsigned int pwm6_a_mux[] = {
+	PWM6_A_MARK,
+};
+static const unsigned int pwm6_b_pins[] = {
+	/* PWM */
+	RCAR_GP_PIN(2, 5),
+};
+static const unsigned int pwm6_b_mux[] = {
+	PWM6_B_MARK,
+};
+
 /* - SCIF0 ------------------------------------------------------------------ */
 static const unsigned int scif0_data_pins[] = {
 	/* RX, TX */
@@ -3565,6 +3664,19 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(msiof3_ss2_e),
 	SH_PFC_PIN_GROUP(msiof3_txd_e),
 	SH_PFC_PIN_GROUP(msiof3_rxd_e),
+	SH_PFC_PIN_GROUP(pwm0),
+	SH_PFC_PIN_GROUP(pwm1_a),
+	SH_PFC_PIN_GROUP(pwm1_b),
+	SH_PFC_PIN_GROUP(pwm2_a),
+	SH_PFC_PIN_GROUP(pwm2_b),
+	SH_PFC_PIN_GROUP(pwm3_a),
+	SH_PFC_PIN_GROUP(pwm3_b),
+	SH_PFC_PIN_GROUP(pwm4_a),
+	SH_PFC_PIN_GROUP(pwm4_b),
+	SH_PFC_PIN_GROUP(pwm5_a),
+	SH_PFC_PIN_GROUP(pwm5_b),
+	SH_PFC_PIN_GROUP(pwm6_a),
+	SH_PFC_PIN_GROUP(pwm6_b),
 	SH_PFC_PIN_GROUP(scif0_data),
 	SH_PFC_PIN_GROUP(scif0_clk),
 	SH_PFC_PIN_GROUP(scif0_ctrl),
@@ -3879,6 +3991,40 @@ static const char * const msiof3_groups[] = {
 	"msiof3_rxd_e",
 };
 
+static const char * const pwm0_groups[] = {
+	"pwm0",
+};
+
+static const char * const pwm1_groups[] = {
+	"pwm1_a",
+	"pwm1_b",
+};
+
+static const char * const pwm2_groups[] = {
+	"pwm2_a",
+	"pwm2_b",
+};
+
+static const char * const pwm3_groups[] = {
+	"pwm3_a",
+	"pwm3_b",
+};
+
+static const char * const pwm4_groups[] = {
+	"pwm4_a",
+	"pwm4_b",
+};
+
+static const char * const pwm5_groups[] = {
+	"pwm5_a",
+	"pwm5_b",
+};
+
+static const char * const pwm6_groups[] = {
+	"pwm6_a",
+	"pwm6_b",
+};
+
 static const char * const scif0_groups[] = {
 	"scif0_data",
 	"scif0_clk",
@@ -3991,6 +4137,13 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(msiof1),
 	SH_PFC_FUNCTION(msiof2),
 	SH_PFC_FUNCTION(msiof3),
+	SH_PFC_FUNCTION(pwm0),
+	SH_PFC_FUNCTION(pwm1),
+	SH_PFC_FUNCTION(pwm2),
+	SH_PFC_FUNCTION(pwm3),
+	SH_PFC_FUNCTION(pwm4),
+	SH_PFC_FUNCTION(pwm5),
+	SH_PFC_FUNCTION(pwm6),
 	SH_PFC_FUNCTION(scif0),
 	SH_PFC_FUNCTION(scif1),
 	SH_PFC_FUNCTION(scif2),
-- 
2.7.4
