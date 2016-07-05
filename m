From: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Subject: [PATCH v5 0/3] pwm support for Broadcom iProc SoC's
Date: Tue,  5 Jul 2016 02:00:23 -0400
Message-ID: <1467698426-27600-1-git-send-email-yendapally.reddy@broadcom.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33045 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbcGEGAu (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Jul 2016 02:00:50 -0400
Received: by mail-pf0-f173.google.com with SMTP id i123so66948867pfg.0
        for <linux-pwm@vger.kernel.org>; Mon, 04 Jul 2016 23:00:49 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Russell King <linux@arm.linux.org.uk>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>

This patchset contains the pwm support for the Broadcom's iProc SoC's.

The first patch provides the documentation details and the
second patch contains the controller support details. The third patch
contains the enable method for Northstar Plus SoC.

This patch series has been tested on NSP bcm958625HR board.
The pwm is not enabled for this board as the pins are open and not used.

This patch series is based on v4.7.0-rc1 and is available from github
repo: https://github.com/Broadcom/cygnus-linux.git
branch: iproc-pwm-v5

Changes since v4
Supported apply() callback instead of config()/set_polarity()
/enable()/disable()? as suggested by Brian

Changes since v3
Addressed comments from Scott to include COMPILE_TEST

Changes since v2
Rebased on v4.7.0-rc1

Changes since v1
Addressed the review comments from Thierry
 1. Use separate driver for iProc SoC's.
 2. Added Robs ack to the Documentation patch

Yendapally Reddy Dhananjaya Reddy (3):
  Documentation: dt: Add Broadcom iproc pwm controller binding
  pwm: iproc: Add support for Broadcom iproc pwm controller
  ARM: dts: NSP: Add PWM Support to DT

 .../devicetree/bindings/pwm/brcm,iproc-pwm.txt     |  21 ++
 arch/arm/boot/dts/bcm-nsp.dtsi                     |   8 +
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-bcm-iproc.c                        | 268 +++++++++++++++++++++
 5 files changed, 308 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.txt
 create mode 100644 drivers/pwm/pwm-bcm-iproc.c

-- 
2.1.0
