From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 7/7] pwm: don't use IS_ENABLED(CONFIG_HAVE_PWM)
Date: Mon, 10 Feb 2014 10:16:53 +0900
Message-ID: <004001cf25fd$c8a11ff0$59e35fd0$%han@samsung.com>
References: <003901cf25fc$73002790$590076b0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:23189 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbaBJBQz (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sun, 9 Feb 2014 20:16:55 -0500
In-reply-to: <003901cf25fc$73002790$590076b0$%han@samsung.com>
Content-language: ko
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: 'Thierry Reding' <thierry.reding@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

The HAVE_PWM symbol is only for legacy platforms that provide
the PWM API without using the generic framework. However, legacy
PWM drivers were already moved to the generic PWM framework.
Thus, HAVE_PWM should be removed, because HAVE_PWM is not
required anymore.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 include/linux/pwm.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index f0feafd..4717f54 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -7,7 +7,7 @@
 struct pwm_device;
 struct seq_file;
 
-#if IS_ENABLED(CONFIG_PWM) || IS_ENABLED(CONFIG_HAVE_PWM)
+#if IS_ENABLED(CONFIG_PWM)
 /*
  * pwm_request - request a PWM device
  */
-- 
1.7.10.4


