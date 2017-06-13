From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] pwm: pwm-hibvt: constify hibvt_pwm_ops
Date: Tue, 13 Jun 2017 15:26:41 +0530
Message-ID: <fc61e98b728dd0e9179409c4369e5f4d1f5d7f08.1497346829.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32919 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752008AbdFMJ5L (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Jun 2017 05:57:11 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

File size before:
   text	   data	    bss	    dec	    hex	filename
   1510	    296	      0	   1806	    70e	drivers/pwm/pwm-hibvt.o
File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   1606	    192	      0	   1798	    706	drivers/pwm/pwm-hibvt.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/pwm/pwm-hibvt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
index d0e8f85..8dadc58 100644
--- a/drivers/pwm/pwm-hibvt.c
+++ b/drivers/pwm/pwm-hibvt.c
@@ -165,7 +165,7 @@ static int hibvt_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	return 0;
 }
 
-static struct pwm_ops hibvt_pwm_ops = {
+static const struct pwm_ops hibvt_pwm_ops = {
 	.get_state = hibvt_pwm_get_state,
 	.apply = hibvt_pwm_apply,
 
-- 
1.9.1
