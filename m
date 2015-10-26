From: Olliver Schinagl <o.schinagl@ultimaker.com>
Subject: [PATCH 04/10] pwm: core: use bitops
Date: Mon, 26 Oct 2015 22:32:35 +0100
Message-ID: <1445895161-2317-5-git-send-email-o.schinagl@ultimaker.com>
References: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Olliver Schinagl <oliver@schinagl.nl>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Joachim Eastwood <manabian@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Olliver Schinagl <oliver+list@schinagl.nl>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

From: Olliver Schinagl <oliver@schinagl.nl>

The pwm header defines bits manually while there is a nice bitops.h with
a BIT() macro. Use the BIT() macro to set bits in pwm.h

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
---
 include/linux/pwm.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index d681f68..29315ad 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -1,6 +1,7 @@
 #ifndef __LINUX_PWM_H
 #define __LINUX_PWM_H
 
+#include <linux/bitops.h>
 #include <linux/err.h>
 #include <linux/of.h>
 
@@ -74,9 +75,9 @@ enum pwm_polarity {
 };
 
 enum {
-	PWMF_REQUESTED = 1 << 0,
-	PWMF_ENABLED = 1 << 1,
-	PWMF_EXPORTED = 1 << 2,
+	PWMF_REQUESTED = BIT(0),
+	PWMF_ENABLED = BIT(1),
+	PWMF_EXPORTED = BIT(2),
 };
 
 /**
-- 
2.6.1
