From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv4 0/3] ftm-pwm: Convert to direct regmap API usage
Date: Tue, 19 Aug 2014 12:38:00 +0800
Message-ID: <1408423083-19827-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-by2lp0240.outbound.protection.outlook.com ([207.46.163.240]:24169
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750774AbaHSEmb (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Tue, 19 Aug 2014 00:42:31 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, mark.rutland@arm.com, linux-pwm@vger.kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, rdunlap@infradead.org, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, Xiubo Li <Li.Xiubo@freescale.com>


This is depended on the following patches, which have already been merged
into linux-next tree:
https://lkml.org/lkml/2014/7/15/6
https://lkml.org/lkml/2014/7/15/5
https://lkml.org/lkml/2014/7/15/7


Changes in V4:
- Modified the 'static struct regmap_config fsl_pwm_regmap_config = {}'
  to 'static const struct regmap_config fsl_pwm_regmap_config = {}'
- Followed the Mark Rutland's advice.

Changes in V3:
- Use the regmap framework's endianness method instead of its own.

Changes in V2:
- Adds detail descriptions of these patches.


Xiubo Li (3):
  pwm: ftm-pwm: Clean up the code.
  pwm: ftm-pwm: Convert to direct regmap API usage.
  pwm: documentation: Add 'big-endian' property for FTM PWM.

 .../devicetree/bindings/pwm/pwm-fsl-ftm.txt        | 23 +++++-
 drivers/pwm/pwm-fsl-ftm.c                          | 90 +++++++++++-----------
 2 files changed, 69 insertions(+), 44 deletions(-)

-- 
1.8.5

