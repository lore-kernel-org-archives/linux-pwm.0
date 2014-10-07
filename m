From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v10 0/2] pwm: add support for atmel-hlcdc-pwm device
Date: Tue,  7 Oct 2014 15:38:13 +0200
Message-ID: <1412689095-14259-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:34084 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753242AbaJGNiT (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Oct 2014 09:38:19 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org, Boris Brezillon <boris.brezillon@free-electrons.com>

Hi Thierry,

This patch series adds support for the atmel-hlcdc-pwm device provided
by the atmel-hlcdc MFD driver.

Best Regards,

Boris

Changes since v9:
 - replace select by depends on
 - rework commit messages
 - rework Kconfig description

Changes since v8:
 - rework the enable/disable waiting loop
 - check return code of regmap functions
 - fix DT binding doc

Changes since v7:
 - addressed several coding style issues


Boris Brezillon (2):
  pwm: add support for atmel-hlcdc-pwm device
  pwm: add DT bindings documentation for atmel-hlcdc-pwm driver

 .../devicetree/bindings/pwm/atmel-hlcdc-pwm.txt    |  29 +++
 drivers/pwm/Kconfig                                |  11 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-atmel-hlcdc.c                      | 259 +++++++++++++++++++++
 4 files changed, 300 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
 create mode 100644 drivers/pwm/pwm-atmel-hlcdc.c

-- 
1.9.1

