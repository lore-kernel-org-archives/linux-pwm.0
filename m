From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: [RFC PATCH v2 2/6] dt-bindings: pwm: document the PWM no-flag
Date: Sun,  5 Apr 2020 22:22:42 +0300
Message-ID: <20200405192246.3741784-3-oleksandr.suvorov@toradex.com>
References: <20200405192246.3741784-1-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bgr052101131039.outbound.protection.outlook.com ([52.101.131.39]:36883
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727390AbgDETXG (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 5 Apr 2020 15:23:06 -0400
In-Reply-To: <20200405192246.3741784-1-oleksandr.suvorov@toradex.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: Paul Barker <pbarker@konsulko.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Igor Opaniuk <igor.opaniuk@toradex.com>, Philippe Schenker <philippe.schenker@toradex.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Oleksandr Suvorov <oleksandr.suvorov@toradex.com>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org

Add the description of PWM_NOFLAGS flag property.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

Changes in v2:
- add the example of PWM_NOFLAGS usage;
- Use PWM_NOFLAGS instead of PWM_POLARITY_NORMAL to avoid possible
  conflict with enum pwm_polarity in <linux/pwm.h>. Also, this name
  reflects the sense of the original value more precisely.

 Documentation/devicetree/bindings/pwm/pwm.txt | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentation/devicetree/bindings/pwm/pwm.txt
index 084886bd721e..7f0bbda127c4 100644
--- a/Documentation/devicetree/bindings/pwm/pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm.txt
@@ -45,7 +45,8 @@ period in nanoseconds.
 
 Optionally, the pwm-specifier can encode a number of flags (defined in
 <dt-bindings/pwm/pwm.h>) in a third cell:
-- PWM_POLARITY_INVERTED: invert the PWM signal polarity
+- PWM_NOFLAGS: no modification flags.
+- PWM_POLARITY_INVERTED: invert the PWM signal polarity.
 
 Example with optional PWM specifier for inverse polarity
 
@@ -54,6 +55,14 @@ Example with optional PWM specifier for inverse polarity
 		pwm-names = "backlight";
 	};
 
+	vibrator {
+		[...]
+		pwms = <&pwm1 0 10000000 PWM_POLARITY_INVERTED>,
+			   <&pwm2 0 10000000 PWM_NOFLAGS>;
+		pwm-names = "enable", "direction";
+		[...]
+	};
+
 2) PWM controller nodes
 -----------------------
 
-- 
2.24.1
