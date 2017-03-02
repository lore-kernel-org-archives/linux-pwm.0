From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 2/2] drivers: pwm: pwm-atmel: enable PWM on sama5d2
Date: Thu, 2 Mar 2017 17:28:45 +0200
Message-ID: <1488468525-28726-3-git-send-email-claudiu.beznea@microchip.com>
References: <1488468525-28726-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1488468525-28726-1-git-send-email-claudiu.beznea@microchip.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, boris.brezillon@free-electrons.com, alexandre.belloni@free-electrons.com
Cc: linux-pwm@vger.kernel.org, Claudiu Beznea <claudiu.beznea@microchip.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

sama5d2 can use the same atmel_pwm_data as sama5d3.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

---
 Documentation/devicetree/bindings/pwm/atmel-pwm.txt | 1 +
 drivers/pwm/pwm-atmel.c                             | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/atmel-pwm.txt b/Documentation/devicetree/bindings/pwm/atmel-pwm.txt
index 02331b9..c8c831d 100644
--- a/Documentation/devicetree/bindings/pwm/atmel-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/atmel-pwm.txt
@@ -4,6 +4,7 @@ Required properties:
   - compatible: should be one of:
     - "atmel,at91sam9rl-pwm"
     - "atmel,sama5d3-pwm"
+    - "atmel,sama5d2-pwm"
   - reg: physical base address and length of the controller's registers
   - #pwm-cells: Should be 3. See pwm.txt in this directory for a
     description of the cells format.
diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 3db82c3..e773311 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -332,6 +332,9 @@ static const struct of_device_id atmel_pwm_dt_ids[] = {
 		.compatible = "atmel,sama5d3-pwm",
 		.data = &atmel_pwm_data_v2,
 	}, {
+		.compatible = "atmel,sama5d2-pwm",
+		.data = &atmel_pwm_data_v2,
+	}, {
 		/* sentinel */
 	},
 };
-- 
2.7.4
