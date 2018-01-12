From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 10/16] pwm: Add PWM modes
Date: Fri, 12 Jan 2018 16:22:57 +0200
Message-ID: <1515766983-15151-11-git-send-email-claudiu.beznea@microchip.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, corbet@lwn.net, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, Claudiu Beznea <claudiu.beznea@microchip.com>
List-Id: linux-pwm@vger.kernel.org

Define a macros for PWM modes to be used by device tree sources.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 include/dt-bindings/pwm/pwm.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/pwm/pwm.h b/include/dt-bindings/pwm/pwm.h
index ab9a077e3c7d..b8617431f8ec 100644
--- a/include/dt-bindings/pwm/pwm.h
+++ b/include/dt-bindings/pwm/pwm.h
@@ -12,4 +12,7 @@
 
 #define PWM_POLARITY_INVERTED			(1 << 0)
 
+#define PWM_DTMODE_NORMAL			(1 << 0)
+#define PWM_DTMODE_COMPLEMENTARY		(1 << 1)
+
 #endif
-- 
2.7.4
