From: Jason Yan <yanaijie@huawei.com>
Subject: [PATCH -next] pwm: make pwm_apply_state_debug static
Date: Thu, 2 Apr 2020 14:57:18 +0800
Message-ID: <20200402065718.32433-1-yanaijie@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:12602 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725789AbgDBG6x (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 2 Apr 2020 02:58:53 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E7AF694E56D5663EE587
        for <linux-pwm@vger.kernel.org>; Thu,  2 Apr 2020 14:58:48 +0800 (CST)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
Cc: Jason Yan <yanaijie@huawei.com>

Fix the following gcc warning:

drivers/pwm/core.c:467:6: warning: symbol 'pwm_apply_state_debug' was
not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/pwm/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index e9b9283cff28..9973c442b455 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -464,8 +464,8 @@ void pwm_free(struct pwm_device *pwm)
 }
 EXPORT_SYMBOL_GPL(pwm_free);
 
-void pwm_apply_state_debug(struct pwm_device *pwm,
-			   const struct pwm_state *state)
+static void pwm_apply_state_debug(struct pwm_device *pwm,
+				  const struct pwm_state *state)
 {
 	struct pwm_state *last = &pwm->last;
 	struct pwm_chip *chip = pwm->chip;
-- 
2.17.2
