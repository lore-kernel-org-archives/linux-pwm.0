From: Olliver Schinagl <oliver@schinagl.nl>
Subject: [PATCH 1/1] pwm: core: use bitops's BIT macro
Date: Fri, 26 Aug 2016 09:40:50 +0200
Message-ID: <1472197250-5791-1-git-send-email-oliver@schinagl.nl>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from 7of9.schinagl.nl ([88.159.158.68]:35140 "EHLO 7of9.schinagl.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750766AbcHZHlt (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 26 Aug 2016 03:41:49 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>

Checkpatch warns about not using the BIT() macro. Replace 1 << bit with
BIT().

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
---
Hi Thierry,

I submitted this patch a year ago and you said you didn't much care for it.
After a year however, have you changed your mind? I notice it's becoming
mandatory in more and more subsystems. Checkpatch is unhappy about it and
isn't it likely to be mandatory throughout the entire kernel at some point?

If you still think it should be omitted however, feel free to /dev/null this
patch :)

Olliver

Changes since v1:
	- Rebased the patch

 include/linux/pwm.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index f1bbae0..a8b70ac 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -1,6 +1,7 @@
 #ifndef __LINUX_PWM_H
 #define __LINUX_PWM_H
 
+#include <linux/bitops.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
@@ -43,8 +44,8 @@ struct pwm_args {
 };
 
 enum {
-	PWMF_REQUESTED = 1 << 0,
-	PWMF_EXPORTED = 1 << 1,
+	PWMF_REQUESTED = BIT(0),
+	PWMF_EXPORTED = BIT(1),
 };
 
 /*
-- 
2.8.1
