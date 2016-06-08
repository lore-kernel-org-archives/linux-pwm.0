From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] pwm: sysfs: get return value from pwm_apply_state()
Date: Wed, 8 Jun 2016 10:58:23 +0900
Message-ID: <1465351103-3152-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relmlor1.renesas.com ([210.160.252.171]:11626 "EHLO
	relmlie4.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753880AbcFHB6o (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Jun 2016 21:58:44 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: ryo.kodama.vz@renesas.com, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

From: Ryo Kodama <ryo.kodama.vz@renesas.com>

This patch adds to check the return value from pwm_apply_state()
used in enable_store(). The error of enable_store() doesn't work
if the return value doesn't received.

Signed-off-by: Ryo Kodama <ryo.kodama.vz@renesas.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pwm/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index d985992..01695d4 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -152,7 +152,7 @@ static ssize_t enable_store(struct device *child,
 		goto unlock;
 	}
 
-	pwm_apply_state(pwm, &state);
+	ret = pwm_apply_state(pwm, &state);
 
 unlock:
 	mutex_unlock(&export->lock);
-- 
1.9.1
