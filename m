From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v8 0/2] pwm: add support for atmel-hlcdc-pwm device
Date: Mon,  6 Oct 2014 16:07:01 +0200
Message-ID: <1412604423-19329-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:56112 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751319AbaJFOHI (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Oct 2014 10:07:08 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>

Hi Thierry,

This patch series adds support for the atmel-hlcdc-pwm device provided
by the atmel-hlcdc MFD driver.

It depends on this series [1] implementing the MFD driver.

Best Regards,

Boris

[1]http://www.mail-archive.com/devicetree@vger.kernel.org/msg44979.html

Changes since v7:
 - addressed several coding style issues

Boris Brezillon (2):
  pwm: add support for atmel-hlcdc-pwm device
  pwm: add DT bindings documentation for atmel-hlcdc-pwm driver

 .../devicetree/bindings/pwm/atmel-hlcdc-pwm.txt    |  50 +++++
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-atmel-hlcdc.c                      | 248 +++++++++++++++++++++
 4 files changed, 308 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
 create mode 100644 drivers/pwm/pwm-atmel-hlcdc.c

-- 
1.9.1

