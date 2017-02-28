From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/2] drivers: pwm: pwm-atmel: enable pwm on sama5d2
Date: Tue, 28 Feb 2017 12:40:15 +0200
Message-ID: <1488278415-2786-3-git-send-email-claudiu.beznea@microchip.com>
References: <1488278415-2786-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from smtpout.microchip.com ([198.175.253.82]:42883 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751763AbdB1KpE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Feb 2017 05:45:04 -0500
In-Reply-To: <1488278415-2786-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, boris.brezillon@free-electrons.com, alexandre.belloni@free-electrons.com
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Claudiu Beznea <claudiu.beznea@microchip.com>

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
index 014b86c..209e877 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -346,6 +346,9 @@ static const struct of_device_id atmel_pwm_dt_ids[] = {
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
