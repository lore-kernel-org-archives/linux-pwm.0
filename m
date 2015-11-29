From: Alban Bedel <albeu@free.fr>
Subject: [PATCH] pwm: Fix of_pwm_get() for consistent return values
Date: Sun, 29 Nov 2015 14:17:37 +0100
Message-ID: <1448803057-8572-1-git-send-email-albeu@free.fr>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:4654 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753046AbbK2NRz (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Sun, 29 Nov 2015 08:17:55 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: Alban Bedel <albeu@free.fr>, Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org

When of_pwm_get() is called without connection ID it returns
-ENOENT when the 'pwms' property doesn't exists or is an empty entry.
However when a connection ID is given and the 'pwm-names' property
doesn't exists or doesn't contains the requested name it returns
-ENODATA or -EINVAL.

To get a consistent return value with both code paths we must return
-ENOENT when of_property_match_string() fails.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 drivers/pwm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index d24ca5f..3b4dcb6 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -578,7 +578,7 @@ struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
 	if (con_id) {
 		index = of_property_match_string(np, "pwm-names", con_id);
 		if (index < 0)
-			return ERR_PTR(index);
+			return ERR_PTR(-ENOENT);
 	}
 
 	err = of_parse_phandle_with_args(np, "pwms", "#pwm-cells", index,
-- 
2.0.0
