From: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
Subject: [PATCH 0/2] Add support for NXP LPC18xx PWM/SCT
Date: Mon, 27 Jul 2015 01:45:43 -0300
Message-ID: <1437972345-16444-1-git-send-email-ariel@vanguardiasur.com.ar>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:35250 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbbG0EqU (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Jul 2015 00:46:20 -0400
Received: by qgii95 with SMTP id i95so44430359qgi.2
        for <linux-pwm@vger.kernel.org>; Sun, 26 Jul 2015 21:46:19 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, manabian@gmail.com, ezequiel@vanguardiasur.com.ar, thierry.reding@gmail.com, Ariel D'Alessandro <ariel@vanguardiasur.com.ar>

This patch series adds support for NXP LPC18xx PWM/SCT.

NXP LPC SoCs family, which includes LPC18xx/LPC43xx, provides a State
Configurable Timer (SCT) which can be configured as a Pulse Width Modulator.
Other SoCs in that family may share the same hardware.

Patchset is based on tag next-20150723 of the linux-next repository.
It has been successfully tested on a Hitex LPC4350 Evaluation Board.

Ariel D'Alessandro (2):
  pwm: NXP LPC18xx PWM/SCT driver
  DT: pwm: Add NXP LPC18xx PWM/SCT binding documentation

 .../devicetree/bindings/pwm/lpc1850-pwm.txt        |  20 +
 drivers/pwm/Kconfig                                |  12 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-lpc18xx.c                          | 453 +++++++++++++++++++++
 4 files changed, 486 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/lpc1850-pwm.txt
 create mode 100644 drivers/pwm/pwm-lpc18xx.c

-- 
1.9.1
