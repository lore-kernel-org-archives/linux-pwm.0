From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] pwm: Fix compile error in pwm_get()
Date: Fri, 10 Feb 2017 12:44:30 +0100
Message-ID: <20170210114430.21512-1-hdegoede@redhat.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751555AbdBJLqE (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 10 Feb 2017 06:46:04 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org

commit bf71f4e8fb95 ("pwm: Try to load modules during pwm_get()") had
error checking added to the request_module call it adds, before merging
it. But the "err" variable the error checking uses was never declared,
this commit fixes this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Feel free to squash this into the original commit
---
 drivers/pwm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 50a33ca..4f3c0a1 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -831,7 +831,7 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
 	 * deferred probe mechanism.
 	 */
 	if (!chip && chosen->module) {
-		err = request_module(chosen->module);
+		int err = request_module(chosen->module);
 		if (err == 0)
 			chip = pwmchip_find_by_name(chosen->provider);
 	}
-- 
2.9.3
