Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467782;
	b=2PfxrmmPERFYDkL1not26MjiRuLKVGRa3Z2sh1yBjTuG6D9Bf25rukOMcO2QPjVVVcuO
	 Etin5KelzYZYIQy2epCwI9tnXk6melURjBub1amoKpzQ0tqeQ+in7vXaxCgQGeH4+gQHI
	 vYJlhzpOebdZzBoMUiv6j8NKnA4AytFqgKnLQdYlzRvKZxoHdS2+6mw1tDZEewg404PwY
	 +Falmil4+8bPZzFdcvQOxaFsP9D9oEorR3XxmCISCFAYFdmCFw1M7BRWWCEGIBHc4sf/P
	 BBU3C/DlKGKXEQV8RMmYCEfe6ljfCgJjoUxnvaEA4g8/4cYUKRKM3ycKP/RoBDNV8ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467782;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ODFeblqJ2IvUuHopebwv4o1Sjw4sySz8nIqoDyGgRI4=;
	b=LpSwnW6u8h64oo13ChtQ1HFSWy/WOQOt26W+tTtPW4sPyt9kv+WN+M86oPC0HHl0h+lB
	 cuNl0hWk0MSMX9sU7k4m5MgOSveUYM2fx8j/kFe1R6wnn2Yzr+h7k5KkH6zCjB0x13P6p
	 njlJ0w4Ufc4D6EuBOVS/kt3gTQ06dd9WfCDASQfbU0mzwNK6WIduozRgeU478qIcbYSFT
	 MVJZE6x1zXZq+rBiKDZw2eZ5IFuqzURmkeItev5KhA+muNtQye1lNQXPJjQ/+Il8JThmx
	 lnxLP6FCm8qbbmaO2FeCHt+e85XlWsrelDx7dA4+CVmehEFvxT9RYUY9MU+T4x8D9zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=jZeEnbD7;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E77606A888;
	Thu, 12 Nov 2026 07:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59E77606A888
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=jZeEnbD7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=jZeEnbD75BNbBCYAWjbWJE8pRuh/gnzKyUqEqRgdZyOYhmx7qBH7sngA8W7eoSEpn+lOI4wJAqidB
	 sJnwyL1N+ykzKy1ba2GJtSaf2Xkuob3RS/WLBrmDmeTlOz6XYCeDpNHsQRbb+lSaJ4jzRUghZSEMrP
	 HLO8bkDWPh75I+m8=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66af567c0f62-abcab;
	Thu, 12 Nov 2026 15:16:17 +0800 (CST)
X-RM-TRANSID:2ee66af567c0f62-abcab
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66af567c0bef-f6ee0;
	Thu, 12 Nov 2026 15:16:17 +0800 (CST)
X-RM-TRANSID:2ee66af567c0bef-f6ee0
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: ukleinek@kernel.org
Cc: nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] pwm: atmel-tcb: Fix the channel restart write on resume
Date: Thu, 12 Nov 2026 15:16:15 +0800
Message-ID: <20261112071615.154385-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

atmel_tcb_pwm_resume() passes the start command as the register address
and the channel control register offset as the value. The command is
0x5, which is not an aligned register address, so regmap rejects the
write and an enabled PWM channel is not restarted after resume.

Pass the channel control register first and the clock-enable and
software-trigger bits second.

Fixes: 061f8572a31c ("pwm: atmel-tcb: Switch to new binding")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 drivers/pwm/pwm-atmel-tcb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index f74a42d75b81..e878eaaf81cc 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -541,8 +541,8 @@ static int atmel_tcb_pwm_resume(struct device *dev)
 
 	if (chan->enabled)
 		regmap_write(tcbpwmc->regmap,
-			     ATMEL_TC_CLKEN | ATMEL_TC_SWTRG,
-			     ATMEL_TC_REG(channel, CCR));
+			     ATMEL_TC_REG(channel, CCR),
+			     ATMEL_TC_CLKEN | ATMEL_TC_SWTRG);
 
 	return 0;
 }
-- 
2.51.0



