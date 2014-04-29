From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv2 0/4] FTM PWM adds regmap and endianness support.
Date: Tue, 29 Apr 2014 11:33:45 +0800
Message-ID: <1398742429-10399-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-by2lp0242.outbound.protection.outlook.com ([207.46.163.242]:36524
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752917AbaD2ESU (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Tue, 29 Apr 2014 00:18:20 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>

Convert to direct regmap API usage. Since the regmap core has already
support rich endianness modes of device, this patch convert to direct
regmap API usage, preparing to support big endianness for LS1 SoC.

Using the regmag framework will be more easy to support the endiannesses
switching of one same device driver on different SoCs.

The endianness scenarios are:
SoC     |  CPU   | FTM-PWM | 'big-endian' property is needed?
--------|--------|---------|---------------------------------
Vybird  |  LE    |   LE    |     No
LS1     |  LE    |   BE    |     Yes
LS2     |  LE    |   LE    |     No



Changes in V2:
- Adds detail descriptions of these patches.


Xiubo Li (4):
  Documentation: Add 'big-endian' property for FTM PWM.
  pwm: ftm-pwm: Clean up the code.
  pwm: ftm-pwm: Convert to direct regmap API usage.
  pwm: ftm-pwm: Add big-endian support

 .../devicetree/bindings/pwm/pwm-fsl-ftm.txt        | 12 ++-
 drivers/pwm/pwm-fsl-ftm.c                          | 96 ++++++++++++----------
 2 files changed, 64 insertions(+), 44 deletions(-)

-- 
1.8.4

