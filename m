Return-Path: <tkryger@broadcom.com>
From: "Tim Kryger" <tim.kryger@linaro.org>
Subject: [PATCH 4/5] ARM: dts: Enable the PWM for bcm28155 AP board
Date: Mon, 18 Nov 2013 10:55:00 -0800
Message-ID: <1384800901-21711-5-git-send-email-tim.kryger@linaro.org>
In-Reply-To: <1384800901-21711-1-git-send-email-tim.kryger@linaro.org>
References: <1384800901-21711-1-git-send-email-tim.kryger@linaro.org>
MIME-Version: 1.0
Return-path: tkryger@broadcom.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Christian Daudt <bcm@fixthebug.org>, Grant Likely <grant.likely@linaro.org>
Cc: Tim Kryger <tim.kryger@linaro.org>, Linux PWM List <linux-pwm@vger.kernel.org>, Device Tree List <devicetree@vger.kernel.org>, Linux Doc List <linux-doc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Broadcom Kernel Feedback List <bcm-kernel-feedback-list@broadcom.com>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linaro Patches List <patches@linaro.org>

Mark the PWM as enabled on the bcm28155 AP board.

Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Alex Elder <elder@linaro.org>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
---
 arch/arm/boot/dts/bcm28155-ap.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/bcm28155-ap.dts b/arch/arm/boot/dts/bcm28155-ap.dts
index 08e47c2..2dfca32 100644
--- a/arch/arm/boot/dts/bcm28155-ap.dts
+++ b/arch/arm/boot/dts/bcm28155-ap.dts
@@ -43,4 +43,8 @@
 		cd-gpios = <&gpio 14 0>;
 		status = "okay";
 	};
+
+	pwm: pwm@3e01a000 {
+		status = "okay";
+	};
 };
-- 
1.8.0.1
