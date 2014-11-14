From: Scott Branden <sbranden@broadcom.com>
Subject: [PATCH 4/4] pwm: kona: Update dependency to ARCH_BCM
Date: Fri, 14 Nov 2014 10:30:00 -0800
Message-ID: <1415989800-7515-5-git-send-email-sbranden@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com>
 <1415989800-7515-1-git-send-email-sbranden@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415989800-7515-1-git-send-email-sbranden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Scott Branden <sbranden@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>, Arun Ramamurthy <arunrama@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

From: Arun Ramamurthy <arunrama@broadcom.com>

Signed-off-by: Arun Ramamurthy <arunrama@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Signed-off-by: Scott Branden <sbranden@broadcom.com>
---
 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index ef2dd2e..186080e 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -64,7 +64,7 @@ config PWM_ATMEL_TCB
 
 config PWM_BCM_KONA
 	tristate "Kona PWM support"
-	depends on ARCH_BCM_MOBILE
+	depends on ARCH_BCM
 	help
 	  Generic PWM framework driver for Broadcom Kona PWM block.
 
-- 
2.1.3
