From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH v4 0/4] PWM: add and enable CSR SiRFSoC PWM driver
Date: Wed,  5 Mar 2014 17:58:25 +0800
Message-ID: <1394013506-6246-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:50977 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754609AbaCEJ6r (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Mar 2014 04:58:47 -0500
Received: by mail-pd0-f175.google.com with SMTP id x10so848660pdj.6
        for <linux-pwm@vger.kernel.org>; Wed, 05 Mar 2014 01:58:46 -0800 (PST)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, workgroup.linux@csr.com, Barry Song <Baohua.Song@csr.com>

From: Barry Song <Baohua.Song@csr.com>

Barry Song (3):
  pwm: sirf: add dt-binding document
  ARM: dts: sirf: fix the pwm-cells and clocks for pwm
  ARM: prima2_defconfig: enable PWM and sirf PWM driver

Huayi Li (1):
  pwm: add CSR SiRFSoC PWM driver

 Documentation/devicetree/bindings/pwm/pwm-sirf.txt |   23 ++
 arch/arm/boot/dts/atlas6.dtsi                      |    5 +-
 arch/arm/boot/dts/prima2.dtsi                      |    6 +-
 arch/arm/configs/prima2_defconfig                  |    2 +
 drivers/pwm/Kconfig                                |    9 +
 drivers/pwm/Makefile                               |    1 +
 drivers/pwm/pwm-sirf.c                             |  329 ++++++++++++++++++++
 7 files changed, 371 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sirf.txt
 create mode 100644 drivers/pwm/pwm-sirf.c

-- 
1.7.5.4

