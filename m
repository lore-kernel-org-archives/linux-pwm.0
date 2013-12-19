From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 1/3] pwm: core: use seq_puts() instead of seq_printf()
Date: Thu, 19 Dec 2013 13:31:24 +0900
Message-ID: <002101cefc73$2d22ff70$8768fe50$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:55207 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929Ab3LSEbc (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Dec 2013 23:31:32 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MY100KWYDWDO230@mailout1.samsung.com> for
 linux-pwm@vger.kernel.org; Thu, 19 Dec 2013 13:31:25 +0900 (KST)
Content-language: ko
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: 'Thierry Reding' <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

For a constant format without additional arguments, use seq_puts()
instead of seq_printf(). Also, the following checkpatch warning is
fixed.

  WARNING: Prefer seq_puts to seq_printf

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pwm/core.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 2ca9504..a804713 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -808,12 +808,12 @@ static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
 		seq_printf(s, " pwm-%-3d (%-20.20s):", i, pwm->label);
 
 		if (test_bit(PWMF_REQUESTED, &pwm->flags))
-			seq_printf(s, " requested");
+			seq_puts(s, " requested");
 
 		if (test_bit(PWMF_ENABLED, &pwm->flags))
-			seq_printf(s, " enabled");
+			seq_puts(s, " enabled");
 
-		seq_printf(s, "\n");
+		seq_puts(s, "\n");
 	}
 }
 
-- 
1.7.10.4


