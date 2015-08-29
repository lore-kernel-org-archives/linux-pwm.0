From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v3 0/2] pwm: Broadcom BCM7038 PWM controller (v3)
Date: Fri, 28 Aug 2015 18:21:47 -0700
Message-ID: <1440811309-1289-1-git-send-email-f.fainelli@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:32787 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbbH2BY3 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Aug 2015 21:24:29 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com, thierry.reding@gmail.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>

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
 drivers/pwm/pwm-brcmstb.c                          | 324 +++++++++++++++++++++
 4 files changed, 355 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.txt
 create mode 100644 drivers/pwm/pwm-brcmstb.c

-- 
2.1.0
