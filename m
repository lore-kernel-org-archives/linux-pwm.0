From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH v2 1/3] pwm: ftm: fix one bug of wrong counting the use counter.
Date: Wed, 15 Oct 2014 13:21:33 +0800
Message-ID: <1413350495-40980-2-git-send-email-Li.Xiubo@freescale.com>
References: <1413350495-40980-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-by2on0107.outbound.protection.outlook.com ([207.46.100.107]:60269
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751073AbaJOFW0 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Wed, 15 Oct 2014 01:22:26 -0400
In-Reply-To: <1413350495-40980-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>

No matter what times the FTM pwm is enabled, the use_count will
always be one.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 drivers/pwm/pwm-fsl-ftm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 0f2cc7e..1150598 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -299,7 +299,7 @@ static int fsl_counter_clock_enable(struct fsl_pwm_chip *fpc)
 {
 	int ret;
 
-	if (fpc->use_count != 0)
+	if (fpc->use_count++ != 0)
 		return 0;
 
 	/* select counter clock source */
@@ -316,8 +316,6 @@ static int fsl_counter_clock_enable(struct fsl_pwm_chip *fpc)
 		return ret;
 	}
 
-	fpc->use_count++;
-
 	return 0;
 }
 
-- 
2.1.0.27.g96db324

