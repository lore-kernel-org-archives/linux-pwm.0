From: Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 2/4] mfd: cros_ec: add EC_PWM function definitions
Date: Thu,  2 Jun 2016 18:21:42 -0700
Message-ID: <1464916904-37554-3-git-send-email-briannorris@chromium.org>
References: <1464916904-37554-1-git-send-email-briannorris@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464916904-37554-1-git-send-email-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>
Cc: linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Stephen Barber <smbarber@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Randall Spangler <rspangler@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Brian Norris <briannorris@chromium.org>
List-Id: linux-pwm@vger.kernel.org

The EC_CMD_PWM_{GET,SET}_DUTY commands allow us to control a PWM that is
attached to the EC, rather than the main host SoC. The API provides
functionality-based (e.g., keyboard light, backlight) or index-based
addressing of the PWM(s). Duty cycles are represented by a 16-bit value,
where 0 maps to 0% duty cycle and U16_MAX maps to 100%. The period
cannot be controlled.

This command set is more generic than, e.g.,
EC_CMD_PWM_{GET,SET}_KEYBOARD_BACKLIGHT and could possibly used to
replace it on future products.

Let's update the command header to include the definitions.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
v2: no change

 include/linux/mfd/cros_ec_commands.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 13b630c10d4c..d673575e0ada 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -949,6 +949,37 @@ struct ec_params_pwm_set_fan_duty {
 	uint32_t percent;
 } __packed;
 
+#define EC_CMD_PWM_SET_DUTY 0x25
+/* 16 bit duty cycle, 65535 = 100% */
+#define EC_PWM_MAX_DUTY 65535
+
+enum ec_pwm_type {
+	/* All types, indexed by board-specific enum pwm_channel */
+	EC_PWM_TYPE_GENERIC = 0,
+	/* Keyboard backlight */
+	EC_PWM_TYPE_KB_LIGHT,
+	/* Display backlight */
+	EC_PWM_TYPE_DISPLAY_LIGHT,
+	EC_PWM_TYPE_COUNT,
+};
+
+struct ec_params_pwm_set_duty {
+	uint16_t duty;     /* Duty cycle, EC_PWM_MAX_DUTY = 100% */
+	uint8_t pwm_type;  /* ec_pwm_type */
+	uint8_t index;     /* Type-specific index, or 0 if unique */
+} __packed;
+
+#define EC_CMD_PWM_GET_DUTY 0x26
+
+struct ec_params_pwm_get_duty {
+	uint8_t pwm_type;  /* ec_pwm_type */
+	uint8_t index;     /* Type-specific index, or 0 if unique */
+} __packed;
+
+struct ec_response_pwm_get_duty {
+	uint16_t duty;     /* Duty cycle, EC_PWM_MAX_DUTY = 100% */
+} __packed;
+
 /*****************************************************************************/
 /*
  * Lightbar commands. This looks worse than it is. Since we only use one HOST
-- 
2.8.0.rc3.226.g39d4020
