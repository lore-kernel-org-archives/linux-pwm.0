From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: [RFC PATCH 2/7] dt-bindings: pwm: document the PWM polarity flag
Date: Tue, 17 Mar 2020 14:32:26 +0200
Message-ID: <20200317123231.2843297-3-oleksandr.suvorov@toradex.com>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
Cc: Paul Barker <pbarker@konsulko.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Igor Opaniuk <igor.opaniuk@toradex.com>, Philippe Schenker <philippe.schenker@toradex.com>, Oleksandr Suvorov <oleksandr.suvorov@toradex.com>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Add the description of PWM_POLARITY_NORMAL flag.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

 Documentation/devicetree/bindings/pwm/pwm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentation/devicetree/bindings/pwm/pwm.txt
index 084886bd721e..440c6b9a6a4e 100644
--- a/Documentation/devicetree/bindings/pwm/pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm.txt
@@ -46,6 +46,7 @@ period in nanoseconds.
 Optionally, the pwm-specifier can encode a number of flags (defined in
 <dt-bindings/pwm/pwm.h>) in a third cell:
 - PWM_POLARITY_INVERTED: invert the PWM signal polarity
+- PWM_POLARITY_NORMAL: don't invert the PWM signal polarity
 
 Example with optional PWM specifier for inverse polarity
 
-- 
2.24.1
