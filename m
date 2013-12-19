From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 3/3] pwm: pxa: remove unnecessary space before tabs
Date: Thu, 19 Dec 2013 13:34:05 +0900
Message-ID: <002301cefc73$8cc4a820$a64df860$%han@samsung.com>
References: <002101cefc73$2d22ff70$8768fe50$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:17456 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815Ab3LSEeM (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Dec 2013 23:34:12 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MY100HQHE0U7B20@mailout3.samsung.com> for
 linux-pwm@vger.kernel.org; Thu, 19 Dec 2013 13:34:06 +0900 (KST)
In-reply-to: <002101cefc73$2d22ff70$8768fe50$%han@samsung.com>
Content-language: ko
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: 'Thierry Reding' <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Eric Miao' <eric.y.miao@gmail.com>

Remove unnecessary space before tabs in order to fix the following
checkpatch warning.

  WARNING: please, no space before tabs

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pwm/pwm-pxa.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 3dc7c10..8d99573 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -8,7 +8,7 @@
  * published by the Free Software Foundation.
  *
  * 2008-02-13	initial version
- * 		eric miao <eric.miao@marvell.com>
+ *		eric miao <eric.miao@marvell.com>
  */
 
 #include <linux/module.h>
-- 
1.7.10.4


