From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v8 0/2] mfd: add atmel-hlcdc driver
Date: Mon,  6 Oct 2014 15:48:42 +0200
Message-ID: <1412603324-18789-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:55844 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752588AbaJFNst (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Oct 2014 09:48:49 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>

Hi Lee,

As proposed in my last atmel-hlcdc series I have split the series in order
to get the accepted parts merged.

This series is the one all others depend on.
Could you take it in your tree so that other maintainers can rely on the
fact this part will be merged before other parts.

Moreover, I know this is late, but can you include it in one of your 3.18
pull request as suggested by Thierry.
If you can't, can you provide Thierry and Dave with a stable branch
including this driver ?

Best Regards,

Boris

Boris Brezillon (2):
  mfd: add atmel-hlcdc driver
  mfd: add documentation for atmel-hlcdc DT bindings

 .../devicetree/bindings/mfd/atmel-hlcdc.txt        |  51 +++++++++
 drivers/mfd/Kconfig                                |   6 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/atmel-hlcdc.c                          | 122 +++++++++++++++++++++
 include/linux/mfd/atmel-hlcdc.h                    |  85 ++++++++++++++
 5 files changed, 265 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
 create mode 100644 drivers/mfd/atmel-hlcdc.c
 create mode 100644 include/linux/mfd/atmel-hlcdc.h

-- 
1.9.1

