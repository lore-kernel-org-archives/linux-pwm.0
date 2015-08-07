From: Olliver Schinagl <oliver+list@schinagl.nl>
Subject: [PATCH] pwm: core: cleanup pointer tests
Date: Fri,  7 Aug 2015 16:49:36 +0200
Message-ID: <1438958976-1821-1-git-send-email-oliver+list@schinagl.nl>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from 7of9.schinagl.nl ([88.159.158.68]:55209 "EHLO 7of9.schinagl.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753743AbbHGO6k (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Fri, 7 Aug 2015 10:58:40 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Olliver Schinagl <oliver@schinagl.nl>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

From: Olliver Schinagl <oliver@schinagl.nl>

pwm_set_polarity() checks if there's ops and polarity function pointers.
Most of these pointers are actually checked when a chip is added via
pwm_add, except for set_polarity.

This patch adds set_polarity to the list of functions to test on
pwmchip_add_with_polarity(); and removes these checks from
pwm_set_polarity.

The pwm should be valid, as it was checked during
pwmchip_add_with_polarity().

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
---
 drivers/pwm/core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 3a7769f..66fd5fd 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -239,7 +239,8 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 	int ret;
 
 	if (!chip || !chip->dev || !chip->ops || !chip->ops->config ||
-	    !chip->ops->enable || !chip->ops->disable || !chip->npwm)
+	    !chip->ops->set_polarity || !chip->ops->enable ||
+	    !chip->ops->disable || !chip->npwm)
 		return -EINVAL;
 
 	mutex_lock(&pwm_lock);
@@ -449,12 +450,9 @@ int pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity)
 {
 	int err;
 
-	if (!pwm || !pwm->chip->ops)
+	if (!pwm)
 		return -EINVAL;
 
-	if (!pwm->chip->ops->set_polarity)
-		return -ENOSYS;
-
 	if (test_bit(PWMF_ENABLED, &pwm->flags))
 		return -EBUSY;
 
-- 
2.1.4
