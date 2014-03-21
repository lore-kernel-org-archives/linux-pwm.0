From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 0/3] FTM PWM adds regmap and endianness support.
Date: Fri, 21 Mar 2014 12:53:07 +0800
Message-ID: <1395377590-23537-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from [65.55.88.15] ([65.55.88.15]:27686 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1759512AbaCUFjL (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 21 Mar 2014 01:39:11 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, linux-pwm@vger.kernel.org
Cc: broonie@kernel.org, swarren@nvidia.com, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>


Xiubo Li (3):
  pwm: ftm-pwm: Clean up the code.
  pwm: ftm-pwm: Convert to direct regmap API usage.
  pwm: ftm-pwm: Add big-endian support

 drivers/pwm/pwm-fsl-ftm.c | 96 ++++++++++++++++++++++++++---------------------
 1 file changed, 53 insertions(+), 43 deletions(-)

-- 
1.8.4


