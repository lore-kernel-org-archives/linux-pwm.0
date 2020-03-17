From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: [RFC PATCH 3/7] dt-bindings: pwm: add normal PWM polarity flag
Date: Tue, 17 Mar 2020 14:32:27 +0200
Message-ID: <20200317123231.2843297-4-oleksandr.suvorov@toradex.com>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
Cc: Paul Barker <pbarker@konsulko.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Igor Opaniuk <igor.opaniuk@toradex.com>, Philippe Schenker <philippe.schenker@toradex.com>, Oleksandr Suvorov <oleksandr.suvorov@toradex.com>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

PWM can have a normal polarity and a reverted one. The reverted polarity
value is defined.
Define the PWM_POLARITY_NORMAL to be used further.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

 include/dt-bindings/pwm/pwm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/pwm/pwm.h b/include/dt-bindings/pwm/pwm.h
index ab9a077e3c7d..6b58caa6385e 100644
--- a/include/dt-bindings/pwm/pwm.h
+++ b/include/dt-bindings/pwm/pwm.h
@@ -10,6 +10,7 @@
 #ifndef _DT_BINDINGS_PWM_PWM_H
 #define _DT_BINDINGS_PWM_PWM_H
 
+#define PWM_POLARITY_NORMAL			0
 #define PWM_POLARITY_INVERTED			(1 << 0)
 
 #endif
-- 
2.24.1
