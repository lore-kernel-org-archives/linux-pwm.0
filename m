From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv3 0/3] ftm-pwm: Convert to direct regmap API usage
Date: Mon, 18 Aug 2014 11:32:32 +0800
Message-ID: <1408332755-35102-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from [207.46.163.238] ([207.46.163.238]:20549 "EHLO
	na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751671AbaHRDiy (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Sun, 17 Aug 2014 23:38:54 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, linux-pwm@vger.kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, rdunlap@infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>


This is depended on the following patches, which has been applied by
Mark into his Regmap-Tree:
https://lkml.org/lkml/2014/7/15/6
https://lkml.org/lkml/2014/7/15/5
https://lkml.org/lkml/2014/7/15/7


Changes in V3:
- Use the regmap framework's endianness method instead of its own.

Changes in V2:
- Adds detail descriptions of these patches.
 





Xiubo Li (3):
  pwm: ftm-pwm: Clean up the code.
  pwm: ftm-pwm: Convert to direct regmap API usage.
  pwm: documentation: Add 'big-endian' property for FTM PWM.

 .../devicetree/bindings/pwm/pwm-fsl-ftm.txt        | 22 +++++-
 drivers/pwm/pwm-fsl-ftm.c                          | 90 +++++++++++-----------
 2 files changed, 68 insertions(+), 44 deletions(-)

-- 
1.8.5

