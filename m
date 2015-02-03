From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] pwm: Delete an unnecessary check before the function call
 "of_node_put"
Date: Tue, 03 Feb 2015 11:58:29 +0100
Message-ID: <54D0A9D5.6020603@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net> <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6> <530A086E.8010901@users.sourceforge.net> <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6> <530A72AA.3000601@users.sourceforge.net> <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6> <530B5FB6.6010207@users.sourceforge.net> <alpine.DEB.2.10.1402241710370.2074@hadrien> <530C5E18.1020800@users.sourceforge.net> <alpine.DEB.2.10.1402251014170.2080@hadrien> <530CD2C4.4050903@users.sourceforge.net> <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6> <5317A59D.4@users.so
 urceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:56274 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753451AbbBCK6g (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Tue, 3 Feb 2015 05:58:36 -0500
In-Reply-To: <5317A59D.4@users.sourceforge.net>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 3 Feb 2015 11:54:28 +0100

The of_node_put() function tests whether its argument is NULL and then
returns immediately. Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/pwm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 966497d..810aef3 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -192,7 +192,7 @@ static void of_pwmchip_add(struct pwm_chip *chip)
 
 static void of_pwmchip_remove(struct pwm_chip *chip)
 {
-	if (chip->dev && chip->dev->of_node)
+	if (chip->dev)
 		of_node_put(chip->dev->of_node);
 }
 
-- 
2.2.2

