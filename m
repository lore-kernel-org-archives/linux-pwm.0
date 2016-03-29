From: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Subject: [PATCH RESEND 0/3] pwm support for Broadcom iProc SoC's
Date: Tue, 29 Mar 2016 10:22:27 -0400
Message-ID: <1459261350-23851-1-git-send-email-yendapally.reddy@broadcom.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:8009 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757079AbcC2OWk (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 29 Mar 2016 10:22:40 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>

This patchset contains the pwm support for the Broadcom's iProc SoC's.

The first patch provides the documentation details and the
second patch contains the controller support details. The third patch
contains the enable method for Northstar Plus SoC.

This patch series has been tested on NSP bcm958625HR board with oscilloscope.
The pwm is not enabled for this board as the pins are open and not used.

This patch series is based on v4.6.0-rc1 and is available from github
repo: https://github.com/Broadcom/cygnus-linux.git
branch: iproc-pwm-v1

This patch series was originally sent on 03/01/16.
See https://lkml.org/lkml/2016/3/1/487

Yendapally Reddy Dhananjaya Reddy (3):
  Documentation: dt: Add Broadcom iproc pwm controller binding
  pwm: kona: Add support for Broadcom iproc pwm controller
  ARM: dts: NSP: Add PWM Support to DT

 .../devicetree/bindings/pwm/brcm,kona-pwm.txt      |   2 +-
 arch/arm/boot/dts/bcm-nsp.dtsi                     |   8 +
 drivers/pwm/Kconfig                                |   6 +-
 drivers/pwm/pwm-bcm-kona.c                         | 183 ++++++++++++++++++---
 4 files changed, 172 insertions(+), 27 deletions(-)

-- 
2.1.0
