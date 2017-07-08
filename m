From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 0/2] pwm: bcm2835: Support for polarity setting via DT
Date: Sat,  8 Jul 2017 12:13:56 +0200
Message-ID: <1499508838-20715-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:60123 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752758AbdGHKPE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 8 Jul 2017 06:15:04 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-rpi-kernel@lists.infradead.org, Eric Anholt <eric@anholt.net>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>

This patch series adds support for the third (optional) pwm cell to specify the
polarity.

Stefan Wahren (2):
  dt-bindings: pwm-bcm2835: Increase pwm-cells
  pwm: bcm2835: Support for polarity setting via DT

 Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt | 4 ++--
 drivers/pwm/pwm-bcm2835.c                             | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.7.4
