From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv10 0/4] Add Freescale FTM PWM support
Date: Thu, 27 Feb 2014 17:39:48 +0800
Message-ID: <1393493992-26073-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:50787 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751058AbaB0Kpb (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Feb 2014 05:45:31 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>

Changed in V10:
  Fix some bugs and adjust the code from Thierry's comments.


Xiubo Li (4):
  pwm: Add Freescale FTM PWM driver support
  ARM: dts: vf610: Add Freescale FTM PWM node.
  ARM: dts: vf610-twr: Enables FTM PWM device.
  Documentation: Add device tree bindings for Freescale FTM PWM.

 .../devicetree/bindings/pwm/pwm-fsl-ftm.txt        |  35 ++
 arch/arm/boot/dts/vf610-twr.dts                    |   6 +
 arch/arm/boot/dts/vf610.dtsi                       |  13 +
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-fsl-ftm.c                          | 496 +++++++++++++++++++++
 6 files changed, 561 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
 create mode 100644 drivers/pwm/pwm-fsl-ftm.c

-- 
1.8.4


