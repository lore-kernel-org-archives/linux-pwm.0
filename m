From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv9 Resend 0/4] Add Freescale FTM PWM driver
Date: Wed, 19 Feb 2014 16:38:53 +0800
Message-ID: <1392799137-17188-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:13663 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751809AbaBSJn0 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Feb 2014 04:43:26 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>

Resend this patch series, just adding the missing and new Reviewed-by and
Acked-by infomation of this patch series.


Xiubo Li (4):
  pwm: Add Freescale FTM PWM driver support
  ARM: dts: vf610: Add Freescale FTM PWM node.
  ARM: dts: vf610-twr: Enables FTM PWM device.
  Documentation: Add device tree bindings for Freescale FTM PWM.

 .../devicetree/bindings/pwm/pwm-fsl-ftm.txt        |  34 ++
 arch/arm/boot/dts/vf610-twr.dts                    |   6 +
 arch/arm/boot/dts/vf610.dtsi                       |  13 +
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-fsl-ftm.c                          | 479 +++++++++++++++++++++
 6 files changed, 543 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
 create mode 100644 drivers/pwm/pwm-fsl-ftm.c

-- 
1.8.4


