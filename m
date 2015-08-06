From: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
Subject: [PATCH v2 0/2] Add support for NXP LPC18xx PWM/SCT
Date: Wed,  5 Aug 2015 23:31:45 -0300
Message-ID: <1438828307-14641-1-git-send-email-ariel@vanguardiasur.com.ar>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:34751 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076AbbHFCb7 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Aug 2015 22:31:59 -0400
Received: by qkfc129 with SMTP id c129so22048029qkf.1
        for <linux-pwm@vger.kernel.org>; Wed, 05 Aug 2015 19:31:58 -0700 (PDT)
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

Changes since v1:
* Added "sct" in DT compatible string and driver's name.
* Allowed period changes when there's only one channel requested.

Ariel D'Alessandro (2):
  pwm: NXP LPC18xx PWM/SCT driver
  DT: pwm: Add NXP LPC18xx PWM/SCT binding documentation

 .../devicetree/bindings/pwm/lpc1850-sct-pwm.txt    |  20 +
 drivers/pwm/Kconfig                                |  12 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-lpc18xx-sct.c                      | 465 +++++++++++++++++++++
 4 files changed, 498 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/lpc1850-sct-pwm.txt
 create mode 100644 drivers/pwm/pwm-lpc18xx-sct.c

-- 
1.9.1
