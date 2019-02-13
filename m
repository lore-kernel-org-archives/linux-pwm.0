From: Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v2 2/3] dt-bindings: pwm: hibvt: Add hi3559v100 support
Date: Wed, 13 Feb 2019 16:05:07 +0100
Message-ID: <20190213150508.11499-2-m.othacehe@gmail.com>
References: <20190213150508.11499-1-m.othacehe@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213150508.11499-1-m.othacehe@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mathieu Othacehe <m.othacehe@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Add support for hi3559v100-shub-pwm and hisilicon,hi3559v100-pwm
platforms.

Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
---
 Documentation/devicetree/bindings/pwm/pwm-hibvt.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt b/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
index fa7849d67836..daedfef09bb6 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
@@ -5,6 +5,8 @@ Required properties:
  The SoC specific strings supported including:
 	"hisilicon,hi3516cv300-pwm"
 	"hisilicon,hi3519v100-pwm"
+	"hisilicon,hi3559v100-shub-pwm"
+	"hisilicon,hi3559v100-pwm
 - reg: physical base address and length of the controller's registers.
 - clocks: phandle and clock specifier of the PWM reference clock.
 - resets: phandle and reset specifier for the PWM controller reset.
-- 
2.17.1
