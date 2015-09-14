From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v4 0/2] pwm: Broadcom BCM7038 PWM controller (v4)
Date: Mon, 14 Sep 2015 16:47:04 -0700
Message-ID: <1442274426-3507-1-git-send-email-f.fainelli@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36334 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbbINXuw (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Sep 2015 19:50:52 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, bcm-kernel-feedback-list@broadcom.com, thierry.reding@gmail.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, ariel@vanguardiasur.com.ar

Hi,

This patch series add PWM support for the Broadcom BCM7xxx
chips which feature one or more PWM controllers capable of
output periods from 148ns to ~622ms using a combination of
variable and fixed frequency settings.

The controller does not support setting a polarity.

This is based on Thierry's pwm/next branch.

Florian Fainelli (2):
  Documentation: dt: add Broadcom BCM7038 PWM controller binding
  pwm: Add Broadcom BCM7038 PWM controller support

 .../devicetree/bindings/pwm/brcm,bcm7038-pwm.txt   |  20 ++
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-brcmstb.c                          | 345 +++++++++++++++++++++
 4 files changed, 376 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.txt
 create mode 100644 drivers/pwm/pwm-brcmstb.c

-- 
2.1.0
