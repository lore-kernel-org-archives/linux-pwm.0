From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 02/16] pwm: pxa: update documentation regarding pwm-cells
Date: Fri, 12 Jan 2018 16:22:49 +0200
Message-ID: <1515766983-15151-3-git-send-email-claudiu.beznea@microchip.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, corbet@lwn.net, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com
Cc: linux-pwm@vger.kernel.org, Mike Dunn <mikedunn@newsguy.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, Claudiu Beznea <claudiu.beznea@microchip.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

pwm-cells should be at least 2 to provide channel number and period value.

Cc: Mike Dunn <mikedunn@newsguy.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/pwm/pxa-pwm.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pxa-pwm.txt b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
index 5ae9f1e3c338..a0e20edeeebc 100644
--- a/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
@@ -10,7 +10,7 @@ Required properties:
   Note that one device instance must be created for each PWM that is used, so the
   length covers only the register window for one PWM output, not that of the
   entire PWM controller.  Currently length is 0x10 for all supported devices.
-- #pwm-cells: Should be 1.  This cell is used to specify the period in
+- #pwm-cells: Should be 2.  This cell is used to specify the period in
   nanoseconds.
 
 Example PWM device node:
@@ -18,13 +18,13 @@ Example PWM device node:
 pwm0: pwm@40b00000 {
 	compatible = "marvell,pxa250-pwm";
 	reg = <0x40b00000 0x10>;
-	#pwm-cells = <1>;
+	#pwm-cells = <2>;
 };
 
 Example PWM client node:
 
 backlight {
 	compatible = "pwm-backlight";
-	pwms = <&pwm0 5000000>;
+	pwms = <&pwm0 0 5000000>;
 	...
 }
-- 
2.7.4
