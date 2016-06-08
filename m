From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v2 13/13] regulator: pwm: Document pwm-dutycycle-unit and
 pwm-dutycycle-range
Date: Wed,  8 Jun 2016 18:34:48 +0200
Message-ID: <1465403688-17098-14-git-send-email-boris.brezillon@free-electrons.com>
References: <1465403688-17098-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1465403688-17098-1-git-send-email-boris.brezillon@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Milo Kim <milo.kim@ti.com>, Heiko Stuebner <heiko@sntech.de>, Patrice Chotard <patrice.chotard@st.com>, Laxman Dewangan <ldewangan@nvidia.com>, kernel@stlinux.com, Boris Brezillon <boris.brezillon@free-electrons.com>, Brian Norris <briannorris@chromium.org>, Stephen Barber <smbarber@chromium.org>, linux-rockchip@lists.infradead.org, Caesar Wang <wxt@rock-chips.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Doug Anderson <dianders@google.com>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Maxime Coquelin <maxime.coquelin@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, linux-kernel@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Ajit Pal Singh <ajitpal.singh@st.com>
List-Id: linux-pwm@vger.kernel.org

Document the pwm-dutycycle-unit and pwm-dutycycle-range properties.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Brian Norris <briannorris@chromium.org>
---
 .../devicetree/bindings/regulator/pwm-regulator.txt   | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/pwm-regulator.txt b/Documentation/devicetree/bindings/regulator/pwm-regulator.txt
index ed936f0..9fbc7b1 100644
--- a/Documentation/devicetree/bindings/regulator/pwm-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/pwm-regulator.txt
@@ -34,6 +34,18 @@ Only required for Voltage Table Mode:
 			    First cell is voltage in microvolts (uV)
 			    Second cell is duty-cycle in percent (%)
 
+Optional properties for Continuous mode:
+- pwm-dutycycle-unit:	Integer value encoding the duty cycle unit. If not
+			defined, <100> is assumed, meaning that
+			pwm-dutycycle-range contains values expressed in
+			percent.
+
+- pwm-dutycycle-range:	Should contain 2 entries. The first entry is encoding
+			the dutycycle for regulator-min-microvolt and the
+			second one the dutycycle for regulator-max-microvolt.
+			Duty cycle values are expressed in pwm-dutycycle-unit.
+			If not defined, <0 100> is assumed.
+
 NB: To be clear, if voltage-table is provided, then the device will be used
 in Voltage Table Mode.  If no voltage-table is provided, then the device will
 be used in Continuous Voltage Mode.
@@ -48,6 +60,13 @@ Continuous Voltage Example:
 		regulator-min-microvolt = <1016000>;
 		regulator-max-microvolt = <1114000>;
 		regulator-name = "vdd_logic";
+		/* unit == per-mille */
+		pwm-dutycycle-unit = <1000>;
+		/*
+		 * Inverted PWM logic, and the duty cycle range is limited
+		 * to 30%-70%.
+		 */
+		pwm-dutycycle-range <700 300>; /* */
 	};
 
 Voltage Table Example:
-- 
2.7.4
