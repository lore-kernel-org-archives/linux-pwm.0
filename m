From: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC PATCH 4/7] dt-bindings: pwm: add description of PWM polarity
Date: Tue, 17 Mar 2020 14:32:28 +0200
Message-ID: <20200317123231.2843297-5-oleksandr.suvorov@toradex.com>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200317123231.2843297-1-oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Paul Barker <pbarker-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Marcel Ziswiler <marcel.ziswiler-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Igor Opaniuk <igor.opaniuk-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Philippe Schenker <philippe.schenker-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Move the description of the PWM signal polarity from
<linux/pwm.h>, prepare for removing the polarity
definition from <linux/pwm.h>.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
---

 include/dt-bindings/pwm/pwm.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/dt-bindings/pwm/pwm.h b/include/dt-bindings/pwm/pwm.h
index 6b58caa6385e..c07da2088a61 100644
--- a/include/dt-bindings/pwm/pwm.h
+++ b/include/dt-bindings/pwm/pwm.h
@@ -10,7 +10,16 @@
 #ifndef _DT_BINDINGS_PWM_PWM_H
 #define _DT_BINDINGS_PWM_PWM_H
 
+/**
+ * a high signal for the duration of the duty-cycle, followed by a low signal
+ * for the remainder of the pulse period.
+ */
 #define PWM_POLARITY_NORMAL			0
+
+/**
+ * a low signal for the duration of the duty-cycle, followed by a high signal
+ * for the remainder of the pulse period.
+ */
 #define PWM_POLARITY_INVERTED			(1 << 0)
 
 #endif
-- 
2.24.1
